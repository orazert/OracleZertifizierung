<?php
// application/models/WarenkorbMapper.php


class Default_Model_WarenkorbMapper
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
            $this->setDbTable('Default_Model_DbTable_Warenkorb');
        }
        return $this->_dbTable;
    }
/*
    public function save(Default_Model_warenkorb $warenkorb)
    {
    		$db = Zend_Registry::Get('db');
	    	$sql ="update wk_waren set w_gewicht_vpi=".$warenkorb ->getW_gewicht_vpi()." where w_id=1163";
				$stmt = $db->query($sql);
				$stmt->execute();
		
       $data = array(
            'EMAIL'   => $warenkorb->getEmail(),
            'COMMENTS' => $warenkorb->getComment(),
            ## 'CREATED' => date('Y-m-d H:i:s') ,
        );

        if (null === ($id = $guestbook->getId())) {
            unset($data['id']);
            $this->getDbTable()->insert($data);
        } else {
            $this->getDbTable()->update($data, array('id = ?' => $id));
        }
    }

/*
    public function find($id, Default_Model_Guestbook $guestbook)
    {
        $result = $this->getDbTable()->find(1163);
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        $guestbook->setW_id($row->W_ID)
                  ->setW_gewicht_vpi($row->W_GEWICHT_VPI);
    }

     public function fetchAll()
    {
        $entries   = array();
		$db = Zend_Registry::Get('db');
		//$stmt = $db->query("select wc_id,warencode,wc_bezeichnung,wc_vpi from wk_warencode");
		
		$sql = "select u.user_name user_name, 
									w1.cc1_bezeichnung cc1_bezeichnung,
									p.ist_vpi ist_cc1_vpi, 
									w1.cc1_vpi default_cc1_vpi 
					from wk_cc1 w1, wk_personal p, wk_user u
					where p.wk_id=w1.cc1_id and p.user_id=u.user_id
					order by user_name, p.wk_id";
		$stmt = $db->query($sql);
		
		$stmt->execute();
		
		while ($row = $stmt->fetch()) {
            $entry = new Default_Model_Guestbook();
            $entry ->setUser_name($row['USER_NAME'])
            				->setCc1_bezeichnung($row['CC1_BEZEICHNUNG'])
            				->setIst_cc1_vpi($row['IST_CC1_VPI'])
            				->setDefault_cc1_vpi($row['DEFAULT_CC1_VPI']);
            $entries[] = $entry;
			}
	
        return $entries;
	}
	*/

	
	
		 public function fetchWc()
    {
        $entries   = array();
		$db = Zend_Registry::Get('db');
		
		$sql = "select user_name, cc1_bezeichnung, cc2_bezeichnung, cc3_bezeichnung,wc_bezeichnung,
						ist_vpi, default_vpi from v_waren_person";

		$stmt = $db->query($sql);
		
		$stmt->execute();
		
		while ($row = $stmt->fetch()) {
            $entry = new Default_Model_Warenkorb();
            $entry ->setUser_name($row['USER_NAME'])
            				->setCc1_bezeichnung($row['CC1_BEZEICHNUNG'])
            				->setCc2_bezeichnung($row['CC2_BEZEICHNUNG'])
            				->setCc3_bezeichnung($row['CC3_BEZEICHNUNG'])
            				->setWc_bezeichnung($row['WC_BEZEICHNUNG'])
            				->setIst_vpi($row['IST_VPI'])
            				->setDefault_vpi($row['DEFAULT_VPI']);
            $entries[] = $entry;
			}
			return $entries;
		}
	
			 public function fetchCc3()
    {
        $entries   = array();
		$db = Zend_Registry::Get('db');
		
		$sql = "select user_name, cc1_bezeichnung, cc2_bezeichnung, cc3_bezeichnung,
						ist_vpi, default_vpi
      from v_cc3_person_union";

		$stmt = $db->query($sql);
		
		$stmt->execute();
		
		while ($row = $stmt->fetch()) {
            $entry = new Default_Model_Warenkorb();
            $entry ->setUser_name($row['USER_NAME'])
            				->setCc1_bezeichnung($row['CC1_BEZEICHNUNG'])
            				->setCc2_bezeichnung($row['CC2_BEZEICHNUNG'])
            				->setCc3_bezeichnung($row['CC3_BEZEICHNUNG'])
            				->setIst_vpi($row['IST_VPI'])
            				->setDefault_vpi($row['DEFAULT_VPI']);
            $entries[] = $entry;
			}
        return $entries;
	}
	
	public function fetchCc2()
    {
        $entries   = array();
		$db = Zend_Registry::Get('db');
		
		$sql = "select user_name, cc1_bezeichnung, cc2_bezeichnung,
						ist_vpi, default_vpi
      from v_cc2_person_union";

		$stmt = $db->query($sql);
		
		$stmt->execute();
		
		while ($row = $stmt->fetch()) {
            $entry = new Default_Model_Warenkorb();
            $entry ->setUser_name($row['USER_NAME'])
            				->setCc1_bezeichnung($row['CC1_BEZEICHNUNG'])
            				->setCc2_bezeichnung($row['CC2_BEZEICHNUNG'])
            				->setIst_vpi($row['IST_VPI'])
            				->setDefault_vpi($row['DEFAULT_VPI']);
            $entries[] = $entry;
			}
        return $entries;
	}
	
	
		
	 public function fetchCc1()
    {
        $entries   = array();
		$db = Zend_Registry::Get('db');
		
		$sql = "select user_name, cc1_bezeichnung, ist_vpi, default_vpi
      from v_cc1_person_union";

		$stmt = $db->query($sql);
		
		$stmt->execute();
		
		while ($row = $stmt->fetch()) {
            $entry = new Default_Model_Warenkorb();
            $entry ->setUser_name($row['USER_NAME'])
            				->setCc1_bezeichnung($row['CC1_BEZEICHNUNG'])
            				->setIst_vpi($row['IST_VPI'])
            				->setDefault_vpi($row['DEFAULT_VPI']);
            $entries[] = $entry;
			}
	
        return $entries;
	}
	
	
}
