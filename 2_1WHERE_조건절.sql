

-- WHERE 조건절
-- 조회 행을 제한
SELECT 
    emp_no,
    emp_nm,
    addr,
    sex_cd
FROM tb_emp
WHERE sex_cd = 2 --성별코드가 2인 애들만 조회하겠다 
;

--pk로 필터링을 하면 무조건 1건 이하가 조회된다.
SELECT 
    emp_no,
    emp_nm,
    addr,
    sex_cd
FROM tb_emp
WHERE emp_no = 1000000003 --where절에 pk를 넣으면? 1건 및 0건이 조회된다.
;


--비교 연산자
SELECT 
    emp_no,
    emp_nm,
    addr,
    sex_cd
FROM tb_emp
WHERE sex_cd != 2 --성별코드가 2가 아닌 사람
;

SELECT 
    emp_no,
    emp_nm,
    addr,
    sex_cd
FROM tb_emp
WHERE sex_cd <> 2 --성별코드가 2가 아닌 사람
;

SELECT 
    emp_no,
    emp_nm,
    addr,
    birth_de
FROM tb_emp
--WHERE birth_de >= '19900101' --90년대 이후 출생자들만 조회 
WHERE birth_de >= '19800101' --80년대 이후 출생자들만 조회 
;
SELECT 
    emp_no,
    emp_nm,
    addr,
    birth_de
FROM tb_emp
WHERE birth_de >= '19800101'
    AND birth_de <= '19891231' --80년 생들만 조회 함
;
SELECT 
    emp_no,
    emp_nm,
    addr,
    birth_de
FROM tb_emp
WHERE NOT birth_de >= '19800101' --NOT을 붙이면 ! 랑 같다 80년 이전출생자 조회 
;


--BETWEEN 연산자
SELECT 
    emp_no,
    emp_nm,
    birth_de
FROM tb_emp
WHERE birth_de NOT BETWEEN '19900101' AND '19991231'
;


--IN 연산 : OR연산
SELECT 
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd = 100002
    OR dept_cd = 100007 --100002, 100007번인 회원을 조회하라 
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
WHERE dept_cd NOT IN(100002, 100007, 100008) --(100002, 100007, 100008) 뺴고 조회
;

-- LIKE 
-- 주로 검색에서 사용
-- 와일드카드 매핑 (% : 0글자 이상, _ : 딱 1글자)

SELECT 
    emp_no,
    emp_nm,
    addr
FROM tb_emp
WHERE addr LIKE '%용인%' --용인이라는 단어가 있는 주소 조회 
;
SELECT 
    emp_no,
    emp_nm,
    addr
FROM tb_emp
WHERE emp_nm LIKE '이%' --이름이 이~로 시작하는 이름 조회 
;
SELECT 
    emp_no,
    emp_nm,
    addr
FROM tb_emp
 --이름이 이~로 시작하는 이름 조회, 이__ : 이씨면서 이름이 꼭 두글자인 사람
WHERE emp_nm LIKE '이__'
;
-- 이%, 이__ 차이점은 이__ 뒤에 언더바가 __ 2개 있기 때문에 이 뒤에 두글자인 사람만 조회
SELECT 
    emp_no,
    emp_nm,
    addr
FROM tb_emp
WHERE emp_nm LIKE '%심' --이름이 심으로 끝나는 사람
;



--SELECT 
--    email
--FROM user
    -- 두번째 글자에 A가 있어야 되는 이메일, 예: aAdfij@naver.com
--WHERE email LIKE '_A%@%'
--;

--성씨가 김씨 이면서 부서가 100003,100004 중에 하나면서 
--90년대생인 사원의 사번,이름,생일,부서코드를 조회

SELECT
    emp_no,
    emp_nm,
    birth_de,
    dept_cd
FROM tb_emp
WHERE emp_nm LIKE '김%'
        AND dept_cd IN (100003, 100004)
        AND birth_de BETWEEN '19900101' AND '19991231'
;
SELECT
    emp_no,
    emp_nm,
    birth_de,
    dept_cd
FROM tb_emp
WHERE 1 = 1 --언제나 true, 1 = 0 은 false 밑에 코드가 있으나 마나 
    AND  emp_nm LIKE '김%'
    AND dept_cd IN (100003, 100004)
    AND birth_de BETWEEN '19900101' AND '19991231'
;

--null값 조회
--반드시 is null 로 조회할 것
SELECT
    emp_no,
    emp_nm,
    direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no is null
;
--null이 아닌거 조회 null만 not을 뒤에 붙인다
SELECT
    emp_no,
    emp_nm,
    direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL --NOT만 뒤에 IS NOT NULL!! 중요
;

-- 연산자 우선 순위
-- NOT > AND > OR
SELECT -- SELECT 조회 
	EMP_NO ,
	EMP_NM ,
	ADDR 
FROM TB_EMP --TB_EMP에서 
WHERE 1=1
    --수원 또는 일산에 사는 김씨 다 나와
	AND EMP_NM LIKE '김%'
    --()를 빼면 수원, 일산사는 사람이 다 나옴
	AND (ADDR LIKE '%수원%' OR ADDR LIKE '%일산%')
;

SELECT 
	EMP_NO ,
	EMP_NM ,
	ADDR 
FROM TB_EMP 
WHERE 1=1   
    --1 AND (2 OR 3)
	AND EMP_NM LIKE '김%'
	AND ADDR LIKE '%수원%'
    OR ADDR LIKE '%일산%'
;

