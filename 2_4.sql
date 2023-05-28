
use student632107060506;



insert into s632107060506 (
    080110208,
    李四,
    男,
    2020-12-25,
    汉
)

insert into sc632107060506 (
    08110208,
    080605
)

update s632107060506 set Nation='汉' where birthday between 1991-01-01 and 1991-12-31;

update sc632107060506 set score = score + 5 where score != null;

update c632107060506 set credit = credit + 1 where cno in (
    select distinct cno from sc632107060506
);

update s632107060506 set sname = sname + "数据结构" where sno in (
    select distinct sno from sc632107060506, c632107060506 where sc632107060506.cno == c632107060506.cno and cname = '数据结构' 
);

update s632107060506 set sno = 08050413 where sname = '李孟才';

delete from sc632107060506 where sno=08010101;

delete from sc632107060506, s632107060506 where sc632107060506.sno = s632107060506.sno 
and birthday between 1991-01-01 and 1991-12-31;

delete from c632107060506 where cname='数据结构';

delete from s632107060506 where Sex = '男';

delete from s632107060506 where sno in (
    select sno from sc632107060506, c632107060506 where sc632107060506.cno == c632107060506.cno and credit = 3;
);


