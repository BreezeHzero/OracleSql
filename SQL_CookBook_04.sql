SELECT deptno FROM dept_accidents GROUP BY deptno HAVING COUNT(*)>=3;
