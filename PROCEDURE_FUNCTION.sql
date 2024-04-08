
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

-- 원의 반지름을 입력받아 원주율(3.1415) 를 반영하여 넓이를 구하는 함수(circle_fnc)를 작성하시오.
-- ex) NUMBER(10,2) => 정수 8자리이고 소숫점이하 2자리 표현 (총10자리숫자 중 00000000.00)
-- DECLARE 생략
CREATE OR REPLACE FUNCTION circle_fnc(radius IN NUMBER)
RETURN NUMBER
IS 
    circle NUMBER;
BEGIN
    circle := radius * radius * 3.1415;
    RETURN circle;
END;
/

select circle_fnc(25) as "면적" from dual;

-- 너비(w),높이(h), 깊이(d)를 매개변수로 입력받아 직육면체의 부피를 구하는 함수(box_vol)를 작성하고, 실행하시오.
CREATE OR REPLACE FUNCTION box_vol(w IN NUMBER, h IN NUMBER, d IN NUMBER)
RETURN NUMBER
IS
    box NUMBER;
BEGIN
    box := w * h* d;
    RETURN box;
END;
-- END[box]
/
select box_vol(5,5,5) as "부피" from dual;

-- 사원(emp1) 테이블로 부터 근무기간(y년x개월)을 계산하는 함수(workdays_fnc)를 작성하시오.
-- (단, 입사일을 입력받아 MONTH_BETWEEN함수를 사용하여 년수와 개월수를 구할 수 있도록 할 것)
-- (실행 시에는 사원명(ename)과 근무기간(y년 x개월)이 출력되도록 할 것.)

CREATE OR REPLACE FUNCTION workdays_fnc(v_date IN DATE)
RETURN VARCHAR2
IS
    work VARCHAR2(20);
BEGIN
    work := FLOOR(MONTHS_BETWEEN(sysdate, v_date)/12) || '년' || FLOOR(MOD(MONTHS_BETWEEN(SYSDATE, v_date), 12)) || '개월';
    RETURN work;
END;
/
select ename AS "사원명", TO_CHAR(regdate, 'YYYY-MM-DD') AS "입사일", workdays_fnc(regdate) AS "근무기간" from emp1;   
-- MONTHS_BETWEEN(나중날짜, 먼저날짜) : 흐른 개월 수 계산 (ex.98개월)
-- FLOOR(숫자) : 소숫점 이하 버림 (ex. 3.14 -> 3 / -3.14 -> -4 => 가장 가까운 아래쪽 정수로 내림하는 데 사용)
-- 년수 구하기 : FLOOR(MONTHS_BETWEEN(SYSDATE, 입사일)/12) (ex. 98/12=8.16667.. => 8년)
-- 잔여 개월수 구하기 : FLOOR(MOD(MONTHS_BETWEEN(SYSDATE, 입사일), 12)) (ex. 98 mod 12 => 2개월) 



--사원(emp1)테이블에서 성별코드(gender)를 이용하여 성별을 구하는 함수(gender_fnc)를 작성하고, 실행하시오.
-- (단, 성별코드(gender)가 1이거나 3이면, '남'이고, 아니면, '여'이다.)
-- (실행결과는 사원명, 성별 컬럼이 출력될 수 있도록 하시오.)

CREATE OR REPLACE FUNCTION gender_fnc(vgender NUMBER)
RETURN VARCHAR2
IS
    sgender VARCHAR2(4);
BEGIN
    IF vgender IN(1,3) THEN
        sgender := '남';
    ELSE
        sgender := '여';
    END IF;
    RETURN sgender;
END;
/

-- 문제에 주민등록번호 8번째 글자를 기준으로 남, 여를 나눠라 이렇게 추가될 수 도 있다.
-- IS gcode VARCHAR(4);
-- gcode := SUBSTR(jumin, 8, 1) 성별코드가 주민번호에서 8번째글자 1글자인 경우
-- IF(gcode IN('1','3') THEN


SELECT ename AS "사원명", gender_fnc(gender) AS "성별" FROM emp1;
    
-- else if => ELS IF
-- 사원(emp1) 테이블에서 급여(salary)를 이용하여 급여등급을 구하는 함수(grade_emp)를 작성하고, 실행하시오.
-- (단, 급여가 4,500,000 이상이면 'A', 3,500,000 DLTKDDLAUS 'B', 3,000,000이상이면, 'C', 나머지는 'D 로)
-- (실행결과는 사원코드, 사원명, 급여등급, 급여 순으로 출력될 수 있도록 하시오.)
-- (EX. IF THEN~ELSIF THEN~ELSE)

CREATE OR REPLACE FUNCTION grade_emp( vsalary NUMBER)
RETURN VARCHAR2
IS
    ssalary VARCHAR2(4);
BEGIN
    IF vsalary >= 4500000 THEN
        ssalary := 'A';
    ELSIF vsalary >= 3500000 THEN
        ssalary := 'B';
    ELSIF vsalary >= 3000000 THEN
        ssalary := 'C';
    ELSE
        ssalary := 'D';
    END IF;
END;

SELECT eno AS "사원코드", ename AS "사원명", grade_emp(salary) AS "급여등급", salary AS FROM emp1;


-- loop_test 테이블 생성
-- 번호(no)숫자
--이름(name)가변문자열 20 글자, 기본값 '강범준'
create table loop_test(no NUMBER, name VARCHAR2(20) DEFAULT '강범준');
-- loop문을 활용하여 번호를 증가식으로 자동 채우면서 20개의 레코드를 추가될 수 있도록 반복할 것.
-- 번호는 1~20
DECLARE
    vcnt NUMBER(2) := 1;
BEGIN
    LOOP
        INSERT INTO loop_test(NO) VALUES (vcnt);
        vcnt := vcnt + 1;
        EXIT WHEN vcnt > 20;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE((vcnt-1) || '건 데이터 입력 완료');
END;
commit;
-- / 안쓰는 이유 : 익명의 값이기 때문에. commit이 필요한 이유.
-- 익명의 값은 exec로 실행을 하지 않아도 바로 실행이 된다. 따라서 바로 select 검색을 해보면 값이 변해있는 것을 알 수 있다.
select * from loop_test;

-- FOR IN LOOP 문을 활용하여 번호를 증가시키고 자동 채우면서 10개의 레코드를 추가될 수 있도록 반복할 것.
-- 번호는 21~30, 프로시저 이름 : loop2
CREATE OR REPLACE PROCEDURE loop2
IS
BEGIN
    FOR i IN 21..30 LOOP -- 21부터 30까지
        INSERT INTO loop_test(NO) VALUES (i);
        COMMIT;
    END LOOP;
END; 
/ -- 계속 컴파일하면 숫자가 증가됨.. 60까지 만들어졌던 이유
-- 여기까지 는 단순히 컴파일만 된 것임. 프로시저는 따로 실행을 해야 함. (EXEC => 실행만 하는것임. 실제로 데이터값을 검색하려면 select문 활용)

EXEC loop2;
select * from loop_test;

-- WHILE LOOP 문을 활용하여 번호를 증가시키고 자동 채우면서 10개의 레코드를 추가될 수 있도록 반복할 것.
-- 번호는 31~40, 프로시저 이름 : loop3
CREATE OR REPLACE PROCEDURE loop3
IS
    vcnt NUMBER(2) := 31;
BEGIN
    WHILE vcnt <= 40 LOOP
        INSERT INTO loop_test(NO) VALUES (vcnt);
        COMMIT;
        vcnt := vcnt + 1;        
    END LOOP;
END;
/

EXEC loop3;

select * from loop_test;



-- 예외처리 프로시저 exc_test

CREATE OR REPLACE PROCEDURE exc_test
IS
    sw emp1%ROWTYPE;
BEGIN
    SELECT * INTO sw FROM emp1; 
    DBMS_OUTPUT.PUT_LINE('데이터 검색 성공');
    COMMIT;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('데이터가 너무 많습니다.');
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('해당 데이터가 없습니다.');
    WHEN OTHER THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('기타 오류로 인해 정상처리 되지 못했습니다.');
END;
/