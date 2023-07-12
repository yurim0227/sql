--1. JOB 테이블의 모든 정보 조회
select * from job;

--2. JOB 테이블의 직급 이름 조회
select job_name from job;

--3. DEPARTMENT 테이블의 모든 정보 조회
select * from department;

--4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
select emp_name, email, phone, hire_date from employee;

--5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
select hire_date, emp_name, salary from employee;

--6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
select emp_name, salary*12 as "연봉", (salary+(salary*nvl(bonus,0)))*12 as "총수령액", ((salary+(salary*nvl(bonus,0)))-(salary*0.03))*12 as "실수령액" 
    from employee;

--7. EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
select emp_name, salary, hire_date, phone 
    from employee
        where sal_level='S1';

--8. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
select emp_name, salary*12 as "연봉", ((salary+(salary*nvl(bonus,0)))-(salary*0.03))*12 as "실수령액", hire_date
    from employee
        where ((salary+(salary*nvl(bonus,0)))-(salary*0.03))*12 >= 50000000;
        
--9. EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
select *
    from employee
        where salary >= 4000000 and job_code IN 'J2';

--10. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중
--고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
select *
    from employee
        where dept_code IN ('D9', 'D5') and hire_date < to_date(20020101, 'yyyymmdd');

--11. EMPLOYEE테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
select *
    from employee
        where hire_date > to_date(19900101, 'yyyymmdd') and hire_date < to_date(20010101, 'yyyymmdd');

--12. EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
select emp_name
    from employee
        where emp_name like '%연';

--13. EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
select emp_name, phone
    from employee
        where phone not like '010%';

--14. EMPLOYEE테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
select *
    from employee
        where email like '____#_%' ESCAPE '#' 
        and dept_code in ('D9', 'D6')
        and hire_date > to_date(19900101, 'yyyymmdd') 
        and hire_date < to_date(20001201, 'yyyymmdd') 
        and salary >= 2700000;

--15. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
select emp_name, substr(emp_no, 1, 2) as "생년", substr(emp_no, 3, 2) as "생월", substr(emp_no, 5, 2) as "생일"
    from employee;

--16. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
select emp_name, rpad(substr(emp_no,1,7),14, '*') as "주민번호"
    from employee;

--17. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--(단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
select emp_name, abs(floor(sysdate-hire_date)) as "근무일수1", abs(floor(hire_date-sysdate)) as "근무일수2"
    from employee;

--18. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
select *
    from employee
        where mod(emp_id, 2)=1;

--19. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
select *
    from employee
        where months_between(sysdate, hire_date) >= 240;

--20. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000' 형식으로 표시)
select emp_name, to_char(salary, 'L999,999,999') as "급여"
    from employee;

--21. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이(만) 조회
--(단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며
--나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
select emp_name, dept_code, substr(emp_no,1,2)||'년 '||substr(emp_no,3,2)||'월 '||substr(emp_no,5,2)||'일' as "생년월일", 2023-(1900+substr(emp_no,1,2)) as "나이"
    from employee;

--22. EMPLOYEE테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 D5면 총무부, D6면 기획부, D9면 영업부로 처리
--(단, 부서코드 오름차순으로 정렬)
select emp_id, emp_name, dept_code, dept_title
    from employee e
        join department d on e.dept_code = d.dept_id
            where dept_code in ('D5', 'D6', 'D9')
                order by dept_code;

--23. EMPLOYEE테이블에서 사번이 201번인 사원명, 주민번호 앞자리, 주민번호 뒷자리,
--주민번호 앞자리와 뒷자리의 합 조회
select emp_name, substr(emp_no, 1, 6) as "앞자리", substr(emp_no, 8, 14) as "뒷자리", substr(emp_no, 1, 6)+substr(emp_no, 8, 14) as "주민번호합계"
    from employee
        where emp_id = 201;

--24. EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 조회
select sum((salary+(salary*nvl(bonus,0)))*12) as "총수령액"
    from employee
        where dept_code in 'D5';

--25. EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
--전체 직원 수, 2001년, 2002년, 2003년, 2004년
select count(*) as "전체직원수", 
    count(case when substr(hire_date,1,2) in '01' then 1 end) as "2001년", 
    count(case when substr(hire_date,1,2) in '02' then 1 end) as "2002년", 
    count(case when substr(hire_date,1,2) in '03' then 1 end) as "2003년", 
    count(case when substr(hire_date,1,2) in '04' then 1 end) as "2004년"
        from employee e;

