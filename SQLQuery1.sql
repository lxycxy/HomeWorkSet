--供应商表 S
CREATE TABLE S (
 SNO VARCHAR(10) PRIMARY KEY,
 SNAME VARCHAR(50),
STATUS VARCHAR(50),
 CITY VARCHAR(50)
);
--零件表 P
CREATE TABLE P (
 PNO VARCHAR(10) PRIMARY KEY,
 PNAME VARCHAR(50),
 COLOR VARCHAR(50),
 WEIGHT DECIMAL(10, 2)
);

--工程项目表 J
CREATE TABLE J (
 JNO VARCHAR(10) PRIMARY KEY,
 JNAME VARCHAR(50),
 CITY VARCHAR(50)
);
--供应情况表 SPJ
CREATE TABLE SPJ (
 SNO VARCHAR(10),
 PNO VARCHAR(10),
 JNO VARCHAR(10),
 QTY INT,
PRIMARY KEY (SNO, PNO, JNO),
FOREIGN KEY (SNO) REFERENCES S(SNO),
FOREIGN KEY (PNO) REFERENCES P(PNO),
FOREIGN KEY (JNO) REFERENCES J(JNO)
);

-- 向供应商表 S 插入数据
INSERT INTO S (SNO, SNAME, STATUS, CITY) VALUES
('s1', '精益', '20', '天津'),
('s2', '盛锡', '10', '北京'),
('s3', '东方红', '30', '北京'),
('s4', '丰泰盛', '20', '天津'),
('s5', '为民', '30', '上海');
--向零件表 P 插入数据
INSERT INTO P (PNO, PNAME, COLOR, WEIGHT) VALUES
('p1', '螺母', '红', 12),
('p2', '螺栓', '绿', 17),
('p3', '螺丝刀', '蓝', 14),
('p4', '螺丝刀', '红', 14),
('p5', '凸轮', '蓝', 40),
('p6', '齿轮', '红', 30);

--向工程项目表 J 插入数据
INSERT INTO J (JNO, JNAME, CITY) VALUES
('j1', '三建', '北京'),
('j2', '一汽', '长春'),
('j3', '弹簧厂', '天津'),
('j4', '造船厂', '天津'),
('j5', '机车厂', '唐山'),
('j6', '无线电厂', '常州'),
('j7', '半导体厂', '南京');
--向供应情况表 SPJ 插入数据
INSERT INTO SPJ (SNO, PNO, JNO, QTY) VALUES
('s1', 'p1', 'j1', 200),
('s1', 'p1', 'j3', 100),
('s1', 'p1', 'j4', 700),
('s1', 'p2', 'j2', 100),
('s2', 'p3', 'j1', 400),
('s2', 'p3', 'j2', 200),
('s2', 'p3', 'j4', 500),
('s2', 'p3', 'j5', 400),
('s2', 'p5', 'j1', 400),
('s2', 'p5', 'j2', 100),
('s3', 'p1', 'j1', 200),
('s3', 'p3', 'j1', 200),
('s4', 'p5', 'j1', 100),
('s4', 'p6', 'j3', 300),
('s4', 'p6', 'j4', 200),
('s5', 'p2', 'j4', 100),
('s5', 'p3', 'j1', 200),
('s5', 'p6', 'j2', 200),
('s5', 'p6', 'j4', 500);

--学生表 Student
CREATE TABLE Student (
 Sno INT PRIMARY KEY,
 Sname VARCHAR(50),
 Ssex VARCHAR(10),
 Sage INT,
 Sdept VARCHAR(50)
);
--课程表 Course
CREATE TABLE Course (
 Cno INT PRIMARY KEY,
 Cname VARCHAR(50),
 Cpno INT,
 Ccredit INT
);

--学生选课表 SC
CREATE TABLE SC (
 Sno INT,
 Cno INT,
 Grade INT,
PRIMARY KEY (Sno, Cno),
FOREIGN KEY (Sno) REFERENCES Student(Sno),
FOREIGN KEY (Cno) REFERENCES Course(Cno)
);


-- Student 插入测试数据
INSERT INTO Student (Sno, Sname, Ssex, Sage, Sdept) VALUES
(201215121, '李勇', '男', 20, 'CS'),
(201215122, '刘晨', '女', 19, 'CS'),
(201215123, '王敏', '女', 18, 'MA'),
(201215125, '张立', '男', 19, 'IS');
--向课程表 Course 插入测试数据
INSERT INTO Course (Cno, Cname, Cpno, Ccredit) VALUES
(1, '数据库', 5, 4),
(2, '数学', NULL, 2),
(3, '信息系统', 1, 4),
(4, '操作系统', 6, 3),
(5, '数据结构', 7, 4),
(6, '数据处理', NULL, 2),
(7, 'PASCAL语言', 6, 4);
--向学生选课表 SC 插入测试数据
INSERT INTO SC (Sno, Cno, Grade) VALUES
(201215121, 1, 92),
(201215121, 2, 85),
(201215121, 3, 88),
(201215122, 2, 90),
(201215122, 3, 80);


use test;

create function RectangleArea(@a int,@b int) returns int
as
begin
    declare @area int
    select @area = @a * @b
	return @area
end


declare @area int
execute @area=RectangleArea 3,5
print ('矩形面积是：')
print @area

create function Search (@sdept char(10)) returns table
as
	return (
	select Student.Sno 学号, Student.Sname 姓名, Course.Cname 课程名, SC.Grade 成绩
	from Student, Course, SC
	where Student.Sdept = @sdept and Student.Sno = SC.Sno and SC.Cno = Course.Cno

);

--drop function Search;

select * from Search('cs');

create trigger  P_checks on p for insert 
as
begin
	declare @weight int
	select @weight = WEIGHT
	from inserted
	if @weight<10 or @weight>20
	begin 
		RAISERROR('weight 必须在~20之间！',16,1)
		ROLLBACK TRANSACTION
	end
end

insert into p(pno,pname,color,weight) values('p7','刀片','红',40);

insert into p(pno,pname,color,weight) values('p7','刀片','红',15);

select * from p;

create trigger J_Update on j for update
as
begin
	if UPDATE(JName) and UPDATE(City)
	begin
		RAISERROR('不允许同修改项目名称和城市！', 16, 1);
		ROLLBACK TRANSACTION;
	end;
end;


update j set jname='建筑' ,city='上海' where jno='j1';

update j set jname='建筑' where jno='j1';

select * from j;

create trigger ScDel_Cascade  on Student instead of delete
as
begin
	declare @sno char(10)
	select @sno=sno from deleted;
	delete from SC where @sno = Sno;
	delete from Student where @sno = Sno;
end;

drop trigger ScDel_Cascade;

delete from student where sname='李勇';

select * from sc;

select * from student;


select * from sc,student,course where sc.cno = course.cno and student.sno = sc.sno;

create function studentgrade() returns table
as
	return(
		select Course.Cno,Cname, COUNT(sc.sno) sc_number, MAX(Grade) Max_grade,
		MIN(Grade) Min_grade,AVG(Grade) Average_grade
		from Course
		left join SC on SC.Cno = Course.Cno
		group by Course.Cno,Cname
);

select * from  studentgrade();
