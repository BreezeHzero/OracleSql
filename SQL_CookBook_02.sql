--�������� ���õ��޸Ľ�������ǲ�ѯ���Ľ�����ÿ�
--��ʾ����10��Ա�������֣�ְλ�͹��ʣ������չ��ʵ���������
SELECT ename,sal,job
FROM emp
WHERE deptno = 10
ORDER BY sal asc;
SELECT ename,sal,job
FROM emp
WHERE deptno = 10
ORDER BY sal desc;
-- ����ֶ�����
--asc��
SELECT empno,deptno,sal,ename,job
FROM emp
ORDER BY deptno,sal asc;
--desc��
SELECT ename,deptno,sal,ename,job
FROM emp
ORDER BY deptno,sal desc;
--�ֶ���������ַ�����
SELECT ename,job
FROM emp
ORDER BY substr(job,length(job)-2);
--�п�ֵ��Ҫָ���Ƿ񽫿�ֵ�������(ORACLEĬ�ϵĽ���ֵ�������)
SELECT ename,sal,comm
FROM emp
ORDER BY 3;
SELECT ename,sal,comm
FROM emp
ORDER BY 3 desc;

--����������ļ�����
SELECT ename,sal,job,comm
FROM emp
ORDER BY CASE WHEN job = 'SALESMAN'
              THEN comm else sal 
              END;











