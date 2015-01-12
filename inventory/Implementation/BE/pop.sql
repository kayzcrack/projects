set foreign_key_checks = 0;
truncate Brand;
set foreign_key_checks = 1;
insert into Brand values('HP','Hewlett Park'),('Len','Lenovo'),('Dell','Dell'),('Tosh','Toshiba'),('Son','Sony');
-- --------------------
set foreign_key_checks = 0;
truncate Model;
set foreign_key_checks = 1;
insert into Model values('HP','HP 620','HP 620'),('HP','HP 655','HP 655'),('Dell','Latitude E6410','Latitude E6410');
-- --------------------
set foreign_key_checks = 0;
truncate RequestStatus;
set foreign_key_checks = 1;

insert into RequestStatus values('APP','Approved'),('DEC','Declined');
-- ---------------------------
set foreign_key_checks = 0;
truncate AuthorizedStatus;
set foreign_key_checks = 1;

insert into AuthorizedStatus values('AUTH','Authorized'),('DEC','Declined');

-- ---------------------------
set foreign_key_checks = 0;
truncate FunctionalStatus;
set foreign_key_checks = 1;

insert into FunctionalStatus values('FUNC','Functional'),('FAULTY','Faulty');

-- -------------------------
set foreign_key_checks = 0;
truncate AvailableStatus;
set foreign_key_checks = 1;

insert into AvailableStatus values('AVAIL','Available'),('NAVAIL','Not Available');
-- ------------------------
set foreign_key_checks = 0;
truncate Category;
set foreign_key_checks = 1;

insert into Category values('EQUIP','Equipment',''),('STAT','Stationary',''),('TOIL','Toiletories',''),('OTHER','Others','');
-- -----------------------
set foreign_key_checks = 0;
truncate PermissionType;
set foreign_key_checks = 1;

insert into PermissionType values('RRES','Request Response'),('AREQ','Authenticate Request'),('MANU','Manage User'),('MANP','Manage Product'),('MANR','Manage Report'),('MREQ','Make Request');
-- ------------------------
set foreign_key_checks = 0;
truncate UserRole;
set foreign_key_checks = 1;

insert into UserRole values('ADMIN','Admin',''),('USER','User',''),('PHEAD','Practice Head',''),('SUPER','Super User','');
-- ------------------------
set foreign_key_checks = 0;
truncate Department;
set foreign_key_checks = 1;

insert into Department values('QRSD','Quanteq Research And System Development');
insert into Department values('QES','Quanteq Enterprise Solution');
insert into Department values('QIBS','Quanteq Enterprise Business Solution');
insert into Department values('QCTS','Quanteq Consulting And Training Services');
-- ------------------------
set foreign_key_checks = 0;
truncate Permission;
set foreign_key_checks = 1;

insert into Permission values('AREQ','PHEAD');
insert into Permission values('MANP','ADMIN');
insert into Permission values('MANU','ADMIN');
insert into Permission values('MANR','ADMIN');
insert into Permission values('RRES','ADMIN');
insert into Permission values('MREQ','ADMIN');
insert into Permission values('MREQ','USER');
insert into Permission values('AREQ','SUPER');
insert into Permission values('MANP','SUPER');
insert into Permission values('MANU','SUPER');
insert into Permission values('MANR','SUPER');
insert into Permission values('RRES','SUPER');
insert into Permission values('MREQ','SUPER');

