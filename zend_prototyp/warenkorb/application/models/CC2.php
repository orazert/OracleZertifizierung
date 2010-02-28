<?php

// application/models/CC2php

class Default_Model_CC2
{	
    private $logger = null;
	private $db = null;
	private $pkg = null;
	
	function __construct()
	{
	   $this->logger = Zend_Registry::get('logger');
	   $this->db = Zend_Registry::get('db');
	   $this->pkg = Zend_Registry::get('pkg', $pkg);
	   $this->logger->debug( '-- Default_Model_CC2->__construct()');
	} // __construct

    
	public function fetchAll($userId, $cc1)
	{
	   $this->logger = Zend_Registry::get('logger');
	   $this->logger->info( "-> Default_Model_CC2->fetchAll() - userId = $userId cc1 = $cc1");
	
       $sql = 'select cc1, cc2, cc2_bezeichnung, cc2_vpi, val, user_def  ' .
		       "from table($this->pkg.fetch_cc2(p_userid => $userId, p_cc1 => $cc1 ))" ;
 
       $this->logger->debug( ' sql = ' . $sql);
	   
	   $db = Zend_Registry::Get('db');
	   $result = $db->fetchAll($sql);
		
	   $this->logger->debug( ' result ' . var_export($result,true));
	   $this->logger->info( '<- Default_Model_CC2->fetchAll()');
	   return $result;
	} // fetchAll
	
	public function insertOrUpdate($val, $userId, $cc1, $cc2)
	{
	   $this->logger = Zend_Registry::get('logger');
	   $this->logger->info( "-> Default_Model_CC2->insertOrUpdate() - userId = $userId cc1 = $cc1 val = $val");
	   $val = str_replace(',','.',$val);
	   //$sql = "select wk_pkg.ins_or_upd_cc2(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_val => $val) from dual";
	   $sql = "call $this->pkg.ins_or_upd_cc2(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_val => $val)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $db = Zend_Registry::Get('db');
	   //$result = $db->fetchAll($sql);
	   $result = $db->query($sql);
	   // $logger->debug( ' result =  ' . var_export($result,true));
	   $this->logger->info( '-> Default_Model_CC2->insertOrUpdate()');
	   return $result;   
	} // insertOrUpdate
	
	public function delete($userId, $cc1, $cc2)
	{
	   $this->logger = Zend_Registry::get('logger');
	   $this->logger->info( "-> Default_Model_CC2->delete() - userId = $userId cc1 = $cc1 cc2 = $cc2");
	   // $sql = "select wk_pkg.del_cc2(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2) from dual";
	   $sql = "call $this->pkg.del_cc2(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $db = Zend_Registry::Get('db');
	   //$result = $db->fetchAll($sql);
	   $this->result = $db->query($sql);
	   $this->logger->info( '-> Default_Model_CC2->delete()'); 
	} // delete
	
	
	
	
}
