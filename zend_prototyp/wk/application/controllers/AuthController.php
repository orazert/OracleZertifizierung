<?php

class AuthController extends Zend_Controller_Action
{

	public function init()
  {   
	   
		$logger = Zend_Registry::get('logger');
		$this->initView();
        $this->view->baseUrl = $this->_request->getBaseUrl();
		$logger->info( '"Honglei init!!!"AuthController->init()');
  }

  public function indexAction()
  {
        $this->_redirect('/');
  }

  public function loginAction()
  {
      $logger = Zend_Registry::get('logger');
	    $logger->info( '->Honglei-> AuthController->loginAction()');
		
			$this->view->message = '';
        if ($this->_request->isPost()) {
            // collect the data from the user
            Zend_Loader::loadClass('Zend_Filter_StripTags');
            $filter = new Zend_Filter_StripTags();
            $username = $filter->filter($this->_request->getPost('username'));
            $password = $filter->filter($this->_request->getPost('password'));
            $logger->debug( "**Honglei** AuthController->loginAction() $username/$password");
			
            if (empty($username)) {
                $this->view->message = 'Bitte einen Username eingeben.';
                $logger->info( '->Honglei-> username empty');
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
				    				$logger->info( '**Honglei** AuthController->loginAction() authenticated');
                    // success : store database row to auth's storage system
                    // (not the password though!)
                    $data = $authAdapter->getResultRowObject(null, 'password');
					// $txt = var_export($data,true);
					// $logger->debug( "** $txt");
                    $auth->getStorage()->write($data);
                    $logger->debug(var_export($data,true));
										$uid = $auth->getIdentity()->USER_ID;

                    $this->_redirect("auth/getcc1?uid=$uid");
                    
                    
                } else {
                    // failure: clear database row from session
										$logger->info( '**Honglei** AuthController->loginAction() not authenticated');
                    $this->view->message = 'Fehler bei Ammeldung.';
                }
            }
		}
        $this->view->title = "Anmelden";
        $this->render();
		$logger->info( '<- AuthController->loginAction()');
        
    }

    public function logoutAction()
    {
        Zend_Auth::getInstance()->clearIdentity();
        $this->_redirect('/');
    }
	
		public function createAction()
		{
	   	$logger = Zend_Registry::get('logger');
	    $logger->info( '-> Honglei ->AuthController->createAction()');
		
			$this->view->message = '';
		
      if ($this->_request->isPost()) {
		// collect the data from the user
            Zend_Loader::loadClass('Zend_Filter_StripTags');
            $filter = new Zend_Filter_StripTags();
            $username = $filter->filter($this->_request->getPost('username'));
            $password = $filter->filter($this->_request->getPost('password'));
            $logger->debug( "** AuthController->createAction() $username/$password");
			
			if (empty($username) or empty($password)  ) {
                $this->view->message = 'Bitte Username und Password eingeben.';
		    } else {
			// add new user  to database
				$data = array(
	                 'user_name' => $username,
	                  'user_pwd' => $password
	            );
				
				$db = Zend_Registry::get('db');
	             
				 try {
	              $db->insert('wk_user', $data);
				  			$this->_redirect('/');
				  
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
    $this->render();
		$logger->info( '<- AuthController->createAction()');
		}
	
	  public function getcc1Action()
    {
       $logger = Zend_Registry::get('logger');
	  	 $logger->info( '-> AuthController->getcc1Action()');
	   	//$logger->debug(print_r($_REQUEST));
	   	$request = $this->getRequest();
			$uidParam = $request->getParam('uid');
	   	$cc1 = new Default_Model_Warenkorb();
       $this->view->entries = $cc1->fetchAll($uidParam);
	   
	   $logger->info( '<- AuthController->getcc1Action()');
   	}
   
    public function getcc2Action()
    {
       $logger = Zend_Registry::get('logger');
	   $logger->info( '-> AuthController->getcc2Action()');
	   
	   $request = $this->getRequest();
	   $logger->debug( 'request\n' . var_export($request,true));
	   $cc1Param = $request->getParam('cc1');
	   $logger->info( '-> AuthController->getcc2Action() RequestParam(cc1) = ' . $cc1Param);
	   
	   $cc2 = new Default_Model_Warenkorb();
       $this->view->entries = $cc2->fetchcc2All($cc1Param);
	   
	   $logger->info( '<- AuthController->getcc2Action()');
	   
    }
	
	  public function getcc3Action()
    {
     $logger = Zend_Registry::get('logger');
	   $logger->info( '->Honglei -> AuthController->getcc3Action()');
	   
	   $request = $this->getRequest();
	   $logger->debug( 'request\n' . var_export($request,true));
	   $cc1Param = $request->getParam('cc1');
	   $cc2Param = $request->getParam('cc2');
	   $logger->info( '-> AuthController->getcc3Action() RequestParam(cc1) = ' . $cc1Param . '; RequestParam(cc2) =' . $cc2Param);
	   
	   $cc3 = new Default_Model_Warenkorb();
     $this->view->entries = $cc3->fetchcc3All($cc1Param, $cc2Param);
	   
	   $logger->info( '<- AuthController->getcc3Action()');
	   
    }
    
      public function modifyAction()
  {
        $logger = Zend_Registry::get('logger');
	    	$logger->info( '-> Honglei ->AuthController->modifyAction()');
			
			$auth = Zend_Auth::getInstance();
			$uid = $auth->getIdentity()->USER_ID;
			
			$request = $this->getRequest();
			$cc1_id = $request->getParam('cc1_id');
			$logger->debug( "**$$$$$$$$$$$$$$ AuthController->modifyAction()". $cc1_id);
      
      $modi = new Default_Model_Warenkorb();
      //$this->view->rs = $modi->fetchSingle($uid, $cc1_id);
      $this->view->rs = $modi->fetchSingle($uid, $cc1_id);
      $logger->debug( ' rs @@@' . var_export($this->view->rs,true));
      
      if ($this->_request->isPost()) {
            Zend_Loader::loadClass('Zend_Filter_StripTags');
            $filter = new Zend_Filter_StripTags();
            $flag = $filter->filter($this->_request->getPost('flag')); 
            $wp_id = $filter->filter($this->_request->getPost('wp_id'));   
            $newvpi = $filter->filter($this->_request->getPost('newvpi'));          
            $logger->debug( "**9999999999 AuthController->modifyAction()". $newvpi. '---'.$cc1_id. '---'.$wp_id. '---'.$flag);
           
			$logger->debug( "**7777777777 AuthController->modifyAction()". $uid);
      		// add new user  to database
				$data = array(
	                 'user_id' => $uid,
	                  'wk_id' => $cc1_id,
	                  'ist_vpi' => $newvpi
	            );
				
				$db = Zend_Registry::get('db');
	      
	      if ($flag=='I'){       
        	$db->insert('wk_personal', $data);
        }else{		  	
		  		$db->update('wk_personal', $data, "wp_id=$wp_id");
		  	}
				//	$this->_redirect('/');
					//$this->render();
			 $cc1 = new Default_Model_Warenkorb();
			 $logger->debug( "**pppppppppppppppp AuthController->modifyAction()". $uid);
			 $this->_redirect("auth/getcc1?uid=$uid");

      }
  }
	
  }
?>