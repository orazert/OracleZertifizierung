<?php

class Cc1Controller extends Zend_Controller_Action
{
    private $userId;

    public function init()
    {
        /* Initialize action controller here */
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-- Cc1Controller->init()');
    }
	
	function preDispatch()
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Cc1Controller->preDispatch()');
	   
	   $auth = Zend_Auth::getInstance();
	   $isLoggedIn = $auth->hasIdentity();
	   $logger->debug( "** Cc1Controller->preDispatch() isLoggedIn = $isLoggedIn");
	   if ( !$isLoggedIn) {
	       $this->_redirect('auth/login');
	   } 
	   $this->userId = $auth->getIdentity()->USER_ID;
	   $logger->info( '<- Cc1Controller->preDispatch()');
	} 
	
    public function indexAction()
    {
       $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Cc1Controller->indexAction()');
		
	   $cc1 = new Default_Model_CC1();
	   $data = $cc1->fetchAll($this->userId);
	   
	   $this->view->entries = array('DATA' => $data );
	   
	   $logger->info( '<- Cc1Controller->indexAction()');
   }

}

