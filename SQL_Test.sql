--�������ֶ���

--STUDETN (s_id,s_name,s_birth,s_sex)
--COURSE(c_id,c_name,t_id)
--TEACHER(t_id,t_name)
--SCORE(s_id,c_id,s_score)
CREATE TABLE STUDENT(
    s_id VARCHAR2(20) PRIMARY KEY,
    s_name VARCHAR2(20) NOT NULL,
    s_birth VARCHAR2(20) NOT NULL,
    s_sex VARCHAR2(10) NOT NULL
);
CREATE TABLE COURSE(
    c_id VARCHAR2(20) PRIMARY KEY,
    c_name VARCHAR2(20) NOT NULL,
    t_id VARCHAR2(20) NOT NULL
);
CREATE TABLE TEACHER(
    t_id VARCHAR2(20) PRIMARY KEY,
    t_name VARCHAR2(20) NOT NULL
);
CREATE TABLE SCORE(
    s_id VARCHAR2(20),
    c_id VARCHAR2(20) NOT NULL,
    s_score VARCHAR2(20) NOT NULL,
    PRIMARY KEY (s_id,c_id)
);
--ѧ����
INSERT INTO STUDENT VALUES('01','����','1998-03-31','Ů');
INSERT INTO STUDENT VALUES('02','������','1996-02-05','��');
INSERT INTO STUDENT VALUES('03','������','1997-12-11','Ů');
INSERT INTO STUDENT VALUES('04','���޼�','1990-08-15','��');
INSERT INTO STUDENT VALUES('05','��С��','2000-03-05','��');
INSERT INTO STUDENT VALUES('06','��С��','1995-5-25','Ů');
INSERT INTO STUDENT VALUES('07','����','1993-6-28','��');
SELECT * FROM STUDENT ORDER BY 1;
UPDATE STUDENT SET s_birth = '1995-05-25' WHERE s_id = '06';
UPDATE STUDENT SET s_birth = '1993-06-28' WHERE s_id = '07';
UPDATE STUDENT SET s_name = '������' WHERE s_id = '02';
--�γ̱�
INSERT INTO COURSE VALUES('01','����','02');
INSERT INTO COURSE VALUES('02','��ѧ','01');
INSERT INTO COURSE VALUES('03','Ӣ��','05');
INSERT INTO COURSE VALUES('04','����','04');
SELECT * FROM COURSE;
--��ʦ��
INSERT INTO TEACHER VALUES('01','л����');
INSERT INTO TEACHER VALUES('02','����');
INSERT INTO TEACHER VALUES('03','лѷ');
INSERT INTO TEACHER VALUES('04','�Ŵ�ɽ');
INSERT INTO TEACHER VALUES('05','������');
SELECT * FROM TEACHER;
--�ɼ���
INSERT INTO SCORE VALUES('01','01','80');
INSERT INTO SCORE VALUES('01','02','88');
INSERT INTO SCORE VALUES('01','03','99');
INSERT INTO SCORE VALUES('01','04','50');
INSERT INTO SCORE VALUES('02','01','77');
INSERT INTO SCORE VALUES('02','02','50');
INSERT INTO SCORE VALUES('02','03','80');
INSERT INTO SCORE VALUES('03','02','60');
INSERT INTO SCORE VALUES('03','04','89');
INSERT INTO SCORE VALUES('04','01','66');
INSERT INTO SCORE VALUES('04','02','77');
INSERT INTO SCORE VALUES('05','03','54');
INSERT INTO SCORE VALUES('05','04','80');
INSERT INTO SCORE VALUES('06','01','87');
INSERT INTO SCORE VALUES('07','02','');
INSERT INTO SCORE VALUES('06','02','60');
INSERT INTO SCORE VALUES('06','03','77');
INSERT INTO SCORE VALUES('06','04','59');
INSERT INTO SCORE VALUES('02','04','55');
SELECT * FROM SCORE;
--1����ѯ"01"�γ̱�"02"�γ̳ɼ��ߵ�ѧ������Ϣ���γ̷���
--����1��
SELECT s.*,sc.s_score,sc_b.s_score
FROM student s
LEFT JOIN score sc
ON s.s_id = sc.s_id AND sc.c_id = '01'
LEFT JOIN score sc_b
ON s.s_id = sc_b.s_id AND sc_b.c_id = '02' OR sc_b.c_id = NULL
WHERE sc.s_score > sc_b.s_score;
--����2��
SELECT s.*, a.s_score, b.s_score
FROM student s,score a,score b
WHERE s.s_id = a.s_id AND s.s_id = b.s_id
AND a.c_id = '01' AND b.c_id = '02'
AND a.s_score > b.s_score;
--��ѯѡ�ˡ�01���γ̺͡�02���γ̵�ѧ����Ϣ
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id AND a.s_id = '01' AND a.s_id = '02'
ORDER BY 1;
--��ѯѡ�ˡ�01���γ̵�ѧ����Ϣ���ɼ�
--Ϊ�˲鿴JOIN ON AND �� JOIN ON WHERE ������ д������������ѯ

--�����s.s_id = a.s_id �Ѿ���student��ȫ������ͳ�Ƴ���
SELECT DISTINCT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id 
ORDER BY 1;

--JOIN ON AND ����ǽ�student��score���ӣ����Ҳ�ѯ����01������
SELECT s.*,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id AND a.c_id = '01';

--����� WHERE�������ǶԲ�ѯ������s.s_id = a.s_idɸѡ��ɸѡ��a.c_id = '01'���˲���ʾ����
SELECT s.*,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.c_id = '01';
--��ѯѡ�ˡ�01���γ̺͡�02���γ̵�ѧ����Ϣ���ɼ�(����˵����ѡ��01������ѡ��02������ȫѡ��)
SELECT s.*,a.s_score,b.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id AND a.c_id = '01'
LEFT JOIN score b
ON s.s_id = b.s_id AND b.c_id = '02'
ORDER BY 1;
--��ѯͬʱѡ�ˡ�01���γ̺͡�02���γ̵�ѧ����Ϣ�ļ��ɼ�
SELECT s.*,a.s_score,b.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id 
LEFT JOIN score b 
ON s.s_id = b.s_id 
WHERE  a.c_id = '01' AND b.c_id = '02'
ORDER BY 1;

-- 2����ѯ"01"�γ̱�"02"�γ̳ɼ��͵�ѧ������Ϣ���γ̷���
SELECT s.*,a.s_score,b.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id AND a.c_id = '01' OR a.c_id = NULL
LEFT JOIN score b
ON s.s_id = b.s_id AND b.c_id = '02'
WHERE a.s_score < b.s_score;

SELECT s.*,a.s_score,b.s_score
FROM student s,score a,score b
WHERE s.s_id = a.s_id AND s.s_id = b.s_id 
AND a.c_id = '01' AND b.c_id = '02' AND a.s_score < b.s_score;

-- 3����ѯƽ���ɼ����ڵ���60�ֵ�ͬѧ��ѧ����ź�ѧ��������ƽ���ɼ�
SELECT s.s_id, s.s_name,avg(a.s_score)
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
HAVING avg(a.s_score) >= 60;

-- 4����ѯƽ���ɼ�С��60�ֵ�ͬѧ��ѧ����ź�ѧ��������ƽ���ɼ�
SELECT s.s_id,s.s_name,avg(a.s_score)
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
HAVING avg(a.s_score) < 60;

-- 5����ѯ����ͬѧ��ѧ����š�ѧ��������ѡ�����������пγ̵��ܳɼ�
SELECT s.s_id,s.s_name,count(a.c_id),sum(a.s_score)
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
ORDER BY 1;

-- 6����ѯ"��"����ʦ������
SELECT count(t_id)
FROM teacher 
WHERE t_name like '��%';

-- 7����ѯѧ��"�Ŵ�ɽ"��ʦ�ڿε�ͬѧ����Ϣ
--����1��
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN course b
ON a.c_id = b.c_id
LEFT JOIN teacher c
ON b.t_id = c.t_id
WHERE c.t_name = '�Ŵ�ɽ'
ORDER BY 1;
--����2��
SELECT s.*
FROM student s
WHERE s.s_id IN 
(SELECT s_id FROM score WHERE c_id IN 
(SELECT c_id FROM course WHERE t_id IN 
(SELECT t_id FROM teacher WHERE t_name = '�Ŵ�ɽ')));

-- 8����ѯûѧ��"�Ŵ�ɽ"��ʦ�ڿε�ͬѧ����Ϣ
SELECT s.*
FROM student s
WHERE s.s_id NOT IN 
(SELECT s_id FROM score WHERE c_id IN 
(SELECT c_id FROM course WHERE t_id IN 
(SELECT t_id FROM teacher WHERE t_name = '�Ŵ�ɽ')));

-- 9����ѯѧ�����Ϊ"01"����Ҳѧ�����Ϊ"02"�Ŀγ̵�ͬѧ����Ϣ
--����1��
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN score b
ON s.s_id = b.s_id
WHERE a.c_id = '01' AND b.c_id = '02';

--ע��: ���������һ�ű����ѯ ��ѡ��01����ѡ��02�ģ���鲻����
--��Ϊһ�ű��������ǵ�ά��
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id 
WHERE a.c_id = '01' AND a.c_id = '02';
--Ӧ��������
--�Ȳ�ѡ��'01'��
SELECT s.*
FROM student s
LEFT JOIN score a 
ON s.s_id = a.s_id
WHERE a.c_id = '01';
--�ٲ�ѡ��'02'��
SELECT s.*
FROM student s
LEFT JOIN score b
ON s.s_id = b.s_id
WHERE b.c_id = '02';
--�����ű�����
SELECT s.*
FROM student s
LEFT JOIN score a 
ON s.s_id = a.s_id
LEFT JOIN score b
ON s.s_id = b.s_id
WHERE a.c_id = '01' AND b.c_id = '02';
--����2��
SELECT s.*
FROM student s,score a,score b
WHERE s.s_id = a.s_id 
AND s.s_id = b.s_id 
AND a.c_id = '01' 
AND b.c_id = '02';

-- 10����ѯѧ�����Ϊ"01"����û��ѧ�����Ϊ"02"�Ŀγ̵�ͬѧ����Ϣ
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE s.s_id IN
(SELECT s_id FROM score WHERE c_id = '01') AND s.s_id NOT IN
(SELECT s_id FROM score WHERE c_id = '02'); --???��������

SELECT s.*
FROM student s
WHERE s.s_id IN 
(SELECT s_id FROM score WHERE c_id = '01') AND s.s_id NOT IN 
(SELECT s_id FROM score WHERE c_id = '02');

-- 11����ѯû��ѧȫ���пγ̵�ͬѧ����Ϣ
--(��ѯû��ѧȫ���пγ̵ģ�Ҳ����˵ѧ��ѡ�Ŀγ�С�ڿγ̱���γ̵�����)
--(Ҳ����˵�����ǣ�ѧ��ѡ�Ŀγ���С�ڿγ̱���γ�������ѧ��)
--����1��
SELECT s.*
FROM student s 
WHERE s.s_id NOT IN 
(SELECT a.s_id FROM score a 
GROUP BY a.s_id 
HAVING count(*) = (SELECT count(distinct c.c_id) FROM course c));

--ͳ�ƿγ̱���Ŀγ��������ظ���
SELECT count(distinct c_id) FROM course;

--ͳ��ѡ��ȫ���γ̵�ѧ��
SELECT a.s_id FROM score a
GROUP BY a.s_id
HAVING count(*) = (SELECT count(c_id) FROM course);

--��ѯѧ����Ϣ��������ѡ��ȫ���γ̵�ѧ��
SELECT s.*
FROM student s
WHERE s.s_id NOT IN 
(SELECT s_id FROM score 
GROUP BY s_id 
HAVING count(*) = (SELECT count(c_id) FROM course));

--����2��
SELECT s.s_id,s.s_name,s.s_birth,s_sex
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name,s.s_birth,s_sex
HAVING count(a.c_id) < (SELECT count(c_id) FROM course)
ORDER BY 1;

-- 12����ѯ������һ�ſ���ѧ��Ϊ"01"��ͬѧ��ѧ��ͬ��ͬѧ����Ϣ
--��ѯѧ��01��ͬѧѧ�Ŀγ�
SELECT a.c_id
FROM score a
WHERE a.s_id IN (SELECT s.s_id FROM student s WHERE s.s_id = '01');

CREATE VIEW s_id_01 AS
SELECT a.c_id
FROM score a
WHERE a.s_id IN (SELECT s.s_id FROM student s WHERE s.s_id = '01');
--����1:
SELECT distinct s.*
FROM student s,score a
WHERE s.s_id = a.s_id AND a.c_id IN (SELECT c_id FROM s_id_01)
ORDER BY 1;
--����2��
SELECT s.*
FROM student s
WHERE s.s_id IN 
(SELECT a.s_id FROM score a WHERE a.c_id IN 
(SELECT a.c_id FROM score a WHERE a.s_id='01'));

-- 13����ѯ��"01"�ŵ�ͬѧѧϰ�Ŀγ���ȫ��ͬ������ͬѧ����Ϣ
--1.��ѯѧ������ѧ������Ϣ
--2.��ѯ��Щ��Щѧ�ţ�ʲôѧ���أ�����01��ѧ��
SELECT a.s_id FROM score a WHERE a.s_id != '01';
--3.����Щѧ�ŷ��飬������ͳ����Щͬѧ��ѡ�Ŀγ���=01ͬѧѡ�Ŀγ���
SELECT a.s_id FROM score a WHERE a.s_id != '01'
GROUP BY a.s_id;
--4.����2��3�õ�����������ͬѧ��ѧ��
SELECT a.s_id FROM score a WHERE a.s_id != '01'
GROUP BY a.s_id
HAVING count(*) = (SELECT count(c_id) FROM score WHERE s_id = '01');
--5.����ѧ�Ų�ѯ����ͬѧ����Ϣ
SELECT s.* FROM student s WHERE s.s_id IN
(SELECT b.s_id FROM score b WHERE b.s_id != '01'
GROUP BY b.s_id HAVING COUNT(1) = 
(SELECT COUNT(1) FROM score c WHERE c.s_id = '01'));

-- 14����ѯûѧ��"�Ŵ�ɽ"��ʦ���ڵ���һ�ſγ̵�ѧ������ 
--1.���ҵ��Ŵ�ɽ�̵Ŀγ̵�c_id
SELECT c.c_id FROM course c,teacher t WHERE c.t_id = t.t_id AND t_name = '�Ŵ�ɽ';
--2.���ҵ�ѧ��ѡ�Ŀγ����Ŵ�ɽ��c_id��ѧ����ѧ��
SELECT a.s_id FROM score a WHERE a.c_id IN (
SELECT c.c_id FROM course c,teacher t WHERE c.t_id = t.t_id AND t_name = '�Ŵ�ɽ'
);
--3.�ų�2.�е�ѧ��
SELECT s.s_name 
FROM student s
WHERE s.s_id NOT IN 
(SELECT a.s_id FROM score a WHERE a.c_id IN (
SELECT c.c_id FROM course c,teacher t WHERE c.t_id = t.t_id AND t_name = '�Ŵ�ɽ'
));

-- 15����ѯ���ż������ϲ�����γ̵�ͬѧ��ѧ�ţ���������ƽ���ɼ� 
SELECT s.s_id,s.s_name,avg(a.s_score)
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE s.s_id IN 
(SELECT a.s_id FROM score a WHERE a.s_score < 60 GROUP BY a.s_id HAVING count(a.s_score)>=2)
GROUP BY s.s_id,s.s_name;

-- 16������"04"�γ̷���С��60���������������е�ѧ����Ϣ
--����1��
SELECT distinct s.*,a.c_id,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.c_id = '04' AND a.s_score < 60 
ORDER BY a.s_score DESC;
--����2��
SELECT s.*
FROM student s, score a
WHERE s.s_id = a.s_id AND a.c_id = '04' AND a.s_score < 60
ORDER BY a.s_score desc;

-- 17���� ƽ���ɼ� �Ӹߵ��� ��ʾ ���� ѧ���� ���пγ̵� �ɼ� �Լ� ƽ���ɼ�
SELECT a.s_id,(SELECT s_score FROM score WHERE s_id = a.s_id AND c_id = '01') AS ����,
              (SELECT s_score FROM score WHERE s_id = a.s_id AND c_id = '02') AS ��ѧ,
              (SELECT s_score FROM score WHERE s_id = a.s_id AND c_id = '03') AS Ӣ��,
              (SELECT s_score FROM score WHERE s_id = a.s_id AND c_id = '04') AS ����,
              avg(s_score) AS ƽ���� 
FROM score a GROUP BY a.s_id
ORDER BY ƽ���� DESC;

-- 18.��ѯ���Ƴɼ���߷֡���ͷֺ�ƽ���֣���������ʽ��ʾ��(������)
--�γ�ID���γ�name����߷֣���ͷ֣�ƽ���֣������ʣ��е��ʣ������ʣ�������
SELECT a.c_id,c.c_name,max(a.s_score),min(a.s_score),avg(a.s_score),
ROUND(100*(sum(case when a.s_score >= 60 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end)),2) AS ������,
ROUND(100*(sum(case when a.s_score >= 70 and a.s_score < 80 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end)),2) AS �е���,
ROUND(100*(sum(case when a.s_score >= 80 and a.s_score < 90 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end)),2) AS ������,
ROUND(100*(sum(case when a.s_score >= 90 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end)),2) AS ������
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
GROUP BY a.c_id,c.c_name;

-- 19�������Ƴɼ��������򣬲���ʾ����
select data.*
from (select
        score.s_score as score2,
        score.s_id,
        score.c_id,
        student.s_name,
        course.c_name,
        rank()over(order by score.s_score desc) ����
      from score score
        join course course on course.c_id = score.c_id
        join student student on student.s_id = score.s_id
      ) data;
-- 20����ѯѧ�����ܳɼ�����������
SELECT s.s_id, sum(a.s_score) AS �ܳɼ�,rank()over(ORDER BY sum(a.s_score) desc) AS ����
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY s.s_id;

-- 21����ѯ��ͬ��ʦ���̲�ͬ�γ�ƽ���ִӸߵ�����ʾ
SELECT c.t_id,t.t_name,c.c_name,avg(a.s_score) AS ƽ����
FROM course c
LEFT JOIN score a
ON c.c_id = a.c_id
LEFT JOIN teacher t
ON c.t_id = t.t_id
GROUP BY c.t_id,t.t_name,c.c_name
ORDER BY ƽ���� DESC;

-- 22����ѯ���пγ̵ĳɼ���2������3����ѧ����Ϣ���ÿγ̳ɼ�

-- 24����ѯѧ��ƽ���ɼ���������
SELECT s.s_id,avg(a.s_score) ƽ���ɼ�,rank()over(order by avg(a.s_score) desc) ����
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id  
WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY s.s_id;

-- 25����ѯ���Ƴɼ�ǰ�����ļ�¼
SELECT a.s_id,a.c_id,a.s_score
FROM score a
LEFT JOIN score b
ON a.c_id = b.c_id AND a.s_score<b.s_score
WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY a.s_id,a.c_id,a.s_score
HAVING count(b.s_id)<3
ORDER BY a.c_id,a.s_score desc;

SELECT a.s_id,a.c_id,a.s_score
FROM score a
LEFT JOIN score b
ON a.c_id = b.c_id AND a.s_score<b.s_score
WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY a.s_id,a.c_id,a.s_score
--HAVING count(b.s_id)<3
ORDER BY a.c_id,a.s_score desc;

SELECT a.s_id,a.c_id,a.s_score
FROM score a
LEFT JOIN score b
ON a.c_id = b.c_id AND a.s_score<b.s_score
--WHERE a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
GROUP BY a.s_id,a.c_id,a.s_score
ORDER BY a.c_id,a.s_score desc;


-- 26����ѯÿ�ſγ̱�ѡ�޵�ѧ����
SELECT c.c_id,count(a.c_id) ѧ����
FROM course c
LEFT JOIN score a
ON c.c_id = a.c_id
GROUP BY c.c_id;

--����2��
SELECT a.c_id,count(a.c_id) ѧ����
FROM score a
GROUP BY a.c_id;

-- 27����ѯ��ֻ�����ſγ̵�ȫ��ѧ����ѧ�ź�����
SELECT s.s_id,s.s_name
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
HAVING count(a.c_id) = 2;

-- 28����ѯ������Ů������ 
SELECT s_sex,count(s_sex) ����
FROM student 
GROUP BY s_sex;

SELECT count(*)
FROM student;

-- 29����ѯ�����к���"��"�ֵ�ѧ����Ϣ
SELECT s.*
FROM student s
WHERE s.s_name LIKE '%��%';

--�����м京�С�������
SELECT *
FROM student 
WHERE s_name LIKE '%_��_%';

--�������һ���ǡ�������
SELECT *
FROM student 
WHERE s_name LIKE '%_��';

-- 30����ѯͬ��ͬ��ѧ����������ͳ��ͬ������ (���ݱ���û��ͬ��ͬ��)
SELECT s.s_id,s.s_name,s.s_sex,count(*) ����
FROM student s
JOIN student s1
ON s.s_id != s1.s_id AND s.s_name = s1.s_name AND s.s_sex = s1.s_sex
GROUP BY s.s_id, s.s_name,s.s_sex;

-- 31����ѯ1990�������ѧ������
SELECT s.s_id,s.s_name,s.s_birth
FROM student s
WHERE s.s_birth LIKE '1990%';

-- 32����ѯÿ�ſγ̵�ƽ���ɼ��������ƽ���ɼ��������У�ƽ���ɼ���ͬʱ�����γ̱����������
SELECT c.c_id,avg(a.s_score) ƽ���ɼ�
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
GROUP BY c.c_id
ORDER BY ƽ���ɼ� desc,c.c_id asc;

--��ѯ�����ͬ��Ĭ���������
SELECT c.c_id,avg(a.s_score) ƽ���ɼ�
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
GROUP BY c.c_id
ORDER BY ƽ���ɼ� desc;

-- 33����ѯƽ���ɼ����ڵ���70������ѧ����ѧ�š�������ƽ���ɼ�
SELECT s.s_id,s.s_name,avg(a.s_score) ƽ���ɼ�
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
GROUP BY s.s_id,s.s_name
HAVING avg(a.s_score) >70;

-- 34����ѯ�γ�����Ϊ"��ѧ"���ҷ�������60��ѧ�������ͷ���
SELECT s.s_name,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.c_id IN (SELECT c_id FROM course WHERE c_name = '��ѧ')AND a.s_score < 60;

-- 35����ѯ����ѧ���Ŀγ̼����������
SELECT s.s_id,s.s_name,c.c_name,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN course c
ON a.c_id = c.c_id;

-- 36����ѯ�κ�һ�ſγ̳ɼ���70�����ϵ��������γ����ƺͷ�����
SELECT s.s_name,c.c_name,a.s_score
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN course c
ON a.c_id = c.c_id
WHERE a.s_score >= 70;

-- 37����ѯ������Ŀγ�
SELECT a.s_id,a.c_id,c.c_name
FROM course c
LEFT JOIN score a
ON c.c_id = a.c_id
WHERE a.s_score < 60;

--38����ѯ�γ̱��Ϊ01�ҿγ̳ɼ���80�����ϵ�ѧ����ѧ�ź�������
SELECT s.s_id,s.s_name
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.c_id = '01' AND a.s_score >= 80;

-- 39����ÿ�ſγ̵�ѧ������ 
SELECT a.c_id,c.c_name,count(*) ����
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
GROUP BY a.c_id,c.c_name;

-- 40����ѯѡ��"�Ŵ�ɽ"��ʦ���ڿγ̵�ѧ���У��ɼ���ߵ�ѧ����Ϣ����ɼ�
--��ѯѡ���Ŵ�ɽ��ʦ�Ŀγ̵�ѧ��
SELECT s.s_id
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
LEFT JOIN course c
ON a.c_id = c.c_id
LEFT JOIN teacher t
ON c.t_id = t.t_id
WHERE t.t_name = '�Ŵ�ɽ';

--��ѯѡ���Ŵ�ɽ�γ�����ߵĳɼ�(�����������ǳɼ�)
SELECT max(a.s_score)
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
LEFT JOIN teacher t
ON c.t_id = t.t_id
WHERE t.t_name = '�Ŵ�ɽ';

--��ѧ����Ϣ(���ݳɼ��ҳ�ѧ��)
SELECT s.*
FROM student s
LEFT JOIN score a
ON s.s_id = a.s_id
WHERE a.s_score in 
(SELECT max(a.s_score)
FROM score a
LEFT JOIN course c
ON a.c_id = c.c_id
LEFT JOIN teacher t
ON c.t_id = t.t_id
WHERE t.t_name = '�Ŵ�ɽ');

-- 41����ѯ��ͬ�γ̳ɼ���ͬ��ѧ����ѧ����š��γ̱�š�ѧ���ɼ�
SELECT a.s_id,a.c_id,a.s_score
FROM score a
LEFT JOIN score a1
ON a.s_id = a1.s_id
WHERE a.c_id != a1.c_id AND a.s_score = a1.s_score;

-- 42����ѯÿ�Ź��ɼ���õ�ǰ���� 
SELECT a.s_id,a.c_id,a.s_score
FROM score a
WHERE (SELECT count(1) FROM score a1 WHERE a.c_id = a1.c_id AND a1.s_score>=a.s_score)<=2
AND a.s_id NOT IN (SELECT a.s_id FROM score a WHERE a.s_score IS NULL)
ORDER BY a.c_id;

--43��ͳ��ÿ�ſγ̵�ѧ��ѡ������������5�˵Ŀγ̲�ͳ�ƣ���
--Ҫ������γ̺ź�ѡ����������ѯ����������������У���������ͬ�����γ̺���������  
SELECT a.c_id,count(*) ����
FROM score a
GROUP BY a.c_id
HAVING count(*)>=5;

-- 44����������ѡ�����ſγ̵�ѧ��ѧ��
SELECT distinct a.s_id
FROM score a
WHERE (SELECT count(*) FROM score b WHERE a.s_id = b.s_id)>=2;

-- 45����ѯѡ����ȫ���γ̵�ѧ����Ϣ 
SELECT *
FROM student 
WHERE s_id IN 
(SELECT s_id FROM score GROUP BY s_id);

SELECT *
FROM student 
WHERE s_id IN 
(SELECT s_id FROM score GROUP BY s_id HAVING count(*)=(SELECT count(*) FROM course));

SELECT s_id FROM score GROUP BY s_id;
SELECT count(*) FROM course;





