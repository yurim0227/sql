-- 1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
select e.emp_name, e.emp_no, d.dept_title, j.job_name
    from employee e
    join department d on e.dept_code = d.dept_id join job j on e.job_code = j.job_code
    where (e.emp_no, e.emp_name) in
    (
    select emp_no, emp_name
        from employee
        where substr(emp_no, 1, 2)>='70'
        and substr(emp_no, 1, 2)<='79'
        and substr(emp_no, 8, 1)='2'
        and emp_name LIKE '전%'
    )
;
-- 2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
select emp_id, emp_name, age, dept_title, job_name
    from
    (
    select e.emp_id, e.emp_name, d.dept_title, j.job_name, (123 - SUBSTR(e.emp_no, 1, 2)) AS age
        from employee e
        join department d on e.dept_code = d.dept_id join job j on e.job_code = j.job_code
        order by age
    ) t
    where rownum = 1
;
-- 3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
select emp_id, emp_name, job_name
    from employee e
    join department d on e.dept_code = d.dept_id join job j on e.job_code = j.job_code
    where emp_name like '%형%'
;
-- 4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
select emp_name, job_name, dept_code, dept_title
    from employee e
    join department d on e.dept_code = d.dept_id join job j on e.job_code = j.job_code
    where dept_code IN ('D5', 'D6')
;
-- 5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
select emp_name, bonus, dept_title, local_name
    from employee e
    join department d on e.dept_code = d.dept_id join location l on d.location_id = l.local_code
    where bonus is not null
;
-- 6. 사원 명, 직급 명, 부서 명, 지역 명 조회
select emp_name, job_name, dept_title, local_name
    from employee e
    join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
    join location l on d.location_id = l.local_code
;
-- 7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
select emp_name, dept_title, local_name, national_name
    from employee e
    join department d on e.dept_code = d.dept_id
    join location l on d.location_id = l.local_code
    join national n on l.national_code = n.national_code
    where n.national_name = '한국' or n.national_name = '일본'
;
-- 8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
select e.emp_name, e.dept_code, m.emp_name
    from employee e, employee m
    where e.dept_code = m.dept_code
    order by e.emp_name
;
-- 9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
select emp_name, job_name, salary
    from employee e join job j on e.job_code = j.job_code
    where bonus is null and e.job_code in ('J4', 'J7')
;
-- 10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
select emp_id, emp_name, dept_title, job_name, hire_date
    from
    (
    select emp_id, emp_name, dept_title, job_name, hire_date, (salary*(salary+nvl(bonus,0))*12) as grade
        from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
        join location l on d.location_id = l.local_code
        order by grade desc
    ) t
    where rownum <= 5
;
-- 11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
    -- 11-1. JOIN과 HAVING 사용
    select d.dept_title, sum(salary)
        from employee e join department d on e.dept_code = d.dept_id
        group by d.dept_title
        having sum(salary) >=
        ((
        select sum(salary)
            from employee
        ) * 0.2)
    ;
    -- 11-2. 인라인 뷰 사용
    select *
        from
        (
        select d.dept_title, sum(salary) as sums
            from employee e, department d
            where e.dept_code=d.dept_id
            group by d.dept_title
        ) sum
        where sum.sums >=
        ((
        select sum(salary)
            from employee
        ) * 0.2)
    ;
    -- 11-3. WITH 사용
    with sum as
    (
    select d.dept_title, sum(salary) as sums
        from employee e, department d
        where e.dept_code=d.dept_id
        group by d.dept_title
    )
    select *
        from sum
        where sum.sums >=
        ((
        select sum(salary)
            from employee
        ) * 0.2)
    ;
-- 12. 부서 명과 부서 별 급여 합계 조회
select d.dept_title, sum(e.salary)
    from employee e join department d on e.dept_code = d.dept_id
    group by d.dept_title
;
-- 13. WITH를 이용하여 급여 합과 급여 평균 조회
with sumavg as
(
select sum(salary) as sums, avg(salary) from employee e
)
select *
    from sumavg
;