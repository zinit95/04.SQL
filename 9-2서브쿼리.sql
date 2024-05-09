-- #�������� : SQL �ȿ� SQL�� ���Ե� ���� 
-- ������ �������� : ��ȸ ����� 1�� ���� 

--�μ��ڵ尡 100004���� �μ��� ����� ���� ��ȸ 
SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
--�μ��ڵ尡 100004�� ����� ��ȸ 
WHERE dept_cd = '100004'
;

--�̳��� ���� �μ��� ��� ������� ��ȸ
--�̳���� �μ��ڵ尡 ����̳�?
--�� �μ��ڵ�� ��� ����� ��ȸ�ض�
--100004�� ��� ����� ��ȸ 
SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd = (
    -- #�������� : SQL �ȿ� SQL�� ���Ե� ���� 
    SELECT 
        dept_cd
    FROM tb_emp
    WHERE emp_nm = '�̳���'
)
;
--1�� ��ȸ 
SELECT 
    dept_cd
FROM tb_emp
WHERE emp_nm = '�̰���'
;

-- ����̸��� �̰����� ����� ���� �ִ� �μ��� ������� ��ȸ
-- ������ �񱳿�����(=, <>, >, >=, <, <=)�� ������ ���������θ� ���ؾ� ��.
SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd = (
    -- #�������� : SQL �ȿ� SQL�� ���Ե� ���� 
    SELECT 
        dept_cd
    FROM tb_emp
    WHERE emp_nm = '�̰���'
)
;

-- 20200525�� ���� �޿��� ȸ����ü�� 20200525�� 
-- ��ü ��� �޿����� ���� ������� ����(���, �̸�, �޿�������, �����޿��׼�) ��ȸ

-- ȸ����ü�� 20200525�� ��ձ޿� ���
-- �� ��պ��� ���� ��� ��ȸ 
SELECT
    E.emp_no,
    E.emp_nm,
    S.pay_de,
    S.pay_amt
FROM tb_emp E
JOIN tb_sal_his S
ON E.emp_no = S.emp_no
WHERE S.pay_de = '20200525'
    --5���� ��պ��� ���� �޿��λ�� ��ȸ 
    AND S.pay_amt >= 4082927
;

SELECT
    E.emp_no,
    E.emp_nm,
    S.pay_de,
    S.pay_amt
FROM tb_emp E
JOIN tb_sal_his S
ON E.emp_no = S.emp_no
WHERE S.pay_de = '20200525'
    --5���� ��պ��� ���� �޿��λ�� ��ȸ 
    --AND S.pay_amt >= 4082927
    AND S.pay_amt >= (
    -- ������ ��������
        SELECT
            AVG(pay_amt)
        FROM tb_sal_his 
        WHERE pay_de = '20200525'
    )
;
--20200525 ȸ�� ��ü �޿� ���
SELECT
    AVG(pay_amt)
FROM tb_sal_his 
WHERE pay_de = '20200525'
;

-- # ������ ��������
-- ���������� ��ȸ �Ǽ��� 0�� �̻��� ��
-- ## ������ ������
-- 1. IN : ���������� �������� �������� ����߿� �ϳ��� ��ġ�ϸ� ��
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 �߿� �����Ƿ� false
-- 2. ANY, SOME : ���������� �������� ���������� �˻���� �� �ϳ� �̻� ��ġ�ϸ� ��
--    ex )  salary > ANY (200, 300, 400)
--            250 ->  200���� ũ�Ƿ� true
-- 3. ALL : ���������� �������� ���������� �˻������ ��� ��ġ�ϸ� ��
--    ex )  salary > ALL (200, 300, 400)
--            250 ->  200���ٴ� ũ���� 300, 400���ٴ� ũ�� �����Ƿ� false
-- 4. EXISTS : ���������� �������� ���������� ��� �� 
--				�����ϴ� ���� �ϳ��� �����ϸ� ��

--�� ������ ����? ������� 2���� 
SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
--WHERE dept_cd IN (
--IN �̶� = ANY �� �����Ŵ� 
WHERE dept_cd = ANY (
                --IN�� ����ϸ� ��ȸ�� �ȴ�. 
                SELECT 
                    dept_cd
                FROM tb_emp
                WHERE emp_nm = '�̰���'
)
;
-- ""�ѱ������ͺ��̽���������� �߱�""�� �ڰ����� ������ �ִ�
-- ����� �����ȣ�� ����̸��� �ش� ����� �ѱ������ͺ��̽���������� 
-- �߱��� �ڰ��� ������ ��ȸ
SELECT
    E.emp_no,
    E.emp_nm,
    COUNT(S.certi_cd) "�ڰ��� ����"
FROM tb_emp E
INNER JOIN tb_emp_certi S
ON E.emp_no = S.emp_no
WHERE S.certi_cd IN(100001, 100002, 100003, 100004, 100005, 100006)
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;
SELECT
    E.emp_no,
    E.emp_nm,
    COUNT(S.certi_cd) "�ڰ��� ����"
FROM tb_emp E
INNER JOIN tb_emp_certi S
ON E.emp_no = S.emp_no
WHERE S.certi_cd IN(
                SELECT certi_cd
                FROM tb_certi
                WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
)
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;
--���� �ڵ�� ���� �ڵ��̴� IN �̳� ANY�̳� 
SELECT
    E.emp_no,
    E.emp_nm,
    COUNT(S.certi_cd) "�ڰ��� ����"
FROM tb_emp E
INNER JOIN tb_emp_certi S
ON E.emp_no = S.emp_no
WHERE S.certi_cd = ANY(
                    SELECT certi_cd
                    FROM tb_certi
                    WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
)
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;


----�ڡڡڡڡ��ڵ� ������ Ȯ�ιٶ� �ڡڡڡڡڡ�
-- EXISTS�� : ���������� �������� ���������� ��� �� 
--           �����ϴ� ���� �ϳ��� �����ϸ� ��
-- �ּҰ� ������ �������� �ٹ��ϰ� �ִ� �μ������� ��ȸ (�μ��ڵ�, �μ���)
SELECT
    dept_cd,
    dept_nm
FROM tb_dept
WHERE dept_cd IN(100009, 100010)
;
SELECT
    dept_cd,
    emp_nm,
    addr
FROM tb_emp
WHERE addr LIKE '%����%'
;
SELECT 
    dept_cd, 
    dept_nm
FROM tb_dept 
WHERE dept_cd IN (
                    SELECT dept_cd
                    FROM tb_emp 
                    WHERE addr LIKE '%����%'
                )
;

SELECT 
    1 
FROM tb_emp
WHERE addr LIKE '%����%'
;

SELECT A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
                    SELECT 
                        1
                    FROM tb_emp B
                    WHERE addr LIKE '%����%'
                        AND A.dept_cd = B.dept_cd
                )
ORDER BY 1            
;


SELECT
    emp_nm
FROM tb_emp;
SELECT
    COUNT(emp_nm)
FROM tb_emp;
SELECT
    -- DISTINCT : �̸��� �ߺ�����
    DISTINCT emp_nm
FROM tb_emp;
SELECT
    COUNT(DISTINCT emp_nm)
FROM tb_emp;
SELECT
    emp_no || emp_nm
FROM tb_emp;
SELECT
    DISTINCT emp_no || emp_nm
FROM tb_emp;


-- # ���� �÷� ��������
--  : ���������� ��ȸ �÷��� 2�� �̻��� ��������
-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� 
-- ���� �������� ����� �̸� ������ϰ� �μ��ڵ带 ��ȸ

SELECT 
    A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
-- # ���� �÷� ��������
--  : ���������� ��ȸ �÷��� 2�� �̻��� ��������
--WHERE���� ������ IN�Ʒ��� ���ǰ����� ���ƾ� �� 
--�÷��� ������ �÷��� ��ġ������ �����ؾ� ��
WHERE (A.dept_cd, A.birth_de) IN (
                        -- # ���� �÷� ��������
                        -- : ���������� ��ȸ �÷��� 2�� �̻��� ��������
                        SELECT 
                        --�÷��� ������ �÷��� ��ġ������ �����ؾ� ��
                            dept_cd "�μ���ȣ", 
                            MIN(birth_de) "�������"
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2
                    )
ORDER BY A.emp_no
;


-- �ζ��� �� �������� (FROM���� ���� ��������)
--�� ����� ����� �̸��� ��� �޿� ������ �˰� ����
SELECT
    E.emp_no,
    E.emp_nm,
    AVG(S.pay_amt)
FROM tb_emp E
--join�� ���ϱ� �����̴ϱ� ���̺��� ���̰� join�ϴ°� ���� 
JOIN tb_sal_his S
ON E.emp_no = S.emp_no
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;

-- �� ����� ����� �̸��� ��� �޿������� ��ȸ�ϰ� �ʹ�.
SELECT 
    A.emp_no, A.emp_nm, B.pay_avg
FROM tb_emp A JOIN (
                 SELECT 
                    emp_no, AVG(pay_amt) AS pay_avg
                 FROM tb_sal_his
                 GROUP BY emp_no
                    ) B
ON A.emp_no = B.emp_no
ORDER BY A.emp_no
;

SELECT 
    A.emp_no, A.emp_nm, AVG(B.PAY_AMT)
FROM tb_emp A 
JOIN TB_SAL_HIS B
ON A.emp_no = B.emp_no
GROUP BY A.EMP_NO, A.EMP_NM 
ORDER BY A.emp_no
;


-- ��Į�� �������� (SELECT, INSERT, UPDATE���� ���� ��������)

-- ����� ���, �����, �μ���, �������, �����ڵ带 ��ȸ
SELECT 
    A.emp_no
    , A.emp_nm
    , (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
    , A.birth_de
    , A.sex_cd
FROM tb_emp A
;


SELECT 
    emp_nm, null
FROM tb_emp;











