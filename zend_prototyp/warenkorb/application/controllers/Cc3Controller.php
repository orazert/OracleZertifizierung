<?php
require_once ( APPLICATION_PATH . '\wk_util\wk_util.php');

class Cc3Controller extends Zend_Controller_Action
{
    private $logger = null;
	private $userId = null;
	
    public function init()
    {
        $this->logger = Zend_Registry::get('logger');
        $this->logger->info( '-- Cc3Controller->init()');
		$this->view->baseUrl = $this->_request->getBaseUrl();	
    } // init
	
    public function preDispatch()
    {
        $this->logger->info( '-> Cc3Controller->preDispatch()');
        	   
        $auth = Zend_Auth::getInstance();
        $isLoggedIn = $auth->hasIdentity();
        $this->logger->debug( "** Cc3Controller->preDispatch() isLoggedIn = $isLoggedIn");
        if ( !$isLoggedIn) {
        	$this->_redirect('auth/login');
        } 
        $this->userId = $auth->getIdentity()->USER_ID;
        $this->logger->info( '<- Cc3Controller->preDispatch()');
    } // preDispatch


    public function indexAction()
    {
		$this->logger->info( '-> Cc3Controller->indexAction()');
        	   
        $request = $this->getRequest();
        // $this->logger->debug( 'request\n' . var_export($request,true));
        $cc1 = $request->getParam('cc1');
		$cc2 = $request->getParam('cc2');
        $this->logger->info( '-> Cc3Controller->indexAction() RequestParam cc1 = $cc1 cc2 = $cc2');
        	   
        $mod = new Default_Model_CC3();
        	   
        $data = $mod->fetchAll($this->userId,$cc1,$cc2);
        $link = array('CC1' => $cc1, 'CC2' => $cc2);
		$waren = new Default_Model_Waren();
		$corr = $waren->getCorr($this->userId);
	
        $this->view->entries = array('DATA' => $data , 'LINK' => $link, 'CORR' =>  $corr);
        	   
        $this->logger->info( '<- Cc3Controller->indexAction()');
    } // indexAction

    public function editAction()
    {
	    $this->logger->info( '-> Cc3Controller->editAction()');
		
		$this->view->message = '';
		
		$request = $this->getRequest();
		$cc1 = $request->getParam('cc1');
		$cc2 = $request->getParam('cc2');
		$cc3 = $request->getParam('cc3');
	    $userDef = $request->getParam('userdef');
		
		$this->logger->debug( 'request\n' . var_export($_REQUEST,true));
        
		if ($this->_request->isPost()) {
			$reset = $request->getParam('reset');
	        $save =  $request->getParam('save');
			$cancle  =  $request->getParam('cancel');
			if (!empty($cancle) ) { // cancle
			   $this->_redirect("cc3/index/cc1/$cc1/cc2/$cc2");
			} elseif (!empty($save)) {
			   $val = $request->getParam('newval');	
			    $msg = wk_check_number($val);
			    if (isset($msg)) {
			        $data = array('cc1' => $cc1, 'cc2' => $cc2, 'cc3' => $cc3, 'userdef' => $userDef );
			        $this->view->entries = $data;
			        $this->view->message = $msg;
		        } else { // insert or update		 		 
			        $mod = new Default_Model_CC3();
                    $data = $mod->insertOrUpdate($val,$this->userId,$cc1,$cc2, $cc3);
		            $this->_redirect("cc3/index/cc1/$cc1/cc2/$cc2");
		       }
		   } elseif (!empty($reset)) { //reset to default value
		      $mod = new Default_Model_CC3();
              $data = $mod->delete($this->userId,$cc1,$cc2,$cc3);
		      $this->_redirect("cc3/index/cc1/$cc1/cc2/$cc2");
		   }
		} else {	
		    $data = array('cc1' => $cc1, 'cc2' => $cc2, 'cc3' => $cc3, 'userdef' => $userDef );
		    $this->view->entries = $data;		
		} 
		$this->view->title = "Wert ändern";
        $this->render();
		$this->logger->info( '<- Cc3Controller->editAction()');
    } // editAction


}



