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

$page_title = "Nhập hồ sơ một chiều";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'search':
			$key = $nv_Request->get_string('key', 'get/post', '');

			$result['status'] = 1;
			$result['html'] = employerList($key);
		break;
		case 'getPermission':
			$id = $nv_Request->get_string('id', 'get/post', '');

			$result['status'] = 1;
			$result['permist'] = getUserPermission($id);
		break;
		case 'savePermission':
			$userid = $nv_Request->get_string('userid', 'get/post', '');
			$permissionData = $nv_Request->get_string('permissionData', 'get/post', '');

			$sql = 'update `'. $db_config['prefix'] .'_user_allow` set former = "'. $permissionData .'" where module = 1 and userid = ' . $userid;
			if ($db->query($sql)) {
				$result['status'] = 1;
				$result['html'] = employerList();
			}
		break;
		case 'filterEmploy':
			$key = $nv_Request->get_string('key', 'get/post', '');

			$result['status'] = 1;
			$result['html'] = notAllowList($key);
		break;
		case 'addEmploy':
			$userid = $nv_Request->get_string('userid', 'get/post', '');
			$key = $nv_Request->get_string('key', 'get/post', '');

			if (checkEmptyPemission($userid)) {
				$sql = 'insert into `'. $db_config['prefix'] .'_user_allow` (userid, module, type) values('.$userid.', '. PERMISSION_MODULE .', 1)';
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['html'] = employerList($key);
					$result['notify'] = 'Đã thêm nhân viên mới';
				}
			}
		break;
		case 'removeUser':
			$userid = $nv_Request->get_string('userid', 'get/post', '');
			$key = $nv_Request->get_string('key', 'get/post', '');

			if ($id = checkUserPermission($userid)) {
				$sql = 'delete from `'. $db_config['prefix'] .'_user_allow` where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['html'] = employerList($key);
					$result['notify'] = 'Đã bỏ quyền thành viên';
				}
			}
		break;
		case 'upUser':
			$userid = $nv_Request->get_string('userid', 'get/post', '');
			$key = $nv_Request->get_string('key', 'get/post', '');

			if ($id = checkUserPermission($userid)) {
				$permission = getUserType($userid);
				if ($permission < 5) {
					$permission ++;
				}
				$sql = 'update `'.$db_config['prefix'].'_user_allow` set type = '. $permission .' where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['html'] = employerList($key);
				}
			}
		break;
		case 'downUser':
			$userid = $nv_Request->get_string('userid', 'get/post', '');
			$key = $nv_Request->get_string('key', 'get/post', '');

			if ($id = checkUserPermission($userid)) {
				$permission = getUserType($userid);
				if ($permission > 0) {
					$permission --;
				}
				$sql = 'update `'.$db_config['prefix'].'_user_allow` set type = '. $permission .' where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['html'] = employerList($key);
				}
			}
		break;
		case 'admin':
			$userid = $nv_Request->get_string('userid', 'get/post', '');
			$type = $nv_Request->get_string('type', 'get/post', '');
			$key = $nv_Request->get_string('key', 'get/post', '');

      // $admin_info['in_groups'] = array(1);
			if (in_array('1', $admin_info['in_groups'])) {
        $sql = 'update `'. $db_config['prefix'] .'_user_allow` set admin = ' . $type . ' where userid = ' . $userid;

        if ($db->query($sql)) {
          $result['status'] = 1;
					$result['html'] = employerList($key);
        }
        // die($sql);
			}
		break;
				case 'salary':
			$userid = $nv_Request->get_string('userid', 'get/post', 0);
			$type = $nv_Request->get_int('type', 'get/post', 0);
			$key = $nv_Request->get_string('key', 'get/post', '');

			// if (in_array('1', $admin_info['in_groups'])) {
        $sql = 'update `'. $db_config['prefix'] .'_user_allow` set salary = ' . intval(!$type) . ' where userid = ' . $userid;
        if ($db->query($sql)) {
          $result['status'] = 1;
					$result['html'] = employerList($key);
        }
        // die($sql);
			// }
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign('content', employerList());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");