-- ������ ���� 
-- START WITH : ������ ù �ܰ踦 ��� ������ �������� ���� ����
-- CONNECT BY PRIOR �ڽ� = �θ�  -> ������ Ž��
-- CONNECT BY �ڽ� = PRIOR �θ�  -> ������ Ž��
-- ORDER SIBLINGS BY : ���� ���������� ������ ����.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
--START WITH : ��𼭺��� �����Ҳ���, ��ġ���� 
--��翡��ȣ(direct_manager_emp_no)�� null�� �ֺ��� ��ȸ�Ѵ�, ���Ķ�
START WITH A.direct_manager_emp_no IS NULL
--START WITH : �����ȣ�� 37������ ��ó��,��ȸ�ض� 
--START WITH A.EMP_NO = '1000000037'
-- CONNECT BY PRIOR �ڽ� = �θ�  -> ������ Ž��
-- CONNECT BY �ڽ� = PRIOR �θ�  -> ������ Ž��
--PRIOR�� ��� ���⿡ �پ��ִ��� Ȯ���غ��� 
--CONNECT BY : ������ ���� 
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no
--SIBLINGS BY ���� �������� ������������ �ϱ� 
ORDER SIBLINGS BY A.emp_no DESC
;

SELECT
    emp_no "�����ȣ", --pk �ڽ�, ���� ��ȣ�� ���� �� ����
    emp_nm "����̸�",
    direct_manager_emp_no --�갡 �θ�, ���� ��ȣ�� ���� �� �����ϱ�
FROM tb_emp
;

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
--START WITH : ��𼭺��� �����Ҳ���, ��ġ���� 
--��翡��ȣ(direct_manager_emp_no)�� null�� �ֺ��� ��ȸ�Ѵ�, ���Ķ�
START WITH A.direct_manager_emp_no IS NULL
--START WITH : �����ȣ�� 37������ ��ó��,��ȸ�ض� 
--START WITH A.EMP_NO = '1000000037'
--direct_manager_emp_no �θ��� �տ� PRIORA�� �־ ��������
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no
ORDER SIBLINGS BY A.emp_no DESC
;
