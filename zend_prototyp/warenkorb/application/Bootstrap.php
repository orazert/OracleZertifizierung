<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    protected function _initAutoload()
    {
    require_once 'Zend/Db.php';
	
	   $config = new Zend_Config_ini(APPLICATION_PATH . '\configs\application.ini','development');
	   
	    // logging
	   $logger = new Zend_Log();
	   $writer = new Zend_Log_Writer_Stream($config->logger->filename);
       $logger->addWriter($writer);
	   $filter = new Zend_Log_Filter_Priority((int)$config->logger->priority);
       $logger->addFilter($filter);
       
	   Zend_Registry::set('logger', $logger);
	   $logger->info('****************************************************************************************');
       $logger->info('--> Zend_Application_Bootstrap_Bootstrap->_initAutoload()');
       
		$options = array(
          Zend_Db::CASE_FOLDING => Zend_Db::CASE_LOWER,
          Zend_Db::AUTO_QUOTE_IDENTIFIERS => false,
        );
        
		// database
		$dbname = $config->database->name;
		$dbuser = $config->database->user;
		$dbpassword = $config->database->password;
		$pkg = $config->database->package;
		Zend_Registry::set('pkg', $pkg);
		
		$logger->debug("Zend_Application_Bootstrap_Bootstrap->_initAutoload() Oracle: dbname = $dbname, dbuser = $dbuser pkg = $pkg");
		
        $params = array ('dbname' =>  $dbname,
                         'username' => $dbuser,
                         'password' => $dbpassword,
                         'options'  => $options
                         );
       
        $db = Zend_Db::factory('oracle', $params);
        Zend_Db_Table_Abstract::setDefaultAdapter($db);
		Zend_Registry::set('db', $db);

$opts = new Zend_Console_Getopt('abp:');
$opts->setOption('ignoreCase', true);
         
		// correlation
		$corrFct = $config->corr->fct;
        $corrData = $config->corr->data;
		Zend_Registry::set('corrFct', $corrFct);
		Zend_Registry::set('corrData', $corrData);
		$logger->debug("Zend_Application_Bootstrap_Bootstrap->_initAutoload() Corr: corrFct = $corrFct, corrData = $corrData");
		
        $autoloader = new Zend_Application_Module_Autoloader(array(
            'namespace' => 'Default',
            'basePath'  => dirname(__FILE__),
        ));
		$logger->info('<- Zend_Application_Bootstrap_Bootstrap->_initAutoload()');
        return $autoloader;
    }

    protected function _initDoctype()
    {
        $this->bootstrap('view');
        $view = $this->getResource('view');
        $view->doctype('XHTML1_STRICT');
    }
}

