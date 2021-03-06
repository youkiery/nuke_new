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
  $xtpl = new XTemplate("device-modal.tpl", PATH);
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
  global $db, $filter, $permit, $keyword;
  
  $sql = "select count(*) as number from pet_manage_material_import a inner join pet_manage_material_detail b on a.detailid = b.id inner join pet_manage_material c on b.materialid = c.id where c.name like '%$keyword%'";
  // die($sql);
  $query = $db->query($sql);
  $number = $query->fetch()['number'];

  $sql = "select a.* from pet_manage_material_import a inner join pet_manage_material_detail b on a.detailid = b.id inner join pet_manage_material c on b.materialid = c.id where c.name like '%$keyword%' order by id desc limit $filter[limit] offset ". ($filter['page'] - 1) * $filter['limit'];
  // $sql = 'select c.* from pet_manage_material_import a inner join pet_manage_material_import_detail b on a.id = b.importid inner join pet_manage_material_detail c on b.detailid = c.id order by id desc limit '. $filter['limit'] .' offset '. ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  $xtpl = new XTemplate("import-list.tpl", PATH);

  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    // echo json_encode($row);die();
    $material = getMaterialByDetail($row['detailid']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('date', date('d/m/Y', $row['date']));
    $xtpl->assign('total', $row['number']);
    $xtpl->assign('note', $row['note']);
    $xtpl->assign('material', $material['name']);
    if ($permit) $xtpl->parse('main.row.manager');
    $xtpl->parse('main.row');
  }

  $xtpl->assign('nav', navigator($number, $filter['page'], $filter['limit'], 'import'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function importMaterial($id) {
  global $db;

  $sql = "select a.number, c.name from pet_manage_material_import_detail a inner join pet_manage_material_detail b on a.detailid = b.id inner join pet_manage_material c on b.materialid = c.id where a.importid = $id";
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list []= "$row[name]: $row[number]";
  }
  return implode('<br>', $list);
}

function exportMaterial($id) {
  global $db;

  $sql = "select a.number, c.name from pet_manage_material_export_detail a inner join pet_manage_material_detail b on a.detailid = b.id inner join pet_manage_material c on b.materialid = c.id where a.exportid = $id";
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list []= "$row[name]: $row[number]";
  }
  return implode('<br>', $list);
}

function getMaterialByDetail($detailid) {
  global $db;

  $sql = "select b.* from pet_manage_material_detail a inner join pet_manage_material b on a.materialid = b.id where a.id = $detailid";
  return fetch($sql);
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

function getImportId($id) {
  global $db;

  $sql = 'select a.date, a.number, b.expire, a.note, b.materialid as itemid, b.source as sourceid from pet_manage_material_import a inner join pet_manage_material_detail b on a.detailid = b.id where a.id = '. $id;
  // item, itemid, source, sourceid

  $row = fetch($sql);
  $row['item'] = getItemId($row['itemid']);
  $row['source'] = getSourceId($row['sourceid']);
  $row['date'] = date('d/m/Y', $row['date']);
  $row['expire'] = date('d/m/Y', $row['expire']);

  return $row;
}

function getExportId($id) {
  global $db;

  $sql = 'select a.id, a.date, a.number, b.expire, a.note, b.materialid as itemid, b.source as sourceid from pet_manage_material_export a inner join pet_manage_material_detail b on a.detailid = b.id where a.id = '. $id;

  $row = fetch($sql);
  $row['item'] = getItemId($row['itemid']);
  $row['source'] = getSourceId($row['sourceid']);
  $row['date'] = date('d/m/Y', $row['date']);
  $row['expire'] = date('d/m/Y', $row['expire']);
  $row['remain'] = materialRemain($row['itemid']);

  return $row;
}

function getSourceId($id) {
  global $db;
  $sql = 'select * from pet_manage_material_source where id = '. $id;
  $query = $db->query($sql);
  return $query->fetch()['name'];
}

function getItemId($id) {
  global $db;
  $sql = 'select * from pet_manage_material where id = '. $id;
  $query = $db->query($sql);
  return $query->fetch()['name'];
}

function exportList() {
  global $db, $filter, $permit, $keyword;
  
  $sql = "select count(*) as number from pet_manage_material_export a inner join pet_manage_material_detail b on a.detailid = b.id inner join pet_manage_material c on b.materialid = c.id where c.name like '%$keyword%'";
  $query = $db->query($sql);
  $number = $query->fetch()['number'];

  $sql = "select a.* from pet_manage_material_export a inner join pet_manage_material_detail b on a.detailid = b.id inner join pet_manage_material c on b.materialid = c.id where c.name like '%$keyword%' order by id desc limit $filter[limit] offset ". ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  $xtpl = new XTemplate("export-list.tpl", PATH);

  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $material = getMaterialByDetail($row['detailid']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('date', date('d/m/Y', $row['date']));
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('note', $row['note']);
    $xtpl->assign('material', $material['name']);
    if ($permit) $xtpl->parse('main.row.manager');
    $xtpl->parse('main.row');
  }

  $xtpl->assign('nav', navigator($number, $filter['page'], $filter['limit'], 'export'));
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
  global $db, $filter, $permit, $keyword;
  
  $sql = "select count(*) as number from pet_manage_material_source where name like '%$keyword%' and active = 1";
  $query = $db->query($sql);
  $number = $query->fetch()['number'];

  $sql = "select * from pet_manage_material_source where name like '%$keyword%' and active = 1 order by id desc limit $filter[limit] offset ". ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $list = array();

  $xtpl = new XTemplate("source-list.tpl", PATH);

  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    // $count = countExport($row['id']);
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
  global $db, $nv_Request, $user_info, $db_config;
  
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;

  $xtpl = new XTemplate("device-list.tpl", PATH);

  // $query = $db->query('select * from `pet_manage_member` where userid = '. $user_info['userid']);
  // $user = $query->fetch();
  // $authors = json_decode($user['author']);

  // $depart = $authors->{depart};
  // $depart2 = array();
  // $departid = array();
  // foreach ($depart as $id) {
  //   $departid[$id] = 1;
  //   $depart2[]= $id;
  // }
  // $xtra = '';
  // if (empty($filter['depart'])) {
  //   $filter['depart'] = $depart2;
  // }
  // else {
  //   foreach ($filter['depart'] as $index => $value) {
  //     if (empty($departid[$value])) unset($filter['depart'][$index]);
  //   }
  // }

  $sql = 'select * from `'. $db_config['prefix'] .'_users` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $user = $query->fetch();
  $group = explode(',', $user['in_groups']);
  // $group = array();
  $list = array();
  $xtra = '';

  if (!in_array('1', $group)) {
    // check if is allowed
    $sql = 'select * from `pet_manage_devicon` where userid = ' . $user_info['userid'];
    $query = $db->query($sql);
    $devicon = $query->fetch();

    if ($devicon['level'] < 3) {
      $list = json_decode($devicon['depart']);
      // var_dump($devicon);die(); 
    } 
    else $list = getDepartidList();
  }
  else $list = getDepartidList();

  if (!empty($filter['depart']) && count($filter['depart'])) {
    $query_list = array();
    foreach ($filter['depart'] as $departid) {
      if (in_array($departid, $list)) $query_list[] = 'depart like \'%"'. $departid .'"%\'';
    }
    if (count($query_list)) $xtra = 'where ('. implode(' or ', $query_list) .')';
    else $xtra = 'where 0';
  }

  if (!empty($filter['keyword'])) {
    if ($xtra) $xtra .= ' and name like "%'. $filter['keyword'] .'%"';
    else $xtra .= ' where name like "%'. $filter['keyword'] .'%"';
  }

  // die('select count(*) as count from `pet_manage_device` '. $xtra .' order by update_time desc limit ' . $filter['limit']);
  $sql = 'select count(*) as count from `pet_manage_device` '. $xtra .' order by update_time desc limit ' . $filter['limit'];
  $query = $db->query($sql);

  $count = $query->fetch();
  $number = $count['count'];
  // die('select * from `pet_manage_device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `pet_manage_device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  // $authors = new object();
  // if ($authors->{'device'} == 2) $xtpl->parse('main.v1');
  $check = empty($devicon) || (!empty($devicon) && $devicon['level'] > 1);
  if ($check) $xtpl->parse('main.v1');
  while ($row = $query->fetch()) {
    $depart = json_decode($row['depart']);
    $list = array();
    foreach ($depart as $value) {
      $list[]= checkDepartId($value);
    }
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('depart', implode(', ', $list));
    $xtpl->assign('departid', $depart[0]);
    $xtpl->assign('company', $row['intro']);
    $xtpl->assign('status', $row['status']);
    $xtpl->assign('number', $row['number']);
    if ($check) $xtpl->parse('main.row.v2');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function checkMember() {
  global $db, $user_info, $op;

  if (empty($user_info)) {
    $content = 'Xin h??y ????ng nh???p tr?????c khi s??? d???ng ch???c n??ng n??y';
  }
  else {
    $query = $db->query('select * from `pet_manage_member` where userid = '. $user_info['userid']);
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
      $content = 'T??i kho???n kh??ng c?? quy???n truy c???p';
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
  $sql = 'select * from `pet_manage_permit` where userid = '. $user_info['userid'];
  $query = $db->query($sql);
  $permit = $query->fetch();
  if (empty($permit)) return false;
  return $permit['type'];
}

function materialRemain($id) {
  global $db;

  $sum = 0;
  $sql = "select * from pet_manage_material_detail where materialid = $id";
  $query = $db->query($sql);

  while ($row = $query->fetch()) $sum += $row['number'];
  return $sum;
}

function materialList() {
  global $db, $url, $filter, $permit, $keyword;

  $xtpl = new XTemplate("material-list.tpl", PATH);

  $sql = "select count(*) as count from `pet_manage_material` where name like '%$keyword%' and active = 1";
  $query = $db->query($sql);
  $count = $query->fetch()['count'];

  $sql = "select * from `pet_manage_material` where name like '%$keyword%' and active = 1 order by name asc limit $filter[limit]  offset " . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $today = time();

  while($row = $query->fetch()) {
    $number = 0;
    $sql = 'select * from `pet_manage_material_detail` where materialid = '. $row['id'];
    $detail_query = $db->query($sql);
    $expire = 9999999999;
    while ($detail = $detail_query->fetch()) {
      if ($detail['number'] > 0 && ($detail['expire'] < $expire)) $expire = $detail['expire'];
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
  $xtpl->assign('today', date('d/m/Y'));
  $xtpl->assign('last_month', date('d/m/Y', time() - $day * 30));
  $xtpl->assign('next_half_year', date('d/m/Y', time() + $day * 30 * 6));

  $xtpl->parse('main');
  return $xtpl->text();
}

function sourceDataList() {
  global $db;

  $sql = 'select * from `pet_manage_material_source` where active = 1 order by name';
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

  $sql = 'select * from `pet_manage_material_source` order by name';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[$row['id']] = $row['name'];
  }
  return $list;
}
