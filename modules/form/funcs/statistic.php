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
  'disease' => $nv_Request->get_array('disease', 'post', ""),
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
      if (!empty($filter['province'])) $xtra []= 'sampleplace like "%'. $filter['province'] .'%"';
      if (count($filter['disease'])) {
        $temp = [];
        foreach ($filter['disease'] as $disease) {
          $temp []= 'exam like "%'. $disease .'%"';
        }
        $xtra []= '(' . implode(' or ', $temp) . ')';
      }
      if (count($filter['species'])) {
        $temp = [];
        foreach ($filter['species'] as $species) {
          $temp []= 'sample like "%'. $species .'%"';
        }
        $xtra []= '(' . implode(' or ', $temp) . ')';
      }

      // ownder, sampleplace

      $sql = 'select id, sampleplace, ig from pet_form_row where (time between '. $filter['from'] .' and '. $filter['end'] .')'. (count($xtra) ? ' and '. implode(' and ', $xtra) : '');
      $query = $db->query($sql);
      $data = array();
      $index = 1;
      while ($row = $query->fetch()) {
        $check = '';
        foreach ($province as $value) {
          if (mb_strpos($row['sampleplace'], $value) !== false) {
            $check = $value;
            break;
          }
        }
        if (empty($data[$check])) $data[$check] = array(
          'name' => $check,
          'unit' => array(),
        );
        if ($pos = searchObject($row['sampleplace'], $data[$check]['unit'], 'name') === false) {
          $pos = count($data[$check]['unit']);
          $data[$check]['unit'] []= array(
            'name' => $row['sampleplace'],
            'list' => array()
          );
        }

        // parse bệnh, đưa vào thống kê
        $ig = json_decode($row['ig']);
        foreach ($ig as $main) {
          foreach ($main->mainer as $mainer) {
            foreach ($mainer->note as $note) {
              if (empty($data[$check]['unit'][$pos]['list'][$note->note])) $data[$check]['unit'][$pos]['list'][$note->note] = array(
                '0' => 0, '1' => 0 // 0: minus, 1: plus
              );
              if (mb_strpos(mb_strtolower($note->result), 'dương') !== false) $data[$check]['unit'][$pos]['list'][$note->note]['1'] ++;
              else $data[$check]['unit'][$pos]['list'][$note->note]['0'] ++;
            }
          }
        }
      }
      // echo json_encode($data);die();

      // list = [
      //   {
      //     name: '',
      //     unit: [
          //     name: '',
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
      //   }
      // ]

      $dd = 1;
      $html = '';
      foreach ($data as $i => $province) {
        $total = 0;
        foreach ($province['unit'] as $unit) {
          $total += count($unit['list']);
        }
        if ($total) {
          $xtpl2 = new XTemplate('pro.tpl', PATH2);
          // echo json_encode($province['unit'][0]);die();

          $length = count($province['unit'][0]['list']);
          $unit = $province['unit'][0]['name'];
          $disease = array_keys($province['unit'][0]['list']);

          $xtpl2->assign('index', $index ++);
          $xtpl2->assign('province', (empty($province['name']) ? 'Không có tên' : $province['name']));
          $xtpl2->assign('pro_cord', $total);
          $xtpl2->assign('uni_cord', $length);
          $xtpl2->assign('unit', $unit);
          $xtpl2->assign('disease', $disease[0]);
          $xtpl2->assign('stat', 'Âm: '. $province['unit'][0]['list'][$disease[0]][0] .', Dương: '. $province['unit'][0]['list'][$disease[0]][1]);
          $xtpl2->parse('main.row');

          $left = count($disease);
          for ($j = 1; $j < $left; $j++) {
            $xtpl2->assign('disease', $disease[$j]);
            $xtpl2->assign('stat', 'Âm: '. $province['unit'][0]['list'][$disease[$j]][0] .', Dương: '. $province['unit'][0]['list'][$disease[$j]][1]);
            $xtpl2->parse('main.row3');
          }

          $xtpl2->parse('main');
          $html .= $xtpl2->text();

          $length = count($province['unit']);
          for ($j = 1; $j < $length; $j++) {
            $xtpl2 = new XTemplate('pro.tpl', PATH2);
            $current = $province['unit'][$j];

            $length2 = count($current['list']);
            $disease = array_keys($unit = $current['list']);

            $xtpl2->assign('uni_cord', $length2);
            $xtpl2->assign('unit', $unit = $current['name']);
            $xtpl2->assign('disease', $disease[0]);
            $xtpl2->assign('stat', 'Âm: '. $current['list'][$disease[0]][0] .', Dương: '. $current['list'][$disease[0]][1]);
            $xtpl2->parse('main.row2');

            $left = count($disease);
            for ($k = 1; $k < $left; $k++) {
              $disease = array_keys($current['list']);
  
              $xtpl2->assign('disease', $disease[$k]);
              $xtpl2->assign('stat', 'Âm: '. $current['list'][$disease[$k]][0] .', Dương: '. $province['unit'][0]['list'][$disease[$k]][1]);
              $xtpl2->parse('main.row3');
            }
            $xtpl2->parse('main');
            $html .= $xtpl2->text();
          }
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

$sql = 'select * from pet_form_remindv2 where type = "exam" order by rate desc';
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $xtpl->assign('name', $row['name']);
  $xtpl->assign('value', $row['id']);
  $xtpl->parse("main.disease");
}

$time = time();

$xtpl->assign('from', date('01/m/Y', $time));
$xtpl->assign('end', date('d/m/Y', $time));

$xtpl->parse("main");
$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
