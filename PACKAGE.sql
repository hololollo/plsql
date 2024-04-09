-- 패키지(PACKAGE) : 여러개의 프로시저 또는 함수등을 하나의 그룹으로 묶은 묶음. 사용하지 않을 것.

-- 패키지 선언부(PACKAGE DECLARATION)
CREATE OR REPLACE PACKAGE emp_pack
IS
    PROCEDURE eno_out;
    PROCEDURE ename_out;
    PROCEDURE pno_out;
    PROCEDURE pos_out;
END emp_pack;    
/


-- 패키지 기능 정의부(PACKAGE DEFINE OF FUNCTION)
CREATE OR REPLACE PACKAGE BODY emp_pack 
IS
    CURSOR sw_cur IS SELECT * FROM emp1;
    
    PROCEDURE eno_out
    IS
    BEGIN
       DBMS_OUTPUT.PUT_LINE('사원번호');
       DBMS_OUTPUT.PUT_LINE('--------');
       FOR k IN sw_cur LOOP 
          DBMS_OUTPUT.PUT_LINE(k.eno);
       END LOOP;
    END eno_out;
    
    PROCEDURE ename_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('사원명');
        DBMS_OUTPUT.PUT_LINE('------');
        FOR k IN sw_cur LOOP 
            DBMS_OUTPUT.PUT_LINE(k.ename);
        END LOOP;
    END ename_out;
    
    PROCEDURE pno_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('부서번호');
        DBMS_OUTPUT.PUT_LINE('------');
        FOR k IN sw_cur LOOP
            DBMS_OUTPUT.PUT_LINE(k.pno);
        END LOOP;
    END pno_out;
    
    PROCEDURE pos_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('직급');
        DBMS_OUTPUT.PUT_LINE('----');
        FOR k IN sw_cur LOOP 
            DBMS_OUTPUT.PUT_LINE(k.pos);
        END LOOP;
    END pos_out;
    
END;
/
EXEC emp_pack.ename_out;
EXEC emp_pack.eno_out;
EXEC emp_pack.pos_out;