create table authors
(
    au_id    varchar(11) charset utf8mb3 not null
        primary key,
    au_lname varchar(40)                 not null,
    au_fname varchar(20)                 not null,
    phone    char(12) default 'UNKNOWN'  not null,
    address  varchar(40)                 null,
    city     varchar(20)                 null,
    state    char(2)                     null,
    zip      char(5)                     null,
    contract tinyint(1)                  not null
);

create table jobs
(
    job_id   int auto_increment
        primary key,
    job_desc varchar(50) default 'New Position - title not forma' not null,
    min_lvl  tinyint unsigned                                     not null,
    max_lvl  tinyint unsigned                                     not null
);

create table publishers
(
    pub_id   char(4)                   not null
        primary key,
    pub_name varchar(40)               null,
    city     varchar(20)               null,
    state    char(2)                   null,
    country  varchar(30) default 'USA' null
);

create table employee
(
    emp_id    char(9)                                    not null
        primary key,
    fname     varchar(20)                                not null,
    minit     char                                       null,
    lname     varchar(30)                                not null,
    job_id    int                                        not null,
    job_lvl   tinyint unsigned default '10'              null,
    pub_id    char(4)                                    not null,
    hire_date datetime         default CURRENT_TIMESTAMP not null,
    constraint FK_FK__employee__job_id__1BFD2C07
        foreign key (job_id) references jobs (job_id),
    constraint FK_FK__employee__pub_id__1ED998B2
        foreign key (pub_id) references publishers (pub_id)
);

create table pub_info
(
    pub_id  char(4)  not null
        primary key,
    logo    longblob null,
    pr_info text     null,
    constraint FK_FK__pub_info__pub_id__173876EA
        foreign key (pub_id) references publishers (pub_id)
);

create table stores
(
    stor_id      char(4)     not null
        primary key,
    stor_name    varchar(40) null,
    stor_address varchar(40) null,
    city         varchar(20) null,
    state        char(2)     null,
    zip          char(5)     null
);

create table discounts
(
    discounttype varchar(40)   not null,
    stor_id      char(4)       null,
    lowqty       smallint      null,
    highqty      smallint      null,
    discount     decimal(4, 2) not null,
    constraint FK_FK__discounts__stor___0F975522
        foreign key (stor_id) references stores (stor_id)
);

create table titles
(
    title_id  varchar(6) charset utf8mb3         not null
        primary key,
    title     varchar(80)                        not null,
    type      char(12) default 'UNDECIDED'       not null,
    pub_id    char(4)                            null,
    price     float(8, 2)                        null,
    advance   float(8, 2)                        null,
    royalty   int                                null,
    ytd_sales int                                null,
    notes     varchar(200)                       null,
    pubdate   datetime default CURRENT_TIMESTAMP not null,
    constraint FK_FK__titles__pub_id__014935CB
        foreign key (pub_id) references publishers (pub_id)
);

create table roysched
(
    title_id varchar(6) charset utf8mb3 not null,
    lorange  int                        null,
    hirange  int                        null,
    royalty  int                        null,
    constraint FK_FK__roysched__title___0DAF0CB0
        foreign key (title_id) references titles (title_id)
);

create table sales
(
    stor_id  char(4)                    not null,
    ord_num  varchar(20)                not null,
    ord_date datetime                   not null,
    qty      smallint                   not null,
    payterms varchar(12)                not null,
    title_id varchar(6) charset utf8mb3 not null,
    primary key (stor_id, title_id, ord_num),
    constraint FK_FK__sales__stor_id__0AD2A005
        foreign key (stor_id) references stores (stor_id),
    constraint FK_FK__sales__title_id__0BC6C43E
        foreign key (title_id) references titles (title_id)
);

create table titleauthor
(
    au_id      varchar(11) charset utf8mb3 not null,
    title_id   varchar(6) charset utf8mb3  not null,
    au_ord     smallint                    null,
    royaltyper int                         null,
    primary key (title_id, au_id),
    constraint FK_Relationship_10
        foreign key (au_id) references authors (au_id),
    constraint FK_Relationship_9
        foreign key (title_id) references titles (title_id)
);

