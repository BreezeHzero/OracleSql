--表名，字段名

--STUDETN (s_id,s_name,s_birth,s_sex)
--COURSE(c_id,c_name,t_id)
--TEACHER(t_id,t_name)
--SCORE(s_id,c_id,s_score)
CREATE TABLE STUDENT(
    s_id VARCHAR2(20) PRIMARY KEY,
    s_name VARCHAR2(20) NOT NULL,
    s_birth VARCHAR2(20) NOT NULL,
    s_sex VARCHAR2(10) NOT NULL
);
CREATE TABLE COURSE(
    c_id VARCHAR2(20) PRIMARY KEY,
    c_name VARCHAR2(20) NOT NULL,
    t_id VARCHAR2(20) NOT NULL
);
CREATE TABLE TEACHER(
    t_id VARCHAR2(20) PRIMARY KEY,
    t_name VARCHAR2(20) NOT NULL
);
CREATE TABLE SCORE(
    s_id VARCHAR2(20),
    c_id VARCHAR2(20) NOT NULL,
    s_score VARCHAR2(20) NOT NULL,
    PRIMARY KEY (s_id,c_id)
);
--学生表
INSERT INTO STUDENT VALUES('01','张琪','1998-03-31','女');
INSERT INTO STUDENT VALUES('02','赵祺瑞','1996-02-05','男');
INSERT INTO STUDENT VALUES('03','王保保','1997-12-11','女');
INSERT INTO STUDENT VALUES('04','张无忌','1990-08-15','男');
INSERT INTO STUDENT VALUES('05','韩小咩','2000-03-05','男');
INSERT INTO STUDENT VALUES('06','张小琪','1995-5-25','女');
INSERT INTO STUDENT VALUES('07','杜瑞','1993-6-28','男');
SELECT * FROM STUDENT ORDER BY 1;
UPDATE STUDENT SET s_birth = '1995-05-25' WHERE s_id = '06';
UPDATE STUDENT SET s_birth = '1993-06-28' WHERE s_id = '07';
UPDATE STUDENT SET s_name = '赵琪瑞' WHERE s_id = '02';
--课程表
INSERT INTO COURSE VALUES('01','语文','02');
INSERT INTO COURSE VALUES('02','数学','01');
INSERT INTO COURSE VALUES('03','英语','05');
INSERT INTO COURSE VALUES('04','体育','04');
SELECT * FROM COURSE;
--教师表
INSERT INTO TEACHER VALUES('01','谢广坤');
INSERT INTO TEACHER VALUES('02','赵四');
INSERT INTO TEACHER VALUES('03','谢逊');
INSERT INTO TEACHER VALUES('04','张翠山');
INSERT INTO TEACHER VALUES('05','张三丰');
SELECT * FROM TEACHER;
--成绩表
INSERT INTO SCORE VALUES('01','01','80');
INSERT INTO SCORE VALUES('01','02','88');
INSERT INTO SCORE VALUES('01','03','99');
INSERT INTO SCORE VALUES('01','04','50');
INSERT INTO SCORE VALUES('02','01','77');
INSERT INTO SCORE VALUES('02','02','50');
INSERT INTO SCORE VALUES('02','03','80');
INSERT INTO SCORE VALUES('03','02','60');
INSERT INTO SCORE VALUES('03','04','89');
INSERT INTO SCORE VALUES('04','01','66');
INSERT INTO SCORE VALUES('04','02','77');
INSERT INTO SCORE VALUES('05','03','54');
INSERT INTO SCORE VALUES('05','04','80');
INSERT INTO SCORE VALUES('06','01','87');
INSERT INTO SCORE VALUES('07','02','');
INSERT INTO SCORE VALUES('06','02','60');
INSERT INTO SCORE VALUES('06','03','77');
INSERT INTO SCORE VALUES('06','04','59');
INSERT INTO SCORE VALUES('02','04','55');
SELECT * FROM SCORE;
--1、查询"01"课程比"02"课程成绩高的学生的信息及课程分数
--方法1：
SELECT s.*,sc.s_score,sc_b.s_score
FROM student s
LEFT JOIN score sc
ON s.s_id = sc.s_id AND sc.c_id = '01'
LEFT JOIN score sc_b
ON s.s_id = sc_b.s_id AND sc_b.c_id = '02' OR sc_b.c_id = NULL
WHERE sc.s_score > sc_b.s_score;
--方法2：
SELECT s.*, a.s_score, b.s_score
FROM student s,score a,score b
WHERE s.s_id = a.s_id AND s.s_id = b.s_id
AND a.c_id = '01' AND b.c_id = '02'
AND a.s_score > b.s_score;
--查询选了“01”课程和“02”课程的学生信息
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id AND a.s_id = '01' AND a.s_id = '02'
ORDER BY 1;
--查询选了“01”课程的学生信息及成绩
--为了查看JOIN ON AND 和 JOIN ON WHERE 的区别 写了下面三个查询

--这里的s.s_id = a.s_id 已经将student里全部人数统计出来
SELECT DISTINCT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id 
ORDER BY 1;

--JOIN ON AND 这个是将student和score联接，并且查询出“01”分数
SELECT s.*,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id AND a.c_id = '01';

--这里的 WHERE条件就是对查询出来的s.s_id = a.s_id筛选，筛选出a.c_id = '01'的人并显示分数
SELECT s.*,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.c_id = '01';
--查询选了“01”课程和“02”课程的学生信息及成绩(就是说有人选了01，有人选了02，有人全选了)
SELECT s.*,a.s_score,b.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id AND a.c_id = '01'
LEFT JOIN score b
ON s.s_id = b.s_id AND b.c_id = '02'
ORDER BY 1;
--查询同时选了“01”课程和“02”课程的学生信息的及成绩
SELECT s.*,a.s_score,b.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id 
LEFT JOIN score b 
ON s.s_id = b.s_id 
WHERE  a.c_id = '01' AND b.c_id = '02'
ORDER BY 1;

-- 2、查询"01"课程比"02"课程成绩低的学生的信息及课程分数
SELECT s.*,a.s_score,b.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id AND a.c_id = '01' OR a.c_id = NULL
LEFT JOIN score b
ON s.s_id = b.s_id AND b.c_id = '02'
WHERE a.s_score < b.s_score;

SELECT s.*,a.s_score,b.s_score
FROM student s,score a,score b
WHERE s.s_id = a.s_id AND s.s_id = b.s_id 
AND a.c_id = '01' AND b.c_id = '02' AND a.s_score < b.s_score;

-- 3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
SELECT s.s_id, s.s_name,avg(a.s_score)
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
HAVING avg(a.s_score) >= 60;

-- 4、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩
SELECT s.s_id,s.s_name,avg(a.s_score)
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
HAVING avg(a.s_score) < 60;

-- 5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
SELECT s.s_id,s.s_name,count(a.c_id),sum(a.s_score)
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
ORDER BY 1;

-- 6、查询"张"姓老师的数量
SELECT count(t_id)
FROM teacher 
WHERE t_name like '张%';

-- 7、查询学过"张翠山"老师授课的同学的信息
--方法1：
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN course b
ON a.c_id = b.c_id
LEFT JOIN teacher c
ON b.t_id = c.t_id
WHERE c.t_name = '张翠山'
ORDER BY 1;
--方法2：
SELECT s.*
FROM student s
WHERE s.s_id IN 
(SELECT s_id FROM score WHERE c_id IN 
(SELECT c_id FROM course WHERE t_id IN 
(SELECT t_id FROM teacher WHERE t_name = '张翠山')));

-- 8、查询没学过"张翠山"老师授课的同学的信息
SELECT s.*
FROM student s
WHERE s.s_id NOT IN 
(SELECT s_id FROM score WHERE c_id IN 
(SELECT c_id FROM course WHERE t_id IN 
(SELECT t_id FROM teacher WHERE t_name = '张翠山')));

-- 9、查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息
--方法1：
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN score b
ON s.s_id = b.s_id
WHERE a.c_id = '01' AND b.c_id = '02';

--注意: 这里如果在一张表里查询 即选了01的又选了02的，会查不出来
--因为一张表查出来的是单维的
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id 
WHERE a.c_id = '01' AND a.c_id = '02';
--应该是这样
--先查选了'01'的
SELECT s.*
FROM student s
LEFT JOIN score a 
ON s.s_id = a.s_id
WHERE a.c_id = '01';
--再查选了'02'的
SELECT s.*
FROM student s
LEFT JOIN score b
ON s.s_id = b.s_id
WHERE b.c_id = '02';
--将两张表联立
SELECT s.*
FROM student s
LEFT JOIN score a 
ON s.s_id = a.s_id
LEFT JOIN score b
ON s.s_id = b.s_id
WHERE a.c_id = '01' AND b.c_id = '02';
--方法2：
SELECT s.*
FROM student s,score a,score b
WHERE s.s_id = a.s_id 
AND s.s_id = b.s_id 
AND a.c_id = '01' 
AND b.c_id = '02';

-- 10、查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE s.s_id IN
(SELECT s_id FROM score WHERE c_id = '01') AND s.s_id NOT IN
(SELECT s_id FROM score WHERE c_id = '02'); --???哈哈哈哈

SELECT s.*
FROM student s
WHERE s.s_id IN 
(SELECT s_id FROM score WHERE c_id = '01') AND s.s_id NOT IN 
(SELECT s_id FROM score WHERE c_id = '02');

-- 11、查询没有学全所有课程的同学的信息
--(查询没有学全所有课程的，也就是说学生选的课程小于课程表里课程的总数)
--(也就是说条件是：学生选的课程数小于课程表里课程总数的学生)
--方法1：
SELECT s.*
FROM student s 
WHERE s.s_id NOT IN 
(SELECT a.s_id FROM score a 
GROUP BY a.s_id 
HAVING count(*) = (SELECT count(distinct c.c_id) FROM course c));

--统计课程表里的课程数（不重复）
SELECT count(distinct c_id) FROM course;

--统计选了全部课程的学生
SELECT a.s_id FROM score a
GROUP BY a.s_id
HAVING count(*) = (SELECT count(c_id) FROM course);

--查询学生信息，不包括选了全部课程的学生
SELECT s.*
FROM student s
WHERE s.s_id NOT IN 
(SELECT s_id FROM score 
GROUP BY s_id 
HAVING count(*) = (SELECT count(c_id) FROM course));

--方法2：
SELECT s.s_id,s.s_name,s.s_birth,s_sex
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name,s.s_birth,s_sex
HAVING count(a.c_id) < (SELECT count(c_id) FROM course)
ORDER BY 1;

-- 12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息
--查询学号01的同学学的课程
SELECT a.c_id
FROM score a
WHERE a.s_id IN (SELECT s.s_id FROM student s WHERE s.s_id = '01');

CREATE VIEW s_id_01 AS
SELECT a.c_id
FROM score a
WHERE a.s_id IN (SELECT s.s_id FROM student s WHERE s.s_id = '01');
--方法1:
SELECT distinct s.*
FROM student s,score a
WHERE s.s_id = a.s_id AND a.c_id IN (SELECT c_id FROM s_id_01)
ORDER BY 1;
--方法2：
SELECT s.*
FROM student s
WHERE s.s_id IN 
(SELECT a.s_id FROM score a WHERE a.c_id IN 
(SELECT a.c_id FROM score a WHERE a.s_id='01'));

-- 13、查询和"01"号的同学学习的课程完全相同的其他同学的信息
--1.查询学生表里学生的信息
--2.查询这些这些学号，什么学号呢？不是01的学号
SELECT a.s_id FROM score a WHERE a.s_id != '01';
--3.将这些学号分组，条件是统计这些同学们选的课程数=01同学选的课程数
SELECT a.s_id FROM score a WHERE a.s_id != '01'
GROUP BY a.s_id;
--4.联立2和3得到符合条件的同学的学号
SELECT a.s_id FROM score a WHERE a.s_id != '01'
GROUP BY a.s_id
HAVING count(*) = (SELECT count(c_id) FROM score WHERE s_id = '01');
--5.根据学号查询出该同学的信息
SELECT s.* FROM student s WHERE s.s_id IN
(SELECT b.s_id FROM score b WHERE b.s_id != '01'
GROUP BY b.s_id HAVING COUNT(1) = 
(SELECT COUNT(1) FROM score c WHERE c.s_id = '01'));

-- 14、查询没学过"张翠山"老师讲授的任一门课程的学生姓名 
--1.先找到张翠山教的课程的c_id
SELECT c.c_id FROM course c,teacher t WHERE c.t_id = t.t_id AND t_name = '张翠山';
--2.再找到学生选的课程有张翠山的c_id的学生的学号
SELECT a.s_id FROM score a WHERE a.c_id IN (
SELECT c.c_id FROM course c,teacher t WHERE c.t_id = t.t_id AND t_name = '张翠山'
);
--3.排除2.中的学生
SELECT s.s_name 
FROM student s
WHERE s.s_id NOT IN 
(SELECT a.s_id FROM score a WHERE a.c_id IN (
SELECT c.c_id FROM course c,teacher t WHERE c.t_id = t.t_id AND t_name = '张翠山'
));

-- 15、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩 
SELECT s.s_id,s.s_name,avg(a.s_score)
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE s.s_id IN 
(SELECT a.s_id FROM score a WHERE a.s_score < 60 GROUP BY a.s_id HAVING count(a.s_score)>=2)
GROUP BY s.s_id,s.s_name;

-- 16、检索"04"课程分数小于60，按分数降序排列的学生信息
--方法1：
SELECT distinct s.*,a.c_id,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.c_id = '04' AND a.s_score < 60 
ORDER BY a.s_score DESC;
--方法2：
SELECT s.*
FROM student s, score a
WHERE s.s_id = a.s_id AND a.c_id = '04' AND a.s_score < 60
ORDER BY a.s_score desc;

-- 17、按 平均成绩 从高到低 显示 所有 学生的 所有课程的 成绩 以及 平均成绩
SELECT a.s_id,(SELECT s_score FROM score WHERE s_id = a.s_id AND c_id = '01') AS 语文,
              (SELECT s_score FROM score WHERE s_id = a.s_id AND c_id = '02') AS 数学,
              (SELECT s_score FROM score WHERE s_id = a.s_id AND c_id = '03') AS 英语,
              (SELECT s_score FROM score WHERE s_id = a.s_id AND c_id = '04') AS 体育,
              avg(s_score) AS 平均分 
FROM score a GROUP BY a.s_id
ORDER BY 平均分 DESC;

-- 18.查询各科成绩最高分、最低分和平均分：以如下形式显示：(有问题)
--课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
SELECT a.c_id,c.c_name,max(a.s_score),min(a.s_score),avg(a.s_score),
ROUND(100*(sum(case when a.s_score >= 60 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end)),2) AS 及格率,
ROUND(100*(sum(case when a.s_score >= 70 and a.s_score < 80 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end)),2) AS 中等率,
ROUND(100*(sum(case when a.s_score >= 80 and a.s_score < 90 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end)),2) AS 优良率,
ROUND(100*(sum(case when a.s_score >= 90 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end)),2) AS 优秀率
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
GROUP BY a.c_id,c.c_name;

-- 19、按各科成绩进行排序，并显示排名
select data.*
from (select
        score.s_score as score2,
        score.s_id,
        score.c_id,
        student.s_name,
        course.c_name,
        rank()over(order by score.s_score desc) 排名
      from score score
        join course course on course.c_id = score.c_id
        join student student on student.s_id = score.s_id
      ) data;
-- 20、查询学生的总成绩并进行排名
SELECT s.s_id, sum(a.s_score) AS 总成绩,rank()over(ORDER BY sum(a.s_score) desc) AS 排名
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY s.s_id;

-- 21、查询不同老师所教不同课程平均分从高到低显示
SELECT c.t_id,t.t_name,c.c_name,avg(a.s_score) AS 平均分
FROM course c
LEFT JOIN score a
ON c.c_id = a.c_id
LEFT JOIN teacher t
ON c.t_id = t.t_id
GROUP BY c.t_id,t.t_name,c.c_name
ORDER BY 平均分 DESC;

-- 22、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩

-- 24、查询学生平均成绩及其名次
SELECT s.s_id,avg(a.s_score) 平均成绩,rank()over(order by avg(a.s_score) desc) 名次
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id  
WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY s.s_id;

-- 25、查询各科成绩前三名的记录
SELECT a.s_id,a.c_id,a.s_score
FROM score a
LEFT JOIN score b
ON a.c_id = b.c_id AND a.s_score<b.s_score
WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY a.s_id,a.c_id,a.s_score
HAVING count(b.s_id)<3
ORDER BY a.c_id,a.s_score desc;

SELECT a.s_id,a.c_id,a.s_score
FROM score a
LEFT JOIN score b
ON a.c_id = b.c_id AND a.s_score<b.s_score
WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY a.s_id,a.c_id,a.s_score
--HAVING count(b.s_id)<3
ORDER BY a.c_id,a.s_score desc;

SELECT a.s_id,a.c_id,a.s_score
FROM score a
LEFT JOIN score b
ON a.c_id = b.c_id AND a.s_score<b.s_score
--WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY a.s_id,a.c_id,a.s_score
ORDER BY a.c_id,a.s_score desc;


-- 26、查询每门课程被选修的学生数
SELECT c.c_id,count(a.c_id) 学生数
FROM course c
LEFT JOIN score a
ON c.c_id = a.c_id
GROUP BY c.c_id;

--方法2：
SELECT a.c_id,count(a.c_id) 学生数
FROM score a
GROUP BY a.c_id;

-- 27、查询出只有两门课程的全部学生的学号和姓名
SELECT s.s_id,s.s_name
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
HAVING count(a.c_id) = 2;

-- 28、查询男生、女生人数 
SELECT s_sex,count(s_sex) 人数
FROM student 
GROUP BY s_sex;

SELECT count(*)
FROM student;

-- 29、查询名字中含有"琪"字的学生信息
SELECT s.*
FROM student s
WHERE s.s_name LIKE '%琪%';

--名字中间含有“琪”的
SELECT *
FROM student 
WHERE s_name LIKE '%_琪_%';

--名字最后一个是“琪”的
SELECT *
FROM student 
WHERE s_name LIKE '%_琪';

-- 30、查询同名同性学生名单，并统计同名人数 (数据表中没有同名同性)
SELECT s.s_id,s.s_name,s.s_sex,count(*) 人数
FROM student s
JOIN student s1
ON s.s_id != s1.s_id AND s.s_name = s1.s_name AND s.s_sex = s1.s_sex
GROUP BY s.s_id, s.s_name,s.s_sex;

-- 31、查询1990年出生的学生名单
SELECT s.s_id,s.s_name,s.s_birth
FROM student s
WHERE s.s_birth LIKE '1990%';

-- 32、查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
SELECT c.c_id,avg(a.s_score) 平均成绩
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
GROUP BY c.c_id
ORDER BY 平均成绩 desc,c.c_id asc;

--查询结果相同，默认相等升序
SELECT c.c_id,avg(a.s_score) 平均成绩
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
GROUP BY c.c_id
ORDER BY 平均成绩 desc;

-- 33、查询平均成绩大于等于70的所有学生的学号、姓名和平均成绩
SELECT s.s_id,s.s_name,avg(a.s_score) 平均成绩
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
HAVING avg(a.s_score) >70;

-- 34、查询课程名称为"数学"，且分数低于60的学生姓名和分数
SELECT s.s_name,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.c_id IN (SELECT c_id FROM course WHERE c_name = '数学')AND a.s_score < 60;

-- 35、查询所有学生的课程及分数情况；
SELECT s.s_id,s.s_name,c.c_name,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN course c
ON a.c_id = c.c_id;

-- 36、查询任何一门课程成绩在70分以上的姓名、课程名称和分数；
SELECT s.s_name,c.c_name,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN course c
ON a.c_id = c.c_id
WHERE a.s_score >= 70;

-- 37、查询不及格的课程
SELECT a.s_id,a.c_id,c.c_name
FROM course c
LEFT JOIN score a
ON c.c_id = a.c_id
WHERE a.s_score < 60;

--38、查询课程编号为01且课程成绩在80分以上的学生的学号和姓名；
SELECT s.s_id,s.s_name
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.c_id = '01' AND a.s_score >= 80;

-- 39、求每门课程的学生人数 
SELECT a.c_id,c.c_name,count(*) 人数
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
GROUP BY a.c_id,c.c_name;

-- 40、查询选修"张翠山"老师所授课程的学生中，成绩最高的学生信息及其成绩
--查询选了张翠山老师的课程的学号
SELECT s.s_id
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN course c
ON a.c_id = c.c_id
LEFT JOIN teacher t
ON c.t_id = t.t_id
WHERE t.t_name = '张翠山';

--查询选了张翠山课程中最高的成绩(这个查出来的是成绩)
SELECT max(a.s_score)
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
LEFT JOIN teacher t
ON c.t_id = t.t_id
WHERE t.t_name = '张翠山';

--找学生信息(根据成绩找出学生)
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.s_score in 
(SELECT max(a.s_score)
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
LEFT JOIN teacher t
ON c.t_id = t.t_id
WHERE t.t_name = '张翠山');

-- 41、查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩
SELECT a.s_id,a.c_id,a.s_score
FROM score a
LEFT JOIN score a1
ON a.s_id = a1.s_id
WHERE a.c_id != a1.c_id AND a.s_score = a1.s_score;

-- 42、查询每门功成绩最好的前两名 
SELECT a.s_id,a.c_id,a.s_score
FROM score a
WHERE (SELECT count(1) FROM score a1 WHERE a.c_id = a1.c_id AND a1.s_score>=a.s_score)<=2
AND a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
ORDER BY a.c_id;

--43、统计每门课程的学生选修人数（超过5人的课程才统计）。
--要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列  
SELECT a.c_id,count(*) 人数
FROM score a
GROUP BY a.c_id
HAVING count(*)>=5;

-- 44、检索至少选修两门课程的学生学号
SELECT distinct a.s_id
FROM score a
WHERE (SELECT count(*) FROM score b WHERE a.s_id = b.s_id)>=2;

-- 45、查询选修了全部课程的学生信息 
SELECT *
FROM student 
WHERE s_id IN 
(SELECT s_id FROM score GROUP BY s_id);

SELECT *
FROM student 
WHERE s_id IN 
(SELECT s_id FROM score GROUP BY s_id HAVING count(*)=(SELECT count(*) FROM course));

SELECT s_id FROM score GROUP BY s_id;
SELECT count(*) FROM course;





