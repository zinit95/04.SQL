-- # 문자열 비교

-- CHAR타입끼리의 비교
DROP TABLE CHAR_COMPARE;
--CHAR_COMPARE 테이블 생성
CREATE TABLE CHAR_COMPARE (  
    sn CHAR(10),
    char_4 CHAR(4),
    char_6 CHAR(6)
);

INSERT INTO char_compare VALUES ('101', 'SQLD', 'SQLD');
INSERT INTO char_compare VALUES ('102', 'SQLD', 'SQLA');
INSERT INTO char_compare VALUES ('103', 'SQLD', '  SQLD');

SELECT * FROM char_compare;

SELECT * FROM char_compare
WHERE sn = '101'
    AND char_4 = char_6 --'SQLD' == 'SQLD'
;

SELECT * FROM char_compare
WHERE sn = '102'
    AND char_4 > char_6 --'SQLD', 'SQLA' D가 더 큼
;

-- 한쪽이 VARCHAR타입일 경우의 비교
DROP TABLE VARCHAR_COMPARE;
CREATE TABLE VARCHAR_COMPARE (
    sn CHAR(10),
    char_4 CHAR(4),
    varchar_6 VARCHAR2(6)
);

INSERT INTO varchar_compare VALUES ('101', 'SQLD', 'SQLD  ');
INSERT INTO varchar_compare VALUES ('102', 'SQLD', 'SQLA  ');
INSERT INTO varchar_compare VALUES ('103', 'SQLD', 'SQLD');
COMMIT;
SELECT * FROM varchar_compare;
WHERE 
    sn = '101'
    AND char_4 = varchar_6 -- 한쪽이 VARCHAR2면 글자수가 달라서 false나옴
;

SELECT * FROM varchar_compare;
WHERE 
    sn = '101'
    AND char_4 = TREAM(varchar_6) -- 한쪽이 VARCHAR2면 글자수가 달라서 false나옴
;

--상수 문자열 비교 
SELECT 
    *
FROM varchar_compare
WHERE sn = '101'
    AND char_4 = 'SQLD  ' --true
;

SELECT 
    *
FROM varchar_compare
WHERE sn = '101'
    AND varchar_6 = 'SQLD  ' --true, 공백을 빼면 false
;


--단일행 함수 
SELECT 
    emp_nm, SUBSTR(addr, 1, 3)
FROM tb_emp
;

SELECT 
    LOWER('Hello WORLD'),  -- 전부 소문자로 변환
    UPPER('hello World'),  -- 전부 대문자로 변환
    INITCAP('abcDEF')      -- 첫글자만 대문자로 나머지는 소문자로 변환
FROM dual; --dual : 아무것도 없는 쓰레기 테이블, 더미테이블, 함수를 호출해보거나 테스트해보는거 

SELECT
    ASCII('A'), -- 문자를 아스키코드로,
    CHR(97)     -- 아스키코드를 문자로
FROM dual;

SELECT 
    'SQL' || 'Developer', --문자열 연결하는거임
    CONCAT('SQL', 'Developer'),   -- 문자열을 결합
    SUBSTR('SQL Developer', 1, 3), -- 문자열 자름 1번부터 3개자름 (첫글자가 1번)
    SUBSTR('ZINIT95', 1, 3), --ZIN 나옴
    LENGTH('HELLO WORLD'),         -- 문자열의 길이
    TRIM('    HI   '),              -- 좌우 공백 제거
    LTRIM('     HELLO1    '), --왼쪽 공백만 제거
    RTRIM('     HELLO2     '), --오른쪽 공백만 제거
    LTRIM('HELLOhello', 'HE') --왼쪽에서 발견된 HE 제거
FROM dual;

SELECT 
    RPAD('Steve', 10, '-'), -- 오른쪽에 주어진 문자를 채움 STEVE는 5글자고 남은 글자는 - 로 채워라
    LPAD('Steve', 10, '*'),  -- 왼쪽에 주어진 문자를 채움, STEVE는 5글자고 남은 글자는 * 로 채워라
    REPLACE('Java Programmer Java', 'Java', 'BigData') AS "REPLACE" -- 문자를 변경, Java를 BigData로 변경해라
    , REPLACE('Java Programmer', 'Java') AS "REPLACE" -- 문자를 제거, Java를 다 지워라 
FROM dual;

SELECT
    LTRIM ('xxYYZZxYZxx', 'X')
FROM dual
;
SELECT 
	(LENGTH(C1) - LENGTH(REPLACE(C1, CHR(10))) + 1) AS CC
FROM TAB1;



-- ## 숫자형 함수
SELECT 
    MOD(27, 5) AS MOD, -- 나머지 값 반환, 2
    CEIL(38.678) AS ceil, -- 올림값 반환, 39
    FLOOR(38.678) AS floor, -- 내림값 반환, 38
    ROUND(38.678, 2) AS round, -- 자리수까지 반올림, 38.68
    TRUNC(38.678, 2) AS trunc  -- 자리수 이하를 절삭, 38.67
    , ABS(-20) AS abs   -- 절대값, 20
    , SIGN(99) AS sign  -- 0보다 작으면 -1, 0보다 크면 1, 0이면 0 , 1
FROM dual;

-- ## 날짜형 함수

-- 현재 날짜를 조회
SELECT SYSDATE --현재 년월일
FROM dual;

SELECT SYSTIMESTAMP --현재 년월일시분초
FROM dual;

-- 날짜 연산
-- 날짜 + 숫자 = 날짜  => 일(DAY) 수를 날짜에 더함
-- 날짜 - 숫자 = 날짜  => 날짜에서 일 수를 뺌
-- 날짜 - 날짜 = 일수  => 어떤 날짜에서 다른 날짜를 뺀 일수
-- 날짜 + 숫자/24 = 날짜  => 날짜에 시간을 더함

SELECT 
    SYSDATE AS "현재 시간",
    SYSDATE - 1 AS "SYSDATE - 1",
    (SYSDATE + 10) - SYSDATE AS "날짜 - 날짜",
    SYSDATE - (1/24) AS "1시간 차감",
    SYSDATE - (1/24/60) * 100 AS "100분 차감",
    SYSDATE - (1/24/60/60) * 30 AS "30초 차감"
FROM dual;



-- ## 변환 함수
SELECT * FROM char_compare
WHERE sn = 101;

-- 날짜를 문자로 변환 (TO_CHAR함수)
-- 날짜 포맷형식: Y - 연도, MM - 두자리 월, D - 일수
-- 시간 포맷형식: HH12 - 시(1~12), HH24 (0-23), MI - 분, SS - 초
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'MM - DD') AS "월 - 일",
    TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS "연/월/일",
    TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') AS "날짜 - 한글포함",
    TO_CHAR(SYSDATE + (1/24) * 6, 'YY/MM/DD HH24:MI:SS') AS "날짜와 시간",
    TO_CHAR(SYSDATE - (1/24) * 6, 'YY/MM/DD AM HH12:MI:SS') AS "날짜와 시간2"
FROM dual;

-- 숫자를 문자로 변환
-- 숫자 포맷 형식 -  $: 달러표시, L: 지역화폐기호
SELECT
    TO_CHAR(9512 * 1.33, '$999,999.99') AS "달러",
    TO_CHAR(1350000, 'L999,999,999') AS "원화"
FROM dual;

-- 문자를 숫자로 변환
SELECT 
    TO_NUMBER('$5,500', '$999,999') - 4000 AS "계산결과"
FROM dual;

--날짜 변환 함수 
SELECT  
    TO_DATE('20150101000000','YYYYMMDDHH24MISS'),
    TO_DATE('20240101','YYYYMMDD'), --시분초를 생력하면 00시00분00초로 세팅됨
    TO_DATE('202401','YYYYMM'), -- 날짜를 생력하묜 1로 생성된다
    TO_CHAR(SYSDATE,'YYYYMM')--일,시분초 다 생략됨
FROM dual;





-- CASE표현과 DECODE함수
SELECT * FROM tb_sal;

-- Searched expression
SELECT 
    sal_cd, --급여코드
    sal_nm, --급여 명
    CASE WHEN sal_cd = '100001' THEN '기본급여' -- WHEN 할 때~, THEN 그러면
         WHEN sal_cd = '100002' THEN '보너스급여'
         ELSE '기타'
     END sal_name --END는 AS다 
FROM tb_sal;


-- Simple expression
SELECT 
    sal_cd, 
    sal_nm,
    CASE sal_cd 
    	  WHEN '100001' THEN '기본급여'
          WHEN '100002' THEN '보너스급여'
         ELSE '기타'
     END sal_name
FROM tb_sal;


SELECT
    sal_cd,
    DECODE(sal_cd, '100001', '기본급여', '100002', '보너스급여', '기타') AS sal_name
FROM tb_sal;



-- NULL 
SELECT
    emp_nm,
    direct_manager_emp_no
FROM tb_emp
;

SELECT 
    COALESCE(NULL,'A')
FROM dual
;

SELECT NULLIF('A','A')
FROM dual
;


-- # 널 관련 함수
-- NVL(expr1, expr2)
-- expr1: Null을 가질 수 있는 값이나 표현식
-- expr2: expr1이 Null일 경우 대체할 값
SELECT 
    emp_no
    , emp_nm
    , direct_manager_emp_no
FROM tb_emp
;

SELECT 
     emp_no
    , emp_nm
    --direct_manager_emp_no가 NULL이면 최상위관리자로 변경
    , NVL(direct_manager_emp_no, '최상위관리자') AS 관리자 
FROM tb_emp
;

SELECT 
     emp_nm,
     NVL(emp_nm, '존재안함') AS emp_nm,
     ADDR 
FROM tb_emp
WHERE emp_nm = '이정직';

SELECT 
    direct_manager_emp_no
FROM tb_emp
WHERE emp_nm = '김회장' --NULL도 조회된것이다. 다만 조회 결과가 NULL인것뿐
;


SELECT 
    -- MAX : 사원중에 최대값을 찾는거임, 유니코드 제일 큰 애, 없는 사람의 이름을 쓰면 NULL이 조회가 된다
    --MAX(emp_nm)
    --NVL(emp_nm, '존재안함') AS emp_nm
    NVL(MAX(emp_nm), '존재안함') AS emp_nm
FROM tb_emp
WHERE emp_nm = '이승엽';

-- NVL2(expr1, expr2, expr3)
-- expr1의 값이 Null이 아니면 expr2를 반환, Null이면 expr3를 반환
SELECT 
    emp_nm,
    NVL2(direct_manager_emp_no, '일반사원', '회장님') AS 직위
FROM tb_emp;

-- NULLIF(expr1, expr2)
-- 두 값이 같으면 NULL리턴, 다르면 expr1 리턴
SELECT
    NULLIF('박찬호', '박찬호')
FROM dual;

SELECT
    NULLIF('박찬호', '박지성')
FROM dual;

-- COALESCE(expr1, ...)
-- 많은 표현식 중 Null이 아닌 값이 최초로 발견되면 해당 값을 리턴
SELECT 
    COALESCE(NULL, NULL, 3000, 4000)
FROM dual;

SELECT 
    COALESCE(NULL, 5000, NULL, 2000)
FROM dual;

SELECT 
    COALESCE(7000, NULL, NULL, 8000)
FROM dual;








