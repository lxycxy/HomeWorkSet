
create database drugmanage;

use drugmanage;

create table druglist (
    drug_no int not null,
    drug_name varchar(20) not null,
    drug_origin varchar(30) not null,
    drug_specs varchar(30) not null,
    primary key(drug_no)
);

/* mysql 以主键为索引时，自动作为聚集索引*/
create index drug_index on druglist(drug_no);


create table purchase (
    purchase_time datetime not null,
    purchase_count int not null,
    purchase_price int not null,
    purchase_supplier varchar(30) not null,
    drug_no int not null,
    primary key (purchase_time),
    foreign key (drug_no) references druglist(drug_no)
);

create index purchase_index on purchase(purchase_time, drug_no DESC);

-- drop database drugmanage;

create database bookmanage;

use bookmanage;


create table book (
    book_no int not null,
    book_name varchar(50) not null,
    book_author varchar(50) not null,
    book_press varchar(50) not null,
    book_price int not null,
    primary key(book_no)
);

create index book_index on book(book_no);

create table reader (
    reader_no int not null,
    reader_name varchar(50) not null,
    reader_sex char(2) not null,
    reader_falts varchar(50) not null,
    reader_address varchar(50) not null,
    primary key(reader_no)
);

create index reader_index on reader(reader_no);

create table borrow (
    reader_no int not null,
    book_no int not null,
    borrow_time datetime not null,
    restore_time datetime not null,
    borrow_remark varchar(200) not null,
    primary key(reader_no, book_no),
    foreign key (reader_no) references reader(reader_no),
    foreign key (book_no) references book(book_no)
);

create index borrow_index on borrow(book_no, reader_no DESC);

-- drop database bookmanage;