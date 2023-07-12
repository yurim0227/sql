--as 별칭이나 또는 as 별칭을 기술하여 컬럼 별칭을 지을 수 있음
-- where if문
--참초할 테이블 없으면 dual
select emp_name as이름, salary*12"연봉(원)",
(salary + (salary*bonus))*12 as"총 소득(원)"
from employee;

-- 부서코드가 'D9'인 직원의 이름, 부서코드 조회
select emp_name, dept_code
from employee
where dept_code= 'D9';

-- 급여가 4000000보다 많은 직원 이름과 급여조회
select emp_name, salary
from employee
where salary > 4000000;

--부서코드가 'D6'이고 급여를 2000000보다 많이 받는 직원의
--이름, 부서코드, 급여 조회

select emp_name,dept_code,salary
from employee
where dept_code = 'D6' and salary > 2000000;

--부서코드가 D6이거나 급여를 2000000보다 많이 받는직원의
-- 이름, 부서코드, 급여조회
select emp_name,dept_code,salary
from employee
where dept_code = 'D6' OR SALARY > 2000000;

--컬럼과 컬럼을 연결한 경우
select emp_id || emp_name || salary
from employee;

--컬럼과 리터럴을 연결한 경우
select emp_name||'의 월급은' || salary||'원 입니다.'
from employee;

--급여를 3500000보다 많이 받고 6000000보다 적게 받는 직원 이름과
--급여 조회
select emp_name, salary
from employee
where salary >=3500000 and salary <= 6000000;

--'전'씨 성을 가진 직원 이름과 급여 조회
select emp_name, salary
from employee
where emp_name like '전%';

--핸드폰의 앞 네자리 중 첫번호가 7인 직원 이름과 전화번호 조회
select emp_name, phone
from employee
where phone like'___7%';

--email id중 '_'의 앞이 3자리인 직원이름, 이메일 조회
select emp_name, email
from employee
where email like'___#_%'ESCAPE'#';

--'이'씨 성이 아닌 직원 사번,이름 이메일조회
SELECT emp_id,emp_name,email
from employee
where not emp_name like '이%';

--관리자도 없고 부서 배치도 받지 않은 직원조회
select emp_name,manager_id,dept_code
from employee
where manager_id is null and dept_code is null;

--부서 배치를 받지 않았지만 보너스를 지급받는 직원조회
select emp_name,bonus,dept_code
from employee
where dept_code is null and bonus is not null;

--D6 부서와 D8 부서원들의 이름,부서코드 급여조회
select emp_name, dept_code, salary
from employee
where dept_code in ('D6','D8');

--또는
select emp_name, dept_code, salary
from employee
where dept_code= 'D6' OR dept_code='D8';

--'J2' 또는 'J7' 직급 코드 중 급여를 2000000보다 많이 받는 직원의 
--이름 급여 직급코드 조회
SELECT EMP_NAME,SALARY, JOB_CODE
FROM employee
WHERE job_code ='J7' OR job_code='J2'
AND salary > 2000000;

--함수 시작
--email 컬럼의 문자열 중 '@'의 위치를 구하시오
select email, instr(email,'@',-1,1)
from employee;

--LPAD / RPAD 
--주어진 컬럼,문자열에 임의의 문자열을 왼쪽/오른쪽에 덧붙여 길이
--N의 문자열 반환

SELECT LPAD(EMAIL, 20, '#')
FROM employee;

SELECT RPAD(EMAIL, 20,'#')
FROM employee;

--LTRLM / RTRIM
--주어진 컬럼 문자열의 왼쪽/오른쪽에서 지정한 STR에 포함된
--모든 문자를 제거한 나머지 반환
SELECT EMP_NAME,LTRIM(PHONE,'010'),RTRIM(EMAIL,'@KH.or.kr')
from employee;

--TRIM
--주어진 컬럼,문자열의 앞/뒤/양쪽에 있는 지정한 문자를 제거한 나머지반환
SELECT trim(' kh ')from dual;
SELECT trim('Z' FROM 'ZZZKHZZZ')FROM DUAL;

--SUBSTR
--컬럼이나 문자열에서 지정한 위치부터 지정한 개수의 문자열을 잘라내어 반환
-- SUBSTR(STRIG,POSTION,[LENGTH])
select substr('SHOWMETHEMONEY',5,2)from dual;

--LOWER/ UPPER / INITCAP
--컬럼의 문자 혹은 문자열을 소문자/대문자/ 첫 글자만 대문자로 변환하여 반환

SELECT LOWER('Welcome To My World') FROM DUAL;
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('Welcome To My World') FROM DUAL;

--ABS 
--인자로 전달 받은 숫자의 절대값 반환
--ABS(NUMBER)

select abs(10,9)from daul;

--sysdate
--시스템에 저장되어 있는 현재 날짜 반환

select sysdate from dual;

--Months_between
--인자로 날짜 두개를 전달받아 개월수 차이를 숫자 데이터형으로 반환

--employee 테이블에서 사원의 이름, 입사일, 근무 개월수 조회
select emp_name, hire_date, months_between(sysdate,hire_date)
from employee;

--ADD_MONTHS
--인자로 전달받은 날짜에 인자로 받은 숫자만큼 개월 수를 더하여 특정날짜반환

--employy테이블에서 사원의 이름,입사일, 입사 후 6개월이 된 날짜 조회
SELECT emp_name,hire_date,add_months(hire_date,6)
from employee;

--next_day
--인자로 전달받은 날짜에 인자로 받은 요일이 가장 가까운 날짜 반환
SELECT sysdate,next_day(sysdate,'월요일')
from employee;
SELECT sysdate,next_day(sysdate,2)
from employee;
SELECT sysdate,next_day(sysdate,'월')
from employee;

--날짜 처리 함수
--last_day
--인자로 전달받은 날짜가 속한 달의 마지막 날짜반환

--사원의 이름, 입사일, 입사한 달의 마지막 날 조회
select emp_name,hire_date,last_day(hire_date)
from employee;

--extract
--년,월,일 정보 추출하여 반환

--employee테이블에서 사원의이름, 입사년, 입사 월, 입사 일 조회
select emp_name,extract(year from hire_date)year,
extract(month from hire_date)month,extract(day from hire_date)day
from employee;

--to_char
--날짜 혹은 숫자형 데이터를 문자형 데이터로 변환하여 반환
--date 문자형으로 변환하려는 날짜형 데이터
--number 문자형으로 변환하려는 숫자형 데이터
--format 문자형으로 변환시 지정할 출력 형식

--to_char 예시
select emp_name,
    to_char(hire_date,'yyyy-mm-dd'),
    to_char(hire_date,'yy-mon-day.dy')
from employee;

select emp_name,
    to_char(salary,'L999,999,999'),
    to_char(salary,'000,000,000')
from employee;

--to_date
--숫자 혹은 문자형 데이터를 날짜형 데이터로 변환하여 반환

--employee테이블에서 2000년도 이후에 입사한 사원의 사번,이름,입사일조회
select emp_no,emp_name,hire_date
from employee
where hire_date > to_date(20000101,'yyyymmdd');

--decode
--비교하자고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
-- decode(표현식,조건1,결과2,조건2,결과2,...,default)

select emp_id,emp_name,emp_no
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS 성별
from employee; --오류

--case
--비교하고자 하는 값 또는 칼럼이 조건식과 같으면 결과 값 반환

select emp_id,emp_name,emp_no,
    case when substr(emp_no,8,1)=1 then '남'
    else '여'
    end as 성별
    from employee;
    
select emp_name,salary,
    case when salary > 5000000 then '1등급'
         when salary > 3500000 then '2등급'
        when salary > 2000000 then '3등급'
    else '4등급'
    end 등급
from employee;

--sum
--해당 컬럼 값들의 총합 반환

--employee테이블에서 남자 사원의 급여 총합 조회
select sum(salary)
from EMPLOYEE
where substr(emp_no,8,1)=1;