CREATE OR REPLACE package wk_pkg as

-- Werte fuer Column 'USER_DEF' 
-- (record t_cc1_rec, t_cc2_rec, t_cc3_rec, t_warencode_rec) 
WK_VAL_DEFAULT      constant number(1) := 0; -- Default Wert
WK_VAL_USER         constant number(1) := 1; -- Benutzerdefinierter Wert
WK_VAL_DIFF_ROW     constant number(1) := 8; -- Dummy Row 'Sonstiges' (cc1 id = 99)
WK_VAL_NOT_EDITABLE constant number(1) := 9; -- Wert nicht editierbar

type t_cc1_rec is record (
                 cc1 number,
                 cc1_bezeichnung varchar2(100),
                 cc1_vpi number,
                 val number, 
                 user_def number(1) );
                                 
type t_cc1_tab is table of t_cc1_rec;

type t_cc2_rec is record (
                 cc1 number,
                 cc2 number,
                 cc2_bezeichnung varchar2(100),
                 cc2_vpi number,
                 val number, 
                 user_def number(1) );
                                 
type t_cc2_tab is table of t_cc2_rec;

type t_cc3_rec is record (
                 cc1 number,
                 cc2 number,
                 cc3 number,
                 cc3_bezeichnung varchar2(100),
                 cc3_vpi number,
                 val number, 
                 user_def number(1) );
                                 
type t_cc3_tab is table of t_cc3_rec;

type t_warencode_rec is record (
                 cc1 number,
                 cc2 number,
                 cc3 number,
                 wc_id number,
                 warencode number,
                 wc_bezeichnung varchar2(100),
                 wc_vpi number,
                 val number, 
                 user_def number(1) );
                                 
type t_warencode_tab is table of t_warencode_rec;

type t_pers_val_rec is record (
                      cc1 number,
                      cc2 number,
                      cc3 number,
                      warencode number,
                      bez varchar2(100),
                      wp_id number,
                      ist_vpi number,
                      wk_level varchar2(10) );

type t_pers_val_tab is table of t_pers_val_rec;

-- fetch_X
function fetch_cc1 (p_userid in number, p_calc_val in number := 1) return t_cc1_tab pipelined;
function fetch_cc2 (p_userid in number, p_cc1  in number, p_calc_val in number := 1) return t_cc2_tab pipelined;
function fetch_cc3 (p_userid in number, p_cc1  in number, p_cc2 in number, p_calc_val in number := 1) return t_cc3_tab pipelined;
function fetch_warencode (p_userid in number, p_cc1  in number, p_cc2 in number, p_cc3 in number, p_calc_val in number := 1) return t_warencode_tab pipelined;
function fetch_alle_waren (p_userid in number) return t_warencode_tab pipelined;

-- ins_or_upd_X
procedure ins_or_upd_cc1(p_userid in number, p_cc1 in number, p_val in number);
procedure ins_or_upd_cc2(p_userid in number, p_cc1 in number, p_cc2 in number, p_val in number);
procedure ins_or_upd_cc3(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number, p_val in number);
procedure ins_or_upd_warencode(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number, p_warencode in number, p_val in number);
procedure ins_or_upd(p_userid in number, p_id in number, p_val in number);

-- del_X
procedure del_cc1(p_userid in number, p_cc1 in number);
procedure del_cc2(p_userid in number, p_cc1 in number, p_cc2 in number);
procedure del_cc3(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number);
procedure del_warencode(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number, p_warencode in number);
procedure del(p_userid in number, p_id in number);

-- calc_factor_X
function  calc_factor_cc1(p_userid in number, p_cc1 in number) return number;
function  calc_factor_cc2(p_userid in number, p_cc1 in number, p_cc2 in number) return number;
function  calc_factor_cc3(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number) return number;

-- has_pers_val_X
function has_pers_val(p_userid in number) return t_pers_val_tab pipelined;
function has_pers_val_cc1(p_userid in number, p_cc1 in number) return t_pers_val_tab pipelined;
function has_pers_val_cc2(p_userid in number, p_cc1 in number, p_cc2 in number) return t_pers_val_tab pipelined;
function has_pers_val_cc3(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number) return t_pers_val_tab pipelined;

end wk_pkg;

/


CREATE OR REPLACE package body wk_pkg as


/* -----------------------------------------------------------------------------
  function fetch_cc1 
--------------------------------------------------------------------------------*/

function fetch_cc1 (p_userid in number, p_calc_val in number := 1) 
return t_cc1_tab pipelined is
  
    cursor c_cur(p_c_user_id number) is
       select cc1, cc1_bezeichnung, cc1_vpi,  coalesce(ist_vpi,cc1_vpi) val, nvl2(ist_vpi,WK_VAL_USER,WK_VAL_DEFAULT) user_def
       from wk_cc1 t1 left join wk_personal tp on t1.cc1_id = tp.wk_id and user_id = p_c_user_id
       order by cc1;
  
   v_tab t_cc1_tab;
   v_sum number := 0;
   v_user_sum number := 0;
   v_faktor number := 1.0;
   v_sum_vpi number := 0.0;
   v_sum_val number := 0;
   v_rec t_cc1_rec;
  
begin
   open  c_cur(p_userid);
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   
   if p_calc_val = 1 then
   for i in v_tab.first .. v_tab.last loop
      if v_tab(i).user_def = WK_VAL_DEFAULT then
        select sum(val) into v_sum_val from table(fetch_cc2(p_userid,v_tab(i).cc1));
        v_tab(i).val := v_sum_val;
        v_user_sum := v_user_sum + v_tab(i).val;
      else 
        v_sum := v_sum + v_tab(i).val;
      end if;
      v_sum_vpi :=  v_sum_vpi +  v_tab(i).cc1_vpi;
--      pipe row(v_tab(i));
   end loop;
  end if;
  
  for i in v_tab.first .. v_tab.last loop
     pipe row(v_tab(i));
  end loop;

  v_rec.cc1 := 99;
  v_rec.cc1_bezeichnung := 'SONSTIGES';
  v_rec.cc1_vpi := 0;
  v_rec.val := v_sum_vpi - v_sum - v_user_sum;
  v_rec.user_def := WK_VAL_DIFF_ROW;
  pipe row(v_rec);
  return;
 end fetch_cc1;
 
/* -----------------------------------------------------------------------------
  function fetch_cc2 
--------------------------------------------------------------------------------*/

function fetch_cc2 (p_userid in number, p_cc1  in number, p_calc_val in number := 1) 
return t_cc2_tab pipelined 
is
   cursor c_cur(p_c_user_id number, p_c_cc1 number) is
       select cc1, cc2, cc2_bezeichnung, cc2_vpi,  coalesce(ist_vpi,cc2_vpi) val, nvl2(ist_vpi,WK_VAL_USER,WK_VAL_DEFAULT) user_def
       from (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id ) left join  wk_personal tp on t2.cc2_id = tp.wk_id and user_id = p_c_user_id
       where t1.cc1 = p_cc1 
       order by cc2;
       
   v_tab t_cc2_tab;
   v_sum number;
   v_factor number;
   
begin
   open  c_cur(p_userid, p_cc1);
   fetch c_cur bulk collect into v_tab;
   close c_cur;
 
  if p_calc_val = 1 then
  v_factor := calc_factor_cc1(p_userid,p_cc1);
  if v_factor is not null 
  then 
      for i in v_tab.first .. v_tab.last loop
         v_tab(i).val := v_tab(i).val * v_factor;
         v_tab(i).user_def := WK_VAL_NOT_EDITABLE;
      end loop; 
  else 
      for i in v_tab.first .. v_tab.last loop
          if v_tab(i).user_def = WK_VAL_DEFAULT then
              select sum(val) into v_sum 
              from table(fetch_cc3(p_userid,v_tab(i).cc1,v_tab(i).cc2));
              v_tab(i).val := v_sum;
          end if;
      end loop;
  end if;
  end if;
  
  for i in v_tab.first .. v_tab.last loop
      pipe row(v_tab(i));
  end loop;
  return;
end fetch_cc2; 

/* -----------------------------------------------------------------------------
  function fetch_cc3 
--------------------------------------------------------------------------------*/

function fetch_cc3 (p_userid in number, p_cc1  in number, p_cc2 in number, p_calc_val in number := 1) 
return t_cc3_tab pipelined 
is 

   cursor c_cur(p_c_user_id number, p_c_cc1 number, p_c_cc2 number) is
      select cc1, cc2, cc3, cc3_bezeichnung, cc3_vpi,  coalesce(ist_vpi,cc3_vpi) val, nvl2(ist_vpi,WK_VAL_USER,WK_VAL_DEFAULT) user_def
      from (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id join wk_cc3 t3 on t2.cc2_id = t3.cc2_id) 
            left join  wk_personal tp on t3.cc3_id = tp.wk_id and user_id = p_c_user_id
      where t1.cc1 = p_cc1 and t2.cc2 = p_cc2 
      order by cc3;
       
   v_tab t_cc3_tab;
   v_sum number;
   v_factor number;
   
begin
   open  c_cur(p_userid, p_cc1, p_cc2);
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   
  if p_calc_val = 1 then
  v_factor := calc_factor_cc2(p_userid,p_cc1,p_cc2);
  if v_factor is not null 
  then 
      for i in v_tab.first .. v_tab.last loop
         v_tab(i).val := v_tab(i).val * v_factor;
         v_tab(i).user_def := WK_VAL_NOT_EDITABLE;
      end loop; 
  else 
      for i in v_tab.first .. v_tab.last loop
          if v_tab(i).user_def = WK_VAL_DEFAULT then
              select sum(val) into v_sum 
              from table(fetch_warencode(p_userid,v_tab(i).cc1,v_tab(i).cc2,v_tab(i).cc3));
              v_tab(i).val := v_sum;
          end if;
      end loop;
  end if;
  end if;
  
  for i in v_tab.first .. v_tab.last loop
      pipe row(v_tab(i));
  end loop;
  return;
end fetch_cc3; 

/* -----------------------------------------------------------------------------
  function fetch_warencode 
--------------------------------------------------------------------------------*/

function fetch_warencode (p_userid in number, p_cc1  in number, p_cc2 in number, p_cc3 in number, p_calc_val in number := 1) 
return t_warencode_tab pipelined 
is
   cursor c_cur(p_c_user_id number, p_c_cc1 number, p_c_cc2 number, p_c_cc3 number) is
      select cc1, cc2, cc3, twc.wc_id, warencode, wc_bezeichnung, wc_vpi,  coalesce(ist_vpi,wc_vpi) val, nvl2(ist_vpi,WK_VAL_USER,WK_VAL_DEFAULT) user_def
      from (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id join wk_cc3 t3 on t2.cc2_id = t3.cc2_id join wk_warencode twc on t3.cc3_id = twc.cc3_id) 
            left join  wk_personal tp on twc.wc_id = tp.wk_id and user_id = p_c_user_id
      where t1.cc1 = p_cc1 and t2.cc2 = p_cc2 and t3.cc3 = p_cc3
      order by warencode;
      
   v_tab t_warencode_tab;
   v_sum number;
   v_factor number;
   
begin
   open  c_cur(p_userid, p_cc1, p_cc2, p_cc3);
   fetch c_cur bulk collect into v_tab;
   close c_cur;
 
 if v_tab.count = 0 then return; end if;
 
  if p_calc_val = 1 then
  v_factor := calc_factor_cc3(p_userid, p_cc1, p_cc2, p_cc3);
  if v_factor is not null 
  then 
      for i in v_tab.first .. v_tab.last loop
         v_tab(i).val := v_tab(i).val * v_factor;
         v_tab(i).user_def := WK_VAL_NOT_EDITABLE;
      end loop; 
  end if;
  end if;
  
  for i in v_tab.first .. v_tab.last loop
      pipe row(v_tab(i));
  end loop;
  return;
end fetch_warencode; 

--------------------------------------------------------------------------------
function fetch_alle_waren (p_userid in number) return t_warencode_tab pipelined
is
v_tab_cc1 t_cc1_tab;
v_tab_cc2 t_cc2_tab;
v_tab_cc3 t_cc3_tab;
v_tab_waren t_warencode_tab;
v_rec_waren t_warencode_rec;
v_sum_pvpi number := 0;
v_sum_ges number := 0;

begin
   select * bulk collect into v_tab_cc1 from table(fetch_cc1(p_userid,0));  
   for i_cc1 in  v_tab_cc1.first .. v_tab_cc1.last - 1 loop    
     select * bulk collect into v_tab_cc2 
     from table(fetch_cc2(p_userid,v_tab_cc1(i_cc1).cc1,0));    
     for i_cc2 in  v_tab_cc2.first ..  v_tab_cc2.last loop       
       select * bulk collect into v_tab_cc3 
       from table(fetch_cc3(p_userid,v_tab_cc2(i_cc2).cc1, v_tab_cc2(i_cc2).cc2,0));     
       for i_cc3 in  v_tab_cc3.first .. v_tab_cc3.last loop          
          select * bulk collect into v_tab_waren 
          from table(fetch_warencode(p_userid,v_tab_cc3(i_cc3).cc1, v_tab_cc3(i_cc3).cc2,  v_tab_cc3(i_cc3).cc3,1));          
          if v_tab_waren.count > 0 then
             for i_waren in  v_tab_waren.first .. v_tab_waren.last loop
               v_sum_pvpi := v_sum_pvpi + v_tab_waren(i_waren).val;
               v_sum_ges := v_sum_ges + v_tab_waren(i_waren).wc_vpi;
               pipe row(v_tab_waren(i_waren));
             end loop;          
          end if;        
       end loop;      
     end loop;
    end loop;
  
    v_rec_waren.cc1 := 99;
    v_rec_waren.cc2 := 0;
    v_rec_waren.cc3 := 0;
    v_rec_waren.warencode := 0;
    v_rec_waren.wc_vpi := 0;
    --v_rec_waren.val := v_tab_cc1(v_tab_cc1.last).val;
    v_rec_waren.val := v_sum_ges - v_sum_pvpi;
    v_rec_waren.wc_id := -1;
    v_rec_waren.wc_bezeichnung := 'Sonstiges';
    v_rec_waren.user_def := WK_VAL_DIFF_ROW;
    pipe row(v_rec_waren);
    
    return;
    
end fetch_alle_waren;

/* -----------------------------------------------------------------------------
  procedure ins_or_upd_ccX
--------------------------------------------------------------------------------*/

procedure ins_or_upd_cc1(p_userid in number, p_cc1 in number, p_val in number)
is
  v_wk_id number;
  v_tab t_pers_val_tab;
begin
  select * bulk collect into v_tab from table(has_pers_val_cc1(p_userid, p_cc1));
  if v_tab.count > 0 then
     for i in v_tab.first .. v_tab.last loop
       delete from wk_personal where user_id = p_userid and wp_id =  v_tab(i).wp_id;
     end loop; 
  end if;
  
  select cc1_id into v_wk_id from wk_cc1 where cc1 = p_cc1;
  update wk_personal set ist_vpi = p_val where user_id = p_userid and wk_id = v_wk_id;
  if sql%rowcount = 0 then
     insert into wk_personal (user_id, wk_id, ist_vpi) values (p_userid, v_wk_id, p_val);
  end if;
end ins_or_upd_cc1;

--------------------------------------------------------------------------------

procedure ins_or_upd_cc2(p_userid in number, p_cc1 in number, p_cc2 in number, p_val in number) 
is
  v_wk_id number;
  v_tab t_pers_val_tab;
begin 
 
  select * bulk collect into v_tab from table(has_pers_val_cc2(p_userid, p_cc1, p_cc2));
  if v_tab.count > 0 then
     for i in v_tab.first .. v_tab.last loop
       delete from wk_personal where user_id = p_userid and wp_id =  v_tab(i).wp_id;
     end loop; 
  end if;

  select t2.cc2_id into v_wk_id 
  from wk_cc1 t1, wk_cc2 t2 
  where t1.cc1_id = t2.cc1_id and 
        t1.cc1 = p_cc1 and t2.cc2 = p_cc2; 
  update wk_personal set ist_vpi = p_val where user_id = p_userid and  wk_id = v_wk_id;
  if sql%rowcount = 0 then 
     insert into wk_personal (user_id, wk_id, ist_vpi) values (p_userid, v_wk_id, p_val);
  end if;
end ins_or_upd_cc2;

--------------------------------------------------------------------------------

procedure ins_or_upd_cc3(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number, p_val in number)
is
  v_wk_id number;
  v_tab t_pers_val_tab;
begin 

   select * bulk collect into v_tab from table(has_pers_val_cc3(p_userid, p_cc1, p_cc2,p_cc3));
   if v_tab.count > 0 then
     for i in v_tab.first .. v_tab.last loop
       delete from wk_personal where user_id = p_userid and wp_id =  v_tab(i).wp_id;
     end loop; 
   end if;

  select t3.cc3_id into v_wk_id 
  from wk_cc1 t1, wk_cc2 t2, wk_cc3 t3
  where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id and 
        t1.cc1 = p_cc1 and t2.cc2 = p_cc2 and t3.cc3 = p_cc3; 
  update wk_personal set ist_vpi = p_val where user_id = p_userid and  wk_id = v_wk_id;
  if sql%rowcount = 0 then 
     insert into wk_personal (user_id, wk_id, ist_vpi) values (p_userid, v_wk_id, p_val);
  end if;
end ins_or_upd_cc3;

--------------------------------------------------------------------------------

procedure ins_or_upd_warencode(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number, p_warencode in number, p_val in number)
is 
  v_wk_id number;
begin 
  select twc.wc_id into v_wk_id 
  from wk_cc1 t1, wk_cc2 t2, wk_cc3 t3, wk_warencode twc
  where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id and t3.cc3_id = twc.cc3_id and
        t1.cc1 = p_cc1 and t2.cc2 = p_cc2 and t3.cc3 = p_cc3 and twc.warencode = p_warencode; 
  update wk_personal set ist_vpi = p_val where user_id = p_userid and  wk_id = v_wk_id;
  if sql%rowcount = 0 then 
     insert into wk_personal (user_id, wk_id, ist_vpi) values (p_userid, v_wk_id, p_val);
  end if;
end ins_or_upd_warencode;

--------------------------------------------------------------------------------

procedure ins_or_upd(p_userid in number, p_id in number, p_val in number)
is
begin
  update wk_personal set ist_vpi = p_val where user_id = p_userid and  wk_id = p_id;
  if sql%rowcount = 0 then 
     insert into wk_personal (user_id, wk_id, ist_vpi) values (p_userid, p_id, p_val);
  end if;
end ins_or_upd;

/* -----------------------------------------------------------------------------
  procedure del_ccX 
--------------------------------------------------------------------------------*/

procedure del_cc1(p_userid in number,p_cc1 in number)
is
begin
  delete from  wk_personal
  where user_id = p_userid and wk_id = (select cc1_id from wk_cc1 where cc1 = p_cc1);
end del_cc1;

--------------------------------------------------------------------------------

procedure del_cc2(p_userid in number, p_cc1 in number, p_cc2 in number) 
is
begin
  delete from  wk_personal
  where user_id = p_userid and 
        wk_id = (select t2.cc2_id from wk_cc1 t1, wk_cc2 t2 
                 where t1.cc1_id = t2.cc1_id and t1.cc1 = p_cc1 and t2.cc2 = p_cc2);
end del_cc2;

--------------------------------------------------------------------------------

procedure del_cc3(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number)
is
begin
  delete from  wk_personal
  where user_id = p_userid and 
        wk_id = (select t3.cc3_id from wk_cc1 t1, wk_cc2 t2, wk_cc3 t3
                 where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id and 
                       t1.cc1 = p_cc1 and t2.cc2 = p_cc2 and t3.cc3 = p_cc3);
end del_cc3;

--------------------------------------------------------------------------------
procedure del_warencode(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number, p_warencode in number)
is 
  v_wk_id number;
begin 
  select twc.wc_id into v_wk_id 
  from wk_cc1 t1, wk_cc2 t2, wk_cc3 t3, wk_warencode twc
  where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id and t3.cc3_id = twc.cc3_id and
        t1.cc1 = p_cc1 and t2.cc2 = p_cc2 and t3.cc3 = p_cc3 and twc.warencode = p_warencode; 
  delete from  wk_personal
  where user_id = p_userid and  wk_id = v_wk_id;
end del_warencode;

--------------------------------------------------------------------------------

procedure del(p_userid in number, p_id in number)
is
begin 
  delete from  wk_personal
  where user_id = p_userid and  wk_id = p_id;
end del;

/* -----------------------------------------------------------------------------
  function  calc_factor_X 
--------------------------------------------------------------------------------*/

function calc_factor_cc1(p_userid in number, p_cc1 in number)
return number
is
  cursor c_val(p_c_user_id number, p_c_cc1 number) is
      select ist_vpi from wk_cc1 t1, wk_personal tp
      where t1.cc1_id = tp.wk_id and 
            user_id = p_c_user_id and cc1 = p_c_cc1;
 
 v_user_val_found boolean;
 v_sum number;
 v_user_val number;
begin
   open c_val(p_userid, p_cc1);
   fetch c_val into v_user_val;
   if c_val%notfound 
    then  v_user_val_found := false;
    else v_user_val_found := true;
   end if;
   close c_val;
   if v_user_val_found then
      select nvl(sum(cc2_vpi),0) into v_sum from wk_cc1 t1, wk_cc2 t2
      where t1.cc1_id  = t2.cc1_id and cc1 = p_cc1;
      if v_sum != 0 
        then return v_user_val / v_sum;
        else return 0; -- ?
      end if;
   end if;
   return null;
   
end calc_factor_cc1;

--------------------------------------------------------------------------------

function calc_factor_cc2(p_userid in number, p_cc1 in number, p_cc2 in number) 
return number
is
  cursor c_val(p_c_user_id number, p_c_cc1 number, p_c_cc2 number) is
    select ist_vpi from wk_cc1 t1,wk_cc2 t2, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = tp.wk_id and 
          user_id = p_c_user_id and cc1 = p_c_cc1 and cc2 = p_c_cc2;
          
 v_user_val_found boolean;
 v_sum number;
 v_user_val number;
 
begin
   open c_val(p_userid, p_cc1,p_cc2);
   fetch c_val into v_user_val;
   if c_val%notfound 
    then  v_user_val_found := false;
    else v_user_val_found := true;
   end if;
   close c_val;
   if v_user_val_found then
      select nvl(sum(cc3_vpi),0) into v_sum from wk_cc1 t1, wk_cc2 t2, wk_cc3 t3
      where t1.cc1_id  = t2.cc1_id and t2.cc2_id  = t3.cc2_id  and cc1 = p_cc1 and cc2 = p_cc2;
      if v_sum != 0 
        then return v_user_val / v_sum;
        else return 0; -- ?
      end if;
   else 
      return calc_factor_cc1(p_userid, p_cc1);
   end if;
end calc_factor_cc2; 

--------------------------------------------------------------------------------

function calc_factor_cc3(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number) 
return number
is
  cursor c_val(p_c_user_id number, p_c_cc1 number, p_c_cc2 number, p_c_cc3 number) is
    select ist_vpi from wk_cc1 t1,wk_cc2 t2, wk_cc3 t3, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id and t3.cc3_id = tp.wk_id and 
          user_id = p_c_user_id and cc1 = p_c_cc1 and cc2 = p_c_cc2 and cc3 = p_c_cc3;
          
 v_user_val_found boolean;
 v_sum number;
 v_user_val number;
 
begin
   open c_val(p_userid, p_cc1, p_cc2, p_cc3);
   fetch c_val into v_user_val;
   if c_val%notfound 
    then  v_user_val_found := false;
    else v_user_val_found := true;
   end if;
   close c_val;
   if v_user_val_found then
      select nvl(sum(wc_vpi),0) into v_sum from wk_cc1 t1, wk_cc2 t2, wk_cc3 t3, wk_warencode twc
      where t1.cc1_id  = t2.cc1_id and t2.cc2_id  = t3.cc2_id and t3.cc3_id = twc.cc3_id and 
            cc1 = p_cc1 and cc2 = p_cc2 and cc3 = p_cc3;
      if v_sum != 0 
        then return v_user_val / v_sum;
        else return 0; -- ?
      end if;
   else 
      return calc_factor_cc2(p_userid, p_cc1, p_cc2);
   end if;
end calc_factor_cc3;

/*--------------------------------------------------------------------------------
  function has_pers_val_X
--------------------------------------------------------------------------------*/

function has_pers_val(p_userid in number) 
return t_pers_val_tab pipelined
is
  cursor c_cur is
    select cc1, null cc2, null cc3, null warencode , cc1_bezeichnung bez, wp_id, ist_vpi, 'cc1' wk_level from wk_cc1 t1, wk_personal tp
    where t1.cc1_id = tp.wk_id
          and user_id = p_userid
    union
    select cc1, cc2, null cc3, null warencode , cc2_bezeichnung bez, wp_id, ist_vpi, 'cc2' wk_level from wk_cc1 t1 , wk_cc2 t2, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = tp.wk_id
          and user_id = p_userid 
    union     
    select cc1, cc2, cc3, null warencode , cc3_bezeichnung bez, wp_id, ist_vpi, 'cc3' from wk_cc1 t1 , wk_cc2 t2, wk_cc3 t3, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id  and t3.cc3_id = tp.wk_id
          and user_id = p_userid 
    union      
    select cc1, cc2, cc3, warencode , wc_bezeichnung bez, wp_id, ist_vpi, 'warencode' from wk_cc1 t1 , wk_cc2 t2, wk_cc3 t3, wk_warencode twc, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id  and t3.cc3_id = twc.cc3_id and twc.wc_id = tp.wk_id
          and user_id = p_userid
    order by cc1, cc2, cc2, warencode;

v_tab t_pers_val_tab;
begin
   open c_cur;
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   if v_tab.count > 0 then
      for i in v_tab.first .. v_tab.last loop
         pipe row(v_tab(i));
      end loop;
   end if;
   return;
end has_pers_val;

--------------------------------------------------------------------------------

function has_pers_val_cc1(p_userid in number, p_cc1 in number) 
return t_pers_val_tab pipelined
is
  cursor c_cur is
    select cc1, cc2, null cc3, null warencode , cc2_bezeichnung bez, wp_id, ist_vpi, 'cc2' wk_level from wk_cc1 t1 , wk_cc2 t2, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = tp.wk_id
          and user_id = p_userid and  t1.cc1 = p_cc1 
    union     
    select cc1, cc2, cc3, null warencode , cc3_bezeichnung bez, wp_id, ist_vpi, 'cc3' from wk_cc1 t1 , wk_cc2 t2, wk_cc3 t3, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id  and t3.cc3_id = tp.wk_id
          and user_id = p_userid and t1.cc1 = p_cc1 
    union      
    select cc1, cc2, cc3, warencode , wc_bezeichnung bez, wp_id, ist_vpi, 'warencode' from wk_cc1 t1 , wk_cc2 t2, wk_cc3 t3, wk_warencode twc, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id  and t3.cc3_id = twc.cc3_id and twc.wc_id = tp.wk_id
          and user_id = p_userid and  t1.cc1 = p_cc1
    order by cc1, cc2, cc2, warencode;

v_tab t_pers_val_tab;
begin
   open c_cur;
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   if v_tab.count > 0 then
      for i in v_tab.first .. v_tab.last loop
         pipe row(v_tab(i));
      end loop;
   end if;
   return;
end has_pers_val_cc1;

--------------------------------------------------------------------------------

function has_pers_val_cc2(p_userid in number, p_cc1 in number, p_cc2 in number) 
return t_pers_val_tab pipelined 
is
  cursor c_cur is
    select cc1, cc2, cc3, null warencode , cc3_bezeichnung bez, wp_id, ist_vpi, 'cc3' wk_level from wk_cc1 t1 , wk_cc2 t2, wk_cc3 t3, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id  and t3.cc3_id = tp.wk_id
          and user_id = p_userid and t1.cc1 = p_cc1 and t2.cc2 = p_cc2
    union      
    select cc1, cc2, null cc3, warencode , wc_bezeichnung bez, wp_id, ist_vpi, 'warencode' from wk_cc1 t1 , wk_cc2 t2, wk_cc3 t3, wk_warencode twc, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id  and t3.cc3_id = twc.cc3_id and twc.wc_id = tp.wk_id
          and user_id = p_userid and  t1.cc1 = p_cc1 and t2.cc2 = p_cc2
     order by cc1, cc2, cc2, warencode;

v_tab t_pers_val_tab;
begin
   open c_cur;
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   if v_tab.count > 0 then
      for i in v_tab.first .. v_tab.last loop
         pipe row(v_tab(i));
      end loop;
   end if;
   return;
end has_pers_val_cc2;

--------------------------------------------------------------------------------

function has_pers_val_cc3(p_userid in number, p_cc1 in number, p_cc2 in number, p_cc3 in number) 
return t_pers_val_tab pipelined
is
  cursor c_cur is
    select cc1, cc2, cc3, warencode , wc_bezeichnung bez, wp_id, ist_vpi, 'warencode' wk_level from wk_cc1 t1 , wk_cc2 t2, wk_cc3 t3, wk_warencode twc, wk_personal tp
    where t1.cc1_id = t2.cc1_id and t2.cc2_id = t3.cc2_id  and t3.cc3_id = twc.cc3_id and twc.wc_id = tp.wk_id
          and user_id = p_userid and  t1.cc1 = p_cc1 and t2.cc2 = p_cc2 and t3.cc3 = p_cc3
     order by cc1, cc2, cc2, warencode;

v_tab t_pers_val_tab;
begin
   open c_cur;
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   if v_tab.count > 0 then
      for i in v_tab.first .. v_tab.last loop
         pipe row(v_tab(i));
      end loop;
   end if;
   return;
end has_pers_val_cc3;

--------------------------------------------------------------------------------

end wk_pkg;

/
