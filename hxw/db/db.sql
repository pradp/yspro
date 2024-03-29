
CREATE TABLE T_HD_BM (
  WID varchar2(50) NOT NULL,
  HDWID varchar2(50) DEFAULT NULL,
  BMR varchar2(50) DEFAULT NULL,
  BMRIP varchar2(30) DEFAULT NULL,
  BMSJ date DEFAULT NULL,
  STATE varchar2(2) DEFAULT NULL,
  HDGS clob,
  FXJB varchar(3) DEFAULT NULL,
  CONSTRAINT "PK_T_HD_BM" PRIMARY KEY ("WID")
  USING INDEX
) ;


CREATE TABLE T_HD_GSFX (
  WID varchar2(50) NOT NULL,
  BMWID varchar2(50) DEFAULT NULL,
  FXDX varchar2(50) DEFAULT NULL,
  
  CONSTRAINT "PK_T_HD_GSFX" PRIMARY KEY ("WID")
  USING INDEX
) ;


CREATE TABLE T_HD_NR (
  WID varchar2(50) NOT NULL,
  HDLX varchar2(50) DEFAULT NULL,
  BT varchar2(150) DEFAULT NULL,
  SYYDT varchar2(150) DEFAULT NULL,
  ZZZ varchar2(50) DEFAULT NULL,
  NR clob,
  HDDD varchar2(900) DEFAULT NULL,
  HDSJ varchar2(600) DEFAULT NULL,
  JG number(10,2) DEFAULT NULL,
  ZDRS number(6) DEFAULT NULL,
  ZBFZZ varchar2(900),
  CJR varchar2(50) DEFAULT NULL,
  CJRQ date DEFAULT NULL,
  ZHXGRQ date DEFAULT NULL,
  DJS number(8) DEFAULT NULL,
  STATE varchar2(2) DEFAULT NULL,
  SHRQ date DEFAULT NULL,
  SHYJ varchar2(900),
  CONSTRAINT "PK_T_HD_NR" PRIMARY KEY ("WID")
  USING INDEX
) ;
