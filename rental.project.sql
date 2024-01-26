create database rental_db;
use rental_db;

create table vehicles (
veh_reg_no varchar(8) not null,
category enum('car','truck') not null default 'car',
brand varchar(30) not null default '',
disc varchar(256) not null default '',
photo blob null,
daily_rate decimal(6,2) not null default 9999.99,
primary key (veh_reg_no),
index (category)
);

describe vehicles;

show create table vehicles ;
show index from vehicles;

create table customers (
customer_id int unsigned not null auto_increment,
name varchar(30) not null default '',
address varchar(80) not null default '',
phone varchar(15) not null default '',
discount double not null default 0.0,
primary key (customer_id),
unique index (phone),
index (name)
);
describe customers;

show create table customers ;
show index from customers;

create table rental_records (
rental_id int unsigned not null auto_increment,
veh_reg_no varchar(8) not null,
customer_id int unsigned not null,
start_date date not null default '2023-09-30',
end_date date not null default '2023-09-30',
lastupdated timestamp not null default current_timestamp on update current_timestamp,
primary key(rental_id),
foreign key(customer_id) references customers (customer_id) on delete restrict on update cascade,
foreign key(veh_reg_no) references vehicles (veh_reg_no) on delete restrict on update cascade
) ;

describe rental_records;

insert into vehicles values
   ('SBA1111A','CAR','NISSAN SUNNY 1.6L','4 Door saloon,Automatic',null,99.99),
    ('SBA2222B','CAR','TOYOTA ALTIs 1.6L','4 Door saloon,Automatic',null,99.99),
     ('SBA3333C','CAR','HONDA CIVIC 1.8L','4 Door saloon,Automatic',null,199.99),
      ('GA5555E','TRUCK','NISSAN CABSTAR 3.0L','Lorry ,manual',null,89.99),
       ('GA6666E','TRUCK','OPEL COMBO 1.6L','van ,manual',null,69.99);
	
select * from vehicles;

insert into customers values
      (1001,'TAN AH Teck','8 Happy Ave','8888888888',0.1),
      (null,'mahammed Ali','1 kg java','9999999999',0.15),
      (null,'kumar','5 serangoon road','555555555',0),
      (null,'kevin jones','2 sunset boulevard','2222222222',0.2);
      
	select * from customers;
    
    insert into rental_records (rental_id,veh_reg_no,customer_id,start_date,end_date) values
    (null,'SBA1111A',1001,'2012-01-01','2012-01-21'),
        (null,'SBA1111A',1001,'2012-02-01','2012-02-05'),
    (null,'GA5555E',1003,'2012-01-05','2012-01-31'),
    (null,'GA6666E',1004,'2012-01-20','2012-02-20');

    select * from rental_records;

select * from vehicles;
select * from customers;
    select * from rental_records;
    
    insert into rental_records
    (rental_id,veh_reg_no,customer_id,start_date,end_date)
    values
    (null,'SBA1111A',
    (select customer_id from customers where name='Tan Ah Teck'),
    curdate(),
    date_add(curdate(), interval 10 day));
        select * from rental_records;
        
  insert into rental_records
    (rental_id,veh_reg_no,customer_id,start_date,end_date)
    values
    (null,'GA5555E',
    (select customer_id from customers where name='Kumar'),
   date_add( curdate(),interval 1 day),
    date_add(curdate(), interval 92 day));
    select * from rental_records;
select r.start_date as 'start date',
      r.end_date as 'end date',
      r.veh_reg_no as 'vehicle no',
      v.brand as 'vehicle brand',
      c.name as 'customer name' from rental_records as r
      inner join vehicles as v using (veh_reg_no)
      inner join customers as c using (customer_id)
      order by v.category,start_date;
      
      select * from rental_records where end_date <= (select curdate());
      select * from rental_records where cast(start_date as date) > '2012-01-10' 
      and cast(end_date as date) >= '2012-01-10';
      
      select * from rental_records where end_date>= 2012-01-10;
      
      create table payments( payment_id int unsigned not null auto_increment, 
       rental_id int unsigned not null,
       amount decimal(8,2) not null default 0,
       mode enum('cash','credit card','check'),
       type enum('deposit','partialo','full') not null default 'full',
       remark varchar(255),
       created_date datetime not null,
       created_by int unsigned  not null,
       last_update_date timestamp default current_timestamp on update current_timestamp,
       last_updatre_by int unsigned not null,
       primary key (payment_id),
       index(rental_id)
      
       );
       
       describe payments;
       
       create table staff (
       staff_id int unsigned not null auto_increment,
       name varchar(30) not null default'',
              title varchar(30) not null default'',
       address varchar(30) not null default'',
phone varchar(30) not null default'',
report_to int unsigned not null,
primary key (staff_id),
unique index (phone),
index (name),
foreign key (report_to) references staff (staff_id)
);
       desc staff;
       insert into staff values (8001,'peter johns','managing director','1 happy ave','12345678',8001);
       
       select * from staff;
       use rental_db;
 insert into staff values (8001,'peter johns','managing director','1 happy ave','12345678',8001);
       select * from staff;
       
       alter table rental_records add column staff_id int unsigned not null;
       set sql_safe_updates = 0;
       update rental_records set staff_id =8001;
       alter table rental_records add foreign key(staff_id) references staff (staff_id) on
       delete restrict on update cascade;
       alter table payments add column staff_id int unsigned not null;
       update payments set staff_id = 8001;
	
 
 alter table payments add foreign key (staff_id) references staff (staff_id) 
 on delete restrict on update cascade;
 
  