-- 커서(cursor) : SELECT 또는 DML과 같은 SQL의 ※한 컬럼※의 결과셋(ResultSet)을 저장하여 필요한 곳에서 활용하기 위한 객체
--      선언(DECLARATION)[resultset] -> 열기(OPEN) -> ※반복※ 읽기, 불러오기(FETCH) -> 닫기(CLOSE) : 명시적 커서(반복문)
--      선언(DECLARATION)[resultset] -> 반복 루프(FOR/LOOP/WHILE) : 묵시적 커서(열기/불러오기/닫기 구분 없다.)

-- 명시적 커서(EXPLICIT CURSOR)

select * from emp1;

-- PL 실행 결과 출력문 활성화
SET SERVEROUTPUT ON;

-- 부서코드가 10인 사원명 직급 급여 및 전체건수 출력
CREATE OR REPLACE PROCEDURE emp_prt1(vpno IN emp1.pno%TYPE)
IS -- IS 뒤에 커서 선언
    CURSOR cur_pno
    IS
    SELECT pno, ename, pos, salary from emp1 where pno = vpno;
vppo emp1.pno%TYPE; -- RESULTSET
vename emp1.ename%TYPE; -- RESULTSET
vpos emp1.pos%TYPE; -- RESULTSET
vsalary emp1.salary%TYPE; -- RESULTSET
BEGIN
    OPEN cur_pno; -- 커서 열기
    DBMS_OUTPUT.PUT_LINE('**********************');
    DBMS_OUTPUT.PUT_LINE('부서코드 사원명 직급 급여');
    DBMS_OUTPUT.PUT_LINE('**********************');
    LOOP
        FETCH cur_pno INTO vppo, vename, vpos, vsalary;  --원하는 수 만큼 반복된다. (FETCH => 반복 시작)
        EXIT WHEN cur_pno%NOTFOUND; -- 끝나는 시점 명시(cur_pno를 더이상 읽을 수(실행될 수) 없을 때 까지)
        DBMS_OUTPUT.PUT_LINE(RPAD(vppo,5) || ' ' || RPAD(vename,5) || ' ' || RPAD(vpos,5) || ' ' || RPAD(vsalary,5));
    END LOOP; -- 반복 종료
    DBMS_OUTPUT.PUT_LINE('**********************'); 
    DBMS_OUTPUT.PUT_LINE('전체 건수 : ' || cur_pno%ROWCOUNT);
    CLOSE cur_pno; -- 커서 닫기
END;
/
EXEC emp_prt1(10); -- 부서코드가 10인 사원명 직급 급여 및 전체건수 출력 실행선언

-- 묵시적 커서
CREATE OR REPLACE PROCEDURE emp_prt2(vpno IN emp1.pno%TYPE)
IS
    CURSOR cur_pno IS SELECT pno, ename, pos, salary FROM emp1 WHERE pno=vpno;
vcnt NUMBER; -- vcnt를 선언
BEGIN
    DBMS_OUTPUT.PUT_LINE('**********************');
    DBMS_OUTPUT.PUT_LINE('부서코드 사원명 직급 급여');
    DBMS_OUTPUT.PUT_LINE('**********************');
    FOR cur IN cur_pno LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(cur.pno,5) || ' ' || RPAD(cur.ename,5) || ' ' || RPAD(cur.pos,5) || ' ' || RPAD(cur.salary,5));
        vcnt := cur_pno%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************'); 
    DBMS_OUTPUT.PUT_LINE('전체 건수 : ' || vcnt);
END;
/
EXEC emp_prt2(10);


-- 직속코드 (SUPERIOR)를 매개변수로 입력받아 입력한 직속코드에 속한 직원의 사원번호(eno), 사원명(ename), 직급(pos), 급여(salary)를 출력하는 cur_super를
-- 묵시적 커서(IMPLICIT CURSOR)로 생성하시오.
CREATE OR REPLACE PROCEDURE cur_super(vsuperior IN emp1.superior%TYPE)
IS
    CURSOR cur_super IS SELECT eno, ename, pos, salary FROM emp1 WHERE superior=vsuperior;
cnt NUMBER; -- vcnt를 선언
BEGIN
    DBMS_OUTPUT.PUT_LINE('**********************');
    DBMS_OUTPUT.PUT_LINE('사원번호 사원명 직급 급여');
    DBMS_OUTPUT.PUT_LINE('**********************');
    FOR cur IN cur_super LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(cur.eno,5) || ' ' || RPAD(cur.ename,6) || ' ' || RPAD(cur.pos,5) || ' ' || RPAD(cur.salary,30));
        cnt := cur_super%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************'); 
    DBMS_OUTPUT.PUT_LINE(vsuperior || '가 직속상관인 수 : ' || cnt);
END;
/
EXEC cur_super(2004);
select * from emp1;