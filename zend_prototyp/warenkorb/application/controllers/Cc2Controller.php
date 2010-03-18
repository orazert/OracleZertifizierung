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
        //$this->logger->debug( "request\n'". var_export($request,true));
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
		$mod = new Default_Model_CC2();
		
		$this->view->message = '';
		
		$request = $this->getRequest();
		$cc1 = $request->getParam('cc1');
		$cc2 = $request->getParam('cc2');
	    $userDef = $request->getParam('userdef');
		$val = $request->getParam('val');
		
		$maxUserVal = $request->getParam('maxuserval');
	    $resetAllowed = $request->getParam('resetallowed');
		$defVal = $request->getParam('defval');
		
		$this->logger->debug( "request\n" . var_export($_REQUEST,true));
        
		if ($this->_request->isPost()) {
			$reset = $request->getParam('reset');
	        $save =  $request->getParam('save');
			$cancle  =  $request->getParam('cancel');
			if (!empty($cancle) ) { // cancle
			   $this->_redirect("cc2/index/cc1/$cc1");
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
                    $data = $mod->insertOrUpdate($val,$this->userId,$cc1,$cc2);
		            $this->_redirect("cc2/index/cc1/$cc1");
		       }
		   } elseif (!empty($reset)) { //reset to default value
              $data = $mod->delete($this->userId,$cc1,$cc2);
		      $this->_redirect("cc2/index/cc1/$cc1");
		   }
		} else { // Kommentare zur Berechnung von maxUserVal siehe Cc1Controller
	        $mod_cc1 = new Default_Model_CC1();
            $id99val =  $mod_cc1->getId99Value($this->userId);
			$this->logger->debug( "id99val =  $id99val ");
			
			$deltaVal = '0'; //$mod->getDeltaSubVal($this->userId, $cc1,$cc2);
			$this->logger->debug( "deltaVal =  $deltaVal ");
			
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
		$perssubval = $mod->hasPersSubValues($this->userId,$cc1,$cc2);
		$this->view->entries = 
		    array('cc1' => $cc1, 'cc2' => $cc2, 'userdef' => $userDef, 'DATA' => $perssubval, 'val' => $val,
			        'maxuserval' => $maxUserVal, 'defval' => $defVal, 'resetallowed' => $resetAllowed,
			      'ONLOAD' => 'javascript: this.document.editform.newval.focus();');
        $this->render();
		$this->logger->info( '<- Cc2Controller->editAction()');
    } // editAction

}



