-- 트랜잭션
CREATE TABLE student (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    age NUMBER
);

INSERT INTO student VALUES (1, '김철수',15);
INSERT INTO student VALUES (2, '홍길동',16);

SELECT * FROM student;

--COMMIT을 하는순간 DB에 저장이 된다
COMMIT;

INSERT INTO student VALUES (3, '도우너',12);

--COMMIT 하기 전까지는 ROLLBACK으로 취소 할 수 있다. 
--도우너를 student 테이블에 추가했지만 commit을 하지 않았다면 rollback으로 취소할수잇음
ROLLBACK;


--계좌이체
UPDATE tb_account
SET balance = balance + 5000
WHERE name = '김철수';

UPDATE tb_account
SET balance = balance - 5000
WHERE name = '박영희';

COMMIT;

DELETE FROM student;
ROLLBACK;

SELECT * FROM student;
--rollback해도 돌아갈 수 없다.
--테이블의 모든 행과 데이터를 삭제, 데이터를 영구적으로 삭제
TRUNCATE TABLE student;



































