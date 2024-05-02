--사원의 사번, 이름, 부서번호, 부서명

SELECT
    emp_no,
    emp_nm, 
    dept_cd
FROM tb_emp
;
SELECT 
    dept_cd,
    dept_nm
FROM tb_dept
;

-- JOIN : 테이블 여러개를 합쳐서 조회한다. 
-- tb_dept랑 tb_emp 같이 조회, 조회 할 때 앞에 tb_dept.dept_cd = tb_dept를 넣어 
-- tb_dept에 있는 dept_cd를 조회하라는거임, 왜? tb_emp, tb_dept에 공통적으로 dept_cd가 둘 다 있어서
-- 어떤걸 조회 해야 될지 모르기 때문에 명시해주는거임
SELECT
    tb_emp.emp_no, --tb_emp에 emp_no를 가져와라 
    tb_emp.emp_nm, 
    tb_dept.dept_cd, --tb_dept에 dept_cdf를 가져와라, 조회해라 
    tb_dept.dept_nm
FROM tb_emp, tb_dept --tb_emp 테이블이랑 tb_dept테이블 같이 조회 
-- tb_emp, tb_dept에 있는 dept_cd를 조회해줘라 
WHERE tb_emp.dept_cd = tb_dept.dept_cd
;

-- 조인 기초 테스트 데이터
CREATE TABLE TEST_A (
    id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);
CREATE TABLE TEST_B (
    b_id NUMBER(10) PRIMARY KEY
    , reply VARCHAR2(100)
    , a_id NUMBER(10)
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);

SELECT * FROM test_a; --게시글 3
SELECT * FROM test_b; --게시글 4

-- join의 원리는 곱하기 연산 
-- Cartesian production : product연산
-- Cross Join : 가능한 모든 경우의 수를 매칭하여 조회
SELECT
    *
FROM test_a, test_b --3*4 = 12개의 게시글이 나옴
;
--INNER JOIN
-- 두 테이블 가넹 연관컬럼을 이용하여
-- 관계가 있는 데이터를 매칭하여 조인 
SELECT
    *
FROM test_a, test_b --3*4 = 12개의 게시글이 나옴
--`test_a` 테이블과 `test_b` 테이블에서 `id`와 `a_id`가 
--서로 같은 값을 가지는 행들만을 합쳐서 결과를 반환
WHERE test_a.id = test_b.a_id
;

SELECT  
    E.emp_no,
    E.emp_nm, 
    E.addr, 
    D.dept_cd,  
    D.dept_nm
FROM tb_emp E, tb_dept D -- tb_emp는 E로 정하고 tb_dept는 D로 정함
WHERE E.dept_cd = D.dept_cd
;

-- 사원의 사원번호와 사원명과 취득한 자격증명을 조회
SELECT
    E.emp_no,
    E.emp_nm,
    E.sex_cd,
    EC.certi_cd,
    C.certi_nm,
    EC.acqu_de
FROM tb_emp E, tb_emp_certi EC, tb_certi C
WHERE E.emp_no = EC.emp_no
    AND EC.certi_cd = C.certi_cd
;

-- 사원의 사원번호와 사원명과 취득한 자격증명, 부서명을 조회 
SELECT
    E.emp_no,
    E.emp_nm,
    D.dept_cd,
    E.sex_cd,
    EC.certi_cd,
    C.certi_nm,
    EC.acqu_de
FROM tb_emp E, tb_emp_certi EC, tb_certi C, tb_dept D
WHERE E.emp_no = EC.emp_no
    AND EC.certi_cd = C.certi_cd
    AND E.dept_cd = D.dept_cd
;

--부서별로 총 자격증 취득 개수를 조회 
SELECT
    D.dept_cd,
    D.dept_NM,
    COUNT(EC.certi_cd )
FROM tb_dept D, tb_emp_certi EC, tb_emp E
WHERE E.dept_cd = D.dept_cd
    AND E.emp_no = EC.emp_no
GROUP BY D.dept_cd, D.dept_nm
ORDER BY D.dept_cd
;

-- 용인시에 사는 사원의 사원번호
SELECT 
    E.emp_no,
    E.emp_nm,
    E.addr,
    E.dept_cd,
    D.dept_cd,
    D.dept_nm
FROM tb_emp E, tb_dept D
WHERE E.addr LIKE '%용인%'
  AND E.dept_cd = D.dept_cd
  AND E.emp_nm LIKE '김%'
;



-- JOIN ON (ANSI 표준 조인)
-- 1. FROM절 뒤, WHERE 절 앞
-- 2. JOIN 키워드 뒤에는 조인할 테이블명을 명시
-- 3. ON 키워드 뒤에는 조인 조건을 명시
-- 4. 조인 조건 서술부(ON절) 일반 조건 서술부 (WHERE절)를 분리해서 작성하는 방법
-- 5. ON절을 이용하면 JOIN 이후의 논리연산이나 서브쿼리와 같은 추가 서술이 가능
SELECT  
    E.emp_no,
    E.emp_nm,
    E.addr,
    E.dept_cd,
    D.dept_cd,
    D.dept_nm
FROM tb_emp E JOIN tb_dept D
ON E.dept_cd = D.dept_cd
WHERE E.ADDR LIKE '%용인%'
    AND E.emp_nm LIKE '김%'
;

SELECT
    E.emp_no,
    E.emp_nm,
    D.dept_nm,
    E.sex_cd,
    EC.certi_cd,
    C.certi_nm,
    EC.acqu_de
FROM tb_emp E 
JOIN tb_emp_certi EC 
ON E.emp_no = EC.emp_no
JOIN tb_certi C 
ON EC.certi_cd = C.certi_cd
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
WHERE D.dept_cd IN (100004, 100006)
    AND EC.acqu_de >= '20180101'
;


-- 1980년대생 사원들의 사번, 사원명 tb_emp, 부서명tb_dept, 자격증명 tb_certi, 취득일자 te_emp_certi 조회 
SELECT
    E.emp_no, E.emp_no, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E, tb_dept D, tb_certi C, tb_emp_certi EC
WHERE E.dept_cd = D.dept_cd
    AND E.emp_no = EC.emp_no
    AND C.certi_cd = EC.certi_cd
    AND E.birth_de BETWEEN '19800101' AND '19891231'
;

SELECT
    E.emp_no, E.emp_nm, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E 
INNER JOIN tb_dept D 
ON E.dept_cd = D.dept_cd
JOIN tb_emp_certi EC
ON E.emp_no = EC.emp_no
INNER JOIN tb_certi C 
ON C.certi_cd = EC.certi_cd
WHERE E.birth_de BETWEEN '19800101' AND '19891231'
;

-- INNER JOIN은 두 테이블간에 연관데이터가 있는 경우에만 사용 
-- 어떤 쇼핑몰회원이 한건도 주문하지 않은 경우
-- INNER JOIN에서는 해당 회원이 조회되지 않음

-- 순서 
-- SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름 
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화
-- HAVING    그룹화 조건
-- ORDER BY  정렬할 열 [ASC | DESC];

-- 조인 조건을 안걸면 카테시안 곱이 만들어짐 - 모든 경우의 수가 다 조회됨
-- 크로스 조인 (밑에꺼는 오라클방식의 크로스 조인)
SELECT
* 
FROM test_a, test_b
;

-- 위에와 같은 결과지만 다른 방식임
SELECT
* 
FROM test_a
CROSS JOIN test_b
;

-- # NATURAL JOIN
-- 1. NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 자동으로 조인조건을 생성하는 기법입니다.
-- 2. 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER조인을 수행합니다.
-- 3. 이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며, 
--    ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안됩니다.
-- 4. SELECT * 문법을 사용하면, 공통 컬럼은 집합에서 한번만 표기됩니다
-- 5. 공통 컬럼이 n개 이상이면 조인 조건이 n개로 처리됩니다.

-- 사원 테이블과 부서 테이블을 조인 (사번, 사원명, 부서코드, 부서명)
SELECT 
   A.emp_no, A.emp_nm, dept_cd, B.dept_nm
   -- *
FROM tb_emp A
NATURAL JOIN tb_dept B
-- ON A.dept_cd = B.dept_cd
;

SELECT 
 *
FROM test_a A
INNER JOIN test_b B
ON A.id = B.a_id
;

SELECT 
 *
FROM test_a A
NATURAL JOIN test_b B
;


-- # USING절 조인
-- 1. NATURAL조인에서는 자동으로 이름과 타입이 일치하는 모든 컬럼에 대해
--    조인이 일어나지만 USING을 사용하면 원하는 컬럼에 대해서면 선택적 조인조건을 
--    부여할 수 있습니다.
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 표기하시면 안됩니다.
SELECT 
   A.emp_no, A.emp_nm, dept_cd, B.dept_nm
FROM tb_emp A
NATURAL JOIN tb_dept B
;

SELECT 
   A.emp_no, A.emp_nm, B.dept_cd, B.dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
;

SELECT 
   emp_no, emp_nm, dept_cd, dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd) --공통걸러명 
;

