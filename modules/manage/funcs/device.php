<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');
$page_title = "Quản lý thiết bị";
checkMember();
$excel = $nv_Request->get_int('excel', 'get');
$action = $nv_Request->get_string('action', 'post', '');
if ($nv_Request->get_int('excel', 'get')) {
  header('location: /excel-output.xlsx?t=' . time());
}
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'excel':
      $xco = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
      $title = array('STT', 'Tài sản', 'Quy cách', 'ĐVT', 'Số lượng', 'Năm sử dụng', 'Nguồn cung cấp', 'Ghi chú');
      $depart = $nv_Request->get_int('depart', 'post');

      include NV_ROOTDIR . '/PHPExcel/IOFactory.php';
      $fileType = 'Excel2007'; 
      $objPHPExcel = PHPExcel_IOFactory::load(NV_ROOTDIR . '/excel.xlsx');
    
      $i = 1;
      if ($depart) {
        $query = $db->query('select * from `'. PREFIX .'depart` where id = ' . $depart);
        $depart = $query->fetch();
        deviceParseExcel($depart);
      }
      else {
        $query = $db->query('select * from `'. PREFIX .'depart`');
        while ($depart = $query->fetch()) {
          deviceParseExcel($depart);
        }
      }
      $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
      $objWriter->save(NV_ROOTDIR . '/excel-output.xlsx');
      $objPHPExcel->disconnectWorksheets();
      unset($objWriter, $objPHPExcel);
      $result['status'] = 1;
    break;
    // case 'insert-item':
    //   $data = $nv_Request->get_array('data', 'post');

    //   if (!strlen($data['name'])) {
    //     $result['notify'] = 'Tên thiết bị trống';
    //   }
    //   else if (checkItemName($data['name'])) {
    //     $result['notify'] = 'Trùng tên thiết bị';
    //   }
    //   else {
    //     // insert
    //     $sql = 'insert into `'. PREFIX .'item` (name, unit, company, description) values("'. $data['name'] .'", "'. $data['unit'] .'", "'. checkCompany($data['company']) .'", "'. $data['description'] .'")';
    //     if ($query = $db->query($sql)) {
    //       $id = $db->lastInsertId();
    //       $sql = 'insert into `'. PREFIX .'item_detail` (item_id, number, date, status) values ('. $id .', '. $data['number'] .', '. strtotime(date('Y/m/d')) .', "'. $data['status'] .'")';
    //       if ($db->query($sql)) {
    //         $result['status'] = 1;
    //         $result['notify'] = 'Đã thêm';
    //         $result['id'] = $db->lastInsertId();
    //       }
    //     }
    //   }
    // break;
    case 'insert-depart':
      $name = $nv_Request->get_string('name', 'post', '');
      $name = ucwords($name);
       
      if (checkDepartName($name)) {
        $result['notify'] = 'Đơn vị đã tồn tại';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'depart` (name, update_time) values("'. $name .'", '. time() .')');
        if ($query) {
          $result['status'] = 1;
          $result['inserted'] = array('id' => $db->lastInsertId(), 'name' => $name);
          $result['notify'] = 'Đã thêm đơn vị';
        }
      }
    break;
    case 'insert-device':
      $data = $nv_Request->get_array('data', 'post');
      // if (checkDeviceName($data['name'])) {
      //   $result['notify'] = 'Thiết bị đã tồn tại';
      // }
      // else {
        foreach ($data as $name => $value) {
          if (!($name == 'depart' || $name == 'description')) checkRemind($name, $value);
        }
        if (empty($data['depart'])) $data['depart'] = array();
        $sql = 'insert into `'. PREFIX .'device` (name, unit, number, year, intro, status, depart, source, description, import_time, update_time) values("'. $data['name'] .'", "'. $data['unit'] .'", "'. $data['number'] .'", "'. $data['year'] .'", "'. $data['intro'] .'", "'. $data['status'] .'", \''. json_encode($data['depart']) .'\', "'. $data['source'] .'", "'. $data['description'] .'", '. totime($data['import']) .', '. time() .')';
        // die($sql);
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = deviceList();
          $result['notify'] = 'Đã thêm thiết bị';
        }
      // }
    break;
    case 'edit-device':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');
      // if (checkDeviceName($data['name'], $id)) {
      //   $result['notify'] = 'Thiết bị đã tồn tại';
      // }
      // else {
        foreach ($data as $name => $value) {
          if (!($name == 'depart' || $name == 'description')) checkRemind($name, $value);
        }
        if (empty($data['depart'])) $data['depart'] = array();
        $sql = 'update `'. PREFIX .'device` set name = "'. $data['name'] .'", unit = "'. $data['unit'] .'", number = "'. $data['number'] .'", year = "'. $data['year'] .'", intro = "'. $data['intro'] .'", status = "'. $data['status'] .'", depart = \''. json_encode($data['depart']) .'\', source = "'. $data['source'] .'", description = "'. $data['description'] .'", import_time = "'. totime($data['import']) .'", update_time = '. time() .' where id = ' . $id;
        // die($sql);
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = deviceList();
          $result['notify'] = 'Đã thêm thiết bị';
        }
      // }
    break;
    case 'get-device':
      $id = $nv_Request->get_int('id', 'post');

      if ($data = getDeviceData($id)) {
        $data['import'] = date('d/m/Y', $data['import_time']);
        unset($data['import_time']);
        unset($data['update_time']);
        $result['status'] = 1;
        $result['device'] = $data;
      }
    break;
    case 'remove-device':
      $id = $nv_Request->get_int('id', 'post');

      if ($db->query('delete from `'. PREFIX .'device` where id = ' . $id)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa';
        $result['html'] = deviceList();
      }
    break;
    case 'remove-all-device':
      $list = $nv_Request->get_array('list', 'post');
      $count = count($list);
      $removed = 0;

      foreach ($list as $id) {
        if ($db->query('delete from `'. PREFIX .'device` where id = ' . $id)) {
          $removed ++;
        }
      }
      $result['status'] = 1;
      $result['notify'] = "Đã xóa $removed trong tổng số $count đã chọn";
      $result['html'] = deviceList();
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = deviceList();
    break;
    case 'transfer':
      $data = $nv_Request->get_array('data', 'post');
      $depart = array();
      $depart[]= $data['depart'];

      $sql = 'update `'. PREFIX .'device` set depart = \'' . json_encode($depart) . '\' where id = ' . $data['id'];
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = deviceList();
      }
    break;
  }
  echo json_encode($result);
  die();
}


if (empty($user_info)) {
  // check if logged
  $contents = 'Đăng nhập trước khi sử dụng chức năng';

  include NV_ROOTDIR . '/includes/header.php';
  echo nv_site_theme($contents);
  include NV_ROOTDIR . '/includes/footer.php';
  die();
}
else {
  // check if administrator
  $sql = 'select * from `'. $db_config['prefix'] .'_users` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $user = $query->fetch();
  $group = explode(',', $user['in_groups']);

  if (!in_array('1', $group)) {
    // check if is allowed
    $sql = 'select * from `'. PREFIX .'devicon` where userid = ' . $user_info['userid'];
    $query = $db->query($sql);
    $devicon = $query->fetch();

    if (!$devicon['level']) {
      // not allow
      $contents = 'Tài khoản không được cấp quyền truy cập';

      include NV_ROOTDIR . '/includes/header.php';
      echo nv_site_theme($contents);
      include NV_ROOTDIR . '/includes/footer.php';
      die();
    }
  }
}

$query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
$user = $query->fetch();
$authors = json_decode($user['author']);

$xtpl = new XTemplate("main.tpl", PATH);
if ($authors->{device} == 2) {
  $xtpl->assign('excel_modal', excelModal());
  $xtpl->assign('device_modal', deviceModal());
  $xtpl->assign('remove_modal', removeModal());
  $xtpl->assign('remove_all_modal', removeAllModal());
  $xtpl->assign('transfer_modal', transferModal());
  $xtpl->assign('filter_modal', loadModal('filter-modal'));
  $xtpl->parse('main.v1');
  $xtpl->parse('main.v2');
}
$xtpl->assign('content', deviceList());
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('depart', json_encode(getUserDepartList(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('remind', json_encode(getRemind(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('remindv2', json_encode(getRemindv2(), JSON_UNESCAPED_UNICODE));
// $xtpl->assign('depart_modal', departmodal());
// $xtpl->assign('item', json_encode(getItemDataList(), JSON_UNESCAPED_UNICODE));
// $xtpl->assign('import', importModal());
// $xtpl->assign('import_insert', importInsertModal());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
