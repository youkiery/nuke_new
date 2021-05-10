<?php

/**
 * @Project Thanhxuanpet 0.1
 * @Author Võ Anh Dư <vodaityr@gmail.com>
 * @Copyright (C) 2021 Thanhxuanpet
 * @License Nope
 * @Createdate 22/01/2021 14:15
 */

if (!defined('NV_IS_TX')) die('Stop!!!');

$filter = array(
  'page' => $nv_Request->get_string('page', 'get', '1'),
  'limit' => $nv_Request->get_string('limit', 'get', '10'),
  'keyword' => $nv_Request->get_string('keyword', 'get', '')
);

$action = $nv_Request->get_string('action', 'post');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'get-product':
      $id = $nv_Request->get_string('id', 'post', '0');

      $sql = 'select * from pet_daklak_product where id = '. $id;
      $query = $db->query($sql);
      $product = $query->fetch();

      $result['status'] = 1;
      $result['data'] = $product;
      break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("statistic-content.tpl", PATH);

$data = array(
  'import' => 0,
  'import_count' => 0,
  'export' => 0,
  'export_count' => 0,
  'total' => 0
);

$sql = 'select * from pet_daklak_import';
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $data['import'] += $row['total'];
  $data['import_count'] ++;
  $data['total'] -= $row['total'];
}

$sql = 'select * from pet_daklak_export';
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $data['export'] += $row['total'];
  $data['export_count'] ++;
  $data['total'] += $row['total'];
}

$xtpl->assign('import', number_format($data['import'], 0, '', ','));
$xtpl->assign('import_count', $data['import_count']);
$xtpl->assign('export', number_format($data['export'], 0, '', ','));
$xtpl->assign('export_count', $data['export_count']);
$xtpl->assign('total', number_format($data['total'], 0, '', ','));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
