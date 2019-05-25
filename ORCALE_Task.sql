-- 查询学生表前3行的数据
SELECT * FROM STUDENT WHERE ROWNUM<=3;
SELECT * FROM STUDENT WHERE STUDENTID BETWEEN 1 AND 3 ORDER BY STUDENTID; 
-- 查询学生表的第2行至第4行的数据
SELECT * FROM STUDENT WHERE STUDENTID BETWEEN 2 AND 4 ORDER BY STUDENTID;

--1 查询全体学生的学号与姓名。
SElECT sno,sname FROM students;
--2 查询全体学生的姓名、学号、所在系。
SELECT sno,sname,sdept FROM students;
--3 查询全体学生的详细记录。
SELECT * FROM students;
--4 查全体学生的姓名及其出生年份
SELECT sname,sage FROM students;
--5 查全体学生的姓名、出生年份和所在系
SELECT sname,sage,sdept FROM students;
--6 查寻所有选修了课程的学生的学号
SELECT sno FROM sc WHERE cno IS NOT NULL;
--7 查计算机系全体学生的名单
SELECT * FROM students WHERE sdept = 'CS';
--8 查所有年龄在20岁以下的学生姓名及其年龄。
SELECT sname,sage FROM students WHERE sage<20;
--9 查询考试成绩有不及格的学生的学号
SELECT sno FROM sc WHERE grade<60;
--10 查询年龄在20至23岁之间的学生的姓名、系别、和年龄
SELECT sname,sdept,sage FROM students WHERE sage BETWEEN 20 AND 23; 
--11 查询年龄不在20至23岁之间的学生姓名、系别和年龄
SELECT sname,sdept,sage FROM students WHERE sage NOT BETWEEN 20 AND 23;
--12 查信息系（IS）、数学系（MA）和计算机科学系（CS）的学生的姓名和性别
SELECT sname,ssex FROM students WHERE sdept IN ('IS','MA','CS');
--13 查既不是信息系、数学系，也不是计算机科学系的学生的姓名和性别
SELECT sname,ssex FROM students WHERE sdept NOT IN ('IS','MA','CS');
--14 查所有姓刘的学生的姓名、学号和性别
SELECT sname,sno,ssex FROM students WHERE sname LIKE '刘%';
--15 查姓“欧阳”且全名为三个汉字的学生的姓名。
SELECT sname FROM students WHERE sname LIKE '欧阳_';
--16 查名字中第二字为“阳”字的学生的姓名和学号。
SELECT sname,sno FROM students WHERE sname LIKE '_阳%';
--17 查所有不姓刘的学生姓名。
SELECT sname FROM students WHERE sname NOT LIKE '刘%';
--18 查DB_Design课程的课程号和学分。
SELECT cno,ccredit FROM courses WHERE cname LIKE 'DB\_Design' ESCAPE '\';
--19 查以“DB_”开头，且倒数第三个字符为i的课程的详细情况
SELECT * FROM courses WHERE cname LIKE 'DB\_%i__' ESCAPE '\';
--20 查询一下缺少成绩的学生的学号和相应的课程号
SELECT sno,cno FROM sc WHERE grade IS NULL;
--21 查询所有有成绩记录的学生的学号和课程号
SELECT sno,cno FROM sc WHERE grade IS NOT NULL;
--22 查询CS系年龄在20岁以下的学生姓名。
SELECT sname FROM students WHERE sdept='CS' AND sage < 20;
--23 查询选修了3号课程的学生的学号及其成绩，查询结果按分数的降序排列。
SELECT sno,grade FROM sc WHERE cno = '3' ORDER BY grade DESC;
