<?php

// application/models/Waren.php

class Default_Model_Waren
{
    private $logger = null;
	private $db = null;
	private $pkg = null;
	private $corrFct = null;
	private $corrData = null; 	
	
	function __construct()
	{
	   $this->logger = Zend_Registry::get('logger');
	   $this->db = Zend_Registry::get('db');
	   $this->pkg = Zend_Registry::get('pkg', $pkg);
	   $this->corrFct = Zend_Registry::get('corrFct');
	   $this->corrData = Zend_Registry::get('corrData');
	   $this->logger->debug( '-- Default_Model_Waren->__construct()');
	} // __construct
	
	public function fetchAll($userId, $cc1, $cc2, $cc3)
	{
	   $this->logger->info( "-> Default_Model_Waren->fetchAll() - userId = $userId cc1 = $cc1 cc2 = $cc2 cc3 => $cc3" );
	
       $sql = 'select cc1, cc2, cc3, wc_id, warencode, wc_bezeichnung, wc_vpi, val, user_def  ' .
		       "from table($this->pkg.fetch_warencode(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_cc3 => $cc3 ))" ;
 
       $this->logger->debug( ' sql = ' . $sql);
	   
	   $result = $this->db->fetchAll($sql);
		
	   $this->logger->debug( ' result ' . var_export($result,true));
	   $this->logger->info( '<- Default_Model_Waren->fetchAll()');
	   return $result;
	} // fetchAll
	
	public function insertOrUpdate($val, $userId, $cc1, $cc2, $cc3, $warencode)
	{
	   $this->logger->info( "-> Default_Model_Waren->insertOrUpdate() - userId = $userId cc1 = $cc1 cc2 = $cc2 warencode = $warencode val = $val");
	   $val = str_replace(',','.',$val);
	   
	   $sql = "call $this->pkg.ins_or_upd_warencode(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_cc3 => $cc3, p_warencode => $warencode, p_val => $val)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->query($sql);
	   $this->logger->debug( ' result =  ' . var_export($result,true));
	   $this->logger->info( '-> Default_Model_Waren->insertOrUpdate()');
	   return $result;   
	} // insertOrUpdate
	
	public function insertOrUpdate_1($val, $userId, $id)
	{
	   $this->logger->info( "-> Default_Model_Waren->insertOrUpdate_1() - userId = $userId id = $id, val = $val");
	   $val = str_replace(',','.',$val);
	   
	   $sql = "call $this->pkg.ins_or_upd(p_userid => $userId, p_id => $id, p_val => $val)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->query($sql);
	   $this->logger->debug( ' result =  ' . var_export($result,true));
	   $this->logger->info( '-> Default_Model_Waren->insertOrUpdate_1()');
	   return $result;   
	} // insertOrUpdate

	
	public function delete($userId, $cc1, $cc2, $cc3, $warencode)
	{
	   $this->logger->info( "-> Default_Model_Waren->delete() - userId = $userId cc1 = $cc1 cc2 = $cc2 cc3 = $cc3");
	   $sql = "call $this->pkg.del_warencode(p_userid => $userId, p_cc1 => $cc1, p_cc2 => $cc2, p_cc3 => $cc3, p_warencode => $warencode)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->query($sql);
	   $this->logger->info( '-> Default_Model_Waren->delete()'); 
	} // delete
	
	
	public function delete_1($userId, $id)
	{
	   $this->logger->info( "-> Default_Model_Waren->delete() - userId = $userId id = $id");
	   $sql = "call $this->pkg.del(p_userid => $userId, p_id => $id)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->query($sql);
	   $this->logger->info( '-> Default_Model_Waren->delete_1()'); 
	} // delete

	
	public function getCorr($userId)
	{
	   $this->logger->info( "-> Default_Model_Waren->getCorr() - userId = $userId");
	   //$sql = 'select 100 * abs(corr(wc_vpi,val)) as CORR ' . "from table($this->pkg.fetch_alle_waren(p_userid => $userId))" ;
	   $sql = 'select ' . $this->corrFct . ' as CORR ' . "from table($this->pkg.$this->corrData(p_userid => $userId))" ;
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->fetchAll($sql);
	   //$this->logger->debug( ' result ' . var_export($result,true));
	   $corr = $result[0]['CORR'];
	   $this->logger->info( " corr = $corr");
	   $this->logger->info( '-> Default_Model_Waren->getCorr()'); 
	   return $corr;
	} // getCorr
	
	
}
