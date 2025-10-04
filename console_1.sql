#创建数据库
create database test1;
#查看创建好的数据库
show create database test1;
#使用数据库
use test1;
#删除数据库
drop database test1;
#查看所有表
show databases;
#创建员工信息表
create table emp(
    depid char(3),
    deoname varchar(20),
    peoplecount int
);
#查看表是否创建完成
show tables ;
#查看表结构
desc emp;
#删除数据表
drop table emp;
#表名修改
alter table emp rename biao;
show tables;
alter table biao rename emp;
#修改字段名
alter table emp change depid depno char(3);
#修改字段格式
alter table emp modify depno varchar(5);
desc emp;
#添加新字段
alter table emp add city varchar(10);
#修改字段位置
alter table emp modify city varchar(10) after depno;
#删除字段
alter table emp drop city;
desc emp;
#创建单字段主键约束
create table test2(
    depid char(3) primary key,
    depname varchar(20),
    peoplecount int
);
alter table test2 rename emp2;
#多字段主键约束
create table emp3(
    depid char(3),
    depname varchar(20),
    peoplecount int,
    primary key(depname,depid)
);
show tables ;
#删除主键
alter table emp3 drop primary key;
#创建唯一约束和创建主键约束方法一致，将primary key改为unique
#删除唯一约束方式不同
create table emp4(
    depid char(3) primary key,
    depname varchar(20) unique,
    peoplecount int
);
drop table emp4;
show tables;
alter table emp4 drop index depname;
desc emp4;
#自动增长约束
create table emp5(
    e_id int primary key auto_increment,
    depname varchar(20),
    peoplecount int
);
alter table emp5 modify e_id int;
#创建默认约束
create table emp6(
    depid char(3) primary key,
    depname varchar(20),
    peoplecount int default 0
);
alter table emp6 modify peoplecount int;
#DML
create database DML1;
use DML1;
create table tab1(
    depid char(3),
    depname varchar(20),
    pelplecount int
);
#导入数据 1.指定字段名导入 2.不指定字段名导入
insert into tab1 (depid, depname, pelplecount) values
('p10','人力部','15'),('p20','研发部','20');
insert into tab1 values
('p30','资源部','25');
#批量导入数据 1.查看默认安全路径 2.导入数据 注“fields terminated by '\t'”是用来判断分隔符的
#注 "ignore x lines"是表示忽略第x行的
show variables like '%secure%';
load data infile 'D:/ProgramData/MySQL/MySQL Server 8.0/Uploads/xx.txt'
into table tab1 fields terminated by '\t';
#检查数据 三方面 1.检查导入的内容 2.检查导入数据的总行数 3.检查表的结构
select * from tab1;
select count(*) from tab1;
desc tab1;
#导出数据
create table tab2 as
select depid,depname,pelplecount from tab1 where depid='p10';
show tables;
select * from tab2;
drop table tab2;
#更新数据
update tab1 set depname='后勤部'where depid='p11';
#删除数据 1.指定记录 2.全部记录
delete from tab1 where depid='p20';
delete from tab1;
truncate tab1;
#DQL
create database dql1;
use dql1;
create table tab1(
    depid char(3),
    depname varchar(20),
    pelplecount int
);
insert into tab1 (depid, depname, pelplecount) values
('p10','人力部','15'),('p20','研发部','20');
insert into tab1 values
('p30','资源部','25');
#基础查询语句 1.接常量则直接返回常量，加from则返回与记录长度相同的常量
#2.接公式，字段名返回公式并返回一行答案记录 加from则返回和记录长度相同的答案
#3.接表达式，字段名返回表达式，若表达式成立返回一行1，加from则返回和记录相同的1
#4.接字段名，返回指定字段名的记录
#5.接*，全部返回
select 1;
select 1 from tab1;
select 1+1;
select 1+1 from tab1;
select 1+1=2;
select 1+1=3 from tab1;
select depid,depname from tab1;
select * from tab1;
#1.单字段去重 2.多字段去重
select distinct depid from tab1;
select distinct depid,depname from tab1;
#设置别名1.as形式 2.省略as形式
select *,pelplecount+1 as 加人 from tab1;
select *,pelplecount+1 '加人' from tab1;
#条件查询 加个where 1.单条件 2.多条件 3.多条件的另一种写法
select * from tab1 where depid='p10';
select * from tab1 where (depid='p10'or depid='p20')and pelplecount>10;
select * from tab1 where depid in ('p10','p20')and pelplecount>10;
#连续范围查询 俩条件条件之间加个and 2.等价写法
select * from tab1 where pelplecount<50 and pelplecount>10;
select * from tab1 where pelplecount between 10 and 50;
#空值查询 注 只能用 is null 不能用=null
select * from tab1 where pelplecount is not null;
#模糊查询 用%匹配0or多个字符 用_来匹配已知数量的字符
select * from tab1 where depid not like 'p%';
select * from tab1 where depid not like '%1%';
select * from tab1 where depid like '_1%';
#查询结果排序 order by 后面跟按哪一字段进行排列 desc指降序 asc指升序
select * from tab1 where depid = 'p10'order by pelplecount desc;
#多字段排序 我就弄了一列整数数据 所以没法多条件 凑活着看吧
select * from tab1 order by pelplecount,pelplecount asc;
#限制查询 用limit限制输出多少个结果or范围内的结果，搭配前面的升降序
select * from tab1 order by pelplecount desc limit 2;
select * from tab1 order by pelplecount desc limit 2,3;
select * from tab1 order by pelplecount desc limit 2 offset 2;
#order by 还可以按职位字母顺序排序
select * from tab1 order by depid;
#聚合 其实就是计算处理 eg：sum() avg() max() min() count() 聚合函数也可作为筛选条件
select max(pelplecount),min(pelplecount)from tab1;
#计数比较特殊 不用选择某一字段名 直接查询记录数 也可选择字段名，即查询该字段的记录数2.去重计数 3.条件计数
select count(*) from tab1;
select count(distinct depid) from tab1;
select count(pelplecount) from tab1 where pelplecount!=20;
#分组 通过group dy实现
select pelplecount,count(*)from tab1 group by pelplecount;
#多字段分组
select depid,depname,avg(pelplecount) as 平均人数 from tab1 group by depid, depname ;
#分组后的筛选 用having（分组后加having=‘’) or where（分组前加where=‘’）
select depid,depname,avg(pelplecount) as 平均人数 from tab1 group by depid, depname  having depid='p10';
select depid,depname,avg(pelplecount) as 平均人数 from tab1 where depid='p10'group by depid, depname;
#函数 常用：abs(x)绝对值 sqrt(x)平方根 round(x[,d])四舍五入 p127
select abs(-1);
select sqrt(4);
select round(5.2);
#字符串函数 p130 concat()合并(不能包含空值null，但可以空白值‘’) substring(s,stert[,length])截取 replace(s,s1,s2)替换
select concat('我是','宋恒嵩','的爸爸');
select substring('我刘洋是宋恒嵩的爸爸',2,9);
select depid,replace(depid,'p10','p90')from tab1;
#日期时间函数 1.获取日期中的年月日 2.按照日月年的格式返回日期 3.对日期进行加法计算，4.计算间隔天数 p133
select year('2025-09-15')年,month('20250915')月,day(20250915)日;
select date_format('25-09-15 17:00:00','%d-%m-%y')日月年;
select date_add('2025-09-15',interval 2 month);
#select floor(datediff(curdate(),起始时间)/365) as 年龄 from tab1
#分组合并函数 分组合并 查询某记录包含的内容（去重）
select depid,group_concat(depname order by depname separator '/') 员工部门 from tab1 group by depid;
select group_concat(distinct depid order by depid) 部门编号 from tab1;
#逻辑函数 1. 控制函数 2. if函数 3.case表达函数
select depid,ifnull(pelplecount,0) 人数 from tab1;
select depid,pelplecount,if(pelplecount>30,'多',if(pelplecount<21,'少','中')) 人数水平 from tab1;
select depid,pelplecount,case when pelplecount>30 then '多' when pelplecount<=20 then'少'else'中'end 人数水平 from tab1;
#开窗函数 1. over函数（全显示出来方便对比） 2. partition by（指定分区）
# 3.order by（排序 按指定记录的升序排） 4.序号函数（1.生成连续的序号 同分也往下继续排 2.考虑同分的情况 产生相同的序号 不跳号 3.跳号 ）
select avg(pelplecount) 平均人数 from tab1;
select *,avg(pelplecount) over() 平均人数 from tab1;

select depid,avg(pelplecount) 平均人数 from tab1 group by depid;
select *,avg(pelplecount) over(partition by depid) 平均人数 from tab1;

select *,sum(pelplecount) over(partition by depname order by depid) 累计工资 from tab1;

select *,
row_number() over (order by depid desc) 排名1,
dense_rank() over (order by depid desc) 排名2,
rank() over (order by depid desc) 排名3
from tab1;

#多表查询
create database duobiao;
use duobiao;
create table t1(
    公共字段 char(1),
    v1 int
);
create table t2(
    公共字段 char(1),
    v1 int
);
alter table t2 change v2 v2 int;
insert into t1 (公共字段, v1) values
('a','1'),
('a','12'),
('b','3'),
('c','4');
insert into t2 (公共字段, v2) values
('b','10'),
('b','11'),
('a','12'),
('d','13');
#纵向合并查询 1.去重合 2.不去重合(看a 12)
select * from t1
union
select * from t2;

select * from t1
union all
select * from t2;
#横向合并查询 1.对应关系（1对1 1对多 多对多 两表画箭头）2.连接方式(连接条件on不得出现在输出表内 using可以 后可接筛选条件)
#（1.内连接(连接条件on不得出现在输出表内 using可以) 2.左外连接 3.右外连接 4.全外连接 5.自连接查询 6.多表连接 7.交叉连接）
select v1 from t1
inner join t2 on t1.公共字段 = t2.公共字段;
select 公共字段,v1 from t1
inner join t2 using(公共字段);

select v1 from t1
left join t2 on t1.公共字段 = t2.公共字段;
select 公共字段,v1 from t1
left join t2 using(公共字段);

select v1 from t1
right join t2 on t1.公共字段 = t2.公共字段;
select 公共字段,v1 from t1
right join t2 using(公共字段);

select * from t1 left join t2 on t1.公共字段 = t2.公共字段
union
select * from t1 left join t2 on t1.公共字段 = t2.公共字段;
