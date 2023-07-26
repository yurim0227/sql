DROP TABLE "PERSON";
DROP TABLE "BUSINESS";
DROP TABLE "MEMBER";

CREATE TABLE "MEMBER" (
	"M_ID"	VARCHAR2(10)		NOT NULL,
	"M_PW"	VARCHAR2(20)		NOT NULL,
	"M_TYPE"	NUMBER(1)		NOT NULL
);

COMMENT ON COLUMN "MEMBER"."M_PW" IS '소문자,대문자,특수문자 포함 8~16자';

COMMENT ON COLUMN "MEMBER"."M_TYPE" IS '1 or 2';


CREATE TABLE "PERSON" (
	"M_ID"	VARCHAR2(10)		NOT NULL,
	"P_NAME"	VARCHAR2(50)		NOT NULL,
	"P_EMAIL"	VARCHAR2(30)		NOT NULL UNIQUE,
	"P_PHONE"	VARCHAR2(20)		NOT NULL UNIQUE
);

COMMENT ON COLUMN "PERSON"."P_EMAIL" IS 'id@domain';

COMMENT ON COLUMN "PERSON"."P_PHONE" IS '000-0000-0000';


CREATE TABLE "BUSINESS" (
	"M_ID"	VARCHAR2(10)		NOT NULL,
	"B_FORM"	VARCHAR2(30)		NOT NULL,
	"B_RNO"	VARCHAR2(20)		NOT NULL,
	"B_BNAME"	VARCHAR2(20)		NOT NULL,
	"B_ADDRESS"	VARCHAR2(100)		NOT NULL,
	"B_NAME"	VARCHAR2(10)		NOT NULL,
	"B_TEL"	VARCHAR2(20)		NOT NULL UNIQUE,
	"B_EMAIL"	VARCHAR2(30)		NOT NULL UNIQUE
);

COMMENT ON COLUMN "BUSINESS"."M_ID" IS 'ID';

COMMENT ON COLUMN "BUSINESS"."B_RNO" IS '000-00-00000';

COMMENT ON COLUMN "BUSINESS"."B_TEL" IS '000-0000-0000';

COMMENT ON COLUMN "BUSINESS"."B_EMAIL" IS 'id@domain';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"M_ID"
);

ALTER TABLE "PERSON" ADD CONSTRAINT "PK_PERSON" PRIMARY KEY (
	"M_ID"
);

ALTER TABLE "BUSINESS" ADD CONSTRAINT "PK_BUSINESS" PRIMARY KEY (
	"M_ID"
);

ALTER TABLE "PERSON" ADD CONSTRAINT "FK_MEMBER_TO_PERSON_1" FOREIGN KEY (
	"M_ID"
)
REFERENCES "MEMBER" (
	"M_ID"
);

ALTER TABLE "BUSINESS" ADD CONSTRAINT "FK_MEMBER_TO_BUSINESS_1" FOREIGN KEY (
	"M_ID"
)
REFERENCES "MEMBER" (
	"M_ID"
);