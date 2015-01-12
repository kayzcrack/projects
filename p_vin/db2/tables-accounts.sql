--#SET TERMINATOR ;
-- mfotang, 28-Dec-2012
-- db2 -td\; -f tables.sql

-- 11.10.13	mfotang - added table transTransactions for transactions created from other transactions
--					- added transactions.createdBy

set schema mlfm;



drop table member_account_rel_types; 
create table member_account_rel_types(member_acct_rel char(5) not null primary key, descr varchar(64) not null, sort int not null default 99999);

drop table acct_status_types;
create table acct_status_types(acct_status_id char(4) not null primary key, descr varchar(64), sort int not null default 99999);


drop table payment_method;
create table payment_method(payment_method_id char(4) not null primary key, descr varchar(64), sort int not null default 99999);

drop table loanpurpose_categories;
create table loanpurpose_categories(
	lp_catId VARCHAR(10) NOT NULL PRIMARY KEY,
	description VARCHAR(64) NOT NULL,
	sorter int NOT NULL DEFAULT 99999-- sort entries by this column
);

drop table loanPurpose_types;
CREATE TABLE LoanPurpose_types ( 
lp_typeId INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
lp_catId VARCHAR(10) NOT NULL,
lp_alias VARCHAR(16) NOT NULL,
description VARCHAR(64) NULL,
sorter int NOT NULL DEFAULT 99999-- sort entries by this column
--, constraint uniq_alias unique(lp_alias)
, constraint fk_LoanPurpose_types_categories foreign key(lp_catId) references loanpurpose_categories(lp_catId) on delete cascade
);


drop table savings_accounts;
create table savings_accounts(
	accountId integer  generated always as identity primary key not null,
	accountName varchar(255) not null,
	description varchar(1024),
--	accountBalance decimal(10,2) not null default 0.0,
	acct_status_id char(4) not null default 'act'
	,createdBy integer  not null implicitly hidden
	,createdAt timestamp  default current_timestamp not null implicitly hidden
	,modifiedBy integer  implicitly hidden
	,modifiedAt timestamp  default current_timestamp implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,constraint fk_savingsaccount_users1 foreign key(createdBy) references Users(userId) on delete no action
	,constraint fk_savingsaccount_users foreign key(modifiedBy) references Users(userId) on delete no action
	,constraint fk_savings_accountstatustypes foreign key(acct_status_id) references acct_status_types(acct_status_id) );
create table savings_account_history like savings_accounts;
alter table  savings_account_history append on;
alter table  savings_accounts add versioning use history table savings_account_history;

drop table member_accounts;
create table member_accounts(
	accountId integer not null primary key,
	memberId integer not null,
	member_acct_rel char(5) not null default 'owner'
	,createdBy integer  not null implicitly hidden
	,createdAt timestamp  default current_timestamp not null implicitly hidden
	,modifiedBy integer  implicitly hidden
	,modifiedAt timestamp  default current_timestamp implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,constraint fk_memberaccount_users foreign key(modifiedBy) references Users(userId) on delete no action
	,constraint fk_memberaccount_users1 foreign key(createdBy) references Users(userId) on delete no action
	,constraint fk_memberaccount_members foreign key(memberId) references members(memberId) on delete cascade,
	constraint fk_memberaccount_savingsaccount foreign key(accountId) references savings_accounts(accountId) on delete cascade,
	constraint fk_memberaccount_memberaccreltypes foreign key(member_acct_rel) references member_account_rel_types(member_acct_rel));
create table member_account_history like member_accounts;
alter table member_account_history append on;
alter table member_accounts add versioning use history table member_account_history;

values 'before debits';
	
drop table debits;
create table debits(
	debitId integer generated always as identity primary key not null,
	accountId integer not null,
	amount decimal(10,2) not null,
	payee varchar(128) not null,
	debitDate timestamp not null default
	,createdBy integer  not null implicitly hidden
	,timeRecorded timestamp not null default
	,authorizedBy integer not null
	,remark varchar(1024) not null
	,modifiedBy integer null implicitly hidden
	,modifiedAt timestamp implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,constraint fk_debits_users foreign key(modifiedBy) references Users(userId) on delete no action
	,constraint fk_debits_users2 foreign key(createdBy) references Users(userId) on delete no action
	,constraint fk_debits_members foreign key (authorizedBy) references members(memberId)
	,constraint fk_debits_savingsacct foreign key(accountId) references savings_accounts(accountId) on delete no action);
-- drop table debits_history;
create table debits_history like debits;
alter table debits_history append on;
alter table debits add versioning use history table debits_history;

drop table transactions;
create table transactions(
	transacId integer generated always as identity primary key not null,
	amount decimal(10,2) not null,
	payment_method_id char(4) not null,
	transDate date not null,
	remark varchar(1024) not null,
	timeRecorded timestamp not null default current_timestamp
	,createdBy integer  not null implicitly hidden
	,modifiedBy integer implicitly hidden
	,modifiedAt timestamp  default current_timestamp implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
--	,constraint check_transdate CHECK(transDate<=current_date)
	,constraint fk_transactions_users foreign key(modifiedBy) references Users(userId) on delete no action
	,constraint fk_transactions_users2 foreign key(createdBy) references Users(userId) on delete no action
	,constraint fk_transaction_paymentMethod foreign key(payment_method_id) references payment_method(payment_method_id) on delete no action);
-- drop table transactions_history;
create table transactions_history like transactions;
alter table transactions_history append on;
alter table transactions add versioning use history table transactions_history;


drop table bankTransactions;
create table bankTransactions(
	transacId integer not null primary key,
	payer varchar(128),
	tellerNo varchar(32)
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,constraint fk_banktransaction_transaction foreign key(transacId) references transactions(transacId) on delete cascade);
-- drop table bankTransaction_history;
create table bankTransactions_history like bankTransactions;
alter table bankTransactions_history append on;
alter table bankTransactions add versioning use history table bankTransactions_history;

drop table cashTransactions;
create table cashTransactions(
	transacId integer not null primary key,
	payer varchar(128)
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,constraint fk_chtransaction_transaction foreign key(transacId) references transactions(transacId) on delete cascade);
-- drop table cashTransaction_history;
create table cashTransactions_history like cashTransactions;
alter table cashTransactions_history append on;
alter table cashTransactions add versioning use history table cashTransactions_history;

drop table interaccountTransactions;
create table interaccountTransactions(
	transacId integer not null,
	debitId integer not null -- must be nullable so that fk_accttransaction_debits can set it to null
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,primary key(transacId)
	,constraint uniq_debitId UNIQUE(debitId) -- column is nullable therefore cant be unique
	,constraint fk_accttransaction_debits foreign key(debitId) references debits(debitId) on delete cascade -- there's a trigger action on delete debits, which will delete the transaction which, in turn, must delete this row
	,constraint fk_accttransaction_transactions foreign key(transacId) references transactions(transacId) on delete cascade);
create table interaccountTransactions_history like interaccountTransactions;
alter table interaccountTransactions_history append on;
alter table interaccountTransactions add versioning use history table interaccountTransactions_history;

-- transactions that have been created from other transactions
drop table transTransactions;
create table transTransactions(
	transacId integer not null,
	srctransacId integer not null -- parent transaction
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,primary key(transacId)
	,constraint fk_accttransaction_transactions foreign key(transacId) references transactions(transacId) on delete cascade	
	,constraint fk_accttransaction_transactions2 foreign key(srctransacId) references transactions(transacId) on delete cascade);

drop table deposits;
create table deposits(
	accountId integer not null,
	transacId integer not null
	,modifiedBy integer  not null implicitly hidden
	,modifiedAt timestamp  default current_timestamp not null implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,primary key(transacId)
	,constraint fk_deposit_savingsacct foreign key(accountId) references savings_accounts(accountId) on delete cascade
	,constraint fk_deposit_transactions foreign key(transacId) references transactions(transacId) on delete cascade);

-- drop table deposits_history;
create table deposits_history like deposits;
alter table deposits_history append on;
alter table deposits add versioning use history table deposits_history;

select 'before loans' "progress" from sysibm.dual;
drop table loans;
create table loans(
	loanId integer generated always as identity primary key not null,
	surety_accountId integer not null,
	accountId integer not null,
	lp_typeId INTEGER not null, --loan purpose
	issueDate date not null,
	amount decimal(10,2) not null,
	remark varchar(1024)
	,timeRecorded timestamp not null default current_timestamp
	,createdBy integer not null implicitly hidden
	,modifiedBy integer implicitly hidden
	,modifiedAt timestamp  default current_timestamp implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,constraint check_dates CHECK(DATE(timeRecorded)>=issueDate)
	,constraint fk_loans_loanPurpose_types foreign key(lp_typeId) references loanPurpose_types(lp_typeId) on delete no action
	,constraint fk_loans_users foreign key(modifiedBy) references Users(userId) on delete no action
	,constraint fk_debits_users2 foreign key(createdBy) references Users(userId) on delete no action
	,constraint fk_loans_savingsacct foreign key(surety_accountId) references savings_accounts(accountId) on delete restrict
	,constraint fk_loans_savingsacct2 foreign key(accountId) references savings_accounts(accountId) on delete restrict);
-- drop table loans_history;
create table loans_history like loans;
alter table loans_history append on;
alter table loans add versioning use history table loans_history;

DEBUG('interest requirements on loans');
drop table interests;
create table interests(
	loanId integer not null primary key,
	int_rate_id integer not null,
	penalty_rate_id integer null, -- null if there is no penalty on late interest payments
-- the next two colums intLastPaidDate and carriedOver are used solely for system-internal tracking
	intLastPaidDate date null implicitly hidden, -- the last transaction date taht was used for interest. any amount left over is recorded in the following column `carriedOver'
	carriedOver decimal(10,2) default 0.0 implicitly hidden, -- amount left over after interest for the cycle was fully paid. transaction date was intLastPaidDate
	int_cycle integer not null default 30, -- the period of interest, in days
	intNextDueDate date not null
	,createdBy integer not null implicitly hidden
	,modifiedBy integer implicitly hidden
	,modifiedAt timestamp  default current_timestamp implicitly hidden
--	,constraint check_dates CHECK(intNextDueDate>=issueDate) -- move into trigger
	,constraint fk_loans_users foreign key(modifiedBy) references Users(userId) on delete no action
	,constraint fk_debits_users2 foreign key(createdBy) references Users(userId) on delete no action
	,constraint fk_loans_interestrates foreign key(int_rate_id) references interest_rates(int_rate_id) on delete restrict
	,constraint fk_interests_loans foreign key(loanId) references loans(loanId) on delete cascade);

-- a kludge to track values that cannot be updated directly from within certain triggers
-- e.g. intNextDueDate that cannot be updated at the time transaction is removed
drop table loan_status;
create table loan_status(
	loanId integer not null primary key,
	cond varchar(32) not null, -- e.g. 'updIntDueDate'
	value varchar(32) null -- 'Y'/'N'. 'Y'=> loans.intNextDueDate needs to be updated
	,constraint uniq_cond UNIQUE(cond)
	,constraint fk_loansdtatus_loans foreign key(loanId) references loans(loanId) on delete cascade);

drop table loanRepayments;
create table loanRepayments(
	loanId integer not null,
	transacId integer not null
	,remark varchar(512)
	-- get createdAt from the transaction!
	,modifiedBy integer  not null implicitly hidden
	,modifiedAt timestamp  default current_timestamp not null implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,primary key(transacId)
	,constraint fk_loanRepayments_transactions foreign key(transacId) references transactions(transacId) on delete cascade
	,constraint fk_lorepay_loans foreign key(loanId) references loans(loanId) on delete no action);
-- drop table loanRepayments_history;
create table loanRepayments_history like loanRepayments;
alter table loanRepayments_history append on;
alter table loanRepayments add versioning use history table loanRepayments_history;
	
-- Fines on late payment of interest
drop table interestFines;
create table interestFines(
	loanId int not null
	,transacId integer not null primary key
	,remark varchar(512)
	,modifiedBy integer  not null implicitly hidden
	,modifiedAt timestamp  default current_timestamp not null implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,constraint fk_interestFines_loans foreign key(loanId) references interests(loanId) on delete no action
	,constraint fk_interestFines_transactions foreign key(transacId) references transactions(transacId) on delete cascade);

create table interestFines_history like interestFines;
alter table interestFines_history append on;
alter table interestFines add versioning use history table interestFines_history;

values('creating table nterestPayments');	
drop table interestPayments;
create table interestPayments(
	loanId int not null
	,transacId integer not null primary key
	,remark varchar(512)
	,modifiedBy integer  not null implicitly hidden
	,modifiedAt timestamp  default current_timestamp not null implicitly hidden
	,sys_start timestamp(12) generated always as row begin not null implicitly hidden
	,sys_end timestamp(12) generated always as row end not null implicitly hidden
	,trans_start timestamp(12) generated always as transaction start id implicitly hidden
	,period system_time(sys_start,sys_end)
	,constraint fk_interestPayments_loans foreign key(loanId) references interests(loanId) on delete no action
	,constraint fk_interestPayments_transactions foreign key(transacId) references transactions(transacId) on delete cascade);

create table interestPayments_history like interestPayments;
alter table interestPayments_history append on;
alter table interestPayments add versioning use history table interestPayments_history;

-- sequences:

-- drop sequence memberId_seq;
-- drop sequence debitId_seq;
-- drop sequence loanId_seq;
-- drop sequence transacId_seq;
-- drop sequence accountId_seq;
-- drop sequence qtrId_seq;
-- 
-- create sequence memberId_seq start with 1000 increment by 1 no maxvalue  nocache;
-- create sequence debitId_seq start with 1 increment by 1 no maxvalue  nocache;
-- create sequence loanId_seq start with 1 increment by 1 no maxvalue  nocache;
-- create sequence transacId_seq start with 1 increment by 1 no maxvalue  nocache;
-- create sequence accountId_seq start with 1 increment by 1 no maxvalue  nocache;
-- create sequence qtrId_seq start with 1 increment by 1 no maxvalue  nocache;

