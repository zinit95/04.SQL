-- Ʈ�����
CREATE TABLE student (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    age NUMBER
);

INSERT INTO student VALUES (1, '��ö��',15);
INSERT INTO student VALUES (2, 'ȫ�浿',16);

SELECT * FROM student;

--COMMIT�� �ϴ¼��� DB�� ������ �ȴ�
COMMIT;

INSERT INTO student VALUES (3, '�����',12);

--COMMIT �ϱ� �������� ROLLBACK���� ��� �� �� �ִ�. 
--����ʸ� student ���̺� �߰������� commit�� ���� �ʾҴٸ� rollback���� ����Ҽ�����
ROLLBACK;


--������ü
UPDATE tb_account
SET balance = balance + 5000
WHERE name = '��ö��';

UPDATE tb_account
SET balance = balance - 5000
WHERE name = '�ڿ���';

COMMIT;

DELETE FROM student;
ROLLBACK;

SELECT * FROM student;
--rollback�ص� ���ư� �� ����.
--���̺��� ��� ��� �����͸� ����, �����͸� ���������� ����
TRUNCATE TABLE student;



































