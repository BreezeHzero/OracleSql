--��(insert into table_name values())��ɾ(delete from)����(update table_name set where) ALTER ���޸ı�ṹ
SELECT * FROM t1;
SELECT * FROM D;

--��һ�����в�ѯ�������ݲ��뵽��һ�ű��У����������
--Ŀ�������
CREATE TABLE T1 AS SELECT * FROM emp;
--Ŀ������
INSERT INTO T1 (SELECT * FROM emp WHERE sal>1000);

INSERT INTO D (SELECT sal FROM emp WHERE sal>1000);

--�����ǲ���һ��(����) alter���޸ı�ṹ
ALTER TABLE D ADD new_column VARCHAR2(20);

--����һ������
INSERT INTO D VALUES('','5000');

--����һ����ͬ�����ݣ����±����ݣ�
UPDATE D SET new_column = '5000';
--ɾ��һ�����ݺ�ɾ��һ�У�����������

--ɾ��һ������ �����±����ݣ�
UPDATE T1 SET  deptno= NULL;
--ɾ��һ�У�����+���ݣ�
ALTER TABLE T1 drop column comm;

SELECT e.ename,e.deptno
FROM emp e
GROUP BY e.ename,e.deptno
HAVING  deptno > 10;

--error! ORA-00937: ���ǵ�����麯��
SELECT e.ename,avg(e.sal)
FROM emp e;
--��ʵ����Ҳ�ǳ�������⣬���Ȼָ���˾ۺϺ�������ͬʱ�ƶ��������У����벻����ָ�����������飬
--�㵽������oracle��ô���أ�
SELECT avg(sal)
FROM emp;
SELECT ename,deptno,avg(sal)
FROM emp
GROUP BY ename,deptno;

--ÿ�������ж����ˣ���һ��deptno�����˼��Σ�
SELECT deptno,count(*)
FROM emp
GROUP BY deptno;
--��ѯÿһ�����Ź��ʴ���1000��JOBΪSALESMAN������
SELECT count(*),deptno
FROM emp
WHERE job='SALESMAN'
GROUP BY deptno,sal
HAVING sal > 1000;

--��ѯÿһ������Ա�����ʴ���1000������
SELECT deptno,count(*)
FROM emp
GROUP BY deptno,sal
HAVING sal>1000 AND deptno IS NOT NULL;

--������

SELECT e.job
FROM emp e,emp e1
WHERE e.empno = e1.empno;

select e.*
from emp e;



