drop view v_waren_person;
drop view v_cc3_person_union;
drop view v_cc2_person_union;
drop view v_cc1_person_union;

drop table wk_personal;
drop table wk_user;
drop table wk_warencode;
drop table wk_cc3;
drop table wk_cc2;
drop table wk_cc1;

drop procedure upd_wk_cc1;
drop procedure upd_wk_cc2;
drop procedure upd_wk_cc3;

drop sequence  WK_SEQ;
drop sequence  WK_WP_SEQ;
drop sequence  WK_USER_SEQ;
commit;

 -------sequence for cc1_2/cc2_id/cc3_id/wc_id
 create sequence  WK_SEQ  minvalue 1 maxvalue 999999999999999999999999999 
 increment by 1 start with 2000 cache 20 noorder  nocycle ;
 
 -------sequence for user_warenkorb_id
  create sequence  WK_WP_SEQ  minvalue 1 maxvalue 999999999999999999999999999 
 increment by 1 start with 80000000 cache 20 noorder  nocycle ;
 
   -------sequence for user_id
  create sequence  WK_USER_SEQ  minvalue 1 maxvalue 999999999999999999999999999 
 increment by 1 start with 600000 cache 20 noorder  nocycle ;

-------hauptgruppen CC1
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

--insert data
INSERT INTO wk_cc1
VALUES
(1000,1,'NAHRUNGSMITTEL UND ALKOHOLFREIE GETRÄNKE',to_number('12,2327','99D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,3586','99D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1001,2,'ALKOHOLISCHE GETRÄNKE UND TABAK',to_number('2,8632','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,0166','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1002,3,'BEKLEIDUNG UND SCHUHE',to_number('5,4634','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,6872','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1003,4,'WOHNUNG, WASSER, ENERGIE',to_number('17,9219','99D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('17,4461','99D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1004,5,'HAUSRAT UND LAUFENDE INSTANDHALTUNG DES HAUSES',to_number('8,3868','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,0317','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1005,6,'GESUNDHEITSPFLEGE',to_number('4,6364','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,3191','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1006,7,'VERKEHR',to_number('15,1252','99D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,9454','99D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1007,8,'NACHRICHTENÜBERMITTLUNG',to_number('2,6572','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,4663','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1008,9,'FREIZEIT UND KULTUR',to_number('12,4187','99D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,0703','99D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1009,10,'ERZIEHUNG UND UNTERRICHT',to_number('1,0345','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9708','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1010,11,'RESTAURANTS UND HOTELS',to_number('7,2844','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('15,0064','99D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc1
VALUES
(1011,12,'VERSCHIEDENE WAREN UND DIENSTLEISTUNGEN',to_number('9,908','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,7479','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
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

-------untergruppen_1  CC2

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

INSERT INTO wk_cc2
VALUES
(1012,1000,1,'Nahrungsmittel',to_number('10,9361','99D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,0455','99D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1013,1000,2,'Alkoholfreie Getränke',to_number('1,2966','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,3131','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1014,1001,1,'Alkoholische Getränke',to_number('1,1067','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,1587','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1015,1001,2,'Tabak',to_number('1,7565','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,8579','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1016,1002,1,'Bekleidung',to_number('4,3813','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,588','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1017,1002,2,'Schuhe. einschließlich Reparatur',to_number('1,0821','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,0992','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1018,1003,1,'Gezahlte Wohnungsmieten',to_number('3,9582','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,6801','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1019,1003,2,'Ausgaben für Eigentumswohnungen',to_number('0,4931','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,6801','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1020,1003,3,'Instandhaltung und Reparatur der Wohnung',to_number('5,1015','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,1378','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1021,1003,4,'Wasserversorgung und sonstige Dienstleistungen im Zusammenhang mit der Wohnung',to_number('3,9261','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,7633','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1022,1003,5,'Elektrizität. Gas und andere Brennstoffe',to_number('4,443','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,1848','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1023,1004,1,'Einrichtungsgegenstände und Bodenbeläge',to_number('3,8617','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,7282','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1024,1004,2,'Heimtextilien',to_number('0,7799','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7378','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1025,1004,3,'Haushaltsgeräte',to_number('1,5627','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,4879','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1026,1004,4,'Glaswaren. Geschirr und andere Gebrauchsgüter für die Haushaltsführung',to_number('0,3901','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3775','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1027,1004,5,'Werkzeuge und Geräte für Haus und Garten',to_number('0,4693','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4682','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1028,1004,6,'Waren und Dienstleistungen für die laufende Haushaltsführung',to_number('1,3231','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,2321','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1029,1005,1,'Medizinische Erzeugnisse',to_number('1,5685','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,5332','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1030,1005,2,'Ambulante Dienstleistungen',to_number('1,7308','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,8064','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1031,1005,3,'Krankenhausdienstleistungen',to_number('1,3371','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,9795','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1032,1006,1,'Kauf von Fahrzeugen',to_number('5,0377','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,6769','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1033,1006,2,'Betrieb von privaten Verkehrsmitteln',to_number('7,9776','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,0836','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1034,1006,3,'Verkehrsdienstleistungen',to_number('2,1099','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,1849','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1035,1007,1,'Postdienste',to_number('0,1787','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,176','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1036,1007,2,'Telefonapparate und Telefaxgeräte',to_number('0,0935','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0773','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1037,1007,3,'Telefon- und Telefaxdienste',to_number('2,385','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,213','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1038,1008,1,'Geräte für Audiovision. Fotografie und Datenverarbeitung',to_number('1,7461','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,6719','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1039,1008,2,'Sonstige wesentliche Gebrauchsgüter für Freizeit und Kultur',to_number('0,2324','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1040,1008,3,'Sonstige Freizeitartikel und -geräte. Gartenartikel und Heimtiere',to_number('2,5458','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,5587','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1041,1008,4,'Freizeit- und Kulturdienstleistungen',to_number('3,329','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,4446','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1042,1008,5,'Zeitungen. Bücher und Schreibwaren',to_number('1,4396','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,4334','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1043,1008,6,'Pauschalreisen',to_number('3,1258','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,7217','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1044,1009,1,'Kindergarten. Volksschule. Internat',to_number('0,2625','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,246','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1045,1009,2,'Hauptschule. Schulausflüge',to_number('0,1178','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1104','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1046,1009,3,'AHS. Halbinternat',NULL,NULL)
/
INSERT INTO wk_cc2
VALUES
(1047,1009,4,'Studiengebühren',to_number('0,1457','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1345','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1048,1009,5,'Kurse',to_number('0,5085','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4799','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1049,1010,1,'Bewirtungsdienstleistungen',to_number('5,9434','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,4406','99D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1050,1010,2,'Beherbergungsdienstleistungen',to_number('1,341','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,5658','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1051,1011,1,'Körperpflege',to_number('2,4867','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,484','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1052,1011,3,'Persönliche Gebrauchsgüter. a.n.g.',to_number('0,7366','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,74','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1053,1011,4,'Sozialschutz',to_number('0,8937','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8328','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1054,1011,5,'Versicherungen',to_number('4,7409','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,6927','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1055,1011,6,'Finanzdienstleistungen. a.n.g.',to_number('0,4167','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3876','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc2
VALUES
(1056,1011,7,'Sonstige Dienstleistungen. a.n.g.',to_number('0,6334','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6108','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
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


-------untergruppen_2  CC3
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

INSERT INTO wk_cc3
VALUES
(1057,1012,1,'Brot und Getreideerzeugnisse',100,to_number('2,1585','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,183','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1058,1012,2,'Fleisch',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,8101','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,8196','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1059,1012,3,'Fisch',100,to_number('0,3246','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3346','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1060,1012,4,'Milch, Käse und Eier',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,8189','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,8329','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1061,1012,5,'Öle und Fette',100,to_number('0,3726','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3837','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1062,1012,6,'Obst',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8859','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9257','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1063,1012,7,'Gemüse',to_number('100,03','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,2054','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,1922','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1064,1012,8,'Zucker, Marmelade, Honig, Schokolade und Süsswaren',100,to_number('1,0029','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,0104','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1065,1012,9,'Nahrungsmittel, a.n.g.',100,to_number('0,3572','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3634','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1066,1013,1,'Kaffee, Tee und Kakao',100,to_number('0,431','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4515','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1067,1013,2,'Mineralwasser, Erfrischungsgetränke  und Saft',100,to_number('0,8656','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8616','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1068,1014,1,'Branntwein',100,to_number('0,1365','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1441','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1069,1014,2,'Wein',100,to_number('0,4768','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,495','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1070,1014,3,'Bier',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4934','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5196','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1071,1015,0,'Tabak',100,to_number('1,7565','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,8579','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1072,1016,1,'Bekleidungsstoffe',100,to_number('0,0162','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0166','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1073,1016,2,'Bekleidungsartikel',to_number('100,03','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,0118','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,2068','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1074,1016,3,'Sonstige Bekleidungsartikel und  -zubehör',100,to_number('0,2123','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2194','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1075,1016,4,'Reinigung und Reparatur von Bekleidung',100,to_number('0,141','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1452','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1076,1017,1,'Schuhe',100,to_number('1,0677','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,0847','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1077,1017,2,'Reparatur von Schuhen',100,to_number('0,0144','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0145','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1078,1018,1,'Gezahlte Wohnungsmieten',100,to_number('3,9582','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,6801','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1079,1019,1,'Ausgaben für Eigentumswohnungen',100,to_number('0,4931','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,6801','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1080,1020,1,'Material für die Instandhaltung und Reparatur der Wohnung',100,to_number('3,47','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,2887','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1081,1020,2,'Dienstleistung für die Instandhaltung  und Reparatur der Wohnung',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,6315','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8491','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1082,1021,1,'Wasserversorgung',100,to_number('0,1972','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1829','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1083,1021,2,'Müllabfuhr',100,to_number('0,2074','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1924','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1084,1021,3,'Abwasserbeseitigung',100,to_number('0,3874','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3575','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1085,1021,4,'Sonstige Dienstleistungen im Zusammenhang mit der Wohnung, ',100,to_number('3,1341','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,0305','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1086,1022,1,'Elektrizität',100,to_number('1,8247','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,6787','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1087,1022,2,'Gas',100,to_number('0,7136','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6813','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1088,1022,3,'Flüssige Brennstoffe',100,to_number('0,7345','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7029','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1089,1022,4,'Feste Brennstoffe',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5728','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5486','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1090,1022,5,'Wärmeenergie',100,to_number('0,5974','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5733','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1091,1023,1,'Möbel und andere Einrichtungsgegenstände',100,to_number('3,5611','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,4467','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1092,1023,2,'Teppiche und andere Bodenbeläge',100,to_number('0,3006','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2815','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1093,1024,0,'Heimtextilien',100,to_number('0,7799','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7378','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1094,1025,1,'Elektrische und nichtelektrische Haushalts-Großgeräte',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,1023','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,0485','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1095,1025,2,'Elektrische und nichtelektrische Haushalts-Kleingeräte',100,to_number('0,2997','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,29','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1096,1025,3,'Reparatur von Haushaltsgeräten',100,to_number('0,1607','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1494','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1097,1026,0,'Glaswaren, Geschirr und andere Gebrauchsgüter für die Haushaltsführung',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3901','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3775','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1098,1027,1,'Großwerkzeuge und -geräte',100,to_number('0,1388','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1434','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1099,1027,2,'Kleinwerkzeuge und div. Zubehör',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3305','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3248','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1100,1028,1,'Kurzlebige Haushaltswaren',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8424','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7889','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1101,1028,2,'Häusliche Dienstleistungen',100,to_number('0,4807','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4432','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1102,1029,1,'Pharmazeutische Erzeugnisse',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,004','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9787','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1103,1029,2,'Sonstige medizinische Erzeugnisse',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0904','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,088','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1104,1029,3,'Sonstige therapeutische Geräte',100,to_number('0,4741','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4665','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1105,1030,1,'Medizinische Dienstleistungen',100,to_number('0,8106','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,83','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1106,1030,2,'Zahnmedizinische Dienstleistungen',100,to_number('0,8791','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9043','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1107,1030,3,'Paramedizinische Dienstleistungen',100,to_number('0,0411','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0721','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1108,1031,0,'Krankenhausdienstleistungen',100,to_number('1,3371','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,9795','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1109,1032,1,'Kraftwagen',100,to_number('4,7676','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,4282','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1110,1032,2,'Krafträder',100,to_number('0,1091','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0997','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1111,1032,3,'Fahrräder',100,to_number('0,161','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,149','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1112,1033,1,'Ersatzteile und Zubehör für private Verkehrsmittel',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5536','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5285','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1113,1033,2,'Kraft- und Schmierstoffe für private Verkehrsmittel',100,to_number('3,6645','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,911','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1114,1033,3,'Instandhaltung und Reparatur von  privaten Verkehrsmitteln',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,029','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,684','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1115,1033,4,'Sonstige Dienstleistungen an privaten Verkehrsmitteln',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,7305','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9601','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1116,1034,1,'Schienenpersonenverkehr',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1967','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2065','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1117,1034,2,'Straßenpersonenverkehr',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2969','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3169','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1118,1034,3,'Luftpersonenverkehr',100,to_number('0,8591','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8634','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1119,1034,5,'Kombinierter Personenverkehr',100,to_number('0,7194','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7587','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1120,1034,6,'Sonstige gekaufte Verkehrsdienstleistungen',100,to_number('0,0378','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0394','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1121,1035,0,'Postdienste',100,to_number('0,1787','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,176','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1122,1036,0,'Telefonapparate und Telefaxgeräte',100,to_number('0,0935','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0773','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1123,1037,0,'Telefon- und Telefaxdienste',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,385','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,213','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1124,1038,1,'Empfangs-, Aufzeichnungs- und Wiedergabegeräte für Ton und Bild',100,to_number('0,5385','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5152','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1125,1038,2,'Foto-, Kino- und optische Geräte',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2228','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2049','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1126,1038,3,'Datenverarbeitungsgeräte',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5183','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4873','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1127,1038,4,'Aufzeichnungsmedien',to_number('100,02','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4189','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,416','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1128,1038,5,'Reparatur von Geräten für Audiovision, Fotografie und ',100,to_number('0,0476','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0485','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1129,1039,2,'Wesentliche Gebrauchsgüter für die Freizeit einschließlich Musikinstrumenten',100,to_number('0,2324','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1130,1040,1,'Spiel- und Hobbywaren',to_number('99,98','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,508','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5066','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1131,1040,2,'Sportgeräte und Ausrüstungen für Camping und Erholung im Freien',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6393','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6495','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1132,1040,3,'Pflanzen',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7296','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7356','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1133,1040,4,'Heimtiere und Heimtierartikel',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5532','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5515','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1134,1040,5,'Veterinär- und andere Dienstleistungen für Heimtiere',100,to_number('0,1157','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1155','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1135,1041,1,'Freizeit- und Sportdienstleistungen',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9394','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,5001','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1136,1041,2,'Kulturdienstleistungen',100,to_number('1,4743','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,9662','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1137,1041,3,'Glücksspiele',100,to_number('0,9153','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9783','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1138,1042,1,'Bücher',100,to_number('0,4193','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4022','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1139,1042,2,'Zeitungen und Zeitschriften',100,to_number('0,7228','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7338','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1140,1042,3,'Sonstige Druckerzeugnisse',100,to_number('0,0513','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0498','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1141,1042,4,'Schreibwaren und Zeichenmaterial',100,to_number('0,2462','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2476','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1142,1043,0,'Pauschalreisen',100,to_number('3,1258','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,7217','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1143,1044,0,'Kindergarten, Volksschule, Internat',100,to_number('0,2625','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,246','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1144,1045,0,'Hauptschule, Schulausflüge',to_number('75,81','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1178','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1104','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1145,1046,0,'AHS, Halbinternat, Oberstufe',NULL,NULL,NULL)
/
INSERT INTO wk_cc3
VALUES
(1146,1047,0,'Studiengebühren',100,to_number('0,1457','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1345','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1147,1048,0,'Kurse',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5085','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4799','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1148,1049,1,'Restaurants, Cafés und dergleichen',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,5373','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,062','99D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1149,1049,2,'Kantinen',100,to_number('0,4061','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3786','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1150,1050,0,'Beherbergungsdienstleistungen',100,to_number('1,341','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,5658','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1151,1051,1,'Friseur- und Kosmetiksalons sowie  andere Einrichtungen für die Körperpflege',100,to_number('1,0622','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,0724','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1152,1051,2,'Elektrische Geräte für die Körperpflege',100,to_number('0,0506','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0499','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1153,1051,3,'Andere Erzeugnisse für die Körperpflege',to_number('100,01','999D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,3739','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,3617','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1154,1052,1,'Schmuck und Uhren',to_number('99,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4023','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4014','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1155,1052,2,'Sonstige persönliche Gebrauchsgüter',100,to_number('0,3343','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3386','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1156,1053,0,'Sozialschutz',100,to_number('0,8937','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8328','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1157,1054,2,'Versicherungen im Zusammenhang  mit der Wohnung',100,to_number('0,9641','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2187','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1158,1054,3,'Versicherungen im Zusammenhang  mit der Gesundheit',100,to_number('1,8308','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4695','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1159,1054,4,'Versicherungen im Zusammenhang  mit dem Verkehr',100,to_number('1,7544','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8451','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1160,1054,5,'Sonstige Versicherungen',100,to_number('0,1916','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1594','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1161,1055,2,'Sonstige Finanzdienstleistungen,  a.n.g',100,to_number('0,4167','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3876','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_cc3
VALUES
(1162,1056,0,'Sonstige Dienstleistungen, a.n.g.',100,to_number('0,6334','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6108','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
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



-------Warencode

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

INSERT INTO wk_warencode
VALUES
(1333,1073,314,'Damenjeans',to_number('0,1607','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,01','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1623','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1334,1073,315,'Kinderjeans',to_number('0,0975','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,43','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1005','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1335,1073,316,'Kinderhose',to_number('0,0488','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,22','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0504','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1336,1073,317,'Kinder-T-Shirt',to_number('0,0943','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,35','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0998','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1337,1073,318,'Kinderjacke',to_number('0,0379','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,94','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0397','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1338,1073,320,'Kinderpyjama',to_number('0,0186','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,46','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0194','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1339,1073,321,'Babyset /Strampler',to_number('0,0512','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,28','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0536','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1340,1073,322,'Kindersocken',to_number('0,0237','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,59','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0236','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1341,1073,323,'Kinderkleid',to_number('0,052','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,3','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0534','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1342,1073,324,'Kindersweater',to_number('0,0325','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,81','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0339','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1343,1073,335,'Herren-Sportbekleidungsset',to_number('0,0401','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),1,to_number('0,0446','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1344,1073,336,'Damenschianzug',to_number('0,0356','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,89','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1345,1073,339,'Freizeitshirt',to_number('0,0476','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,19','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0512','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1346,1073,383,'Damenbademode',to_number('0,0115','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,29','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0114','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1347,1073,404,'Herrenbademode',to_number('0,0111','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,28','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0112','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1348,1074,294,'Krawatte',to_number('0,0891','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('41,97','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0909','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1349,1074,412,'Kopfbedeckung',to_number('0,0891','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('41,97','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0955','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1350,1074,760,'Strickwolle',to_number('0,0162','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,63','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0147','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1351,1074,761,'Stickgarn',to_number('0,0099','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,66','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0103','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1352,1074,762,'Zwirn',to_number('0,008','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,77','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,008','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1353,1075,297,'Änderungsschneiderei, Hose kürzen',to_number('0,0531','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('37,66','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0545','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1354,1075,375,'Waschen+Bügeln Herrenhemden',to_number('0,0677','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('48,01','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,07','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1355,1075,376,'Chemische Reinigung',to_number('0,0202','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,33','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0207','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1356,1076,222,'Damenstiefeletten',to_number('0,069','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,46','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0757','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1357,1076,226,'Herrensportschuhe',to_number('0,0819','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,67','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,085','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1358,1076,325,'Sportfreizeitschuhe',to_number('0,155','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,52','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1603','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1359,1076,326,'Herrenhalbschuhe',to_number('0,1787','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,74','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1782','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1360,1076,327,'Herren-Sommerschuhe',to_number('0,0422','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,95','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0422','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1361,1076,328,'Damenpumps',to_number('0,0908','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,5','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0914','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1362,1076,329,'Damensommerschuhe',to_number('0,1427','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,37','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,135','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1363,1076,330,'Damenstiefel',to_number('0,0695','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,51','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0734','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1364,1076,331,'Kinderhalbschuhe',to_number('0,1455','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,63','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1488','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1365,1076,332,'Kindersportschuhe',to_number('0,0364','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,41','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,037','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1366,1076,334,'Damensportschuhe',to_number('0,056','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0577','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1367,1077,340,'Absatzreparatur',to_number('0,0144','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,0145','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1368,1078,556,'Wohnungsmiete (alle Kateg.)',to_number('3,9582','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('3,6801','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1369,1079,558,'Kosten für Eigentumswohnung',to_number('0,4931','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('3,6801','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1370,1080,248,'Spülbecken',to_number('0,1293','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,73','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0403','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1371,1080,254,'Fertigparkett',to_number('0,1117','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,22','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0472','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1372,1080,257,'Laminatboden',to_number('0,1117','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,22','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0466','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1373,1080,258,'Waschtischarmatur',to_number('0,1335','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0457','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1374,1080,709,'Ziegelstein',to_number('0,3475','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,01','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,131','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1375,1080,711,'Hohlblocksteine',to_number('0,1738','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,01','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0645','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1376,1080,712,'Zement',to_number('0,3676','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,59','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0978','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1377,1080,713,'PVC-Kanalrohre',to_number('0,0841','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,42','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0148','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1378,1080,714,'Gasbetonsteine',to_number('0,0988','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,032','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1379,1080,715,'Betondachsteine',to_number('0,1463','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,22','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,032','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1380,1080,716,'Hydratkalk',to_number('0,3402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,8','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,064','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1381,1080,717,'Gebundene Faserdämmstoffe',to_number('0,1463','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,22','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,032','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1382,1080,718,'Gipskartonplatte',to_number('0,3201','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,22','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0953','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1383,1080,719,'Isolierglaskippfenster',to_number('0,4609','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,28','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1805','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1384,1080,726,'Lack',to_number('0,033','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,95','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0386','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1385,1080,727,'Dispersionsfarbe',to_number('0,0669','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,93','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0842','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1386,1080,730,'Fliesen',to_number('0,1971','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,68','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1468','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1387,1080,731,'Holzverkleidung',to_number('0,2012','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,8','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0954','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1388,1081,220,'Installateur (Gas/Wasser)',to_number('0,1295','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,94','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0816','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1389,1081,221,'Jahreswartung / Gasheizung',to_number('0,1399','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,57','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1384','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1390,1081,223,'Elektroinstallateur',to_number('0,1596','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0886','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1391,1081,225,'Malerarbeiten',to_number('0,0878','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,38','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,064','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1392,1081,255,'Parkett verlegen',to_number('0,3335','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,44','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3004','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1393,1081,720,'Maurerarbeiten (KV-Lohn)',to_number('0,4436','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('27,19','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0325','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1394,1081,721,'Zimmermannsarbeiten',to_number('0,1061','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,5','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0441','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1395,1081,722,'Zentralheizung',to_number('0,0863','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,29','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0547','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1396,1081,723,'Fenstereinbau',to_number('0,0741','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,54','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0056','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1397,1081,724,'Fliesenlegen',to_number('0,0711','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,36','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0392','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1398,1082,498,'Wassergebühr lfd. Kosten',to_number('0,1735','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('87,98','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1611','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1399,1082,499,'Wassergebühr/Fixkosten',to_number('0,0237','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,02','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0218','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1400,1083,500,'Müllabfuhr (Einfamilienhaus)',to_number('0,2074','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,1924','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1401,1084,501,'Kanalgebühr (Einfamilienhaus)',to_number('0,3874','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,3575','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1402,1085,502,'Rauchfangkehrer (Einfamilienhaus)',to_number('0,131','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,18','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1208','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1403,1085,557,'Betriebskosten, Mietwohnung',to_number('2,2164','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('70,72','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,0954','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1404,1085,559,'Betriebskosten, Eigtumswohnung',to_number('0,7867','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('25,1','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8143','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1405,1086,564,'Elektr.Strom, Arbeitspreis/Nacht',to_number('0,146','9D999','NLS_NUMERIC_CHARACTERS ='', '''),8,to_number('0,1366','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1406,1086,566,'Elektr.Strom, Grundgebühr Zähler',to_number('0,1642','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),9,to_number('0,1508','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1407,1086,567,'Elektr.Strom, Arbeitspreis/Tag',to_number('1,5145','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),83,to_number('1,3913','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1408,1087,568,'Gas, Grundgebühr',to_number('0,0482','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,75','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0439','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1409,1087,569,'Gas, Arbeitspreis',to_number('0,6654','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('93,25','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6374','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1410,1088,227,'Heizöl extra leicht/Großabnahme',to_number('0,7345','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,7029','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1411,1089,228,'Braunkohlenbriketts',to_number('0,0634','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,07','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0599','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1412,1089,229,'Hüttenkoks',to_number('0,0423','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,38','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0391','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1413,1089,230,'Holzbriketts',to_number('0,0337','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,88','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0323','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1414,1089,231,'Brennholz',to_number('0,4334','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('75,66','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4173','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1415,1090,570,'Fernheizung, Grundgebühr',to_number('0,1493','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('24,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,14','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1416,1090,571,'Fernheizung, Arbeitspreis',to_number('0,4481','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('75,01','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4333','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1417,1091,187,'Küche, Arbeitsplatte',to_number('0,068','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,91','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0668','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1418,1091,237,'Hochschrank (für Kühlschrank)',to_number('0,102','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,86','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0995','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1419,1091,238,'Vorratsschrank',to_number('0,102','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,86','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1','9D9','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1420,1091,239,'Unterbau-Eckschrank',to_number('0,102','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,86','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,099','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1421,1091,240,'Küchenelement/Oberschrank',to_number('0,136','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,82','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1307','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1422,1091,241,'Küchenelement/Unterschrank',to_number('0,17','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,77','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1628','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1423,1091,242,'Sitzgarnitur',to_number('0,3275','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,2','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3191','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1424,1091,243,'Schlafzimmermöbel',to_number('0,3909','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,98','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3776','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1425,1091,244,'Essgarnitur',to_number('0,1655','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,65','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1581','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1426,1091,245,'Wohnzimmerprogramm',to_number('0,5288','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,85','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5114','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1427,1091,246,'Vorzimmerspiegel',to_number('0,155','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,35','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1488','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1428,1091,247,'Gartenmöbel',to_number('0,1132','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,18','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1102','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1429,1091,249,'Badezimmerblock',to_number('0,3822','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,73','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3632','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1430,1091,259,'Vorzimmer',to_number('0,1289','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,62','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1261','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1431,1091,269,'Kinderzimmer',to_number('0,2316','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,5','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2286','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1432,1091,284,'Kommode/Anrichte',to_number('0,0829','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,33','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0815','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1433,1091,437,'Schreibtisch',to_number('0,0829','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,33','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0809','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1434,1091,734,'Luster/Hängelampe',to_number('0,0558','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,57','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0551','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1435,1091,735,'Deckenbeleuchtung',to_number('0,0655','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,84','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0632','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1436,1091,748,'Matratze',to_number('0,1704','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,79','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1641','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1437,1092,250,'Spannteppich',to_number('0,0697','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('23,19','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0651','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1438,1092,252,'Wollteppich, handgewebt',to_number('0,1366','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('45,44','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1273','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1439,1092,256,'Spannteppich verlegen',to_number('0,0943','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('31,37','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0891','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1440,1093,253,'Gardinen',to_number('0,1968','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('25,23','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1843','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1441,1093,260,'Bettwäsche',to_number('0,1555','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('19,94','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1455','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1442,1093,261,'Spannleintuch',to_number('0,0795','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,19','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0783','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1443,1093,262,'Badetuch/Handtuch',to_number('0,1108','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,21','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1058','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1444,1093,263,'Steppdecke',to_number('0,1265','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,22','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1201','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1445,1093,264,'Tischdecke',to_number('0,1108','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,21','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1038','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1446,1094,270,'Kühlschrank, Standgerät',to_number('0,0478','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,34','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0463','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1447,1094,271,'Kühlschrank, Einbaugerät',to_number('0,0688','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0672','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1448,1094,272,'Gefrierschrank, Standgerät',to_number('0,0502','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,55','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0475','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1449,1094,273,'Geschirrspüler',to_number('0,1652','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,156','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1450,1094,274,'Elektroherd, Einbaugerät',to_number('0,1916','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('17,38','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1823','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1451,1094,275,'Mikrowellenherd',to_number('0,0089','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,81','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0084','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1452,1094,277,'Staubsauger',to_number('0,1284','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,65','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1239','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1453,1094,278,'Waschmaschine',to_number('0,2006','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,2','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1885','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1454,1094,280,'Heizlüfte/Klimagerät',to_number('0,0905','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,21','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0871','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1455,1094,442,'Kühl-Gefrier-Kombination',to_number('0,0694','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,3','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0643','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1456,1094,729,'Wäschetrockner',to_number('0,0638','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,79','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0609','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1457,1094,739,'Kaminofen/Allesbrenner',to_number('0,0171','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,55','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0161','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1458,1095,276,'Hand-, Stabmixer',to_number('0,021','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,01','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0202','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1459,1095,279,'Dampfbügeleisen, -station',to_number('0,0659','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('21,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0615','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1460,1095,283,'Kaffeemaschine, Espresso-Vollautomat',to_number('0,2128','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),71,to_number('0,2083','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1461,1096,754,'Waschmaschinenservice',to_number('0,1607','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,1494','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1462,1097,732,'Kristalltiere',to_number('0,064','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,41','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0714','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1463,1097,740,'Druckkochtopf',to_number('0,0329','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,43','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0314','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1464,1097,741,'Bratpfanne',to_number('0,0798','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,46','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0751','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1465,1097,742,'Essbesteck',to_number('0,0296','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,59','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0269','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1466,1097,743,'Messer',to_number('0,0099','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,54','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0094','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1467,1097,744,'Flachteller',to_number('0,0424','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,87','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0397','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1468,1097,745,'Trinkglas',to_number('0,0478','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,25','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0463','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1469,1097,746,'Plastikgeschirr',to_number('0,041','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,51','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0371','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1470,1097,747,'Kunststoffeimer',to_number('0,0427','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,95','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1471,1098,749,'Bohrmaschine',to_number('0,0345','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('24,86','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0328','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1472,1098,750,'Akkuschrauber',to_number('0,023','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,57','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0238','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1473,1098,751,'Rasenmäher',to_number('0,0813','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('58,57','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0868','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1474,1099,234,'Batterie',to_number('0,1017','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('30,77','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0958','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1475,1099,267,'Energiesparlampe',to_number('0,0324','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,8','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0308','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1476,1099,268,'Spotlampe',to_number('0,0324','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,8','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0309','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1477,1099,736,'Hammer',to_number('0,1006','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('30,44','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1054','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1478,1099,752,'Gartenschere',to_number('0,0634','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('19,18','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0619','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1479,1100,235,'Filtertüten',to_number('0,0709','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,42','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0683','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1480,1100,350,'Scheuermittel',to_number('0,0153','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,82','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0149','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1481,1100,351,'Geschirrspülmittel',to_number('0,122','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,48','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1184','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1482,1100,352,'Allzweckreiniger',to_number('0,0305','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,62','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0285','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1483,1100,353,'Alufolie',to_number('0,0518','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,15','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0493','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1484,1100,354,'Schwammtuch',to_number('0,1063','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,62','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1017','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1485,1100,355,'Vollwaschmittel',to_number('0,1674','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('19,87','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1572','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1486,1100,391,'Klebstoff',to_number('0,0224','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,66','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0214','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1487,1100,444,'WC-Stein/Spüler',to_number('0,0501','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,95','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0486','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1488,1100,456,'Spezialwaschmittel',to_number('0,0983','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,67','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0847','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1489,1100,737,'Spanplattenschrauben',to_number('0,0638','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,57','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0577','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1490,1100,770,'Bodenwischer',to_number('0,0436','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,18','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0382','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1491,1101,771,'Wohnungsreinigung',to_number('0,4807','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,4432','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1492,1102,778,'Erkältungsmittel /Hustentee',to_number('0,2029','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,21','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1997','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1493,1102,779,'Schmerz-/Rheumamittel',to_number('0,105','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,46','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1023','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1494,1102,780,'Contraceptivum',to_number('0,049','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,88','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0479','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1495,1102,781,'Vitamin-, Gesundheitspräparat',to_number('0,1609','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,03','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1572','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1496,1102,782,'Homöopathisches Medikament',to_number('0,084','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,37','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0815','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1497,1102,783,'Rezeptgebühr',to_number('0,3042','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('30,3','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2951','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1498,1102,787,'Haut-, und Schleimhautmittel',to_number('0,098','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,76','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,095','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1499,1103,368,'Pflaster',to_number('0,0099','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,95','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0096','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1500,1103,373,'Kondome',to_number('0,0186','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,58','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0182','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1501,1103,768,'Inkontinenzeinlagen',to_number('0,0109','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,06','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0108','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1502,1103,775,'Wundverband',to_number('0,0268','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('29,65','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0259','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1503,1103,776,'Fieberthermometer',to_number('0,0242','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('26,77','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0235','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1504,1104,773,'Heilbehelfe',to_number('0,0664','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,01','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0644','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1505,1104,777,'Kontaktlinsen',to_number('0,0474','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),10,to_number('0,0459','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1506,1104,784,'Brillengläser',to_number('0,2418','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),51,to_number('0,2421','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1507,1104,785,'Brillenfassung',to_number('0,1185','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('24,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1141','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1508,1105,755,'Wahlarzt (prakt.Arzt)',to_number('0,0998','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,31','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1036','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1509,1105,756,'Wahlarzt (Facharzt)',to_number('0,43','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('53,05','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4439','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1510,1105,0,'Prakt. Arzt, Ordination (2Positionen)',to_number('0,0998','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,31','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,102','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1511,1105,0,'Facharzt, Ordination (3 Posotionen)',to_number('0,1383','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('17,06','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1412','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1512,1105,792,'Krankenscheingebühr/ E-Card',to_number('0,0427','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,27','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0393','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1513,1106,774,'Wahlarzt (Zahnarzt)',to_number('0,5883','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('66,92','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6044','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1514,1106,791,'Zahnarztleistung',to_number('0,2908','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('33,08','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2999','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1515,1107,757,'Wahlarzt (Institut)',to_number('0,0193','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('46,96','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0338','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1516,1107,758,'Nichtärztliche Gesundheitsberatung',to_number('0,0218','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('53,04','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0383','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1517,1108,0,'Pflegeheim (2 Positionen)',to_number('1,0748','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('80,38','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9938','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1518,1108,573,'Spitalskosten (Sonderkl.Aufz.)',to_number('0,1305','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,76','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,191','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1519,1108,574,'Spitalskosten (Allgemein)',to_number('0,1317','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2095','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1520,1108,575,'Spitalskosten (Sonderklasse Vollzahler)',to_number('0,0001','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,01','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5852','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1521,1109,0,'PKW, Gebrauchtwagen (24 Positionen)',to_number('0,4102','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,6','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3789','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1522,1109,0,'PKW, Neuwagen (52 Positionen)',to_number('4,3574','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('91,4','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,0493','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1523,1110,902,'Mofa',to_number('0,0223','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,44','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,02','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1524,1110,903,'Motorrad',to_number('0,0868','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('79,56','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0797','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1525,1111,904,'Fahrrad',to_number('0,161','9D999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,149','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1526,1112,419,'Scheibenfrostschutz',to_number('0,018','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,25','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0208','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1527,1112,420,'Scheibenwischer',to_number('0,0788','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,23','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,075','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1528,1112,421,'Autozündkerzen',to_number('0,0182','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,29','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0172','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1529,1112,422,'Autobatterie',to_number('0,0233','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,21','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0223','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1530,1112,435,'Sommerreifen',to_number('0,1954','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('35,3','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,185','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1531,1112,436,'Winterreifen',to_number('0,0716','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,93','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0678','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1532,1112,927,'Autoersatzlampen',to_number('0,0747','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,49','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0708','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1533,1112,930,'Autoapotheke',to_number('0,0096','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,73','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0089','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1534,1112,931,'Lastenträger',to_number('0,064','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,56','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0607','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1535,1113,415,'Motoröl',to_number('0,018','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,49','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0192','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1536,1113,416,'Normalbenzin',to_number('0,4826','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,17','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,506','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1537,1113,417,'Superbenzin',to_number('1,3049','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('35,61','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,3743','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1538,1113,418,'Dieseltreibstoff',to_number('1,859','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('50,73','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,0115','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1539,1114,423,'Wagenwäsche',to_number('0,0425','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,09','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0555','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1540,1114,424,'Kfz-Spengler Stunde',to_number('0,3072','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('15,14','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,406','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1541,1114,425,'Kfz-Mechaniker Stunde',to_number('0,4608','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('22,71','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6077','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1542,1114,428,'Scheinwerfer Material',to_number('0,2103','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,36','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2751','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1543,1114,430,'Auspuffanlage mit Katalysator - Material',to_number('0,3679','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,13','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4903','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1544,1114,431,'Vorderrad Bremsen - Material',to_number('0,1727','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,51','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,229','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1545,1114,432,'KFZ-Elektrikerstunde',to_number('0,1536','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,57','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2012','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1546,1114,433,'Ölservice',to_number('0,2047','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,09','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2751','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1547,1114,548,'Klimaanlagenservice',to_number('0,0683','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,37','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0888','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1548,1114,550,'Reifenservice',to_number('0,041','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,02','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0553','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1549,1115,470,'Fahrschule',to_number('0,1749','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,11','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1623','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1550,1115,493,'Parkgebühr',to_number('0,0388','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0367','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1551,1115,494,'Parkpickerl',to_number('0,0388','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0376','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1552,1115,495,'Parkgarage',to_number('0,0777','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,49','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0715','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1553,1115,552,'Mietwagen',to_number('0,0542','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,13','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0952','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1554,1115,582,'Allgemeine Mautgebühr',to_number('0,1532','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2327','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1555,1115,585,'Wiederkehrende Begutachtung',to_number('0,0614','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,55','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0799','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1556,1115,807,'Führerscheingebühr',to_number('0,0057','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,33','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0053','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1557,1115,906,'Motorbez. Vers.steuer bis 40 kW',to_number('0,0466','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,69','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0053','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1558,1115,907,'Motorbez. Vers.steuer 41-55 kW',to_number('0,1959','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,32','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0053','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1559,1115,908,'Motorbez. Vers.steuer 56-67 kW',to_number('0,2239','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,94','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0053','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1560,1115,909,'Motorbez. Vers.steuer 68-89 kW',to_number('0,3171','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,32','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0053','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1561,1115,910,'Motorbez. Vers.steuer 90-111 kW',to_number('0,1492','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,62','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0053','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1562,1115,925,'Mautgebühr, Alpenstraßen',to_number('0,0573','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,31','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0871','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1563,1115,926,'Anmelden eines PKW',to_number('0,0542','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,13','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0501','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1564,1115,928,'Beitrag zum Autofahrerclub',to_number('0,0816','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,72','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0752','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1565,1116,951,'Bahn-Erwachsene Vollpreis',to_number('0,0367','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,66','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0385','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1566,1116,952,'Bahn-Kinder',to_number('0,0023','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,17','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0023','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1567,1116,953,'Bahn-Halbpreis alle Züge',to_number('0,0878','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('44,64','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0922','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1568,1116,954,'Bahn-Vorteilscard',to_number('0,0333','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,93','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,035','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1569,1116,956,'Bahn-Zeitkarte (J,M,W)',to_number('0,0333','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,93','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,035','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1570,1116,957,'Bahn-Seniorenkarte',to_number('0,0033','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,68','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0035','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1571,1117,496,'Taxi Tagesfahrt',to_number('0,121','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('40,75','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1292','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1572,1117,497,'Taxi Nachtfahrt',to_number('0,121','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('40,75','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1273','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1573,1117,932,'Ausflugsbus',to_number('0,0549','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,49','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0604','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1574,1118,966,'Flugticket',to_number('0,8591','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,8634','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1575,1119,0,'Österr. Personennahverkehr, Tageskarten (5 Positionen)',to_number('0,274','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('38,09','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2882','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1576,1119,0,'Österr. Personennahverkehr, Dauerkarten (7 Positionen)',to_number('0,4454','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('61,91','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4705','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1577,1120,958,'Bahn-Schließfachgebühr',to_number('0,0378','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,0394','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1578,1121,935,'Postkarte Inland',to_number('0,0536','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('29,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0528','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1579,1121,936,'Briefporto Inland',to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('22,5','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0396','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1580,1121,937,'Briefporto Ausland',to_number('0,0134','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,5','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0132','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1581,1121,939,'Pakettarif',to_number('0,0715','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('40,01','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0704','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1582,1122,969,'Mobiltelefongerät',to_number('0,0685','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('73,26','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0563','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1583,1122,970,'Komforttelefon /autom. Anufbeantworter',to_number('0,025','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('26,74','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,021','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1584,1123,584,'Festnetz/Gesprächsentgelt',to_number('0,2743','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,5','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2678','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1585,1123,940,'Telefongrundentgelt',to_number('0,4942','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,72','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,487','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1586,1123,949,'Mobiltelefon, Grundentgelt',to_number('0,6615','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('27,74','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5804','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1587,1123,950,'Mobiltelefon, Gesprächsentgelt',to_number('0,7166','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('30,05','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6365','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1588,1123,967,'Internetentgelt',to_number('0,1717','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,2','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1756','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1589,1123,968,'Festnetz, Onlineentgelt',to_number('0,0667','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,8','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0657','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1590,1124,408,'HiFi-Anlage',to_number('0,0419','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0418','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1591,1124,409,'Farbfernseher',to_number('0,1699','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('31,55','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1642','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1592,1124,411,'CD/MP3-Portable',to_number('0,0429','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,97','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,042','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1593,1124,805,'DVD-Recorder/Player',to_number('0,0805','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,95','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0777','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1594,1124,821,'Satellitenanlage',to_number('0,0548','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,18','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0544','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1595,1124,838,'Autoradio mit CD',to_number('0,0425','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,89','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0418','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1596,1124,864,'Flachfernseher',to_number('0,106','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('19,68','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0933','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1597,1125,824,'Spiegelreflexkamera',to_number('0,0197','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,84','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0186','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1598,1125,825,'Camcorder',to_number('0,0394','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('17,68','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0372','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1599,1125,854,'Digitalkamera',to_number('0,1637','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('73,47','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1491','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1600,1126,799,'Softwarepaket',to_number('0,027','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,21','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0243','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1601,1126,800,'PC-Drucker',to_number('0,0504','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,72','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0412','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1602,1126,842,'PC-Monitor',to_number('0,079','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('15,24','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0731','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1603,1126,843,'PC-Computer',to_number('0,1435','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('27,69','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1368','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1604,1126,860,'PC-Zubehör',to_number('0,035','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,75','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0319','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1605,1126,861,'Notebook',to_number('0,1834','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('35,38','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,18','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1606,1127,397,'Farbnegativfilm',to_number('0,0245','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0246','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1607,1127,405,'CD-Rohling',to_number('0,0299','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,14','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0297','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1608,1127,406,'DVD-Rohling',to_number('0,0247','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,9','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0246','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1609,1127,514,'Fotopapier',to_number('0,0245','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0254','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1610,1127,801,'CD, Hitparade',to_number('0,1706','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('40,73','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1683','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1611,1127,802,'CD, Klassik',to_number('0,019','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,54','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0197','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1612,1127,809,'DVD-Film',to_number('0,0584','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,94','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0582','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1613,1127,827,'CD-ROM für Schüler/Studenten',to_number('0,0288','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,88','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0285','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1614,1127,859,'Speichermedium',to_number('0,0385','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,19','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,037','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1615,1128,828,'Fernsehmechaniker',to_number('0,0476','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,0485','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1616,1129,803,'Blockflöte',to_number('0,037','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('15,92','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0379','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1617,1129,804,'Gitarre',to_number('0,1111','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('47,81','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1149','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1618,1129,806,'Tischtennistisch',to_number('0,0843','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('36,27','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0872','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1619,1130,448,'Tretauto/Dreirad',to_number('0,0951','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,72','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0936','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1620,1130,449,'Modepuppe',to_number('0,0308','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,06','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0338','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1621,1130,450,'Kunststoffbaukasten',to_number('0,1446','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('28,46','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1415','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1622,1130,451,'Metallmodellfahrzeug',to_number('0,0533','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,49','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0522','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1623,1130,452,'Stofftier',to_number('0,0145','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0146','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1624,1130,453,'Brettspiel',to_number('0,0495','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,74','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0487','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1625,1130,454,'Grundgerät für Videospiel',to_number('0,0123','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,42','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0123','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1626,1130,455,'PC-CDRom-Spiel',to_number('0,0698','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,74','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0705','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1627,1130,826,'Spielkarten',to_number('0,0381','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,5','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0394','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1628,1131,337,'Schischuhe/Inlineskater',to_number('0,1318','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,62','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1431','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1629,1131,338,'Tennisbälle',to_number('0,0198','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,1','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0199','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1630,1131,579,'Snowboard',to_number('0,0285','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,46','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0292','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1631,1131,580,'Snowboardbindung',to_number('0,0107','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,67','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0105','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1632,1131,583,'Schi',to_number('0,1389','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('21,73','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1464','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1633,1131,592,'Schwimmbecken',to_number('0,0283','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,43','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0286','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1634,1131,600,'Schlafsack',to_number('0,0538','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,42','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0541','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1635,1131,810,'Schisicherheitsbindung',to_number('0,0285','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,46','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0273','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1636,1131,811,'Tennisracket',to_number('0,0396','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,19','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,04','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1637,1131,812,'Fitnessgerät',to_number('0,1416','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('22,15','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1325','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1638,1131,813,'Schiservice',to_number('0,0178','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0179','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1639,1132,829,'Schnittblumen',to_number('0,1662','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('22,78','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1696','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1640,1132,830,'Zimmerpflanze',to_number('0,0942','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,91','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0916','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1641,1132,831,'Gartenpflanze',to_number('0,1939','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('26,58','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2001','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1642,1132,832,'Grassamen',to_number('0,0997','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,67','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1','9D9','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1643,1132,833,'Blumenerde',to_number('0,0931','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,76','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0912','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1644,1132,834,'Düngemittel',to_number('0,0825','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,31','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0831','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1645,1133,370,'Katzenfutter',to_number('0,2661','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('48,1','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2653','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1646,1133,371,'Hundefutter',to_number('0,1563','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('28,25','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1551','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1647,1133,434,'Katzenstreu',to_number('0,1308','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('23,64','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1311','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1648,1134,504,'Tierarzt, Hundeimpfung',to_number('0,1157','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,1155','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1649,1135,466,'Musikschule Öffentlich',to_number('0,0949','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,1','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0969','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1650,1135,475,'Tennisvereinsbeitrag',to_number('0,187','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('19,91','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1862','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1651,1135,476,'Fußballsitzplatz',to_number('0,0737','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0745','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1652,1135,478,'Hallenbad (4 Positionen)',to_number('0,0536','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,71','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0548','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1653,1135,482,'Freiluftbad (4 Positionen)',to_number('0,0535','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,7','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0539','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1654,1135,486,'Fitness-Studio',to_number('0,0794','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,45','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0805','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1655,1135,505,'Reitstunde',to_number('0,0949','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,1','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0953','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1656,1135,934,'Seilbahnen und Lifte',to_number('0,3024','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('32,19','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,858','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1657,1136,395,'Kino, Eintrittskarte Erw.',to_number('0,0904','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,13','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1067','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1658,1136,399,'Filmentwicklung/Farbfilm',to_number('0,0249','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,69','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0251','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1659,1136,400,'Fotoerstausarbeitung',to_number('0,1031','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,99','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1019','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1660,1136,401,'Fotoprint (Digitalfoto)',to_number('0,0497','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,37','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0471','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1661,1136,468,'Musiktheater',to_number('0,1215','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3695','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1662,1136,469,'Sprechtheater',to_number('0,1412','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,58','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4395','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1663,1136,471,'Ausstellung/Museum Erwach. (4',to_number('0,0287','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,95','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,041','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1664,1136,503,'Telekabelgebühr',to_number('0,54','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('36,63','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4879','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1665,1136,506,'Touristische Attraktion (2 Positionen)',to_number('0,0151','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,02','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0214','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1666,1136,581,'Fernseh-Kombigebühr',to_number('0,3597','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('24,4','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3261','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1667,1137,850,'Lotto',to_number('0,6259','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('68,38','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3261','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1668,1137,851,'Joker',to_number('0,1573','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('17,19','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3261','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1669,1137,852,'Rubbellos',to_number('0,1321','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,43','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3261','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1670,1138,795,'Fachbuch',to_number('0,137','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('32,67','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1309','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1671,1138,796,'Bestseller Belletristik',to_number('0,1046','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('24,95','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1049','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1672,1138,797,'Bestseller Kinderbuch',to_number('0,0407','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,71','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0411','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1673,1138,798,'Bestseller Sachbuch',to_number('0,137','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('32,67','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1253','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1674,1139,586,'Tageszeitungen (10 Positionen)',to_number('0,5179','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('71,65','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,523','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1675,1139,808,'Illustrierte',to_number('0,2049','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('28,35','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2108','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1676,1140,794,'Autoatlas',to_number('0,0513','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,0498','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1677,1141,384,'Schulfüllfeder',to_number('0,0188','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,64','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0189','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1678,1141,385,'Schulheft',to_number('0,0254','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,32','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0252','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1679,1141,386,'Collegeblock',to_number('0,0254','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,32','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0252','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1680,1141,387,'Geodreieck',to_number('0,0289','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,74','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0291','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1681,1141,388,'Buntstifte',to_number('0,0607','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('24,65','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,061','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1682,1141,389,'Bleistift, Schulstift',to_number('0,0361','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,66','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0373','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1683,1141,390,'Geschenkpapier',to_number('0,0509','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,67','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0509','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1684,1142,840,'Buspauschalreisen im Inland',to_number('0,0938','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),3,to_number('0,0837','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1685,1142,841,'Buspauschalreisen im Ausland',to_number('0,3126','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),10,to_number('0,2835','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1686,1142,845,'Städteflug',to_number('0,7189','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),23,to_number('0,5828','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1687,1142,846,'Flugpauschalreisen',to_number('2,0005','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),64,to_number('1,7717','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1688,1143,445,'Kindergartengebühr (3 Positionen)',to_number('0,1964','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('74,82','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1843','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1689,1143,467,'Volksschule, Halbinternat, Non-Profit',to_number('0,0661','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('25,18','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0617','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1690,1144,439,'Hauptschule,',to_number('0,0661','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('25,18','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0617','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1691,1144,817,'Schulschikurs',to_number('0,0207','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,27','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0201','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1692,1144,818,'Landschulwoche',to_number('0,031','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('30,36','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0286','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1693,1146,603,'Studiengebühr',to_number('0,1457','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,1345','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1694,1147,98,'Nachhilfe',to_number('0,1271','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),25,to_number('0,1186','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1695,1147,814,'Sprachkurs',to_number('0,1101','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('21,65','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1012','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1696,1147,815,'Fortbildungskurs/-lehrgang',to_number('0,207','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('40,71','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1988','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1697,1147,816,'EDV-Kurs',to_number('0,0643','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,65','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0613','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1698,1148,23,'Leberkäse, heiß',to_number('0,0237','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,43','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0436','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1699,1148,99,'Pizza inkl. Zustellung',to_number('0,1041','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,88','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,189','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1700,1148,188,'Belegtes Gebäck',to_number('0,1632','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,95','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2988','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1701,1148,189,'Vegetarisches Gericht',to_number('0,1982','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,58','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3638','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1702,1148,192,'Schokoladetorte',to_number('0,1101','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,99','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2001','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1703,1148,193,'Kaffee (Melange/Verlängerter)',to_number('0,1101','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,99','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2011','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1704,1148,194,'Mischgetränk, alkoholisch',to_number('0,1542','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2792','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1705,1148,195,'Würstel',to_number('0,0331','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0602','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1706,1148,196,'Tagessuppe',to_number('0,022','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1707,1148,197,'Gulaschsuppe/Bohnensuppe',to_number('0,022','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1708,1148,198,'Rindsgulasch',to_number('0,1101','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,99','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2018','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1709,1148,199,'Tagesmenü im Gasthaus',to_number('0,1542','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2802','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1710,1148,200,'Grillkotelette',to_number('0,1542','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2823','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1711,1148,201,'Schnitzel, paniert',to_number('0,3304','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,97','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6051','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1712,1148,202,'Rostbraten',to_number('0,022','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1713,1148,203,'Salat',to_number('0,1101','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,99','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2011','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1714,1148,204,'Mehlspeise, Dessert',to_number('0,0661','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,19','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1209','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1715,1148,205,'Fischgericht',to_number('0,2864','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,17','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5206','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1716,1148,206,'Kinderschnitzel',to_number('0,0661','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,19','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1207','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1717,1148,207,'Kleiner Brauner',to_number('0,2203','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,98','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4028','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1718,1148,208,'Bier',to_number('0,6608','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,93','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,2035','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1719,1148,209,'Wein, 1/8 l',to_number('0,3965','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,16','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7306','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1720,1148,210,'Mineralwasser',to_number('0,0881','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,59','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,161','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1721,1148,211,'Apfelsaft aufgespritzt',to_number('0,1322','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,39','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2419','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1722,1148,212,'Colagetränk',to_number('0,1982','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,58','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,36','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1723,1148,213,'Fruchtsaft ohne Kohelsäure',to_number('0,1982','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,58','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3605','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1724,1148,214,'Pizzaschnitte',to_number('0,0757','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,37','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1386','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1725,1148,215,'Getränk am Imbissstand',to_number('0,0568','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,03','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,104','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1726,1148,217,'Fast Food',to_number('0,1657','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,99','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3111','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1727,1148,218,'Kebab',to_number('0,0142','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,26','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0257','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1728,1148,403,'Discothek inkl. Getränk',to_number('0,121','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,19','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2221','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1729,1148,438,'Spezialitätenrestaurant Vorspeise',to_number('0,0881','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,59','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1621','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1730,1148,460,'Essen auf Rädern',to_number('0,0599','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,08','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0561','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1731,1148,463,'Spezialitätenrestaurant Hauptspeise',to_number('0,3965','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,16','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7189','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1732,1148,547,'Spezialitätenrestaurant Nachspeise',to_number('0,1101','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,99','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1984','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1733,1148,620,'Fertigmenü',to_number('0,3147','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,68','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,5756','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1734,1149,461,'Kantinenmenü',to_number('0,213','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('52,45','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1976','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1735,1149,462,'Gebäck mit Wurst/Käse',to_number('0,0789','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('19,43','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0744','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1736,1149,465,'Mittagessen (Schule, Kindergarten)',to_number('0,1142','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('28,12','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1066','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1737,1150,457,'Hotel, 4*5* Auslandstouristen',to_number('0,236','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('17,6','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,9645','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1738,1150,819,'Studentenheim',to_number('0,0683','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,09','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3138','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1739,1150,836,'Hotelzimmer mit Frst. 4*, 5*',to_number('0,2769','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,65','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,0279','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1740,1150,837,'Hotelzimmer mit Frst. 3*',to_number('0,1816','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,54','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,8568','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1741,1150,839,'Privatzimmer im Inland',to_number('0,0363','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,71','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1942','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1742,1150,844,'Ferienwohnung',to_number('0,0454','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,39','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3593','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1743,1150,853,'Übernachtung im Ausland (App.)',to_number('0,3649','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('27,21','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3593','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1744,1150,871,'Wellnesshotel',to_number('0,1316','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,81','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,49','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1745,1151,180,'Fußpflege',to_number('0,0545','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,13','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0545','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1746,1151,181,'Massage',to_number('0,1818','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('17,12','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1835','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1747,1151,182,'Gesichtsbehandlung',to_number('0,1273','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,98','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1272','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1748,1151,374,'Kinder-/Jugendhaarschnitt',to_number('0,0459','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,32','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,046','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1749,1151,377,'Damenhaarschnitt',to_number('0,3434','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('32,33','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3489','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1750,1151,378,'Friseur, Waschen und Legen',to_number('0,0448','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,22','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0456','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1751,1151,379,'Haarfärben',to_number('0,0746','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,02','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0755','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1752,1151,380,'Dauerwelle',to_number('0,0348','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,28','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0351','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1753,1151,381,'Herrenhaarschnitt',to_number('0,0427','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,02','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0428','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1754,1151,477,'Sauna',to_number('0,0562','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,29','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0562','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1755,1151,487,'Solarium',to_number('0,0562','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,29','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0571','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1756,1152,281,'Rasierapparat',to_number('0,0339','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),67,to_number('0,0332','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1757,1152,282,'Haarfön',to_number('0,0167','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),33,to_number('0,0167','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1758,1153,346,'Haartönung',to_number('0,07','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,09','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0696','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1759,1153,347,'Haarshampoo',to_number('0,0798','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,81','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0771','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1760,1153,348,'Ganzkörperpflegecreme',to_number('0,1249','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,09','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1245','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1761,1153,349,'Tampons',to_number('0,036','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,62','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0362','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1762,1153,356,'Flüssigseife',to_number('0,0186','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,35','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0182','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1763,1153,357,'Gesichtscreme',to_number('0,1376','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,02','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1365','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1764,1153,358,'Eau de Toilette',to_number('0,0957','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,97','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0955','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1765,1153,359,'Lippenstift',to_number('0,1978','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,4','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1969','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1766,1153,360,'Zahncreme',to_number('0,0547','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,98','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0548','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1767,1153,361,'Zahnbürste',to_number('0,0348','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,53','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0348','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1768,1153,363,'Haarspray',to_number('0,0383','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,79','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0389','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1769,1153,364,'Duschgel',to_number('0,1037','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,55','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,105','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1770,1153,365,'Toilettepapier',to_number('0,0638','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,64','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0631','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1771,1153,366,'Papiertaschentücher',to_number('0,026','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,89','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0256','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1772,1153,367,'Wegwerfwindeln',to_number('0,0873','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,35','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0844','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1773,1153,369,'Babyfeuchttücher',to_number('0,0894','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,51','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0856','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1774,1153,429,'Deodorant',to_number('0,0391','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0381','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1775,1153,520,'Rasierklingen',to_number('0,0619','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,51','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0629','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1776,1153,772,'Pflegemittel für Zahnersatz',to_number('0,0145','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,06','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,014','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1777,1154,764,'Ehering',to_number('0,0738','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,34','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0745','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1778,1154,765,'Halskette',to_number('0,1724','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('42,85','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,174','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1779,1154,767,'Damenarmbanduhr',to_number('0,1561','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('38,8','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1529','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1780,1155,333,'Schulrucksack',to_number('0,0285','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,53','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0289','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1781,1155,341,'Damenschirm',to_number('0,0623','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,64','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0616','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1782,1155,342,'Damenhandtasche',to_number('0,0427','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,77','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0431','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1783,1155,343,'Laptoptasche',to_number('0,0242','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0248','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1784,1155,344,'Herrengeldbörse',to_number('0,0228','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,82','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0232','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1785,1155,345,'Hartschalenkoffer',to_number('0,0242','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0248','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1786,1155,489,'Sarg',to_number('0,0924','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('27,64','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0957','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1787,1155,753,'Kinderbuggy',to_number('0,018','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,38','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0175','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1788,1155,929,'Autokindersitz',to_number('0,0192','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,74','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,019','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1789,1156,0,'Seniorenheim (3 Positionen)',to_number('0,6577','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('73,59','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,6094','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1790,1156,441,'Nachmittagsbetreuung Öffentl.',to_number('0,0815','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,12','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0794','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1791,1156,443,'Kinderkrippe Öffentl. Rechtsträger',to_number('0,021','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,35','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0199','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1792,1156,447,'Tagesmutter',to_number('0,0427','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0395','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1793,1156,459,'Heimhilfe',to_number('0,0908','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,16','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0846','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1794,1157,560,'Eigenheimbündelversicherung',to_number('0,6652','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),69,to_number('0,0846','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1795,1157,710,'Hausratsversicherung',to_number('0,2989','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),31,to_number('0,1341','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1796,1158,0,'Private Krankenversicherung (3 Positionen',to_number('1,8308','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,4695','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1797,1159,0,'Haftpflichtversichrung (5 Positionen)',to_number('1,0008','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('57,05','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,4788','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1798,1159,0,'Teilkaskoversicherung (5 Positionen)',to_number('0,5837','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('33,27','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,255','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1799,1159,923,'Autorechtsschutzversicherung',to_number('0,0865','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,93','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0717','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1800,1159,924,'Motorradhaftpflichtversicherung',to_number('0,0834','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,75','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0396','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1801,1160,901,'Rechtsschutzversicherung',to_number('0,1916','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,1594','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1802,1161,0,'Bankgebühren (3 Positionen)',to_number('0,2917','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),70,to_number('0,2724','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1803,1161,870,'Depotgebühren',to_number('0,125','9D999','NLS_NUMERIC_CHARACTERS ='', '''),30,to_number('0,1152','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1804,1162,488,'Begräbniskosten',to_number('0,2596','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('40,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2395','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1805,1162,490,'Friedhofsgebühr',to_number('0,1113','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('17,57','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1027','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1806,1162,553,'Rechtsanwalt',to_number('0,1269','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,03','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1426','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1807,1162,554,'Vermittlungsgebühren, Mietwohnung',to_number('0,0553','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,73','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,052','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1808,1162,835,'Reisepass, Ausstellungsgebühr',to_number('0,0803','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,68','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,074','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1163,1057,42,'Pizza, tiefgekühlt',to_number('0,0806','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,73','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,081','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1164,1057,43,'Germknödel tiefgekühlt',to_number('0,0313','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,45','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0318','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1165,1057,45,'Fertiggericht,tiefgekühlt',to_number('0,023','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,07','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0231','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1166,1057,47,'Fertiggericht,gekühlt',to_number('0,0124','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,57','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0125','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1167,1057,73,'Mischbrotwecken',to_number('0,1278','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,92','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1302','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1168,1057,74,'Spezialbrot',to_number('0,2982','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,82','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3018','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1169,1057,75,'Weißbrot',to_number('0,1994','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2017','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1170,1057,76,'Semmel',to_number('0,1157','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,36','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1178','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1171,1057,77,'Gebäck',to_number('0,2776','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,86','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2835','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1172,1057,78,'Weckerl zum Fertigbacken',to_number('0,0819','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,79','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0796','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1173,1057,85,'Frühstückscerealien',to_number('0,055','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,55','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0551','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1174,1057,86,'Müsli',to_number('0,0303','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,4','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0311','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1175,1057,87,'Butterkekse',to_number('0,0855','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,96','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0864','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1176,1057,88,'Haselnussschnitten',to_number('0,0508','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,35','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0537','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1177,1057,89,'Salzstäbchen',to_number('0,0388','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,8','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0393','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1178,1057,91,'Crackers',to_number('0,0222','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,03','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0225','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1179,1057,103,'Langkornreis',to_number('0,0566','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,62','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0577','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1180,1057,106,'Weizenmehl',to_number('0,0736','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,41','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0729','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1181,1057,107,'Teigwaren',to_number('0,1265','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,86','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1263','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1182,1057,110,'Kindergrieß',to_number('0,0489','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,27','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0489','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1183,1057,190,'Nussgebäck',to_number('0,1612','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,47','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1628','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1184,1057,191,'Topfengolatsche',to_number('0,1612','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,47','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1633','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1185,1058,1,'Rindfleisch, Beiried',to_number('0,0611','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,17','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,062','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1186,1058,2,'Rindsschnitzelfleisch',to_number('0,1039','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,7','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1063','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1187,1058,3,'Rind-Suppenfleisch',to_number('0,0825','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,94','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,085','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1188,1058,4,'Rindfleisch, Lungenbraten',to_number('0,0581','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,07','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0591','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1189,1058,6,'Bauchfleisch',to_number('0,0574','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,04','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0597','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1190,1058,7,'Schopfbraten',to_number('0,0835','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,97','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0822','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1191,1058,8,'Schweinsschnitzel',to_number('0,1826','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,5','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1756','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1192,1058,9,'Karree',to_number('0,1982','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,05','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2008','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1193,1058,11,'Kalbsschnitzel',to_number('0,0476','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,69','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0477','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1194,1058,13,'Dauerhartwurst',to_number('0,2707','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,63','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2686','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1195,1058,14,'Faschiertes',to_number('0,1527','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,43','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1534','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1196,1058,15,'Selchfleisch',to_number('0,082','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,92','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0794','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1197,1058,16,'Speck',to_number('0,1231','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,38','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1229','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1198,1058,18,'Toastschinken',to_number('0,3032','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,79','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3094','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1199,1058,19,'Truthahnextra',to_number('0,0974','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,47','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0984','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1200,1058,21,'Extrawurst',to_number('0,2165','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,7','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2209','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1201,1058,22,'Salami',to_number('0,1949','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,94','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1952','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1202,1058,26,'Brathuhn',to_number('0,1275','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,54','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1295','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1203,1058,27,'Putenbrustfleisch',to_number('0,1738','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,18','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1678','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1204,1058,30,'Leberaufstrich',to_number('0,0568','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,02','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0602','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1205,1058,31,'Rindsgulaschkonserve',to_number('0,0516','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,84','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,053','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1206,1058,37,'Hühnerfilet',to_number('0,085','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,02','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0825','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1207,1059,33,'Thunfisch',to_number('0,0341','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,51','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0349','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1208,1059,39,'Dorschfilet, tiefgekühlt',to_number('0,103','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('31,73','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1009','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1209,1059,40,'Fischstäbchen, tiefgekühlt',to_number('0,0511','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('15,74','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0512','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1210,1059,46,'Frischer Fisch',to_number('0,0843','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('25,97','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,093','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1211,1059,66,'Räucherlachs',to_number('0,0521','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,05','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0546','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1212,1060,48,'Vollmilch',to_number('0,3549','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('19,51','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3595','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1213,1060,49,'Milchmixgetränk',to_number('0,0849','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,67','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0851','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1214,1060,50,'Sauerrahm',to_number('0,0668','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,67','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0666','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1215,1060,51,'Schlagobers',to_number('0,1559','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,57','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1566','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1216,1060,52,'Speisetopfen',to_number('0,0262','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,44','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0263','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1217,1060,54,'Kondensierte Milch',to_number('0,0396','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,18','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0404','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1218,1060,55,'Fruchtjoghurt',to_number('0,1415','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1429','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1219,1060,56,'Topfencreme mit Früchten',to_number('0,0203','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,12','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0202','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1220,1060,57,'Joghurt',to_number('0,0566','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,11','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0573','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1221,1060,59,'Emmentaler',to_number('0,1576','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,66','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,16','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1222,1060,60,'Gouda',to_number('0,1745','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,59','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1786','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1223,1060,63,'Camembert',to_number('0,0957','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,26','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0984','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1224,1060,64,'Frischkäse',to_number('0,129','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,09','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1286','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1225,1060,65,'Mozarella',to_number('0,0788','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,33','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0784','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1226,1060,147,'Eier',to_number('0,2366','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,01','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,234','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1227,1061,53,'Butter',to_number('0,1472','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('39,51','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1477','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1228,1061,67,'Margarine',to_number('0,0815','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('21,87','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0896','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1229,1061,69,'Sortenreines Pflanzenöl',to_number('0,0455','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,21','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0451','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1230,1061,70,'Gemischtes Pflanzenöl',to_number('0,0455','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,21','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0456','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1231,1061,71,'Olivenöl',to_number('0,0529','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,2','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0557','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1232,1062,92,'Erdnüsse, geröstet/gesalzen',to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,54','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,04','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1233,1062,117,'Rosinen',to_number('0,064','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,22','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0622','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1234,1062,149,'Mandarinen',to_number('0,0193','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,18','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0199','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1235,1062,150,'Erdbeeren',to_number('0,0708','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,99','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1199','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1236,1062,151,'Äpfel',to_number('0,173','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('19,53','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,168','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1237,1062,152,'Birnen',to_number('0,0322','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,63','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0323','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1238,1062,154,'Pfirsiche, Nektarinen',to_number('0,0919','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,37','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0801','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1239,1062,155,'Trauben',to_number('0,0761','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,59','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0826','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1240,1062,156,'Zucker-, Honigmelone',to_number('0,0443','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),5,to_number('0,0436','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1241,1062,157,'Bananen',to_number('0,1356','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('15,31','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1369','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1242,1062,158,'Kiwi',to_number('0,0443','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),5,to_number('0,0485','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1243,1062,160,'Orangen',to_number('0,0624','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,04','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0602','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1244,1062,161,'Zitronen',to_number('0,0318','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,59','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0315','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1245,1063,28,'Rotkraut, tiefgekühlt',to_number('0,0154','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,28','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0144','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1246,1063,34,'Delikatessgurken',to_number('0,117','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,71','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1184','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1247,1063,36,'Mischgemüse, tiefgekühlt',to_number('0,0555','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,6','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0572','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1248,1063,38,'Spinat,tiefgekühlt',to_number('0,0318','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,64','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0321','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1249,1063,41,'Pommes frites, tiefgekühlt',to_number('0,0223','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0228','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1250,1063,90,'Kartoffelchips',to_number('0,052','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,31','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0516','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1251,1063,109,'Babykost/Gemüse',to_number('0,0845','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,01','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0856','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1252,1063,165,'Champignons',to_number('0,0271','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,25','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0272','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1253,1063,167,'Gurken',to_number('0,0559','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,64','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0445','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1254,1063,168,'Karfiol',to_number('0,0572','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,75','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0699','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1255,1063,169,'Karotten',to_number('0,0542','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,5','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0517','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1256,1063,170,'Eissalat',to_number('0,0694','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,76','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0687','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1257,1063,171,'Paprika',to_number('0,0851','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,06','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0757','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1258,1063,173,'Häuptelsalat',to_number('0,1182','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,81','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,132','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1259,1063,175,'Tomaten',to_number('0,1251','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,38','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1081','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1260,1063,176,'Zwiebeln',to_number('0,0574','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,76','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0568','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1261,1063,183,'Kartoffeln',to_number('0,1176','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,76','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1167','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1262,1063,184,'Suppengrün, Wurzelwerk',to_number('0,0207','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,72','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,02','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1263,1063,185,'Sauerkraut',to_number('0,039','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0388','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1264,1064,25,'Speiseeis, Familienpackung',to_number('0,0509','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,08','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0505','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1265,1064,32,'Pfirsichkompott',to_number('0,0415','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,14','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0421','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1266,1064,44,'Speiseeis, Einzelstück',to_number('0,0764','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,62','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0769','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1267,1064,93,'Vollmilchschokolade',to_number('0,2484','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('24,77','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2562','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1268,1064,94,'Schokoriegel',to_number('0,1338','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('13,34','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1308','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1269,1064,95,'Kaugummi',to_number('0,1658','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,53','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1676','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1270,1064,96,'Fruchtbonbons',to_number('0,0933','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,3','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0945','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1271,1064,100,'Künstlicher Süßstoff',to_number('0,0141','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,41','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0142','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1272,1064,101,'Marmelade/Konfitüre',to_number('0,0591','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,89','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0588','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1273,1064,102,'Bienenhonig',to_number('0,0252','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,51','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0244','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1274,1064,104,'Kristallzucker',to_number('0,0944','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,41','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0944','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1275,1065,108,'Suppenpulver',to_number('0,0645','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,06','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0674','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1276,1065,111,'Backpulver',to_number('0,0645','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('18,06','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0652','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1277,1065,113,'Vollsalz',to_number('0,0296','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('8,29','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0298','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1278,1065,114,'Gewürzpaprika',to_number('0,0549','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('15,37','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0556','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1279,1065,115,'Senf',to_number('0,0503','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,08','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0498','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1280,1065,116,'Tomatenketchup',to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,25','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0405','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1281,1065,118,'Gärungsessig',to_number('0,0532','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('14,89','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0551','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1282,1066,142,'Teebeutel',to_number('0,0966','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('22,41','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0975','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1283,1066,144,'Bohnenkaffee',to_number('0,3108','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('72,11','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3302','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1284,1066,145,'Kakaohältiges Schnellgetränk',to_number('0,0236','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,48','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0238','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1285,1067,133,'Aromatisiertes Mineralwasser',to_number('0,09','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('10,4','99D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0903','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1286,1067,134,'Modegetränk',to_number('0,0683','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,89','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0683','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1287,1067,135,'Mineral-,Tafelwasser',to_number('0,1451','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('16,76','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1444','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1288,1067,136,'Kohlensäurehältige Limonade',to_number('0,1041','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,03','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1034','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1289,1067,137,'Colagetränk',to_number('0,1041','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('12,03','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1013','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1290,1067,138,'Eistee',to_number('0,0646','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('7,46','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,066','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1291,1067,139,'Orangensaft',to_number('0,2894','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('33,43','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2879','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1292,1068,130,'Weinbrandverschnitt',to_number('0,0382','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('27,99','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1293,1068,131,'Wodka',to_number('0,0983','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('72,01','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1039','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1294,1069,123,'Rotwein',to_number('0,2131','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('44,69','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2255','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1295,1069,125,'Weißwein, Bouteille',to_number('0,1639','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('34,38','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1755','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1296,1069,127,'Sekt',to_number('0,0998','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('20,93','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,094','9D999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1297,1070,119,'Dosenbier',to_number('0,148','9D999','NLS_NUMERIC_CHARACTERS ='', '''),30,to_number('0,1558','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1298,1070,120,'Flaschenbier',to_number('0,2911','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),59,to_number('0,3062','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1299,1070,121,'Spezialbier',to_number('0,0543','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('11,01','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0576','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1300,1071,628,'Zigaretten',to_number('1,7279','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('98,37','99D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,8274','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1301,1071,629,'Zigarren',to_number('0,0286','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,63','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0305','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1302,1072,759,'Viskosestoff',to_number('0,0162','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),100,to_number('0,0166','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1303,1073,186,'Kindertrainingsanzug',to_number('0,0517','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,29','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0507','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1304,1073,216,'Damensportbekleidungsset',to_number('0,0402','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),1,to_number('0,0433','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1305,1073,219,'Herren-Snowboardanzug',to_number('0,0401','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),1,to_number('0,0435','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1306,1073,233,'Babybody',to_number('0,0341','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0343','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1307,1073,236,'Kinderunterwäscheset',to_number('0,0294','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,73','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,03','9D99','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1308,1073,265,'Herrenjeans',to_number('0,1301','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,24','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1343','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1309,1073,285,'Herrenmantel',to_number('0,0136','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,34','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0153','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1310,1073,287,'Herrenanzug',to_number('0,1394','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,47','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1477','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1311,1073,288,'Herrenhose',to_number('0,1022','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,55','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1121','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1312,1073,289,'Herrensakko',to_number('0,0279','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,7','9D9','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0289','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1313,1073,290,'Herrenjacke',to_number('0,1379','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,44','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1521','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1314,1073,291,'Herrenshirt',to_number('0,1115','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,78','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1183','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1315,1073,292,'Herrenhemd',to_number('0,1951','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,86','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2018','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1316,1073,293,'Herren-Poloshirt',to_number('0,0743','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,85','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0769','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1317,1073,295,'Herrensocken',to_number('0,0417','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,04','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0418','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1318,1073,296,'Herrenunterhose',to_number('0,0775','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,93','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0799','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1319,1073,298,'Damenkleid',to_number('0,0877','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,19','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0963','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1320,1073,299,'Damenhose',to_number('0,263','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('6,56','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2859','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1321,1073,300,'Damenmantel',to_number('0,0704','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,75','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0731','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1322,1073,301,'Damenzweiteiler',to_number('0,073','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('1,82','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0794','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1323,1073,302,'Damenrock',to_number('0,0877','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,19','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0988','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1324,1073,303,'Damenjacke',to_number('0,181','9D999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,51','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1847','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1325,1073,304,'Damenshirt',to_number('0,3798','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('9,47','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,3895','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1326,1073,305,'Damenpullover',to_number('0,1899','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('4,73','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1949','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1327,1073,306,'Damenbluse',to_number('0,2191','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('5,46','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,2301','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1328,1073,307,'Herrenpullover, -weste',to_number('0,1487','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,71','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1558','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1329,1073,309,'Büstenhalter',to_number('0,1267','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('3,16','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1317','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1330,1073,310,'Damenstrumpfhose',to_number('0,0332','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,83','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0337','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1331,1073,311,'Damennachthemd',to_number('0,0332','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,83','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,0352','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
/
INSERT INTO wk_warencode
VALUES
(1332,1073,312,'Damenunterhose',to_number('0,1086','9D9999','NLS_NUMERIC_CHARACTERS ='', '''),to_number('2,71','9D99','NLS_NUMERIC_CHARACTERS ='', '''),to_number('0,1116','9D9999','NLS_NUMERIC_CHARACTERS ='', '''))
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

-- Start of DDL Script for View HR.V_WAREN_PERSON
-- Generated 11-Feb-2010 12:21:00 from HR@ORCL

--Aus der Sicht: Ebene Wc
CREATE OR REPLACE VIEW v_waren_person (
   user_id,
   user_name,
   cc1_id,
   cc2_id,
   cc3_id,
   wc_id,
   cc1,
   cc1_bezeichnung,
   cc2,
   cc2_bezeichnung,
   cc3,
   cc3_bezeichnung,
   warencode,
   wc_bezeichnung,
   ist_vpi,
   default_vpi )
AS
select u.user_id,u.user_name, w1.cc1_id, w2.cc2_id, w3.cc3_id, wc.wc_id, w1.cc1, w1.cc1_bezeichnung,
w2.cc2, w2.cc2_bezeichnung,
w3.cc3, w3.cc3_bezeichnung,
wc.warencode, wc.wc_bezeichnung, p.ist_vpi ist_vpi, wc_vpi default_vpi
from wk_warencode wc, wk_cc3 w3, wk_cc2 w2, wk_cc1 w1, wk_personal p, wk_user u
where wc.cc3_id=w3.cc3_id and w3.cc2_id=w2.cc2_id and w2.cc1_id = w1.cc1_id
and wc.wc_id=p.wk_id and p.user_id=u.user_id
/


-- End of DDL Script for View HR.V_WAREN_PERSON

-- Start of DDL Script for View HR.V_CC3_PERSON_UNION
-- Generated 11-Feb-2010 12:20:47 from HR@ORCL

--Aus der Sicht: Ebene cc3 = cc3 input + wc input 
CREATE OR REPLACE VIEW v_cc3_person_union (
   user_id,
   user_name,
   cc1_id,
   cc1_bezeichnung,
   cc2_id,
   cc2_bezeichnung,
   cc3_id,
   cc3_bezeichnung,
   ist_vpi,
   default_vpi )
AS
select u.user_id,u.user_name, w1.cc1_id, w1.cc1_bezeichnung,w2.cc2_id,w2.cc2_bezeichnung,w3.cc3_id,w3.cc3_bezeichnung, p.ist_vpi ist_vpi, w3.cc3_vpi default_vpi
from  wk_cc3 w3, wk_cc2 w2, wk_cc1 w1, wk_personal p, wk_user u
where  w3.cc2_id=w2.cc2_id and w2.cc1_id = w1.cc1_id
and w3.cc3_id=p.wk_id and p.user_id=u.user_id
union
select a."USER_ID",a."USER_NAME",a."CC1_ID",a."CC1_BEZEICHNUNG",a."CC2_ID",a."CC2_BEZEICHNUNG",a."CC3_ID",a."CC3_BEZEICHNUNG",a."SUM(IST_VPI)", w.cc3_vpi from
(select user_id, user_name, cc1_id,cc1_bezeichnung,cc2_id,cc2_bezeichnung,cc3_id, cc3_bezeichnung,sum(ist_vpi)
from v_waren_person
where cc3_id in (select cc3_id from wk_cc3)
group by user_id,user_name,cc3_id, cc2_id, cc1_id,cc1_bezeichnung,cc2_bezeichnung,cc3_bezeichnung) a, wk_cc3 w
where a.cc3_id=w.cc3_id
/


-- End of DDL Script for View HR.V_CC3_PERSON_UNION

-- Start of DDL Script for View HR.V_CC2_PERSON_UNION
-- Generated 11-Feb-2010 12:20:21 from HR@ORCL

--Aus der Sicht: Ebene cc2 = cc2 input + cc3 input 
CREATE OR REPLACE VIEW v_cc2_person_union (
   user_id,
   user_name,
   cc1_id,
   cc1_bezeichnung,
   cc2_id,
   cc2_bezeichnung,
   ist_vpi,
   default_vpi )
AS
select u.user_id,u.user_name, w1.cc1_id, w1.cc1_bezeichnung,w2.cc2_id,w2.cc2_bezeichnung, p.ist_vpi ist_vpi, w2.cc2_vpi default_vpi
from   wk_cc2 w2, wk_cc1 w1, wk_personal p, wk_user u
where  w2.cc1_id = w1.cc1_id
and w2.cc2_id=p.wk_id and p.user_id=u.user_id
union
select a."USER_ID",a."USER_NAME",a."CC1_ID",a."CC1_BEZEICHNUNG",a."CC2_ID",a."CC2_BEZEICHNUNG",a."SUM(IST_VPI)", w.cc2_vpi from
(select user_id, user_name, cc1_id, cc1_bezeichnung,cc2_id,cc2_bezeichnung, sum(ist_vpi)
from v_cc3_person_union
group by user_id,user_name,cc1_id, cc1_bezeichnung,cc2_id,cc2_bezeichnung) a, wk_cc2 w
where a.cc2_id=w.cc2_id
/


-- End of DDL Script for View HR.V_CC2_PERSON_UNION

-- Start of DDL Script for View HR.V_CC1_PERSON_UNION
-- Generated 11-Feb-2010 12:19:32 from HR@ORCL

--Aus der Sicht: Ebene cc1 = cc1 input + cc2 input 
CREATE OR REPLACE VIEW v_cc1_person_union (
   user_id,
   user_name,
   cc1_id,
   cc1_bezeichnung,
   ist_vpi,
   default_vpi )
AS
select u.user_id,u.user_name, w1.cc1_id,w1.cc1_bezeichnung,p.ist_vpi ist_vpi, w1.cc1_vpi default_vpi
from   wk_cc1 w1, wk_personal p, wk_user u
where  w1.cc1_id=p.wk_id and p.user_id=u.user_id
UNION
select a."USER_ID",a."USER_NAME",a."CC1_ID",a."CC1_BEZEICHNUNG",a."SUM(IST_VPI)", w.cc1_vpi from
(select user_id, user_name, cc1_id, cc1_bezeichnung, sum(ist_vpi)
from v_cc2_person_union
group by user_id, user_name, cc1_id, cc1_bezeichnung)  a, wk_cc1 w
where a.cc1_id=w.cc1_id
/


-- End of DDL Script for View HR.V_CC1_PERSON_UNION


select count(*) from wk_warencode;

/*   
select w1.cc1_id, w2.cc2_id, w3.cc3_id, wc.wc_id, w1.cc1, w1.cc1_bezeichnung, 
w2.cc2, w2.cc2_bezeichnung,
w3.cc3, w3.cc3_bezeichnung,
wc.warencode, wc.wc_bezeichnung
from wk_warencode wc, wk_cc3 w3, wk_cc2 w2, wk_cc1 w1
where wc.cc3_id=w3.cc3_id and w3.cc2_id=w2.cc2_id and w2.cc1_id = w1.cc1_id;
*/