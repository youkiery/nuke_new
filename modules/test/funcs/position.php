<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');

$xtpl = new XTemplate("main.tpl", PATH2);

$sql = 'select * from pet_test_position';
$query = $db->query($sql);
$list = array();

while($row = $query->fetch()) {
  $row['alias'] = convert($row['name']);
  $row['position'] = explode(', ', $row['position']);
  $list []= $row;
}

$xtpl->assign('list', json_encode($list));

$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
