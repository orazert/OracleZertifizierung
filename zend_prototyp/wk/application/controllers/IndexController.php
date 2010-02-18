<?php

class IndexController extends Zend_Controller_Action
{  
    
    public function init()
    {				 
    }

    public function indexAction()
    {
        // action body
         		   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> 88888888888888888888');
        $this->_redirect('auth/login');
    }
	
	function preDispatch()
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( 'IndexController->preDispatch()');
	   
	   $auth = Zend_Auth::getInstance();
	   if ( !$auth->hasIdentity()) {
	       $this->_redirect('auth/login');
	   } 
	} 


}

