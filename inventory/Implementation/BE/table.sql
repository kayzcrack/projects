drop database if exists inventory;
create database inventory;
use inventory;
-- ---------------------------------
set foreign_key_checks =0;
drop table if exists Brand;
set foreign_key_checks =1;

create table Brand(
BrandID char(5) Not Null,
Name varchar(32),
primary key(BrandID));
-- --------------------------------
set foreign_key_checks =0;
drop table if exists Purpose;
set foreign_key_checks =1;

create table Purpose(
Id char(5) Not Null,
Name varchar(16) Not NUll,
Primary key(Id)
);
-- --------------------------------
set foreign_key_checks =0;
drop table if exists Model;
set foreign_key_checks =1;

create table Model(
BrandID char(5) Not Null,
ModelID char(32) Not Null,
Name varchar(32),
primary key(ModelID),
foreign key(BrandID) references Brand(BrandID) on delete no action on update cascade);
-- ---------------------------------
set foreign_key_checks =0;
drop table if exists RequestStatus;
set foreign_key_checks =1;

create table RequestStatus(
RequestStatusID char(8) not null,
Description varchar(16),
constraint pk_RequestStatus primary key(RequestStatusID)
);

-- -----------------------------------
set foreign_key_checks =0;
drop table if exists AuthorizedStatus;
set foreign_key_checks =1;

create table AuthorizedStatus(
AuthorizedStatusID char(8) not null,
Description varchar(16),
constraint pk_AuthorizedStatus primary key(AuthorizedStatusID)
);

-- ----------------------------------
set foreign_key_checks =0;
drop table if exists FunctionalStatus;
set foreign_key_checks =1;

create table FunctionalStatus(
FunctionalStatusID char(8) not null,
Description varchar(16),
constraint pk_FunctionalStatus primary key(FunctionalStatusID)
);

-- ---------------------------------
set foreign_key_checks =0;
drop table if exists AvailableStatus;
set foreign_key_checks =1;

create table AvailableStatus(
AvailableStatusID char(8) not null,
Description varchar(16),
constraint pk_AvailableStatus primary key(AvailableStatusID) 
);

-- ---------------------------------
set foreign_key_checks =0;
drop table if exists  Category;
set foreign_key_checks =1;

create table Category(
CategoryID char(8) not null,
CategoryName varchar(32),
Description varchar(64),
constraint pk_Category primary key(CategoryID) 
);

-- --------------------------------
set foreign_key_checks =0;
drop table if exists PermissionType;
set foreign_key_checks =1;

create table PermissionType(
PermissionTypeID char(8) not null,
PermissionName varchar(16),
constraint pk_PermissioType primary key(PermissionTypeID) 
);

-- -------------------------------
set foreign_key_checks =0;
drop table if exists UserRole;
set foreign_key_checks =1;

create table UserRole(
RoleID char(8) not null,
RoleName varchar(32),
Description varchar(64),
constraint pk_UserRole primary key(RoleID) 
);

-- --------------------------------
set foreign_key_checks =0;
drop table if exists Department;
set foreign_key_checks =1;

create table Department(
DepartmentID char(5) not null,
DepartmentName varchar(64),
constraint pk_Department primary key(DepartmentID) 
);

-- --------------------------------
set foreign_key_checks =0;
drop table if exists Staff;
set foreign_key_checks =1;

create table Staff(
StaffID varchar(16) not null,
Surname varchar(32) not null,
Firstname varchar(32) not null,
DepartmentID char(5) not null,
Username varchar(32) not null,
Email varchar(64) not null,
Password varchar(255) not null,
RoleID char(8) not null,
constraint pk_Staff primary key(StaffID),
constraint fk_Staff_UserRole Foreign key(RoleID) references UserRole(RoleID) on delete no action on update cascade,
constraint fk_Staff_Department foreign key(DepartmentID) references Department(DepartmentID) on delete no action on update cascade
);

-- --------------------------------
set foreign_key_checks =0;
drop table if exists Request;
set foreign_key_checks =1;

create table Request(
RequestID int not null auto_increment,
StaffID varchar(16) not null,
ProductName varchar(32) not null,
RequestDate Date not null,
Model varchar(32),
Purpose varchar(32) not null,
Quantity varchar(32) not null,
CategoryID char(8),
Comment varchar(64),
ExpectedDateOfCollection Date,
constraint pk_Request primary key(RequestID),
constraint fk_Request_Staff foreign key(StaffID) references Staff(StaffID) on delete no action on update cascade
);

-- -------------------------------
set foreign_key_checks =0;
drop table if exists RequestResponse;
set foreign_key_checks =1;

create table RequestResponse(
RequestID int not null,
StaffID  varchar(16) not null,
StatusID char(8),
AvailableDate Date,
constraint pk_RequestResponse primary key(RequestID),
constraint fk_RequestResponse_Staff foreign key(StaffID) references Staff(StaffID) on delete no action on update cascade,
constraint fk_RequestResponse_RequestStatus foreign key(StatusID) references RequestStatus(RequestStatusID) on delete no action on update cascade
);

-- -------------------------------
set foreign_key_checks =0;
drop table if exists AuthorizedRequest;
set foreign_key_checks =1;

create table AuthorizedRequest(
RequestID int not null,
StaffID varchar(16),
AuthorizedStatusID char(8),
Comment varchar(128),
constraint pk_AuthorizedRequest primary key(RequestID),
constraint fk_AuthorizedRequest_RequestRespesponse foreign key(RequestID) references RequestResponse(RequestID) on delete no action on update cascade,
constraint fk_AuthorizedRequest_Staff foreign key(StaffID) references Staff(StaffID) on delete no action on update cascade,
constraint fk_AuthorizedRequest_AuthorizedStatus foreign key(AuthorizedStatusID) references AuthorizedStatus(AuthorizedStatusID) on delete no action on update cascade
);
-- -----------------------------
set foreign_key_checks =0;
drop table if exists `Return`;
set foreign_key_checks =1;

create table `Return`(
RequestID int not null,
ReturnDate Date,
`Comment` varchar(128) not null,
constraint pk_Return primary key(RequestID),
constraint fk_Return_AuthorizedRequest foreign key(RequestID) references AuthorizedRequest(RequestID) on delete no action on update cascade
);

-- ----------------------------
set foreign_key_checks =0;
drop table if exists UserLogin;
set foreign_key_checks =1;

create table UserLogin(
StaffID varchar(16) not null,
LoginTime Datetime not null default '0000-00-00 00:00:00',
LogoutTime Datetime,
constraint pk_UserLogin primary key(StaffID,LoginTime),
constraint fk_UserLogin foreign key(StaffID) references Staff(StaffID) on delete no action on update cascade
);

-- ---------------------------
set foreign_key_checks =0;
drop table if exists Product;
set foreign_key_checks =1;

create table Product(
ProductCode varchar(16) not null,
ProductName varchar(32) not null,
BrandID char(5),
ModelID char(32),
SerialNumber varchar(32),
CategoryID char(8),
FunctionalStatusID char(8),
AvailableStatusID char(8),
DateOfPurchased date,
constraint pk_Product primary key(ProductCode),
foreign key(BrandID) references Brand(BrandID) on delete no action on update cascade,
foreign key(ModelID) references Model(ModelID) on delete no action on update cascade,
constraint fk_Product_FunctionalStatus foreign key(FunctionalStatusID) references FunctionalStatus(FunctionalStatusID) on delete no action on update cascade,
constraint fk_Product_AvailableStatus foreign key(AvailableStatusID) references AvailableStatus(AvailableStatusID) on delete no action on update cascade 
);
-- ------------------------------
set foreign_key_checks =0;
drop table if exists Permission;
set foreign_key_checks =1;

create table Permission(
PermissionTypeID char(8) not null,
RoleID char(8) not null,
constraint pk_Permission primary key(PermissionTypeID,RoleID),
constraint fk_Permission_PermissionType foreign key(PermissionTypeID) references PermissionType(PermissionTypeID) on delete no action on update cascade,
constraint fk_Permission_UserRole foreign key(RoleID) references UserRole(RoleID) on delete no action on update cascade
);

-- -------------------------------
