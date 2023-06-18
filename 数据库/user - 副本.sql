-- create user 'qry'@'localhost' identified by 'qry';

-- create user 'upt'@'localhost' identified by 'upt';

-- grant select on student632107060506.s632107060506 to 'qry'@'localhost';

-- grant select on student632107060506.c632107060506 to 'qry'@'localhost';

-- grant update on student632107060506.s632107060506 to 'upt'@'localhost';

-- grant delete on student632107060506.s632107060506 to 'upt'@'localhost';


use student632107060506;

select * from s632107060506 where sex='男';

select * from c632107060506 where credit>3;

select s632107060506.sno, s632107060506.sname, s632107060506.sex from s632107060506, sc632107060506, c632107060506
    where s632107060506.sno = sc632107060506.sno and c632107060506.cno = sc632107060506.cno and credit > 4;

update s632107060506 set Nation='汉' where birthday between '1991-01-01' and '1991-12-31';

update s632107060506 set sname = concat(sname, "数据结构") where s632107060506.sno in (
    select distinct sc632107060506.sno from sc632107060506, c632107060506 where sc632107060506.cno = c632107060506.cno and cname = '数据结构'
);

delete from s632107060506 where s632107060506.sno in (
    select sc632107060506.sno from sc632107060506, c632107060506 where sc632107060506.cno = c632107060506.cno and c632107060506.credit = 3
);



