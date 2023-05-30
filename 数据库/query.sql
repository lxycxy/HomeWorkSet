use pubs;

select * from authors;

--  查询其他样例表中全部信息
-- select * from discounts;

-- select * from employee;

-- select * from jobs;
-- select * from pub_info;
-- select * from publishers;
-- select * from roysched;

-- select * from sales;
-- select * from stores;
-- select * from titleauthor;

-- select * from titles;

-- 简单条件查询
select title, title_id from titles;

select title from titles where price between 15 and 18;

select title_id, title from titles where title like "T%";

-- 多条件查询

select title, price from titles where title like "T%" and price < 16;

select title_id, title, price from titles where title not like "T%" and price > 16;

-- 连接操作
select title, pub_name from titles, publishers where title.pub_id = publishers.pub_id;

select au_lname, au_fname, title from titles, authors, titleauthor 
where titleauthor.title_id = titles.title_id and titleauthor.au_id = authors.au_id;

-- 排序
select au_lname, au_fname, phone from authors order by au_lname, au_fname;

select title, price from titles order by title DESC;

-- 函数

select count(distinct titles.type) from titles;

select count(distinct price) from titles;

select title, price from titles where price = (select min(price) from titles);


select title, price from titles where price = (select max(price) from titles);

select sum(ord_num) from sales;

