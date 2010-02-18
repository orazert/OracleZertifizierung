<?php

// application/models/CC12php

class Default_Model_CC2
{
    
	public function fetchAll($userId,$cc1)
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( "-> Default_Model_CC2->fetchAll() - userId = $userId cc1 = $cc1");
	
	/*
	 $sql = 'select cc1, cc2, cc2_bezeichnung, cc2_vpi, cc2_hvpi ' .
           'from wk_cc1 t1, wk_cc2 t2 ' .
           "where t1.cc1_id = t2.cc1_id and cc1 = $cc1 "  .
           'order by cc1, cc2';
	*/
	/*
     $sql = 'with pers_wk as ' .
       '(select t2.cc2_id, tp.ist_vpi ' .
       'from  (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id) left join wk_personal tp on t2.cc2_id = tp.wk_id ' .
       "where tp.user_id = $userId) " .
       'select cc1, cc2, cc2_bezeichnung, cc2_vpi, coalesce(tp.ist_vpi,cc2_vpi) val, nvl2(ist_vpi,1,0) user_def ' .
       'from (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id) left join pers_wk tp on t2.cc2_id = tp.cc2_id ' .
        "where t1.cc1 = $cc1 order by cc1, cc2";
 */
    $sql = 
      'select cc1, cc2, cc2_bezeichnung, cc2_vpi, coalesce(ist_vpi,cc2_vpi) val, nvl2(ist_vpi,1,0) user_def '.
      "from (wk_cc1 t1 join wk_cc2 t2 on t1.cc1_id = t2.cc1_id) left join wk_personal tp on t2.cc2_id = tp.wk_id and user_id = $userId " .
      "where t1.cc1 = $cc1 " .
      'order by cc1, cc2';
	 
 
       $logger->debug( ' sql = ' . $sql);
	   
	   $db = Zend_Registry::Get('db');
	   $result = $db->fetchAll($sql);
		
	   $logger->debug( ' result ' . var_export($result,true));
	   $logger->info( '<- Default_Model_CC2->fetchAll()');
	   return $result;
	}
}
