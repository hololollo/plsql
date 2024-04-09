-- PL(Procedural Language)의 SQL ⇒ PL/SQL 
-- SQL 구문을 하나의 명력 블록으로 구성하여 필요시 호출하여 사용하며, 
-- IF, LOOP, FOR 등을 활용하여 더 효과적으로 SQL을 활용할 수 있다.
-- 프로시저(Procedure), 함수(Function), 트리거(Trigger)는 선언(DECLARE)부터 해야한다. 임의의 테이블값

/*
 프로시저 문법
 CREATE OR REPLACE PROCEDURE 프로시저 이름( 매개변수명1[ IN | OUT | IN OUT ] 데이터타입[:= 디폴트값],
      매개변수명2[ IN | OUT | IN OUT ] 데이터타입[:= 디폴트값], ... )
  IS[AS]
      변수, 상수 등 선언
  BEGIN
      실행
  [EXCEPTION 예외처리부]
  END [프로시저 이름]


 함수 문법
    CREATE OR REPLACE FUNCTION 함수 이름 (매개변수1, 매개변수2....)
    RETURN 데이터 타입;
    IS[AS]
        변수, 상수 선언..
    BEGIN
        실행부
        RETURN 반환값
        [EXCEPTION 예외처리부]
    END [함수 이름];
*/


-- 사원(emp) 테이블 작성
-- 사원번호(eno) 숫자 최대 10자리 , 사원명(ename)가변문자 20자, 부서코드(pno) 숫자 최대 2자리, 직급(pos) 가변문자 10자, 
-- 우편번호(pcode) 가변문자 7자, 주소(addr) 가변문자 100자, 급여(salery) 숫자 8자, 보너스(bonus) 숫자 8자리, 입사일(regdate) 날짜, 성별(gender) 숫자 최대 2자리
create table emp1 (eno number(10), ename varchar(20), pno number(2), pos varchar(10), pcode varchar(7), addr varchar(100), salary number(8), bonus number(8), regdate date, gender number(2)); 
drop table emp1;
-- 컬럼 추가
-- 상급자(superior) 숫자 최대 10자리, 전화번호(tel) 가변문자 13자리
alter table emp1 add superior number(10);
alter table emp1 add tel varchar(13);

select * from emp1;


-- 컬럼 순서 맞추기
-- 컬럼 숨기기
alter table emp1 modify salary invisible;
alter table emp1 modify bonus invisible;
alter table emp1 modify regdate invisible;
alter table emp1 modify gender invisible;
alter table emp1 modify superior invisible;

select * from emp1;

-- 컬럼 보이기
alter table emp1 modify salary visible;
alter table emp1 modify bonus visible;
alter table emp1 modify regdate visible;
alter table emp1 modify gender visible;
alter table emp1 modify superior visible;

select * from emp1;


-- 데이터 추가
insert into emp1 values(2001, '수민', 10, '부장', '125-365', '서울 용산구', '02-985-1254', 3500000, 1000000, '1980-12-01', 1, default);
insert into emp1 values(2002, '시은', 10, '대리', '354-865', '서울 강남구', '02-865-1245', 4000000, null, '2000-01-25', 1, 2004);
insert into emp1 values(2003, '아이사', 20, '사원', '587-456', '부산 해운대구', '051-256-9874', 2500000, 1000000, '2002-05-24', 2, 2002);
insert into emp1 values(2004, '세은', 30, '과장', '987-452', '서울 강남구', '02-333-6589', 5000000, null, '1997-03-22', 2, 2001);
insert into emp1 values(2005, '윤', 10, '대리', '123-322', '서울 성동구', '02-888-9564', 3000000, 1000000, '1999-07-15', 2, 2004);
insert into emp1 values(2006, '재이', 20, '사원', '154-762', '서울 송파구', '02-3369-9874', 2000000, null, '2003-05-22', 2, 2005);
insert into emp1 values(2007, '최유진', 30, '대리', '367-985', '서울 영등포구', '02-451-2563', 3000000, 1000000, '2006-01-25', 2, 2004);
insert into emp1 values(2008, '샤오팅', 40, '사원', '552-126', '서울 중구', '02-447-3256', 2400000, null, '2001-02-02', 2, 2007);
insert into emp1 values(2009, '마시로', 10, '사원', '315-276', '서울 종로구', '02-123-1278', 2500000, 1000000, '2009-04-17', 2, 2002);
insert into emp1 values(2010, '김채헌', 20, '사원', '485-172', '서울 성북구', '02-478-1235', 2450000, 800000, '2009-12-15', 2, 2004);

select * from emp1;


-- PL(Procedural Language)의 SQL ⇒ PL/SQL 
-- SQL 구문을 하나의 명력 블록으로 구성하여 필요시 호출하여 사용하며, 
-- IF, LOOP, FOR 등을 활용하여 더 효과적으로 SQL을 활용할 수 있다.
-- 프로시저(Procedure), 함수(Function), 트리거(Trigger)는 선언(DECLARE)부터 해야한다. 임의의 테이블값

-- PL 실행 결과 출력문 활성화
SET SERVEROUTPUT ON;

DECLARE 
    TYPE firsttype IS RECORD(a emp1.ename%TYPE, b emp1.pos%TYPE, c emp1.salary%TYPE);
cus1 firsttype; 
BEGIN
    SELECT ename, pos, salary INTO cus1 FROM emp1 where eno=2001;
    DBMS_OUTPUT.PUT_LINE('***********');
    DBMS_OUTPUT.PUT_LINE(cus1.a || '   ' || cus1.b || '   ' || cus1.c);
    DBMS_OUTPUT.PUT_LINE('현재 계정 : ' || USER);
    DBMS_OUTPUT.PUT_LINE('현재 질의 시간 : ' || TO_CHAR(SYSDATE, 'YYYY-DD-MM HH:MM:SS'));
END; -- 익명의 값을 불러오는 DECLARE문을 활용하면 바로 실행되기 때문에 프로시저처럼 EXEC같은 실행문을 따로 실행시킬 필요가 없다.

-- 익명의 프로시저를 활용하여 사원(emp) 테이블로부터 사원번호 2002인 직원의 사원번호, 사원명, 직급, 주소, 입사일을 출력하시오.
-- 단, 입사일은 연도 네자리-월 두자리-일 두자리 형태로 출력될 수 있도록 할 것.
DECLARE
    sawon emp1%ROWTYPE;
BEGIN
    SELECT * INTO sawon FROM emp1 where eno=2002;
    DBMS_OUTPUT.PUT_LINE('***********************************************');
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || sawon.eno);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || sawon.ename);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || sawon.pos);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || sawon.addr);
    DBMS_OUTPUT.PUT_LINE('입사일 : ' || TO_CHAR(sawon.regdate, 'YYYY-MM-DD'));
END;


-- 익명의 반복 프로시저 실습(INDEX BY) => 레코드
DECLARE
    TYPE ename_type IS TABLE OF emp1.ename%TYPE INDEX BY BINARY_INTEGER; -- emp1테이블의 ename열과 같은 유형을 같는 ename_type이라는 사용자 정의 타입을 (배열 0부터 INTEGER로서)선언
    TYPE pos_type IS TABLE OF emp1.pos%TYPE INDEX BY BINARY_INTEGER;
    ename_column ename_type; -- ename_type의 인스턴스인 ename_column을 선언. (emp1 테이블의 ename 열의 데이터를 저장할 변수)
    pos_column pos_type;
    i BINARY_INTEGER := 0; -- i를 0으로 선언
BEGIN
    FOR k IN(SELECT ename, pos FROM emp1) LOOP
        i := i + 1;
        ename_column(i) := k.ename;
        pos_column(i) := k.pos;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('****************');
    DBMS_OUTPUT.PUT_LINE('사원명 직급');
    DBMS_OUTPUT.PUT_LINE('****************');
    FOR J IN 1..i LOOP -- j를 1부터 i까지 반복
        DBMS_OUTPUT.PUT_LINE(RPAD(ename_column(j), 12) || RPAD(pos_column(j),10)); -- RPAD : 글자 수 맞추기 함수 => 즉, ename_column(j), 12 라는 의미는 오른쪽부터 빈칸을 포함하여 12글자를 맞춘것(너비).
    END LOOP;
END;



-- 프로시저 문법
--  CREATE OR REPLACE PROCEDURE 프로시저 이름( 매개변수명1[ IN | OUT | IN OUT ] 데이터타입[:= 디폴트값],
--      매개변수명2[ IN | OUT | IN OUT ] 데이터타입[:= 디폴트값], ... )
--  IS[AS]
--      변수, 상수 등 선언
--  BEGIN
--      실행
--  [EXCEPTION 예외처리부]
--  END [프로시저 이름]


--[프로시저]
-- 사원번호(eno=u_eno)와 급여(salary=u_salary)를 매개변수로 입력받아 해당 사원의 급여를 갱신하는 프로시저(update_pay)를 작성하여라.

CREATE OR REPLACE PROCEDURE update_pay(u_eno IN NUMBER, u_salary IN NUMBER)
IS
BEGIN
    UPDATE emp1 SET salary=u_salary WHERE eno=u_eno;
    COMMIT;
END update_pay;
/
EXEC update_pay(2001, 5000000);
EXEC update_pay(2006, 2800000);

-- 사원번호(eno)와 직급(pos), 주소(addr)를 입력 받아 갱신하는 프로시저(update_emp1)를 작성하고, 임의의 데이터로 3건이상 실행하도록 하시오. 
CREATE OR REPLACE PROCEDURE update_emp1(p_eno IN NUMBER, p_pos IN emp1.pos%TYPE, p_addr IN emp1.addr%TYPE)
IS
BEGIN
    UPDATE emp1 SET pos=p_pos, addr=p_addr where eno=p_eno;
    COMMIT;
END update_emp1;
/
EXEC update_emp1(2002, '과장', '서울 광진구');
EXEC update_emp1(2003, '대리', '서울 마포구');
EXEC update_emp1(2004, '부장', '서울 구로구');
select * from emp1;


-- 함수 문법
--    CREATE OR REPLACE FUNCTION 함수 이름 (매개변수1, 매개변수2....)
--    RETURN 데이터 타입;
--    IS[AS]
--        변수, 상수 선언..
--    BEGIN
--        실행부
--        RETURN 반환값
--        [EXCEPTION 예외처리부]
--    END [함수 이름];


-- [함수]
-- 사원번호(eno)를 매개변수로 입력받아 특정 직원의 세금(3.3%)을 계산하여 출력하는 함수(tax_fnc)를 작성하고 실행하여라.
-- 임의로 3건의 실행문을 실행하고, 그 결과를 출력하시오.

CREATE OR REPLACE FUNCTION tax1(v_eno IN emp1.eno%TYPE)
RETURN NUMBER
IS
    v_tax NUMBER; -- 리턴 값 변수 선언
BEGIN
    SELECT (salary + NVL(bonus, 0)) * 0.033 INTO v_tax FROM emp1 WHERE eno = v_eno;
    RETURN v_tax;
END tax1;
/


--호출시 함수는 EXEC가 필요없다.

-- 실행방법 1(?)
DECLARE
    v_tax NUMBER;
BEGIN
    v_tax := tax1(2003);
    DBMS_OUTPUT.PUT_LINE('세금 : ' || v_tax);
END;
/
-- 실행방법 2
select tax1(2003) as "세금" from dual;

-- 실행방법 3
select distinct tax1(2003) as "세금" from emp1;
select tax1(2003) as "세금" from emp1 where eno = 2003;

-- 직급(pos)을 매개변수로 입력받아 해당 직급별 급여 총액, 평균 급여, 인원수를 출력하는 프로시저(tot_emp)를 작성하시오.

CREATE OR REPLACE PROCEDURE tot_emp(v_pos IN VARCHAR2) 
IS
    tot_salary NUMBER;
    avg_salary NUMBER;
    emp_count NUMBER;
BEGIN
    SELECT SUM(salary+NVL(bonus,0)), AVG(salary + bonus,0)), COUNT(*) INTO TOT_SALARY, avg_salary, emp_count
    FROM emp1 WHERE pos=v_pos
    

    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(v_pos || '의 급여집계');
    DBMS_OUTPUT.PUT_LINE('급여 총액: ' || tot_salary || '원');
    DBMS_OUTPUT.PUT_LINE('평균 총액 ' || avg_salary || '원');
    DBMS_OUTPUT.PUT_LINE('인원 수' || emp_count || '명');
END tot_emp;
/

-- 사원을 추가하는 프로시저(ins_emp)를 작성하시오.
-- (단, 추가하는 데이터는 임의로 할 것.)
CREATE OR REPLACE PROCEDURE ins_emp1(veno IN emp1.eno%TYPE,
vename IN emp1.ename%TYPE, vpno IN emp1.pno%TYPE,
vpos IN emp1.pos%TYPE, vpcode IN emp1.pcode%TYPE,
vaddr IN emp1.addr%TYPE, vtel IN emp1.tel%TYPE,
vsalary IN emp1.salary%TYPE, vbonus IN emp1.bonus%TYPE,
vregdate IN emp1.regdate%TYPE, vgender IN emp1.gender%TYPE,
vsuperior IN emp1.superior%TYPE)
IS
BEGIN
    INSERT INTO emp1 VALUES(veno,vename,vpno,vpos,vpcode,vaddr,vtel,vsalary,vbonus,
    vregdate,vgender,vsuperior);
    COMMIT;
END;
EXEC ins_emp1(2011,'김다연',30,'사원','223-245','동두천시','031-457-1405',2350000,null,'2023-12-26',2,2005);
EXEC ins_emp1(2012,'히카루',40,'사원','123-125','서울시 구로구','02-2454-6903',2320000,null,'2024-01-10',1,2007);
EXEC ins_emp1(2013,'서영은',40,'사원','127-113','서울시 금천구','02-8654-2728',2320000,null,'2024-01-10',2,2006);
select * from emp1;

-- 사원번호(eno)를 매개변수로 입력받아 해당 직원에 대한 퇴사처리를 하는 프로시저(del_emp)를 작성하시오.
-- (단, del_emp 프로시저에서 매개값으로 사원번호가 2001인 사원을 진행할 것) 

CREATE OR REPLACE PROCEDURE del_emp(v_eno IN NUMBER)
-- create or replace procedure del_emp(v_eno IN emp.eno%TYPE)
IS
BEGIN
    DELETE FROM emp1 WHERE eno=v_eno;
    COMMIT;
--  [EXCEPTION 예외처리부]
END del_emp;
/
EXEC del_emp(2001);
select * from emp1;



