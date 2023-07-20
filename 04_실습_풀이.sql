select * from employee;
select * from department;
select * from job;
select * from location;
select * from national;

-- 1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
select emp_name, emp_no, dept_title, job_name
    from employee join department on dept_code = dept_id join job using (job_code)
    where substr(emp_no, 1, 2) >= 70 and substr(emp_no, 1, 2) <= 79
    and substr(emp_no, 8, 1) = 2
    and substr(emp_name, 1, 1) = '전'
;
-- 2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
select emp_id, emp_name, (extract(year from sysdate) - (substr(emp_no, 1, 2) + 1900) + 1) age, dept_title, job_name
    from employee join department on dept_code = dept_id join job using (job_code)
    where (extract(year from sysdate) - (substr(emp_no, 1, 2) + 1900) + 1)
    = (select min(extract(year from sysdate) - (substr(emp_no, 1, 2) + 1900) + 1) from employee)
;
select emp_id, emp_name, age, dept_title, job_name
    from
    (
    select emp_id, emp_name, dept_title, job_name,
    (extract(year from sysdate) - (substr(emp_no, 1, 2) + 1900) + 1) age
        from employee
        join department on dept_code = dept_id join job using (job_code)
        order by age
    )
    where rownum = 1
;
select emp_id, emp_name, age, dept_title, job_name
    from
    (
    select emp_id, emp_name, dept_title, job_name,
    (extract(year from sysdate) - (substr(emp_no, 1, 2) + 1900) + 1) age
        from employee
        join department on dept_code = dept_id join job using (job_code)
    )
    where age = (select min(extract(year from sysdate) - (substr(emp_no, 1, 2) + 1900) + 1) from employee)
;
-- 3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
select emp_id, emp_name, job_name
     from employee join job using (job_code)
     where emp_name like '%형%'
;
-- 4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
select emp_name, job_name, dept_code, dept_title
    from employee join job using (job_code) join department on dept_code = dept_id
    where dept_code in ('D5', 'D6')
;
-- 5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
select emp_name, bonus, dept_title, local_name
    from employee join department on dept_code = dept_id join location on location_id = local_code
    where bonus is not null
;
-- 6. 사원 명, 직급 명, 부서 명, 지역 명 조회
select emp_name, job_name, dept_title, local_name
    from employee join job using (job_code) join department on dept_code = dept_id
    join location on location_id = local_code
    order by job_code
;

-- 7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
select emp_name, dept_title, local_name, national_name
    from employee join department on dept_code = dept_id join location on location_id = local_code
    join national using (national_code)
    where national_name = '한국' or national_name = '일본'
;

-- 8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
select e1.emp_name, e1.dept_code, e2.emp_name
    from employee e1, employee e2
    where e1.dept_code = e2.dept_code and e1.emp_name != e2.emp_name
    order by e1.emp_name
;

-- 9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
select emp_name, job_name, nvl(salary, 0)
    from employee join job using (job_code)
    where bonus is null and job_code in ('J4', 'J7')
;

-- 10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
select emp_id, emp_name, dept_title, job_name, hire_date, rownum
    from
    (select * from employee join department on dept_code = dept_id join job using (job_code)
    order by salary * 12 + nvl(bonus, 0) desc)
    where rownum <= 5
;

-- 11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
    -- 11-1. JOIN과 HAVING 사용
    select dept_title, sum(salary)
         from employee join department on dept_code = dept_id
         group by dept_title
         having sum(salary) > (select sum(salary) * 0.2 from employee)
    ;
    -- 11-2. 인라인 뷰 사용
    select dept_title, sum_salary
         from (select dept_title, sum(salary) sum_salary from employee join department on dept_code = dept_id group by dept_title)
         where sum_salary > (select sum(salary) * 0.2 from employee)
    ;
    -- 11-3. WITH 사용
    
-- 12. 부서 명과 부서 별 급여 합계 조회
select dept_title, sum(salary)
    from employee join department on dept_code = dept_id
    group by dept_title
;
-- 13. WITH를 이용하여 급여 합과 급여 평균 조회