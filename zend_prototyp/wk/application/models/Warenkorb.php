<?php

// application/models/CC1.php

class Default_Model_Warenkorb
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
	public function fetchAll($user_id)
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Default_Model_Warenkorb->fetch()');
	   
	   $db = Zend_Registry::Get('db');
									
		 $sql =	  'select a.*, nvl(p.ist_vpi,0) ist_vpi, nvl2(p.ist_vpi,1,0) user_def '.
              'from'. 
              '('.
              'select	u.user_id user_id, w.*	from wk_cc1 w, wk_user u '.
              "where u.user_id=$user_id ".
               ')  a, wk_personal p '.
               'where a.cc1_id=p.wk_id(+) and a.user_id=p.user_id(+) '.
               'order by a.user_id, cc1_id, cc1';
               
      		/* $sql =	  'select a.*, coalesce(p.ist_vpi,a.cc1_vpi) ist_vpi, nvl2(ist_vpi,1,0) user_def '.
              'from'. 
              '('.
              'select	u.user_id user_id, w.*	from wk_cc1 w, wk_user u '.
              "where u.user_id=$user_id ".
               ')  a, wk_personal p '.
               'where a.cc1_id=p.wk_id(+) and a.user_id=p.user_id(+) '.
               'order by a.user_id, cc1_id, cc1';  */       
$logger->debug( $sql );
	   $db = Zend_Registry::Get('db');
	   $result = $db->fetchAll($sql);
		
	   $logger->debug( ' result ' . var_export($result,true));
	   $logger->info( '<- Default_Model_Warencode->fetchall()');
	   return $result;
	}
	
	
		public function fetchcc2All($cc1)
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Default_Model_CC2->fetchAll()');
	   
	   $db = Zend_Registry::Get('db');
		
	 $sql = 'select cc1, cc2, cc2_bezeichnung, cc2_vpi, cc2_hvpi ' .
           'from wk_cc1 t1, wk_cc2 t2 ' .
           "where t1.cc1_id = t2.cc1_id and cc1 = $cc1 "  .
           'order by cc1, cc2';
		   
       $logger->debug( ' SQL ' . $sql);
	   
	   $db = Zend_Registry::Get('db');
	   $result = $db->fetchAll($sql);
		
	   $logger->debug( ' result ' . var_export($result,true));
	   $logger->info( '<- Default_Model_CC1->fetc_cc1()');
	   return $result;
	}
	
		public function fetchcc3All($cc1, $cc2)
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Default_Model_CC3->fetchAll()');
	   
	   $db = Zend_Registry::Get('db');
		
	 $sql = 'select cc1, cc2, cc3, cc3_bezeichnung, cc3_vpi, cc3_hvpi ' .
           'from wk_cc3 t3, wk_cc2 t2, wk_cc1 t1 ' .
           'where t3.cc2_id = t2.cc2_id and t2.cc1_id=t1.cc1_id ' .
           "and cc1=$cc1 and cc2 = $cc2 "  .
           'order by cc1, cc2, cc3';
		   
       $logger->debug( ' SQL ' . $sql);
	   
	   $db = Zend_Registry::Get('db');
	   $result = $db->fetchAll($sql);
	
		
	   $logger->debug( ' result ' . var_export($result,true));
	   $logger->info( '<- Default_Model_CC1->fetc_cc1()');
	   return $result;
	}
	
	
		public function fetchSingle($uid, $wkid)
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Default_Model_Warenkorb->fetch()');
	   
	   $db = Zend_Registry::Get('db');
									
		 $sql =	  'select wp_id, user_id, wk_id, ist_vpi from wk_personal '.
		 					"where user_id=$uid and wk_id=$wkid and rownum<=1";
$logger->info( $sql );
	   $db = Zend_Registry::Get('db');
	   $result = $db->fetchAll($sql);
		 if (empty($result)) {
			 		 $result = array(array(
		 						'USER_ID' => $uid,
		 						'WK_ID'=> $wkid,
		 						'IST_VPI' => 0
		 						));
		 }
		 						
	   $logger->debug( ' result @@@' . var_export($result,true));
	   $logger->info( '<- Default_Model_Warencode->fetchall()');
	   return $result;
	}
	
}
