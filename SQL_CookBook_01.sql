SELECT * 
FROM emp;
--���Ҳ���10�����е�Ա�������еõ���ɵ�Ա�����Լ�����20�й��ʲ�����2000�����Ա��
SELECT *
FROM emp
WHERE deptno=10
AND comm IS NOT NULL;
--������10�Ų��ţ�+comm IS NOT NULL��
SELECT *
FROM emp
WHERE deptno=10
OR comm IS NOT NULL;
--��OR����������ִ��
SELECT *
FROM emp
WHERE deptno=10
OR comm IS NULL;

SELECT * 
FROM emp
WHERE deptno=10 --����10�Ų��ŵ�commΪ��
--OR comm IS NOT NULL
OR sal <= 2000 AND deptno=20;

--������ʾ������sal<=2000 deptno=20������>2000������Ϊ ��һ����������comm IS NOT NULL
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

--������
SELECT *
FROM emp
WHERE deptno=20 AND(
comm IS NOT NULL
OR sal<=2000
);
--��������
SELECT * 
FROM emp
WHERE deptno=20 
AND comm IS NOT NULL  --����deptno=20��commIS NOT NULL��һ������ sal<=2000����һ������
OR sal<=2000;

SELECT *
FROM emp
WHERE (
deptno=10
OR comm IS NOT NULL
OR sal<=2000
) AND deptno=20;

--����������
SELECT ename,deptno,sal
FROM emp;

--ȡ����
SELECT sal AS sale, comm AS commission
FROM emp;
--Oracle �����������AS
SELECT sal salary, comm commission
FROM emp;
--����ǣ��SQLִ��˳�����⣬FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY
SELECT *
FROM(
SELECT sal salary, comm commission
FROM emp)
WHERE salary<2000;

--������ֵ
--���ename work as a massage   '||'��Oracle���ӷ�
SELECT ename || ' works as a ' || job AS msg
FROM emp
WHERE deptno=10;

--SELECT �����ʹ�������߼�
SELECT ename, sal,
CASE WHEN sal<=2000 THEN 'UNDERPAID'
     WHEN sal>=4000 THEN 'OVERPAID'
     ELSE 'OK'
     END AS STATUS --AS �����STATUS�Ǳ���
FROM emp;

--��ʾ���е�����
--Oracle������ rownum ����ʾ���� rownum�����ú���
SELECT * 
FROM emp
WHERE rownum <= 5;
--�ӱ����������N����¼
--�ҿ�ֵ
SELECT * 
FROM emp
WHERE comm IS NULL;
SELECT * 
FROM emp
WHERE comm IS NOT NULL;
--����ֵת����ʵ��ֵ
--��comm��ΪNULL��ֵ����0
SELECT coalesce(comm,0)
FROM emp;
--Ҳ����ʹ��CASE���
SELECT 
CASE WHEN comm IS NULL then 0
     ELSE comm
     END
FROM emp;
--��ģʽ����
SELECT ename,job
FROM emp
WHERE deptno in(10,20);
--��10��20���ŵ�Ա���������������һ����I������ְ������"ER"��Ա��,ͨ���%
SELECT ename,job
FROM emp
WHERE deptno in(10,20)
--�����'%ER' %����ERǰ����ʾ�ַ�����ER��β��
AND (ename like '%I%' OR job like '%ER');
--'%ER%'��ʾ�ַ��м���ER��
--AND (ename like '%I%' OR job like '%ER%');
--'ER%'��ʾ��ER��ͷ��
--AND (ename like '%I%' OR job like 'ER%');













