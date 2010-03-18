<?php
require_once ( APPLICATION_PATH . '\wk_util\wk_util.php');

class AuthController extends Zend_Controller_Action
{
  
	public function init()
    {   
	   
		$logger = Zend_Registry::get('logger');
		$this->initView();
        $this->view->baseUrl = $this->_request->getBaseUrl();
		$logger->info( 'AuthController->init()');
    }

	/*
	function preDispatch()
	{
	   $logger = Zend_Registry::get('logger');
	   $logger->info( '-> AuthController->preDispatch()');
	   
	   $auth = Zend_Auth::getInstance();
	   $isLoggedIn = $auth->hasIdentity();
	   $logger->debug( "** AuthController->preDispatch() isLoggedIn = $isLoggedIn");
	   if ( $isLoggedIn) {
	       $request = $this->getRequest();
	       $action = $request->getParam('action');
		   if ($action != 'logout') {
	         $this->_redirect('cc1/index');
		   }
	   } 
	   $logger->info( '<- AuthController->preDispatch()');
	} 
       */
	
    public function indexAction()
    {
        $this->_redirect('/');
    }
	
    function loginAction()
    {
        $logger = Zend_Registry::get('logger');
	    $logger->info( '-> AuthController->loginAction()');
		


		$this->view->message = '';
	    
        if ($this->_request->isPost()) {
            // collect the data from the user
            Zend_Loader::loadClass('Zend_Filter_StripTags');
            $filter = new Zend_Filter_StripTags();
            $username = $filter->filter($this->_request->getPost('username'));
            $password = $filter->filter($this->_request->getPost('password'));
            $logger->debug( "** AuthController->loginAction() $username/$password");
			
            if (wk_empty($username) or wk_empty($password)) {
                $this->view->message = 'Bitte Name und Passwort eingeben.';
			    $data = array('ONLOAD' => 'this.document.loginform.username.focus();' );
		        $this->view->entries = $data;	
            } else {
                // setup Zend_Auth adapter for a database table
                Zend_Loader::loadClass('Zend_Auth_Adapter_DbTable');
                $db = Zend_Registry::get('db');
                $authAdapter = new Zend_Auth_Adapter_DbTable($db);
                $authAdapter->setTableName('wk_user');
                $authAdapter->setIdentityColumn('user_name');
                $authAdapter->setCredentialColumn('user_pwd');
                
                // Set the input credential values to authenticate against
                $authAdapter->setIdentity($username);
                $authAdapter->setCredential($password);
                
                // do the authentication 
                $auth = Zend_Auth::getInstance();
                $result = $auth->authenticate($authAdapter);
                if ($result->isValid()) {
				    $logger->info( '** AuthController->loginAction() authenticated');
                    // success : store database row to auth's storage system
                    // (not the password though!)
                    $data = $authAdapter->getResultRowObject(null, 'password');
					// $txt = var_export($data,true);
					// $logger->debug( "** $txt");
                    $auth->getStorage()->write($data);
                    $this->_redirect('cc1/index');
                } else {
                    // failure: clear database row from session
					$logger->info( '** AuthController->loginAction() not authenticated');
                    $this->view->message = 'Fehler bei Ammeldung.';
                }
            }
		}
        $this->view->title = "Anmelden";
		$this->view->entries = array('ONLOAD' => 'javascript: this.document.loginform.username.focus();', 'LOGIN' => 'login');
        $this->render();
		$logger->info( '<- AuthController->loginAction()');
        
    }

    function logoutAction()
    {
        Zend_Auth::getInstance()->clearIdentity();
        $this->_redirect('/');
    }
	
	function createAction()
	{
	   $logger = Zend_Registry::get('logger');
	    $logger->info( '-> AuthController->createAction()');
		
		$this->view->message = '';
        if ($this->_request->isPost()) {
		// collect the data from the user
            Zend_Loader::loadClass('Zend_Filter_StripTags');
            $filter = new Zend_Filter_StripTags();
            $username = $filter->filter($this->_request->getPost('username'));
            $password = $filter->filter($this->_request->getPost('password'));
            $logger->debug( "** AuthController->createAction() $username/$password");
			
			if (wk_empty($username) or wk_empty($password)  ) {
                $this->view->message = 'Bitte Name und Passwort eingeben.';
		    } else {
			// add new user  to database
				$data = array(
	                 'user_name' => $username,
	                  'user_pwd' => $password
	            );
				
				$db = Zend_Registry::get('db');
	             
				 try {
	              $db->insert('wk_user', $data);
				  $this->_redirect('auth/login');
				  
				 } catch (Exception $e) {
				    $errTxt = $e->getMessage();
				    $logger->debug( '** AuthController->CreateAction() insert Exception: ' . $errTxt);
				     // ORA-00001 unique constraint violation.
				 if (false !== strpos($errTxt,'ORA-00001')) {
	                $this->view->message = 'Es gibt schon einen Benutzer mit diesem Namen';
				 } else {
				   $this->view->message = 'Fehler bei Registierung.';
				 }
		   } 
		 }
		}
		$this->view->title = "Benutzer registrieren";
		$this->view->entries = array('ONLOAD' => 'javascript: this.document.createform.username.focus();', 'CREATE' => 'create' );
        $this->render();
		$logger->info( '<- AuthController->createAction()');
	}
	
	public function helpAction()
    {
        $logger = Zend_Registry::get('logger');
	    $logger->info( '-> AuthController->helpAction()');
		$this->view->entries = array('HELP' => 'help' );
		$this->render();
		$logger->info( '<- AuthController->helpAction()');
    }
  }
?>