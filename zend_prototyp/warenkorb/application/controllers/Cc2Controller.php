<?php
require_once ( APPLICATION_PATH . '\wk_util\wk_util.php');

class Cc2Controller extends Zend_Controller_Action
{

    private $userId = null;
	private $logger = null;

    public function init()
    {
        $this->logger = Zend_Registry::get('logger');
        $this->logger->info( '-- Cc2Controller->init()');
		$this->view->baseUrl = $this->_request->getBaseUrl();	   
    } // init

    public function preDispatch()
    {
        $this->logger->info( '-> Cc2Controller->preDispatch()');
        	   
        $auth = Zend_Auth::getInstance();
        $isLoggedIn = $auth->hasIdentity();
        $this->logger->debug( "** Cc2Controller->preDispatch() isLoggedIn = $isLoggedIn");
        if ( !$isLoggedIn) {
        	    $this->_redirect('auth/login');
        } 
        $this->userId = $auth->getIdentity()->USER_ID;
        $this->logger->info( '<- Cc2Controller->preDispatch()');
    } // preDispatch

    public function indexAction()
    {
		$this->logger->info( '-> Cc2Controller->indexAction()');
        	   
        $request = $this->getRequest();
        //$this->logger->debug( 'request\n' . var_export($request,true));
        $cc1 = $request->getParam('cc1');
        $this->logger->info( '-> Cc2Controller->indexAction() RequestParam(cc1) = ' . $cc1);
        	   
        $mod = new Default_Model_CC2();
        	   
        $data = $mod->fetchAll($this->userId,$cc1);
        $link = array('CC1' => $cc1 );
        $waren = new Default_Model_Waren();
		$corr = $waren->getCorr($this->userId);;  
        $this->view->entries = array('DATA' => $data , 'LINK' => $link, 'CORR' =>  $corr);

        	   
        $this->logger->info( '<- Cc2Controller->indexAction()');
    } // indexAction
	
    public function editAction()
    {
	    $this->logger->info( '-> Cc2Controller->editAction()');
		
		$this->view->message = '';
		
		$request = $this->getRequest();
		$cc1 = $request->getParam('cc1');
		$cc2 = $request->getParam('cc2');
	    $userDef = $request->getParam('userdef');
		$perssubval = $request->getParam('perssubval');
		$val = $request->getParam('val');
		$this->logger->debug( 'request\n' . var_export($_REQUEST,true));
        
		if ($this->_request->isPost()) {
			$reset = $request->getParam('reset');
	        $save =  $request->getParam('save');
			$cancle  =  $request->getParam('cancel');
			if (!empty($cancle) ) { // cancle
			   $this->_redirect("cc2/index/cc1/$cc1");
			} elseif (!empty($save)) {
			   $val = $request->getParam('newval');
                $msg = wk_check_number($val);			   
			    if (isset($msg)) {
			        $this->view->message = $msg;
		        } else { // insert or update		 		 
			        $mod = new Default_Model_CC2();
                    $data = $mod->insertOrUpdate($val,$this->userId,$cc1,$cc2);
		            $this->_redirect("cc2/index/cc1/$cc1");
		       }
		   } elseif (!empty($reset)) { //reset to default value
		      $mod = new Default_Model_CC2();
              $data = $mod->delete($this->userId,$cc1,$cc2);
		      $this->_redirect("cc2/index/cc1/$cc1");
		   }
		} else {
            $mod = new Default_Model_CC2();
			$perssubval = $mod->hasPersSubValues($this->userId,$cc1,$cc2);			
		} 
		$this->view->title = "PVPI-Wert ändern";
		$this->view->entries = 
		    array('cc1' => $cc1, 'cc2' => $cc2, 'userdef' => $userDef, 'DATA' => $perssubval, 'val' => $val,
			      'ONLOAD' => 'javascript: this.document.editform.newval.focus();');
        $this->render();
		$this->logger->info( '<- Cc2Controller->editAction()');
    } // editAction

}



