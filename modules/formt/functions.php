<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_FORM', true); 
define("PATH", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_name);
define("PATH2", NV_ROOTDIR . "/modules/" . $module_file . '/template/user/' . $op);
define("MODAL_PATH", NV_ROOTDIR . "/modules/" . $module_file . '/modal/');

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

if (empty($user_info) || !checkIsViewer($user_info['userid'])) {
  include ( NV_ROOTDIR . "/includes/header.php" );
  echo nv_site_theme('Chưa đăng nhập hoặc tài khoản không có quyền truy cập');
  include ( NV_ROOTDIR . "/includes/footer.php" );
}

function formTranslateCode($samplecode) {
  $result = array();
  $sampleListA = explode(', ', $samplecode);
  foreach ($sampleListA as $sampleA) {
    if (strpos($sampleA, '-') !== false) {
      $liberate = '';
      $sampleListB = explode('-', $sampleA);
      if (count($sampleListB) == 2) {
        $sampleFrom = trim($sampleListB[0]);
        $sampleEnd = trim($sampleListB[1]);

        if (strlen($sampleFrom) == strlen($sampleEnd)) {
          $liberateCount = strlen($sampleFrom);
          for ($i = 0; $i < $liberateCount; $i++) {
            if ($sampleFrom[$i] == $sampleEnd[$i]) {
              $liberate .= $sampleFrom[$i];
            }
            else {
              break;
            }
          }

          $liberateCount = strlen($liberate);
          $sampleFrom = intval(substr($sampleFrom, $liberateCount));
          $sampleEnd = intval(substr($sampleEnd, $liberateCount));
          $sampleCount = strlen($sampleEnd);

          if ($sampleFrom && $sampleEnd) {
            // replace 
            if ($sampleFrom > $sampleEnd) {
              $temp = $sampleFrom;
              $sampleFrom = $sampleEnd;
              $sampleEnd = $temp;
            }

            // die("$sampleFrom, $sampleEnd, $sampleCount");

            for ($index = $sampleFrom; $index <= $sampleEnd; $index++) {
              $result []= $liberate . fillZero($index, $sampleCount);
            }
          }
        }
        else {
          $result []= $sampleA;
        }

      }
      else {
        $result []= $sampleA;
        // return false
      }
    }
    else {
      $result []= $sampleA;
    }
  }
  // console.log(result);
  
  // resultChecker = result.length == $number ? true : false
  // if (!resultChecker) {
  //   ('Ký hiệu mẫu không khớp số lượng, ' + result.length + ' trên ' + $number)
  // }

  return $result;
}

function fillZero($number, $length) {
  if (strlen($number) < $length) {
    $new_number = '';
    $zero_number = $length - strlen($number);
    for ($i = 0; $i < $zero_number; $i++) { 
      $new_number .= '0';
    }
    $new_number = $new_number . $number;
    return $new_number;
  }
  return $number;
}
