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

$page_title = "Danh sách khóa văn bản";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'filter':
			$filter = $nv_Request->get_array('filter', 'post');

			$result['status'] = 1;
			$result['html'] = lockerList($filter);
		break;
		case 'lock':
			$id = $nv_Request->get_int('id', 'post');
			$type = $nv_Request->get_int('type', 'post', 0);
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'update `'. PREFIX .'_row` set locker = ' . $type . ' where id = ' . $id;
			if ($db->query($sql)) {
				$result['status'] = 1;
				$result['html'] = lockerList($filter);
			}
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate('main.tpl', PATH2);
$xtpl->assign('content', lockerList());

$xtpl->parse('main');
$contents = $xtpl->text();

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");