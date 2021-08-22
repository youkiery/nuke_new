<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_MAINFILE')) { die('Stop!!!'); }
define('PREFIX', $db_config['prefix'] . '_' . $module_name . '_');
define('PATH2', NV_ROOTDIR . "/modules/". $module_file ."/template");

function all($sql) {
  global $db;
  $list = array();
  $query = $db->query($sql);
  while ($row = $query->fetch()) $list []= $row;
  return $list;
}

function fetch($sql) {
  global $db;

  $query = $db->query($sql);
  return $query->fetch();
}

function cmp($a, $b) {
  return $a['date'] > $b['date'];
}

function loadModal($name) {
  $xtpl = new XTemplate($name . ".tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function totime($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    if (!$time) {
      $time = time();
    }
  }
  else {
    $time = time();
  }
  return $time;
}

function totimev2($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    if (!$time) {
      $time = 0;
    }
  }
  else {
    $time = 0;
  }
  return $time;
}

function simplize($str) {
  $str = mb_strtolower($str);
  $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", "a", $str);
  $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", "e", $str);
  $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", "i", $str);
  $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", "o", $str);
  $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", "u", $str);
  $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", "y", $str);
  $str = preg_replace("/(đ)/", "d", $str);
  //$str = str_replace(" ", "-", str_replace("&*#39;","",$str));
  return $str;
}


function checkDeviceName($name, $id = 0) {
  global $db;

  $xtra = '';
  if ($id) {
    $xtra = ' and id <> ' . $id;
  }
  $query = $db->query('select * from `pet_manage_device` where name = "'. $name . '"' . $xtra);
  if ($query->fetch()) {
    return true;
  }
  // die('select * from `pet_manage_device` where name = "'. $name . '"');
  return false;
}

function checkRemind($name, $value) {
  global $db;

  $query = $db->query('select * from `pet_manage_remind` where name = "'. $name .'" and value = "'. $value .'"');

  if (!($row = $query->fetch())) {
    $query = $db->query('insert into `pet_manage_remind` (name, value) values("'. $name .'", "'. $value .'")');
  }
  else {
    $query = $db->query('update `pet_manage_remind` set rate = rate + 1 where id = ' . $row['id']);
  }
}

function getRemind() {
  global $db;

  $query = $db->query('select * from `pet_manage_remind` group by name order by rate desc');
  $list = array();
  while ($row = $query->fetch()) {
    $list[$row['name']] = $row['value'];
  }
  return $list;
}

function getRemindv2() {
  global $db;

  $query = $db->query('select * from `pet_manage_remind`');
  $list = array();
  while ($row = $query->fetch()) {
    if (empty($list[$row['name']])) $list[$row['name']] = array();
    $list[$row['name']][] = $row['value'];
  }
  return $list;
}

function getDeviceData($id) {
  global $db;

  $query = $db->query('select * from `pet_manage_device` where id = '. $id);
  if ($row = $query->fetch()) {
    $row['depart'] = json_decode($row['depart']);
    return $row;
  }
  return false;
}

function checkDepartName($name, $id = 0) {
  global $db;

  if ($id) $sql = 'select * from `pet_manage_device_depart` where name = "'. $name .'" and id <> ' . $id;
  else $sql = 'select * from `pet_manage_device_depart` where name = "'. $name .'"';
  $query = $db->query($sql);
  if ($query->fetch()) {
    return true;
  }
  return false;
}

function checkDepartId($id) {
  global $db;

  $query = $db->query('select * from `pet_manage_depart` where id = ' . $id);
  if ($row = $query->fetch()) {
    return $row['name'];
  }
  return '';
}

function checkItemName($name) {
  global $db;

  $query = $db->query('select * from `pet_manage_item` where name = "'. $name .'"');
  if ($row = $query->fetch()) return $row['id'];
  return false;
}

function checkCompany($name) {
  global $db;

  if (empty($name)) return 0;
  $query = $db->query('select * from `pet_manage_company` where name = "'. $name .'"');
  if ($row = $query->fetch()) {
    return $row['id'];
  }
  else {
    // die('insert into `pet_manage_company` (name) values("'. $name .'")');
    $query = $db->query('insert into `pet_manage_company` (name) values("'. $name .'")');
    if ($query) return $row->lastInsertId();
  }
  return 0;
}

function getItemData($id) {
  global $db;
  $empty = 'chưa xác định';

  if (empty($id)) return $empty;
  $query = $db->query('select * from `pet_manage_item` where id = '. $id);
  if ($row = $query->fetch()) {
    return $row;
  }
  return $empty;
}

function getCompanyName($id) {
  global $db;
  $empty = 'chưa xác định';

  if (empty($id)) return $empty;
  $query = $db->query('select * from `pet_manage_company` where id = '. $id);
  if ($row = $query->fetch()) {
    return $row['name'];
  }
  return $empty;
}

function parseFilter($name) {
  global $nv_Request;
  $filter = $nv_Request->get_array($name . '_filter', 'post');

  if (empty($filter['page']) || $filter['page'] < 1) {
    $filter['page'] = 1;
  }
  if (empty($filter['limit']) || $filter['limit'] < 10) {
    $filter['limit'] = 10;
  }
  return $filter;
}

function getImportData($id) {
  global $db;

  $query = $db->query('select * from `pet_manage_import_detail` where import_id = '. $id);
  $data = array('total' => 0, 'count' => 0);
  while ($row = $query->fetch()) {
    $data['count'] ++;
    $data['total'] += $row['number'];
  }
  return $data;
}

function getExportData($id) {
  global $db;

  $query = $db->query('select * from `pet_manage_export_detail` where export_id = '. $id);
  $data = array('total' => 0, 'count' => 0);
  while ($row = $query->fetch()) {
    $data['count'] ++;
    $data['total'] += $row['number'];
  }
  return $data;
}

function spat($number, $str) {
  $string = '';
  for ($i = 0; $i < $number; $i++) { 
    $string .= $str;
  }
  return $string;
}

function getItemDataList() {
  global $db;

  $list = array();
  $query = $db->query('select * from `pet_manage_material`');
  while ($row = $query->fetch()) {
    $list []= $row;
  }
  return $list;
}

function checkItemId($item_id, $item_date, $item_status) {
  global $db;

  // die('select * from `pet_manage_item_detail` where item_id = '. $item_id .' and date = '. $item_date .' and status = "'. $item_status .'"');
  $query = $db->query('select * from `pet_manage_item_detail` where item_id = '. $item_id .' and date = '. $item_date .' and status = "'. $item_status .'"');
  if ($row = $query->fetch()) {
    return $row['id'];
  }
  $query = $db->query('insert into `pet_manage_item_detail` (item_id, number, date, status) values ('. $item_id .', 0, '. $item_date .', "'. $row['status'] .'")');
  if ($query) return $db->lastInsertId();  
  return 0;
}

function getItemDatav2($id) {
  global $db;

  $query = $db->query('select * from `pet_manage_material` where id = ' . $id);
  if ($row = $query->fetch()) {
    return $row;
  }
  return false;
}

// function getImportData($id) {
//   global $db;

//   $query = $db->query('select * from `pet_manage_import_detail` where id = ' . $id);
//   if ($row = $query->fetch()) {
//     return $row;
//   }
//   return false;
// }

function checkItemIndex($list, $id) {
  global $db;

  $itemData = getItemDatav2($id);

  foreach ($list as $index => $row) {
    if ($row['id'] === $itemData['id']) {
      return $index;
    }
  }
}

function getUserDepartList() {
  global $db, $user_info;

  $query = $db->query('select * from `pet_manage_member` where userid = '. $user_info['userid']);
  $user = $query->fetch();
  $author = json_decode($user['author']);

  $xtra = ' where id in ('. implode(', ', $author->{'depart'}) .') ';
  
  $list = array();
  $query = $db->query('select * from `pet_manage_depart`'. $xtra);
  while($row = $query->fetch()) {
    $list []= $row;
  }
  return $list;
}

function getDepartList() {
  global $db;

  $query = $db->query('select * from `pet_manage_device_depart`');
  $list = array();

  while($row = $query->fetch()) {
    $list []= $row;
  }
  return $list;
}

function getDepartidList() {
  global $db;

  $query = $db->query('select * from `pet_manage_depart`');
  $list = array();

  while($row = $query->fetch()) {
    $list []= $row['id'];
  }
  return $list;
}

function checkMaterialName($name, $id = 0) {
  global $db;

  if ($id) {
    $query = $db->query('select * from `pet_manage_material` where name = "'. $name .'" and active = 1 and id <>' . $id);
  }
  else {
    $query = $db->query('select * from `pet_manage_material` where name = "'. $name .'" and active = 1');
  }
  if ($row = $query->fetch()) return $row['id'];
  return false;
}

function getMaterialDataList() {
  global $db;

  $list = array();
  $sql = 'select * from `pet_manage_material` where active = 1';
  $query = $db->query($sql);
  // insert link
  while ($row = $query->fetch()) {
    $sql = 'select * from `pet_manage_material_detail` where number > 0 and materialid = '. $row['id'];
    $detail_query = $db->query($sql);
    $detail_list = array();

    while ($detail = $detail_query->fetch()) {
      $detail_list []= $detail;
    }
    // var_dump($detail_list);die();
    $row['detail'] = $detail_list;
    $row['alias'] = simplize($row['name']);
    $list []= $row;
  }
  // var_dump($list);die();
  return $list;
}

function checkItem($id) {
  global $db;

  $sql = "select * from `pet_manage_material` where id = $id";
  $query = $db->query($sql);
  if ($row = $query->fetch()) {
    return $row;
  }
  return array();
}

function deviceParseExcel($depart) {
  global $db, $objPHPExcel, $i, $j, $xco, $titles;
  $device_query = $db->query('select * from `pet_manage_device` where depart like \'%"'. $depart['id'] .'"%\' limit 1');
  if ($device_query->fetch()) {
    $device_query = $db->query('select * from `pet_manage_device` where depart like \'%"'. $depart['id'] .'"%\'');
    $j = 0;
    $objPHPExcel
    ->setActiveSheetIndex(0)
    ->setCellValue($xco['0'] . $i, 'DANH MUC TÀI SẢN KIỂM KÊ PHÒNG '. $depart['name'] .' NĂM ' . date('Y', time()));
    $i += 2;

    foreach ($titles as $value) {
      $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue($xco[$j++] . $i, $value);
    }
    $i++;

    $index = 1;
    $count = 0;
    while ($device = $device_query->fetch()) {
      $j = 0;
      $count += $device['number'];
      $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue($xco[$j++] . $i, $index++)
      ->setCellValue($xco[$j++] . $i, $device['name'])
      ->setCellValue($xco[$j++] . $i, $device['intro'])
      ->setCellValue($xco[$j++] . $i, $device['unit'])
      ->setCellValue($xco[$j++] . $i, $device['number'])
      ->setCellValue($xco[$j++] . $i, $device['year'])
      ->setCellValue($xco[$j++] . $i, $device['source'])
      ->setCellValue($xco[$j++] . $i++, $device['description']);
    }
    $objPHPExcel
    ->setActiveSheetIndex(0)
    ->setCellValue($xco[0] . $i, 'Tổng cộng: ')
    ->setCellValue($xco[4] . $i++, $count);
    $i += 2;
  }
  return $objPHPExcel;
}

function materialOverlowList() {
  global $db, $filter;

  $type_list = array(0 => 'Vật tư', 1 => 'Hóa chất');

  if (empty($filter['type'])) {
    $filter['type'] = array(0, 1);
  }

  $xtpl = new XTemplate("overlow-list.tpl", PATH);

  $sql = 'select count(*) as count from `pet_manage_material` where number < bound';
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = 'select * from `pet_manage_material` where number < bound order by id desc';
  $query = $db->query($sql);
  $index = 1;
  // $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('type', $type_list[$row['type']]);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('description', $row['description']);
    if ($row['unit']) $xtpl->assign('unit', "($row[unit])");
    else $xtpl->assign('unit', '');
    $xtpl->parse('main.row');
  }
  // $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));

  $xtpl->parse('main');
  return $xtpl->text();
}

function getMaterialData($item_id) {
  global $db;

  $sql = 'select * from `pet_manage_material` where id = ' . $item_id;
  $query = $db->query($sql);
  if (!empty($row = $query->fetch())) {
    return $row;
  }
  return array();
}

function checkDeviceConfig() {
  global $db, $db_config;

  $sql = 'select * from `'. $db_config['prefix'] .'_config` where config_name = "device_config"';
  $query = $db->query($sql);
  if (empty($config = $query->fetch())) {
      // 2 weeks
      return 14;
  }
  return $config['config_value'];
}
