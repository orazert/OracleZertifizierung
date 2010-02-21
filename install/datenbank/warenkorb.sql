-- oracle login with system

-- Start of DDL Script for User WK
-- Generated 16-Feb-2010 22:21:47 from SYS@ORCL

drop DIRECTORY rwfiles
/
drop user wk cascade
/

CREATE USER wk
IDENTIFIED BY wk
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
/
GRANT CREATE VIEW TO wk
/
GRANT UNLIMITED TABLESPACE TO wk
/
GRANT CONNECT TO wk
/
GRANT RESOURCE TO wk
/
ALTER USER wk DEFAULT ROLE ALL
/



-- End of DDL Script for User WK

CREATE DIRECTORY rwfiles AS 'd:\xampp\htdocs\OracleZertifizierung\install\datenbank';
GRANT read, write ON DIRECTORY rwfiles TO PUBLIC;

connect wk/wk

 -------sequence for cc1_2/cc2_id/cc3_id/wc_id
 create sequence  WK_SEQ  minvalue 1 maxvalue 999999999999999999999999999 
 increment by 1 start with 1000 cache 20 noorder  nocycle ;
 
 -------sequence for user_warenkorb_id
  create sequence  WK_WP_SEQ  minvalue 1 maxvalue 999999999999999999999999999 
 increment by 1 start with 80000000 cache 20 noorder  nocycle ;
 
  -------sequence for user_id
  create sequence  WK_USER_SEQ  minvalue 1 maxvalue 999999999999999999999999999 
 increment by 1 start with 600000 cache 20 noorder  nocycle ;

-------hauptgruppen CC1
create table ext_hauptgruppen
 (
     cc1 number,
     bezeichnung varchar2(100)
) 
organization  external
   (
         type oracle_loader
         default directory system.rwfiles
         access parameters 
         (
               records delimited by newline
               badfile 'ext_hauptgruppen.bad'
               logfile 'ext_hauptgruppen.log'
               fields terminated by ';'
               missing field values are null
               ( 
                      cc1,
                      bezeichnung
         ))
             location ('ext_hauptgruppen.csv')
) reject limit unlimited;


CREATE TABLE wk_cc1
    (cc1_id                         NUMBER NOT NULL,
    cc1                            NUMBER,
    cc1_bezeichnung                VARCHAR2(100),
    cc1_vpi                        NUMBER,
    cc1_hvpi                       NUMBER
  ,
  CONSTRAINT WK_CC1_PK
  PRIMARY KEY (cc1_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/





-- Triggers for WK_CC1

CREATE OR REPLACE TRIGGER wk_cc1_insert_trg
 BEFORE
  INSERT
 ON wk_cc1
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
begin
  :new.cc1_id := wk_seq.nextval;
end;
/

insert into wk_cc1 (cc1, cc1_bezeichnung)
select cc1, bezeichnung from ext_hauptgruppen;

-------untergruppen_1  CC2

create table ext_untergruppen_1
(
     cc1 number,
     cc2 number,
     bezeichnung varchar2(100)
) 
organization  external
   (
         type oracle_loader
         default directory system.rwfiles
         access parameters 
         (
               records delimited by newline
               badfile 'ext_untergruppen_1.bad'
               logfile 'ext_untergruppen_1.log'
               fields terminated by ';'
               missing field values are null
               ( 
                      cc1,
                      cc2,
                      bezeichnung
         ))
             location ('ext_untergruppen_1.csv')
) reject limit unlimited;


CREATE TABLE wk_cc2
    (cc2_id                         NUMBER NOT NULL,
    cc1_id                         NUMBER,
    cc2                            NUMBER,
    cc2_bezeichnung                VARCHAR2(100),
    cc2_vpi                        NUMBER,
    cc2_hvpi                       NUMBER
  ,
  CONSTRAINT WK_CC2_PK
  PRIMARY KEY (cc2_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/





-- Constraints for WK_CC2



-- Triggers for WK_CC2

CREATE OR REPLACE TRIGGER wk_cc2_insert_trg
 BEFORE
  INSERT
 ON wk_cc2
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
begin
  :new.cc2_id := wk_seq.nextval;
  
end;
/

-- End of DDL Script for Table HR.WK_CC2

-- Foreign Key
ALTER TABLE wk_cc2
ADD CONSTRAINT wk_cc2_fk FOREIGN KEY (cc1_id)
REFERENCES wk_cc1 (cc1_id)
/

insert into  wk_cc2 (cc1_id, cc2, cc2_bezeichnung)
select (select cc1_id from wk_cc1 where ext.cc1=wk_cc1.cc1), cc2,  bezeichnung from ext_untergruppen_1 ext;
 

-------untergruppen_2  CC3
create table ext_untergruppen_2
(
     cc1 number,
     cc2 number,
     cc3 number,
     bezeichnung varchar2(100)
) 
organization  external
   (
         type oracle_loader
         default directory system.rwfiles
         access parameters 
         (
               records delimited by newline
               badfile 'ext_untergruppen_2.bad'
               logfile 'ext_untergruppen_2.log'
               fields terminated by ';'
               missing field values are null
               ( 
                      cc1,
                      cc2,
                      cc3,
                      bezeichnung
         ))
             location ('ext_untergruppen_2.csv')
) reject limit unlimited;



CREATE TABLE wk_cc3
    (cc3_id                         NUMBER NOT NULL,
    cc2_id                         NUMBER,
    cc3                            NUMBER,
    cc3_bezeichnung                VARCHAR2(100),
    cc3_anteil                     NUMBER,
    cc3_vpi                        NUMBER,
    cc3_hvpi                       NUMBER
  ,
  CONSTRAINT WK_CC3_PK
  PRIMARY KEY (cc3_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/





-- Constraints for WK_CC3



-- Triggers for WK_CC3

CREATE OR REPLACE TRIGGER wk_cc3_insert_trg
 BEFORE
  INSERT
 ON wk_cc3
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
begin
  :new.cc3_id := wk_seq.nextval;
end;
/


-- End of DDL Script for Table HR.WK_CC3

-- Foreign Key
ALTER TABLE wk_cc3
ADD CONSTRAINT wk_cc3_fk FOREIGN KEY (cc2_id)
REFERENCES wk_cc2 (cc2_id)
/

insert into  wk_cc3 (cc2_id, cc3, cc3_bezeichnung)
select (select w2.cc2_id from wk_cc2 w2, wk_cc1 w1
where w2.cc1_id = w1.cc1_id and w1.cc1=ext.cc1 and w2.cc2=ext.cc2), cc3, bezeichnung from ext_untergruppen_2 ext;

-------Warencode
create table ext_waren
 (
     cc1 number,
     cc2 number,
     cc3 number,
     warencode number,
     bezeichnung varchar2(100),
     index1 number,
     prozent number,
     index2 number
) 
organization  external
   (
         type oracle_loader
         default directory system.rwfiles
         access parameters 
         (
               records delimited by newline
               badfile 'ext_waren.bad'
               logfile 'ext_waren.log'
               fields terminated by ';'
               missing field values are null
               ( 
                      cc1,
                      cc2,
                      cc3,
                      warencode,
                      bezeichnung,
                      index1,
                      prozent,
                      index2
         ))
             location ('ext_waren.csv')
)reject  limit unlimited;


CREATE TABLE wk_warencode
    (wc_id                          NUMBER NOT NULL,
    cc3_id                         NUMBER,
    warencode                      NUMBER,
    wc_bezeichnung                 VARCHAR2(100),
    wc_vpi                         NUMBER,
    wc_anteil                      NUMBER,
    wc_hvpi                        NUMBER
  ,
  CONSTRAINT WK_WARENCODE_PK
  PRIMARY KEY (wc_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/





-- Constraints for WK_WARENCODE



-- Triggers for WK_WARENCODE

CREATE OR REPLACE TRIGGER wk_warencode_insert_trg
 BEFORE
  INSERT
 ON wk_warencode
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
begin
  :new.wc_id := wk_seq.nextval;
end;
/


-- End of DDL Script for Table HR.WK_WARENCODE

-- Foreign Key
ALTER TABLE wk_warencode
ADD CONSTRAINT wk_warencode_fk FOREIGN KEY (cc3_id)
REFERENCES wk_cc3 (cc3_id)
/

insert into wk_warencode 
   (cc3_id, warencode, wc_bezeichnung, wc_vpi, wc_anteil, wc_hvpi)
   select (select w3.cc3_id
						from wk_cc3 w3, wk_cc2 w2, wk_cc1 w1
						where w3.cc2_id=w2.cc2_id and w2.cc1_id = w1.cc1_id
						and w1.cc1=ext.cc1 and w2.cc2=ext.cc2 and w3.cc3=ext.cc3), 
	 warencode, bezeichnung, index1, prozent, index2 from ext_waren ext;
  
--commit;

-- Start of DDL Script for Procedure HR.UPD_WK_CC1
-- Generated 7-Feb-2010 19:41:14 from HR@ORCL

-- Start of DDL Script for Procedure HR.UPD_WK_CC3
-- Generated 7-Feb-2010 19:42:03 from HR@ORCL

--einmalige Verwendung for updating sum(vpi)  wc->cc3
CREATE OR REPLACE 
PROCEDURE upd_wk_cc3
 IS
  cursor c_cc3 is
        select cc3_id from wk_cc3;
  v_anteil_sum number;
  v_vpi_sum number;
  v_hvpi_sum number;
BEGIN 
    for rs in c_cc3 loop
        select sum(wc_anteil), sum(wc_vpi), sum(wc_hvpi) 
        into v_anteil_sum, v_vpi_sum, v_hvpi_sum from wk_warencode
        where cc3_id=rs.cc3_id;

        --dbms_output.put_line(rs.cc3_id);
        update wk_cc3
        set cc3_anteil=v_anteil_sum, cc3_vpi=v_vpi_sum, cc3_hvpi=v_hvpi_sum
        where cc3_id=rs.cc3_id;
    end loop;
END;
/

-- Start of DDL Script for Procedure HR.UPD_WK_CC2
-- Generated 7-Feb-2010 19:41:50 from HR@ORCL
--einmalige Verwendung for updating sum(vpi)  cc3->cc2

CREATE OR REPLACE 
PROCEDURE upd_wk_cc2
 IS
  cursor c is
        select cc2_id from wk_cc2;
  v_vpi_sum number;
  v_hvpi_sum number;
BEGIN 
    for rs in c loop       
        select sum(cc3_vpi), sum(cc3_hvpi) 
        into v_vpi_sum, v_hvpi_sum from wk_cc3
        where cc2_id=rs.cc2_id;

        update wk_cc2
        set cc2_vpi=v_vpi_sum, cc2_hvpi=v_hvpi_sum
        where cc2_id=rs.cc2_id;
    end loop;
END;
/

--einmalige Verwendung for updating sum(vpi)  cc2->cc1 
CREATE OR REPLACE 
PROCEDURE upd_wk_cc1
 IS
  cursor c is
        select cc1_id from wk_cc1;
  v_vpi_sum number;
  v_hvpi_sum number;
BEGIN 
    for rs in c loop       
        select sum(cc2_vpi), sum(cc2_hvpi) 
        into v_vpi_sum, v_hvpi_sum from wk_cc2
        where cc1_id=rs.cc1_id;
dbms_output.put_line(rs.cc1_id);
        update wk_cc1
        set cc1_vpi=v_vpi_sum, cc1_hvpi=v_hvpi_sum
        where cc1_id=rs.cc1_id;
    end loop;
END;
/

--execute bottom up

exec UPD_WK_CC3;
/
exec UPD_WK_CC2;
/
exec UPD_WK_CC1;
/

--drop external tables after import
drop table ext_hauptgruppen;
drop table ext_untergruppen_1;
drop table ext_untergruppen_2;
drop table ext_waren;
commit;

--User
-- Start of DDL Script for Table HR.WK_USER
-- Generated 16-Feb-2010 21:36:31 from HR@ORCL

CREATE TABLE wk_user
    (user_id                        NUMBER NOT NULL,
    user_name                      VARCHAR2(20),
    user_pwd                       VARCHAR2(20)
  ,
  CONSTRAINT WK_USER_PK
  PRIMARY KEY (user_id)
  USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  ))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/





-- Constraints for WK_USER

ALTER TABLE wk_user
ADD CONSTRAINT wk_user_uk UNIQUE (user_name)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- Triggers for WK_USER

CREATE OR REPLACE TRIGGER wk_user_insert_trg
 BEFORE
  INSERT
 ON wk_user
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
begin
  :new.user_id := wk_user_seq.nextval;
end;
/


-- End of DDL Script for Table HR.WK_USER

INSERT INTO wk_user (user_name, user_pwd)
VALUES
('Statistik2006','123')
/
INSERT INTO wk_user (user_name, user_pwd)
VALUES
('Honglei','123')
/
INSERT INTO wk_user (user_name, user_pwd)
VALUES
('Ludwig','123')
/
INSERT INTO wk_user (user_name, user_pwd)
VALUES
('Mario','123')
/
INSERT INTO wk_user (user_name, user_pwd)
VALUES
('Pummel','123')
/
INSERT INTO wk_user (user_name, user_pwd)
VALUES
('Mark','123')
/

-- Start of DDL Script for Table HR.WK_PERSONAL
-- Generated 7-Feb-2010 21:09:55 from HR@ORCL

-- Userspezifischer Warenkorb
CREATE TABLE wk_personal
    (wp_id                          NUMBER NOT NULL,
    user_id                        NUMBER,
    wk_id                          NUMBER,
    ist_vpi                       NUMBER
  ,
  CONSTRAINT WK_PERSONAL_PK
  PRIMARY KEY (wp_id)
  USING INDEX)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/


-- Constraints for WK_PERSONAL


ALTER TABLE wk_personal
ADD CONSTRAINT wk_personal_uk UNIQUE (user_id, wk_id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Table HR.WK_PERSONAL

-- Foreign Key
ALTER TABLE wk_personal
ADD CONSTRAINT wk_personal_fk FOREIGN KEY (user_id)
REFERENCES wk_user (user_id)
/
-- End of DDL script for Foreign Key(s)

-- Triggers for WK_PERSONAL

CREATE OR REPLACE TRIGGER wk_personal_insert_trg
 BEFORE
  INSERT
 ON wk_personal
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
begin
  :new.wp_id := wk_wp_seq.nextval;
end;
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Honglei'), (select cc1_id from wk_cc1 where cc1=6), 22.2)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Ludwig'), (select cc1_id from wk_cc1 where cc1=1), 15.5)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Ludwig'), (select cc1_id from wk_cc1 where cc1=5), 33.3)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Ludwig'), 
(select w2.cc2_id from wk_cc1 w1, wk_cc2 w2 where w2.cc1_id=w1.cc1_id and w1.cc1=8 and w2.cc2=1), 13.8)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Mario'), (select cc1_id from wk_cc1 where cc1=10), 44.4)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Ludwig'), 
(select w2.cc2_id from wk_cc1 w1, wk_cc2 w2 where w2.cc1_id=w1.cc1_id and w1.cc1=10 and w2.cc2=5), 4.9)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Ludwig'), 
(select w3.cc3_id from wk_cc1 w1, wk_cc2 w2, wk_cc3 w3 
where w3.cc2_id=w2.cc2_id and w2.cc1_id=w1.cc1_id 
and w1.cc1=12 and w2.cc2=3 and w3.cc3=1), 16.3)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Ludwig'), 
(select w2.cc2_id from wk_cc1 w1, wk_cc2 w2 
where w2.cc1_id=w1.cc1_id and w1.cc1=8 and w2.cc2=2), 2.8)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Honglei'), 
(select wc.wc_id from wk_cc1 w1, wk_cc2 w2, wk_cc3 w3, wk_warencode wc 
where wc.cc3_id=w3.cc3_id and w3.cc2_id=w2.cc2_id and w2.cc1_id=w1.cc1_id 
and w1.cc1=1 and w2.cc2=1 and w3.cc3=4 and warencode=48), 2.1)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Honglei'), 
(select wc.wc_id from wk_cc1 w1, wk_cc2 w2, wk_cc3 w3, wk_warencode wc 
where wc.cc3_id=w3.cc3_id and w3.cc2_id=w2.cc2_id and w2.cc1_id=w1.cc1_id 
and w1.cc1=1 and w2.cc2=1 and w3.cc3=4 and warencode=49), 2.5)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Honglei'), 
(select wc.wc_id from wk_cc1 w1, wk_cc2 w2, wk_cc3 w3, wk_warencode wc 
where wc.cc3_id=w3.cc3_id and w3.cc2_id=w2.cc2_id and w2.cc1_id=w1.cc1_id  
and w1.cc1=1 and w2.cc2=1 and w3.cc3=4 and warencode=50), 3.2)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Mark'), 
(select wc.wc_id from wk_cc1 w1, wk_cc2 w2, wk_cc3 w3, wk_warencode wc 
where wc.cc3_id=w3.cc3_id and w3.cc2_id=w2.cc2_id and w2.cc1_id=w1.cc1_id  
and w1.cc1=1 and w2.cc2=1 and w3.cc3=4 and warencode=60), 3.7)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Mario'), 
(select wc.wc_id from wk_cc1 w1, wk_cc2 w2, wk_cc3 w3, wk_warencode wc 
where wc.cc3_id=w3.cc3_id and w3.cc2_id=w2.cc2_id and w2.cc1_id=w1.cc1_id  
and w1.cc1=4 and w2.cc2=3 and w3.cc3=2 and warencode=723), 2.6)
/

insert into WK_PERSONAL (user_id, wk_id, ist_vpi)
VALUES ((select user_id from wk_user where user_name='Honglei'), 
(select w3.cc3_id from wk_cc1 w1, wk_cc2 w2, wk_cc3 w3 
where w3.cc2_id=w2.cc2_id and w2.cc1_id=w1.cc1_id 
and w1.cc1=1 and w2.cc2=1 and w3.cc3=6), 4.9)
/

commit;

select count(*) from wk_warencode;

/*   
select w1.cc1_id, w2.cc2_id, w3.cc3_id, wc.wc_id, w1.cc1, w1.cc1_bezeichnung, 
w2.cc2, w2.cc2_bezeichnung,
w3.cc3, w3.cc3_bezeichnung,
wc.warencode, wc.wc_bezeichnung
from wk_warencode wc, wk_cc3 w3, wk_cc2 w2, wk_cc1 w1
where wc.cc3_id=w3.cc3_id and w3.cc2_id=w2.cc2_id and w2.cc1_id = w1.cc1_id;
*/