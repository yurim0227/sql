-- Q. 1
select emp.*, grade
    from emp join salgrade on sal >= losal and sal <= hisal
    order by grade, empno
;
-- Q. 2
select emp.*, grade
    from emp join salgrade on sal >= losal and sal <= hisal
    order by grade desc, empno desc
;
-- Q. 3
-- DEPTNO가 20,30인 부서 사람들의 등급별 평균연봉
-- 조건 :
    -- 1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 계산하도록 한다.
    -- 2. 연봉 계산은 SAL*12+COMM
    -- 3. 순서는 평균연봉이 내림차순으로 정렬한다.
select grade, round(avg(sal * 12 + nvl(comm, 0)), 1) 평균연봉
    from emp join salgrade on sal >= losal and sal <= hisal
    where deptno != 10
    group by grade
    order by 평균연봉 desc
;
-- Q. 4
-- 조건 :
    -- 1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 조회
    -- 2. 연봉 계산은 SAL*12+COMM
    -- 3. 순서는 평균연봉이 내림차순으로 정렬한다.
select deptno, round(avg(sal * 12 + nvl(comm, 0)), 0) 평균연봉
    from emp
    where deptno != 10
    group by deptno
    order by 평균연봉 desc
;
-- Q. 5
-- 사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬
select e1.empno, e1.ename, e1.job, e1.mgr, e2.ename MANAGER
    from emp e1, emp e2
    where e1.mgr = e2.empno
    order by empno
;
-- Q. 6
-- 사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬
-- 단, Select 절에 SubQuery를 이용하여 풀이
select empno, ename, job, mgr, (select e2.ename from emp e2 where e1.mgr = e2.empno) MANAGER
    from emp e1
    order by mgr, empno desc
;
-- Q. 7
-- MARTIN의 월급보다 많으면서 ALLEN과 같은 부서이거나 20번부서인 사원 조회
select *
    from emp
    where sal > (select sal from emp where ename = 'MARTIN')
    and (deptno = (select deptno from emp where ename = 'ALLEN') or deptno = 20)
;
-- Q. 8
-- ‘RESEARCH’부서의 사원 이름과 매니저 이름을 나타내시오.
select ename, (select ename from emp e2 where e1.mgr = empno) MANAGER
    from emp e1 join dept d on e1.deptno = d.deptno
    where dname = 'RESEARCH' order by mgr, empno desc
;
select ename, (select ename from emp e2 where e1.mgr = empno) MANAGER
    from emp e1, dept d
    where e1.deptno = d.deptno and dname = 'RESEARCH'
    order by mgr, empno desc
;
-- Q. 9
-- GRADE별로 급여을 가장 작은 사원명을 조회
select grade, ename 등급별가장작은급여
    from emp join salgrade on sal between losal and hisal
    where (grade, sal) in
    (
    select grade, min(sal)
        from emp, salgrade where sal between losal and hisal
        group by grade
    )
;
-- Q. 10
-- GRADE별로 가장 많은 급여, 가장 작은 급여, 평균 급여를 조회
select grade, min(sal) MIN_SAL, max(sal) MAX_SAL, round(avg(sal), 2) AVG_SAL
    from emp join salgrade on sal between losal and hisal
    group by grade
;
-- Q. 11
-- GRADE별로 평균급여에 10프로내외의 급여를 받는 사원명을 조회 - 정렬
with abc as
(
select floor(avg(sal)*0.9) s1, floor(avg(sal)*1.1) s2, grade
    from emp join salgrade on sal between losal and hisal
    group by grade
)
select grade, ename 평균10프로내외인사원
    from emp join abc on sal between s1 and s2
    order by 1, 2
;
--Q. 12
-- 지역 재난 지원금을 사원들에게 추가 지급
-- 조건 :
    -- 1. NEW YORK지역은 SAL의 2%, DALLAS지역은 SAL의 5%, CHICAGO지역은 SAL의 3%,
    -- BOSTON지역은 SAL의 7%
-- 2. 추가지원금이 많은 사람 순으로 정렬
select empno, ename, sal,
case when loc = 'NEW YORK' then sal * 1.02
when loc = 'DALLAS' then sal * 1.05
when loc = 'CHICAGO' then sal * 1.03
when loc = 'BOSTON' then sal * 1.07
end SAL_SUBSIDY
    from emp e, dept d
    where e.deptno = d.deptno
    order by
    case when loc = 'NEW YORK' then sal * 0.02
    when loc = 'DALLAS' then sal * 0.05
    when loc = 'CHICAGO' then sal * 0.03
    when loc = 'BOSTON' then sal * 0.07
    end desc
;