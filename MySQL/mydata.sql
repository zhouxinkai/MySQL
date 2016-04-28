mysql -u root -p database_name
-- 登录数据库
source 'C:\schema.sql'
-- 在MySQL命令行执行一个sql文件
create database mydata;
--创建一个数据库mydata；
use mydata;
--使用mydata数据库
show databases；
--显示一共有多少个数据库
show variables like '%datadir%';
--查看数据文件存放路径

show tables；
--mydata数据库中一共有多少张表
desc dept；
--dept表里的内容

create table dept
(
deptno int primary key,
dname varchar(14),
loc varchar(13),
);

create table emp
(
empno int primary key,
ename varchar(10),
job varchar(10),
mgr int,
hiredate datetime,
sal double,
comm double,
deptno int,
foreign key (deptno) references dept(deptno)	-- 添加外键
);
-- 创建两张表；

insert into dept values (10,'A','A');
insert into dept values (20,'B','B');
-- 往dept表里插入值
commit
-- 提交
select * from dept order by deptno desc limit 1,1;
-- select * from dept,选择表dept；order by deptno desc，按照deptno逆序排列
-- limit 1,1 从第一行开始数，数1行显示出来

create table article
(
id int primary key auto_increment,	-- 自动递增的主键
title varchar(255),
);
insert into article values (null,'a');
insert into article values (null,'b');

select now();
-- 取得当前时间，now()为一个函数
select date_format(now(),'%Y-%m-%d %H:%i:%s');
-- 转换时间格式
insert into emp values (999,'test','clerk',7369,'2015-7-8 22:03:56',8000,80,10);
-- '2015-7-8 22:03:56'插入日期

/* Char类型，是不变长度的字符串，速度快。用空间换取速度
Varchar类型，是可变长度字符串，节省储存空间，但是存取速度慢。用速度换取空间
如果定义长度为10位，输入一个A。对于char类型，数据库存的为 ‘A’+9个空格。
对于varchar类型，数据库存的只为‘A’。从空间上考虑，用Varchar是可以的，但是从效率的角度考虑，用char好一些。

数据定义语言：create、drop、alter。
数据查询语言：select。
数据操作语言：update、insert、delete。

SQL语言的主要功能就是查询，但是查询中会有表达式的值计算、大小的判断、逻辑值的应用等操作。 
SQL是结构化查询语言，主要用来查询、添加、删除、修改数据库中的信息。增查改删

LIKE运算符在模糊查询中，常常会用到。从它的字面意思上就能体会出，它是要查询和规定信息相像的内容，
例如：name like ‘%周%’，就是要查询以名字中包含“周”的名字，其中，“%”是通配符。

学习的方法：先知道怎么用，再系统的看书学习。 */
use tysql;
create table emp
(
company varchar(13) primary key,
loc varchar(13)
);
create table dept
(
_name varchar(13),
_year int  primary key,
company varchar(13),
foreign key (company) references emp(company)
);
-- 在定义外键时必须先定义对应变量
-- 外键必须是外表中的主键
-- 外键只能引用外表主键列中的值，即外键的取值范围是主键取值范围的一个子集

insert into emp values ('nanjing','trend');
insert into emp values ('beijing','360');
insert into dept values('trend','zhou',11);
insert into dept values('trend','xin',22);
insert into dept values('trend','kai',33);
insert into dept values(NULL,'cui',44);
SELECT dept.company,_name,_year,loc
FROM emp,dept
WHERE dept.company=emp.company;
-- 联接之后的新表的行数必为辅表的行数

SELECT * FROM tysql.customers;
SELECT c1.cust_id,c1.cust_name,c1.cust_contact
FROM customers AS c1,customers AS c2
WHERE c1.cust_id=c2.cust_id;
-- 通过主键自联接将得到一张原表
use tysql;
SELECT c1.cust_id,c1.cust_name,c1.cust_contact,c2.cust_id,c2.cust_name,c2.cust_contact
FROM Customers AS c1,Customers AS c2
WHERE c1.cust_name=c2.cust_name;
-- 自联接必须通过非主键联接才有意义，从这个过程中的可以理解联接是咋样进行的
-- 内联接：通过主键、外键的一对多的对应关系，按照主键的每一个取值，在对应的多个
--       外键的每一个行上加上对应主键行。
create table xin
(
d varchar(13),
e int,
f varchar(13)
);
create table kai
(
l int,
m int,
n int
);
INSERT INTO kai
VALUES
(
11,22,33
);
INSERT INTO xin
(
d,e,f
)
SELECT n,m,l
FROM kai;
-- INTO后面的列名和SELECT后面的列名不一定一致，其按照相同的位置插入
-- 如n字段向d字段插入，类型也不一定相同，但前后总列数要一样

USE tysql;
-- DROP PROCEDURE NewOrder
DELIMITER //  
-- 定义//为定界符
CREATE PROCEDURE NewOrder(IN new_cust_id CHAR(10),OUT new_order_num INT)
BEGIN
	-- DECLARE new_order_num INT; 在存储过程内部要这样定义变量
	SELECT MAX(order_num) INTO new_order_num
    FROM Orders;
    SELECT new_order_num+1 INTO new_order_num;
    SELECT new_order_num;
    INSERT INTO Orders(order_num,order_date,cust_id)
    VALUES (new_order_num,NOW(),new_cust_id);
END;//
DELIMITER ;  
-- 定义//为定界符
SET @cust_id=1000000005;	-- 在存储过程外部，用户变量名以@开头（不用定义），否则为系统变量
CALL NewOrder(@cust_id,@new_order_num);
SELECT @new_order_num;
-- 以下说明来自帮助文档：？ create procedure
-- 默认情况下delimiter（定界符）为分号，即一行命令以分号结束，那么回车后，MySQL将会执行该命令。
-- 但有时候，不希望MySQL这么做。如输入较多的语句，且语句中包含有分号。
-- 这种情况下，就需要事先把delimiter换成其它符号，如//或$$。
-- 这样只有当//出现之后，MySQL解释器才会执行这段语句。

use tysql;
DELIMITER //
drop procedure  if exists cursor_proc;
CREATE PROCEDURE cursor_proc() 
BEGIN
	DECLARE custid CHAR(20);
	DECLARE custname CHAR(20);
    DECLARE i INT;
	DECLARE cursor_1 CURSOR FOR 	-- 游标不能单独定义
	select cust_id,cust_name from Customers
	where cust_email is null;
    /*游标(cursor)必须在声明处理程序之前被声明，
    并且变量和条件必须在声明游标或处理程序之前被声明。*/
    open cursor_1;
    SET i=0;
    WHILE i<2 DO
		FETCH cursor_1 INTO custid,custname;
		SELECT custid,custname;
        SET i=i+1;
    END WHILE;
    CLOSE cursor_1;
END;//
CALL cursor_proc();


drop trigger  if exists customer_state;
DELIMITER //
CREATE TRIGGER customer_state
BEFORE INSERT
ON Customers FOR EACH ROW
BEGIN
	UPDATE Customers
    SET cust_state =Upper(cust_state),
		cust_name =Upper(cust_name)
    WHERE Customers.cust_id=NEW.cust_id;  -- NEW代表执行插入操作时，插入的行
END;//
DELIMITER ;
/*触发器(trigger)：监视某种情况，并触发某种操作。
触发器创建语法四要素：1.监视地点(table) 2.监视事件(insert/update/delete) 
3.触发时间(after/before) 4.触发事件(insert/update/delete)
after是先完成数据的增删改，再触发，触发的语句晚于监视的增删改操作
before是先完成触发，再增删改，触发的语句先于监视的增删改*/
insert into customers(cust_id,cust_name,cust_state)
values('0726','bruce_zhou','nj');

-- 有bug，begin-end之间的代码修改为如下代码
BEGIN
	-- IF customers.cust_id=NEW.cust_id THEN
    SET NEW.cust_state =Upper(NEW.cust_state),
		NEW.cust_name =Upper(NEW.cust_name);
	-- END IF;
    -- NEW代表执行插入操作时，插入的行
END;//
-- 1不要使用UPDATE，2不要使用表customers.cust_id=NEW.cust_id,因为触发器内的代码不能引用旧表中的数据