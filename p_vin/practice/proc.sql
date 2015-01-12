create or replace procedure iterate()
language sql
set option tgtrls = v4r5mo, output = *print, srtseq = *langidunq, langid = esp
begin
	ins_loop:
		for each_department as
				c1 cursor for
				select deptno,deptname,mgrno,admrdept,location
				from sample.department
				where deptno <> 'D11'
				order by deptno
		do
		       insert into sample.newdept(deptno,deptname,mgrno,admrdept,location)
		       values(deptno,deptname,mgrno,admrdept,location);
		end for;
end;		