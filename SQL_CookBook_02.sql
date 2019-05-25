--排序问题 更好的修改结果集，是查询出的结果更好看
--显示部门10的员工的名字，职位和工资，并按照工资的升序排列
SELECT ename,sal,job
FROM emp
WHERE deptno = 10
ORDER BY sal asc;
SELECT ename,sal,job
FROM emp
WHERE deptno = 10
ORDER BY sal desc;
-- 多个字段排序
--asc升
SELECT empno,deptno,sal,ename,job
FROM emp
ORDER BY deptno,sal asc;
--desc降
SELECT ename,deptno,sal,ename,job
FROM emp
ORDER BY deptno,sal desc;
--字段最后两个字符排序
SELECT ename,job
FROM emp
ORDER BY substr(job,length(job)-2);
--有空值的要指定是否将空值排在最后(ORACLE默认的将空值排在最后)
SELECT ename,sal,comm
FROM emp
ORDER BY 3;
SELECT ename,sal,comm
FROM emp
ORDER BY 3 desc;

--根据数据项的键排序
SELECT ename,sal,job,comm
FROM emp
ORDER BY CASE WHEN job = 'SALESMAN'
              THEN comm else sal 
              END;











