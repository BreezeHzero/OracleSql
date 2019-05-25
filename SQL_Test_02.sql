CREATE TABLE students(
sno VARCHAR2(10) PRIMARY KEY,
sname VARCHAR2(20),
sage NUMERIC(2),
sex VARCHAR2(5)
);
CREATE TABLE teachers(
tno VARCHAR2(10) PRIMARY KEY,
tname VARCHAR2(20)
);
CREATE TABLE courses(
cno VARCHAR2(10),
cname VARCHAR2(20),
tno VARCHAR2(20),
CONSTRAINT pk_courses PRIMARY KEY(cno,tno)
);
CREATE TABLE sc(
sno VARCHAR2(10),
cno VARCHAR2(10),
score NUMERIC(4,2),
CONSTRAINT pk_sc PRIMARY KEY(sno,cno)
);
INSERT INTO students VALUES('s001','����',23,'��');
insert into students values ('s002','����',23,'��'); 
insert into students values ('s003','����',25,'��'); 
insert into students values ('s004','����',20,'Ů'); 
insert into students values ('s005','����',20,'Ů'); 
insert into students values ('s006','�',21,'��'); 
insert into students values ('s007','����',21,'��'); 
insert into students values ('s008','����',21,'Ů');
insert into students values ('s009','������',23,'Ů');
insert into students values ('s010','����',22,'Ů');
SELECT * FROM students;
commit;
insert into teachers values ('t001', '����'); 
insert into teachers values ('t002', '����'); 
insert into teachers values ('t003', '������'); 
UPDATE teachers SET tname = '����' WHERE tno = 't002';
commit;
SELECT * FROM teachers;
insert into courses values ('c001','J2SE','t002');
insert into courses values ('c002','Java Web','t002');
insert into courses values ('c003','SSH','t001'); 
insert into courses values ('c004','Oracle','t001'); 
insert into courses values ('c005','SQL SERVER 2005','t003'); 
insert into courses values ('c006','C#','t003'); 
insert into courses values ('c007','JavaScript','t002'); 
insert into courses values ('c008','DIV+CSS','t001'); 
insert into courses values ('c009','PHP','t003');
insert into courses values ('c010','EJB3.0','t002');
commit;
SELECT * FROM courses;
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9); 
insert into sc values ('s003','c001',81.9); 
insert into sc values ('s004','c001',60.9); 
insert into sc values ('s001','c002',82.9); 
insert into sc values ('s002','c002',72.9); 
insert into sc values ('s003','c002',81.9); 
insert into sc values ('s001','c003','59');
commit;
SELECT * FROM sc;
INSERT INTO sc VALUES('s006','c004','58');
INSERT INTO sc VALUES('s001','c004','59');
--1����ѯ��c001���γ̱ȡ�c002���γ̳ɼ��ߵ�ѧ����ѧ�ţ�
SELECT s1.sno
FROM sc s1
LEFT JOIN sc s2
ON s1.sno = s2.sno AND s1.cno =  'c001' AND s2.cno = 'c002'
WHERE s1.score > s2.score;

select a.* from
(select * from sc a where a.cno='c001') a,
(select * from sc b where b.cno='c002') b
where a.sno=b.sno and a.score > b.score;

--2����ѯƽ���ɼ�����60 �ֵ�ͬѧ��ѧ�ź�ƽ���ɼ���
SELECT sno,avg(score)
FROM sc
GROUP BY sno
HAVING avg(score)>60;
--3����ѯ����ͬѧ��ѧ�š�������ѡ�������ܳɼ���
SELECT sc.sno,s.sname,count(*),sum(score)
FROM sc 
LEFT JOIN students s
ON sc.sno = s.sno
GROUP BY sc.sno,s.sname;
--4����ѯ�ա���������ʦ�ĸ�����
SELECT count(*)
FROM teachers 
WHERE tname LIKE '��%';
--5����ѯûѧ�������ࡱ��ʦ�ε�ͬѧ��ѧ�š�������
SELECT distinct s.sno,s.sname
FROM students s
WHERE s.sno NOT IN
(
SELECT sc.sno
FROM sc
WHERE sc.cno IN
(SELECT c.cno
FROM courses c
WHERE tno IN
(SELECT tno FROM teachers WHERE tname = '����'))
);

--��ѯѡ��������ʦ�γ̵�ѧ��ѧ��
SELECT distinct sno
FROM sc
WHERE cno IN
(SELECT c.cno
FROM courses c
WHERE tno IN
(SELECT tno FROM teachers WHERE tname = '����'));

--��ѯ������ʦ�Ŀγ�
SELECT c.cno
FROM courses c
WHERE tno IN
(SELECT tno FROM teachers WHERE tname = '����');

--6����ѯѧ����c001������Ҳѧ����š�c002���γ̵�ͬѧ��ѧ�š�����
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno
LEFT JOIN sc s2
ON s.sno = s2.sno
WHERE s1.sno = s2.sno AND s1.cno = 'c001' AND s2.cno = 'c002';
--7����ѯѧ�������ࡱ��ʦ���̵Ŀε�ͬѧ��ѧ�š�������
SELECT s.sno,s.sname
FROM students s
WHERE s.sno IN
(SELECT sno 
FROM sc 
WHERE cno IN
(SELECT c.cno
FROM courses c,teachers t 
WHERE c.tno = t.tno AND t.tname = '����'));

--8����ѯ�γ̱�š�c002���ĳɼ��ȿγ̱�š�c001���γ̵͵�����ͬѧ��ѧ�š�������
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno AND s1.cno = 'c001'
LEFT JOIN sc s2
ON s.sno = s2.sno AND s2.cno = 'c002'
WHERE s2.score < s1.score;

SELECT s.sno,s.sname
FROM students s,sc s1,sc s2
WHERE s.sno = s1.sno AND s.sno = s2.sno AND s1.cno = 'c001' AND s2.cno = 'c002'
AND s1.score > s2.score;
--9����ѯ���пγ̳ɼ�С��60 �ֵ�ͬѧ��ѧ�š�������
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno
WHERE s1.score < 60;
--10����ѯû��ѧȫ���пε�ͬѧ��ѧ�š�������
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno
GROUP BY s.sno,s.sname
HAVING count(cno) != 
(SELECT count(*)
FROM courses c);
--11����ѯ������һ�ſ���ѧ��Ϊ��s001����ͬѧ��ѧ��ͬ��ͬѧ��ѧ�ź�������
--��ѯs001ѡ�Ŀγ�
SELECT s1.cno
FROM sc s1
WHERE s1.sno = 's001';

SELECT distinct s.sno,s.sname
FROM students s
LEFT JOIN sc s1
ON s.sno = s1.sno
WHERE s1.cno IN 
(SELECT s2.cno
FROM sc s2
WHERE s2.sno = 's001') AND s1.sno != 's001';

SELECT distinct s.sno,s.sname
FROM students s,sc s1
WHERE s.sno = s1.sno AND s1.cno IN (SELECT s2.cno FROM sc s2 WHERE s2.sno = 's001')
AND s1.sno != 's001';
--12����ѯ����ѧ��ѧ��Ϊ��s001��ͬѧ����һ�ſε�����ͬѧѧ�ź�������
--13���ѡ�SC�����С����ࡱ��ʦ�̵Ŀεĳɼ�������Ϊ�˿γ̵�ƽ���ɼ���
UPDATE sc SET score = 
(SELECT avg(s2.score) 
FROM sc s2
LEFT JOIN courses c
ON s2.cno = c.cno
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '����'
GROUP BY sc.cno) 
WHERE cno IN  
(SELECT c.cno
FROM courses c
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '����');

SELECT * FROM sc;

SELECT distinct s1.cno
FROM sc s1
LEFT JOIN courses c
ON s1.cno = c.cno
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '����';

--����1��
--���������ҵ�ִ��ʱ�䡣
select r.FIRST_LOAD_TIME,r.* from v$sqlarea r order by r.FIRST_LOAD_TIME desc ;

--����2��
create table sc_r --����һ���±�
as
select * from sc --���������ű�
as 
of timestamp to_timestamp('2019-04-26/09:17:54','yyyy-mm-dd hh24:mi:ss');--���ʱ����ִ���޸Ĳ��������Ǹ�ʱ��

--����3��
delete  sc; --ɾ���޸Ĳ��������ű�
insert into sc select * from sc_r; --����ԭ��������

--��ѯ������ȫ���ָ�
select * FROM sc;

--14����ѯ�͡�s001���ŵ�ͬѧѧϰ�Ŀγ���ȫ��ͬ������ͬѧѧ�ź�������
SELECT s.sno,s.sname
FROM students s
LEFT JOIN sc s2
ON s.sno = s2.sno
WHERE s2.cno IN
(SELECT s1.cno
FROM sc s1
WHERE  s1.sno = 's001');

--15��ɾ��ѧϰ�����ࡱ��ʦ�ε�SC ���¼��

--16����SC ���в���һЩ��¼����Щ��¼Ҫ���������������û���Ϲ���š�c002���γ̵�ͬѧѧ�š���c002���ſε�ƽ���ɼ���
INSERT INTO sc(sno,cno,score)
SELECT distinct s.sno,sc.cno,(SELECT avg(score) FROM sc WHERE sc.cno = 'c002')
FROM students s,sc
WHERE NOT EXISTS
(SELECT * FROM sc WHERE cno = 'c002' AND sc.sno = s.sno) AND sc.cno = 'c002';
--17����ѯ���Ƴɼ���ߺ���͵ķ֣���������ʽ��ʾ���γ�ID����߷֣���ͷ�
SELECT c.cno,max(sc.score),min(sc.score) 
FROM courses c
LEFT JOIN sc
ON c.cno = sc.cno
GROUP BY c.cno;
--18��������ƽ���ɼ��ӵ͵��ߺͼ����ʵİٷ����Ӹߵ���˳��
SELECT c.cno,avg(sc.score) as ƽ����,sum(case when score>=60 then 1 else 0 end)/count(*) as �ϸ���
FROM courses c
RIGHT JOIN sc
ON c.cno = sc.cno
GROUP BY c.cno
ORDER BY ƽ����, �ϸ���;

select cno,avg(score),sum(case when score>=60 then 1 else 0 end)/count(*)
as ������
from sc group by cno
order by avg(score) , ������ desc;
--19����ѯ��ͬ��ʦ���̲�ͬ�γ�ƽ���ִӸߵ�����ʾ
SELECT t.tno,c.cno,avg(sc.score) as ƽ����
FROM teachers t
LEFT JOIN courses c
ON t.tno = c.tno
RIGHT JOIN sc
ON c.cno = sc.cno
GROUP BY t.tno,c.cno
ORDER BY ƽ���� desc;
--20��ͳ����ӡ���Ƴɼ�,������������:�γ�ID,�γ�����,[100-85],[85-70],[70-60],[ <60]
SELECT sc.cno,c.cname, 
sum(case when score between 85 and 100 then 1 else 0 end) as "[100-85]",
sum(case when score between 70 and 85 then 1 else 0 end) as "[85-70]",
sum(case when score between 60 and 70 then 1 else 0 end) as "[70-60]",
sum(case when score < 60 then 1 else 0 end) as "[<60]"
FROM sc,courses c
WHERE sc.cno = c.cno
GROUP BY sc.cno,c.cname;
--21����ѯ���Ƴɼ�ǰ�����ļ�¼:(�����ǳɼ��������)
SELECT distinct sc.sno,sc.cno,sc.score 
FROM sc
WHERE (select count(*) FROM sc)<3;

select * from
(select sno,cno,score,row_number() over
(partition by cno order by score desc) rn from sc)
where rn<4;
--22����ѯÿ�ſγ̱�ѡ�޵�ѧ����
SELECT c.cno,count(*)
FROM courses c
LEFT JOIN sc
ON c.cno = sc.cno
GROUP BY c.cno;
--23����ѯ��ֻѡ����һ�ſγ̵�ȫ��ѧ����ѧ�ź�����
SELECT s.sno,s.sname,count(*)
FROM students s
LEFT JOIN sc 
ON s.sno = sc.sno
GROUP BY s.sno,s.sname
HAVING count(*) = 1;
--24����ѯ������Ů������
SELECT s.sex,count(*)
FROM students s
GROUP BY s.sex;
--25����ѯ�ա��š���ѧ������
SELECT s.*
FROM students s
WHERE s.sname like '��%';
--26����ѯͬ��ͬ��ѧ����������ͳ��ͬ������
select sname,count(*)
from students  
group by sname
having count(*)>1;
--27��1981 �������ѧ������(ע��Student ����Sage �е�������number)
select sno,sname,sage,sex from students t where to_char(sysdate,'yyyy')-sage =1988;
--28����ѯÿ�ſγ̵�ƽ���ɼ��������ƽ���ɼ��������У�ƽ���ɼ���ͬʱ�����γ̺Ž�������
SELECT sc.cno,avg(sc.score) as ƽ����
FROM sc
GROUP BY sc.cno
ORDER BY ƽ���� asc,sc.cno desc;
--29����ѯƽ���ɼ�����75 ������ѧ����ѧ�š�������ƽ���ɼ�
SELECT s.sno,s.sname,avg(sc.score) as ƽ����
FROM students s
LEFT JOIN sc 
ON s.sno = sc.sno
GROUP BY s.sno,s.sname
HAVING avg(sc.score)>75;
--30����ѯ�γ�����Ϊ�����ݿ⡱���ҷ�������60 ��ѧ�������ͷ���
SELECT c.cname,s.sname,sc.score
FROM courses c
LEFT JOIN sc
ON c.cno = sc.cno
LEFT JOIN students s
ON sc.sno = s.sno
WHERE c.cname = 'Oracle' AND sc.score < 60;
--31����ѯ����ѧ����ѡ�������
SELECT s.sno,s.sname,c.cno,cname
FROM students s
LEFT JOIN sc
ON s.sno = sc.sno
LEFT JOIN courses c
ON sc.cno = c.cno;
--32����ѯ�κ�һ�ſγ̳ɼ���70 �����ϵ��������γ����ƺͷ�����
SELECT s.sname,c.cname,sc.score
FROM students s
LEFT JOIN sc 
ON s.sno = sc.sno
LEFT JOIN courses c
ON sc.cno = c.cno
WHERE sc.score > 70;
--33����ѯ������Ŀγ̣������γ̺ŴӴ�С����
SELECT sc.score,sc.cno 
FROM sc
WHERE sc.score < 60
ORDER BY sc.cno desc;
--34����ѯ�γ̱��Ϊc001 �ҿγ̳ɼ���80 �����ϵ�ѧ����ѧ�ź�������
SELECT s.sno,s.sname
FROM students s 
LEFT JOIN sc
ON s.sno = sc.sno
WHERE sc.cno = 'c001' AND sc.score > 80;
--35����ѡ�˿γ̵�ѧ������
SELECT count(*)
FROM (SELECT distinct sc.sno
FROM sc);

SELECT count(distinct sno)
FROM sc;
--36����ѯѡ�ޡ����ࡱ��ʦ���ڿγ̵�ѧ���У��ɼ���ߵ�ѧ����������ɼ�
SELECT s.sname,sc.score
FROM students s
LEFT JOIN sc
ON s.sno = sc.sno
LEFT JOIN courses c
ON sc.cno = c.cno
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '����' AND sc.score = (SELECT max(score) FROM sc);
--37����ѯ�����γ̼���Ӧ��ѡ������
SELECT c.cno,c.cname,count(*)
FROM courses c
LEFT JOIN sc
ON c.cno = sc.cno
GROUP BY c.cno,c.cname;
--38����ѯ��ͬ�γ̳ɼ���ͬ��ѧ����ѧ�š��γ̺š�ѧ���ɼ�
SELECT sc.sno,sc.cno,sc.score
FROM sc
LEFT JOIN sc s2
ON sc.sno = s2.sno
WHERE sc.cno != s2.cno AND sc.score = s2.score;

select a.* from sc a ,sc b where a.score=b.score and a.cno<>b.cno;
--39����ѯÿ�Ź��γɼ���õ�ǰ����
--40��ͳ��ÿ�ſγ̵�ѧ��ѡ������������4 �˵Ŀγ̲�ͳ�ƣ���
--Ҫ������γ̺ź�ѡ����������ѯ����������������У���������ͬ�����γ̺���������
SELECT sc.cno,count(*) as ����
FROM sc
GROUP BY sc.cno
HAVING count(*)>=4
ORDER BY ���� desc, sc.cno asc;
--41����������ѡ�����ſγ̵�ѧ��ѧ��
SELECT sc.sno
FROM sc
GROUP BY sc.sno
HAVING count(sc.sno)>=2;
--42����ѯȫ��ѧ����ѡ�޵Ŀγ̵Ŀγ̺źͿγ���
SELECT distinct sc.cno,c.cname
FROM sc 
LEFT JOIN courses c
ON sc.cno = c.cno;
--43����ѯûѧ�������ࡱ��ʦ���ڵ���һ�ſγ̵�ѧ������
SELECT s.sname 
FROM students s
WHERE s.sno NOT IN
(SELECT sc.sno 
FROM sc 
LEFT JOIN courses c
ON sc.cno = c.cno
LEFT JOIN teachers t
ON c.tno = t.tno
WHERE t.tname = '����');
--44����ѯ�������ϲ�����γ̵�ͬѧ��ѧ�ż���ƽ���ɼ�
SELECT sc.sno,avg(sc.score) as ƽ����
FROM sc
WHERE sc.sno IN (SELECT sno FROM sc WHERE score < 60 GROUP BY sno HAVING count(*) > 1)
GROUP BY sc.sno;

SELECT sno,avg(score) 
FROM sc
WHERE sno IN 
(SELECT sno FROM sc WHERE score < 60 GROUP BY sno HAVING count(sno) > 1)
GROUP BY sno;
--45��������c004���γ̷���С��60���������������е�ͬѧѧ��
SELECT sc.sno
FROM sc
WHERE sc.cno = 'c004' AND sc.score < 60
ORDER BY sc.score desc;
--46��ɾ����s002��ͬѧ�ġ�c001���γ̵ĳɼ�
DELETE FROM sc WHERE sc.sno = 's002' AND sc.cno = 'c001';











