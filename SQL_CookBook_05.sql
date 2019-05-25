--插(insert into table_name values())，删(delete from)，更(update table_name set where) ALTER 是修改表结构
SELECT * FROM t1;
SELECT * FROM D;

--从一个表中查询出的数据插入到另一张表中，分两种情况
--目标表不存在
CREATE TABLE T1 AS SELECT * FROM emp;
--目标表存在
INSERT INTO T1 (SELECT * FROM emp WHERE sal>1000);

INSERT INTO D (SELECT sal FROM emp WHERE sal>1000);

--单单是插入一列(列名) alter是修改表结构
ALTER TABLE D ADD new_column VARCHAR2(20);

--插入一行数据
INSERT INTO D VALUES('','5000');

--插入一列相同的数据（更新表数据）
UPDATE D SET new_column = '5000';
--删除一列数据和删除一列（包括列名）

--删除一列数据 （更新表数据）
UPDATE T1 SET  deptno= NULL;
--删除一列（列名+数据）
ALTER TABLE T1 drop column comm;

SELECT e.ename,e.deptno
FROM emp e
GROUP BY e.ename,e.deptno
HAVING  deptno > 10;

--error! ORA-00937: 不是单组分组函数
SELECT e.ename,avg(e.sal)
FROM emp e;
--其实这里也非常容易理解，你既然指定了聚合函数，又同时制定了其他列，还想不按照指定的列来分组，
--你到底想让oracle怎么做呢？
SELECT avg(sal)
FROM emp;
SELECT ename,deptno,avg(sal)
FROM emp
GROUP BY ename,deptno;

--每个部门有多少人（数一下deptno出现了几次）
SELECT deptno,count(*)
FROM emp
GROUP BY deptno;
--查询每一个部门工资大于1000，JOB为SALESMAN的人数
SELECT count(*),deptno
FROM emp
WHERE job='SALESMAN'
GROUP BY deptno,sal
HAVING sal > 1000;

--查询每一个部门员工工资大于1000的人数
SELECT deptno,count(*)
FROM emp
GROUP BY deptno,sal
HAVING sal>1000 AND deptno IS NOT NULL;

--自连接

SELECT e.job
FROM emp e,emp e1
WHERE e.empno = e1.empno;

select e.*
from emp e;



