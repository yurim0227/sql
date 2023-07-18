SET SERVEROUTPUT ON;
SET SERVEROUTPUT OFF;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD2');
    DBMS_OUTPUT.PUT('HELLO WORLD3');
    DBMS_OUTPUT.PUT('HELLO WORLD4');
    DBMS_OUTPUT.PUT_LINE();
--오류 보고 -
--ORA-06550: 줄 6, 열5:PLS-00306: 'PUT_LINE' 호출 시 인수의 갯수나 유형이 잘못되었습니다
--ORA-06550: 줄 6, 열5:PL/SQL: Statement ignored
--06550. 00000 -  "line %s, column %s:\n%s"
END;
/
DECLARE
--    dno dept.deptno%type;
--    dnm dept.dname%type;
--    dloc dept.loc%type;
BEGIN
    insert into dept values('&deptno','&부서명','&지역');
    commit;
END;
