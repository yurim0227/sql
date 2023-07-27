--DROP TABLE "BOARD_READ_RECORD";
--DROP TABLE "BOARD";
--DROP TABLE "MEMBER";

--desc member;
insert into MEMBER values ('kh1', '11','kh1name','kh1@a.co.kr')
;
insert into MEMBER values ('admin', 'admin','adminname','admin@a.co.kr')
;
insert into MEMBER values ('biz1', '11','biz1name','biz1@a.co.kr')
;
--desc board;

--원본글
insert into BOARD values (SEQ_BOARD_BNO.nextval, 'title1', 'cotent1', default, 'kh1', SEQ_BOARD_BNO.nextval, 0,0);
insert into BOARD values (SEQ_BOARD_BNO.nextval, 'title2', 'cotent2', default, 'kh1', SEQ_BOARD_BNO.nextval, 0,0);
insert into BOARD values (SEQ_BOARD_BNO.nextval, 'title3', 'cotent3', default, 'kh1', SEQ_BOARD_BNO.nextval, 0,0);
insert into BOARD values (SEQ_BOARD_BNO.nextval, 'title4', 'cotent4', default, 'kh1', SEQ_BOARD_BNO.nextval, 0,0);
-- 원1 - 답글
insert into BOARD values (SEQ_BOARD_BNO.nextval, '1-답', '1-답', default, 'kh1', 1, 1, 1);
-- 원1- 5답-답답글
insert into BOARD values (SEQ_BOARD_BNO.nextval, '5-답', '5-답', default, 'kh1', 1, 2, 2);
-- 원1 - 답글
update board set BRE_STEP = BRE_STEP + 1 where BRE_STEP > 0;
insert into BOARD values (SEQ_BOARD_BNO.nextval, '1-답', '1-답', default, 'kh1', 1, 1, 1);
-- 원 1 - 7-답답글

select * from board order by bref desc, bre_step asc;
commit;