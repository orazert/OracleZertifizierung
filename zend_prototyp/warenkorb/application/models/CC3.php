<?php

// application/models/CC3php

class Default_Model_CC3
{
    private $logger = null;
	private $db = null;
	private $pkg = null;
	
	function __construct()
	{
	   $this->logger = Zend_Registry::get('logger');
	   $this->db = Zend_Registry::get('db');
	   $this->pkg = Zend_Registry::get('pkg', $pkg);
	   $this->logger->debug( '-- Default_Model_CC3->__construct()');
	} // __construct
	
	public function fetchAll($userId, $cc1, $cc2)
	{
	   $this->logger->info( "-> Default_Model_CC3->fetchAll() - userId = $userId cc1 = $cc1 cc2 = $cc2" );	
       $sql = 'select cc1, cc2, cc3, cc3_bezeichnung, cc3_vpi, val, user_def  ' .
		       "from table($this->pkg.fetch_cc3(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2 ))" ;
       $this->logger->debug( ' sql = ' . $sql);
	   $result = $this->db->fetchAll($sql);
	   //$this->logger->debug( ' result ' . var_export($result,true));
	   $this->logger->info( '<- Default_Model_CC3->fetchAll()');
	   return $result;
	} // fetchAll
	
	public function insertOrUpdate($val, $userId, $cc1, $cc2, $cc3)
	{
	   $this->logger->info( "-> Default_Model_CC3->insertOrUpdate() - userId = $userId cc1 = $cc1 cc2 = $cc2 cc3 = $cc3 val = $val");
	   $val = str_replace(',','.',$val);
	   $sql = "call $this->pkg.ins_or_upd_cc3(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_cc3 => $cc3, p_val => $val)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->query($sql);
	   $this->logger->info( '-> Default_Model_CC3->insertOrUpdate()');
	   return $result;   
	} // insertOrUpdate
	
	public function delete($userId, $cc1, $cc2, $cc3)
	{
	   $this->logger->info( "-> Default_Model_CC3->delete() - userId = $userId cc1 = $cc1 cc2 = $cc2 cc3 = $cc3");
	   $sql = "call $this->pkg.del_cc3(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_cc3 => $cc3)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->query($sql);
	   $this->logger->info( '-> Default_Model_CC3->delete()'); 
	} // delete
		
	public function hasPersSubValues($userId,$cc1, $cc2, $cc3)
	{
	  $this->logger->info( "-> Default_Model_CC2->hasPersSubValues() - - userId = $userId cc1 = $cc1");
	  //$sql = "select count(*) result from table($this->pkg.has_pers_val_cc3(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_cc3 => $cc3))";
	  $sql = "select * from table($this->pkg.has_pers_val_cc3(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_cc3 => $cc3))";
	  $this->logger->debug( ' sql =  ' . $sql);
	  $result = $this->db->fetchAll($sql);
	  //$res = $result[0]['RESULT'];
	  //$this->logger->debug( " res = $result");
	  $this->logger->info( '-> Default_Model_CC2->hasPersSubValues()'); 
	  return $result;
	} // hasPersSubValues
	
	public function getDeltaSubVal($userId,$cc1,$cc2,$cc3)
	{
	  $this->logger->info( "-> Default_Model_CC3->getDeltaSubVal() - userId = $userId");
	  $sql = "select nvl(sum(ist_vpi-def_val),0) deltaval " . 
	         "from table($this->pkg.has_pers_val_cc3(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_cc3 => $cc3))";
	  $this->logger->debug( ' sql =  ' . $sql);
	  $result = $this->db->fetchAll($sql);
	  $deltaVal = $result[0]['DELTAVAL'];
	  $this->logger->debug( " deltaval =  $deltaVal");
	  $this->logger->info('<- Default_Model_CC3->getDeltaSubVal()()');
	  return $deltaVal;
	} // getDeltaSubVal
	
}
