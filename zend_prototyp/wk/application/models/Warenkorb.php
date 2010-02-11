<?php

// application/models/warenkorb.php

class Default_Model_Warenkorb
{
    protected $_comment;
    protected $_mapper;

    protected $_user_name;
    protected $_cc1_bezeichnung;
    protected $_cc2_bezeichnung;
    protected $_cc3_bezeichnung;
    protected $_wc_bezeichnung;   
		protected $_ist_vpi;
		protected $_default_vpi;
									
    public function __construct(array $options = null)
    {
        if (is_array($options)) {
            $this->setOptions($options);
        }
    }

    public function __set($name, $value)
    {
        $method = 'set' . $name;
        if (('mapper' == $name) || !method_exists($this, $method)) {
            throw new Exception('Invalid warenkorb property');
        }
        $this->$method($value);
    }

    public function __get($name)
    {
        $method = 'get' . $name;
        if (('mapper' == $name) || !method_exists($this, $method)) {
            throw new Exception('Invalid warenkorb property (get get)');
        }
        return $this->$method();
    }

    public function setOptions(array $options)
    {
        $methods = get_class_methods($this);
        foreach ($options as $key => $value) {
            $method = 'set' . ucfirst($key);
            if (in_array($method, $methods)) {
                $this->$method($value);
            }
        }
        return $this;
    }



									
    public function setUser_name($text)
    {
        $this->_user_name = (string) $text;
        return $this;
    }

    public function getUser_name()
    {
        return $this->_user_name;
    }
    
    
     public function setCc1_bezeichnung($text)
    {
        $this->_cc1_bezeichnung = (string) $text;
        return $this;
    }

    public function getCc1_bezeichnung()
    {
        return $this->_cc1_bezeichnung;
    }
    
        public function setCc2_bezeichnung($text)
    {
        $this->_cc2_bezeichnung = (string) $text;
        return $this;
    }

    public function getCc2_bezeichnung()
    {
        return $this->_cc2_bezeichnung;
    }
    
        public function setCc3_bezeichnung($text)
    {
        $this->_cc3_bezeichnung = (string) $text;
        return $this;
    }

    public function getCc3_bezeichnung()
    {
        return $this->_cc3_bezeichnung;
    }
    
  
       public function setIst_vpi($text)
    {
        $this->_ist_vpi = $text;
        return $this;
    }

    public function getIst_vpi()
    {
        return $this->_ist_vpi;
    }   
    
    public function setDefault_vpi($text)
    {
        $this->_default_vpi = $text;
        return $this;
    }

    public function getDefault_vpi()
    {
        return $this->_default_vpi;
    }   
    
   
    public function setWc_bezeichnung($text)
    {
        $this->_wc_bezeichnung = (string) $text;
        return $this;
    }

    public function getWc_bezeichnung()
    {
        return $this->_wc_bezeichnung;
    }
    
              
    public function setComment($comment)
    {
        $this->_comment = (string) $comment;
        return $this;
    }

    public function getComment()
    {
        return $this->_comment;
    }

    public function setMapper($mapper)
    {
        $this->_mapper = $mapper;
        return $this;
    }

    public function getMapper()
    {
        if (null === $this->_mapper) {
            $this->setMapper(new Default_Model_WarenkorbMapper());
        }
        return $this->_mapper;
    }

    /*public function save()
    {
        $this->getMapper()->save($this);
    }

    public function find($id)
    {
        $this->getMapper()->find($id, $this);
        return $this;
    }

    public function fetchAll()
    {
        return $this->getMapper()->fetchAll();
    }*/
    

    
    public function fetchWc()
    {
        return $this->getMapper()->fetchWc();
    }
    
    public function fetchCc3()
    {
        return $this->getMapper()->fetchCc3();
    }
    
       public function fetchCc2()
    {
        return $this->getMapper()->fetchCc2();
    }
    
    public function fetchCc1()
    {
        return $this->getMapper()->fetchCc1();
    }
}
