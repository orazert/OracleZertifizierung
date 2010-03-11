<?php

// Text für HTML -  Seiten
const WK_TXT_CC1 = 'Warenbereiche';
const WK_TXT_CC2 = 'Warenarten';
const WK_TXT_CC3 = 'Warengruppen';
const WK_TXT_WAREN = 'Waren';

// Konstanten füt Column user_def
const WK_VAL_DEFAULT = '0'; // Default Wert
const WK_VAL_USER = '1'; // Benutzerdefinierter Wert
const WK_VAL_DIFF_ROW = '8'; // Dummy Row Sonstiges cc1 id = 99
const WK_VAL_NOT_EDITABLE = '9'; // Wert nicht  editierbar

function wk_number_format($strVal, $scale = 4)
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
   if ( !($min <= $num and $num <= $max)) {
      return "Bitte eine Zahl im Bereich von $min bis $max  eingeben";
   }
   return null;
}

?>