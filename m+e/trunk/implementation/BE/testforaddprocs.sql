
-- Test addSelector

call addSelector('Hindi');
call addSelector('Arabic');
call addSelector('Spanish');
call addSelector('Mandarin');
call addSelector('Bengali');
call addSelector('Russian');
call addSelector('German');
call addSelector('Yoruba');
call addSelector('Hausa');
call addSelector('Igbo');
call addSelector('Urhobo');
call addSelector('Efik');
call addSelector('Ibibio');
-- ----------------------------------------------
-- Test addIndicatorClass

Call addIndicatorClass('SAN','Sanitation');
Call addIndicatorClass('SAN1','san1');
Call addIndicatorClass('POP','POP');
Call addIndicatorClass('EB','Emotional Behaviour');
Call addIndicatorClass('CMR','Child Mortality Rate');
Call addIndicatorClass('ILT','Illitracy');
Call addIndicatorClass('F&D','Flood and Drought');
Call addIndicatorClass('UNE','Unemployment Rate');
Call addIndicatorClass('RP','Rice Production');
Call addIndicatorClass('AR','Accident Rate');
Call addIndicatorClass('CL','Corruption Level');
-- ----------------------------------------------
-- Test addIndicator

Call addIndicator('Number of people who test hiv+','nac','HIV');
Call addIndicator('No of waste bins','nac','SAN');
Call addIndicator('No of graduates in the community','act','UNE');
Call addIndicator('No of working graduates in the community','act','UNE');
Call addIndicator('No of accident a day','nac','AR');
Call addIndicator('No of governors without First degree','nac','CL');
Call addIndicator('Aggressiveness','nac','EB');
Call addIndicator('Slogishness','nac','EB');
Call addIndicator('Cleaniness of the environment','nac','EB');
Call addIndicator('No of children who died at birth','nac','EB');
Call addIndicator('No of mothers who come for ante-natal','nac','EB');
Call addIndicator('no of students in a class','act','SP');
Call addIndicator('no of female students in a class','act','SP');
Call addIndicator('no of male students in a class','act','SP');
Call addIndicator('no of female students in a school','act','SP');
Call addIndicator('no of male students in a school','act','SP');
Call addIndicator('Teacher to student ratio','act','SP');
Call addIndicator('no of students who scored above 60 percent','act','SP');
-- --------------------------------------------------------------------
-- Test addFrequencyOfMeasure 

Call addFrequencyOfMeasure('M', 'Monthly',now(),'');
Call addFrequencyOfMeasure('W', 'Weekly',now(),'');
Call addFrequencyOfMeasure('BW', 'Bi-Weekly',now(),'');
Call addFrequencyOfMeasure('Y', 'Anually',now(),'');
Call addFrequencyOfMeasure('BY','Bi-Anually',now(),'');
Call addFrequencyOfMeasure('H','Hourly',now(),'');
-- ---------------------------------------------------------------
-- Test addMethodOfMeasurement

Call addMethodOfMeasurement('Questionnaire');
Call addMethodOfMeasurement('Focus groups');
Call addMethodOfMeasurement('Community meetings');
Call addMethodOfMeasurement('Key informant interviews');
Call addMethodOfMeasurement('Archive');
Call addMethodOfMeasurement('Observation');
-- ---------------------------------------------------------------
-- Test addUserRole

Call addUserRole('TL','TeamLead');
Call addUserRole('TM','Team Member');
Call addUserROle('SU','Super User');
-- ----------------------------------------------------------------
-- Test addUser

Call addUser('password','Alex','Alexander','act','TL','Alec');
Call addUser('password','Afoma','Afoma1','act','TL','A');
Call addUser('password','Vincent','Ale','act','TL','Ale');
Call addUser('password','tonaya','tonaya','act','TM','Alec');
Call addUser('password','voti','vincent','act','TM','Alec');
-- -------------------------------------------------
-- Test addPermissionType

Call addPermissionType('MANT','Manage Team');
Call addPermissionType('MANM','Manager team member');
Call addPermissionType('MANQ','Manager question');
Call addPermissionType('SM','Manage Schedule'); 
Call addPermissionType('AU','Add User');

-- ---------------------------------------------------------
-- Test addPermission

Call addPermission('MANM','ADMIN');
Call addPermission('MANM','TL');
Call addPermission('AU','SU');
Call addPermission('MANQ','ADMIN');
Call addPermission('MANQ','SU');
-- ----------------------------------------------------
-- Test addTeam

Call addTeam('E','Team E');
Call addTeam('F','Team F');
Call addTeam('1','Team 1');
Call addTeam('2','Team 2');
-- ---------------------------------------------------
-- Test addDataSource

CALL addDataSource('TAB','Tablet');
CALL addDataSource('p1','paper1');
CALL addDataSource('p3','paper3');
CALL addDataSource('p4','paper4');
CALL addDataSource('p5','paper5');
CALL addDataSource('p6','paper6');
CALL addDataSource('p7','paper7');
CALL addDataSource('p8','p8');
CALL addDataSource('p9','p9');
CALL addDataSource('p10','p10');
-- ----------------------------------------------
-- Test addTeamMember

Call addTeamMember('C','Tonia','TAB','Alex');
Call addTeamMember('A','Afoma','p1','Vincent');
Call addTeamMember('B','Vincent','LAP','Afoma');
Call addTeamMember('D','Tonaya','TAB','Alex');
Call addTeamMember('E','voti','TAB','Afoma');

-- --------------------------------------------------
-- Test addFacilityType

Call addFacilityType('AP','Airport');
Call addFacilityType('CH','Church');
Call addFacilityType('Ci','Cinema');
Call addFacilityType('FS','Filling station');
Call addFacilityType('PGC','Power Generating Company');
Call addFacilityType('MKT','Market');
Call addFacilityType('FA','Farms');
Call addFacilityType('M','Mosque');
Call addFacilityType('SCH','School');
-- ------------------------------------
-- Test addFacilityService

CAll addFacilityService('EDU','Educational Services');
CAll addFacilityService('REL','Religious services');
CAll addFacilityService('ENT','Entertainment services');
CAll addFacilityService('POW','Electricity Services');
CAll addFacilityService('FP','Farm Products');
CAll addFacilityService('GAS','Gas services');
CAll addFacilityService('B+S','Buying and Selling');
-- ----------------------------------------
-- Test addAddress

call addAddress('con','NGA','AB','1','01','Abuja','');
call addAddress('res','NGA','BA','1','01','No 1 Bayelsa','');
call addAddress('off','NGA','ZF','4','04','No 1 Zamfara road','near the mango tree');
call addAddress('con','NGA','YB','4','01','No 1 Yobe road','near the icecream truck');
call addAddress('con','NGA','NS','5','03','No 1 Nassarawa road','near the filling station');
call addAddress('con','NGA','KN','7','06','No 1 kano road','');
-- -------------------------------------------------
-- Test addFacility

Call addFacility('SCH','Garki School','nac','EDU','Dr','james@yahoo.com','9878','Chikwe','john','they','con','NGA','BA','1','01','Garki School Bayelsa',''); 
Call addFacility('MKT','Garki Market','act','B+S','Mrs','july@yahoo.com','9878','Chik','july','they','res','NGA','FC','1','01','Garki Market Abuja','');
Call addFacility('PGC','PHCN Office','nac','POW','Mr','james@yahoo.com','9878','Chikwe','john','they','con','NGA','BA','1','01','Power Generating Company abuja','');
Call addFacility('SCH','Garki Sch 1','nac','EDU','Dr','james@yahoo.com','9878','Chikwe','john','they','con','NGA','BA','1','01','Garki school Abuja','');
Call addFacility('Ci','Garki Cinema','act','ENT','Dr','james@yahoo.com','9878','Chikwe','john','they','con','NGA','BA','1','01','Garki cinema Abuja','');
Call addFacility('FS','Garki Filling station','act','GAS','Dr','james@yahoo.com','9878','Chikwe','john','they','con','NGA','BA','1','01','Garki fuel station Abuja','');
Call addFacility('FA','Garki Farms','nac','FP','Dr','james@yahoo.com','9878','Chikwe','john','they','con','NGA','BA','1','01','Garki farm Abuja','');
Call addFacility('CH','Garki Church','nac','REL','Dr','james@yahoo.com','9878','Chikwe','john','they','con','NGA','BA','1','01','Garki church Abuja','');
Call addFacility('M','Garki Mosque','act','REL','Dr','james@yahoo.com','9878','Chikwe','john','they','con','NGA','BA','1','01','Garki mosque Abuja','');


-- ------------------------------------------------------
-- Test addHumanRespondent

Call addHumanRespondent('Jude','July','1991-03-16','F','S','con','NGA','AB','1','01','No 5 Central Area','');
Call addHumanRespondent('ode','odu','1991-03-18','M','M','res','NGA','FC','1','01','No 5 Central Area','');
Call addHumanRespondent('Fred','June','1991-08-16','F','S','off','NGA','AB','1','01','No 5 Central Area','');
Call addHumanRespondent('tonia','ton','1999-03-16','M','S','con','NGA','AB','1','01','No 5 Central Area','');
Call addHumanRespondent('Jun','kon','1989-03-16','F','D','res','NGA','AB','1','01','No 5 Central Area','');
Call addHumanRespondent('man','mano','1975-03-16','M','S','con','NGA','AB','1','01','No 5 Central Area','');
-- ---------------------------
-- Test addRespondent

call addRespondent('girl',1,null);
call addRespondent('boy',null,1);
call addRespondent('A man',null,2);
call addRespondent('a man',2,null);
call addRespondent('a gal',3,null);
call addRespondent('a boy',null,3);
call addRespondent('a child',4,null);
-- ---------------------------------
-- Test addTeamRespondent

Call addTeamRespondent('C',NOW(),'');
Call addTeamRespondent('A','','');
Call addTeamRespondent('B',NOW(),'');
Call addTeamRespondent('D','',NOW());
Call addTeamRespondent('1',NOW(),'');
Call addTeamRespondent('2','',NOW());

-- --------------------------------------------------
-- Test addFacilityContact

call addFacilityContact('Mrs','yahoo.com','987665768','jack','james','july');
call addFacilityContact('Ms','yahoo.com','9768','july','john','rex');
call addFacilityContact('Mr','yahoo.com','987668','mark','vincent','oti');
call addFacilityContact('Dr','yahoo.com','95768','angel','cath','rine');
call addFacilityContact('Prof','yahoo.com','665768','hansan','jude','julie');
call addFacilityContact('Rev','yahoo.com','965768','rukki','james','jewel');


-- -----------------------------------------------
-- Test addContinent

call addContinent('TONIA','Tonia con'); 
-- ---------------------------------------------
-- Test addCountry

call addCountry('T','Tonia country','TONIA');
-- --------------------------------
-- Test addLevelName

Call addLevelName('T','STATE','LGA','WARD');
-- ------------------------------------------
-- Test addCountryZone

call addCountryZone('T','N','NORTH');
call addCountryZone('T','S','SOUTH');
-- -----------------------------------------
-- Test addAULevel1

call addAULevel1('T','AN','ANTHONIA');
-- -----------------------------------------------
-- Test addAULevel2 

call addAULevel2('T','AN','JUDE','ANN');
-- ------------------------------------------------
-- Test addAULevel3 

call addAULevel3('T','AN','VINCENT','ANN','AFOMA');
-- ------------------------------------------------
-- Test addScheduleActiveIndicator

call addScheduleActiveIndicator(1,'act',now(),'2014-05-05','D',1);
call addScheduleActiveIndicator(1,'nac',now(),'2014-06-05','W',2);
call addScheduleActiveIndicator(1,'act',now(),'2014-05-05','D',3);
call addScheduleActiveIndicator(1,'act',now(),'2014-05-05','D',4);
call addScheduleActiveIndicator(1,'act',now(),'2014-05-05','D',2);
call addScheduleActiveIndicator(1,'act',now(),'2014-05-05','D',4);
call addScheduleActiveIndicator(1,'act',now(),'2014-05-05','D',5);
-- --------------------------------------------------------
-- Test addMeasure

call addMeasure(1,1,1,'Tonaya','10 people were tested for malaria bt only 3 had malaria','D');
call addMeasure(1,1,1,'Afoma','10 people were tested for malaria bt only 3 had malaria','A');
call addMeasure(1,1,1,'Vincent','10 people were tested for malaria bt only 3 had malaria','B');
call addMeasure(1,1,1,'Tonaya','10 people were tested for malaria bt only 3 had malaria','D');
call addMeasure(1,1,1,'Tonia','10 people were tested for malaria bt only 3 had malaria','A');
call addMeasure(1,1,1,'Afoma','10 people were tested for malaria bt only 3 had malaria','A');
call addMeasure(1,1,1,'voti','10 people were tested for malaria bt only 3 had malaria','E');
-- ----------------------------------------
-- Test addTeamAreaOfCoverage

call addTeamAreaOfCoverage('A','01','NGA','AB','1',now(),'2014-06-01'); 
call addTeamAreaOfCoverage('B','03','NGA','AB','3',now(),'2014-06-01');
call addTeamAreaOfCoverage('C','04','NGA','AB','1',now(),'2014-06-01');
call addTeamAreaOfCoverage('D','05','NGA','AB','4',now(),'2014-06-01');
call addTeamAreaOfCoverage('1','06','NGA','AB','1',now(),'2014-06-01');
call addTeamAreaOfCoverage('A','07','NGA','AB','1',now(),'2014-06-01');
-- --------------------------------------
-- Test Question

call addQuestion(2,'num','act','How many people tested HIV positive?','Use pencils','Answer should be a number',1);
call addQuestion(1,'num','act','How many students are females?','Use pencils','Answer should be a number',2);
call addQuestion(3,'num','act','How many students are male?','Use pencils','Answer should be a number',3);
call addQuestion(4,'num','act','How many people are graduates?','Use pencils','Answer should be a number',4);
call addQuestion(5,'num','act','How many teachers have BSc?','Use pencils','Answer should be a number',5);
call addQuestion(1,'num','act','How clean is the Hospital?','Use pencils','Answer should be a txt',6);
call addQuestion(2,'num','act','How many waste bins do the Hospital have?','Use pencils','Answer should be a number',7);


-- ---------------------------------------------

call LoginUser('Tonia','password');
call LoginUser('Alex','password');
call LoginUser('Afoma','password');
call LoginUser('Vincent','password');

-- ------------------------
call LogoutUser('Tonia');
call LogoutUser('Alex');








