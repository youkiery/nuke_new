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
