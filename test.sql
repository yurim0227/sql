DROP TABLE MEMBER;
CREATE TABLE MEMBER(

MEMBER_ID VARCHAR2(30) PRIMARY KEY,

MEMBER_PWD VARCHAR2(100) NOT NULL,

MEMBER_NM VARCHAR2(15) NOT NULL,

MEMBER_ENROLL_DT DATE DEFAULT SYSDATE

);
INSERT INTO MEMBER VALUES('user01', 'pass01', '홍길동', DEFAULT);
COMMIT;

desc member;
select * from member;
select * from member where member_id = 'user01' and member_pwd = 'pass01';
insert into member values ('user02', 'pass02', '성이름', '23/09/25');
insert into member (member_id, member_pwd, member_nm) values ('user03', 'pass03', '성이름');
update member set member_id = 'user01' where member_id = 'user04';