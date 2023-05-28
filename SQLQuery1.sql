--��Ӧ�̱� S
CREATE TABLE S (
 SNO VARCHAR(10) PRIMARY KEY,
 SNAME VARCHAR(50),
STATUS VARCHAR(50),
 CITY VARCHAR(50)
);
--����� P
CREATE TABLE P (
 PNO VARCHAR(10) PRIMARY KEY,
 PNAME VARCHAR(50),
 COLOR VARCHAR(50),
 WEIGHT DECIMAL(10, 2)
);

--������Ŀ�� J
CREATE TABLE J (
 JNO VARCHAR(10) PRIMARY KEY,
 JNAME VARCHAR(50),
 CITY VARCHAR(50)
);
--��Ӧ����� SPJ
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

-- ��Ӧ�̱� S ��������
INSERT INTO S (SNO, SNAME, STATUS, CITY) VALUES
('s1', '����', '20', '���'),
('s2', 'ʢ��', '10', '����'),
('s3', '������', '30', '����'),
('s4', '��̩ʢ', '20', '���'),
('s5', 'Ϊ��', '30', '�Ϻ�');
--������� P ��������
INSERT INTO P (PNO, PNAME, COLOR, WEIGHT) VALUES
('p1', '��ĸ', '��', 12),
('p2', '��˨', '��', 17),
('p3', '��˿��', '��', 14),
('p4', '��˿��', '��', 14),
('p5', '͹��', '��', 40),
('p6', '����', '��', 30);

--�򹤳���Ŀ�� J ��������
INSERT INTO J (JNO, JNAME, CITY) VALUES
('j1', '����', '����'),
('j2', 'һ��', '����'),
('j3', '���ɳ�', '���'),
('j4', '�촬��', '���'),
('j5', '������', '��ɽ'),
('j6', '���ߵ糧', '����'),
('j7', '�뵼�峧', '�Ͼ�');
--��Ӧ����� SPJ ��������
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

--ѧ���� Student
CREATE TABLE Student (
 Sno INT PRIMARY KEY,
 Sname VARCHAR(50),
 Ssex VARCHAR(10),
 Sage INT,
 Sdept VARCHAR(50)
);
--�γ̱� Course
CREATE TABLE Course (
 Cno INT PRIMARY KEY,
 Cname VARCHAR(50),
 Cpno INT,
 Ccredit INT
);

--ѧ��ѡ�α� SC
CREATE TABLE SC (
 Sno INT,
 Cno INT,
 Grade INT,
PRIMARY KEY (Sno, Cno),
FOREIGN KEY (Sno) REFERENCES Student(Sno),
FOREIGN KEY (Cno) REFERENCES Course(Cno)
);


-- Student �����������
INSERT INTO Student (Sno, Sname, Ssex, Sage, Sdept) VALUES
(201215121, '����', '��', 20, 'CS'),
(201215122, '����', 'Ů', 19, 'CS'),
(201215123, '����', 'Ů', 18, 'MA'),
(201215125, '����', '��', 19, 'IS');
--��γ̱� Course �����������
INSERT INTO Course (Cno, Cname, Cpno, Ccredit) VALUES
(1, '���ݿ�', 5, 4),
(2, '��ѧ', NULL, 2),
(3, '��Ϣϵͳ', 1, 4),
(4, '����ϵͳ', 6, 3),
(5, '���ݽṹ', 7, 4),
(6, '���ݴ���', NULL, 2),
(7, 'PASCAL����', 6, 4);
--��ѧ��ѡ�α� SC �����������
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
print ('��������ǣ�')
print @area

create function Search (@sdept char(10)) returns table
as
	return (
	select Student.Sno ѧ��, Student.Sname ����, Course.Cname �γ���, SC.Grade �ɼ�
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
		RAISERROR('weight ������~20֮�䣡',16,1)
		ROLLBACK TRANSACTION
	end
end

insert into p(pno,pname,color,weight) values('p7','��Ƭ','��',40);

insert into p(pno,pname,color,weight) values('p7','��Ƭ','��',15);

select * from p;

create trigger J_Update on j for update
as
begin
	if UPDATE(JName) and UPDATE(City)
	begin
		RAISERROR('������ͬ�޸���Ŀ���ƺͳ��У�', 16, 1);
		ROLLBACK TRANSACTION;
	end;
end;


update j set jname='����' ,city='�Ϻ�' where jno='j1';

update j set jname='����' where jno='j1';

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

delete from student where sname='����';

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
