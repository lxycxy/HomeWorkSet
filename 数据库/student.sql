drop database student632107060506;

create database student632107060506;

use student632107060506;

create table s632107060506(
    sno char(10) not null,
    sname varchar(20) not null,
    sex char(2) not null,
    birthday date not null,
    Nation varchar(10) not null,
    primary key(sno)
);

create table c632107060506(
    cno char(10) not null,
    cname varchar(10) not null,
    credit int ,
    primary key(cno)
);

create table sc632107060506(
    sno char(10) not null,
    cno char(10) not null,
    score int,
    foreign key(sno) references s632107060506(sno) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(cno) references c632107060506(cno) ON DELETE CASCADE ON UPDATE CASCADE ,
    primary key(sno, cno)
);

INSERT INTO `c632107060506`(`cno`, `cname`, `credit`) VALUES ('080601', 'C语言', 3);
INSERT INTO `c632107060506`(`cno`, `cname`, `credit`) VALUES ('080602', '数据结构', 4);
INSERT INTO `c632107060506`(`cno`, `cname`, `credit`) VALUES ('080603', '数据库原理', 4);
INSERT INTO `c632107060506`(`cno`, `cname`, `credit`) VALUES ('080604', '操作系统', 4);
INSERT INTO `c632107060506`(`cno`, `cname`, `credit`) VALUES ('080605', '编译原理', 3.5);

INSERT INTO `s632107060506`(`sno`, `sname`, `sex`, `birthday`, `nation`) VALUES ('08010101', '张三', '男', '1992-05-02', '汉');
INSERT INTO `s632107060506`(`sno`, `sname`, `sex`, `birthday`, `nation`) VALUES ('08050412', '李孟才', '男', '1991-08-09', '藏');
INSERT INTO `s632107060506`(`sno`, `sname`, `sex`, `birthday`, `nation`) VALUES ('08060945', '王珊珊', '女', '1993-08-29', '汉');
INSERT INTO `s632107060506`(`sno`, `sname`, `sex`, `birthday`, `nation`) VALUES ('08110207', '杨彤', '女', '1994-05-30', '汉');

INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08010101', '080601', 80);
INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08010101', '080602', 79);
INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08010101', '080603', 65);
INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08060945', '080601', 98);
INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08060945', '080604', 89);
INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08050412', '080601', 85);
INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08050412', '080602', 86);
INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08110207', '080602', 65);
INSERT INTO `sc632107060506`(`sno`, `cno`, `score`) VALUES ('08110207', '080605', 54);


insert into s632107060506 values (
    '080110208',
    '李四',
    '男',
    '2020-12-25',
    '汉'
);

insert into sc632107060506 values (
    '080110208',
    '080605',
    null
);

update s632107060506 set Nation='汉' where birthday between '1991-01-01' and '1991-12-31';

update sc632107060506 set score = score + 5 where score != null;

update c632107060506 set credit = credit + 1 where c632107060506.cno in (
    select distinct sc632107060506.cno from sc632107060506
);

update s632107060506 set sname = concat(sname, "数据结构") where s632107060506.sno in (
    select distinct sc632107060506.sno from sc632107060506, c632107060506 where sc632107060506.cno = c632107060506.cno and cname = '数据结构' and sex='男'
);

update s632107060506 set sno = 08050413 where sname = '李孟才';

delete from sc632107060506 where sno = 08010101;

delete from sc632107060506  where sc632107060506.sno in (
    select s632107060506.sno from s632107060506 where birthday > '1991-01-01' and  birthday < '1991-12-31'
);

delete from c632107060506 where cname='数据结构';

delete from s632107060506 where sex = '男';

delete from s632107060506 where s632107060506.sno in (
    select sc632107060506.sno from sc632107060506, c632107060506 where sc632107060506.cno = c632107060506.cno and c632107060506.credit = 3
);






