<?php

// application/models/CC1.php

class Default_Model_CC1
{	
    private $logger = null;
	private $db = null;
	private $pkg = null;
	
	function __construct()
	{
	   $this->logger = Zend_Registry::get('logger');
	   $this->db = Zend_Registry::get('db');
	   $this->pkg = Zend_Registry::get('pkg', $pkg);
	   $this->logger->debug( '-- Default_Model_CC1->__construct()');
	} // __construct

	public function fetchAll($userId)
	{
	   $this->logger->info( '-> Default_Model_CC1->fetch() - userId = ' . $userId); 
	   $sql = 'select cc1, cc1_bezeichnung, cc1_vpi, val, user_def ' .
		       "from table($this->pkg.fetch_cc1(p_userid => $userId))" ;
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->fetchAll($sql);
	   // $this->logger->debug( ' result ' . var_export($result,true));
	   $this->logger->info( '<- Default_Model_CC1->fetch_cc1()');
	   return $result;
	} // fetchAll
	
	public function insertOrUpdate($val,$userId,$cc1)
	{
	   $this->logger->info( "-> Default_Model_CC1->insertOrUpdate() - userId = $userId cc1 = $cc1 val = $val");
	   $val = str_replace(',','.',$val);
	   $sql = "call $this->pkg.ins_or_upd_cc1(p_userid => $userId, p_cc1 => $cc1, p_val => $val)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->query($sql);
	   $this->logger->info( '-> Default_Model_CC1->insertOrUpdate()');
	   return $result;   
	} // insertOrUpdate
	
	public function delete($userId,$cc1)
	{
	   $this->logger->info( "-> Default_Model_CC1->delete() - userId = $userId cc1 = $cc1");
	   $sql = "call $this->pkg.del_cc1(p_userid => $userId, p_cc1 => $cc1)";
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->query($sql);
	   $this->logger->info( '-> Default_Model_CC1->delete()'); 
	} // delete
	
	public function getCorr($userId)
	{
	   $this->logger->info( "-> Default_Model_CC1->getCorr() - userId = $userId");
	   $sql = 'select corr(cc1_vpi,val) as CORR ' . "from table($this->pkg.fetch_cc1(p_userid => $userId))" ;
	   $this->logger->debug( ' sql =  ' . $sql);
	   $result = $this->db->fetchAll($sql);
	   //$this->logger->debug( ' result ' . var_export($result,true));
	   $corr = $result[0]['CORR'];
	   $this->logger->debug( " corr = $corr");
	   $this->logger->info( '-> Default_Model_CC1->getCorr()'); 
	   return $corr;
	} // getCorr
	
	public function hasPersSubValues($userId,$cc1)
	{
	  $this->logger->info( "-> Default_Model_CC1->hasPersSubValues() - - userId = $userId cc1 = $cc1");
	  //$sql = "select count(*) result from table($this->pkg.has_pers_val_cc1(p_userid => $userId, p_cc1 => $cc1))";
	  $sql = "select * from table($this->pkg.has_pers_val_cc1(p_userid => $userId, p_cc1 => $cc1))";
	  $this->logger->debug( ' sql =  ' . $sql);
	  $result = $this->db->fetchAll($sql);
	  //$res = $result[0]['RESULT'];
	  //$this->logger->debug( " res = $result");
	  $this->logger->info( '-> Default_Model_CC1->hasPersSubValues()'); 
	  return $result;
	} // hasPersSubValues
	
    public function getPvpiList($userId)
	{
	  $this->logger->info( "-> Default_Model_CC1->getPvpiList() - userId = $userId");
	  $sql = "select * from table($this->pkg.has_pers_val(p_userid => $userId))";
	  $this->logger->debug( ' sql =  ' . $sql);
	  $result = $this->db->fetchAll($sql);
	  $this->logger->debug( ' result ' . var_export($result,true));
	  $this->logger->info( '-> Default_Model_CC1->getPvpiList)'); 
	  return $result;
	} // hasPersSubValues
	
	public function deleteFromWKPers($userid,$wpid)
	{
	    $this->logger->info( "-> Default_Model_CC1->deleteFromWKPers() - userId = $userId wpid = $wpid");
		$sql = "delete from wk_personal where user_id = $userid and wp_id = $wpid";
		$this->logger->debug( ' sql =  ' . $sql);
		$result = $this->db->query($sql);
		$this->logger->info( "<- Default_Model_CC1->deleteFromWKPers()");
		return result;
	} //  deleteFromWKPers
	
	
}
