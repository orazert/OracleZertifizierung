<?php

// application/models/CC1.php

class Default_Model_CC1
{
    
	public function calc($tab)
	{
	  $logger = Zend_Registry::get('logger');
	  $logger->info( '-> Default_Model_CC1->calc()');
	  
	  $sum = 0.0;
	  $sumUser = 0.0;
	  
	  foreach ($tab as $row) {
	      $val = str_replace(',','.',$row['VAL']);
	      if ($row['USER_DEF'] == 1 ) {
	          $sumUser += $val ;
	      } else {
	         $sum += $val;
	      }
	   }
	   
	   $gesamtSumme = $sumUser + $sum;
	   $logger->debug("Default_Model_CC1->calc() sumUser = $sumUser, sum = $sum, gesamtSumme = $gesamtSumme");
	   
	   $diff = 100.0 - $sumUser;
	   $factor = $diff / $sum;
	   
	   $logger->debug("Default_Model_CC1->calc()  factor = $factor");
	   
	   $res = array();
	   
	   $sumUser = 0.0;
	   $sum = 0.0;
	   
	   foreach ($tab as $key => $row) {
	      $val = str_replace(',','.',$row['VAL']);
		  $logger->debug(" val = $val");
	      $logger->debug( '  Default_Model_CC1->calc() userDef / val = ' . $row['USER_DEF'] . '/ '. $row['VAL'] . '/ ' . $val );
	      $row['CC1_VPI'] =  str_replace('.',',',sprintf('%7.4F',str_replace(',','.',$row['CC1_VPI'])));
		  if ($row['USER_DEF'] == 1 ) {
	         $sumUser += $val ;
			 $row['VAL'] = str_replace('.',',',sprintf('%7.4F',$val));
			 $res[$key] = $row;
	      }  else {
	        $val = str_replace(',','.',$row['VAL']);
	        $newVal = $val * $factor;
			$sum += $newVal ;
			$row['VAL'] = str_replace('.',',',sprintf('%7.4F',$newVal));
			$res[$key] = $row;
	      }
	  }
	   $gesamtSumme = $sumUser + $sum;
	   $logger->debug("Default_Model_CC1->calc() sumUser = $sumUser, sum = $sum, gesamtSumme = $gesamtSumme");
	   $logger->info( '<- Default_Model_CC1->calc()');
       return $res;	   
	 }
	
	public function fetchAll($userId)
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Default_Model_CC1->fetch() - userId = ' . $userId);
	   
	
	   /*
	           $sql = 'select cc1, cc1_bezeichnung, cc1_vpi, cc1_hvpi from wk_cc1 order by cc1';//
	      */
	   
	   /*
	  $sql = 'with pers_wk as ' .
               '(select t1.cc1_id, t2.ist_vpi ' .
                'from wk_cc1 t1 left join wk_personal t2 on t1.cc1_id = t2.wk_id ' .
                 "where t2.user_id = $userId ) " .
              'select cc1, cc1_bezeichnung, cc1_vpi, coalesce(ist_vpi,cc1_vpi) val, nvl2(ist_vpi,1,0) user_def ' .
			  'from wk_cc1 t3 left join pers_wk t4 on t3.cc1_id = t4.cc1_id ' .
              'order by cc1';
	*/

       $sql =  
		  'select cc1, cc1_bezeichnung, cc1_vpi,  coalesce(ist_vpi,cc1_vpi) val, nvl2(ist_vpi,1,0) user_def '.
          "from wk_cc1 t1 left join wk_personal tp on t1.cc1_id = tp.wk_id and user_id = $userId " .
          'order by cc1';
	
	   $logger->debug( ' sql =  ' . $sql);
	   
	   $db = Zend_Registry::Get('db');
	   $result = $db->fetchAll($sql);
	   $result = $this->calc($result);
	   
		
	   $logger->debug( ' result ' . var_export($result,true));
	   $logger->info( '<- Default_Model_CC1->fetc_cc1()');
	   return $result;
	}
}
