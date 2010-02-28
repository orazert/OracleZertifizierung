<?php
require_once ( APPLICATION_PATH . '\wk_util\wk_util.php');

class Cc1Controller extends Zend_Controller_Action
{
    private $logger = null;
    private $userId = null;

    public function init()
    {
        $this->logger = Zend_Registry::get('logger');
        $this->logger->info( '-- Cc1Controller->init()');
		$this->view->baseUrl = $this->_request->getBaseUrl();
    } // init

    public function preDispatch()
    {
        $this->logger->info( '-> Cc1Controller->preDispatch()');
        $auth = Zend_Auth::getInstance();
        $isLoggedIn = $auth->hasIdentity();
        $this->logger->debug( "** Cc1Controller->preDispatch() isLoggedIn = $isLoggedIn");
        if ( !$isLoggedIn) {
        	$this->_redirect('auth/login');
        } 
        $this->userId = $auth->getIdentity()->USER_ID;
        $this->logger->info( '<- Cc1Controller->preDispatch()');
    } // preDispatch

    public function indexAction()
    {
        $this->logger->info( '-> Cc1Controller->indexAction()');
        $cc1 = new Default_Model_CC1();
        $data = $cc1->fetchAll($this->userId);
		$waren = new Default_Model_Waren();
		$corr = $waren->getCorr($this->userId);;  
        $this->view->entries = array('DATA' => $data ,'CORR' =>  $corr);
     
        $this->logger->info( '<- Cc1Controller->indexAction()');
    } // indexAction

    public function editAction()
    {
	    $this->logger->info( '-> Cc1Controller->editAction()');
		$this->view->message = '';
		$request = $this->getRequest();
		$cc1 = $request->getParam('cc1');
	    $userDef = $request->getParam('userdef');		
		$this->logger->debug( 'request\n' . var_export($_REQUEST,true));     
		if ($this->_request->isPost()) {
			$reset = $request->getParam('reset');
	        $save =  $request->getParam('save');
			$cancle  =  $request->getParam('cancel');
			if (!empty($cancle) ) { // cancle
			   $this->_redirect('cc1/index');	
			} elseif (!empty($save)) {
			    $val = $request->getParam('newval');
                $msg = wk_check_number($val);			
			    if (isset($msg)) {
			        $data = array('cc1' => $cc1, 'userdef' => $userDef );
			        $this->view->entries = $data;
			        $this->view->message = 'Bitte einen Wert eingeben.';
					 $this->view->message = $msg;
		        } else { // insert or update		 		 
			        $mod = new Default_Model_CC1();
                    $data = $mod->insertOrUpdate($val,$this->userId,$cc1);
		            $this->_redirect('cc1/index');
		       }
		   } elseif (!empty($reset)) { //reset to default value
		      $mod = new Default_Model_CC1();
              $data = $mod->delete($this->userId,$cc1);
		      $this->_redirect('cc1/index');
		   }
		} else {	
		    $data = array('cc1' => $cc1, 'userdef' => $userDef );
		    $this->view->entries = $data;		
		} 
		$this->view->title = "Wert ändern";
        $this->render();
		$this->logger->info( '<- Cc1Controller->editAction()');
    } // editAction


}



