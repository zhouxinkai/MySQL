# -*- coding: UTF-8 -*-
import mysql.connector
# 使用MySQL官方Python Connector，手册http://dev.mysql.com/doc/connector-python/en/connector-python-example-connecting.html
conn= mysql.connector.connect(
        host='localhost',
        port = 3307,
        user='root',
        passwd='683004')
# 创建一个连接对象
cur=conn.cursor()
# 获得该连接的游标对象

try:
    cur.execute('create database test')
except Exception as e:
    print(e)
    print('database test is already exists,now again create it!')
    cur.execute('drop database test')
    cur.execute('create database test')
finally:
	print('database test is be succeed create!')
# 创建新的数据库test
cur.execute('use test')
cur.execute("create table students(stu_id char(20) primary key,stu_name char(20),stu_class char(30),age char(20))")
# 通过cur.execute()函数创建一张表
cur.execute("insert into students values('2','Tom','3 year 2 class','9')")
cur.execute("update students set stu_class='3 year 1 class' where stu_name='Tom'")

sqli="insert into students values(%s,%s,%s,%s)"
cur.execute(sqli,('3','Huhu','2 year 1 class','7'))
cur.executemany(sqli,[
    ('4','Tom','1 year 1 class','6'),
    ('5','Jack','2 year 1 class','7'),
    ('6','Yaheng','2 year 2 class','7'),
    ])
# 通过executemany()函数插入多行数据

conn.commit()
# 一定要有conn.commit()这句来提交事务，要不然不能真正的插入数据。

cur.execute("select * from students")   #在对游标对象执行操作之前，必须进行查询操作
aa=cur.fetchone()
aa=cur.fetchone()
'''#取得当前行的数据，作为元组返回
#cur.scroll(0,'absolute')  
# 将游标定位到表中的第一条数据。
#scroll(self, value, mode='relative'):移动指针到某一行.
#如果mode='relative',则表示从当前所在行移动value条,如果 mode='absolute',则表示从结果集的第一行移动value条.
aa=cur.fetchone()

cur.scroll(0,'absolute')'''
aa=cur.fetchall()
print(aa)
# 取得所有行的数据，作为元组返回

cur.close()
conn.close()   
    



