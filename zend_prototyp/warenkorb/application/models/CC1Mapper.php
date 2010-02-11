<?php
// application/models/CC1Mapper.php


class Default_Model_CC1Mapper
{
    protected $_dbTable;

    public function setDbTable($dbTable)
    {
        if (is_string($dbTable)) {
            $dbTable = new $dbTable();
        }
        if (!$dbTable instanceof Zend_Db_Table_Abstract) {
            throw new Exception('Invalid table data gateway provided');
        }
        $this->_dbTable = $dbTable;
        return $this;
    }

    public function getDbTable()
    {
        if (null === $this->_dbTable) {
            $this->setDbTable('Default_Model_DbTable_CC1');
        }
        return $this->_dbTable;
    }


    public function save(Default_Model_CC1 $cc1)
    {
        $data = array(
            'CC1'   => $cc1->getCc1(),
            'CC1_BEZEICHNUNG'  => $cc1->getCc1_bezeichnung(),
			'CC1_VPI' => $cc1->getVpi(),
			'CC1_HVPI' => $cc1->getHvpi()
        );
		
		print_r($data);

        if (null === ($id = $cc1->getId())) {
            unset($data['id']);
            $this->getDbTable()->insert($data);
        } else {
            $this->getDbTable()->update($data, array('id = ?' => $id));
        }
    }

    public function fetchAll()
    {
       $logger = Zend_Registry::get('logger');
	   $logger->debug( '-> Default_Model_CC1Mapper->fetchAll()');

		$resultSet = $this->getDbTable()->fetchAll();
        $entries   = array();
        foreach ($resultSet as $row) {
            $entry = new Default_Model_CC1();
            $entry ->setId($row->CC1_ID)
                  ->setCc1($row->CC1)
                  ->setCc1_bezeichnung($row->CC1_BEZEICHNUNG)
				  ->setCc1_vpi($row->CC1_VPI)
				  ->setCc1_hvpi($row->CC1_HVPI)
                  ->setMapper($this);
            $entries[] = $entry;
			$logger->debug( 'Default_Model_CC1Mapper->fetchAll() entry = '. $entry->__toString());
        }
         $logger->debug( '<- Default_Model_CC1Mapper->fetchAll()');
        return $entries;
    }
}
