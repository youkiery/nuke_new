<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_FORM')) {
	die('Stop!!!');
}

define('READ_ONLY', 1);
define('MODIFY', 2);

$page_title = "Khóa văn bản";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'update':
      $data = $nv_Request->get_array('data', 'post');

      if (count($data) > 0) {
        $time = totime($data['locker']);
          if (empty($data['checker'])) {
            $time = 0;
            $data['auto'] = 0;
          }
          if ($data['locker'])
          $sql = 'update `'. $db_config['prefix'] .'_config` set config_value = "'. $time .'" where config_name = "locked_time"';
          $sql2 = 'update `'. $db_config['prefix'] .'_config` set config_value = "'. $data['auto'] .'" where config_name = "auto_locker"';
          if ($db->query($sql) && $db->query($sql2)) {
            $result['status'] = 1;
          }
      }
		break;
	}

	echo json_encode($result);
	die();
}

// $admin_info['in_groups'] = array('1');
$sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $admin_info['userid'];
$query = $db->query($sql);
$adin = $query->fetch();

// if (in_array('1', $admin_info['in_groups']) || $adin['admin'] > 0) {
if (1) {
  $xtpl = new XTemplate("locked.tpl", PATH);

  $locked_time = getLocker();
  $auto_locker = getAutolocker();

  $xtpl->assign('checked', '');
  $xtpl->assign('lchecked', 'disabled');

  if ($auto_locker) {
    $xtpl->assign('autolocker', 'checked');
  }
  else { $xtpl->assign('autolocker', ''); }

  if ($locked_time > 0) {
    $xtpl->assign('checked', 'checked');
    if (!$auto_locker) {
      $xtpl->assign('lchecked', '');
    }
  }
  else {
    $xtpl->assign('autolocker', 'disabled');
    $locked_time = time();
  }

  $xtpl->assign('locked', date('d/m/Y', $locked_time));
  $xtpl->parse("main");
  $contents = $xtpl->text("main");
}
else {
  // không phải admin tối cao
  $contents = 'Tài khoản không có quyền truy cập';
}


include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");