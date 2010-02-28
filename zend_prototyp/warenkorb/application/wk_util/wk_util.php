<?php

function wk_number_format($strVal)
{
  return str_replace('.',',',sprintf('%6.4F',str_replace(',','.',$strVal)));
}

function wk_check_number($number, $min = 0, $max = 100)
{
   if (empty($number)) {
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