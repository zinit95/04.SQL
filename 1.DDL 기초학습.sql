


select * from tb_emp;
-- 테이블 생성 (DDL: 데이터 정의어)
-- 학생들의 성적정보를 저장할 데이터 구조
CREATE TABLE tbl_score (
    name VARCHAR2(4) NOT NULL,
    kor NUMBER(3) NOT NULL CHECK(kor >= 0 AND kor <= 100),
    eng NUMBER(3) NOT NULL CHECK(eng >= 0 AND eng <= 100),
    math NUMBER(3) NOT NULL CHECK(math >= 0 AND math <= 100),
    total NUMBER(3) NULL,
    average NUMBER(5, 2),
    grade CHAR(1),
    stu_num NUMBER(6) PRIMARY KEY
);

SELECT * FROM tbl_score;

-- 컬럼 추가하기
ALTER TABLE tbl_score
ADD (sci NUMBER(3) NOT NULL);

--컬럼 제거하기
ALTER TABLE tbl_score
DROP COLUMN sci;

-- DROP : 테이블 제거, 강력한 제거 ,위험한 명령어, 복구가 안됨
-- 테이블 복사(CTAS)
CREATE TABLE tb_emp_copy
AS SELECT * FROM tb_emp

DROP TABLE tb_emp_copy;

SELECT * FROM tb_emp_copy;

-- TRUNCATE  : 구조는 남기고 안에 데이터만 삭제하여 
-- 테이블이 생성된 초기상태로 돌아간다, 위험한 명령어, 복구가 안됨

TRUNCATE TABLE tb_emp_copy;

--ALTER문으로 제약조건 추가하기
--stu_num에 깜빡하고 PRIMARY KEY를 안걸었다
ALTER TABLE tbl_score
ADD CONSTRAINT pk_tbl_score
PRIMARY KEY (stu_num);

--pk를 제거
ALTER TABLE tbl_score
DROP CONSTRAINT pk_tbl_score;





