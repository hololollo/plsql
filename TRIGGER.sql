-- 트리거(TRIGGER) : 특정 상황이나 동작 등을 이벤트라고 할 때, 이벤트가 발생하면 연쇄 동작으로 해당 기능을 자동으로 처리해주는 서브 프로그램의 일종.
-- 애프터트리거(업데이트UPDATE, 딜리트DELETE, 인서트INSERT => 트랜잭션TRANSACTION) / 비포트리거(셀렉트SELECT)가 있다.



--상품테이블
CREATE TABLE goods(pno number, pname varchar(100), price number);
--입고테이블
create table store(pno number, amount number, price number);
--출고테이블
create table release(pno number, amount number, price number);
--재고테이블
create table inventory(pno number, amount number, price number);
drop table inventory;
--데이터 추가
-- 상품 등록
insert into goods values(100, '먹태깡', 2500);
insert into goods values(200, '꼬북칩', 2000);
insert into goods values(300, '짜파링', 3000);
insert into goods values(400, '팅쵹', 2800);
insert into goods values(500, '감튀', 2600);

select * from goods;

select * from inventory;


-- 입고시의 재고 처리 : 입고(store) 테이블에 새로운 레코드가 추가되면, 재고는 증가된다.
-- 만약, 현재 해당 상품의 재고가 없으면, 새로운 상품으로 재고를 처리하고,
-- 해당 상품에 기존에 존재하면, 그 제품의 수량과 단가를 적용하여 재고를 처리할 수 있도록 구현할 것.
-- 트리거 이름 : store_trigger
-- 재고의 단가 : 입고시 원래 가격의 40%의 마진율

CREATE OR REPLACE TRIGGER store_trigger
AFTER INSERT ON store -- insert문을 실행하면, 알아서 자동으로 실행됨
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO vcnt FROM inventory WHERE pno = :NEW.pno; -- :을 붙인다.
    IF (vcnt=0) THEN -- 재고가 없다면
        INSERT INTO inventory VALUES (:NEW.pno, :NEW.amount, :new.price*1.4);
    ELSE -- 재고가 있다면
        UPDATE inventory SET amount=amount+:NEW.amount, price=:NEW.price*1.4 -- pno상품넘버는 동일.  amount : 기존 + 수량증가. price가격 : 새로운 가격
        WHERE pno=:NEW.pno;
    END IF;
END;
/

select * from inventory;
-- 입고 처리
INSERT INTO store VALUES(100,2,2500);
-- 재고 처리 : store_trigger에 의해 자동 처리됨
INSERT INTO inventory VALUES(100,2,3500);   
COMMIT;
INSERT INTO store VALUES(100,3,2500);
INSERT INTO store VALUES(200,4,2000);

-- 출고시의 재고처리 : 출고(release) 테이블에 새로운 레코드가 추가되면, 재고는 감소된다.
-- 만약 현재 해당 상품이 모두 출고 되면, 해당 상품의 재고 정보를 삭제하고, 해당 상품이 출고되고도 잔존하면, 그 제품의 수량을 적용하여 재고를 처리할 수 있도록 구현
-- 트리거 이름 : release_trigger
CREATE OR REPLACE TRIGGER release_trigger
AFTER INSERT ON release 
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT amount-:NEW.amount INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        DELETE FROM inventory WHERE pno=:NEW.pno;
    ELSE
        UPDATE inventory SET amount=amount-:NEW.amount WHERE pno=:NEW.pno;
    END IF;    
END;
/

select * from inventory;
INSERT INTO release VALUES(100,3,(SELECT price FROM inventory WHERE pno=100));



--반출시(recall)시의 재고 처리 : 입고(store) 테이블에 수량이 감소하면, 재고도 감소된다.
-- 만약, 현재 해당 상품이 모두 반출(recall)되면, 해당 상품의 재고 정보를 삭제하고, 
-- 해당 상품이 반출되고도 잔존하면, 그 제품의 수량을 적용하여 재고를 처리할 수 있도록 구현
-- 트리거 이름 : recall_trigger

CREATE OR REPLACE TRIGGER recall_trigger
AFTER UPDATE ON store -- update문을 실행하면, 알아서 자동으로 실행됨
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    -- 재고 확인.
    SELECT COUNT(*) INTO vcnt FROM inventory WHERE pno = :NEW.pno; -- :을 붙인다.
    IF (vcnt=0) THEN -- 재고가 없다면
         DELETE FROM inventory WHERE pno=:NEW.pno;
    ELSE -- 재고가 있다면
        UPDATE inventory SET amount=amount-:NEW.amount WHERE pno = :NEW.pno;  
    END IF;
END;
/
select * from inventory;
UPDATE store SET amount=amount-2 WHERE pno=100;



--반품(return)시의 재고 처리 : 출고(release) 테이블에 수량이 감소하면, 재고는 증가된다.
-- 만약, 현재 해당 상품의 재고가 없으면, 새로운 상품으로 재고를 처리하고, 
-- 해당 사품이 기존에 존재하면, 그 제품의 수량을 적용하여 재고를 처리할 수 있도록 구현
-- 트리거 이름 : return_trigger

CREATE OR REPLACE TRIGGER return_trigger
AFTER UPDATE ON release -- update문을 실행하면, 알아서 자동으로 실행됨
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    -- 재고 확인.
    SELECT COUNT(*) INTO vcnt FROM inventory WHERE pno = :NEW.pno; -- :을 붙인다.
    IF (vcnt=0) THEN -- 재고가 없다면
        INSERT INTO inventory values (:NEW.pno, :NEW.amount,:NEW.price);
    ELSE -- 재고가 있다면
        UPDATE inventory SET amount=amount+:NEW.amount, price=:NEW.price*1.4 
        WHERE pno=:NEW.pno;
    END IF;
END;
/

UPDATE release SET amount=amount-2 WHERE pno=100;

----------------------------------------------------------------

-- 입고시의 재고 처리 : 입고(store) 테이블에 새로운 레코드가 추가되면, 재고는 증가된다.
-- 만약, 현재 해당 상품의 재고가 없으면, 새로운 상품으로 재고를 처리하고,
-- 해당 상품에 기존에 존재하면, 그 제품의 수량과 단가를 적용하여 재고를 처리할 수 있도록 구현할 것.
-- 트리거 이름 : store_trigger
-- 재고의 단가 : 입고시 원래 가격의 40%의 마진율
CREATE OR REPLACE TRIGGER store_trigger
AFTER INSERT ON store 
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        INSERT INTO inventory VALUES (:NEW.pno, :NEW.amount, :NEW.price*1.4);
    ELSE
        UPDATE inventory SET amount=amount+:NEW.amount, price=:NEW.price*1.4 
        WHERE pno=:NEW.pno;
    END IF;    
END;
/

select * from inventory;
-- 입고 처리
INSERT INTO store VALUES(100,2,2500);
-- 재고 처리 : store_trigger에 의해 자동 처리됨
INSERT INTO inventory VALUES(100,2,3500);   
COMMIT;
INSERT INTO store VALUES(100,3,2500);
INSERT INTO store VALUES(200,4,2000);

-- 출고시의 재고 처리 : ※출고(release) 테이블에 새로운 레코드가 추가되면(INSERT)※, ※재고(수량)는 감소※된다.
-- 만약, 현재 해당 상품이 모두 출고 되면, 해당 상품의 재고 정보를 삭제하고,
-- 해당 상품이 출고되고도 잔존하면, 그 제품의 ※수량을 적용※하여 ※재고를 처리※ (=>수정=update)할 수 있도록 구현할 것.
-- 트리거 이름 : release_trigger
CREATE OR REPLACE TRIGGER release_trigger
AFTER INSERT ON release -- 출고테이블에 새로운 레코드가 추가되면
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT amount-:NEW.amount INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN -- 잔존값이 없다면
        DELETE FROM inventory WHERE pno=:NEW.pno; -- 재고정보 삭제
    ELSE -- 잔존값이 있다면
        UPDATE inventory SET amount=amount-:NEW.amount WHERE pno=:NEW.pno; --재고를 처리(수정=> 감소)
    END IF;    
END;
/

select * from inventory;
INSERT INTO release VALUES(100,3,(SELECT price FROM inventory WHERE pno=100));


-- 반출(recall)시의 재고 처리 : 입고(store) 테이블에 수량이 감소하면(UPDATE), 재고도 감소된다.
-- 만약, 현재 해당 상품이 모두 반출(recall) 되면, 해당 상품의 재고 정보를 삭제하고,
-- 해당 상품이 반출되고도 잔존하면, 그 제품의 수량을 적용하여 재고를 처리할 수 있도록 구현할 것.
-- 트리거 이름 : recall_trigger
CREATE OR REPLACE TRIGGER recall_trigger
AFTER UPDATE ON store -- store테이블 수량 감소
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT amount-:NEW.amount INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN -- 모두 반출되면
        DELETE FROM inventory WHERE pno=:NEW.pno; -- 재고 정보 삭제
    ELSE -- 잔존값이 있으면
        UPDATE inventory SET amount=amount-:NEW.amount WHERE pno=:NEW.pno; -- 재고 처리 => 재고(수량) 감소
    END IF;    
END;
/

select * from inventory;
UPDATE store SET amount=amount-2 WHERE pno=100;



-- 반품(return)시의 재고 처리 : 출고(release) 테이블에 수량이 감소하면, 재고는 증가된다.
-- 만약, 현재 해당 상품의 재고가 없으면, 새로운 상품으로 재고를 처리하고,
-- 해당 상품이 기존에 존재하면, 그 제품의 수량을 적용하여 재고를 처리할 수 있도록 구현할 것.
-- 트리거 이름 : return_trigger
CREATE OR REPLACE TRIGGER return_trigger
AFTER UPDATE ON release
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        INSERT INTO inventory VALUES (:NEW.pno, :NEW.amount, :NEW.price);
    ELSE
        UPDATE inventory SET amount=amount+:NEW.amount
        WHERE pno=:NEW.pno;
    END IF;    
END;
/

select * from inventory;
UPDATE release SET amount=amount-2 WHERE pno=100;