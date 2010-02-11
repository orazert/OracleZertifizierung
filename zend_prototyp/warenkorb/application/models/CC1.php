<?php

// application/models/CC1.php

class Default_Model_CC1
{
    protected $_cc1;
    protected $_cc1_bezeichnung;
	protected $_vpi;
	protected $_hvpi;
    protected $_id;
    protected $_mapper;

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
            throw new Exception('Invalid CC1 property');
        }
        $this->$method($value);
    }

    public function __get($name)
    {
        $method = 'get' . $name;
        if (('mapper' == $name) || !method_exists($this, $method)) {
            throw new Exception('Invalid CC1 property');
        }
        return $this->$method();
    }
    public function __toString()
	{
	    return "Default_Model_CC1 { $this->_cc1 | $this->_cc1_bezeichnung |  $this->_vpi |  $this->_hvpi }";
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

    public function setCc1($val)
    {
        $this->_cc1 = $val;
		return $this;
    }
	
    public function getCc1()
    {
        return $this->_cc1;
    }
 
    public function getCc1_vpi()
    {
        return $this->_vpi;
    }
	
	public function setCc1_vpi($val)
    {
        $this->_vpi = $val;
		return $this;
    }
	
    public function getCc1_hvpi()
    {
        return $this->_hvpi;
    }
	
	public function setCc1_hvpi($val)
    {
        $this->_hvpi = $val;
		return $this;
    }
	
	public function setCc1_bezeichnung($val)
    {
        $this->_cc1_bezeichnung = $val;
		return $this;
    }
	
    public function getCc1_bezeichnung()
    {
        return $this->_cc1_bezeichnung;
    }

    public function setId($id)
    {
        $this->_id = (int) $id;
        return $this;
    }

    public function getId()
    {
        return $this->_id;
    }

    public function setMapper($mapper)
    {
        $this->_mapper = $mapper;
        return $this;
    }

    public function getMapper()
    {
        if (null === $this->_mapper) {
            $this->setMapper(new Default_Model_CC1Mapper());
        }
        return $this->_mapper;
    }

    public function save()
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
    }
}
