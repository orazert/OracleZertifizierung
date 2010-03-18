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
        $this->logger->info( "-> WarenController->indexAction() RequestParam cc1 = $cc1 cc2 = $cc2 cc3 = $cc3");
        	   
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
		$mod = new Default_Model_Waren();
		$this->view->message = '';
		
		$request = $this->getRequest();
		$cc1 = $request->getParam('cc1');
		$cc2 = $request->getParam('cc2');
		$cc3 = $request->getParam('cc3');
		$id = $request->getParam('id');
		$warencode = $request->getParam('warencode');
	    $userDef = $request->getParam('userdef');
		$val = $request->getParam('val');
		$maxUserVal = $request->getParam('maxuserval');
		
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
               if (!isset($msg)) {			
                   $maxVal = wk_to_float($maxUserVal);
				   $userVal = wk_to_float($val);
				   if ( !(0 <= $userVal and $userVal <= $maxVal)) {
                      $msg = 'Neuer PVPI-Wert liegt nicht im gültigen Wertebereich!';
				   }
				}			 			   
			    if (isset($msg)) {
			        $this->view->message = $msg;
		        } else { // insert or update		 		 
					$data = $mod->insertOrUpdate_1($val,$this->userId,$id);
		            $this->_redirect("waren/index/cc1/$cc1/cc2/$cc2/cc3/$cc3");
		       }
		   } elseif (!empty($reset)) { //reset to default value
			  $data = $mod->delete_1($this->userId,$id);
		      $this->_redirect("waren/index/cc1/$cc1/cc2/$cc2/cc3/$cc3");
		   }
		} else { // Kommentare zur Berechnung von maxUserVal siehe Cc1Controller	
	        $mod_cc1 = new Default_Model_CC1();
            $id99val =  $mod_cc1->getId99Value($this->userId);
			$this->logger->debug( "id99val =  $id99val ");
			$deltaVal = '0';
            $maxUserVal = wk_calc_max_user_val($val,$id99val,$deltaVal);
			$def_val = wk_to_float($defVal);
			$this->logger->debug( "def_val =  $def_val ");	
			$maxVal = wk_to_float($maxUserVal);
			$this->logger->debug( "maxVal =  $maxVal ");
			
			 if (0 <= $def_val and $def_val <= $maxVal) {
			    $resetAllowed = '1';
			 } else { $resetAllowed = '0';}
			 
            $this->logger->debug( "maxVal: type  =  $maxValType  val =  $maxUserVal");			
		} 
		$this->view->title = "PVPI-Wert ändern";
		$this->view->entries = 
		    array('cc1' => $cc1, 'cc2' => $cc2, 'cc3' => $cc3, 'id' => $id, 'warencode' => $warencode, 'userdef' => $userDef, 'val' => $val,
			      'maxuserval' => $maxUserVal, 'defval' => $defVal, 'resetallowed' => $resetAllowed,
			      'ONLOAD' => 'javascript: this.document.editform.newval.focus();');
        $this->render();
		$this->logger->info( '<- WarenController->editAction()');
    } // editAction



}



