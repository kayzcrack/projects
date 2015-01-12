call getAllMenu();
-- ==============
call getMenu('DO');
call getMenu('cert');
call getMenu('vio');
-- ===============
call getMenuLink('ins');
call getMenuLink('ld');
call getMenuLink('ds');
-- ================
call getAllPermission(); -- check this again.
-- get all permission for a user.
-- =================
call getPermission('adm');
call getPermission('reg');
-- =================
call getAllRoles()
-- ================
call getRole('DI');
call getRole('FRSC');
-- =================
call getAllUser();
-- ================
call getUser('jondon');
call getUser('winny');
-- ================
call getGender();
-- ================
call getDriver('CPCD/00178');
call getDriver('CPCD/00249');
call getDriver('CPCD/00483'); 

-- =================
call getAllDriver('RS.1');
call getAllDriver('RS.2'); 

-- =================
call getAllRelationship();
-- =================
call getDriverNOK('CPCD/0234');
call getDriverNOK('CPCD/0235'); 

-- =================
call getFRSCSectorCommand('RS1.1');
call getFRSCSectorCommand('RS1.2');

-- =================
call getFRSCSectorCommand();
-- =================
call getAllSectorInstructor();
-- =================
call  getSectorInstructor('RS.1/0234');
call  getSectorInstructor('RS.1/0235');
-- ==================
call getModule('A');
call getModule('B');
-- ==================
call getModuleSubType('A');
call getModuleSubType('B');
call getModuleSubType('C');
-- ==================
call getTraining('','','CPCD/00178'); -- test again
call getTraining('2014-11-11 00:00:00','');
call getTraining('','2015-11-11');
-- =================




