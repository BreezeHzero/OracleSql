-- ��ѯѧ����ǰ3�е�����
SELECT * FROM STUDENT WHERE ROWNUM<=3;
SELECT * FROM STUDENT WHERE STUDENTID BETWEEN 1 AND 3 ORDER BY STUDENTID; 
-- ��ѯѧ����ĵ�2������4�е�����
SELECT * FROM STUDENT WHERE STUDENTID BETWEEN 2 AND 4 ORDER BY STUDENTID;

--1 ��ѯȫ��ѧ����ѧ����������
SElECT sno,sname FROM students;
--2 ��ѯȫ��ѧ����������ѧ�š�����ϵ��
SELECT sno,sname,sdept FROM students;
--3 ��ѯȫ��ѧ������ϸ��¼��
SELECT * FROM students;
--4 ��ȫ��ѧ������������������
SELECT sname,sage FROM students;
--5 ��ȫ��ѧ����������������ݺ�����ϵ
SELECT sname,sage,sdept FROM students;
--6 ��Ѱ����ѡ���˿γ̵�ѧ����ѧ��
SELECT sno FROM sc WHERE cno IS NOT NULL;
--7 ������ϵȫ��ѧ��������
SELECT * FROM students WHERE sdept = 'CS';
--8 ������������20�����µ�ѧ�������������䡣
SELECT sname,sage FROM students WHERE sage<20;
--9 ��ѯ���Գɼ��в������ѧ����ѧ��
SELECT sno FROM sc WHERE grade<60;
--10 ��ѯ������20��23��֮���ѧ����������ϵ�𡢺�����
SELECT sname,sdept,sage FROM students WHERE sage BETWEEN 20 AND 23; 
--11 ��ѯ���䲻��20��23��֮���ѧ��������ϵ�������
SELECT sname,sdept,sage FROM students WHERE sage NOT BETWEEN 20 AND 23;
--12 ����Ϣϵ��IS������ѧϵ��MA���ͼ������ѧϵ��CS����ѧ�����������Ա�
SELECT sname,ssex FROM students WHERE sdept IN ('IS','MA','CS');
--13 ��Ȳ�����Ϣϵ����ѧϵ��Ҳ���Ǽ������ѧϵ��ѧ�����������Ա�
SELECT sname,ssex FROM students WHERE sdept NOT IN ('IS','MA','CS');
--14 ������������ѧ����������ѧ�ź��Ա�
SELECT sname,sno,ssex FROM students WHERE sname LIKE '��%';
--15 ���ա�ŷ������ȫ��Ϊ�������ֵ�ѧ����������
SELECT sname FROM students WHERE sname LIKE 'ŷ��_';
--16 �������еڶ���Ϊ�������ֵ�ѧ����������ѧ�š�
SELECT sname,sno FROM students WHERE sname LIKE '_��%';
--17 �����в�������ѧ��������
SELECT sname FROM students WHERE sname NOT LIKE '��%';
--18 ��DB_Design�γ̵Ŀγ̺ź�ѧ�֡�
SELECT cno,ccredit FROM courses WHERE cname LIKE 'DB\_Design' ESCAPE '\';
--19 ���ԡ�DB_����ͷ���ҵ����������ַ�Ϊi�Ŀγ̵���ϸ���
SELECT * FROM courses WHERE cname LIKE 'DB\_%i__' ESCAPE '\';
--20 ��ѯһ��ȱ�ٳɼ���ѧ����ѧ�ź���Ӧ�Ŀγ̺�
SELECT sno,cno FROM sc WHERE grade IS NULL;
--21 ��ѯ�����гɼ���¼��ѧ����ѧ�źͿγ̺�
SELECT sno,cno FROM sc WHERE grade IS NOT NULL;
--22 ��ѯCSϵ������20�����µ�ѧ��������
SELECT sname FROM students WHERE sdept='CS' AND sage < 20;
--23 ��ѯѡ����3�ſγ̵�ѧ����ѧ�ż���ɼ�����ѯ����������Ľ������С�
SELECT sno,grade FROM sc WHERE cno = '3' ORDER BY grade DESC;
