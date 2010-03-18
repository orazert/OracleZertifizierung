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
		$corr = $waren->getCorr($this->userId); 
        $this->view->entries = array('DATA' => $data ,'CORR' =>  $corr);
        $this->logger->info( '<- Cc1Controller->indexAction()');
    } // indexAction

    public function editAction()
    {
	    $this->logger->info( '-> Cc1Controller->editAction()');
		$mod = new Default_Model_CC1();
		$this->view->message = '';
		$request = $this->getRequest();
		$cc1 = $request->getParam('cc1');
	    $userDef = $request->getParam('userdef');
		$maxUserVal = $request->getParam('maxuserval');
		$val = $request->getParam('val');
		$resetAllowed = $request->getParam('resetallowed');
		$defVal = $request->getParam('defval');
		$this->logger->debug( "request\n" . var_export($_REQUEST,true));     
		if ($this->_request->isPost()) {
			$reset = $request->getParam('reset');
	        $save =  $request->getParam('save');
			$cancle  =  $request->getParam('cancel');
			if (!empty($cancle) ) { // cancle
			   $this->_redirect('cc1/index');	
			} elseif (!empty($save)) { //save
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
                    $data = $mod->insertOrUpdate($val,$this->userId,$cc1);
		            $this->_redirect('cc1/index');
		       }
		   } elseif (!empty($reset)) { //reset to default value
              $data = $mod->delete($this->userId,$cc1);
		      $this->_redirect('cc1/index');
		   }
		} else {	
	        //  Bereich für neuen PVPI berechnen:   0 <= neuer PVPI <= maxUserVal
			// maxUserVal  = alter PVPI + Wert SONSTIGES(id99) 
			//  (  maxUserVal  ist mindestens so gross wie der altee PVPI)
			
			// Wert von SONSTIGES (cc1 = 99)  
            $id99val =  $mod->getId99Value($this->userId); 
			$this->logger->debug( "id99val =  $id99val ");
			
			// Summe der Differenzen(PVPI  - Defaultwert VPI)  jener  Elemente  
			// die beim Speichern des neuen PVPI gelöscht werden
			$deltaVal = '0'; //$mod->getDeltaSubVal($this->userId, $cc1);
			$this->logger->debug( "deltaVal =  $deltaVal ");
			
			// Berechnung maxUserVal 
            $maxUserVal = wk_calc_max_user_val($val,$id99val,$deltaVal);
			$def_val = wk_to_float($defVal);
			$this->logger->debug( "def_val =  $def_val ");	
			$maxVal = wk_to_float($maxUserVal);
			$this->logger->debug( "maxVal =  $maxVal ");
			
			 // Rücksetzen auf Default ist nicht möglich, wenn der Default VPI Wert >  maxUserVal
			 // (kein Reset-Button !!)
			 if (0 <= $def_val and $def_val <= $maxVal) {
			    $resetAllowed = '1';
			 } else { $resetAllowed = '0';}
			 
            $this->logger->debug( "maxUserVal = $maxUserVal");			
		} 
		$this->view->title = "PVPI-Wert ändern";
		// Liste der Elemente lesen die auf Default-Wert gesetzt werden, falls der neue PVPI gespeichert wird.
		$perssubval = $mod->hasPersSubValues($this->userId,$cc1);
		$this->view->entries = 
		    array('cc1' => $cc1, 'userdef' => $userDef, 'DATA' => $perssubval, 'val' => $val, 
			      'maxuserval' => $maxUserVal, 'defval' => $defVal, 'resetallowed' => $resetAllowed,
		         'ONLOAD' => 'javascript: this.document.editform.newval.focus();');
        $this->render();
		$this->logger->info( '<- Cc1Controller->editAction()');
    } // editAction
     
    public function displayAction()
    {
	    $this->logger->info( '-> Cc1Controller->displayAction()');
        $mod = new Default_Model_CC1();
        $data = $mod->getPvpiList($this->userId);
        $this->view->entries = array('DATA' => $data);
        $this->logger->info( '<- Cc1Controller->displayAction()');
	}  // displayAction
	
	public function resetAction()
	{
	    $this->logger->info( '-> Cc1Controller->resetAction()');
		$this->logger->debug( "request\n" . var_export($_REQUEST,true));
		if ($this->_request->isPost()) {
		   $mod = new Default_Model_CC1();
            $data = $mod->getPvpiList($this->userId);
		    $request = $this->getRequest();
		    foreach ($data as $entry) {
		    $wpid_param = 'WPID_'. $entry['WP_ID'];
			$wpid_val = $request->getParam($wpid_param);
			if (isset($wpid_val)) {
			    $this->logger->debug( "delete  wpid_val = $wpid_val" );
				$mod->deleteFromWKPers($this->userId,$wpid_val);
		    }
		  }
		}
		$this->_redirect('cc1/display');
		$this->logger->info( '<- Cc1Controller->resetAction()');
	} //  resetAction
	

}



