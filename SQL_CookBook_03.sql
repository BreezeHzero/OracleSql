--操作多个表
--显示EMP 表部门10中员工的名字和部门编号，以及DEPT表中每个员工的名字和部门编号
--内连接
--两表行连接(等值连接) 
SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.deptno = 10;

SELECT e.ename, d.loc,
       e.deptno as emp_deptno,
       d.deptno as dept_deptno
FROM emp e, dept d
WHERE e.deptno = 10;

--在WHERE子句的表达式中使用e.deptno和d.deptno来限制结果集，只返回emp.deptno和dept.deptno相等的行
SELECT e.ename, d.loc,
       e.deptno as emp_deptno,
       d.deptno as dept_deptno
FROM emp e,dept d
WHERE e.deptno = d.deptno
AND e.deptno = 10;

--另一种解决方案 利用显示的JOIN子句，（INNER关键字）推荐
SELECT e.ename, d.loc 
FROM emp e 
INNER JOIN dept d
ON (e.deptno = d.deptno)
WHERE e.deptno = 10;

--查找连个表中共同行，但有多列可以用来联接的这两个表
--例如，先创建下面的视图V：
CREATE VIEW v
AS 
SELECT ename,job,sal
FROM emp
WHERE job = 'CLERK';

SELECT * FROM v;

--现在需要返回表emp中与视图得到的行相匹配的所有职员的empno，enamel，job，sal和deptno
--要返回正确的结果，必须按所有必要的列进行联接。或者，如果不想进行联接，也可以使用集合操作INTERSECT,返回两个表的共同行
SELECT e.empno,e.ename,e.job,e.sal,e.deptno
FROM emp e
JOIN v
ON (e.ename = v.ename
AND e.job = v.job
AND e.sal = v.sal
);
--或者
SELECT e.empno,e.ename,e.job,e.sal,e.deptno
FROM emp e,v
WHERE e.ename = v.ename
AND e.job = v.job
AND e.sal = v.sal;
--或者INTERSECT （相交）
SELECT empno,ename,job,sal,deptno
FROM emp
WHERE (
(ename,job,sal)
IN
(SELECT ename,job,sal
FROM emp
INTERSECT
SELECT ename,job,sal
from v)
);

--从一个表中查找另一个表中没有的值
--例如要dept中查找在emp表中不存在数据的所有部门
--可以使用子查询，或者自带求差集函数MINUS（减）
SELECT deptno 
FROM dept
MINUS
SELECT deptno 
FROM emp;
--子查询
SELECT deptno
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);
--DISTINCT去掉重复行
SELECT DISTINCT deptno
FROM dept
WHERE deptno not in(SELECT deptno FROM emp);

--要解决NOT IN 和NULL 有关的问题，可以使用NOT EXISTS和相关子查询
SELECT d.deptno
FROM dept d
WHERE NOT EXISTS (SELECT NULL FROM emp e WHERE d.deptno = e.deptno);

--在一个表中查找与其他表不匹配的记录
--对于有相同关键字的两个表，要在一个表中查找与另外一个表中不匹配的行
--例如，要查找没有职员的部门
--要查找部门中每个员工的工作岗位需要在表DEPTNO及EMP中有一个等值连接
--需要列出表DEPT中   找出在表EMP表中没有的部门编号
--旧版本写法
SELECT d.*
FROM dept d,emp e
WHERE d.deptno = e.deptno(+)
AND e.deptno IS NULL;
--新版本写法
SELECT d.*
FROM dept d
LEFT OUTER JOIN emp e
ON (d.deptno = e.deptno)
WHERE e.deptno IS NULL;

--左连接和外连接的区别
SELECT e.ename, e.deptno emp_deptno,d.*
FROM dept d
LEFT JOIN emp e
ON (d.deptno = e.deptno);

SELECT e.ename, e.deptno emp_deptno,d.*
FROM dept d
RIGHT JOIN emp e
ON (e.deptno = d.deptno);

--创建一个表emp_bonus
CREATE TABLE emp_bonus(
empno VARCHAR2(20) PRIMARY KEY,
received VARCHAR2(20) NOT NULL,
TYPE NUMBER NOT NULL
);

SELECT * FROM emp_bonus;

SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;
--现在想将每个员工所获得的奖励的日期加入到结果数据中
SELECT e.ename,d.loc,eb.received
FROM emp e,dept d,emp_bonus eb
WHERE e.deptno = d.deptno
AND e.empno = eb.empno;
--这样查询结果会少所以我们采用联接
SELECT e.ename,d.loc,eb.received
FROM emp e
JOIN dept d
ON (e.deptno = d.deptno)
LEFT JOIN emp_bonus eb
ON(e.empno = eb.empno);
--还可以用标量子查询
--ORDER BY 2表示是以LOC来排序的
SELECT e.ename, d.loc,(SELECT eb.received FROM emp_bonus eb WHERE eb.empno = e.empno) received
FROM emp e,dept d
WHERE e.deptno = d.deptno
ORDER BY 2;

--检测两个表中是否有相同的数据
CREATE VIEW v1
AS SELECT * FROM emp WHERE deptno != 10
UNION ALL
SELECT * FROM emp WHERE ename = 'WARD';

SELECT * FROM v1;

--使用集合运算函数MINUS和UNION ALL求V1和表EMP的差表，以及emp和v1的差集，两个差集合并
--解决方案是
--1.查找出emp表在v1中没有的行 MINUS函数
--2.然后合并（UNION ALL）在试图v1中存在，而emp中没有的行。
--在合并时，要保证列名相同
(SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno,count(*) as cnt
FROM v1
GROUP BY empno,ename,job,mgr,hiredate,sal,comm,deptno
MINUS
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno,count(*) as cnt
FROM emp
GROUP BY empno,ename,job,mgr,hiredate,sal,comm,deptno
)
UNION ALL
(SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno,count(*) as cnt
FROM emp
GROUP BY empno,ename,job,mgr,hiredate,sal,comm,deptno
MINUS
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno,count(*) as cnt
FROM v1
GROUP BY empno,ename,job,mgr,hiredate,sal,comm,deptno);

--GROUP BY
SELECT deptno,count(*)
FROM emp
WHERE sal>2000
GROUP BY deptno;

--检索全部的列
SELECT count(*) FROM emp;
--count(列名) 这个会判断列中是否有非空
SELECT count(comm) FROM emp;

SELECT count(*) FROM emp
UNION
SELECT count(*) FROM dept;

--识别和消除笛卡儿积（数据列排列组合）
SELECT e.ename,d.loc
FROM emp e,dept d
WHERE e.deptno = 10;

--消除 方法1：
SELECT e.ename,d.loc
FROM emp e,dept d
WHERE e.deptno = 10
AND e.deptno = d.deptno;
--方法2：（推荐）
--写INNER JOIN 和 JOIN 没有区别
SELECT e.ename,d.loc
FROM emp e
JOIN dept d
ON (e.deptno = d.deptno)
WHERE e.deptno = 10;

--聚集与联接
--例如：要查找部门10中所有员工的工资合计和奖金合计。
--由于有些员工的奖金记录不止一条，在emp和emp_bonus之间作联接会导致聚集函数sum算的值错误
SELECT * FROM emp_bonus;

SELECT e.empno,e.ename,e.sal,e.deptno,e.sal
* CASE WHEN eb.type = 1 THEN .1
       WHEN eb.type = 2 THEN .2
       ELSE .3
       END BONUS
FROM emp e,emp_bonus eb
WHERE e.empno = eb.empno
AND e.deptno = 20;
--开始计算奖金总数
--为了计算奖金总数而和emp_bonus做联接，出现错误
CREATE TABLE emp_bonus(
empno varchar2(2) PRIMARY KEY,
received date NOT NULL,
type number NOT NULL
);

SELECT deptno,sum(sal) total_sal,sum（bonus）total_bonus
FROM(
SELECT e.empno,e.ename,e.sal,e.deptno,e.sal
* CASE WHEN eb.type = 1 THEN .1
       WHEN eb.type = 2 THEN .2
       ELSE .3
       END BONUS
FROM emp e,emp_bonus eb
WHERE e.empno = eb.empno
AND e.deptno = 20) x
GROUP BY deptno;

--同时返回多个表中丢失的数据，从表dept,中返回emp不存在的行（所有没有员工的部门）需要做外联接。
SELECT d.deptno,d.dname,e.ename
FROM dept d
LEFT OUTER JOIN emp e
ON (d.deptno = e.deptno);

--插入一个新员工，这个员工不属于任何部门
INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
SELECT 1111,'YODA','JEDI',NULL,hiredate,sal,comm,NULL
FROM emp
WHERE ename = 'KING';

--这样却丢掉了原来的部门
SELECT d.deptno,d.dname,e.ename 
FROM dept d
RIGHT OUTER JOIN emp e
ON (d.deptno = e.deptno);

--使用全连接来解决
SELECT d.deptno,d.dname,e.ename
FROM dept d
FULL JOIN emp e
ON(d.deptno = e.deptno);

SELECT d.deptno,d.dname,e.ename
FROM dept d
LEFT JOIN emp e
ON(d.deptno = e.deptno)
UNION
SELECT d.deptno,d.dname,e.ename
FROM dept d
RIGHT JOIN emp e
ON(d.deptno = e.deptno);
























