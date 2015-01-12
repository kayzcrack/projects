/*
Revised M&E Test Script
09/10/2013
*/

SELECT authenticateUser('Folaniyi', 'password');


SELECT checkActiveUser('Folaniyi');
SELECT checkActiveUser('Tonia');


SELECT Admin('Folaniyi','password');
SELECT Admin('tonia','password');
SELECT Admin('voti','password');

SELECT checkActiveUser('Folaniyi');
SELECT checkActiveUser('Tonia');

SELECT checkLoginStatus('Folaniyi'); 

SELECT checkPermission('Folaniyi','ADMIN');
SELECT checkPermission('tonia','SCHE');


call addQuestion('MAL','Nac','What effective vaccines are available for the treatment of Malaria?','','Docs questions','Txt','tonia','ADMIN');

call addTeam('G','Team G','Folaniyi','ADMIN');


call addIndicator('SEC','Security Issues','Nac','Law','tonia','ADMIN');

call addMeasure('A4','12','MAL','1999-03-03','1999-09-09','Folaniyi','B1','40','3','tonia','ADMIN');


call addUser('James','pass','Jude','James','L','Registrar',now(),'tonia','ADMIN');
call addUser('James1','pass','Jude','James','L','User',now(),'tonia','ADMIN');


call deactivateIndicator('MAL','tonia','Admin');
call deactivateIndicator('UNE','Folaniyi','Admin');


call activateIndicator('MAL','tonia','Admin');
call activateIndicator('UNE','Folaniyi','Admin');


call activateUser('James1','tonia','password');

call deactivateUser('kayz','tonia','password');
call deactivateUser('voden2','tonia','password');

call changeUserPassword('tonia','password','James','password');


call scheduleActiveIndicator('B1','10','Act','MAL',now(),'2013-11-30','30','100','D','Ob','tonia','Admin');
call scheduleActiveIndicator('A1','1','Act','SP',now(),'2013-11-30','10','70','M','Intv','tonia','Admin');


call logoutUser('voden2');

call addFacility ('Ap','11','Act','Ent','tonia','ADMIN'); 
call addFacility ('Fs','11','Act','Edu','tonia','ADMIN');

call addHumanRespondent('Fred','Tosin','Uduak','2011-09-13','F','S','tonia','ADMIN');
call addHumanRespondent('Kriss','Boma','Lawrence','2010-04-17','M','D','Folaniyi','ADMIN');

call addAddress('Res','NGA','AD','1','03','12','NO 7 Ajasco str','Abuja','tonia','ADMIN');
call addAddress('Con','NGA','AD','1','03','12','NO 30 Ajasco str','Lagos','tonia','MANUSER');


call addRespondent('Respondent','10','7','Folaniyi','ADMIN');
call addRespondent('Respondent','14','8','tonia','ADMIN');
call addRespondent('Respondent',null,'5','Folaniyi','ADMIN');
call addRespondent('Respondent','15',null,'tonia','ADMIN');

call recordHumanRespondent('Person', 5, 'voti', 'ADMIN');

call addFacilityService('J','Human Rights','tonia','ADMIN');

call createUserRole('HOD','Head of Dept','tonia','ADMIN');

call addTeamRespondent('13','1','tonia','ADMIN');
call addTeamRespondent('12','A','Folaniyi','ADMIN');


call addFacilityContact('Principal','ajas@gmail.com','0988989','Ajas','Itoro','Ken','tonia','ADMIN');


call addPermission('DAR','Admin','tonia','password');


call addAUL2('NGA','YB','Unknow','19','tonia','ADMIN');
call addAUL2('NGA','ZF','Unknow','19','Folaniyi','ADMIN');


call addAUL1('NGA','Uknw','Unknow','tonia','ADMIN');


call addAUL3('NGA','YB','Unknown','9','55','tonia','ADMIN');


call addCountry('Unk','Unknown','Afr','tonia','ADMIN');


call addContinent('Unk','Unknown','Folaniyi','Admin');


call addLevel('GHA','Unknown','Unknown','Unknown','tonia','ADMIN');


call addIndicatorClass('Govt','Government','tonia','ADMIN');


call addResultType('N','Numeric','tonia','ADMIN');


call addDataSource('BB','BlackBerry Phone','tonia','ADMIN');


call addPermissionType('AADD','Add Address','Folaniyi','ADMIN');


call addAddressType('E','Email','Folaniyi','ADMIN');


call addFacilityType('S','Stadium','tonia','ADMIN');


call addTeamMember('1','tonia','vincent','tonia','ADMIN');
call addTeamMember('B1','tonia','vincent','Folaniyi','ADMIN');


call addZone('Unkwn','GHA','Unknown','tonia','ADMIN');


call getAllQuestions();

call getQuestionForIndicator('MAL'); 
call getQuestionForIndicator('SP');


call getAllIndicators();


-- call getCountries();


-- call getCountriesinContinent('Afr');


-- call getZonesinCountry('NGA');


-- call getLevelsinCountry('NGA');


call getActiveIndicators();

call getInActiveIndicators();


call getFacilities();

call getFacilitiesbyServices('Ent');

call getActiveFacilities();

call getInActiveFacilities();

call getFacilityAddress('14');

call getHumanAddress('3');

call getRespondentsInfo('Human');
call getRespondentsInfo('Facility');

call getRolePermission('User');

call getUsers();

call getMeasureForIndicator('SP');
call getMeasureForIndicator('MAL');

call getIndicatorClass( );

call getTeamMembers('1');
call getTeamMembers('A');
call getTeamMembers('B1');

call getPermission('Admin');
call getPermission('User');

call getUserLogin();

call getUserPermission('tonia');
call getUserPermission('Folaniyi');
call getUserPermission('voti');

-- call getAULevel2('ZF');

-- call getAULevel3('ZF','1');

-- call getAllAULevel3();

-- call getAllAULevel2();

-- call getAllAULevel1();

call recordHumanRespondent('Person',9,'voti','ADMIN');
call removePermissionFromRole('Report', 'User', 'voti','ADMIN');

call updateAddress('13','Con','NGA','ZF','9','10','12','No 1 national hosp','abuja','tonia','ADMIN');

call updateFacility('10','Ap','11','Nac','Ent','tonia','ADMIN');

call updateUsers('kayz','olu','doc','Tab','User','tonia','ADMIN');

call updateHumanRespondents('6','fred','man','james','1993-03-03','M','S','tonia','ADMIN');


call updateTeamRespondents('13','C','tonia','ADMIN');

call updateUserRole('Admin','Manages All Event','tonia','ADMIN');

call updateQuestions('15','SP','Act','What is rate of unemployment in Nigeria?','','At 100%','Num','tonia','ADMIN');

call updateQuestions('15','SP','Act','What is the rate of unemployment in Nigeria?','','At 100%','Num','tonia','ADMIN');

call updateIndicators('RP','Rice Production Rate','Act','Law','tonia', 'ADMIN');

call updateIndicatorClass('H','Health Care','tonia','ADMIN');

call updateMeasures('A3','1','SP',NOW(),NOW(),'Tonia','A','60','1','tonia','ADMIN');

call updateRespondent('40','Med.Doc','10','7','tonia','ADMIN');

call updateTeam('G','Teams G','tonia','ADMIN');

call updateScheduleActiveIndicator('A3','1','Act','SP',now(),now(),'50','150','M','Ob','tonia','ADMIN');

call updateFreaquencyOfMeasures('BA','Bi-Annually',NOW(),'2014-05-19','tonia','ADMIN');

call updateFacilityContact('11','Me@yahoo.com','098765677','Rex','Lex',null,'tonia','ADMIN');

call updateTeamMember('A','tonia','Kate','tonia','ADMIN');











































