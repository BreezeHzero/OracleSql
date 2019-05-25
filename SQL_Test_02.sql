CREATE TABLE students(
sno VARCHAR2(10) PRIMARY KEY,
sname VARCHAR2(20),
sage NUMERIC(2),
sex VARCHAR2(5)
);
CREATE TABLE teachers(
tno VARCHAR2(10) PRIMARY KEY,
tname VARCHAR2(20)
);
CREATE TABLE courses(
cno VARCHAR2(10),
cname VARCHAR2(20),
tno VARCHAR2(20),
CONSTRAINT pk_courses PRIMARY KEY(cno,tno)
);
CREATE TABLE sc(
sno VARCHAR2(10),
cno VARCHAR2(10),
score NUMERIC(4,2),
CONSTRAINT pk_sc PRIMARY KEY(sno,cno)
);
INSERT INTO students VALUES('s001','张三',23,'男');
insert into students values ('s002','李四',23,'男'); 
insert into students values ('s003','吴鹏',25,'男'); 
insert into students values ('s004','琴沁',20,'女'); 
insert into students values ('s005','王丽',20,'女'); 
insert into students values ('s006','李波',21,'男'); 
insert into students values ('s007','刘玉',21,'男'); 
insert into students values ('s008','萧蓉',21,'女');
insert into students values ('s009','陈萧晓',23,'女');
insert into students values ('s010','陈美',22,'女');
SELECT * FROM students;
commit;
insert into teachers values ('t001', '刘阳'); 
insert into teachers values ('t002', '谌燕'); 
insert into teachers values ('t003', '胡明星'); 
UPDATE teachers SET tname = '王燕' WHERE tno = 't002';
commit;
SELECT * FROM teachers;
insert into courses values ('c001','J2SE','t002');
insert into courses values ('c002','Java Web','t002');
insert into courses values ('c003','SSH','t001'); 
insert into courses values ('c004','Oracle','t001'); 
insert into courses values ('c005','SQL SERVER 2005','t003'); 
insert into courses values ('c006','C#','t003'); 
insert into courses values ('c007','JavaScript','t002'); 
insert into courses values ('c008','DIV+CSS','t001'); 
insert into courses values ('c009','PHP','t003');
insert into courses values ('c010','EJB3.0','t002');
commit;
SELECT * FROM courses;
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9); 
insert into sc values ('s003','c001',81.9); 
insert into sc values ('s004','c001',60.9); 
insert into sc values ('s001','c002',82.9); 
insert into sc values ('s002','c002',72.9); 
insert into sc values ('s003','c002',81.9); 
insert into sc values ('s001','c003','59');
commit;
SELECT * FROM sc;
INSERT INTO sc VALUES('s006','c004','58');
INSERT INTO sc VALUES('s001','c004','59');
--1、查询“c001”课程比“c002”课程成绩高的学生的学号；
SELECT s1.sno
FROM sc s1
LEFT JOIN sc s2
ON s1.sno = s2.sno AND s1.cno =  'c001' AND s2.cno = 'c002'
WHERE s1.score > s2.score;

select a.* from
(select * from sc a where a.cno='c001') a,
(select * from sc b where b.cno='c002') b
where a.sno=b.sno and a.score > b.score;

--2、查询平均成绩大于60 分的同学的学号和平均成绩；
SELECT sno,avg(score)
FROM sc
GROUP BY sno
HAVING avg(score)>60;
--3、查询所有同学的学号、姓名、选课数、总成绩；
SELECT sc.sno,s.sname,count(*),sum(score)
FROM sc 
LEFT JOIN students s
ON sc.sno = s.sno
GROUP BY sc.sno,s.sname;
--4、查询姓“刘”的老师的个数；
SELECT count(*)
FROM teachers 
WHERE tname LIKE '刘%';
--5、查询没学过“王燕”老师课的同学的学号、姓名；
SELECT distinct s.sno,s.sname
FROM students s
WHERE s.sno NOT IN
(
SELECT sc.sno
FROM sc
WHERE sc.cno IN
(SELECT c.cno
FROM courses c
WHERE tno IN
(SELECT tno FROM teachers WHERE tname = '王燕'))
);

--查询选了王燕老师课程的学生学号
SELECT distinct sno
FROM sc
WHERE cno IN
(SELECT c.cno
FROM courses c
WHERE tno IN
(SELECT tno FROM teachers WHERE tname = '王燕'));

--查询王燕老师的课程
SELECT c.cno
FROM courses c
WHERE tno IN
(SELECT tno FROM teachers WHERE tname = '王燕');

--6、查询学过“c001”并且也学过编号“c002”课程的同学的学号、姓名
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno
LEFT JOIN sc s2
ON s.sno = s2.sno
WHERE s1.sno = s2.sno AND s1.cno = 'c001' AND s2.cno = 'c002';
--7、查询学过“谌燕”老师所教的课的同学的学号、姓名；
SELECT s.sno,s.sname
FROM students s
WHERE s.sno IN
(SELECT sno 
FROM sc 
WHERE cno IN
(SELECT c.cno
FROM courses c,teachers t 
WHERE c.tno = t.tno AND t.tname = '王燕'));

--8、查询课程编号“c002”的成绩比课程编号“c001”课程低的所有同学的学号、姓名；
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno AND s1.cno = 'c001'
LEFT JOIN sc s2
ON s.sno = s2.sno AND s2.cno = 'c002'
WHERE s2.score < s1.score;

SELECT s.sno,s.sname
FROM students s,sc s1,sc s2
WHERE s.sno = s1.sno AND s.sno = s2.sno AND s1.cno = 'c001' AND s2.cno = 'c002'
AND s1.score > s2.score;
--9、查询所有课程成绩小于60 分的同学的学号、姓名；
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno
WHERE s1.score < 60;
--10、查询没有学全所有课的同学的学号、姓名；
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno
GROUP BY s.sno,s.sname
HAVING count(cno) != 
(SELECT count(*)
FROM courses c);
--11、查询至少有一门课与学号为“s001”的同学所学相同的同学的学号和姓名；
--查询s001选的课程
SELECT s1.cno
FROM sc s1
WHERE s1.sno = 's001';

SELECT distinct s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno
WHERE s1.cno IN 
(SELECT s2.cno
FROM sc s2
WHERE s2.sno = 's001') AND s1.sno != 's001';

SELECT distinct s.sno,s.sname
FROM students s,sc s1
WHERE s.sno = s1.sno AND s1.cno IN (SELECT s2.cno FROM sc s2 WHERE s2.sno = 's001')
AND s1.sno != 's001';
--12、查询至少学过学号为“s001”同学所有一门课的其他同学学号和姓名；
--13、把“SC”表中“谌燕”老师教的课的成绩都更改为此课程的平均成绩；
UPDATE sc SET score = 
(SELECT avg(s2.score) 
FROM sc s2
LEFT JOIN courses c
ON s2.cno = c.cno
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '王燕'
GROUP BY sc.cno) 
WHERE cno IN  
(SELECT c.cno
FROM courses c
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '王燕');

SELECT * FROM sc;

SELECT distinct s1.cno
FROM sc s1
LEFT JOIN courses c
ON s1.cno = c.cno
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '王燕';

--步骤1：
--这条语句查找到执行时间。
select r.FIRST_LOAD_TIME,r.* from v$sqlarea r order by r.FIRST_LOAD_TIME desc ;

--步骤2：
create table sc_r --创建一个新表
as
select * from sc --操做的那张表
as 
of timestamp to_timestamp('2019-04-26/09:17:54','yyyy-mm-dd hh24:mi:ss');--这个时间是执行修改操作语句的那个时间

--步骤3：
delete  sc; --删除修改操作的那张表
insert into sc select * from sc_r; --插入原来的数据

--查询，数据全部恢复
select * FROM sc;

--14、查询和“s001”号的同学学习的课程完全相同的其他同学学号和姓名；
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s2
ON s.sno = s2.sno
WHERE s2.cno IN
(SELECT s1.cno
FROM sc s1
WHERE  s1.sno = 's001');

--15、删除学习“谌燕”老师课的SC 表记录；

--16、向SC 表中插入一些记录，这些记录要求符合以下条件：没有上过编号“c002”课程的同学学号、“c002”号课的平均成绩；
INSERT INTO sc(sno,cno,score)
SELECT distinct s.sno,sc.cno,(SELECT avg(score) FROM sc WHERE sc.cno = 'c002')
FROM students s,sc
WHERE NOT EXISTS
(SELECT * FROM sc WHERE cno = 'c002' AND sc.sno = s.sno) AND sc.cno = 'c002';
--17、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
SELECT c.cno,max(sc.score),min(sc.score) 
FROM courses c
LEFT JOIN sc
ON c.cno = sc.cno
GROUP BY c.cno;
--18、按各科平均成绩从低到高和及格率的百分数从高到低顺序
SELECT c.cno,avg(sc.score) as 平均分,sum(case when score>=60 then 1 else 0 end)/count(*) as 合格率
FROM courses c
RIGHT JOIN sc
ON c.cno = sc.cno
GROUP BY c.cno
ORDER BY 平均分, 合格率;

select cno,avg(score),sum(case when score>=60 then 1 else 0 end)/count(*)
as 及格率
from sc group by cno
order by avg(score) , 及格率 desc;
--19、查询不同老师所教不同课程平均分从高到低显示
SELECT t.tno,c.cno,avg(sc.score) as 平均分
FROM teachers t
LEFT JOIN courses c
ON t.tno = c.tno
RIGHT JOIN sc
ON c.cno = sc.cno
GROUP BY t.tno,c.cno
ORDER BY 平均分 desc;
--20、统计列印各科成绩,各分数段人数:课程ID,课程名称,[100-85],[85-70],[70-60],[ <60]
SELECT sc.cno,c.cname, 
sum(case when score between 85 and 100 then 1 else 0 end) as "[100-85]",
sum(case when score between 70 and 85 then 1 else 0 end) as "[85-70]",
sum(case when score between 60 and 70 then 1 else 0 end) as "[70-60]",
sum(case when score < 60 then 1 else 0 end) as "[<60]"
FROM sc,courses c
WHERE sc.cno = c.cno
GROUP BY sc.cno,c.cname;
--21、查询各科成绩前三名的记录:(不考虑成绩并列情况)
SELECT distinct sc.sno,sc.cno,sc.score 
FROM sc
WHERE (select count(*) FROM sc)<3;

select * from
(select sno,cno,score,row_number() over
(partition by cno order by score desc) rn from sc)
where rn<4;
--22、查询每门课程被选修的学生数
SELECT c.cno,count(*)
FROM courses c
LEFT JOIN sc
ON c.cno = sc.cno
GROUP BY c.cno;
--23、查询出只选修了一门课程的全部学生的学号和姓名
SELECT s.sno,s.sname,count(*)
FROM students s
LEFT JOIN sc 
ON s.sno = sc.sno
GROUP BY s.sno,s.sname
HAVING count(*) = 1;
--24、查询男生、女生人数
SELECT s.sex,count(*)
FROM students s
GROUP BY s.sex;
--25、查询姓“张”的学生名单
SELECT s.*
FROM students s
WHERE s.sname like '张%';
--26、查询同名同姓学生名单，并统计同名人数
select sname,count(*)
from students  
group by sname
having count(*)>1;
--27、1981 年出生的学生名单(注：Student 表中Sage 列的类型是number)
select sno,sname,sage,sex from students t where to_char(sysdate,'yyyy')-sage =1988;
--28、查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列
SELECT sc.cno,avg(sc.score) as 平均分
FROM sc
GROUP BY sc.cno
ORDER BY 平均分 asc,sc.cno desc;
--29、查询平均成绩大于75 的所有学生的学号、姓名和平均成绩
SELECT s.sno,s.sname,avg(sc.score) as 平均分
FROM students s
LEFT JOIN sc 
ON s.sno = sc.sno
GROUP BY s.sno,s.sname
HAVING avg(sc.score)>75;
--30、查询课程名称为“数据库”，且分数低于60 的学生姓名和分数
SELECT c.cname,s.sname,sc.score
FROM courses c
LEFT JOIN sc
ON c.cno = sc.cno
LEFT JOIN students s
ON sc.sno = s.sno
WHERE c.cname = 'Oracle' AND sc.score < 60;
--31、查询所有学生的选课情况；
SELECT s.sno,s.sname,c.cno,cname
FROM students s
LEFT JOIN sc
ON s.sno = sc.sno
LEFT JOIN courses c
ON sc.cno = c.cno;
--32、查询任何一门课程成绩在70 分以上的姓名、课程名称和分数；
SELECT s.sname,c.cname,sc.score
FROM students s
LEFT JOIN sc 
ON s.sno = sc.sno
LEFT JOIN courses c
ON sc.cno = c.cno
WHERE sc.score > 70;
--33、查询不及格的课程，并按课程号从大到小排列
SELECT sc.score,sc.cno 
FROM sc
WHERE sc.score < 60
ORDER BY sc.cno desc;
--34、查询课程编号为c001 且课程成绩在80 分以上的学生的学号和姓名；
SELECT s.sno,s.sname
FROM students s 
LEFT JOIN sc
ON s.sno = sc.sno
WHERE sc.cno = 'c001' AND sc.score > 80;
--35、求选了课程的学生人数
SELECT count(*)
FROM (SELECT distinct sc.sno
FROM sc);

SELECT count(distinct sno)
FROM sc;
--36、查询选修“谌燕”老师所授课程的学生中，成绩最高的学生姓名及其成绩
SELECT s.sname,sc.score
FROM students s
LEFT JOIN sc
ON s.sno = sc.sno
LEFT JOIN courses c
ON sc.cno = c.cno
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '王燕' AND sc.score = (SELECT max(score) FROM sc);
--37、查询各个课程及相应的选修人数
SELECT c.cno,c.cname,count(*)
FROM courses c
LEFT JOIN sc
ON c.cno = sc.cno
GROUP BY c.cno,c.cname;
--38、查询不同课程成绩相同的学生的学号、课程号、学生成绩
SELECT sc.sno,sc.cno,sc.score
FROM sc
LEFT JOIN sc s2
ON sc.sno = s2.sno
WHERE sc.cno != s2.cno AND sc.score = s2.score;

select a.* from sc a ,sc b where a.score=b.score and a.cno<>b.cno;
--39、查询每门功课成绩最好的前两名
--40、统计每门课程的学生选修人数（超过4 人的课程才统计）。
--要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
SELECT sc.cno,count(*) as 人数
FROM sc
GROUP BY sc.cno
HAVING count(*)>=4
ORDER BY 人数 desc, sc.cno asc;
--41、检索至少选修两门课程的学生学号
SELECT sc.sno
FROM sc
GROUP BY sc.sno
HAVING count(sc.sno)>=2;
--42、查询全部学生都选修的课程的课程号和课程名
SELECT distinct sc.cno,c.cname
FROM sc 
LEFT JOIN courses c
ON sc.cno = c.cno;
--43、查询没学过“谌燕”老师讲授的任一门课程的学生姓名
SELECT s.sname 
FROM students s
WHERE s.sno NOT IN
(SELECT sc.sno 
FROM sc 
LEFT JOIN courses c
ON sc.cno = c.cno
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '王燕');
--44、查询两门以上不及格课程的同学的学号及其平均成绩
SELECT sc.sno,avg(sc.score) as 平均分
FROM sc
WHERE sc.sno IN (SELECT sno FROM sc WHERE score < 60 GROUP BY sno HAVING count(*) > 1)
GROUP BY sc.sno;

SELECT sno,avg(score) 
FROM sc
WHERE sno IN 
(SELECT sno FROM sc WHERE score < 60 GROUP BY sno HAVING count(sno) > 1)
GROUP BY sno;
--45、检索“c004”课程分数小于60，按分数降序排列的同学学号
SELECT sc.sno
FROM sc
WHERE sc.cno = 'c004' AND sc.score < 60
ORDER BY sc.score desc;
--46、删除“s002”同学的“c001”课程的成绩
DELETE FROM sc WHERE sc.sno = 's002' AND sc.cno = 'c001';











