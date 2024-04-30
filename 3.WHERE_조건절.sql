

-- WHERE ������
-- ��ȸ ���� ����
SELECT 
    emp_no,
    emp_nm,
    addr,
    sex_cd
FROM tb_emp
WHERE sex_cd = 2 --�����ڵ尡 2�� �ֵ鸸 ��ȸ�ϰڴ� 
;

--pk�� ���͸��� �ϸ� ������ 1�� ���ϰ� ��ȸ�ȴ�.
SELECT 
    emp_no,
    emp_nm,
    addr,
    sex_cd
FROM tb_emp
WHERE emp_no = 1000000003 --where���� pk�� ������? 1�� �� 0���� ��ȸ�ȴ�.
;


--�� ������
SELECT 
    emp_no,
    emp_nm,
    addr,
    sex_cd
FROM tb_emp
WHERE sex_cd != 2 --�����ڵ尡 2�� �ƴ� ���
;

SELECT 
    emp_no,
    emp_nm,
    addr,
    sex_cd
FROM tb_emp
WHERE sex_cd <> 2 --�����ڵ尡 2�� �ƴ� ���
;

SELECT 
    emp_no,
    emp_nm,
    addr,
    birth_de
FROM tb_emp
--WHERE birth_de >= '19900101' --90��� ���� ����ڵ鸸 ��ȸ 
WHERE birth_de >= '19800101' --80��� ���� ����ڵ鸸 ��ȸ 
;
SELECT 
    emp_no,
    emp_nm,
    addr,
    birth_de
FROM tb_emp
WHERE birth_de >= '19800101'
    AND birth_de <= '19891231' --80�� ���鸸 ��ȸ ��
;
SELECT 
    emp_no,
    emp_nm,
    addr,
    birth_de
FROM tb_emp
WHERE NOT birth_de >= '19800101' --NOT�� ���̸� ! �� ���� 80�� ��������� ��ȸ 
;


--BETWEEN ������
SELECT 
    emp_no,
    emp_nm,
    birth_de
FROM tb_emp
WHERE birth_de NOT BETWEEN '19900101' AND '19991231'
;


--IN ���� : OR����
SELECT 
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd = 100002
    OR dept_cd = 100007 --100002, 100007���� ȸ���� ��ȸ�϶� 
;
SELECT 
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd IN(100002, 100007, 100008)
;
SELECT 
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd NOT IN(100002, 100007, 100008) --(100002, 100007, 100008) ���� ��ȸ
;

-- LIKE 
-- �ַ� �˻����� ���
-- ���ϵ�ī�� ���� (% : 0���� �̻�, _ : �� 1����)

SELECT 
    emp_no,
    emp_nm,
    addr
FROM tb_emp
WHERE addr LIKE '%����%' --�����̶�� �ܾ �ִ� �ּ� ��ȸ 
;
SELECT 
    emp_no,
    emp_nm,
    addr
FROM tb_emp
WHERE emp_nm LIKE '��%' --�̸��� ��~�� �����ϴ� �̸� ��ȸ 
;
SELECT 
    emp_no,
    emp_nm,
    addr
FROM tb_emp
 --�̸��� ��~�� �����ϴ� �̸� ��ȸ, ��__ : �̾��鼭 �̸��� �� �α����� ���
WHERE emp_nm LIKE '��__'
;
-- ��%, ��__ �������� ��__ �ڿ� ����ٰ� __ 2�� �ֱ� ������ �� �ڿ� �α����� ����� ��ȸ
SELECT 
    emp_no,
    emp_nm,
    addr
FROM tb_emp
WHERE emp_nm LIKE '%��' --�̸��� ������ ������ ���
;



--SELECT 
--    email
--FROM user
    -- �ι�° ���ڿ� A�� �־�� �Ǵ� �̸���, ��: aAdfij@naver.com
--WHERE email LIKE '_A%@%'
--;

--������ �达 �̸鼭 �μ��� 100003,100004 �߿� �ϳ��鼭 
--90������ ����� ���,�̸�,����,�μ��ڵ带 ��ȸ

SELECT
    emp_no,
    emp_nm,
    birth_de,
    dept_cd
FROM tb_emp
WHERE emp_nm LIKE '��%'
        AND dept_cd IN (100003, 100004)
        AND birth_de BETWEEN '19900101' AND '19991231'
;
SELECT
    emp_no,
    emp_nm,
    birth_de,
    dept_cd
FROM tb_emp
WHERE 1 = 1 --������ true, 1 = 0 �� false �ؿ� �ڵ尡 ������ ���� 
    AND  emp_nm LIKE '��%'
    AND dept_cd IN (100003, 100004)
    AND birth_de BETWEEN '19900101' AND '19991231'
;

--null�� ��ȸ
--�ݵ�� is null �� ��ȸ�� ��
SELECT
    emp_no,
    emp_nm,
    direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no is null
;
--null�� �ƴѰ� ��ȸ null�� not�� �ڿ� ���δ�
SELECT
    emp_no,
    emp_nm,
    direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL --NOT�� �ڿ� IS NOT NULL!! �߿�
;

-- ������ �켱 ����
-- NOT > AND > OR
SELECT -- SELECT ��ȸ 
	EMP_NO ,
	EMP_NM ,
	ADDR 
FROM TB_EMP --TB_EMP���� 
WHERE 1=1
    --���� �Ǵ� �ϻ꿡 ��� �达 �� ����
	AND EMP_NM LIKE '��%'
    --()�� ���� ����, �ϻ��� ����� �� ����
	AND (ADDR LIKE '%����%' OR ADDR LIKE '%�ϻ�%')
;

SELECT 
	EMP_NO ,
	EMP_NM ,
	ADDR 
FROM TB_EMP 
WHERE 1=1   
    --1 AND (2 OR 3)
	AND EMP_NM LIKE '��%'
	AND ADDR LIKE '%����%'
    OR ADDR LIKE '%�ϻ�%'
;

