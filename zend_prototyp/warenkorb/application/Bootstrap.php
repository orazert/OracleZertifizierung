<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    protected function _initAutoload()
    {
    require_once 'Zend/Db.php';
	
	   $logger = new Zend_Log();
	   $writer = new Zend_Log_Writer_Stream(APPLICATION_PATH .'\logs\zend_log.txt');
       $logger->addWriter($writer);
	   //$filter = new Zend_Log_Filter_Priority(Zend_Log::INFO);
       //$logger->addFilter($filter);
	   Zend_Registry::set('logger', $logger);
       $logger->info('Zend_Application_Bootstrap_Bootstrap->_initAutoload()');

        $options = array(
          Zend_Db::CASE_FOLDING => Zend_Db::CASE_UPPER,
          Zend_Db::AUTO_QUOTE_IDENTIFIERS => false,
        );
        
        $params = array ('dbname' => $config->application->mydbname,
                         'username' => 'wk', ## $config->application->myusername, 
                         'password' => 'wk', ## $config->application->mypassword,
                         'options'  => $options
                         );
       
        $db = Zend_Db::factory('oracle', $params);
        Zend_Db_Table_Abstract::setDefaultAdapter($db);


        $autoloader = new Zend_Application_Module_Autoloader(array(
            'namespace' => 'Default',
            'basePath'  => dirname(__FILE__),
        ));
		
        return $autoloader;
    }

    protected function _initDoctype()
    {
        $this->bootstrap('view');
        $view = $this->getResource('view');
        $view->doctype('XHTML1_STRICT');
    }
}

