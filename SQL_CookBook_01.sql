SELECT * 
FROM emp;
--查找部门10中所有的员工，所有得到提成的员工，以及部门20中工资不超过2000美金的员工
SELECT *
FROM emp
WHERE deptno=10
AND comm IS NOT NULL;
--条件是10号部门，+comm IS NOT NULL的
SELECT *
FROM emp
WHERE deptno=10
OR comm IS NOT NULL;
--带OR两条条件都执行
SELECT *
FROM emp
WHERE deptno=10
OR comm IS NULL;

SELECT * 
FROM emp
WHERE deptno=10 --这里10号部门的comm为空
--OR comm IS NOT NULL
OR sal <= 2000 AND deptno=20;

--这里显示数据中sal<=2000 deptno=20里面有>2000的是因为 有一个并列条件comm IS NOT NULL
SELECT *
FROM emp
WHERE deptno=10
OR comm IS NOT NULL
OR sal<=2000 AND deptno=20; 

SELECT *
FROM emp
WHERE deptno=20 AND 
comm IS NOT NULL
AND sal<=2000;

--带括号
SELECT *
FROM emp
WHERE deptno=20 AND(
comm IS NOT NULL
OR sal<=2000
);
--不带括号
SELECT * 
FROM emp
WHERE deptno=20 
AND comm IS NOT NULL  --这里deptno=20和commIS NOT NULL是一个条件 sal<=2000是另一个条件
OR sal<=2000;

SELECT *
FROM emp
WHERE (
deptno=10
OR comm IS NOT NULL
OR sal<=2000
) AND deptno=20;

--检索部分列
SELECT ename,deptno,sal
FROM emp;

--取别名
SELECT sal AS sale, comm AS commission
FROM emp;
--Oracle 允许别名不用AS
SELECT sal salary, comm commission
FROM emp;
--这里牵扯SQL执行顺序问题，FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY
SELECT *
FROM(
SELECT sal salary, comm commission
FROM emp)
WHERE salary<2000;

--连接列值
--输出ename work as a massage   '||'是Oracle连接符
SELECT ename || ' works as a ' || job AS msg
FROM emp
WHERE deptno=10;

--SELECT 语句中使用条件逻辑
SELECT ename, sal,
CASE WHEN sal<=2000 THEN 'UNDERPAID'
     WHEN sal>=4000 THEN 'OVERPAID'
     ELSE 'OK'
     END AS STATUS --AS 后面的STATUS是别名
FROM emp;

--显示表中的行数
--Oracle里特有 rownum 来显示行数 rownum是内置函数
SELECT * 
FROM emp
WHERE rownum <= 5;
--从表中随机返回N条记录
--找空值
SELECT * 
FROM emp
WHERE comm IS NULL;
SELECT * 
FROM emp
WHERE comm IS NOT NULL;
--将空值转换成实际值
--将comm里为NULL的值换成0
SELECT coalesce(comm,0)
FROM emp;
--也可以使用CASE语句
SELECT 
CASE WHEN comm IS NULL then 0
     ELSE comm
     END
FROM emp;
--按模式搜索
SELECT ename,job
FROM emp
WHERE deptno in(10,20);
--在10到20部门的员工里，返回名字中有一个‘I’或者职务中有"ER"的员工,通配符%
SELECT ename,job
FROM emp
WHERE deptno in(10,20)
--这里的'%ER' %放在ER前，表示字符中以ER结尾的
AND (ename like '%I%' OR job like '%ER');
--'%ER%'表示字符中间有ER的
--AND (ename like '%I%' OR job like '%ER%');
--'ER%'表示以ER开头的
--AND (ename like '%I%' OR job like 'ER%');













