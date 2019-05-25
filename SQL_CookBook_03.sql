--���������
--��ʾEMP ����10��Ա�������ֺͲ��ű�ţ��Լ�DEPT����ÿ��Ա�������ֺͲ��ű��
--������
--����������(��ֵ����) 
SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.deptno = 10;

SELECT e.ename, d.loc,
       e.deptno as emp_deptno,
       d.deptno as dept_deptno
FROM emp e, dept d
WHERE e.deptno = 10;

--��WHERE�Ӿ�ı��ʽ��ʹ��e.deptno��d.deptno�����ƽ������ֻ����emp.deptno��dept.deptno��ȵ���
SELECT e.ename, d.loc,
       e.deptno as emp_deptno,
       d.deptno as dept_deptno
FROM emp e,dept d
WHERE e.deptno = d.deptno
AND e.deptno = 10;

--��һ�ֽ������ ������ʾ��JOIN�Ӿ䣬��INNER�ؼ��֣��Ƽ�
SELECT e.ename, d.loc 
FROM emp e 
INNER JOIN dept d
ON (e.deptno = d.deptno)
WHERE e.deptno = 10;

--�����������й�ͬ�У����ж��п����������ӵ���������
--���磬�ȴ����������ͼV��
CREATE VIEW v
AS 
SELECT ename,job,sal
FROM emp
WHERE job = 'CLERK';

SELECT * FROM v;

--������Ҫ���ر�emp������ͼ�õ�������ƥ�������ְԱ��empno��enamel��job��sal��deptno
--Ҫ������ȷ�Ľ�������밴���б�Ҫ���н������ӡ����ߣ��������������ӣ�Ҳ����ʹ�ü��ϲ���INTERSECT,����������Ĺ�ͬ��
SELECT e.empno,e.ename,e.job,e.sal,e.deptno
FROM emp e
JOIN v
ON (e.ename = v.ename
AND e.job = v.job
AND e.sal = v.sal
);
--����
SELECT e.empno,e.ename,e.job,e.sal,e.deptno
FROM emp e,v
WHERE e.ename = v.ename
AND e.job = v.job
AND e.sal = v.sal;
--����INTERSECT ���ཻ��
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

--��һ�����в�����һ������û�е�ֵ
--����Ҫdept�в�����emp���в��������ݵ����в���
--����ʹ���Ӳ�ѯ�������Դ�������MINUS������
SELECT deptno 
FROM dept
MINUS
SELECT deptno 
FROM emp;
--�Ӳ�ѯ
SELECT deptno
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);
--DISTINCTȥ���ظ���
SELECT DISTINCT deptno
FROM dept
WHERE deptno not in(SELECT deptno FROM emp);

--Ҫ���NOT IN ��NULL �йص����⣬����ʹ��NOT EXISTS������Ӳ�ѯ
SELECT d.deptno
FROM dept d
WHERE NOT EXISTS (SELECT NULL FROM emp e WHERE d.deptno = e.deptno);

--��һ�����в�����������ƥ��ļ�¼
--��������ͬ�ؼ��ֵ�������Ҫ��һ�����в���������һ�����в�ƥ�����
--���磬Ҫ����û��ְԱ�Ĳ���
--Ҫ���Ҳ�����ÿ��Ա���Ĺ�����λ��Ҫ�ڱ�DEPTNO��EMP����һ����ֵ����
--��Ҫ�г���DEPT��   �ҳ��ڱ�EMP����û�еĲ��ű��
--�ɰ汾д��
SELECT d.*
FROM dept d,emp e
WHERE d.deptno = e.deptno(+)
AND e.deptno IS NULL;
--�°汾д��
SELECT d.*
FROM dept d
LEFT OUTER JOIN emp e
ON (d.deptno = e.deptno)
WHERE e.deptno IS NULL;

--�����Ӻ������ӵ�����
SELECT e.ename, e.deptno emp_deptno,d.*
FROM dept d
LEFT JOIN emp e
ON (d.deptno = e.deptno);

SELECT e.ename, e.deptno emp_deptno,d.*
FROM dept d
RIGHT JOIN emp e
ON (e.deptno = d.deptno);

--����һ����emp_bonus
CREATE TABLE emp_bonus(
empno VARCHAR2(20) PRIMARY KEY,
received VARCHAR2(20) NOT NULL,
TYPE NUMBER NOT NULL
);

SELECT * FROM emp_bonus;

SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;
--�����뽫ÿ��Ա������õĽ��������ڼ��뵽���������
SELECT e.ename,d.loc,eb.received
FROM emp e,dept d,emp_bonus eb
WHERE e.deptno = d.deptno
AND e.empno = eb.empno;
--������ѯ��������������ǲ�������
SELECT e.ename,d.loc,eb.received
FROM emp e
JOIN dept d
ON (e.deptno = d.deptno)
LEFT JOIN emp_bonus eb
ON(e.empno = eb.empno);
--�������ñ����Ӳ�ѯ
--ORDER BY 2��ʾ����LOC�������
SELECT e.ename, d.loc,(SELECT eb.received FROM emp_bonus eb WHERE eb.empno = e.empno) received
FROM emp e,dept d
WHERE e.deptno = d.deptno
ORDER BY 2;

--������������Ƿ�����ͬ������
CREATE VIEW v1
AS SELECT * FROM emp WHERE deptno != 10
UNION ALL
SELECT * FROM emp WHERE ename = 'WARD';

SELECT * FROM v1;

--ʹ�ü������㺯��MINUS��UNION ALL��V1�ͱ�EMP�Ĳ���Լ�emp��v1�Ĳ��������ϲ�
--���������
--1.���ҳ�emp����v1��û�е��� MINUS����
--2.Ȼ��ϲ���UNION ALL������ͼv1�д��ڣ���emp��û�е��С�
--�ںϲ�ʱ��Ҫ��֤������ͬ
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

--����ȫ������
SELECT count(*) FROM emp;
--count(����) ������ж������Ƿ��зǿ�
SELECT count(comm) FROM emp;

SELECT count(*) FROM emp
UNION
SELECT count(*) FROM dept;

--ʶ��������ѿ�������������������ϣ�
SELECT e.ename,d.loc
FROM emp e,dept d
WHERE e.deptno = 10;

--���� ����1��
SELECT e.ename,d.loc
FROM emp e,dept d
WHERE e.deptno = 10
AND e.deptno = d.deptno;
--����2�����Ƽ���
--дINNER JOIN �� JOIN û������
SELECT e.ename,d.loc
FROM emp e
JOIN dept d
ON (e.deptno = d.deptno)
WHERE e.deptno = 10;

--�ۼ�������
--���磺Ҫ���Ҳ���10������Ա���Ĺ��ʺϼƺͽ���ϼơ�
--������ЩԱ���Ľ����¼��ֹһ������emp��emp_bonus֮�������ӻᵼ�¾ۼ�����sum���ֵ����
SELECT * FROM emp_bonus;

SELECT e.empno,e.ename,e.sal,e.deptno,e.sal
* CASE WHEN eb.type = 1 THEN .1
       WHEN eb.type = 2 THEN .2
       ELSE .3
       END BONUS
FROM emp e,emp_bonus eb
WHERE e.empno = eb.empno
AND e.deptno = 20;
--��ʼ���㽱������
--Ϊ�˼��㽱����������emp_bonus�����ӣ����ִ���
CREATE TABLE emp_bonus(
empno varchar2(2) PRIMARY KEY,
received date NOT NULL,
type number NOT NULL
);

SELECT deptno,sum(sal) total_sal,sum��bonus��total_bonus
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

--ͬʱ���ض�����ж�ʧ�����ݣ��ӱ�dept,�з���emp�����ڵ��У�����û��Ա���Ĳ��ţ���Ҫ�������ӡ�
SELECT d.deptno,d.dname,e.ename
FROM dept d
LEFT OUTER JOIN emp e
ON (d.deptno = e.deptno);

--����һ����Ա�������Ա���������κβ���
INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
SELECT 1111,'YODA','JEDI',NULL,hiredate,sal,comm,NULL
FROM emp
WHERE ename = 'KING';

--����ȴ������ԭ���Ĳ���
SELECT d.deptno,d.dname,e.ename 
FROM dept d
RIGHT OUTER JOIN emp e
ON (d.deptno = e.deptno);

--ʹ��ȫ���������
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
























