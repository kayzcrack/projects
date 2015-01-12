call getAllIndicatorClass();
-- =========================
call getIndicatorClass('Edu');
call getIndicatorClass('HIV');
call getIndicatorClass('MAL');
-- ==========================
call getAllIndicatorStatus();
-- ==========================
call getIndicatorStatus('Act');
-- =============================
call getAllIndicators();
-- =============================
call getIndicatorsByClass('Envrn');
call getIndicatorsByClass('Edu');
-- ==============================
call getAllIndicatorsByClassStatus('Nac','HIV');
call getAllIndicatorsByClassStatus('Act','MAL');
-- ===============================
call getAllIndicatorsByStatus('Act');
 call getAllIndicatorsByStatus('Nac');
 -- ===============================
  call getAllQuestionStatus();
 -- =============================
  call getQuestionStatus('Act'); 
 call getQuestionStatus('Nac'); 
 
 -- =============================
 call getFrequencyOfMeasure();
 
 -- ==============================
 call getMethodOfMeasurements();
 
 -- ==================================
 call getScheduleActiveStatus();
 
 -- =================================
 call getUStatus();
 
 -- ===============================
 call getUserRoles();
 
 -- ==============================
 
call getAllPermissionTypes();

-- ==============================
call getPermission('MANEVT');

-- ============================
call getAllTeams();

-- ============================
call getTeam('A');
call getTeam('B');
call getTeam('C');
-- =========================
call getAllTeamMembers('A');

-- =========================
call getTeamRespondents('A'); 
-- =========================
call getFacilityTpes();
-- ========================
call getFacilityServices();
-- ========================
call getTitle(); 
-- ======================
call getFacilityContact(1);
-- ========================
call getFacilityStatus();
-- ========================
call getAllFacilityByType('BAN'); -- populate and test
call getAllFacilityByType('HOS');
-- ============================
call getContinent();
-- ==========================
call getCountry();
-- =========================
call getCountryByContinent('Afr');

-- ==========================
call getCountryLevelNames('CMR');
call getCountryLevelNames('CMR'); 
-- ===========================
call getCountryAULevel1('NGA');
call getCountryAULevel1('CMR'); 
-- ==========================
call getCountryAULevel2('NGA');
call getCountryAULevel2('CMR');
-- ===========================
call getAULevel2InAULevel1('FC');
call getAULevel2InAULevel1('CR'); 
call getAULevel2InAULevel1('KG'); 
-- ==========================
-- call getCountryAULevel3('NGA'); 
                                
-- ==========================
                                            
call getAULevel3InAULevel2('1','ZF','NGA');
call getAULevel3InAULevel2('3','AB','NGA');
call getAULevel3InAULevel2('1','FC','NGA'); 
-- ============================
call getTeamAreaOfCoverage('A','2014-11-12','');
call getTeamAreaOfCoverage('A','','2014-10-10');
call getTeamAreaOfCoverage('A','2014-11-12','2014-10-10');
-- ======================================
call getGender();
-- ============================
call getMaritalStatus();
-- ==========================
call getHumanRespodent(1);  
call getHumanRespodent(2);
call getHumanRespodent(3);
-- =========================
call getAddressType();
-- =======================
call getAddress('',1);
call getAddress(1,'');-- populate data to test this procedrue
call getAddress('','');
-- =========================
call getScheduleActiveIndicatorStatus('Act','2014-05-01','2015-03-01');
call getScheduleActiveIndicatorStatus('Nac','','2015-03-01');
call getScheduleActiveIndicatorStatus('Act','2014-05-01','');

-- ==================================
call getScheduleActiveIndicator('2014-05-01','2015-03-01');
call getScheduleActiveIndicator('','2015-03-01');
call getScheduleActiveIndicator('2014-05-01','');
-- ====================================================
call getSelector();

-- ==============================================



