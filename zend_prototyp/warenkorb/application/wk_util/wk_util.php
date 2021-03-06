<?php

// Text f�r HTML -  Seiten
const WK_TXT_CC1 = 'Warenbereiche';
const WK_TXT_CC2 = 'Warenarten';
const WK_TXT_CC3 = 'Warengruppen';
const WK_TXT_WAREN = 'Waren';

// Konstanten f�t Column user_def
const WK_VAL_DEFAULT = '0'; // Default Wert
const WK_VAL_USER = '1'; // Benutzerdefinierter Wert
const WK_VAL_USER_SUB = '7'; // Benutzerdefinierte Werte in unteren Ebenen
const WK_VAL_DIFF_ROW = '8'; // Dummy Row Sonstiges cc1 id = 99
const WK_VAL_NOT_EDITABLE = '9'; // Wert nicht  editierbar

function wk_number_format($strVal, $scale = 2)
{ 
  $num_digits = $scale + 2;
  $fstr = '%'.$num_digits . '.' . $scale . 'F';
  return str_replace('.',',',sprintf($fstr,str_replace(',','.',$strVal)));
}

function wk_empty($str)
{
   if (isset($str) and is_string($str) and strlen($str)) {
       return false;
   }
   return true;
}

function wk_check_number($number, $min = 0, $max = 100)
{
   if (wk_empty($number)) {
       return "Bitte eine Zahl eingeben";
   }
   $num = str_replace(',','.',$number);
   if ( !is_numeric($num)) {
       return "Bitte eine Zahl eingeben";
   }
   /*
   if ( !($min <= $num and $num <= $max)) {
      return "Bitte eine Zahl im Bereich von $min bis $max  eingeben";
   } */
   return null;
}

function wk_to_float($strVal)
{
   $floatVal = (float)str_replace(',','.',$strVal);
   return $floatVal;
}

function wk_calc_max_user_val($strOldVal,$stId99Val,$deltaSubVal)
{
   $logger = Zend_Registry::get('logger');
   $logger->debug("-> wk_calc_max_user_val(strOldVal=$strOldVal,stId99Val=$stId99Val,deltaSubVal = $deltaSubVal)");
   $maxVal = wk_to_float($strOldVal);
   $id99Val = wk_to_float($stId99Val);
   if ( $id99Val >= 0 ) {
      $oldVal = wk_to_float($strOldVal);
	  $deltaVal = wk_to_float($deltaSubVal);
      //$maxVal = $oldVal + $id99Val - $deltaVal;
	  $maxVal = $oldVal + $id99Val;
   }
   $logger->debug("<- wk_calc_max_user_val() maxVal = $maxVal");
   //return sprintf('%F',$maxVal);
   return wk_number_format(sprintf('%F',$maxVal),4);
}
?>