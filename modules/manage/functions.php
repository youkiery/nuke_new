<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_SYSTEM')) die('Stop!!!');
define('NV_IS_MOD_CONGVAN', true);
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template/user/" . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');

function deviceModal() {
  $xtpl = new XTemplate("modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function excelModal() {
  $xtpl = new XTemplate("excel-modal.tpl", PATH);

  $depart = getDepartList();
  foreach ($depart as $data) {
    $xtpl->assign('id', $data['id']);
    $xtpl->assign('name', $data['name']);
    $xtpl->parse('main.depart');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function transferModal() {
  $xtpl = new XTemplate("transfer-modal.tpl", PATH);

  $depart = getDepartList();
  foreach ($depart as $data) {
    $xtpl->assign('id', $data['id']);
    $xtpl->assign('name', $data['name']);
    $xtpl->parse('main.depart');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function removeModal() {
  $xtpl = new XTemplate("remove-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal() {
  $xtpl = new XTemplate("remove-all-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function importList() {
  global $db, $filter, $permit;
  
  $sql = 'select count(*) as number from pet_manage_material_import';
  $query = $db->query($sql);
  $number = $query->fetch()['number'];

  $sql = 'select * from pet_manage_material_import order by id desc limit '. $filter['limit'] .' offset '. ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $list = array();

  $xtpl = new XTemplate("import-list.tpl", PATH);

  $index = 1;
  while ($row = $query->fetch()) {
    $count = countImport($row['id']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->assign('number', $count['number']);
    $xtpl->assign('total', $count['total']);
    if ($permit) $xtpl->parse('main.row.manager');
    $xtpl->parse('main.row');
  }

  $xtpl->assign('nav', navigator($number, $filter['page'], $filter['limit'], 'import'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function countImport($id) {
  global $db;

  $sql = 'select * from pet_manage_material_import_detail where importid = '. $id;
  $query = $db->query($sql);
  $data = array(
    'number' => 0,
    'total' => 0
  );

  while ($row = $query->fetch()) {
    $data['number'] ++;
    $data['total'] += $row['number'];
  }

  return $data;
}

function exportList() {
  global $db, $filter, $permit;
  
  $sql = 'select count(*) as number from pet_manage_material_export';
  $query = $db->query($sql);
  $number = $query->fetch()['number'];

  $sql = 'select * from pet_manage_material_export order by id desc limit '. $filter['limit'] .' offset '. ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $list = array();

  $xtpl = new XTemplate("export-list.tpl", PATH);

  $index = 1;
  while ($row = $query->fetch()) {
    $count = countExport($row['id']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->assign('number', $count['number']);
    $xtpl->assign('total', $count['total']);
    if ($permit) $xtpl->parse('main.row.manager');
    $xtpl->parse('main.row');
  }

  $xtpl->assign('nav', navigator($number, $filter['page'], $filter['limit'], 'import'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function countExport($id) {
  global $db;

  $sql = 'select * from pet_manage_material_export_detail where exportid = '. $id;
  $query = $db->query($sql);
  $data = array(
    'number' => 0,
    'total' => 0
  );

  while ($row = $query->fetch()) {
    $data['number'] ++;
    $data['total'] += $row['number'];
  }

  return $data;
}

function sourceList() {
  global $db, $filter, $permit;
  
  $sql = 'select count(*) as number from pet_manage_material_source where active = 1';
  $query = $db->query($sql);
  $number = $query->fetch()['number'];

  $sql = 'select * from pet_manage_material_source where active = 1 order by id desc limit '. $filter['limit'] .' offset '. ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $list = array();

  $xtpl = new XTemplate("source-list.tpl", PATH);

  $index = 1;
  while ($row = $query->fetch()) {
    $count = countExport($row['id']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    if ($permit) $xtpl->parse('main.row.manager');
    $xtpl->parse('main.row');
  }

  $xtpl->assign('nav', navigator($number, $filter['page'], $filter['limit'], 'import'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceList() {
  global $db, $allow, $user_info, $start, $check_image;
  
  $xtpl = new XTemplate("device-list.tpl", PATH);
  if (empty($user_info)) $xtpl->parse('main.no');
  else {
    $sql = 'select * from `'. PREFIX .'device` where id in (select itemid from `'. PREFIX .'device_employ` where userid = '. $user_info['userid'] .')';
    $query = $db->query($sql);
    $index = 1;
  
    while ($row = $query->fetch()) {
      $sql = 'select * from `'. PREFIX .'device_detail` where itemid = ' . $row['id'] . ' and time >= '. $start .' order by id desc limit 1';
      $detail_query = $db->query($sql);
      $detail = $detail_query->fetch();
      $xtpl->assign('check', '');
      if (!empty($detail)) $xtpl->assign('check', $check_image);

      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xtpl->assign('name', $row['name']);
      $xtpl->assign('status', $row['status']);
      $xtpl->assign('note', $row['description']);
      $xtpl->assign('number', $row['number']);
      $manual = getDeviceManual($row['id']);
      if (!empty($manual)) $xtpl->parse('main.yes.row.manual');
      $xtpl->parse('main.yes.row');
    }
    $xtpl->parse('main.yes');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}
function checkMember() {
  global $db, $user_info, $op;

  if (empty($user_info)) {
    $content = 'Xin hãy đăng nhập trước khi sử dụng chức năng này';
  }
  else {
    $query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
    $user = $query->fetch();
    $authors = json_decode($user['author']);
    if ($op == 'device' && $authors->{'device'}) {
      // ok
    }
    else if ($op == 'material' && $authors->{'material'}) {
      // ok
    }
    else if ($op == 'main' && ($authors->{'device'} || $authors->{'material'})) {
      // ok
    }
    else {
      // prevent
      $content = 'Tài khoản không có quyền truy cập';
    }
  }
  if ($content) {
    include NV_ROOTDIR . '/includes/header.php';
    echo nv_site_theme($content);
    include NV_ROOTDIR . '/includes/footer.php';
  }
}

function checkMaterialPermit() {
  global $db, $user_info;

  if (empty($user_info)) return false;
  if (empty($user_info['userid'])) return false;
  $sql = 'select * from `'. PREFIX .'permit` where userid = '. $user_info['userid'];
  $query = $db->query($sql);
  $permit = $query->fetch();
  if (empty($permit)) return false;
  return $permit['type'];
}

function materialList() {
  global $db, $url, $filter, $permit;

  $xtpl = new XTemplate("material-list.tpl", PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'material`';
  $query = $db->query($sql);
  $count = $query->fetch()['count'];

  $sql = 'select * from `'. PREFIX .'material` where active = 1 order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $today = time();

  while($row = $query->fetch()) {
    $number = 0;
    $sql = 'select * from `'. PREFIX .'material_detail` where number > 0 and materialid = '. $row['id'];
    $detail_query = $db->query($sql);
    $expire = 9999999999;
    while ($detail = $detail_query->fetch()) {
      if ($detail['expire'] < $expire) $expire = $detail['expire'];
      // echo "$expire, ";
      $number += $detail['number'];
    }
    // if ($row['id'] == 7) die("$number");

    $xtpl->assign('expire', '-');
    $xtpl->assign('color', '');
    if ($expire !== 9999999999) $xtpl->assign('expire', date('d/m/Y', $expire));
    if ($expire < $today) $xtpl->assign('color', 'red');
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('number', $number);
    $xtpl->assign('description', $row['description']);
    if ($row['unit']) $xtpl->assign('unit', "($row[unit])");
    else $xtpl->assign('unit', '');
    if ($permit) $xtpl->parse('main.row.manager');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navigator($count, $filter['page'], $filter['limit'], 'material'));
  // die();
  $xtpl->parse('main');
  return $xtpl->text();
}

function materialModal() {
  $xtpl = new XTemplate("modal.tpl", PATH);
 
  $day = 60 * 60 * 24;
  $xtpl->assign('last_month', date('d/m/Y', time() - $day * 30));
  $xtpl->assign('next_half_year', date('d/m/Y', time() + $day * 30 * 6));

  $xtpl->parse('main');
  return $xtpl->text();
}

function sourceDataList() {
  global $db;

  $sql = 'select * from `'. PREFIX .'material_source` where active = 1 order by name';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[] = array(
      'id' => $row['id'],
      'name' => $row['name'],
      'alias' => simplize($row['name'])
    );
  }
  return $list;
}

function sourceDataList2() {
  global $db;

  $sql = 'select * from `'. PREFIX .'material_source` where active = 1 order by name';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[$row['id']] = $row['name'];
  }
  return $list;
}
