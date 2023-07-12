--Q. 1
select e.*, grade
    from emp e 
        join salgrade sa on e.sal > sa.losal and e.sal < sa.hisal
        order by grade, empno;

--Q. 2
select e.*, grade
    from emp e 
        join salgrade sa on e.sal > sa.losal and e.sal < sa.hisal
        where deptno!=10 order by grade desc, empno desc;

--Q. 3
select grade, round(avg(sal*12+nvl(comm,0)), 0) as "평균연봉"
    from emp e
        join salgrade sa on e.sal > sa.losal and e.sal < sa.hisal
            where deptno!=10 group by grade order by "평균연봉" desc;

--Q. 4
select deptno, round(avg(sal*12+nvl(comm,0)), 0) as "평균연봉"
    from emp e
        join salgrade sa on e.sal > sa.losal and e.sal < sa.hisal
            where deptno!=10 group by deptno order by "평균연봉" desc;

--Q. 5
SELECT e.empno, e.ename, e.job, e.mgr, m.ename as MANAGER
    FROM emp e, emp m
        where e.mgr = m.empno
            order by e.empno;

--Q. 6
SELECT e.empno, e.ename, e.job, e.mgr, (select ename from emp m where m.empno=e.mgr) as MANAGER
    FROM emp e
        order by e.mgr, e.empno desc;

--Q. 7
select * 
    from emp 
        where sal > (select sal from emp where ename IN 'MARTIN') 
            AND (deptno=(select deptno from emp where ename IN 'ALLEN') or deptno=20);

--Q. 8
select e.ename, (select ename from emp m where m.empno=e.mgr) as MANAGER
    from emp e, dept d
        where e.deptno=d.deptno AND d.dname IN 'RESEARCH';

--Q. 9
select sa.grade, ename as "등급별가장작은급여"
    from emp e, salgrade sa
        where (grade, sal) IN (select grade, min(sal) from emp, salgrade where sal >= losal and sal <= hisal group by grade);

--Q. 10
select grade, min(sal) as "MIN_SAL", max(sal) as "MAX_SAL", round(avg(sal), 2) as "AVG_SAL"
    from emp e, salgrade sa
        where sal >= losal and sal <= hisal
        group by grade;

--Q. 11
--select sa.grade, e.ename as "상위10프로사원"
--    from (select grade, ename, sal, percent_rank() over(partition by grade order by sal desc) as rank from emp, salgrade where sal >= losal and sal <= hisal) e, salgrade sa
--        where sal >= losal and sal <= hisal and e.rank <= 0.1;

with tenper as (select floor(avg(e2.sal)*0.9) as min_sal, floor(avg(e2.sal)*1.1) as max_sal, sa2.grade
            from emp e2 join salgrade sa2 on e2.sal between sa2.losal and sa2.hisal
                group by sa2.grade)        
select grade, ename as "평균10프로내외인사원"
    from emp e
        join tenper on e.sal between min_sal and max_sal
            order by grade, 2;
    
select * from emp;
select * from salgrade;

    
    
--Q. 12
select empno, ename, sal, 
(case when loc = 'NEW YORK' then sal*1.02
    when loc = 'DALLAS' then sal*1.05
    when loc = 'CHICAGO' then sal*1.03
    when loc = 'BOSTON' then sal*1.07
    end) as SAL_SUBSIDY
    from emp e, dept d
        where e.deptno = d.deptno
            order by (case when loc = 'NEW YORK' then sal*0.02
                        when loc = 'DALLAS' then sal*0.05
                        when loc = 'CHICAGO' then sal*0.03
                        when loc = 'BOSTON' then sal*0.07
                        end) desc;