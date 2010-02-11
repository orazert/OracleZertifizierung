<?php
class Default_Adapter_Oracle extends Zend_Db_Adapter_Oracle
{

$options = array(
    Zend_Db::AUTO_QUOTE_IDENTIFIERS => false
);

$params = array(
    'dbname'         => 'blumpf',
    'options'        => $options
);
}