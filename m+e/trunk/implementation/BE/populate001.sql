INSERT INTO MethodOfMeasurement(Description) 
VALUES ('Interview'),('Archive'); 

-- ===================================================================================
INSERT INTO QuestionStatus(StatusID,Description) 
VALUES ('act','active'),('nac','Not active');

-- ==================================================================================
INSERT INTO UserStatus
VALUES('nac','Not active'),('act','active');

-- ====================================================

INSERT INTO  ResultType 
VALUES ('txt','Text'),('num','Number');

-- ==================================================================================

INSERT INTO IndicatorStatus VALUES ('act','active'),('nac','Not active');

-- ====================================================================

INSERT INTO Title (TitleID, Description) 
VALUES ('Mr','MR'),('Mrs','MRS'),('Dr','DOCTOR'),('Prof','Professor');

-- ==================================================================================
INSERT INTO Selector(Description) VALUES('English'),('French'),('Latin');
-- =========================================================================

INSERT INTO IndicatorClass VALUES ('MAL','Malaria');

-- ====================================================================
INSERT INTO `Indicator`(Name,StatusID,IndicatorClassID)
VALUES('no of mal patient','act','MAL');
-- ================================================

INSERT INTO Question(IndicatorID,TypeID,StatusID,Question,Instructions,HINT,SelectorID)
VALUES(1,'txt','act','How many people where tested for malaria?','give your answer','Number',1);
-- ================================================

INSERT INTO FrequencyOfMeasure 
VALUES ('D','Daily',now(),'');
-- ===================================================================

INSERT INTO ScheduleActiveStatus 
VALUES ('act','active'),('nac','Not active');

-- ===================================================================
INSERT INTO FacilityService
VALUES('MEDS','Medical Services');
-- =============================================================

INSERT INTO FacilityStatus
VALUES('act','active'),('nac','Not active');

-- ==========================================================
INSERT INTO FacilityType
VALUES('HOS','Hospital'),('BAN','Bank');

-- ===========================================================
INSERT INTO Team(TeamID,Description,DateFormed) 
VALUES('A','Team A',now());

-- =================================================
INSERT INTO MaritalStatus 
VALUES('S','Single'),('M','Married'),('D','Divorced');

-- ==============================================================

INSERT INTO Gender 
VALUES ('M','Male'),('F','Female');

-- =================================================================

INSERT INTO DataSource
VALUEs('LAP','Laptop'),('PAP','Papers');
-- =======================================================

INSERT INTO UserRole
VALUES('ADMIN','Admin');

-- ======================================================
INSERT INTO PermissionType
VALUES('MANU','Manage Users');

-- =====================================================
INSERT INTO AddressType 
VALUES ('con','Contact'),('res','Residential'),('off','Official');

-- ===============================================================
INSERT INTO Continent(ContinentCode, Name) 
VALUES ('Afr','Afica'),('Ant','Antarctica'),('Asia','Asia'),('Aus','Australia'),('Eup','Europe'),('NAme','North America'),('Oce','Oceania'),('SAme','South America');

-- ==============================================================

/* insertinginto table Country */
INSERT INTO Country VALUES ('ABW','Aruba','NAme');
INSERT INTO Country VALUES ('AFG','Afghanistan','Asia');
INSERT INTO Country VALUES ('AGO','Angola','Afr');
INSERT INTO Country VALUES('AIA','Anguilla','NAme');
INSERT INTO Country VALUES('ALB','Albania','Eup');
INSERT INTO Country VALUES('AND','Andorra','Eup');
INSERT INTO Country VALUES('ANT','Netherlands Antilles','NAme');
INSERT INTO Country VALUES('ARE','United Arab Emirates','Asia');
INSERT INTO Country VALUES('ARG','Argentina','SAme');
INSERT INTO Country VALUES('ARM','Armenia','Asia');
INSERT INTO Country VALUES('ASM','American Samoa','Oce');
INSERT INTO Country VALUES('ATA','Ant','Ant');
INSERT INTO Country VALUES('ATF','French Southern territories','Ant');
INSERT INTO Country VALUES('ATG','Antigua and Barbuda','NAme');
INSERT INTO Country VALUES('AUS','Aus','Oce');
INSERT INTO Country VALUES('AUT','Austria','Eup');
INSERT INTO Country VALUES('AZE','Azerbaijan','Asia');
INSERT INTO Country VALUES('BDI','Burundi','Afr');
INSERT INTO Country VALUES('BEL','Belgium','Eup');
INSERT INTO Country VALUES('BEN','Benin','Afr');
INSERT INTO Country VALUES('BFA','Burkina Faso','Afr');
INSERT INTO Country VALUES('BGD','Bangladesh','Asia');
INSERT INTO Country VALUES('BGR','Bulgaria','Eup');
INSERT INTO Country VALUES('BHR','Bahrain','Asia');
INSERT INTO Country VALUES('BHS','Bahamas','NAme');
INSERT INTO Country VALUES('BIH','Bosnia and Herzegovina','Eup');
INSERT INTO Country VALUES('BLR','Belarus','Eup');
INSERT INTO Country VALUES('BLZ','Belize','NAme');
INSERT INTO Country VALUES('BMU','Bermuda','NAme');
INSERT INTO Country VALUES('BOL','Bolivia','SAme');
INSERT INTO Country VALUES('BRA','Brazil','SAme');
INSERT INTO Country VALUES('BRB','Barbados','NAme');
INSERT INTO Country VALUES('BRN','Brunei','Asia');
INSERT INTO Country VALUES('BTN','Bhutan','Asia');
INSERT INTO Country VALUES('BVT','Bouvet Island','Ant');
INSERT INTO Country VALUES('BWA','Botswana','Afr');
INSERT INTO Country VALUES('CAF','Central African Republic','Afr');
INSERT INTO Country VALUES('CAN','Canada','NAme');
INSERT INTO Country VALUES('CCK','Cocos (Keeling) Islands','Oce');
INSERT INTO Country VALUES('CHE','Switzerland','Eup');
INSERT INTO Country VALUES('CHL','Chile','SAme');
INSERT INTO Country VALUES('CHN','China','Asia');
INSERT INTO Country VALUES('CIV','Cote D`Ivoire','Afr');
INSERT INTO Country VALUES('CMR','Cameroon','Afr');
INSERT INTO Country VALUES('COD','Congo, The Democratic Republic of the','Afr');
INSERT INTO Country VALUES('COG','Congo','Afr');
INSERT INTO Country VALUES('COK','Cook Islands','Oce');
INSERT INTO Country VALUES('COL','Colombia','SAme');
INSERT INTO Country VALUES('COM','Comoros','Afr');
INSERT INTO Country VALUES('CPV','Cape Verde','Afr');
INSERT INTO Country VALUES('CRI','Costa Rica','NAme');
INSERT INTO Country VALUES('CUB','Cuba','NAme');
INSERT INTO Country VALUES('CXR','Christmas Island','Oce');
INSERT INTO Country VALUES('CYM','Cayman Islands','NAme');
INSERT INTO Country VALUES('CYP','Cyprus','Asia');
INSERT INTO Country VALUES('CZE','Czech Republic','Eup');
INSERT INTO Country VALUES('DEU','Germany','Eup');
INSERT INTO Country VALUES('DJI','Djibouti','Afr');
INSERT INTO Country VALUES('DMA','Dominica','NAme');
INSERT INTO Country VALUES('DNK','Denmark','Eup');
INSERT INTO Country VALUES('DOM','Dominican Republic','NAme');
INSERT INTO Country VALUES('DZA','Algeria','Afr');
INSERT INTO Country VALUES('ECU','Ecuador','SAme');
INSERT INTO Country VALUES('EGY','Egypt','Afr');
INSERT INTO Country VALUES('ERI','Eritrea','Afr');
INSERT INTO Country VALUES('ESH','Western Sahara','Afr');
INSERT INTO Country VALUES('ESP','Spain','Eup');
INSERT INTO Country VALUES('EST','Estonia','Eup');
INSERT INTO Country VALUES('ETH','Ethiopia','Afr');
INSERT INTO Country VALUES('FIN','Finland','Eup');
INSERT INTO Country VALUES('FJI','Fiji Islands','Oce');
INSERT INTO Country VALUES('FLK','Falkland Islands','SAme');
INSERT INTO Country VALUES('FRA','France','Eup');
INSERT INTO Country VALUES('FRO','Faroe Islands','Eup');
INSERT INTO Country VALUES('FSM','Micronesia, Federated States of','Oce');
INSERT INTO Country VALUES('GAB','Gabon','Afr');
INSERT INTO Country VALUES('GBR','United Kingdom','Eup');
INSERT INTO Country VALUES('GEO','Georgia','Asia');
INSERT INTO Country VALUES('GHA','Ghana','Afr');
INSERT INTO Country VALUES('GIB','Gibraltar','Eup');
INSERT INTO Country VALUES('GIN','Guinea','Afr');
INSERT INTO Country VALUES('GLP','Guadeloupe','NAme');
INSERT INTO Country VALUES('GMB','Gambia','Afr');
INSERT INTO Country VALUES('GNB','Guinea-Bissau','Afr');
INSERT INTO Country VALUES('GNQ','Equatorial Guinea','Afr');
INSERT INTO Country VALUES('GRC','Greece','Eup');
INSERT INTO Country VALUES('GRD','Grenada','NAme');
INSERT INTO Country VALUES('GRL','Greenland','NAme');
INSERT INTO Country VALUES('GTM','Guatemala','NAme');
INSERT INTO Country VALUES('GUF','French Guiana','SAme');
INSERT INTO Country VALUES('GUM','Guam','Oce');
INSERT INTO Country VALUES('GUY','Guyana','SAme');
INSERT INTO Country VALUES('HKG','Hong Kong','Asia');
INSERT INTO Country VALUES('HMD','Heard Island and McDonald Islands','Ant');
INSERT INTO Country VALUES('HND','Honduras','NAme');
INSERT INTO Country VALUES('HRV','Croatia','Eup');
INSERT INTO Country VALUES('HTI','Haiti','NAme');
INSERT INTO Country VALUES('HUN','Hungary','Eup');
INSERT INTO Country VALUES('IDN','Indonesia','Asia');
INSERT INTO Country VALUES('IND','India','Asia');
INSERT INTO Country VALUES('IOT','British Indian Ocean Territory','Afr');
INSERT INTO Country VALUES('IRL','Ireland','Eup');
INSERT INTO Country VALUES('IRN','Iran','Asia');
INSERT INTO Country VALUES('IRQ','Iraq','Asia');
INSERT INTO Country VALUES('ISL','Iceland','Eup');
INSERT INTO Country VALUES('ISR','Israel','Asia');
INSERT INTO Country VALUES('ITA','Italy','Eup');
INSERT INTO Country VALUES('JAM','Jamaica','NAme');
INSERT INTO Country VALUES('JOR','Jordan','Asia');
INSERT INTO Country VALUES('JPN','Japan','Asia');
INSERT INTO Country VALUES('KAZ','Kazakstan','Asia');
INSERT INTO Country VALUES('KEN','Kenya','Afr');
INSERT INTO Country VALUES('KGZ','Kyrgyzstan','Asia');
INSERT INTO Country VALUES('KHM','Cambodia','Asia');
INSERT INTO Country VALUES('KIR','Kiribati','Oce');
INSERT INTO Country VALUES('KNA','Saint Kitts and Nevis','NAme');
INSERT INTO Country VALUES('KOR','South Korea','Asia');
INSERT INTO Country VALUES('KWT','Kuwait','Asia');
INSERT INTO Country VALUES('LAO','Laos','Asia');
INSERT INTO Country VALUES('LBN','Lebanon','Asia');
INSERT INTO Country VALUES('LBR','Liberia','Afr');
INSERT INTO Country VALUES('LBY','Libyan Arab Jamahiriya','Afr');
INSERT INTO Country VALUES('LCA','Saint Lucia','NAme');
INSERT INTO Country VALUES('LIE','Liechtenstein','Eup');
INSERT INTO Country VALUES('LKA','Sri Lanka','Asia');
INSERT INTO Country VALUES('LSO','Lesotho','Afr');
INSERT INTO Country VALUES('LTU','Lithuania','Eup');
INSERT INTO Country VALUES('LUX','Luxembourg','Eup');
INSERT INTO Country VALUES('LVA','Latvia','Eup');
INSERT INTO Country VALUES('MAC','Macao','Asia');
INSERT INTO Country VALUES('MAR','Morocco','Afr');
INSERT INTO Country VALUES('MCO','Monaco','Eup');
INSERT INTO Country VALUES('MDA','Moldova','Eup');
INSERT INTO Country VALUES('MDG','Madagascar','Afr');
INSERT INTO Country VALUES('MDV','Maldives','Asia');
INSERT INTO Country VALUES('MEX','Mexico','NAme');
INSERT INTO Country VALUES('MHL','Marshall Islands','Oce');
INSERT INTO Country VALUES('MKD','Macedonia','Eup');
INSERT INTO Country VALUES('MLI','Mali','Afr');
INSERT INTO Country VALUES('MLT','Malta','Eup');
INSERT INTO Country VALUES('MMR','Myanmar','Asia');
INSERT INTO Country VALUES('MNG','Mongolia','Asia');
INSERT INTO Country VALUES('MNP','Northern Mariana Islands','Oce');
INSERT INTO Country VALUES('MOZ','Mozambique','Afr');
INSERT INTO Country VALUES('MRT','Mauritania','Afr');
INSERT INTO Country VALUES('MSR','Montserrat','NAme');
INSERT INTO Country VALUES('MTQ','Martinique','NAme');
INSERT INTO Country VALUES('MUS','Mauritius','Afr');
INSERT INTO Country VALUES('MWI','Malawi','Afr');
INSERT INTO Country VALUES('MYS','Malaysia','Asia');
INSERT INTO Country VALUES('MYT','Mayotte','Afr');
INSERT INTO Country VALUES('NAM','Namibia','Afr');
INSERT INTO Country VALUES('NCL','New Caledonia','Oce');
INSERT INTO Country VALUES('NER','Niger','Afr');
INSERT INTO Country VALUES('NFK','Norfolk Island','Oce');
INSERT INTO Country VALUES('NGA','Nigeria','Afr');
INSERT INTO Country VALUES('NIC','Nicaragua','NAme');
INSERT INTO Country VALUES('NIU','Niue','Oce');
INSERT INTO Country VALUES('NLD','Netherlands','Eup');
INSERT INTO Country VALUES('NOR','Norway','Eup');
INSERT INTO Country VALUES('NPL','Nepal','Asia');
INSERT INTO Country VALUES('NRU','Nauru','Oce');
INSERT INTO Country VALUES('NZL','New Zealand','Oce');
INSERT INTO Country VALUES('OMN','Oman','Asia');
INSERT INTO Country VALUES('PAK','Pakistan','Asia');
INSERT INTO Country VALUES('PAN','Panama','NAme');
INSERT INTO Country VALUES('PCN','Pitcairn','Oce');
INSERT INTO Country VALUES('PER','Peru','SAme');
INSERT INTO Country VALUES('PHL','Philippines','Asia');
INSERT INTO Country VALUES('PLW','Palau','Oce');
INSERT INTO Country VALUES('PNG','Papua New Guinea','Oce');
INSERT INTO Country VALUES('POL','Poland','Eup');
INSERT INTO Country VALUES('PRI','Puerto Rico','NAme');
INSERT INTO Country VALUES('PRK','North Korea','Asia');
INSERT INTO Country VALUES('PRT','Portugal','Eup');
INSERT INTO Country VALUES('PRY','Paraguay','SAme');
INSERT INTO Country VALUES('PSE','Palestine','Asia');
INSERT INTO Country VALUES('PYF','French Polynesia','Oce');
INSERT INTO Country VALUES('QAT','Qatar','Asia');
INSERT INTO Country VALUES('REU','Rï¿½ï¿½ï¿½union','Afr');
INSERT INTO Country VALUES('ROM','Romania','Eup');
INSERT INTO Country VALUES('RUS','Russian Federation','Eup');
INSERT INTO Country VALUES('RWA','Rwanda','Afr');
INSERT INTO Country VALUES('SAU','Saudi Arabia','Asia');
INSERT INTO Country VALUES('SDN','Sudan','Afr');
INSERT INTO Country VALUES('SEN','Senegal','Afr');
INSERT INTO Country VALUES('SGP','Singapore','Asia');
INSERT INTO Country VALUES('SGS','South Georgia and the South Sandwich Islands','Ant');
INSERT INTO Country VALUES('SHN','Saint Helena','Afr');
INSERT INTO Country VALUES('SJM','Svalbard and Jan Mayen','Eup');
INSERT INTO Country VALUES('SLB','Solomon Islands','Oce');
INSERT INTO Country VALUES('SLE','Sierra Leone','Afr');
INSERT INTO Country VALUES('SLV','El Salvador','NAme');
INSERT INTO Country VALUES('SMR','San Marino','Eup');
INSERT INTO Country VALUES('SOM','Somalia','Afr');
INSERT INTO Country VALUES('SPM','Saint Pierre and Miquelon','NAme');
INSERT INTO Country VALUES('STP','Sao Tome and Principe','Afr');
INSERT INTO Country VALUES('SUR','Suriname','SAme');
INSERT INTO Country VALUES('SVK','Slovakia','Eup');
INSERT INTO Country VALUES('SVN','Slovenia','Eup');
INSERT INTO Country VALUES('SWE','Sweden','Eup');
INSERT INTO Country VALUES('SWZ','Swaziland','Afr');
INSERT INTO Country VALUES('SYC','Seychelles','Afr');
INSERT INTO Country VALUES('SYR','Syria','Asia');
INSERT INTO Country VALUES('TCA','Turks and Caicos Islands','NAme');
INSERT INTO Country VALUES('TCD','Chad','Afr');
INSERT INTO Country VALUES('TGO','Togo','Afr');
INSERT INTO Country VALUES('THA','Thailand','Asia');
INSERT INTO Country VALUES('TJK','Tajikistan','Asia');
INSERT INTO Country VALUES('TKL','Tokelau','Oce');
INSERT INTO Country VALUES('TKM','Turkmenistan','Asia');
INSERT INTO Country VALUES('TMP','East Timor','Asia');
INSERT INTO Country VALUES('TON','Tonga','Oce');
INSERT INTO Country VALUES('TTO','Trinidad and Tobago','NAme');
INSERT INTO Country VALUES('TUN','Tunisia','Afr');
INSERT INTO Country VALUES('TUR','Turkey','Asia');
INSERT INTO Country VALUES('TUV','Tuvalu','Oce');
INSERT INTO Country VALUES('TWN','Taiwan','Asia');
INSERT INTO Country VALUES('TZA','Tanzania','Afr');
INSERT INTO Country VALUES('UGA','Uganda','Afr');
INSERT INTO Country VALUES('UKR','Ukraine','Eup');
INSERT INTO Country VALUES('UMI','United States Minor Outlying Islands','Oce');
INSERT INTO Country VALUES('URY','Uruguay','SAme');
INSERT INTO Country VALUES('USA','United States','NAme');
INSERT INTO Country VALUES('UZB','Uzbekistan','Asia');
INSERT INTO Country VALUES('VAT','Holy See (Vatican City State)','Eup');
INSERT INTO Country VALUES('VCT','Saint Vincent and the Grenadines','NAme');
INSERT INTO Country VALUES('VEN','Venezuela','SAme');
INSERT INTO Country VALUES('VGB','Virgin Islands, British','NAme');
INSERT INTO Country VALUES('VIR','Virgin Islands, U.S.','NAme');
INSERT INTO Country VALUES('VNM','Vietnam','Asia');
INSERT INTO Country VALUES('VUT','Vanuatu','Oce');
INSERT INTO Country VALUES('WLF','Wallis and Futuna','Oce');
INSERT INTO Country VALUES('WSM','Samoa','Oce');
INSERT INTO Country VALUES('YEM','Yemen','Asia');
INSERT INTO Country VALUES('YUG','Yugoslavia','Eup');
INSERT INTO Country VALUES('ZAF','South Africa','Afr');
INSERT INTO Country VALUES('ZMB','Zambia','Afr');
INSERT INTO Country VALUES('ZWE','Zimbabwe','Afr');

-- ===================================================
INSERT INTO Zone(ZoneCode, CountryCode, Description) 
VALUES('FN','CMR','Far North'),('NC','NGA','North Central'),('NE','NGA','North East'),('NW','NGA','North West'),('SE','NGA','South East'),('SS','NGA','South South'),('SW','NGA','South West');

-- ===================================================
/* insertinginto table LevelNames */
INSERT INTO LevelName(CountryCode, Level1name, Level2name, Level3name) 
VALUES ('NGA','state','lga','ward'),('CMR','Division','Subdivision','district');

-- ====================================================

/* inserting into Table AULevel1- State, Region. */
INSERT INTO AULevel1 
VALUES ('CMR','AD','Adamawa'),('CMR','CE','Centre'),('CMR','E','East'),
('CMR','EN','Extreme Nord'),('CMR','LT','Littoral'),('CMR','N','Nord'),
('CMR','NW','Northwest'),('CMR','OU','Ouest'),('CMR','regio','Region'),
('CMR','S','South'),('CMR','SW','Southwest'),('GHA','as','Ashanti Region'),
('GHA','br','Brong Ahafo Region'),('GHA','ct','Central Region'),
('GHA','et','Eastern Region'),('GHA','ga','Greater Accra Region'),
('GHA','nt','Northern Region'),('GHA','ue','Upper East Region'),
('GHA','uw','Upper West Region'),('GHA','vl','Volta Region'),
('GHA','wt','Western Region'),('NGA','AB','Abia'),('NGA','AD','Adamawa'),
('NGA','AI','Akwa ibom'),('NGA','AN','Anambra'),('NGA','BA','Bauchi'),
('NGA','BN','Benue'),('NGA','BO','Borno'),('NGA','BY','Bayelsa'),
('NGA','CR','Cross river'),('NGA','DT','Delta'),('NGA','EB','Ebonyi'),
('NGA','ED','Edo'),('NGA','EK','Ekiti'),('NGA','EN','Enugu'),('NGA','FC','Fct'),
('NGA','GB','Gombe'),('NGA','IM','Imo'),('NGA','JG','Jigawa'),('NGA','KB','Kebbi'),
('NGA','KD','Kaduna'),('NGA','KG','Kogi'),('NGA','KN','Kano'),
('NGA','KT','Katsina'),('NGA','KW','Kwara'),('NGA','LA','Lagos'),
('NGA','NG','Niger'),('NGA','NS','Nassarawa'),('NGA','OD','Ondo'),
('NGA','OG','Ogun'),('NGA','OS','Osun'),('NGA','OY','Oyo'),('NGA','PL','Plateau'),
('NGA','RV','Rivers'),('NGA','SO','Sokoto'),('NGA','state','State'),
('NGA','TR','Taraba'),('NGA','un','Unknown'),('NGA','YB','Yobe'),
('NGA','ZF','Zamfara');

-- ===================================================
/* inserting into Table AULevel -LGA's */

INSERT INTO AULevel2 VALUES ('CMR','regio','Division','div'),('NGA','AB','Aba North','1'),('NGA','AB','Ohafia','10'),('NGA','AB','Osisioma ngwa','11'),
('NGA','AB','Ugwunagbo','12'),('NGA','AB','Ukwa East','13'),('NGA','AB','Ukwa West','14'),('NGA','AB','Umuahia North','15'),('NGA','AB','Umuahia South','16'),
('NGA','AB','Umu-nneochi','17'),('NGA','AB','Aba South','2'),('NGA','AB','Arochukwu','3'),('NGA','AB','Bende','4'),('NGA','AB','Ikwuano','5'),
('NGA','AB','Isiala-Ngwa north','6'),('NGA','AB','Isiala-Ngwa south','7'),('NGA','AB','Isuikwuato','8'),('NGA','AB','Obin gwa','9'),('NGA','AD','Demsa','1'),
('NGA','AD','Madagali','10'),('NGA','AD','Maiha','11'),('NGA','AD','Mayo-Balewa','12'),('NGA','AD','Michika','13'),('NGA','AD','Mubi North','14'),
('NGA','AD','Mubi South','15'),('NGA','AD','Numan','16'),('NGA','AD','Shelleng','17'),('NGA','AD','Song','18'),('NGA','AD','tungo','19'),('NGA','AD','Furore','2'),
('NGA','AD','Yola  North','20'),('NGA','AD','Yola South','21'),('NGA','AD','Ganye','3'),('NGA','AD','Girei','4'),('NGA','AD','Gombi','5'),('NGA','AD','Guyuk','6'),
('NGA','AD','Hong','7'),('NGA','AD','Jada','8'),('NGA','AD','Lamurde','9'),('NGA','AI','Abak','1'),('NGA','AI','Ibiono Ibom','10'),('NGA','AI','Ika','11'),
('NGA','AI','Ikono','12'),('NGA','AI','Ikot Abasi','13'),('NGA','AI','Ikot Ekpene','14'),('NGA','AI','Ini','15'),('NGA','AI','Itu','16'),('NGA','AI','Mbo','17'),
('NGA','AI','Mkpat-Enin','18'),('NGA','AI','Nsit Atai','19'),('NGA','AI','Eastern Obolo','2'),('NGA','AI','Nsit Ubium','20'),('NGA','AI','Nsit Ubom','21'),
('NGA','AI','Obot Akara','22'),('NGA','AI','Okobo','23'),('NGA','AI','Onna','24'),('NGA','AI','Oron','25'),('NGA','AI','Oruk Anam','26'),('NGA','AI','Udong Uko','27'),
('NGA','AI','Ukanafun','28'),('NGA','AI','Uruan','29'),('NGA','AI','Eket','3'),('NGA','AI','Urue Offong Oruku','30'),('NGA','AI','Uyo','31'),
('NGA','AI','Esit Eket(UQUO)','4'),('NGA','AI','Essien-Udim','5'),('NGA','AI','Etim Ekpo','6'),('NGA','AI','Etinan','7'),('NGA','AI','Ibeno','8'),
('NGA','AI','Ibesikpo Asutan','9'),('NGA','AN','Aguata','1'),('NGA','AN','Idemili North','10'),('NGA','AN','Idemili South','11'),('NGA','AN','Ihiala','12'),
('NGA','AN','Njikoka','13'),('NGA','AN','Nnewi North','14'),('NGA','AN','Nnewi South','15'),('NGA','AN','Ogbaru','16'),('NGA','AN','Onitsha North','17'),
('NGA','AN','Onitsha South','18'),('NGA','AN','Orumba North','19'),('NGA','AN','Ayamelum','2'),('NGA','AN','Orumba South','20'),('NGA','AN','Oyi','21'),
('NGA','AN','Anambra East','3'),('NGA','AN','Anambra West','4'),('NGA','AN','Anaocha(Mbamili)','5'),('NGA','AN','Awka North','6'),('NGA','AN','Awka South','7'),
('NGA','AN','Dunkofia','8'),('NGA','AN','Ekwusigo','9'),('NGA','BA','Alkaleri','1'),('NGA','BA','Itas/Gadua','10'),('NGA','BA','Jama\'are','11'),('NGA','BA','Katagum','12'),
('NGA','BA','Kirfi','13'),('NGA','BA','Misau','14'),('NGA','BA','Ningi','15'),('NGA','BA','Shira','16'),('NGA','BA','Tafawa-Balewa','17'),('NGA','BA','Toro','18'),
('NGA','BA','Warji','19'),('NGA','BA','Bauchi','2'),('NGA','BA','Zaki','20'),('NGA','BA','Bogoro','3'),('NGA','BA','Damban','4'),('NGA','BA','Darazo','5'),
('NGA','BA','Dass','6'),('NGA','BA','Gamawa','7'),('NGA','BA','Ganjuwa','8'),('NGA','BA','Glade','9'),('NGA','BN','Ado','1'),('NGA','BN','Konshisha','10'),
('NGA','BN','Kwande','11'),('NGA','BN','Logo','12'),('NGA','BN','Makurdi','13'),('NGA','BN','Obi','14'),('NGA','BN','Ogbadibo','15'),('NGA','BN','Oju','16'),
('NGA','BN','Ohimini','17'),('NGA','BN','Okpokwu','18'),('NGA','BN','Oturkpo','19'),('NGA','BN','Aguta','2'),('NGA','BN','Tarka','20'),('NGA','BN','Ukum','21'),
('NGA','BN','Ushongo','22'),('NGA','BN','Vandeikya','23'),('NGA','BN','Apa','3'),('NGA','BN','Buruku','4'),('NGA','BN','Gboko','5'),('NGA','BN','Guma','6'),
('NGA','BN','Gwer East','7'),('NGA','BN','Gwer West','8'),('NGA','BN','Katsina-Ala','9'),('NGA','BO','Abadam','1'),('NGA','BO','Guzamala','10'),('NGA','BO','Gwoza','11'),
('NGA','BO','Hawul','12'),('NGA','BO','Jere','13'),('NGA','BO','Kaga','14'),('NGA','BO','Kala/Balge','15'),('NGA','BO','Konduga','16'),('NGA','BO','Kukawa','17'),
('NGA','BO','Kwaya-Kusar','18'),('NGA','BO','Mafa','19'),('NGA','BO','Askira/Uba','2'),('NGA','BO','Magumeri','20'),('NGA','BO','Maiduguri','21'),('NGA','BO','Marte','22'),
('NGA','BO','Mobbar','23'),('NGA','BO','Monguno','24'),('NGA','BO','Ngala','25'),('NGA','BO','Nganzai','26'),('NGA','BO','Shani','27'),('NGA','BO','Bama','3'),
('NGA','BO','Bayo','4'),('NGA','BO','Biu','5'),('NGA','BO','Chibok','6'),('NGA','BO','Damboa','7'),('NGA','BO','Dikwa','8'),('NGA','BO','Gubio','9'),('NGA','BY','Brass','1'),
('NGA','BY','Ekeremor','2'),('NGA','BY','Kolokume Opokuma','3'),('NGA','BY','Nembe','4'),('NGA','BY','Ogbai','5'),('NGA','BY','Sagbama','6'),('NGA','BY','Southern Ijaw','7'),
('NGA','BY','Yenagoa','8'),('NGA','CR','Abi','1'),('NGA','CR','Etung','10'),('NGA','CR','Ikom','11'),('NGA','CR','Obanliku','12'),('NGA','CR','Obubra','13'),
('NGA','CR','Obudu','14'),('NGA','CR','Odukpani','15'),('NGA','CR','Ogoja','16'),('NGA','CR','Yakurr','17'),('NGA','CR','Yala','18'),('NGA','CR','Akamkpa','2'),
('NGA','CR','Akpabuyo','3'),('NGA','CR','Bakassi','4'),('NGA','CR','Bekwarra','5'),('NGA','CR','Biase','6'),('NGA','CR','Boki','7'),('NGA','CR','Calabar-Municipal','8'),
('NGA','CR','Calabar-South','9'),('NGA','DT','Aniocha North','1'),('NGA','DT','Isoko South','10'),('NGA','DT','Ndokwa East','11'),('NGA','DT','Ndokwa West','12'),
('NGA','DT','Okpe','13'),('NGA','DT','Oshimilli North','14'),('NGA','DT','Oshimili South','15'),('NGA','DT','Patani','16'),('NGA','DT','Sapele','17'),('NGA','DT','Udu','18'),
('NGA','DT','Ugheli North','19'),('NGA','DT','Aniocha South','2'),('NGA','DT','Ugheli South','20'),('NGA','DT','Ukwuani','21'),('NGA','DT','Uvwie','22'),
('NGA','DT','Warri North','23'),('NGA','DT','Warri South','24'),('NGA','DT','Warri South West','25'),('NGA','DT','Bomadi','3'),('NGA','DT','Burutu','4'),
('NGA','DT','Ethiope East','5'),('NGA','DT','Ethiope West','6'),('NGA','DT','Ika North East','7'),('NGA','DT','Ika South','8'),('NGA','DT','Isoko North','9'),
('NGA','EB','Abakaliki','1'),('NGA','EB','Izzi','10'),('NGA','EB','Ohaozara','11'),('NGA','EB','Ohaukwu','12'),('NGA','EB','Onicha','13'),('NGA','EB','Afikpo North','2'),
('NGA','EB','Afikpo South','3'),('NGA','EB','Ebonyi','4'),('NGA','EB','Ezza North','5'),('NGA','EB','Ezza South','6'),('NGA','EB','Ikwo','7'),('NGA','EB','Ishielu','8'),
('NGA','EB','Ivo','9'),('NGA','ED','Akoko-Edo','1'),('NGA','ED','Iguegben','10'),('NGA','ED','Ikpoba Okha','11'),('NGA','ED','Oredo','12'),('NGA','ED','Orhionmwon','13'),
('NGA','ED','Ovia North East','14'),('NGA','ED','Ovia South West','15'),('NGA','ED','Owan East','16'),('NGA','ED','Owan West','17'),('NGA','ED','Ohunmwonde','18'),
('NGA','ED','agbor','2'),('NGA','ED','Esan Central','3'),('NGA','ED','Esan North East','4'),('NGA','ED','Esan South East','5'),('NGA','ED','Esan West','6'),
('NGA','ED','Etsako Central','7'),('NGA','ED','Etsako East','8'),('NGA','ED','Etsako West','9'),('NGA','EK','Ado Ekiti','1'),('NGA','EK','Ikere','10'),
('NGA','EK','Ikole','11'),('NGA','EK','Ilejemeje','12'),('NGA','EK','Irepodun/Ifelodun','13'),('NGA','EK','Ise/Orun','14'),('NGA','EK','Moba','15'),
('NGA','EK','Oye','16'),('NGA','EK','Efon','2'),('NGA','EK','Ekiti East','3'),('NGA','EK','Ekiti West','4'),('NGA','EK','Ekiti South West','5'),('NGA','EK','Emure','6'),
('NGA','EK','Gboyin','7'),('NGA','EK','Ido-Osi','8'),('NGA','EK','Ijero','9'),('NGA','EN','Aninri','1'),('NGA','EN','Isi-Uzo','10'),('NGA','EN','Nkanu East','11'),
('NGA','EN','Nkanu West','12'),('NGA','EN','Nsukka','13'),('NGA','EN','Oji-River','14'),('NGA','EN','Udenu','15'),('NGA','EN','Udi','16'),('NGA','EN','Uzo-Uwani','17'),
('NGA','EN','Awgu','2'),('NGA','EN','Enugu East','3'),('NGA','EN','Enugu North','4'),('NGA','EN','Enugu South','5'),('NGA','EN','Ezeagu','6'),('NGA','EN','Igbo-Etiti','7'),
('NGA','EN','Igbo-Eze North','8'),('NGA','EN','Igbo-Eze South','9'),('NGA','FC','Abaji','1'),('NGA','FC','Enugu - Bwari','2'),('NGA','FC','Gwagwalada','3'),
('NGA','FC','Kuje','4'),('NGA','FC','Kwali','5'),('NGA','FC','Municipal','6'),('NGA','GB','Akko','1'),('NGA','GB','Shongom','10'),('NGA','GB','Yamaltu/Deba','11'),
('NGA','GB','Balanga','2'),('NGA','GB','Billiri','3'),('NGA','GB','Dukku','4'),('NGA','GB','Funakaye','5'),('NGA','GB','Gombe','6'),('NGA','GB','Kultungo','7'),
('NGA','GB','Kwami','8'),('NGA','GB','Nafada','9'),('NGA','IM','Aboh-Mbaise','1'),('NGA','IM','Isu','10'),('NGA','IM','Mbaitoli(nwaorieubi)','11'),
('NGA','IM','Ngor-Okpala','12'),('NGA','IM','Njaba(nnenasa)','13'),('NGA','IM','Nwangele(Onu-Nwangele)','14'),('NGA','IM','Nkwere','15'),('NGA','IM','Obowo(Otoko)','16'),
('NGA','IM','Oguta','17'),('NGA','IM','Ohaji Egbema(Nnahu-Egbema)','18'),('NGA','IM','Okigwe','19'),('NGA','IM','Ahiazu Mbaise','2'),('NGA','IM','Onuimo(Okwe)','20'),
('NGA','IM','Orlu','21'),('NGA','IM','Orsu (Awo-Idemili)','22'),('NGA','IM','Oru East(Awo-Omamma)','23'),('NGA','IM','Orsu West(MGBIDI)','24'),
('NGA','IM','Owerri Urban (Owerri)','25'),('NGA','IM','Owerri North(Orie Uratta)','26'),('NGA','IM','Owerri West(Umuguma)','27'),('NGA','IM','Ehime mbano','3'),
('NGA','IM','Ezinhitte(mbaise)','4'),('NGA','IM','Ideato North','5'),('NGA','IM','Ideato South','6'),('NGA','IM','Ihitte/Uboma(Isinneke)','7'),('NGA','IM','Ikeduru(Iho)','8'),
('NGA','IM','Isiala Mbano(umuelemai)','9'),('NGA','JG','Auyo','1'),('NGA','JG','Guri','10'),('NGA','JG','Gwaram','11'),('NGA','JG','Gwiwa','12'),('NGA','JG','Hadejia','13'),
('NGA','JG','Jahun','14'),('NGA','JG','Kafin Hausa','15'),('NGA','JG','Kaugama','16'),('NGA','JG','Kazaure','17'),('NGA','JG','KiriKasamma','18'),('NGA','JG','Kiyawa','19'),
('NGA','JG','Babura','2'),('NGA','JG','Maigatari','20'),('NGA','JG','Malam Maduri','21'),('NGA','JG','Miga','22'),('NGA','JG','Rinim','23'),('NGA','JG','Roni','24'),
('NGA','JG','Sule Tarkarakar','25'),('NGA','JG','Taura','26'),('NGA','JG','Yankwashi','27'),('NGA','JG','Birnin Kudu','3'),('NGA','JG','Birniwa','4'),('NGA','JG','Buji','5'),
('NGA','JG','Dutshe','6'),('NGA','JG','Garki','7'),('NGA','JG','Gagarawa','8'),('NGA','JG','Gumel','9'),('NGA','KB','Aleiro','1'),('NGA','KB','Gwandu','10'),
('NGA','KB','Jega','11'),('NGA','KB','Kalgo','12'),('NGA','KB','Koko/Besse','13'),('NGA','KB','Maiyama','14'),('NGA','KB','Ngaski','15'),('NGA','KB','Sakaba','16'),
('NGA','KB','Shanga','17'),('NGA','KB','Suru','18'),('NGA','KB','Wasagu/Danko','19'),('NGA','KB','Arewa-Dandi','2'),('NGA','KB','Yauri','20'),('NGA','KB','Zuru','21'),
('NGA','KB','Argungu','3'),('NGA','KB','Augie','4'),('NGA','KB','Bagudo','5'),('NGA','KB','Birnin Kebbi','6'),('NGA','KB','Bunza','7'),('NGA','KB','Dandi','8'),
('NGA','KB','Fakai','9'),('NGA','KD','Birnin-Gwari','1'),('NGA','KD','Kaduna South','10'),('NGA','KD','Kagarko','11'),('NGA','KD','Kajuru','12'),('NGA','KD','Kaura','13'),
('NGA','KD','Kauru','14'),('NGA','KD','Kubau','15'),('NGA','KD','Kudan','16'),('NGA','KD','Lere','17'),('NGA','KD','Makarfi','18'),('NGA','KD','Sabon Gari','19'),
('NGA','KD','Chikun','2'),('NGA','KD','Sanga','20'),('NGA','KD','Soba','21'),('NGA','KD','Zagon-Kataf','22'),('NGA','KD','Zaria','23'),('NGA','KD','Giwa','3'),
('NGA','KD','Igabi','4'),('NGA','KD','Ikara','5'),('NGA','KD','Jaba','6'),('NGA','KD','Jema\'a','7'),('NGA','KD','Kachia','8'),('NGA','KD','Kaduna North','9'),
('NGA','KG','Adavi','1'),('NGA','KG','Kabba/bunu','10'),('NGA','KG','Kogi(k.k)','11'),('NGA','KG','Lokoja','12'),('NGA','KG','Mopa-muro','13'),('NGA','KG','Ofu','14'),
('NGA','KG','Ogorimagongo','15'),('NGA','KG','Okehi','16'),('NGA','KG','Okene','17'),('NGA','KG','Olamaboro','18'),('NGA','KG','Omala','19'),('NGA','KG','Ajaokuta','2'),
('NGA','KG','Yagba East','20'),('NGA','KG','Yagba West','21'),('NGA','KG','Ankpa','3'),('NGA','KG','Bassa','4'),('NGA','KG','Dekina','5'),('NGA','KG','Ibaji','6'),
('NGA','KG','Idah','7'),('NGA','KG','Igalamela-Odolu','8'),('NGA','KG','Ijumu','9'),('NGA','KN','Ajingi','1'),('NGA','KN','Dawakin Tofa','10'),('NGA','KN','Doguwa','11'),
('NGA','KN','Fagge','12'),('NGA','KN','Gabasawa','13'),('NGA','KN','Garko','14'),('NGA','KN','Garum Mallam','15'),('NGA','KN','Gaya','16'),('NGA','KN','Gezawa','17'),
('NGA','KN','Gwale','18'),('NGA','KN','Gwarzo','19'),('NGA','KN','Albasu','2'),('NGA','KN','Kabo','20'),('NGA','KN','Kano Municipal','21'),('NGA','KN','Karaye','22'),
('NGA','KN','Kibiya','23'),('NGA','KN','Kiru','24'),('NGA','KN','Kumbotso','25'),('NGA','KN','Kunchi','26'),('NGA','KN','Kura','27'),('NGA','KN','Makoda','28'),
('NGA','KN','Minjibir','29'),('NGA','KN','Bagwai','3'),('NGA','KN','Madobi','30'),('NGA','KN','Nassarawa','31'),('NGA','KN','Rano','32'),('NGA','KN','Rimin Gado','33'),
('NGA','KN','Rogo','34'),('NGA','KN','Shanono','35'),('NGA','KN','Sumaila','36'),('NGA','KN','Takai','37'),('NGA','KN','Tarauni','38'),('NGA','KN','Tofa','39'),
('NGA','KN','Bebeji','4'),('NGA','KN','Tudun Wada','40'),('NGA','KN','Tsanyawa','41'),('NGA','KN','Ungogo','42'),('NGA','KN','Warawa','43'),('NGA','KN','Wudil','44'),
('NGA','KN','Bichi','5'),('NGA','KN','Bunkure','6'),('NGA','KN','Dala','7'),('NGA','KN','Dambatta','8'),('NGA','KN','Dawakin Kudu','9'),('NGA','KT','Bakori','1'),
('NGA','KT','Daura','10'),('NGA','KT','Dutsi','11'),('NGA','KT','Dutsin-ma','12'),('NGA','KT','Faskari','13'),('NGA','KT','Funtua','14'),('NGA','KT','Ingawa','15'),
('NGA','KT','Jibiya','16'),('NGA','KT','Kafur','17'),('NGA','KT','Kaita','18'),('NGA','KT','Kankara','19'),('NGA','KT','Batagarawa','2'),('NGA','KT','Kankia','20'),
('NGA','KT','Katsina','21'),('NGA','KT','Kurfi','22'),('NGA','KT','Kusada','23'),('NGA','KT','Mai\'adua','24'),('NGA','KT','Malumfashi','25'),('NGA','KT','Mani','26'),
('NGA','KT','Mashi','27'),('NGA','KT','Matazu','28'),('NGA','KT','Musawa','29'),('NGA','KT','Batsari','3'),('NGA','KT','Rimi','30'),('NGA','KT','Sabuwa','31'),
('NGA','KT','Safana','32'),('NGA','KT','Sandamu','33'),('NGA','KT','Zango','34'),('NGA','KT','Baure','4'),('NGA','KT','Bindawa','5'),('NGA','KT','Charanchi','6'),
('NGA','KT','Dandume','7'),('NGA','KT','Danja','8'),('NGA','KT','Dan musa','9'),('NGA','KW','Asa','1'),('NGA','KW','Isin','10'),('NGA','KW','Kaiama','11'),
('NGA','KW','Moro','12'),('NGA','KW','Offa','13'),('NGA','KW','Oke-Ero','14'),('NGA','KW','Oyun','15'),('NGA','KW','Pategi','16'),('NGA','KW','Baruten','2'),
('NGA','KW','Edu','3'),('NGA','KW','Ekiti','4'),('NGA','KW','Ifelodun','5'),('NGA','KW','Ilorin East','6'),('NGA','KW','Ilorin South','7'),('NGA','KW','Ilorin West','8'),
('NGA','KW','Irepodun','9'),('NGA','LA','Agege','1'),('NGA','LA','Ifako/Ijaye','10'),('NGA','LA','Ikeja','11'),('NGA','LA','Ikorodu','12'),('NGA','LA','Kosofe','13'),
('NGA','LA','Lagos Island','14'),('NGA','LA','Lagos Mainland','15'),('NGA','LA','Mushin','16'),('NGA','LA','Ojoo','17'),('NGA','LA','Oshodi Isolo','18'),
('NGA','LA','Somolu','19'),('NGA','LA','Ajeromi/Ifelodun','2'),('NGA','LA','Surulere','20'),('NGA','LA','Alimosho','3'),('NGA','LA','Amuwo Odofin','4'),
('NGA','LA','Apapa','5'),('NGA','LA','Badagry','6'),('NGA','LA','Epe','7'),('NGA','LA','Etiosa','8'),('NGA','LA','Ibeju Lekki','9'),('NGA','NG','Agaie','1'),
('NGA','NG','Katcha','10'),('NGA','NG','Kontagora','11'),('NGA','NG','Lapai','12'),('NGA','NG','Lavun','13'),('NGA','NG','Magama','14'),('NGA','NG','Mariga','15'),
('NGA','NG','Mashegu','16'),('NGA','NG','Mokwa','17'),('NGA','NG','Muya','18'),('NGA','NG','Paikoro','19'),('NGA','NG','Agwara','2'),('NGA','NG','Rafi','20'),
('NGA','NG','Rijau','21'),('NGA','NG','Shiroro','22'),('NGA','NG','Suleja','23'),('NGA','NG','Tafa','24'),('NGA','NG','Wushishi','25'),('NGA','NG','Bida','3'),
('NGA','NG','Borgu','4'),('NGA','NG','Bosso','5'),('NGA','NG','Chanchaga','6'),('NGA','NG','Edati','7'),('NGA','NG','Gbako','8'),('NGA','NG','Gurara','9'),
('NGA','NS','Akwanga','1'),('NGA','NS','Nasarawa-Eggon','10'),('NGA','NS','Obi','11'),('NGA','NS','Toto','12'),('NGA','NS','Wamba','13'),('NGA','NS','Awe','2'),
('NGA','NS','Doma','3'),('NGA','NS','Karu','4'),('NGA','NS','Keana','5'),('NGA','NS','Keffi','6'),('NGA','NS','Kokona','7'),('NGA','NS','Lafia','8'),
('NGA','NS','Nassarawa','9'),('NGA','OD','Akoko North-East','1'),('NGA','OD','Ilaje','10'),('NGA','OD','Ile-Oluji Okeigbo','11'),('NGA','OD','Irele','12'),
('NGA','OD','Odigbo','13'),('NGA','OD','Okitipupa','14'),('NGA','OD','Ondo East','15'),('NGA','OD','Ondo West','16'),('NGA','OD','Ose','17'),('NGA','OD','Owo','18'),
('NGA','OD','Akoko North-West','2'),('NGA','OD','Akoko South East','3'),('NGA','OD','Akoko South West','4'),('NGA','OD','Akure North','5'),('NGA','OD','Akure South','6'),
('NGA','OD','Ese-odo','7'),('NGA','OD','Idanre','8'),('NGA','OD','Ifedore','9'),('NGA','OG','Abeokuta North','1'),('NGA','OG','Ijebu North East','10'),
('NGA','OG','Ijebu Ode','11'),('NGA','OG','Ikenne','12'),('NGA','OG','Afon','13'),('NGA','OG','Ipokia','14'),('NGA','OG','Obafemi Owode','15'),('NGA','OG','Odedah','16'),
('NGA','OG','Odogbolu','17'),('NGA','OG','Ogun waterside','18'),('NGA','OG','Remo North','19'),('NGA','OG','Abeokuta South','2'),('NGA','OG','Shagamu','20'),
('NGA','OG','Ado Odo/Ota','3'),('NGA','OG','Egbado North','4'),('NGA','OG','Egbado South','5'),('NGA','OG','Ewekoro','6'),('NGA','OG','Ifo','7'),('NGA','OG','Ijebu East','8'),
('NGA','OG','Ijebu North','9'),('NGA','OS','Atakumosa-East','1'),('NGA','OS','Ejigbo','10'),('NGA','OS','Ife Central','11'),('NGA','OS','Ifedayo','12'),
('NGA','OS','Ife East','13'),('NGA','OS','Ifelodun','14'),('NGA','OS','Ife North','15'),('NGA','OS','Ife South','16'),('NGA','OS','Ila','17'),
('NGA','OS','Ilesha East','18'),('NGA','OS','Ilesha West','19'),('NGA','OS','Atakumosa-West','2'),('NGA','OS','Irepodun','20'),('NGA','OS','Irewole','21'),
('NGA','OS','Isokan','22'),('NGA','OS','Iwo','23'),('NGA','OS','Obokun','24'),('NGA','OS','Odo-Otin','25'),('NGA','OS','Ola-oluwa','26'),('NGA','OS','Olorunda','27'),
('NGA','OS','Oriade','28'),('NGA','OS','Orolu','29'),('NGA','OS','Ayedaade','3'),('NGA','OS','Oshogbo','30'),('NGA','OS','Ayedire','4'),('NGA','OS','Boluwa-duro','5'),
('NGA','OS','Boripe','6'),('NGA','OS','Ede North','7'),('NGA','OS','Ede South','8'),('NGA','OS','Egbedore','9'),('NGA','OY','Afijio','1'),('NGA','OY','Ibadan South West','10'),
('NGA','OY','Ibarapa Central','11'),('NGA','OY','Ibarapa East','12'),('NGA','OY','Ibarapa North','13'),('NGA','OY','Iddo','14'),('NGA','OY','Irepo','15'),
('NGA','OY','Iseyin','16'),('NGA','OY','Itesiwaju','17'),('NGA','OY','Iwajowa','18'),('NGA','OY','Kajola','19'),('NGA','OY','Akinyele','2'),('NGA','OY','Lagelu','20'),
('NGA','OY','Ogbomosho North','21'),('NGA','OY','Ogbomosho South','22'),('NGA','OY','Ogo Oluwa','23'),('NGA','OY','Olorunsogo','24'),('NGA','OY','Oluyole','25'),
('NGA','OY','Ona Ara','26'),('NGA','OY','Oorelope','27'),('NGA','OY','Ori Ire','28'),('NGA','OY','Oyo East','29'),('NGA','OY','Atiba','3'),('NGA','OY','Oyo West','30'),
('NGA','OY','Saki East','31'),('NGA','OY','saki West','32'),('NGA','OY','Surulere','33'),('NGA','OY','Atisbo','4'),('NGA','OY','Egbeda','5'),('NGA','OY','Ibadan North','6'),
('NGA','OY','Ibadan North East','7'),('NGA','OY','Ibadan North West','8'),('NGA','OY','Ibadan South East','9'),('NGA','PL','Barikin Ladi','1'),('NGA','PL','Langtang-South','10'),
('NGA','PL','Mangu','11'),('NGA','PL','Mikang','12'),('NGA','PL','Pankshin','13'),('NGA','PL','Qua\'anpan','14'),('NGA','PL','Riyom','15'),('NGA','PL','Shendam','16'),
('NGA','PL','Wase','17'),('NGA','PL','Bassa','2'),('NGA','PL','Bokkos','3'),('NGA','PL','Jos East','4'),('NGA','PL','Jos North','5'),('NGA','PL','Jos South','6'),
('NGA','PL','Kanam','7'),('NGA','PL','Kanke','8'),('NGA','PL','Langtang-North','9'),('NGA','RV','Abua/Odual','1'),('NGA','RV','Emuohua','10'),('NGA','RV','Etchie','11'),
('NGA','RV','Gokana','12'),('NGA','RV','Ikwerre','13'),('NGA','RV','Khana','14'),('NGA','RV','Obia/ Akpor','15'),('NGA','RV','Ogba/Egbema/Ndoni','16'),
('NGA','RV','Ogu/Bolo','17'),('NGA','RV','Okrika','18'),('NGA','RV','Omumma','19'),('NGA','RV','Ahoada East','2'),('NGA','RV','Opobo/Nkoro','20'),('NGA','RV','Oyigbo','21'),
('NGA','RV','Port- Harcourt','22'),('NGA','RV','Tai','23'),('NGA','RV','Ahoada West','3'),('NGA','RV','Akuku Toru','4'),('NGA','RV','Andoni','5'),('NGA','RV','Asari-Toru','6'),
('NGA','RV','Bonny','7'),('NGA','RV','Degema','8'),('NGA','RV','Eleme','9'),('NGA','SO','Binji','1'),('NGA','SO','Kware','10'),('NGA','SO','Kebbe','11'),
('NGA','SO','Rabah','12'),('NGA','SO','Sabon Birni','13'),('NGA','SO','Shagari','14'),('NGA','SO','Silame','15'),('NGA','SO','Sokoto North','16'),
('NGA','SO','Sokoto South','17'),('NGA','SO','Tambuwal','18'),('NGA','SO','Tangaza','19'),('NGA','SO','Bodinga','2'),('NGA','SO','Tureta','20'),
('NGA','SO','Wamakko','21'),('NGA','SO','Wurno','22'),('NGA','SO','Yabo','23'),('NGA','SO','Dange-Shuni','3'),('NGA','SO','Gada','4'),('NGA','SO','Goronyo','5'),
('NGA','SO','Gudu','6'),('NGA','SO','Gwadabawa','7'),('NGA','SO','Illela','8'),('NGA','SO','Isa','9'),('NGA','state','Local Gvernment Area','lga'),
('NGA','TR','Ardo -Kola','1'),('NGA','TR','Lau','10'),('NGA','TR','Sarduana','11'),('NGA','TR','Takum','12'),('NGA','TR','Ussa','13'),('NGA','TR','Wukari','14'),
('NGA','TR','Yorro','15'),('NGA','TR','Zing','16'),('NGA','TR','Bali','2'),('NGA','TR','Donga','3'),('NGA','TR','Gashaka','4'),('NGA','TR','Gassol','5'),
('NGA','TR','Ibi','6'),('NGA','TR','Jalingo','7'),('NGA','TR','Karim-Lamido','8'),('NGA','TR','Kurmi','9'),('NGA','YB','Bade','1'),('NGA','YB','Karasuwa','10'),
('NGA','YB','Machina','11'),('NGA','YB','Nangere','12'),('NGA','YB','Nguru','13'),('NGA','YB','Potiskum','14'),('NGA','YB','Tarmua','15'),('NGA','YB','Yunusari','16'),
('NGA','YB','Yusufari','17'),('NGA','YB','Borsari','2'),('NGA','YB','Damaturu','3'),('NGA','YB','Fika','4'),('NGA','YB','Fune','5'),('NGA','YB','Geidam','6'),
('NGA','YB','Gujba','7'),('NGA','YB','Gulani','8'),('NGA','YB','Jakusko','9'),('NGA','ZF','Anka','1'),('NGA','ZF','Maru','10'),('NGA','ZF','Shinkafi','11'),
('NGA','ZF','Talata Mafara','12'),('NGA','ZF','Tsafe','13'),('NGA','ZF','Zurmi','14'),('NGA','ZF','Bakura','2'),('NGA','ZF','Birnin Magaji','3'),('NGA','ZF','Bukkuyum','4'),
('NGA','ZF','Bungudu','5'),('NGA','ZF','Gummi','6'),('NGA','ZF','Gusau','7'),('NGA','ZF','Kaura Namoda','8'),('NGA','ZF','Maradun','9');

-- ==================================================================
INSERT INTO Facility(FacilityTypeID,Name,FacilityStatusID,ServiceTypeID)
VALUES('HOS','GENERAL HOSPITAL ABJ','act','MEDS');
-- ==========================================================
INSERT INTO HumanRespondent(Surname,OtherNames,Sex,DateOfBirth,MaritalID)
VALUES('Ann','Tonia','F','2000/11/11','S');
-- ==============================================
INSERT INTO `User`
VALUES('password','Tonia','Zino','act','ADMIN','Mark');
-- ===========================================================

INSERT INTO TeamMember
VALUES('A','Tonia','LAP','Tonia');
-- ===============================================
INSERT INTO Respondent(DateVisited,Description,FacilityID,HumanID) 
VALUES(now(),'male',1,1);
-- ==============================================





