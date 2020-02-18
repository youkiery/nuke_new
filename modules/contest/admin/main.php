<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$xco = array(1 => 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
$yco = array(1 => 'SBD', 'Tên Chủ nuôi', 'Địa chỉ', 'Số điện thoại', 'Tên thú cưng', 'Giống loài', 'Phần thi');

if ($nv_Request->get_string('download', 'get')) {
  header('location: /assets/excel-output.xlsx?' . time());
}

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'active':
      $id = $nv_Request->get_int('type', 'post', 0);
      $type = $nv_Request->get_int('type', 'post', 0);

      $sql = 'update `'. PREFIX .'row` set active = ' . $type . ' where id = ' . $id;
      if ($db->query($sql)) {
          $result['status'] = 1;
      }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/$module_file/template/admin/$op");

// $query = $db->query('select * from `'. PREFIX .'config` where name = "show_content"');
// $contest_config = $query->fetch();
// if (empty($contest_config)) {
//   $db->query('insert into `'. PREFIX .'config` (name, value) values("show_content", 1)');
//   $contest_config = array('value' => 1);
// }

// if ($contest_config['value']) {
//   $xtpl->assign('show_yes', 'block');
//   $xtpl->assign('show_no', 'none');
// }
// else {
//   $xtpl->assign('show_yes', 'none');
//   $xtpl->assign('show_no', 'block');
// }

// $query = $db->query('select * from `'. PREFIX .'species` order by rate desc');
// $species = array();
// while ($row = $query->fetch()) {
//   $species[] = ucwords($row['name']);
//   $xtpl->assign('id', $row['id']);
//   $xtpl->assign('species', ucwords($row['name']));
//   $xtpl->parse('main.species');
//   $xtpl->parse('main.species2');
// }

// $query = $db->query('select * from `'. PREFIX .'test`');
// while ($row = $query->fetch()) {
//   $xtpl->assign('id', $row['id']);
//   $xtpl->assign('contest', $row['name']);
//   $xtpl->parse('main.contest');
// }

// $xtpl->assign('modal_contest', contestModal());
// $xtpl->assign('modal_test', testModal());
// $xtpl->assign('remove_contest_modal', removeModal());
// $xtpl->assign('remove_all_contest_modal', removeAllModal());
// $xtpl->assign('content', contestList());
// $xtpl->assign('species', json_encode($species, JSON_UNESCAPED_UNICODE));
// $xtpl->parse('main');

// Danh sách khóa học, xác nhận
$xtpl->assign('content', courtRegistList());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
