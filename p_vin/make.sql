delimiter // 

drop procedure if exists calc_result //

create procedure  calc_result(IN in_StudentID varchar(16),IN in_LevelID VARCHAR(16),IN in_SemesterID VARCHAR(16))
begin
 
	Set @courseload =(Select IFNULL(SUM(c.CourseHours),0) from StudentSubject ss 
	LEFT JOIN Course c on c.CourseID=ss.CourseID 
	where ss.StudentID= in_StudentID and c.LevelID= in_LevelID and c.SemesterID= in_SemesterID);

Set @formula=(select(sum(courseval(r.CourseID)*grdval(r.Grade))) from Result r 
				Where r.StudentID= in_StudentID and r.LevelID= in_LevelID and r.SemesterID= in_SemesterID);

Set @gpa=(@formula/@courseload);

Insert Into GPA (StudentID,LevelID,SemesterID,GPA)
Values (in_StudentID,in_LevelID,in_SemesterID,(ROUND(@gpa,2)))
ON DUPLICATE KEY UPDATE StudentID=in_StudentID,LevelID=in_LevelID,SemesterID=in_SemesterID,GPA=(ROUND(@gpa,2));

Select (ROUND(@gpa,2)) as GPA,in_StudentID AS StudentID;
end //
delimiter ;
-- ----------------------------------------
delimiter // 

drop trigger if exists ai_result//

create trigger  ai_result after insert on GPA
for each row
begin

   if new.StudentID in (select StudentID from GPA where SemesterID= 'Second') THEN
   
   Set @level=(Select l.flag from Level l left join Student s on s.LevelID=l.LevelID where s.StudentID=new.StudentID);
   set @nlevel=(@level+1);
   
	update Student 
	set LevelID=(Select LevelID from Level where flag=@nlevel)
	Where StudentID=new.StudentID;
	
	end if;
end //
delimiter ;










