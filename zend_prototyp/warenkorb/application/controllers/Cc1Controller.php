<?php

class Cc1Controller extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
       $logger = Zend_Registry::get('logger');
	   $logger->info( '-> Cc1Controller->indexAction()');
		
	   $cc1 = new Default_Model_CC1();
       $this->view->entries = $cc1->fetchAll();
	   
	   $logger->info( '<- Cc1Controller->indexAction()');
   }



}

