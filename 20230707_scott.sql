-- 학습용 SCOTT 명령어들
SELECT *
FROM EMP
;
SELECT ENAME, SAL,EMPNO
FROM EMP
;
SELECT ENAME, MGR, SAL, DEPTNO 
FROM emp
WHERE DEPTNO=20 OR SAL>1500
;
SELECT ENAME, MGR, SAL, DEPTNO 
FROM emp
--WHERE ENAME = 'smith'
WHERE ENAME = 'SMITH'
-- ORA-00904: "SMITH": 부적합한 식별자
;
select empno, ename, sal
from emp
;
-- * 을 사용하는 것 보다 속도 빠름. 권장.
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp;
-- * 보다 컬럼명을 나열하는 것이 속도면에서 좋음.
select * from emp;
select * from dept;
select * from salgrade;
select * from bonus;


-- Q: 사원명과 연봉과 보너스포함한 연봉을 조회
select ename, sal*12, sal*12 + nvl(comm, 0)
from emp
;
select comm, nvl(comm, 0), nvl(comm, 100)
from emp
;
select ename as "사원명", sal*12 as 연봉, sal*12 + nvl(comm, 0) as "보너스 포함 연봉"
from emp
;
select ename "name", sal*12 sal12, sal*12 + nvl(comm, 0) salwcomm
from emp
;

select '안녕' as hello
from emp
;
select '안녕' as hello
from dept
;
select '$' as 단위, sal 
from emp
;
select distinct '$' as 단위, sal 
from emp
;

-- 급여를 1500보다 많이 받고 2800보다 적게 받는 직원 이름과 급여 조회
-- between and 사용
select ename, sal
    from emp
    where sal between 1500 and 2799
;
-- >= <= 사용
select ename, sal
    from emp
    where sal >= 1500 and sal < 2800
;
-- 20번 부서를 제외한 사원 정보를 조회
select * 
    from emp
--    where deptno != 20
--    where deptno <> 20
--    where deptno ^= 20
--    where not deptno = 20
    where deptno not in (20)
;
-- 20번 부서를 제외한 사원 중 comm이 null이 아닌 사원 정보를 조회
select * 
    from emp
    where not deptno = 20 
--        and comm is not null
-- 오류        comm != null  comm = null
;
-- 10, 20, 30 부서를 사원 정보를 조회
select * 
    from emp
--    where deptno = 10 OR deptno = 20 OR deptno = 30
    where deptno in (10, 20, 30)
;
-- 10, 20, 30 부서를 제외한 사원 정보를 조회
select * 
    from emp
--    where not (deptno = 10 OR deptno = 20)
--    where deptno != 10 AND deptno != 20 AND deptno != 30
    where deptno not in (10,20,30)
;
select * from emp;


-- 급여를 1800보다 많이 받고 2500보다 적게 받는 직원이름과 급여 조회

-- ‘S’로 시작하는 2글자이상의 이름을 가진 직원 이름과 급여 조회
select ename, sal 
    from emp
    where ename like 'S_%'
;
--ORA-00933: SQL 명령어가 올바르게 종료되지 않았습니다
--00933. 00000 -  "SQL command not properly ended"
--SQL Error [933] [42000]: ORA-00933: SQL 명령어가 올바르게 종료되지 않았습니다

-- 핸드폰의 앞 네 자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
-- 이름 중 3번째 글자가 ‘S’ 인 직원 이름과 급여 조회
select ename, sal 
    from emp
    where ename like '__S%'
;
-- 이름 중 3번째 글자가 ‘_’ 인 직원 이름과 급여 조회
select ename, sal 
    from emp
    -- 이름이 4글자 이상인 직원
--    where ename like '___%'  
    where ename like '__\_%' escape '\'
         or job like '__@_%' escape '@'
-- like '__*_' escape '*'
;
-- EMAIL ID 중 ‘_’의 앞이 3자리인 직원 이름, 이메일 조회
-- ‘이’씨 성이 아닌 직원 사번, 이름, 이메일 조회
-- 관리자도 없고 부서 배치도 받지 않은 직원 조회 - *
select *
    from emp
    where mgr is null
        and deptno is null
;
-- 관리자가 없지만 보너스를 지급받는 직원 조회
select *
    from emp
    where mgr is null
        and comm is not null
;
-- 20 부서와 30 부서원들의 이름, 부서코드, 급여 조회
-- in
select ename, deptno, sal
    from emp
    where deptno in (20, 30)
    -- deptno = 20 or deptno = 30
;

-- ANALYST 또는 SALESMAN 인 사원 중 급여를 2500보다 많이 받는 직원의 이름, 급여, job 조회
select ename, sal, job
    from emp
    where job in ('ANALYST', 'SALESMAN') 
        and sal >= 2500
    ;
-- 사원명의 길이와 byte크기를 조회
select length(ename), lengthb(ename)
    from emp
    ;
--select ' a안 녕b ', length(' a안 녕b '), lengthb(' a안 녕b ')
select trim(' a안 녕b '), length(trim(' a안 녕b ')), lengthb(trim(' a안 녕b ')) 
--    from emp
    from dual
--   테이블 dual 은 임시테이블로 연산이나 간단한 함수 결과값을 조회할때 사용함.
;
-- 사원명의 시작부분 S와 끝나는 부분 S 모두 제거해주세요.
select Rtrim(Ltrim(ename, 'S'), 'S') from emp;
-- Ltrim 예시 010 제거

-- Lpad / Rpad 채워넣기
-- ename이 총 10자가 되도록 left 쪽에 'S'를 채워주세요.
select Lpad(ename, 10, 'S') from emp;
-- ename이 총 10자가 되도록 left 쪽에 ' ' 공백(default)를 채워주세요.
select Lpad(ename, 10) from emp;

-- 문자(컬럼) 이어붙이기
select concat(ename, comm) from emp;
select ename||comm from emp;
select sal||'달러' from emp;
select concat(sal, '달러') from emp;
-- substr 엄청중요 !!
-- replace
select replace(ename, 'AM', 'AB') from emp;


select ename||'s family' , sal ||'원'
from emp;
select sal, '원'
from emp;

-- sysdate은 함수는 아니나 명령어가 실행되는 시점에 결과값을 출력해주므로 함수호출과 같이 동작함.
select sysdate, add_months(sysdate, 1) from dual;
select hiredate from emp;
select hiredate, add_months(hiredate, 1) from emp;
-- 2023.07.10 (월)
select sysdate, to_char(sysdate, 'yyyy.mm.dd (dy) hh24:mi:ss')  from dual;
select sysdate, to_char(sysdate, 'yyyy.mm.dd (day) hh24:mi:ss')  from dual;

alter session set NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';
select sysdate from dual;
select * from emp;

-- year 2023 month 09 day 11 hour 13
select to_date('2023091113', 'yyyymmddhh24') from dual;
select add_months(to_date('2023091113', 'yyyymmddhh24'), 5) from dual;
select next_day(to_date('2023091113', 'yyyymmddhh24'), '수') from dual;  
select next_day(to_date('2023091113', 'yyyymmddhh24'), 4) from dual;  
-- 1:일요일, 2 월요일, 3 화요일...
select last_day(to_date('2023091113', 'yyyymmddhh24')) from dual;

-- 오류 select add_months('20230911132214', 4) from dual;

select to_char(empno, '000000') , '$'||trim(to_char(sal, '999,999,999,999'))
    from emp;
select to_char(empno, '000000') , trim(to_char(sal, 'L999,999,999,999'))
    from emp;

select to_number('123,4567,89.01', '999,9999,99.99')*5 from dual;
-- 오류 select '123,4567,8901'*5 from dual;
-- 오류 select '123,456,789,012'*5 from dual;

-- 직원들의 평균 급여는 얼마인지 조회
select avg(sal) 평균급여 from emp;
select sum(sal) sum from emp;
select max(sal) max from emp;
select min(sal) min from emp;
select count(sal) count from emp;
-- 부서별 평균 급여 조회
select avg(sal) 평균급여, deptno from emp group by deptno;
select sum(sal) sum, deptno from emp group by deptno;
select max(sal) max, deptno from emp group by deptno;
select min(sal) min, deptno from emp group by deptno;
select count(sal) count, deptno from emp group by deptno;
select count(*) count, deptno from emp group by deptno;
-- job별 평균 급여 조회
select avg(sal) 평균급여, job from emp group by job;
select sum(sal) sum, job from emp group by job;
select max(sal) max, job from emp group by job;
select min(sal) min, job from emp group by job;
select count(sal) count, job from emp group by job;
select count(*) count, job from emp group by job;

-- job이 ANALYST 인 직원의 평균 급여 조회
select avg(sal) 평균급여, job 
    from emp 
    group by job
    having job='ANALYST'
;
select avg(sal) 평균급여
    -- 오류, job 
    from emp 
    where job='ANALYST'
;
-- job이 CLERK 인 부서별 직원의 평균 급여 조회
---- job이 CLERK 인 부서별 직원
select job, deptno, ename, sal
    from emp
    where job='CLERK';
-- job이 CLERK 인 부서별 직원의 평균 급여 조회
select job, deptno, avg(sal)
--, ename
    from emp
    where job='CLERK'
    group by deptno, job
    ;

select * from emp
    order by sal desc, ename asc
    ;
select sal, sal*12+nvl(comm,0) salcomm 
    from emp
    order by salcomm desc, sal asc
    ;
select ename, sal*12+nvl(comm,0)  
    from emp
    order by 2 desc, 1 desc
    ;
-- job 오름차순
select * from emp
--    order by job;
    order by 3;    
    
    
--- 사원명, 부서번호, 부서명, 부서위치를 조회
select * from dept;
select * from emp;
select * 
    from emp
        join dept on emp.deptno = dept.deptno        
;
select * 
    from emp
        join dept using (deptno)
;
select emp.ename, emp.deptno, dept.dname, dept.loc
    from emp
        join dept on emp.deptno = dept.deptno        
;
--ORA-00918: 열의 정의가 애매합니다
--00918. 00000 -  "column ambiguously defined"
select ename, dept.deptno, dname, loc
    from emp
        join dept on emp.deptno = dept.deptno        
;
select *
    from emp
        join dept using (deptno)
;
select ename, deptno, dname, loc
    from emp
        join dept using (deptno)
;

select ename, dept.deptno, dname, loc
    from emp, dept 
    where emp.deptno = dept.deptno
;
-- 부서위치가 DALLAS인 사원명, 부서번호, 부서명, 위치를 조회
select ename, dept.deptno, dname, loc
    from emp, dept 
    where emp.deptno = dept.deptno
        and loc = 'DALLAS'
;

select empno, loc
    from emp cross join dept
;

select * from emp;
select * from salgrade;
-- 사원의 이름, 사번, sal, grade 를 조회
select e.ename, e.empno, e.sal, s.grade
    from emp e join salgrade s         
                on e.sal between s.losal and s.hisal
    order by s.grade desc, e.sal desc
;
select ename, empno, sal, grade
    from emp join salgrade         
                on sal between losal and hisal
    order by grade desc, sal desc
;
select empno, ename, mgr from emp;
select e.empno, e.ename, e.mgr, m.ename mgrname
    from emp e join emp m 
        on e.mgr = m.empno
;
-- 같은 이름 컬럼명이 나타나지 않도록 별칠 사용
select e.empno boss, e.ename, m.empno emp, m.ename emps
    from emp e join emp m 
        on e.empno = m.mgr
;
select ename from emp where empno=7566
;
select * from emp;

-- 자료형
create table t1( 
    c1 char(5), 
    c2 varchar2(5) 
);
insert into t1 values('12','12');
insert into t1 values('12345','12345');
--ORA-12899: "SCOTT"."T1"."C1" 열에 대한 값이 너무 큼(실제: 6, 최대값: 5)
--insert into t1 values('123456','123456');
--ORA-12899: "SCOTT"."T1"."C2" 열에 대한 값이 너무 큼(실제: 6, 최대값: 5)
--insert into t1 values('12345','123456');
commit;
select * from t1;
select length(c1), length(c2) from t1;

desc t1;
desc emp;

-- ERD( entity relationship diagram )
-- UML  - classDiagram, ERD


select rownum, e.* from emp e where deptno in (20, 30)
;
-- 오류
select rownum, e.* from emp e where deptno in (20, 30)
    order by ename asc
;
-- 해결 방법
select rownum, e.* 
    from ( select * from emp order by ename asc ) e 
    where deptno in (20, 30)
;
select rownum, e.* 
    from ( select * from emp where deptno in (20, 30) order by ename asc ) e 
;
select * from emp order by ename asc;
-- 1page 1-3
select rownum, e.* 
    from ( select * from emp where deptno in (20, 30) order by ename asc ) e 
    where rownum between 1 and 3
;
-- 2page 4-6
select rownum rnum, e.* 
    from ( select * from emp where deptno in (20, 30) order by ename asc ) e 
    where rownum between 4 and 6
--    rnum은 select -6 수행순서로 where 절에서 사용할 수 없음.
;
select sysdate, e.* 
    from ( select * from emp where deptno in (20, 30) order by ename asc ) e 
    where sysdate > '2023-06-11'
;
-- 해결 - ROWNUM을 제대로 사용하기 위해서는 2개의 중첩 subquery(inline-view)필요함.
-- 3page 7-9
select *
    from (select rownum rnum, e.* 
                from ( select * from emp where deptno in (20,30) order by ename asc ) e
            )
    where rnum between 7 and 9
;

with abc as (select rownum rnum, e.* 
                from ( select * from emp where deptno in (20,30) order by ename asc) e )
select *
from abc
where rnum between 7 and 9
-- abc 가 마치 새로운 테이블 처럼 사용가능함.
--    and sal > (select avg(sal) from abc)
;

create view view_abc 
as
select rownum rnum, e.* 
                from ( select * from emp where deptno in (20,30) order by ename asc) e
;
select * from view_abc;
select *
from view_abc
where rnum between 7 and 9
;

--20230712
-- 03- 11. GRADE별로 평균급여에 10프로내외의 급여를 받는 사원명을 조회 - 정렬
select s.grade, e.ename , e.sal
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal
    where e.sal > 
    -- 다중 행 결과물과 >= 비교 안됨.(950, 1266, 1550, 2879, 5000 )
            (
            select avg(sal)
                from emp e2 join salgrade s2
                    on e2.sal between s2.losal and s2.hisal
                where s2.grade = s.grade
                --group by s2.grade having s2.grade = 4
            )*0.9
            and e.sal <
            (
            select avg(sal)
                from emp e2 join salgrade s2
                    on e2.sal between s2.losal and s2.hisal
                where s2.grade = s.grade
                --group by s2.grade having s2.grade = 4
            )*1.1
;
select avg(sal) , s.grade
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal
    group by s.grade
;
-- select에서 rownum 반드시 별칭
-- select에서 함수사용한 경우 반드시 별칭
-- with 사용
with abc3 as ( select s.grade, e.ename , e.sal
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal )
select *
    from abc3 t1
    where sal between (select avg(t2.sal) from abc3 t2 where t2.grade = t1.grade)*0.9
    and (select avg(t2.sal) from abc3 t2 where t2.grade = t1.grade)*1.1
;
select *
    from view_emp_salgrade t1
    where sal between (select avg(t2.sal) from abc3 t2 where t2.grade = t1.grade)*0.9
    and (select avg(t2.sal) from abc3 t2 where t2.grade = t1.grade)*1.1
;
Create or replace view view_emp_salgrade
as
select e.empno, e.ename, job, mgr, hiredate, sal, comm, deptno, grade, losal, hisal
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal
;


select * from emp e join dept d on e.deptno=d.deptno;
select * from salgrade;
select * from dept;

--SALESMAN 들의 급여와 같은 급여를 받는 사원을 조회
select empno, ename, sal
    from emp
    where sal < all (select sal from emp where job='SALESMAN')
--    where sal < (select max(sal) from emp where job='SALESMAN')
;
select ename,sal from emp where job='SALESMAN' ;

--관리자로 등록되어 있는 사원들을 조회
select empno, ename
    from emp e
    where exists ( select empno from emp e2 where e2.empno = e.mgr)
;
select * from emp;

select * from user_constraints;
