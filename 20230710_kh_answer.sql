-- 급여를 3500000보다 많이 받고 6000000보다 적게 받는 직원이름과 급여 조회
select EMP_NAME, SALARY
    from EMPLOYEE
--    where SALARY > 3500000 and SALARY < 6000000
    where SALARY between 3500000 and 5999999
;
-- ‘전’씨 성을 가진 직원 이름과 급여 조회
select EMP_NAME, SALARY
    from EMPLOYEE
    where EMP_NAME like '전%'
;
-- 핸드폰의 앞 네 자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
select EMP_NAME, PHONE
    from EMPLOYEE
    where PHONE like '___7%'
;
-- EMAIL ID 중 ‘_’의 앞이 3자리인 직원 이름, 이메일 조회
select EMP_NAME, EMAIL
    from EMPLOYEE
    where EMAIL like '___#_%' escape '#'
;
-- ‘이’씨 성이 아닌 직원 사번, 이름, 이메일 조회
select EMP_ID, EMP_NAME, EMAIL
    from EMPLOYEE
--    where EMP_NAME not like '이%'
    where not EMP_NAME like '이%'
;
-- 관리자도 없고 부서 배치도 받지 않은 직원 조회
select EMP_ID, MANAGER_ID, DEPT_CODE
    from EMPLOYEE
    where MANAGER_ID is null and DEPT_CODE is null
;
-- 부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
select EMP_NAME, BONUS, DEPT_CODE
    from EMPLOYEE
    where DEPT_CODE is null and BONUS is not null
;
-- D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
select EMP_NAME, DEPT_CODE, SALARY
    from EMPLOYEE
--    where DEPT_CODE in ('D6', 'D8')
    where DEPT_CODE = 'D6' or DEPT_CODE = 'D8'
;
-- ‘J2’ 또는 ‘J7’ 직급 코드 중 급여를 2000000보다 많이 받는 직원의 이름, 급여, 직급코드 조회
select EMP_NAME, SALARY, JOB_CODE
    from EMPLOYEE
--    where DEPT_CODE in ('D6', 'D8')
--    where JOB_CODE = 'J7' or JOB_CODE = 'J2' and SALARY > 2000000
    where (JOB_CODE = 'J7' or JOB_CODE = 'J2') and SALARY > 2000000
;