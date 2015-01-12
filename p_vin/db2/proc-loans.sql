 /*
 some more routines to complement proc-part1.sql
 mfotang, Wed Oct  2 16:53:50 WAT 2013

 this file uses sqlstate class '91' (procedure), subclass '001'-'099' (loans), '100'-199 (interest), 500-599 (transactions)
*/
--#SET TERMINATOR @

-- total loan refunded between 2 dates
CREATE OR REPLACE FUNCTION totalLoanRepaid(IN inLoanId anchor loans.loanId,  IN inEndDate DATE DEFAULT CURRENT_DATE, IN inStartDate DATE DEFAULT '2000-01-01') RETURNS anchor transactions.amount READS SQL DATA NO EXTERNAL ACTION
BEGIN
	RETURN (SELECT NVL(SUM(t.amount), 0.0) 
			  FROM transactions t
			  JOIN loanRepayments r ON t.transacId=r.transacId AND r.loanId=inloanId AND t.transdate between date2Day(inStartDate) AND date2Day(inEndDate+1 DAY));
END@

-- outstanding loan amount as of a date
CREATE OR REPLACE FUNCTION loanAmount(IN inLoanId anchor loans.loanId, IN intheDate DATE DEFAULT CURRENT_DATE) RETURNS anchor transactions.amount READS SQL DATA NO EXTERNAL ACTION
BEGIN
	DECLARE v_amount anchor loans.amount;
	DECLARE v_date anchor loans.issueDate;
	SELECT issueDate, amount INTO v_date, v_amount FROM loans WHERE loanId=inLoanId;
	RETURN CASE WHEN date2Day(v_date)>date2Day(intheDate) THEN 0 ELSE v_amount - totalLoanRepaid(inLoanId, v_date,intheDate) END;
END@


CREATE OR REPLACE FUNCTION loanId2orgId(IN inLoanId anchor loans.loanId, IN strict int default 1) RETURNS anchor members.orgId DETERMINISTIC READS SQL DATA NO EXTERNAL ACTION
-- return orgId of account that took loan

BEGIN
	DECLARE v_orgId integer default NULL;
--	DECLARE rcount integer;

	SELECT m.orgId INTO v_orgId FROM loans l
	JOIN savings_accounts sa ON sa.accountId=l.accountId
	JOIN member_accounts ma ON ma.accountId=sa.accountId
	JOIN members m on m.memberId=ma.memberId
	WHERE l.loanId=inLoanId;
	IF v_orgId IS NULL AND strict=1 THEN
--	GET DIAGNOSTICS rcount = ROW_COUNT;
--	IF rcount= 0 THEN
		SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT='No such loan';
	END IF;
	RETURN v_orgId;
END@

-- total interest paid between 2 dates
CREATE OR REPLACE FUNCTION totalInterestPd(IN inLoanId anchor loans.loanId,  IN inEndDate DATE, IN inStartDate DATE DEFAULT '2000-01-01') RETURNS anchor transactions.amount READS SQL DATA NO EXTERNAL ACTION
BEGIN
	RETURN (SELECT NVL(SUM(t.amount), 0.0) 
			  FROM transactions t
			  JOIN interestPayments r ON t.transacId=r.transacId AND r.loanId=inloanId
			  		AND date2Day(t.transdate) between date2Day(inStartDate)
					AND date2Day(inEndDate+1 DAY));
END@

-- total interest paid 
CREATE OR REPLACE FUNCTION totalInterestPd(IN inLoanId anchor loans.loanId) RETURNS anchor transactions.amount READS SQL DATA NO EXTERNAL ACTION
BEGIN
	RETURN (SELECT NVL(SUM(t.amount), 0.0) 
			  FROM transactions t
			  JOIN interestPayments r ON t.transacId=r.transacId AND r.loanId=inloanId);
END@

CREATE OR REPLACE FUNCTION totalInterestFinesPd(IN inLoanId anchor loans.loanId) RETURNS anchor transactions.amount READS SQL DATA NO EXTERNAL ACTION
-- fines paid on late interest payment
BEGIN
	RETURN (SELECT NVL(SUM(t.amount), 0.0) 
			  FROM transactions t
			  JOIN interestFines r ON t.transacId=r.transacId AND r.loanId=inloanId);
END@



CALL SYSIBMADM.DBMS_OUTPUT.PUT_LINE('next: setInterestDueDate')@

CREATE OR REPLACE PROCEDURE setInterestDueDate(IN inLoanId anchor loans.loanId) SPECIFIC setInterestDueDate20 MODIFIES SQL DATA NO EXTERNAL ACTION
BEGIN
--
-- The logic of this procedure is based on the following assumption!!
-- ASSUMPTION: no loan repayment can be done if interest is being owed
--
	DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
	DECLARE v_transacDate anchor transactions.transDate;
	DECLARE v_lastTransacDate anchor transactions.transDate DEFAULT NULL; -- date of last transaction that was used to pay one cycle of interest

	DECLARE v_rate anchor interests.int_rate_id;
	DECLARE v_loanamnt anchor loans.amount default NULL;
	DECLARE v_int0 anchor transactions.amount;
	DECLARE v_int anchor transactions.amount;
	DECLARE v_sys anchor users.userId;
	DECLARE v_cycle anchor loans.int_cycle;
	DECLARE v_loanId anchor loans.loanId DEFAULT NULL;

--	declare x int default 0;

	DECLARE c CURSOR FOR
		SELECT DISTINCT date2Day(t.transDate) as transDay
		  FROM transactions t
		  JOIN interestPayments r ON t.transacId=r.transacId AND r.loanId=inloanId
		  	   ORDER BY transDay DESC;

CALL	DBMS_OUTPUT.PUT_LINE('in setInterestDueDate() for loan '|| inLoanId);

	SELECT l.loanId, l.amount, i.int_rate_id, i.int_cycle INTO  v_loanId, v_loanamnt, v_rate, v_cycle
	  FROM 	loans l
	  LEFT JOIN interests i ON l.loanId=i.loanId
	  WHERE	l.loanId=inLoanId;
	IF v_loanId IS NULL THEN
		SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT='No such loan';
		END IF;
	IF v_rate IS NULL THEN BEGIN
		CALL DEBUG('There is no interest on loan ' || inLoanId);
		RETURN;
		END;
	END IF;

	-- insterest as at date of issue:
	SET v_int0=interest(v_loanamnt, v_rate);
	IF v_int0=0 THEN RETURN; END IF; -- no interest on the loan
	-- total interest paid till date
	SET v_int=totalInterestPd(inLoanId);
	SET v_sys=username2id('system', loanId2orgId(inLoanId));
	-- reset date of next interest to be date of loan:
	UPDATE loans SET intNextDueDate=issueDate, modifiedBy=v_sys WHERE loanId=inloanId;
	OPEN c;
	FETCH FROM c INTO v_transacDate;
	W1: WHILE(SQLSTATE='00000') DO
		-- monthly interest as of v_transacDate:
		SET v_int0=interest(loanAmount(inLoanId, v_transacDate), v_rate);
		IF v_int0=0 OR   -- no interest due
			v_int0>v_int -- not enough left to pay for one iteration of interest
			THEN LEAVE W1;
		END IF;
		SET v_lastTransacDate=v_transacDate;
		W2: WHILE(FLOOR(v_int/v_int0)>0) DO
			UPDATE loans
			   SET intNextDueDate=intNextDueDate+v_cycle, modifiedBy=v_sys 
			 WHERE loanId=inloanId;
			SET v_int=v_int - v_int0;
		END WHILE;
		FETCH FROM c INTO v_transacDate;
	END WHILE;
	CLOSE c;
	UPDATE loans SET intLastPaidDate=v_lastTransacDate, carriedOver=v_int WHERE loanId=inloanId;
	BEGIN
		DECLARE CONTINUE HANDLER FOR NOT FOUND BEGIN END;
		DELETE FROM loan_status WHERE loanId=inLoanId AND cond='updIntDueDate';
	END;
END@

-- find the week corresponding to a date. since meeting days are not normal
-- days, but the week day om which meeting holds, the whole week is considered
-- one single day. this function returns a number that represents that one
-- single day.
CREATE OR REPLACE FUNCTION ngap(IN inDate DATE default CURRENT_DATE)  RETURNS INT DETERMINISTIC NO EXTERNAL ACTION
-- todo make this a function of the interest cycle!
BEGIN
	RETURN 100*YEAR(date2Day(inDate))+WEEK(inDate);
END@

CREATE OR REPLACE FUNCTION pendingInterest(IN inLoanId anchor loans.loanId) RETURNS anchor transactions.amount READS SQL DATA 
-- Calculate pending interest amount.
-- before calling this function, setInterestDueDate() must be called to fix interest due date.

BEGIN
	DECLARE v_dueDate anchor loans.intNextDueDate;
	DECLARE v_rate anchor loans.int_rate_id;
	DECLARE v_loanamnt anchor loans.amount;
	DECLARE v_int anchor transactions.amount DEFAULT 0.0;
	DECLARE v_lastDate anchor loans.intLastPaidDate;
	DECLARE v_carriedOver anchor loans.carriedOver;
	DECLARE v_cycle anchor loans.int_cycle;
	DECLARE v_theDay date;
	DECLARE v_thisDay date;
	DECLARE v_loanId anchor loans.loanId DEFAULT NULL;


CALL DBMS_OUTPUT.PUT_LINE('in pendingInterest() for loan '|| inLoanId);

	SELECT l.loanId, l.amount, i.int_rate_id, i.intNextDueDate, i.intLastPaidDate, i.carriedOver, i.int_cycle
			INTO  v_loanId, v_loanamnt, v_rate, v_dueDate, v_lastDate, v_carriedOver, v_cycle
	  FROM loans l
	  LEFT JOIN interests i ON l.loanId=i.loanID
	  WHERE l.loanId=inLoanId;

	  --  differentiate between loan ``not found'' and ``no interest required''
	IF v_loanId IS NULL THEN
		SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT='No such loan';
		END IF;
	IF v_rate IS NULL THEN
		RETURN 0.0;
		END IF;
	SET v_theDay=date2Day(v_dueDate);
	SET v_thisDay= date2Day(CURRENT_DATE);
	IF v_thisDay<v_theDay THEN
		SET v_int = 0.0;
	ELSEIF v_thisDay=v_theDay THEN
		SET v_int= interest(v_loanamnt, v_rate);
	ELSE BEGIN -- today > due date
		DECLARE v_amt0  anchor loans.amount;
		DECLARE v_int0 anchor transactions.amount;
		DECLARE v_a INT;

		-- loan amount as of last due date:
		SET v_amt0=v_loanamnt - totalLoanRepaid(inLoanId, v_dueDate);
		-- periodic interest as of last due date
		SET v_int0=interest(v_amt0, v_rate);
		-- calculate successive periods (v_cycle days per period) for which interest wasnt paid. assumption: loan could not have been repaid (partially or fully) while interest was owed; therefore, loan amount is the same as at last interest due date
		SET v_a=CEILING((DAYS(v_thisDay) - DAYS(v_theDay))/v_cycle);
		-- calculate interest for those missing period:
		IF v_a>0 THEN SET v_int=v_int0 * v_a; END IF; -- this should always be true, since v_thisDay>v_theDay
		IF v_lastDate IS NOT NULL AND day2date(v_lastDate)>=v_theDay THEN -- some interest has last been paid. deduct it from total
			SET v_int=v_int - totalInterestPd(inloanId, CURRENT DATE, v_lastDate) ;
		END IF;
		END;
	END IF;

	RETURN v_int - v_carriedOver;
END@

CREATE OR REPLACE FUNCTION interestDue(IN inLoanId anchor loans.loanId, IN inDate DATE DEFAULT CURRENT DATE) RETURNS anchor transactions.amount READS SQL DATA 
-- Calculate interest amount that was due as of specified date
-- before calling this function, setInterestDueDate() must be called to fix interest due date.
BEGIN
	DECLARE v_dueDate anchor loans.intNextDueDate;
	DECLARE v_rate anchor loans.int_rate_id;
	DECLARE v_loanamnt anchor loans.amount;
	DECLARE v_int anchor transactions.amount DEFAULT 0.0;
	DECLARE v_lastDate anchor loans.intLastPaidDate;
	DECLARE v_carriedOver anchor loans.carriedOver;
	DECLARE v_cycle anchor loans.int_cycle;
	DECLARE v_theDay date;
	DECLARE v_thisDay date;
	DECLARE v_loanId anchor loans.loanId DEFAULT NULL;


	CALL DEBUG('in interestDue for loan '|| inLoanId || ' as of '||inDate);

	SELECT l.loanId, l.amount, i.int_rate_id, i.intNextDueDate, i.intLastPaidDate, i.carriedOver, i.int_cycle
			INTO  v_loanId, v_loanamnt, v_rate, v_dueDate, v_lastDate, v_carriedOver, v_cycle
	  FROM loans l
	  LEFT JOIN interests i ON l.loanId=i.loanID
	  WHERE l.loanId=inLoanId;

	IF v_loanId IS NULL THEN
		SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT='No such loan';
		END IF;
	IF v_rate IS NULL THEN
		RETURN 0.0;
		END IF;
	
	SET v_dueDay=date2Day(v_dueDate);
	SET v_theDay= date2Day(inDate);
	IF v_theDay<v_dueDay THEN
		SET v_int = 0.0;
/*	ELSEIF v_theDay=v_dueDay THEN
		SET v_int= interest(v_loanamnt, v_rate);*/
	ELSE BEGIN --theday>=dueday
		DECLARE v_amt0  anchor loans.amount;
		DECLARE v_int0 anchor transactions.amount;
		DECLARE v_a INT;

		-- loan amount as of the last due date:
		SET v_amt0=v_loanamnt - totalLoanRepaid(inLoanId, v_dueDate);
		-- periodic interest as of last due date
		SET v_int0=interest(v_amt0, v_rate);
		-- calculate successive periods (v_cycle days per period) for which interest wasnt paid. assumption: loan could not have been repaid (partially or fully) while interest was owed; therefore, loan amount is the same as at last interest due date
		SET v_a=CEILING((DAYS(v_theDay) - DAYS(v_dueDay))/v_cycle);
		-- calculate interest for those missing period:
		IF v_a>0 THEN SET v_int=v_int0 * v_a; END IF;
		IF v_lastDate IS NOT NULL AND v_dueDay>=date2Day(v_lastDate) THEN -- some interest was paid vefore the day. deduct it from the total
			SET v_int=v_int - totalInterestPd(inloanId, inDate, v_lastDate) ;
		END IF;
		END;
	END IF;

	RETURN v_int;
END@


CREATE OR REPLACE FUNCTION pendingInterestFine(IN inLoanId anchor loans.loanId) RETURNS anchor transactions.amount READS SQL DATA 
-- Calculate pending fine on unpaid interest.

BEGIN
	DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
--	DECLARE v_dueDate anchor loans.intNextDueDate;
	DECLARE v_rate anchor loans.int_rate_id;
--	DECLARE v_loanamnt anchor loans.amount;
	DECLARE v_loanID anchor loans.loanId DEFAULT NULL;
	DECLARE v_int anchor transactions.amount DEFAULT 0.0;
/*	DECLARE v_lastDate anchor loans.intLastPaidDate;
	DECLARE v_carriedOver anchor loans.carriedOver;
	DECLARE v_cycle anchor loans.int_cycle;*/
	DECLARE v_theDay date;
--	DECLARE v_thisDay date;
	DECLARE v_amt anchor transactions.amount DEFAULT 0.0;
	DECLARE cur1 CURSOR WITH NO RETURN FOR
				SELECT DISTINCT date2day(t.transDate) as transDate FROM transactions t
				JOIN interestPayments r ON t.transacId=r.transacId AND r.loanId=inLoanId
					ORDER BY t.transDate ASC;

	DEBUG('in pendingInterestFine() for loan '|| inLoanId);
	SELECT l.loanId, i.penalty_rate_id
			INTO  v_loanId, v_rate
	  FROM loans l
	  LEFT JOIN interests i ON l.loanId=i.loanID
	  WHERE l.loanId=inLoanId;

	IF v_loanId IS NULL THEN
		SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT='No such loan';
		END IF;
	IF v_rate IS NULL THEN
		RETURN 0.0;
		END IF;

	OPEN cur1;
	FETCH transDate INTO v_theDay;
	IF SQLSTATE = '00000' THEN BEGIN
--	for each day interest was paid, calculate penalty
		WHILE(SQLSTATE='00000') DO
			SET v_int=interestDue(inLoanId, v_theDay);
			SET v_amnt=v_amnt+interest(v_int, v_rate); 
			CALL DEBUG('as of ' || v_theDay || ', unpaid interest: ' || v_int || '; total fine: '|| v_amount);
			FETCH transDate INTO v_theDay;
			END WHILE;
		SET v_amnt=v_amnt - totalInterestFinesPd(inLoanId);
		END;
	ELSE BEGIN -- no interest has ever been paid
		SET v_int=interestDue(inLoanId, CURRENT DATE);
		SET v_amnt=interest(v_int, v_rate);
		CALL DEBUG('as of today, unpaid interest: ' || v_int || '; total fine: '|| v_amount);
		END;
	END IF;
	RETURN v_amnt;
END@


--
-- loans
-- 
DEBUG('create LoanDetails_t')@
CREATE OR REPLACE TYPE LoanDetails_t AS ROW (loanID anchor loans.loanId
								,accountId anchor loans.accountId
								,amount anchor loans.amount
								,issueDate anchor loans.issueDate
								,interestRate anchor loans.int_rate_id
								,suretyAccId anchor loans.surety_accountId
								,timeRecorded anchor loans.timeRecorded
								,debtor VARCHAR(255)
								,memberId anchor member_accounts.memberId
								,amntRepaid anchor transactions.amount
								,balance anchor transactions.amount
								,interest anchor transactions.amount
								,interestPaid anchor transactions.amount
								,pendingInterest anchor transactions.amount
								,intNextDueDate anchor loans.intNextDueDate
								,sureteeAccName anchor savings_accounts.accountName
								,lp_typeId anchor LoanPurpose_types.lp_typeId
								,lp_desc anchor LoanPurpose_types.description
								,lp_catId anchor LoanPurpose_types.lp_catId
								,lpcat_desc anchor loanpurpose_categories.description
								,remark anchor loans.remark) @



CREATE OR REPLACE FUNCTION loanDetails(in_loanId anchor loans.loanId) RETURNS LoanDetails_t reads sql data
LANGUAGE SQL
-- details of one loan
-- Before calling this function, setInterestDueDate() must be called to fix interest due date.
-- setInterestDueDate() cannot be called from here because of SQLSTATE SQL0577N:   User defined routine "SETINTERESTDUEDATE" (specific name "SETINTERESTDUEDATE20") attempted to modify data but was not defined as MODIFIES SQL DATA.
-- For more info, see Table access restrictions in the db2 sql ref manual vol 2, section on CREATE FUNCTION.
begin
	DECLARE details LoanDetails_t default NULL;

	CALL DBMS_OUTPUT.PUT_LINE('in loanDetails for loan '|| in_loanId);

	SET details=(SELECT l.loanId,l.accountId,l.amount, l.issueDate, l.int_rate_id as interestRate,l.surety_accountId as suretyAcctId, l.timeRecorded, m.surname || ' '||m.othernames as debtor, ma.memberId, tmp.amntRepaid, CAST(l.amount-tmp.amntRepaid AS  DECIMAL(10,2)) as balance, interest(l.amount-tmp.amntRepaid, l.int_rate_id) as interest, tmp.interestPaid, tmp.pendingInterest, l.intNextDueDate, a.accountName as sureteeAccName, lp.lp_typeId, lp.description as lp_desc, lp.lp_catId, lpcat.description as lpcat_desc, l.remark
	  FROM loans l
	  JOIN table(select loanId, totalLoanRepaid(ll.loanId) as amntRepaid, totalInterestPd(ll.loanId) as interestPaid, pendingInterest(ll.loanId) as pendingInterest FROM loans ll WHERE ll.loanId=in_loanId) as tmp on l.loanId=in_loanId AND l.loanId=tmp.loanId

	  JOIN member_accounts ma ON ma.accountId=l.accountId
	  JOIN savings_accounts sa ON sa.accountId=ma.accountId
	  JOIN members m on m.memberId=ma.memberId
 LEFT JOIN LoanPurpose_types lp on lp.lp_typeId=l.lp_typeId
 LEFT JOIN loanpurpose_categories lpcat on lp.lp_catId=lpcat.lp_catId
 LEFT JOIN savings_accounts a ON a.accountId=l.surety_accountId);
	RETURN details;

end@
CALL	DBMS_OUTPUT.PUT_LINE('done.')@

CALL	DBMS_OUTPUT.PUT_LINE('next: getLoanDetails')@

CREATE OR REPLACE PROCEDURE getLoanDetails(IN in_userId anchor users.userId, in_loanId anchor loans.loanId) SPECIFIC getLoanDetailsForOne
 LANGUAGE SQL DYNAMIC RESULT SETS 1
-- details of one loan
begin
	DECLARE l LoanDetails_t default null;

	CALL DBMS_OUTPUT.PUT_LINE('in getLoanDetailsForOne for loan '|| in_loanId);

	IF EXISTS (SELECT * FROM loan_status WHERE loanId=in_LoanId AND cond='updIntDueDate' AND value='Y') THEN
		CALL setInterestDueDate(in_LoanId);
	END IF;

	SET l=loanDetails(in_loanId);

	call DBMS_OUTPUT.PUT_LINE('amount: '||l.amount|| '; int due date: '||l.intNextDueDate);
	IF l.loanId IS NULL THEN
		SIGNAL SQLSTATE '91099' SET MESSAGE_TEXT='No such loan or some error';
	ELSE
	BEGIN
		DECLARE c CURSOR WITH RETURN TO CLIENT FOR
			SELECT l.loanId as loanId
			, l.accountId as accountId, l.amount as amount, l.issueDate as issueDate, l.interestRate as interestRate,l.suretyAccId as suretyAccId, l.timeRecorded as timeRecorded, l.debtor as debtor, l.memberId as memberId, l.amntRepaid as amntRepaid, l.balance as balance, l.amntRepaid as amntRepaid, l.interest as interest, l.interestPaid as interestPaid, l.pendingInterest as pendingInterest, l.intNextDueDate as intNextDueDate, l.sureteeAccName as sureteeAccName, l.lp_typeId as lp_typeId, l.lp_desc as lp_desc, l.lp_catId as lp_catId, l.lpcat_desc as lpcat_desc, l.remark as remark
			  FROM SYSIBM.SYSDUMMY1;
			open c;
	END;
	END IF;
end@



CREATE OR REPLACE PROCEDURE getLoansDetails(IN in_userId anchor users.userId, in_startDate DATE DEFAULT '2000-01-01', in_endDate DATE DEFAULT current_date) SPECIFIC getLoanDetailsForAll
LANGUAGE SQL DYNAMIC RESULT SETS 1 MODIFIES SQL DATA
-- details of all loans
begin
	DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
	DECLARE v_loanId anchor loans.loanId;
	DECLARE c CURSOR WITHOUT RETURN FOR
		SELECT loanId from Loans WHERE issueDate BETWEEN date2day(in_startDate) AND date2day(in_endDate+1);

	DELETE FROM temp_loan_details;
	OPEN c;
	FETCH FROM c INTO v_loanId;
	W1: WHILE(SQLSTATE='00000') DO BEGIN
		DECLARE l LoanDetails_t;

		IF EXISTS (SELECT * FROM loan_status WHERE loanId=v_LoanId AND
			cond='updIntDueDate' AND value='Y') THEN
				CALL setInterestDueDate(v_LoanId);
		END IF;

		SET l=loanDetails(v_loanId);
		CALL	DBMS_OUTPUT.PUT_LINE('in loop for loan '|| v_loanId);

		INSERT INTO temp_loan_details SELECT l.loanId as loanId,
		l.accountId as accountId,
		l.amount as amount,
		l.issueDate as issueDate,
		l.interestRate as interestRate,
		l.suretyAccId as suretyAccId,
		l.timeRecorded as timeRecorded,
		l.debtor as debtor,
		l.memberId as memberId,
		l.amntRepaid as amntRepaid,
		l.balance as balance, 
		l.interest as interest,
		l.interestPaid as interestPaid, 
		l.pendingInterest as pendingInterest,
		l.intNextDueDate as intNextDueDate,
		l.sureteeAccName as sureteeAccName,
		l.lp_typeId as lp_typeId,
		l.lp_desc as lp_desc, 
		l.lp_catId as lp_catId,
		l.lpcat_desc as lpcat_desc,
		l.remark as remark FROM SYSIBM.SYSDUMMY1;
		FETCH FROM c INTO v_loanId;
		END;
	END WHILE;
	CLOSE c;
	BEGIN
		DECLARE cur CURSOR WITH RETURN TO CLIENT FOR SELECT * FROM temp_loan_details;
		OPEN cur;
	END;
end@

CREATE OR REPLACE PROCEDURE getLoansToAccount(IN in_userId anchor users.userId,in_accountId anchor loans.accountId,
		  in_startDate DATE DEFAULT '2000-01-01',
		  in_endDate DATE DEFAULT current_date)
LANGUAGE SQL DYNAMIC RESULT SETS 1  MODIFIES SQL DATA 
-- all loans granted to an account
begin
	DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
	DECLARE v_loanId anchor loans.loanId;
	DECLARE c CURSOR WITHOUT RETURN FOR
		SELECT loanId from Loans WHERE accountId=in_accountId AND issueDate BETWEEN date2day(in_startDate) AND date2day(in_endDate+1);

	DELETE FROM temp_loan_details;
	OPEN c;
	FETCH FROM c INTO v_loanId;
	W1: WHILE(SQLSTATE='00000') DO BEGIN
		DECLARE l LoanDetails_t;

		IF EXISTS (SELECT * FROM loan_status WHERE loanId=v_LoanId AND
			cond='updIntDueDate' AND value='Y') THEN
				CALL setInterestDueDate(v_LoanId);
		END IF;

		SET l=loanDetails(v_loanId);
		CALL	DBMS_OUTPUT.PUT_LINE('in loop for loan '|| v_loanId);

		INSERT INTO temp_loan_details SELECT l.loanId as loanId,
		l.accountId as accountId,
		l.amount as amount,
		l.issueDate as issueDate,
		l.interestRate as interestRate,
		l.suretyAccId as suretyAccId,
		l.timeRecorded as timeRecorded,
		l.debtor as debtor,
		l.memberId as memberId,
		l.amntRepaid as amntRepaid,
		l.balance as balance, 
		l.interest as interest,
		l.interestPaid as interestPaid, 
		l.pendingInterest as pendingInterest,
		l.intNextDueDate as intNextDueDate,
		l.sureteeAccName as sureteeAccName,
		l.lp_typeId as lp_typeId,
		l.lp_desc as lp_desc, 
		l.lp_catId as lp_catId,
		l.lpcat_desc as lpcat_desc,
		l.remark as remark FROM SYSIBM.SYSDUMMY1;
		FETCH FROM c INTO v_loanId;
		END;
	END WHILE;
	CLOSE c;
	BEGIN
		DECLARE cur CURSOR WITH RETURN TO CLIENT FOR SELECT * FROM temp_loan_details;
		OPEN cur;
	END;
end@

CREATE OR REPLACE PROCEDURE getLoansToMember(IN in_userId anchor users.userId,in_memberId anchor members.memberId,
		  in_startDate DATE DEFAULT '2000-01-01',
		  in_endDate DATE DEFAULT current_date)
LANGUAGE SQL DYNAMIC RESULT SETS 1 MODIFIES SQL DATA 
-- all loans granted to a member
begin
	DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
	DECLARE v_loanId anchor loans.loanId;
	DECLARE c CURSOR WITHOUT RETURN FOR
		SELECT ll.loanId from Loans ll
		JOIN member_accounts mac ON mac.accountId=ll.accountId AND mac.memberId=in_memberId
		WHERE ll.issueDate BETWEEN date2day(in_startDate) AND date2day(in_endDate+1);

	DELETE FROM temp_loan_details;
	OPEN c;
	FETCH FROM c INTO v_loanId;
	W1: WHILE(SQLSTATE='00000') DO BEGIN
		DECLARE l LoanDetails_t;

		IF EXISTS (SELECT * FROM loan_status WHERE loanId=v_LoanId AND
			cond='updIntDueDate' AND value='Y') THEN
				CALL setInterestDueDate(v_LoanId);
		END IF;

		SET l=loanDetails(v_loanId);
		CALL	DBMS_OUTPUT.PUT_LINE('in loop for loan '|| v_loanId);

		INSERT INTO temp_loan_details SELECT l.loanId as loanId,
		l.accountId as accountId,
		l.amount as amount,
		l.issueDate as issueDate,
		l.interestRate as interestRate,
		l.suretyAccId as suretyAccId,
		l.timeRecorded as timeRecorded,
		l.debtor as debtor,
		l.memberId as memberId,
		l.amntRepaid as amntRepaid,
		l.balance as balance, 
		l.interest as interest,
		l.interestPaid as interestPaid, 
		l.pendingInterest as pendingInterest,
		l.intNextDueDate as intNextDueDate,
		l.sureteeAccName as sureteeAccName,
		l.lp_typeId as lp_typeId,
		l.lp_desc as lp_desc, 
		l.lp_catId as lp_catId,
		l.lpcat_desc as lpcat_desc,
		l.remark as remark FROM SYSIBM.SYSDUMMY1;
		FETCH FROM c INTO v_loanId;
		END;
	END WHILE;
	CLOSE c;
	BEGIN
		DECLARE cur CURSOR WITH RETURN TO CLIENT FOR SELECT * FROM temp_loan_details;
		OPEN cur;
	END;

end@


DEBUG('recordInterestPayment')@
--
-- Loan repayments, interest payments
-- creating a transaction and recording its purpose, must be done
-- as an atomic operation from the front-end. Therefore, it is assumed
-- herein that userId is same as the same one that created the transaction.
-- 
-- Note:
-- updates are not explicitly handled. Instead, the corresponding 
-- transactions should be updated using modifyTransaction().
--
--
-- payment of interest
--

--0. low-level routine
CREATE OR REPLACE PROCEDURE recordInterestPayment(IN in_loanId anchor interestPayments.loanId, IN in_transacId anchor interestPayments.transacId, IN in_remark anchor interestPayments.remark, IN in_userId anchor users.userId) SPECIFIC interestPayment0
BEGIN
		call log_activity('interest', 'new', in_userId, 'trans Id: '|| in_transacId ||'; loan id: '||in_loanId || '; remark: '|| in_remark);
		CALL checkLoginStatus(in_UserId, 'recordInterestPayment');
		CALL checkPermission(in_userId,  'recordInterestPayment', 'INTEREST');

		INSERT INTO interestPayments(loanId, transacId, remark, modifiedBy)	VALUES (in_loanId, in_transacId, in_remark, in_userId);
		CALL setInterestDueDate(in_loanId);
END@

CREATE OR REPLACE PROCEDURE sys_recordInterestPayment(IN in_loanId anchor interestPayments.loanId, IN in_transacId anchor interestPayments.transacId, IN in_remark anchor interestPayments.remark, IN in_userId anchor users.userId) SPECIFIC interestPaymentBySystem
-- called internally to force interest payment
BEGIN
		call log_activity('interest', 'new', in_userId, 'trans Id: '|| in_transacId ||'; loan id: '||in_loanId || '; remark: '|| in_remark);
		CALL checkLoginStatus(in_UserId, 'recordInterestPayment',1);
		CALL checkPermission(in_userId,  'recordInterestPayment', 'INTEREST',1);

		INSERT INTO interestPayments(loanId, transacId, remark, modifiedBy)	VALUES (in_loanId, in_transacId, in_remark, in_userId);
		CALL setInterestDueDate(in_loanId);
END@

-- 1. interest payment by cash
CREATE OR REPLACE PROCEDURE recordInterestPayment(IN in_loanId anchor interestPayments.loanId,
		IN in_amount anchor transactions.amount,
		IN in_transDate anchor transactions.transDate,
		IN in_remark anchor loanRepayments.remark,
		IN in_payer anchor cashTransactions.payer,
		IN in_userId anchor users.userId) SPECIFIC interestPaymentByCash
BEGIN
	DECLARE v_transacId anchor transactions.transacId;
	DECLARE v_sysusr anchor users.userId;

	SET v_sysusr=username2id('system', loanId2orgId(in_loanId));
	BEGIN ATOMIC
	CALL createTransaction(in_amount, in_transDate, 'cash', in_remark, v_transacId, v_sysusr);
	CALL recordCashTransaction(v_transacId, in_payer);
	CALL recordInterestPayment(in_loanId, v_transacId, in_remark, in_userId);
	END;
END@
-- 2. interest payment using bank payment
CREATE OR REPLACE PROCEDURE recordInterestPayment(IN in_loanId anchor interestPayments.loanId,
		IN in_amount anchor transactions.amount,
		IN in_transDate anchor transactions.transDate,
		IN in_remark anchor transactions.remark,
		IN in_payer anchor bankTransactions.payer,
		IN in_tellerNo anchor bankTransactions.tellerNo,
		IN in_userId anchor users.userId) SPECIFIC interestPaymentByBank
BEGIN
	DECLARE v_transacId anchor transactions.transacId;
	DECLARE v_sysusr anchor users.userId;

	SET v_sysusr=username2id('system', loanId2orgId(in_loanId));
	BEGIN ATOMIC
	CALL createTransaction(in_amount, in_transDate, 'bank', in_remark, v_transacId, v_sysusr);
	CALL recordBankTransaction(v_transacId, in_payer, in_tellerNo);
	CALL recordInterestPayment(in_loanId, v_transacId, in_remark, in_userId);
	END;
END@
-- 3. interest payment by tranferring funds from another account
CREATE OR REPLACE PROCEDURE recordInterestPayment(IN in_loanId anchor interestPayments.loanId,
		IN in_amount anchor transactions.amount,
		IN in_transDate anchor transactions.transDate,
		IN in_remark anchor transactions.remark,
		IN in_debitAcctNo anchor deposits.accountId,
		IN in_authorizedBy anchor debits.authorizedBy,
		IN in_debitremark anchor debits.remark,
		IN in_userId anchor users.userId) SPECIFIC interestPaymentByDebit
BEGIN
	DECLARE v_debitId anchor debits.debitId;
	DECLARE v_payee anchor savings_accounts.accountName DEFAULT NULL;
	DECLARE v_amount anchor debits.amount default 0.0;

	-- find out who took loan
	SELECT a.accountName INTO v_payee
	  FROM Loans l
	  JOIN savings_accounts a ON a.accountId=l.accountId AND l.loanId=in_loanId;
	IF v_payee IS NULL THEN
		SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT='no such loan';
	END IF;
	CALL debitAccount(in_debitAcctNo, v_payee, in_amount, CURRENT_DATE, in_authorizedBy, in_debitremark, v_debitId, in_userId);
	SELECT amount INTO v_amount FROM debits WHERE debitId=v_debitId;
	IF v_amount>0.0 THEN BEGIN ATOMIC
		DECLARE v_sysusr anchor users.userId;
		DECLARE v_transacId anchor transactions.transacId;
		
		SET v_sysusr=username2id('system', loanId2orgId(in_loanId));
		CALL createTransaction(v_amount, in_transDate, 'acct', in_remark, v_transacId, v_sysusr);
		CALL recordInterAcctTransaction(v_transacId, v_debitId);
		CALL recordInterestPayment(in_loanId, v_transacId, in_remark, in_userId);
		END;
	END IF;
END@


-- reverse interest payment

CREATE OR REPLACE PROCEDURE undoInterestPayment(in_transacId anchor interestPayments.transacId, IN in_reason VARCHAR(512), IN in_userId anchor users.userId)
BEGIN
	DECLARE v_loanId anchor interestPayments.loanId;
	DECLARE v_errtxt VARCHAR(128);
	DECLARE EXIT HANDLER FOR SQLSTATE '91501' BEGIN
		SET v_errtxt= 'No such interest repayment (transaction ' || in_transacId || ')';
		SIGNAL SQLSTATE '91102' SET MESSAGE_TEXT=v_errtxt;
		END;
	SELECT loanId INTO v_loanId	FROM interestPayments WHERE transacId=in_transacId;
	call log_activity('InterestRepayment','reverse',in_userId,' TransacId: '|| in_transacId ||'; loanId: '||v_loanId || '; Reason: ' || in_reason);
	CALL checkLoginStatus(in_UserId, 'undoInterestPayment');
	CALL checkPermission(in_userId,  'undoInterestPayment', 'DELINTEREST');
	CALL undoTransaction(in_transacId, in_reason, username2id('system', loanId2orgId(v_loanId)));
END@	

CREATE OR REPLACE PROCEDURE getInterestPayments4Loan(IN in_userId anchor users.userId, IN inLoanId anchor loans.loanId, IN inStartDate DATE default '1900-1-1', IN inEndDate DATE default CURRENT_DATE) SPECIFIC getInterestPayments4Loan
DYNAMIC RESULT SETS 1 LANGUAGE SQL
BEGIN
	DECLARE c CURSOR WITH RETURN TO CLIENT FOR
		SELECT r.loanId, t.transacId, t.transdate, t.amount, t.payment_method_id, userid2name(t.createdBy) as createdBy, t.timeRecorded, t.remark
		  FROM transactions t
		  JOIN interestPayments r ON t.transacId=r.transacId AND r.loanId=inloanId
		  		AND date2Day(t.transdate) between date2Day(inStartDate) AND date2Day(inEndDate)
		      ORDER BY  t.transdate DESC, t.timeRecorded DESC;
	OPEN c;
END@

CREATE OR REPLACE PROCEDURE getInterestPayments(IN in_userId anchor users.userId, IN inStartDate DATE default '1900-1-1', IN inEndDate DATE default CURRENT_DATE) SPECIFIC getInterestPayments4AllLoans
DYNAMIC RESULT SETS 1 LANGUAGE SQL
BEGIN
	DECLARE c CURSOR WITH RETURN TO CLIENT FOR
		SELECT r.loanId, t.transacId, t.transdate, t.amount, t.payment_method_id, userid2name(t.createdBy) as createdBy, t.timeRecorded, t.remark
		  FROM transactions t
		  JOIN interestPayments r ON t.transacId=r.transacId AND date2Day(t.transdate) between date2Day(inStartDate) AND date2Day(inEndDate)
		  ORDER BY r.loanId, t.transdate DESC, t.timeRecorded DESC;
	OPEN c;
END@


-- loan repayment
-- 0. low-level routine:
CREATE OR REPLACE PROCEDURE recordLoanRepayment(IN in_loanId anchor loanRepayments.loanId, IN in_transacId anchor loanRepayments.transacId, IN in_remark anchor loanRepayments.remark, OUT out_actualAmount anchor transactions.amount, IN in_userId anchor users.userId) SPECIFIC recordLoanRepayment0
-- OUT out_actualAmount is the amount actually used for loan repayment. it might be less than the transaction amount, if part of the money is used for something else, e.g. repayin loan
BEGIN
	DECLARE v_errtxt VARCHAR(128);
	DECLARE v_a anchor transactions.amount DEFAULT NULL;
	DECLARE v_int anchor transactions.amount DEFAULT 0.0;
	DECLARE EXIT HANDLER FOR SQLSTATE '92106' BEGIN
		SET v_errtxt='Pay pending interest first. Interest is atleast '|| pendingInterest(in_loanId);
		RESIGNAL SET MESSAGE_TEXT=v_errtxt;
	END;

	call log_activity('loan repay', 'new', in_userId, 'trans Id: '|| in_transacId ||'; loan id: '||in_loanId);
	CALL checkLoginStatus(in_UserId, 'recordLoanRepayment');
	CALL checkPermission(in_userId,  'recordLoanRepayment', 'LOANREPAY');
	SELECT amount INTO v_a FROM transactions WHERE transacId=in_transacId;
	IF v_a is null THEN SIGNAL SQLSTATE '91501' SET MESSAGE_TEXT='transaction not found'; END IF;
	SET v_int=pendingInterest(in_loanId);
	IF v_int>0 THEN BEGIN ATOMIC
	-- create another transaction
		DECLARE v_transacId anchor transactions.transacId;
		DECLARE v_b anchor transactions.amount;
		DECLARE v_sysusr anchor users.userId;

		SET v_sysusr=username2id('system', loanId2orgId(in_loanId));
		-- amnt to use for interest
		SET v_b=CASE WHEN v_int>v_a THEN v_a ELSE v_int END;
		CALL createTransaction(v_b, CURRENT DATE, 'tran', 'deduction for interest payment', v_transacId, v_sysusr);
		CALL sys_recordInterestPayment(in_loanId, v_transacId, 'mandatory payment', v_sysusr);
		SET v_a=v_a - v_b;
		IF v_a>0 THEN BEGIN
			CALL createTransaction(v_a, CURRENT DATE, 'tran', 'left over for loan repayment', v_transacId, v_sysusr);
			INSERT INTO loanRepayments (loanId,transacId, remark, modifiedBy) VALUES (in_loanId,v_transacId, in_remark, in_userId);
			END;
		END IF;
		END;
	ELSE
		INSERT INTO loanRepayments (loanId,transacId, remark, modifiedBy) VALUES (in_loanId,in_transacId, in_remark, in_userId);
	END IF;
	SET out_actualAmount=v_a;
END@
-- 1. loan refund by cash
CREATE OR REPLACE PROCEDURE recordLoanRepayment(IN in_loanId anchor loanRepayments.loanId,
		IN in_amount anchor transactions.amount,
		IN in_transDate anchor transactions.transDate,
		IN in_remark anchor loanRepayments.remark,
		IN in_payer anchor cashTransactions.payer,
		OUT out_amount anchor transactions.amount,
		IN in_userId anchor users.userId) SPECIFIC recordLoanRepaymentByCash
BEGIN
	DECLARE v_transacId anchor transactions.transacId;
	DECLARE v_sysusr anchor users.userId;

	SET v_sysusr=username2id('system', loanId2orgId(in_loanId));
	BEGIN ATOMIC
	CALL createTransaction(in_amount, in_transDate, 'cash', in_remark, v_transacId, v_sysusr);
	CALL recordCashTransaction(v_transacId, in_payer);
	CALL recordLoanRepayment(in_loanId, v_transacId, in_remark, out_amount, in_userId);
	END;
END@
-- 2. loan refund using bank payment
CREATE OR REPLACE PROCEDURE recordLoanRepayment(IN in_loanId anchor loanRepayments.loanId,
		IN in_amount anchor transactions.amount,
		IN in_transDate anchor transactions.transDate,
		IN in_remark anchor transactions.remark,
		IN in_payer anchor bankTransactions.payer,
		IN in_tellerNo anchor bankTransactions.tellerNo,
		OUT out_amount anchor transactions.amount,
		IN in_userId anchor users.userId) SPECIFIC recordLoanRepaymentByBank
BEGIN
	DECLARE v_transacId anchor transactions.transacId;
	DECLARE v_sysusr anchor users.userId;

	SET v_sysusr=username2id('system', loanId2orgId(in_loanId));
	BEGIN ATOMIC
	CALL createTransaction(in_amount, in_transDate, 'bank', in_remark, v_transacId, v_sysusr);
	CALL recordBankTransaction(v_transacId, in_payer, in_tellerNo);
	CALL recordLoanRepayment(in_loanId, v_transacId, in_remark, out_amount, in_userId);
	END;
END@
-- 3. loan refund by tranferring funds from another account
CREATE OR REPLACE PROCEDURE recordLoanRepayment(IN in_loanId anchor loanRepayments.loanId,
		IN in_amount anchor transactions.amount,
		IN in_transDate anchor transactions.transDate,
		IN in_remark anchor transactions.remark,
		IN in_debitAcctNo anchor deposits.accountId,
		IN in_authorizedBy anchor debits.authorizedBy,
		IN in_debitremark anchor debits.remark,
		OUT out_amount anchor transactions.amount,
		IN in_userId anchor users.userId) SPECIFIC recordLoanRepaymentByDebit
BEGIN
	DECLARE v_debitId anchor debits.debitId;
	DECLARE v_payee anchor savings_accounts.accountName DEFAULT NULL;
	DECLARE v_amount anchor debits.amount default 0.0;

	-- find out who took loan
	SELECT a.accountName INTO v_payee
	  FROM Loans l
	  JOIN savings_accounts a ON a.accountId=l.accountId AND l.loanId=in_loanId;
	IF v_payee IS NULL THEN
		SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT='no such loan';
	END IF;
	CALL debitAccount(in_debitAcctNo, v_payee, in_amount, CURRENT_DATE, in_authorizedBy, in_debitremark, v_debitId, in_userId);
	SELECT amount INTO v_amount FROM debits WHERE debitId=v_debitId;
	IF v_amount>0.0 THEN BEGIN ATOMIC
		DECLARE v_transacId anchor transactions.transacId;
		DECLARE v_sysusr anchor users.userId;

		SET v_sysusr=username2id('system', loanId2orgId(in_loanId));
		
		CALL createTransaction(v_amount, in_transDate, 'acct', in_remark, v_transacId, v_sysusr);
		CALL recordInterAcctTransaction(v_transacId, v_debitId);
		CALL recordLoanRepayment(in_loanId, v_transacId, in_remark, out_amount, in_userId);
		END;
	END IF;

END@

values('3')@
--
-- reverse loan repayment
-- 
CREATE OR REPLACE PROCEDURE undoLoanRepayment(IN in_transacId anchor loanRepayments.transacId,
IN in_reason VARCHAR(512), IN in_userId anchor users.userId)
BEGIN
	DECLARE v_loanId anchor loanRepayments.loanId;
	DECLARE EXIT HANDLER FOR SQLSTATE '91501' BEGIN
		DECLARE v_errtxt VARCHAR(128);
		SET v_errtxt= 'No such loan repayment (transaction ' || in_transacId || ')';
		RESIGNAL SET MESSAGE_TEXT=v_errtxt;
		END;
	SELECT loanId INTO v_loanId  
	FROM loanRepayments
	WHERE transacId=in_transacId;
	call log_activity('LoanRepayment','reverse',in_userId,'loan id: '||v_loanId ||'; transacId: '|| in_transacId || '; Reason: ' || in_reason);
	CALL checkLoginStatus(in_UserId, 'undoLoanRepayment');
	CALL checkPermission(in_userId,  'undoLoanRepayment', 'DELLOANREPAY');
	CALL undoTransaction(in_transacId, in_reason, username2id('system', loanId2orgId(v_loanId)));
END@

values('getInterestPaid')@
CREATE OR REPLACE PROCEDURE getInterestPaid(in_startDate DATE DEFAULT '2000-01-01',
		  in_endDate DATE DEFAULT current_date)
	LANGUAGE SQL DYNAMIC RESULT SETS 1
begin
		DECLARE C1 CURSOR WITH RETURN TO CLIENT FOR
			SELECT ip.loanId, m.surname || ' '||m.othernames as debtor, ip.transacId, t.amount, t.transDate, t.timeRecorded FROM interestPayments ip
			JOIN Transactions t ON ip.transacId = t.transacId
			JOIN loans l ON l.loanId=ip.loanId
			JOIN member_accounts ma ON ma.accountId=l.accountId
			JOIN members m ON m.memberId=ma.memberId
			WHERE t.transdate BETWEEN date2day(in_startDate) AND date2day(in_endDate+1)
			ORDER BY t.transDate DESC;
		OPEN C1;
end@

CREATE OR REPLACE PROCEDURE getInterestPaidByLaon(in_loanId anchor interestPayments.loanId,
		  in_startDate DATE DEFAULT '2000-01-01',
		  in_endDate DATE DEFAULT current_date)
	LANGUAGE SQL DYNAMIC RESULT SETS 1
begin
		DECLARE C1 CURSOR WITH RETURN TO CLIENT FOR
			SELECT ip.loanId, ip.transacId, t.amount,  t.transDate, t.timeRecorded FROM interestPayments ip
			JOIN Transactions t ON ip.transacId = t.transacId
			WHERE loanId = in_loanId 
			AND t.transdate BETWEEN date2day(in_startDate) AND date2day(in_endDate+1)
			ORDER BY t.transDate DESC;
		OPEN C1;
end@

CREATE OR REPLACE PROCEDURE getLoanRefundHistory(in_startDate DATE DEFAULT '2000-01-01',
		  in_endDate DATE DEFAULT current_date)
	LANGUAGE SQL DYNAMIC RESULT SETS 1
begin
		DECLARE C1 CURSOR WITH RETURN TO CLIENT FOR
			SELECT lr.loanId, m.surname || ' '||m.othernames as debtor,  lr.transacId, t.amount, t.transDate, pm.descr, t.remark FROM loanRepayments lr
			JOIN Transactions t ON lr.transacId = t.transacId
			JOIN payment_method pm on t.payment_method_id = pm.payment_method_id
			JOIN loans l ON l.loanId=lr.loanId
			JOIN member_accounts ma ON ma.accountId=l.accountId
			JOIN members m ON m.memberId=ma.memberId
			WHERE t.transDate BETWEEN date2day(in_startDate) AND date2day(in_endDate+1)
			ORDER BY t.transDate DESC;
		OPEN C1;
end@

CREATE OR REPLACE PROCEDURE getLoanRefundHistory4Loan(in_loanId anchor loanRepayments.loanId,
		  in_startDate DATE DEFAULT '2000-01-01',
		  in_endDate DATE DEFAULT current_date)
	LANGUAGE SQL DYNAMIC RESULT SETS 1
begin
		DECLARE C1 CURSOR WITH RETURN TO CLIENT FOR
			SELECT lr.loanId, lr.transacId, t.amount, t.transDate, pm.descr, t.remark FROM loanRepayments lr
			JOIN Transactions t ON lr.transacId = t.transacId
			JOIN payment_method pm on t.payment_method_id = pm.payment_method_id
			WHERE loanId=in_loanId 
			AND	t.transDate BETWEEN date2day(in_startDate) AND date2day(in_endDate+1)
			ORDER BY t.transDate DESC;
		OPEN C1;
end@


DEBUG('grantLoan')@

CREATE OR REPLACE PROCEDURE grantLoan(
		IN in_accountID anchor loans.accountId,
		IN in_surety_accountId anchor loans.surety_accountId,
		IN in_issueDate anchor loans.issueDate,
		IN in_amount anchor loans.amount,
		IN in_int_rate_id anchor interests.int_rate_id,
		IN in_penalty_rate_id anchor interests.penalty_rate_id,
		IN in_lp_typeId anchor loanPurpose_types.lp_typeId,
		IN in_remark anchor loans.remark,
	   OUT out_loanId anchor loans.loanId,
		IN in_userId anchor users.userId)
--  logging will be done using triggers
BEGIN
	call log_activity('loan', 'grant',in_userId, 'acct# ' || in_accountId || '; surety acct#: '|| in_surety_accountId || '; int: ' || in_int_rate_id|| '; issuedate: ' || in_issueDate);
	CALL checkLoginStatus(in_UserId, 'grantLoan');
	CALL checkPermission(in_UserId,  'grantLoan', 'LOAN');
	BEGIN ATOMIC
		INSERT INTO loans(accountId, surety_accountId, issueDate, amount, lp_typeId, remark,createdBy) VALUES (in_accountId, in_surety_accountId, in_issueDate, in_amount, in_lp_typeId, in_remark, in_userId);
		SET out_loanId=IDENTITY_VAL_LOCAL;
		IF in_int_rate_id IS NOT NULL THEN
			INSERT INTO interests(accountId, int_rate_id, penalty_rate_id, intNextDueDate,createdBy) VALUES (in_accountId, in_int_rate_id, in_penalty_rate_id, in_issueDate, in_userId);
		END IF;
	END;
END@

values('modifyLoan')@
CREATE OR REPLACE PROCEDURE modifyLoan(IN in_loanId anchor loans.loanId,
		IN in_accountID anchor loans.accountId,
		IN in_surety_accountId anchor loans.surety_accountId,
		IN in_issueDate anchor loans.issueDate,
		IN in_amount anchor loans.amount,
		IN in_lp_typeId anchor loanPurpose_types.lp_typeId,
		IN in_remark anchor loans.remark,
		IN in_userId anchor users.userId)
BEGIN
-- TODO reject if issueDate moved back but interest pending
	DECLARE EXIT HANDLER FOR SQLSTATE '23513'
		RESIGNAL SET MESSAGE_TEXT='loan date cannot be after interest date';

	call log_activity('loan','change',in_userId,'loanId: '|| in_loanId || '; acct# ' || in_accountId || '; surety acct#: '|| in_surety_accountId ||  '; issuedate: ' || in_issueDate || '; amnt: '||in_amount);
	CALL checkLoginStatus(in_UserId, 'modifyLoan');
	CALL checkPermission(in_UserId,  'modifyLoan', 'UPDLOAN');
	BEGIN ATOMIC
		DECLARE EXIT HANDLER FOR NOT FOUND BEGIN
			DECLARE v_errtxt VARCHAR(64);
			SET v_errtxt= 'Loan ' || in_loanId || ' not found';
			SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT=v_errtxt;
		END;
		UPDATE loans
		SET accountId=in_accountId, surety_accountId=in_surety_accountId, issueDate=in_issueDate, amount=in_amount, lp_typeId=in_lp_typeId,
		-- int_rate_id=(in_int_rate_id), 
		remark=in_remark, modifiedBy=in_UserId, modifiedAt=current_timestamp
		WHERE loanId=in_loanId;
	END;
END@

CREATE OR REPLACE PROCEDURE changeIntDueDate(IN in_loanId anchor loans.loanId,
		IN in_intNextDueDate anchor loans.intNextDueDate,
		IN in_reason varchar(512),
		IN in_userId anchor users.userId)
BEGIN
-- TODO adjust pending interest. OR, reject if interest pending and date bein moved further
	call log_activity('loan','change',in_userId,'loanId: '|| in_loanId || '; interest due date: ' || in_intNextDueDate|| '; reason' || in_reason);
	CALL checkLoginStatus(in_UserId, 'changeIntDueDate');
	CALL checkPermission(in_UserId,  'checkPermission', 'INTDATE');
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND BEGIN
			DECLARE v_errtxt VARCHAR(64);
			SET v_errtxt= 'Loan ' || in_loanId || ' not found';
			SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT=v_errtxt;
		END;
		UPDATE loans SET intNextDueDate=in_intNextDueDate, modifiedBy=in_userId WHERE loanId=in_loanId;
	END;
END@

CREATE OR REPLACE PROCEDURE changeIntRate(IN in_loanId anchor loans.loanId,
		IN in_int_rate_id anchor loans.int_rate_id,
		IN in_reason varchar(512),
		IN in_userId anchor users.userId)
BEGIN
	call log_activity('loan','change',in_userId,'loanId: '|| in_loanId || '; interest rate: ' || in_int_rate_id|| '; reason' || in_reason);
	CALL checkLoginStatus(in_UserId, 'changeIntDueDate');
	CALL checkPermission(in_UserId,  'checkPermission', 'INTRATE');
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND BEGIN
			DECLARE v_errtxt VARCHAR(64);
			SET v_errtxt= 'Loan ' || in_loanId || ' not found';
			SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT=v_errtxt;
		END;
		UPDATE loans SET int_rate_id=in_int_rate_id, modifiedBy=in_userId WHERE loanId=in_loanId;
	END;
END@


CREATE OR REPLACE PROCEDURE undoLoan(IN in_loanId anchor loans.loanId,
		IN in_reason VARCHAR(512),
	  	IN in_userId anchor users.userId)
BEGIN
	call log_activity('loan','reverse',in_userId,' loanId: '|| in_loanId || '; reason: '|| in_reason);
	CALL checkLoginStatus(in_UserId, 'undoLoan');
	CALL checkPermission(in_UserId,  'undoLoan', 'DELLOAN');
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND BEGIN
			DECLARE v_errtxt VARCHAR(64);
			SET v_errtxt= 'Loan ' || in_loanId || ' not found';
			SIGNAL SQLSTATE '91001' SET MESSAGE_TEXT=v_errtxt;
		END;
		DELETE FROM loans WHERE loanId =in_loanId;
	END;
END@	

