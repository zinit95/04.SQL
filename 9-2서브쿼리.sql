-- #서브쿼리 : SQL 안에 SQL이 포함된 구문 
-- 단일행 서브쿼리 : 조회 결과가 1건 이하 

--부서코드가 100004번인 부서의 사원들 정보 조회 
SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
--부서코드가 100004인 사람들 조회 
WHERE dept_cd = '100004'
;

--이나라가 속한 부서의 모든 사원정보 조회
--이나라는 부서코드가 몇번이냐?
--그 부서코드로 모든 사원을 조회해라
--100004번 모든 사원들 조회 
SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd = (
    -- #서브쿼리 : SQL 안에 SQL이 포함된 구문 
    SELECT 
        dept_cd
    FROM tb_emp
    WHERE emp_nm = '이나라'
)
;
--1건 조회 
SELECT 
    dept_cd
FROM tb_emp
WHERE emp_nm = '이관심'
;

-- 사원이름이 이관심인 사람이 속해 있는 부서의 사원정보 조회
-- 단일행 비교연산자(=, <>, >, >=, <, <=)는 단일행 서브쿼리로만 비교해야 함.
SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd = (
    -- #서브쿼리 : SQL 안에 SQL이 포함된 구문 
    SELECT 
        dept_cd
    FROM tb_emp
    WHERE emp_nm = '이관심'
)
;

-- 20200525에 받은 급여가 회사전체의 20200525일 
-- 전체 평균 급여보다 높은 사원들의 정보(사번, 이름, 급여지급일, 받은급여액수) 조회

-- 회사전체의 20200525일 평균급여 계산
-- 그 평균보다 높은 사원 조회 
SELECT
    E.emp_no,
    E.emp_nm,
    S.pay_de,
    S.pay_amt
FROM tb_emp E
JOIN tb_sal_his S
ON E.emp_no = S.emp_no
WHERE S.pay_de = '20200525'
    --5월달 평균보다 많은 급여인사람 조회 
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
    --5월달 평균보다 많은 급여인사람 조회 
    --AND S.pay_amt >= 4082927
    AND S.pay_amt >= (
    -- 단일행 서브쿼리
        SELECT
            AVG(pay_amt)
        FROM tb_sal_his 
        WHERE pay_de = '20200525'
    )
;
--20200525 회사 전체 급여 평균
SELECT
    AVG(pay_amt)
FROM tb_sal_his 
WHERE pay_de = '20200525'
;

-- # 다중행 서브쿼리
-- 서브쿼리의 조회 건수가 0건 이상인 것
-- ## 다중행 연산자
-- 1. IN : 메인쿼리의 비교조건이 서브쿼리 결과중에 하나라도 일치하면 참
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 중에 없으므로 false
-- 2. ANY, SOME : 메인쿼리의 비교조건이 서브쿼리의 검색결과 중 하나 이상 일치하면 참
--    ex )  salary > ANY (200, 300, 400)
--            250 ->  200보다 크므로 true
-- 3. ALL : 메인쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치하면 참
--    ex )  salary > ALL (200, 300, 400)
--            250 ->  200보다는 크지만 300, 400보다는 크지 않으므로 false
-- 4. EXISTS : 메인쿼리의 비교조건이 서브쿼리의 결과 중 
--				만족하는 값이 하나라도 존재하면 참

--왜 에러가 나냐? 결과값이 2개라서 
SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
--WHERE dept_cd IN (
--IN 이랑 = ANY 랑 같은거다 
WHERE dept_cd = ANY (
                --IN을 사용하면 조회가 된다. 
                SELECT 
                    dept_cd
                FROM tb_emp
                WHERE emp_nm = '이관심'
)
;
-- ""한국데이터베이스진흥원에서 발급""한 자격증을 가지고 있는
-- 사원의 사원번호와 사원이름과 해당 사원의 한국데이터베이스진흥원에서 
-- 발급한 자격증 개수를 조회
SELECT
    E.emp_no,
    E.emp_nm,
    COUNT(S.certi_cd) "자격증 개수"
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
    COUNT(S.certi_cd) "자격증 개수"
FROM tb_emp E
INNER JOIN tb_emp_certi S
ON E.emp_no = S.emp_no
WHERE S.certi_cd IN(
                SELECT certi_cd
                FROM tb_certi
                WHERE issue_insti_nm = '한국데이터베이스진흥원'
)
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;
--위에 코드랑 같은 코드이다 IN 이냐 ANY이냐 
SELECT
    E.emp_no,
    E.emp_nm,
    COUNT(S.certi_cd) "자격증 개수"
FROM tb_emp E
INNER JOIN tb_emp_certi S
ON E.emp_no = S.emp_no
WHERE S.certi_cd = ANY(
                    SELECT certi_cd
                    FROM tb_certi
                    WHERE issue_insti_nm = '한국데이터베이스진흥원'
)
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;


----★★★★★코드 오류뜸 확인바람 ★★★★★★
-- EXISTS문 : 메인쿼리의 비교조건이 서브쿼리의 결과 중 
--           만족하는 값이 하나라도 존재하면 참
-- 주소가 강남인 직원들이 근무하고 있는 부서정보를 조회 (부서코드, 부서명)
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
WHERE addr LIKE '%강남%'
;
SELECT 
    dept_cd, 
    dept_nm
FROM tb_dept 
WHERE dept_cd IN (
                    SELECT dept_cd
                    FROM tb_emp 
                    WHERE addr LIKE '%강남%'
                )
;

SELECT 
    1 
FROM tb_emp
WHERE addr LIKE '%강남%'
;

SELECT A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
                    SELECT 
                        1
                    FROM tb_emp B
                    WHERE addr LIKE '%강남%'
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
    -- DISTINCT : 이름을 중복제거
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


-- # 다중 컬럼 서브쿼리
--  : 서브쿼리의 조회 컬럼이 2개 이상인 서브쿼리
-- 부서원이 2명 이상인 부서 중에서 각 부서의 
-- 가장 연장자의 사번과 이름 생년월일과 부서코드를 조회

SELECT 
    A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
-- # 다중 컬럼 서브쿼리
--  : 서브쿼리의 조회 컬럼이 2개 이상인 서브쿼리
--WHERE절에 갯수랑 IN아래에 조건갯수랑 같아야 됨 
--컬럼의 개수와 컬럼의 위치개수가 동일해야 됨
WHERE (A.dept_cd, A.birth_de) IN (
                        -- # 다중 컬럼 서브쿼리
                        -- : 서브쿼리의 조회 컬럼이 2개 이상인 서브쿼리
                        SELECT 
                        --컬럼의 개수와 컬럼의 위치개수가 동일해야 됨
                            dept_cd "부서번호", 
                            MIN(birth_de) "생년월일"
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2
                    )
ORDER BY A.emp_no
;


-- 인라인 뷰 서브쿼리 (FROM절에 쓰는 서브쿼리)
--각 사번의 사번과 이름과 평균 급여 정보를 알고 싶음
SELECT
    E.emp_no,
    E.emp_nm,
    AVG(S.pay_amt)
FROM tb_emp E
--join은 곱하기 연산이니깐 테이블을 줄이고 join하는게 낫다 
JOIN tb_sal_his S
ON E.emp_no = S.emp_no
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;

-- 각 사원의 사번과 이름과 평균 급여정보를 조회하고 싶다.
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


-- 스칼라 서브쿼리 (SELECT, INSERT, UPDATE절에 쓰는 서브쿼리)

-- 사원의 사번, 사원명, 부서명, 생년월일, 성별코드를 조회
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











