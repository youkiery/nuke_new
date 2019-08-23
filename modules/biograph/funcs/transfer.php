<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}

$page_title = "autoload";

$action = $nv_Request->get_string('action', 'post', '');
$userinfo = getUserInfo();
if (empty($userinfo)) {
	header('location: /' . $module_name . '/login/');
	die();
}
else {
  if ($userinfo['center']) {
    header('location: /biograph/center');
  }
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'filter':

		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("transfer.tpl", "modules/biograph/template");

$xtpl->assign('content', transferList($userinfo['id']));
$xtpl->assign('origin', '/' . $module_name . '/' . $op . '/');

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");