<?php
require_once ( APPLICATION_PATH . '\wk_util\wk_util.php');

class WarenController extends Zend_Controller_Action
{
    private $logger = null;
	private $userId = null;
	
    public function init()
    {
        $this->logger = Zend_Registry::get('logger');
        $this->logger->info( '-- WarenController->init()');
		$this->view->baseUrl = $this->_request->getBaseUrl();	
    } // init
	
    public function preDispatch()
    {
        $this->logger->info( '-> WarenController->preDispatch()');
        	   
        $auth = Zend_Auth::getInstance();
        $isLoggedIn = $auth->hasIdentity();
        $this->logger->debug( "** WarenController->preDispatch() isLoggedIn = $isLoggedIn");
        if ( !$isLoggedIn) {
        	$this->_redirect('auth/login');
        } 
        $this->userId = $auth->getIdentity()->USER_ID;
        $this->logger->info( '<- WarenController->preDispatch()');
    } // preDispatch


    public function indexAction()
    {
		$this->logger->info( '-> WarenController->indexAction()');
        	   
        $request = $this->getRequest();
        //$this->logger->debug( "request\n" . var_export($request,true));
        $cc1 = $request->getParam('cc1');
		$cc2 = $request->getParam('cc2');
		$cc3 = $request->getParam('cc3');
        $this->logger->info( '-> WarenController->indexAction() RequestParam cc1 = $cc1 cc2 = $cc2 cc3 = $cc3');
        	   
        $mod = new Default_Model_Waren();
        	   
        $data = $mod->fetchAll($this->userId,$cc1,$cc2,$cc3);
        $link = array('CC1' => $cc1, 'CC2' => $cc2, 'CC3' => $cc3);
		$corr = $mod->getCorr($this->userId);;  
        $this->view->entries = array('DATA' => $data , 'LINK' => $link, 'CORR' =>  $corr);
        	   
        $this->logger->info( '<- WarenController->indexAction()');
    } // indexAction

    public function editAction()
    {
	    $this->logger->info( '-> WarenController->editAction()');
		
		$this->view->message = '';
		
		$request = $this->getRequest();
		$cc1 = $request->getParam('cc1');
		$cc2 = $request->getParam('cc2');
		$cc3 = $request->getParam('cc3');
		$id = $request->getParam('id');
		$warencode = $request->getParam('warencode');
	    $userDef = $request->getParam('userdef');
		
		$this->logger->debug( 'request\n' . var_export($_REQUEST,true));
        
		if ($this->_request->isPost()) {
			$reset = $request->getParam('reset');
	        $save =  $request->getParam('save');
			$cancle  =  $request->getParam('cancel');
			if (!empty($cancle) ) { // cancle
			   $this->_redirect("waren/index/cc1/$cc1/cc2/$cc2/cc3/$cc3");
			} elseif (!empty($save)) {
			   $val = $request->getParam('newval');	
               $msg = wk_check_number($val);				   
			    if (isset($msg)) {
			        $data = array('cc1' => $cc1, 'cc2' => $cc2, 'cc3' => $cc3, 'id' => $id, 'warencode' => $warencode,'userdef' => $userDef );
			        $this->view->entries = $data;
			        $this->view->message = $msg;
		        } else { // insert or update		 		 
			        $mod = new Default_Model_Waren();
                    //$data = $mod->insertOrUpdate($val,$this->userId,$cc1,$cc2,$cc3,$warencode);
					$data = $mod->insertOrUpdate_1($val,$this->userId,$id);
		            $this->_redirect("waren/index/cc1/$cc1/cc2/$cc2/cc3/$cc3");
		       }
		   } elseif (!empty($reset)) { //reset to default value
		      $mod = new Default_Model_Waren();
              //$data = $mod->delete($this->userId,$cc1,$cc2,$cc3,$warencode);
			  $data = $mod->delete_1($this->userId,$id);
		      $this->_redirect("waren/index/cc1/$cc1/cc2/$cc2/cc3/$cc3");
		   }
		} else {	
		    $data = array('cc1' => $cc1, 'cc2' => $cc2, 'cc3' => $cc3, 'id' => $id, 'warencode' => $warencode, 'userdef' => $userDef );
		    $this->view->entries = $data;		
		} 
		$this->view->title = "Wert ändern";
        $this->render();
		$this->logger->info( '<- WarenController->editAction()');
    } // editAction



}



