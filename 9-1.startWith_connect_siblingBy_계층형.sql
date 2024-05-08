-- 계층형 쿼리 
-- START WITH : 계층의 첫 단계를 어디서 시작할 것인지의 대한 조건
-- CONNECT BY PRIOR 자식 = 부모  -> 순방향 탐색
-- CONNECT BY 자식 = PRIOR 부모  -> 역방향 탐색
-- ORDER SIBLINGS BY : 같은 레벨끼리의 정렬을 정함.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
--START WITH : 어디서부터 전계할꺼냐, 펼치꺼냐 
--상사에번호(direct_manager_emp_no)에 null인 애부터 조회한다, 펼쳐라
START WITH A.direct_manager_emp_no IS NULL
--START WITH : 사원번호가 37번부터 펼처라,조회해라 
--START WITH A.EMP_NO = '1000000037'
-- CONNECT BY PRIOR 자식 = 부모  -> 순방향 탐색
-- CONNECT BY 자식 = PRIOR 부모  -> 역방향 탐색
--PRIOR가 어디 방향에 붙어있는지 확인해보자 
--CONNECT BY : 계층형 쿼리 
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no
--SIBLINGS BY 같은 레벨끼리 내림차순으로 하기 
ORDER SIBLINGS BY A.emp_no DESC
;

SELECT
    emp_no "사원번호", --pk 자식, 같은 번호가 있을 수 없음
    emp_nm "사원이름",
    direct_manager_emp_no --얘가 부모, 같은 번호가 있을 수 있으니깐
FROM tb_emp
;

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
--START WITH : 어디서부터 전계할꺼냐, 펼치꺼냐 
--상사에번호(direct_manager_emp_no)에 null인 애부터 조회한다, 펼쳐라
START WITH A.direct_manager_emp_no IS NULL
--START WITH : 사원번호가 37번부터 펼처라,조회해라 
--START WITH A.EMP_NO = '1000000037'
--direct_manager_emp_no 부모인 앞에 PRIORA가 있어서 역방향임
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no
ORDER SIBLINGS BY A.emp_no DESC
;
