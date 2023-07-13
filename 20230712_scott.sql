--20230712
-- 03- 11. GRADE별로 평균급여에 10프로내외의 급여를 받는 사원명을 조회 - 정렬
-- where 에 subquery 활용
select s.grade, e.ename , e.sal
    from emp e join salgrade s  on e.sal between s.losal and s.hisal
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
                where s2.grade =  s.grade
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
select t1.grade, ename "10프로내외"
    from view_emp_salgrade t1
    where sal between (select avg(t2.sal) from view_emp_salgrade t2 where t2.grade = t1.grade)*0.9 
    and (select avg(t2.sal) from view_emp_salgrade t2 where t2.grade = t1.grade)*1.1
    order by t1.grade asc, 2 asc
;
Create or replace view view_emp_salgrade 
as
select e.empno, e.ename, job, mgr, hiredate, sal, comm, deptno, grade, losal, hisal
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal
;

--  from 절 subquery