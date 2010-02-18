<?php

class Cc2Controller extends Zend_Controller_Action
{
    private $userId;
	 
    public function init()
    {
       /* Initialize action controller here */
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-- Cc2Controller->init()');
    }
		
	function preDispatch()
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Cc2Controller->preDispatch()');
	   
	   $auth = Zend_Auth::getInstance();
	   $isLoggedIn = $auth->hasIdentity();
	   $logger->debug( "** Cc2Controller->preDispatch() isLoggedIn = $isLoggedIn");
	   if ( !$isLoggedIn) {
	       $this->_redirect('auth/login');
	   } 
	   $this->userId = $auth->getIdentity()->USER_ID;
	   $logger->info( '<- Cc2Controller->preDispatch()');
	} 

	
    public function indexAction()
    {
       $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Cc2Controller->indexAction()');
	   
	   $request = $this->getRequest();
	   $logger->debug( 'request\n' . var_export($request,true));
	   $cc1Param = $request->getParam('cc1');
	   $logger->info( '-> Cc1Controller->indexAction() RequestParam(cc1) = ' . $cc1Param);
	   
	   $cc2 = new Default_Model_CC2();
	   
	   $data = $cc2->fetchAll($this->userId,$cc1Param);
	   $link = array('CC1' => $cc1Param );
       $this->view->entries = array('DATA' => $data , 'LINK' => $link);
	   
	   $logger->info( '<- Cc2Controller->indexAction()');
	   
	   
	   $logger->info( '<- Cc2Controller->indexAction()');
    }


}

