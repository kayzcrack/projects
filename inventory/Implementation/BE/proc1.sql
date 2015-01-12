delimiter //
drop procedure if exists addRequest //
create procedure addRequest(IN in_StaffID varchar(16),IN in_ProductName varchar(32),IN in_Model varchar(32),IN in_Purpose varchar(32),IN in_Quantity varchar(32),IN in_CategoryID char(8),IN in_Comment varchar(64),IN in_ExpectedDateOfCollection Date)

begin
	insert into Request(StaffID,ProductName,RequestDate,Model,Purpose,Quantity,CategoryID,Comment,ExpectedDateOfCollection)
	values(in_StaffID,in_ProductName,now(),in_Model,in_Purpose,in_Quantity,in_CategoryID,in_Comment,
		in_ExpectedDateOfCollection);
end //
delimiter ;
-- -------------------------------------------
delimiter //
drop procedure if exists addRequestResponse //
create procedure addRequestResponse(IN in_RequestID int,IN in_StaffID varchar(16),IN in_StatusID char(8),IN in_AvailableDate Date)
begin
	insert into RequestResponse(RequestID,StaffID,StatusID,AvailableDate)
	values(in_RequestID,in_StaffID,in_StatusID,in_AvailableDate);
end //
delimiter ;
-- ------------------------------------------
delimiter //
drop procedure if exists addAuthorizedRequest //
create procedure addAuthorizedRequest(IN in_RequestID int,IN in_StaffID varchar(16),IN in_AuthorizedStatusID char(8),IN in_Comment varchar(128))
begin
	insert into AuthorizedRequest(RequestID,StaffID,AuthorizedStatusID,Comment)
	values(in_RequestID,in_StaffID,in_AuthorizedStatusID,in_Comment);
end //
delimiter ;
-- ------------------------------------------
delimiter //
drop procedure if exists addReturn //
create procedure addReturn(IN in_RequestID int,IN in_ReturnDate Date,IN in_Comment varchar(128))
begin
	insert into `Return`(RequestID,ReturnDate,Comment)
	values(in_RequestID,in_ReturnDate,in_Comment);
end //
delimiter ;
-- ------------------------------------------
delimiter //
drop procedure if exists addProduct //
create procedure addProduct(IN in_ProductCode varchar(16),IN in_ProductName varchar(32),IN in_BrandID char(5),
IN in_ModelID varchar(32),IN in_SerialNumber varchar(32),IN in_CategoryID varchar(8),
IN in_FunctionalStatusID char(8),IN in_AvailableStatusID varchar(8),IN in_DateOfPurchased Date)
begin
	insert into Product(ProductCode,ProductName,BrandID,ModelID,SerialNumber,CategoryID,FunctionalStatusID,
	AvailableStatusID,DateOfPurchased)
	values(in_ProductCode,in_ProductName,in_BrandID,in_ModelID,in_SerialNumber,in_CategoryID,in_FunctionalStatusID,
		in_AvailableStatusID,in_DateOfPurchased)
on duplicate key update
ProductCode = in_ProductCode,ProductName = in_ProductName,BrandID = in_BrandID,ModelID = in_ModelID,
SerialNumber = in_SerialNumber,CategoryID = in_CategoryID,FunctionalStatusID = in_FunctionalStatusID,
AvailableStatusID = in_AvailableStatusID,DateOfPurchased = in_DateOfPurchased;
end //
delimiter ;
-- ------------------------------------------
delimiter //
drop procedure if exists addPermission //
create procedure addPermission(IN in_PermissionTypeID char(8),IN in_RoleID char(8))
begin
	insert into Permission(PermissionTypeID,RoleID)
	values(in_PermissionTypeID,in_RoleID);
end //
delimiter ;
-- ------------------------------------------
delimiter //
drop procedure if exists addStaff //
create procedure addStaff(IN in_StaffID varchar(16),IN in_Surname varchar(32),IN in_Firstname varchar(32)
,IN in_DeptID varchar(10),IN in_RoleID varchar(8))
begin
    set @uname = makeUsername(in_Firstname,in_Surname);
    set @pass = makePassword();
    set @email = makeEmail(in_Firstname,in_Surname);
    
    insert into inventory.KeepPass(StaffID,Username,Password)
    values(in_StaffID,@uname,@pass);
    
    insert into Staff(StaffID,Surname,Firstname,DepartmentID,Username,Email,Password,RoleID)
    values(in_StaffID,in_Surname,in_Firstname,in_DeptID,@uname,@email,@pass,in_RoleID)
    on duplicate key update
    StaffID = in_StaffID,Surname = in_Surname, Firstname = in_Firstname,Username = @uname,Email = @email,
    DepartmentID = in_DeptID,
    RoleID = in_RoleID;
end //
delimiter ;
-- ------------------------------------    
delimiter //
drop procedure if exists addBrand //
create procedure addBrand(IN in_BrandID char(5), IN in_Name varchar(32))
begin
  insert into Brand(BrandID,Name) values(in_BrandID, in_Name)
  on duplicate key update
  BrandID = in_BrandID, Name = in_Name;
end //
delimiter ;
-- ----------------------------------
delimiter // 
drop procedure if exists addModel //
create procedure addModel(IN in_BrandID char(5), IN in_ModelID char(32), IN in_Name varchar(32))
begin
  insert into Model(BrandID,ModelID,Name)
  values(in_BrandID,in_ModelID,in_Name)
  on duplicate key update
  BrandID = in_BrandID,Name = in_Name;
end //
delimiter ;
-- -----------------------------  
  

