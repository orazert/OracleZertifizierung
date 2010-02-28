CREATE OR REPLACE package ls_wk_pkg as

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

-- fetch_X
function fetch_cc1 (p_userid in number, p_sum_vpi in number := null) return t_cc1_tab pipelined;
function fetch_cc2 (p_userid in number, p_cc1  in number, p_sum_vpi in number := null) return t_cc2_tab pipelined;
function fetch_cc3 (p_userid in number, p_cc1  in number, p_cc2 in number, p_sum_vpi in number := null) return t_cc3_tab pipelined;
function fetch_warencode (p_userid in number, p_cc1  in number, p_cc2 in number, p_cc3 in number, p_sum_vpi in number := null) return t_warencode_tab pipelined;
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


end ls_wk_pkg;

/


CREATE OR REPLACE package body ls_wk_pkg as

/* -----------------------------------------------------------------------------
  function fetch_cc1 
--------------------------------------------------------------------------------*/

function fetch_cc1 (p_userid in number, p_sum_vpi in number := null) 
return t_cc1_tab pipelined is
  
    cursor c_cur(p_c_user_id number) is
       select cc1, cc1_bezeichnung, cc1_vpi,  coalesce(ist_vpi,cc1_vpi) val, nvl2(ist_vpi,1,0) user_def
       from wk_cc1 t1 left join wk_personal tp on t1.cc1_id = tp.wk_id and user_id = p_c_user_id
       order by cc1;
  
   v_tab t_cc1_tab;
   v_sum number := 0;
   v_user_sum number := 0;
   v_faktor number := 1.0;
   v_sum_vpi number := 0.0;
  
begin
   open  c_cur(p_userid);
   fetch c_cur bulk collect into v_tab;
   close c_cur;
  
   for i in v_tab.first .. v_tab.last loop
       if v_tab(i).user_def > 0 
       then v_user_sum := v_user_sum + v_tab(i).val;
       else v_sum := v_sum + v_tab(i).val;
       end if;
       v_sum_vpi :=  v_sum_vpi +  v_tab(i).cc1_vpi;
   end loop;
   
   if p_sum_vpi is not null then
     v_sum_vpi :=  p_sum_vpi;
   end if;
  
   if v_user_sum > v_sum_vpi then
      -- alle werte skalieren
      v_faktor := v_sum_vpi / (v_sum + v_user_sum);
      for i in v_tab.first .. v_tab.last loop
           v_tab(i).val := v_tab(i).val * v_faktor;
           if v_tab(i).user_def = 1 then  v_tab(i).user_def := 2; end if;
           pipe row(v_tab(i));
       end loop;
   else 
       -- nur die vom user nicht geaenderten Werte skalieren
       if v_sum != 0 then 
          -- v_faktor := (100.0 - v_user_sum) / v_sum;
          v_faktor := (v_sum_vpi - v_user_sum) / v_sum;
       end if;       
       for i in v_tab.first .. v_tab.last loop
          if v_tab(i).user_def = 0 then
               v_tab(i).val := v_tab(i).val * v_faktor;
          end if;
          pipe row(v_tab(i));
       end loop;
   end if;
   return;
 end fetch_cc1;
 
/* -----------------------------------------------------------------------------
  function fetch_cc2 
--------------------------------------------------------------------------------*/

function fetch_cc2 (p_userid in number, p_cc1  in number, p_sum_vpi in number := null) 
return t_cc2_tab pipelined is

   cursor c_cur(p_c_user_id number, p_c_cc1 number) is
       select cc1, cc2, cc2_bezeichnung, cc2_vpi,  coalesce(ist_vpi,cc2_vpi) val, nvl2(ist_vpi,1,0) user_def
       from (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id ) left join  wk_personal tp on t2.cc2_id = tp.wk_id and user_id = p_c_user_id
       where t1.cc1 = p_cc1 
       order by cc2;
      
   v_tab t_cc2_tab;
   v_sum number := 0;
   v_user_sum number := 0;
   v_faktor number := 1.0;
   v_sum_vpi number;
  
begin
   open  c_cur(p_userid, p_cc1);
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   
   if p_sum_vpi is null then 
       select val into v_sum_vpi from table(fetch_cc1(p_userid)) where cc1 = p_cc1;
   else 
      v_sum_vpi := p_sum_vpi;
   end if;
  
   for i in v_tab.first .. v_tab.last loop
       if v_tab(i).user_def > 0 
       then v_user_sum := v_user_sum + v_tab(i).val;
       else v_sum := v_sum + v_tab(i).val;
       end if;
   end loop;

   if v_user_sum > v_sum_vpi then
      -- alle werte skalieren
      v_faktor := v_sum_vpi / (v_sum + v_user_sum);
      for i in v_tab.first .. v_tab.last loop
           v_tab(i).val := v_tab(i).val * v_faktor;
           if v_tab(i).user_def = 1 then  v_tab(i).user_def := 2;  end if;
           pipe row(v_tab(i));
       end loop;
   else 
       if v_sum != 0 then 
          v_faktor := (v_sum_vpi - v_user_sum) / v_sum;
       end if;
       for i in v_tab.first .. v_tab.last loop
           if v_tab(i).user_def = 0 then
               v_tab(i).val := v_tab(i).val * v_faktor;
           end if;
           pipe row(v_tab(i));
       end loop;
   end if;
   return;
end fetch_cc2;

/* -----------------------------------------------------------------------------
  function fetch_cc3 
--------------------------------------------------------------------------------*/

function fetch_cc3 (p_userid in number, p_cc1  in number, p_cc2 in number, p_sum_vpi in number := null) 
return t_cc3_tab pipelined is 

   cursor c_cur(p_c_user_id number, p_c_cc1 number, p_c_cc2 number) is
      select cc1, cc2, cc3, cc3_bezeichnung, cc3_vpi,  coalesce(ist_vpi,cc3_vpi) val, nvl2(ist_vpi,1,0) user_def
      from (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id join wk_cc3 t3 on t2.cc2_id = t3.cc2_id) 
            left join  wk_personal tp on t3.cc3_id = tp.wk_id and user_id = p_c_user_id
      where t1.cc1 = p_cc1 and t2.cc2 = p_cc2 
      order by cc3;
      
   v_tab t_cc3_tab;
   v_sum number := 0;
   v_user_sum number := 0;
   v_faktor number := 1.0;
   v_sum_vpi number;
  
begin
   open  c_cur(p_userid, p_cc1, p_cc2);
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   
   if  p_sum_vpi is null then
      select val into v_sum_vpi from table(fetch_cc2(p_userid,p_cc1)) where cc1 = p_cc1 and cc2 = p_cc2;
  else 
      v_sum_vpi := p_sum_vpi;
  end if;
  
   for i in v_tab.first .. v_tab.last loop
       if v_tab(i).user_def > 0 
           then v_user_sum := v_user_sum + v_tab(i).val;
           else v_sum := v_sum + v_tab(i).val;
       end if;
   end loop;

   if v_user_sum > v_sum_vpi then
      -- alle werte skalieren
      v_faktor := v_sum_vpi / (v_sum + v_user_sum);
      for i in v_tab.first .. v_tab.last loop
           v_tab(i).val := v_tab(i).val * v_faktor;
           if v_tab(i).user_def = 1 then  v_tab(i).user_def := 2;  end if;
           pipe row(v_tab(i));
       end loop;
   else 
      if v_sum != 0 then 
          v_faktor := (v_sum_vpi - v_user_sum) / v_sum;
      end if;
      for i in v_tab.first .. v_tab.last loop
          if v_tab(i).user_def = 0 then
              v_tab(i).val := v_tab(i).val * v_faktor;
           end if;
       pipe row(v_tab(i));
       end loop;
   end if; 
   return;
end fetch_cc3;

/* -----------------------------------------------------------------------------
  function fetch_warencode 
--------------------------------------------------------------------------------*/

function fetch_warencode (p_userid in number, p_cc1  in number, p_cc2 in number, p_cc3 in number, p_sum_vpi in number := null) 
return t_warencode_tab pipelined is

   cursor c_cur(p_c_user_id number, p_c_cc1 number, p_c_cc2 number, p_c_cc3 number) is
      select cc1, cc2, cc3, twc.wc_id, warencode, wc_bezeichnung, wc_vpi,  coalesce(ist_vpi,wc_vpi) val, nvl2(ist_vpi,1,0) user_def
      from (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id join wk_cc3 t3 on t2.cc2_id = t3.cc2_id join wk_warencode twc on t3.cc3_id = twc.cc3_id) 
            left join  wk_personal tp on twc.wc_id = tp.wk_id and user_id = p_c_user_id
      where t1.cc1 = p_cc1 and t2.cc2 = p_cc2 and t3.cc3 = p_cc3
      order by warencode;
      
   v_tab t_warencode_tab;
   v_sum number := 0;
   v_user_sum number := 0;
   v_faktor number := 1.0;
   v_sum_vpi number;
  
begin
   open  c_cur(p_userid, p_cc1, p_cc2, p_cc3);
   fetch c_cur bulk collect into v_tab;
   close c_cur;
   
   if v_tab.count = 0 then return; end if;
   
   if  p_sum_vpi is null then
      select val into v_sum_vpi from table(fetch_cc3(p_userid,p_cc1,p_cc2)) 
      where cc1 = p_cc1 and cc2 = p_cc2 and cc3 = p_cc3;
  else 
     v_sum_vpi := p_sum_vpi;
  end if;
   
  for i in v_tab.first .. v_tab.last loop
       if v_tab(i).user_def > 0 
           then v_user_sum := v_user_sum + v_tab(i).val;
           else v_sum := v_sum + v_tab(i).val;
       end if;
   end loop;

   if v_user_sum > v_sum_vpi then
      -- alle werte skalieren
      v_faktor := v_sum_vpi / (v_sum + v_user_sum);
      for i in v_tab.first .. v_tab.last loop
           v_tab(i).val := v_tab(i).val * v_faktor;
           if v_tab(i).user_def = 1 then  v_tab(i).user_def := 2;  end if;
           pipe row(v_tab(i));
       end loop;
   else 
       if v_sum != 0 then 
            v_faktor := (v_sum_vpi - v_user_sum) / v_sum;
       end if;
       for i in v_tab.first .. v_tab.last loop
           if v_tab(i).user_def = 0 then
               v_tab(i).val := v_tab(i).val * v_faktor;
           end if;
           pipe row(v_tab(i));
       end loop;
   end if;
   return;
end fetch_warencode;

--------------------------------------------------------------------------------
function fetch_alle_waren (p_userid in number) return t_warencode_tab pipelined
is
v_tab_cc1 t_cc1_tab;
v_tab_cc2 t_cc2_tab;
v_tab_cc3 t_cc3_tab;
v_tab_waren t_warencode_tab;

begin
   select * bulk collect into v_tab_cc1 from table(fetch_cc1(p_userid));
   
   for i_cc1 in  v_tab_cc1.first .. v_tab_cc1.last loop
   
     select * bulk collect into v_tab_cc2 
     from table(fetch_cc2(p_userid,v_tab_cc1(i_cc1).cc1,v_tab_cc1(i_cc1).val));
     for i_cc2 in  v_tab_cc2.first ..  v_tab_cc2.last loop 
       select * bulk collect into v_tab_cc3 
       from table(fetch_cc3(p_userid,v_tab_cc2(i_cc2).cc1, v_tab_cc2(i_cc2).cc2, v_tab_cc2(i_cc2).val));
       for i_cc3 in  v_tab_cc3.first .. v_tab_cc3.last loop 
          select * bulk collect into v_tab_waren 
          from table(fetch_warencode(p_userid,v_tab_cc3(i_cc3).cc1, v_tab_cc3(i_cc3).cc2,  v_tab_cc3(i_cc3).cc3,  v_tab_cc3(i_cc3).val));
          if v_tab_waren.count > 0 then
             for i_waren in  v_tab_waren.first .. v_tab_waren.last loop 
               pipe row(v_tab_waren(i_waren));
             end loop;
          end if;
       end loop;
     end loop;

    end loop;
    return;
    
end fetch_alle_waren;


/*

       for i_cc3 in  v_tab_cc3.first ..  v_tab_cc3.last loop 
         select * bulk collect into v_tab_waren from table(fetch_warencode(p_userid,v_tab_cc3(i_cc3).cc1, v_tab_cc3(i_cc3).cc2,v_tab_cc3(i_cc3).cc3));
        
         for i_waren in v_tab_waren.first .. v_tab_waren.last loop
            pipe row(v_tab_waren(i_waren));
         end loop;
       end loop;
     end loop;
 

*/


/* -----------------------------------------------------------------------------
  procedure ins_or_upd_ccX
--------------------------------------------------------------------------------*/

procedure ins_or_upd_cc1(p_userid in number, p_cc1 in number, p_val in number)
is
  v_wk_id number;
begin
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
begin  
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
begin 
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

--------------------------------------------------------------------------------
end ls_wk_pkg;






/
