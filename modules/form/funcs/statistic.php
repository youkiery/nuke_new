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

      $sql = 'select id, ireceive, owner, sampleplace, ig from pet_form_row where (time between '. $filter['from'] .' and '. $filter['end'] .')'. (count($xtra) ? ' and '. implode(' and ', $xtra) : '');
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
        $unit = (empty($row['owner']) ? '' : $row['owner'] .', ') . $row['sampleplace'];
        if ($pos = searchObject($unit, $data[$check]['unit'], 'name') === false) {
          $pos = count($data[$check]['unit']);
          $data[$check]['unit'] []= array(
            'name' => $unit,
            'list' => array()
          );
        }
        
        $time = date('d/m/Y', $row['ireceive']);

        // parse bệnh, đưa vào thống kê
        $ig = json_decode($row['ig']);
        foreach ($ig as $main) {
          foreach ($main->mainer as $mainer) {
            foreach ($mainer->note as $note) {
              $idx = searchObject($note->note, $data[$check]['unit'][$pos]['list'], 'disease');
              if ($idx == false) {
                $idx = count($data[$check]['unit'][$pos]['list']);

                $data[$check]['unit'][$pos]['list'] []= $temp = array(
                  'time' => $time,
                  'disease' => $note->note,
                  'minus' => 0,
                  'plus' => 0
                );
              }
              
              if (mb_strpos(mb_strtolower($note->result), 'dương') !== false) $data[$check]['unit'][$pos]['list'][$idx]['plus'] ++;
              else $data[$check]['unit'][$pos]['list'][$idx]['minus'] ++;
            }
          }
        }
      }
      // echo json_encode($data);die();

      // list
      //   name
      //   unit
      //     name
      //     list
      //       time
      //       disease
      //         plus
      //         minus

      $dd = 1;
      $html = '';
      foreach ($data as $i => $province) {
        $total = 0;
        foreach ($province['unit'] as $unit) {
          $total += count($unit['list']);
        }
        if ($total) {
          $xtpl2 = new XTemplate('pro.tpl', PATH2);
          $uni_cord = count($province['unit'][0]['list']);
          $current = $province['unit'][0]['list'][0];

          $xtpl2->assign('index', $index ++);
          $xtpl2->assign('pro_cord', $total);
          $xtpl2->assign('uni_cord', $uni_cord);
          $xtpl2->assign('province', (empty($province['name']) ? 'Không có tên' : $province['name']));
          $xtpl2->assign('unit', $province['unit'][0]['name']);
          $xtpl2->assign('date', $current['time']);
          $xtpl2->assign('disease', $current['disease']);
          $xtpl2->assign('stat', 'Âm: '. $current['minus'] .', Dương: '. $current['plus']);
          $xtpl2->parse('main.row');

          $left = count($province['unit'][0]['list']);
          for ($j = 1; $j < $left; $j++) {
            $current = $province['unit'][0]['list'][$j];
            $xtpl2->assign('date', $current['time']);
            $xtpl2->assign('disease', $current['disease']);
            $xtpl2->assign('stat', 'Âm: '. $current['minus'] .', Dương: '. $current['plus']);
            $xtpl2->parse('main.row3');
          }

          $xtpl2->parse('main');
          $html .= $xtpl2->text();
          
          $left = count($province['unit']);
          for ($i = 1; $i < $left; $i++) { 
            $xtpl2 = new XTemplate('pro.tpl', PATH2);
            $uni_cord = count($province['unit'][$i]['list']);
            $current = $province['unit'][$i]['list'][0];
  
            $xtpl2->assign('uni_cord', $uni_cord);
            $xtpl2->assign('unit', $province['unit'][$i]['name']);
            $xtpl2->assign('date', $current['time']);
            $xtpl2->assign('disease', $current['disease']);
            $xtpl2->assign('stat', 'Âm: '. $current['minus'] .', Dương: '. $current['plus']);
            $xtpl2->parse('main.row2');
  
            $left2 = count($province['unit'][$i]['list']);
            for ($j = 1; $j < $left2; $j++) {
              $current = $province['unit'][$i]['list'][$j];
              $xtpl2->assign('date', $current['time']);
              $xtpl2->assign('disease', $current['disease']);
              $xtpl2->assign('stat', 'Âm: '. $current['minus'] .', Dương: '. $current['plus']);
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

$list = array();
while ($row = $query->fetch()) {
  $list []= array(
    'name' => $row['name'],
    'alias' => deuft8($row['name']),
    'id' => $row['id'],
  );
}
$xtpl->assign('species', json_encode($list));

$sql = 'select * from pet_form_remindv2 where type = "exam" order by rate desc';
$query = $db->query($sql);

$list = array();
while ($row = $query->fetch()) {
  $list []= array(
    'name' => $row['name'],
    'alias' => deuft8($row['name']),
    'id' => $row['id'],
  );
}
$xtpl->assign('disease', json_encode($list));

$time = time();

$xtpl->assign('from', date('01/m/Y', $time));
$xtpl->assign('end', date('d/m/Y', $time));

$xtpl->parse("main");
$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
