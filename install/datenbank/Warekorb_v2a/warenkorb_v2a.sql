/* drop
drop table ext_hauptgruppen;
drop table ext_untergruppen_1;
drop table ext_untergruppen_2;
drop table ext_waren;
drop table wk_waren;
drop table wk_untergruppen_2;
drop table wk_untergruppen_1;
drop table wk_hauptgruppen;
drop sequence  WK_SEQ
*/


 -------sequence
 create sequence  WK_SEQ  minvalue 1 maxvalue 999999999999999999999999999 
 increment by 1 start with 1000 cache 20 noorder  nocycle ;

-------hauptgruppen
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


create table wk_hauptgruppen (
  hg_id number,
  hg_cc1 number,
  hg_bezeichnung varchar2(100),

  constraint wk_hg_id_pk primary key (hg_id),
  constraint wk_hg_cc_uk unique (hg_cc1)
);

create or replace
trigger wk_hg_insert_trg
 before insert on wk_hauptgruppen 
for each row 
begin
  :new.hg_id := wk_seq.nextval;
end;
/

insert into wk_hauptgruppen (hg_cc1, hg_bezeichnung)
select cc1, bezeichnung from ext_hauptgruppen;

-------untergruppen_1

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


create table wk_untergruppen_1 (
  ug1_id  number,
  ug1_cc1 number,
  ug1_cc2 number,
  ug1_bezeichnung varchar2(100),

  constraint wk_ug1_id_pk primary key (ug1_id),
  constraint wk_ug1_cc_uk unique (ug1_cc1, ug1_cc2),
  constraint wk_ug1_cc_fk foreign key (ug1_cc1) references wk_hauptgruppen (hg_cc1)
);

create or replace
trigger wk_ug1_insert_trg
 before insert on wk_untergruppen_1 
for each row 
begin
  :new.ug1_id := wk_seq.nextval;
end;
/

insert into  wk_untergruppen_1 (ug1_cc1, ug1_cc2, ug1_bezeichnung)
select cc1, cc2,  bezeichnung from ext_untergruppen_1;


-------untergruppen_2
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



create table wk_untergruppen_2 (
  ug2_id  number,
  ug2_cc1 number,
  ug2_cc2 number,
  ug2_cc3 number,
  ug2_bezeichnung varchar2(100),

  constraint wk_ug2_id_pk primary key (ug2_id),
  constraint wk_ug2_cc_uk unique (ug2_cc1, ug2_cc2, ug2_cc3),
  constraint wk_ug2_cc_fk foreign key (ug2_cc1, ug2_cc2) references wk_untergruppen_1 (ug1_cc1, ug1_cc2)
);

create or replace
trigger wk_ug2_insert_trg
 before insert on wk_untergruppen_2 
for each row 
begin
  :new.ug2_id := wk_seq.nextval;
end;
/

insert into  wk_untergruppen_2 (ug2_cc1, ug2_cc2, ug2_cc3, ug2_bezeichnung)
select cc1, cc2, cc3, bezeichnung from ext_untergruppen_2;

-------waren 
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


create table wk_waren (
  w_id number,
  w_cc1 number,
  w_cc2 number,
  w_cc3 number,
  w_warencode number,
  w_bezeichnung varchar2(100),
  w_gewicht_vpi number,
  w_anteil_an_gruppe number,
  w_gewicht_hvpi number,
  constraint wk_w_id_pk primary key (w_id),
  constraint wk_w_cc_fk foreign key (w_cc1, w_cc2, w_cc3) references  wk_untergruppen_2 (ug2_cc1, ug2_cc2, ug2_cc3)
);

create or replace
trigger wk_w2_insert_trg
 before insert on wk_waren 
for each row 
begin
  :new.w_id := wk_seq.nextval;
end;
/

insert into wk_waren 
   (w_cc1, w_cc2, w_cc3, w_warencode, w_bezeichnung, w_gewicht_vpi, w_anteil_an_gruppe, w_gewicht_hvpi)
   select cc1, cc2, cc3, warencode, bezeichnung, index1, prozent, index2 from ext_waren;
  
commit;

select count(*) from wk_waren;

/*   
select w2.ug1_cc1, w2.ug1_cc2, w3.ug2_cc3, w4.w_warencode, 
			w1.hg_bezeichnung, w2.ug1_bezeichnung, w3.ug2_bezeichnung, w4.w_bezeichnung, 
			w4.w_gewicht_vpi, w4.w_anteil_an_gruppe, w4.w_gewicht_hvpi 
from wk_waren w4, wk_untergruppen_2 w3, wk_untergruppen_1 w2, wk_hauptgruppen w1
where w2.ug1_cc1=w1.hg_cc1 
	and w3.ug2_cc1=w2.ug1_cc1 
	and w3.ug2_cc2=w2.ug1_cc2
	and w4.w_cc1=w3.ug2_cc1 
	and w4.w_cc2=w3.ug2_cc2 
	and w4.w_cc3=w3.ug2_cc3
*/
