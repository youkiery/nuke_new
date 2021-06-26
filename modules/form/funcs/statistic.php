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

$page_title = "Thống kê";
$filter = array(
  'from' => $nv_Request->get_string('from', 'post', ""),
  'end' => $nv_Request->get_string('end', 'post', ""),
  'province' => $nv_Request->get_string('province', 'post', ""),
  'disease' => $nv_Request->get_string('disease', 'post', ""),
  'species' => $nv_Request->get_array('species', 'post', ""),
);

$province = array('Đắk Lắk', 'An Giang', 'Bà Rịa Vũng Tàu', 'Bình Dương', 'Bình Phước', 'Bình Thuận', 'Bình Định', 'Bạc Liêu', 'Bắc Giang', 'Bắc Kạn', 'Bắc Ninh', 'Bến Tre', 'Cao Bằng', 'Cà Mau', 'Cần Thơ', 'Gia Lai', 'Hà Nội', 'Hà Giang', 'Hà Nam', 'Hà Tĩnh', 'Hòa Bình', 'Hưng Yên', 'Hải Dương', 'Hải Phòng', 'Hậu Giang', 'Hồ Chí Minh', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum', 'Lai Châu', 'Long An', 'Lào Cai', 'Lâm Đồng', 'Lạng Sơn', 'Nam Định', 'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ', 'Phú Yên', 'Quảng Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị', 'Sóc Trăng', 'Sơn La', 'Thanh Hóa', 'Thái Bình', 'Thái Nguyên', 'Thừa Thiên Huế', 'Tiền Giang', 'Trà Vinh', 'Tuyên Quang', 'Tây Ninh', 'Vĩnh Long', 'Vĩnh Phúc', 'Yên Bái', 'Điện Biên', 'Đà Nẵng', 'Đắk Nông', 'Đồng Nai', 'Đồng Tháp');

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
  $result = array("status" => 0);
  switch ($action) {
    case 'filter':
      $xtpl = new XTemplate("list.tpl", PATH2);
      $filter['from'] = totime($filter['from']);
      $filter['end'] = totime($filter['end']);

      $xtra = array();
      if (!empty($filter['province'])) $xtra []= 'sender like "%'. $filter['province'] .'%"';
      if (!empty($filter['disease'])) {
        $xtra []= 'exam like "%'. $filter['disease'] .'%"';
      }
      if (count($filter['species'])) {
        $temp = [];
        foreach ($filter['species'] as $species) {
          $temp []= 'sample like "%'. $species .'%"';
        }
        $xtra []= '(' . implode(' or ', $temp) . ')';
      }

      $sql = 'select id, sender, ig from pet_form_row where (time between '. $filter['from'] .' and '. $filter['end'] .')'. (count($xtra) ? ' and '. implode(' and ', $xtra) : '');
      $query = $db->query($sql);
      $data = array();
      $index = 1;
      while ($row = $query->fetch()) {
        $check = '';
        foreach ($province as $value) {
          if (mb_strpos($row['sender'], $value) !== false) {
            $check = $value;
            break;
          }
        }
        if (empty($data[$check])) $data[$check] = array(
          'name' => $check,
          'unit' => array(),
          'list' => array()
        );
        if (array_search($row['sender'], $data[$check]['unit']) === false) $data[$check]['unit'] []= $row['sender'];
        // parse bệnh, đưa vào thống kê
        $ig = json_decode($row['ig']);
        foreach ($ig as $main) {
          foreach ($main->mainer as $mainer) {
            foreach ($mainer->note as $note) {
              if (empty($data[$check]['list'][$note->note])) $data[$check]['list'][$note->note] = array(
                '0' => 0, '1' => 0 // 0: minus, 1: plus
              );
              if (mb_strpos(mb_strtolower($note->result), 'dương') !== false) $data[$check]['list'][$note->note]['1'] ++;
              else $data[$check]['list'][$note->note]['0'] ++;
            }
          }
        }
      }
      // echo json_encode($data);die();

      // list = [
      //   {
      //     name: '',
      //     unit: '',
      //     list: [
      //       {
      //         disease: {
      //           0: 0,
      //           1: 0
      //         }
      //       }
      //     ]
      //   }
      // ]

      $dd = 1;
      $html = '';
      foreach ($data as $i => $province) {
        // if ($dd++ == 1) continue;
        $length = count($province['list']);
        $disease = array_keys($province['list']);
        if ($length) {
          $xtpl2 = new XTemplate('bick.tpl', PATH2);
          $xtpl2->assign('index', $index ++);
          $xtpl2->assign('province', (empty($province['name']) ? 'Không có tên' : $province['name']));
          $xtpl2->assign('unit', implode('<br>', $province['unit']));
          $xtpl2->assign('pro_cord', $length);
          $xtpl2->assign('disease', $disease[0]);
          $xtpl2->assign('stat', "Âm: " .$province['list'][$disease[0]][0] .", Dương: ". $province['list'][$disease[0]][1]);
          $xtpl2->parse('main.row');
  
          for ($j = 1; $j < $length; $j++) {
            $xtpl2->assign('disease', $disease[$j]);
            $xtpl2->assign('stat', "Âm: " .$province['list'][$disease[$j]][0] .", Dương: ". $province['list'][$disease[$j]][1]);
            $xtpl2->parse('main.row2');
          }
          // $dd ++;
          // if ($dd == 3) 
          // break;
          $xtpl2->parse('main');
          $html .= $xtpl2->text();
        }
      }

      $xtpl->assign('html', $html);
      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);

$permission = getUserType($user_info['userid']);

// $permissionType = array('Bị cấm', 'Kế toán', 'Chỉ đọc', 'Nhân viên', 'Siêu nhân viên', 'Quản lý');
//                          0      , 1        , 2        , 3          , 4               ,  5

$permist = array();

switch ($permission) {
	case 1:
		$xtpl->parse('main.secretary');
	break;
	case 2:
		$xtpl->parse('main.user');
	break;
	case 3:
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
	break;
	case 4: 
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
		$xtpl->parse('main.secretary');
		$xtpl->parse('main.printx');
	break;
	case 5: 
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
		$xtpl->parse('main.secretary');
		$xtpl->parse('main.printx');
	break;
}

$sql = 'select * from pet_form_remindv2 where type = "sample" order by rate desc';
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $xtpl->assign('name', $row['name']);
  $xtpl->assign('value', $row['id']);
  $xtpl->parse("main.species");
}

$time = time();

$xtpl->assign('from', date('01/m/Y', $time));
$xtpl->assign('end', date('d/m/Y', $time));

$xtpl->parse("main");
$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
