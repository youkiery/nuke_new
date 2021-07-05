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
  'page' => $nv_Request->get_string('page', 'post', 1),
  'limit' => $nv_Request->get_string('limit', 'post', 20),
  'from' => $nv_Request->get_string('from', 'post', ""),
  'end' => $nv_Request->get_string('end', 'post', ""),
  'province' => $nv_Request->get_string('province', 'post', ""),
  'disease' => $nv_Request->get_array('disease', 'post', ""),
  'species' => $nv_Request->get_array('species', 'post', ""),
);

$sampleType = array(0 => 'Nguyên con', 'Huyết thanh', 'Máu', 'Phủ tạng', 'Swab');
$province = array('Đắk Lắk', 'An Giang', 'Bà Rịa Vũng Tàu', 'Bình Dương', 'Bình Phước', 'Bình Thuận', 'Bình Định', 'Bạc Liêu', 'Bắc Giang', 'Bắc Kạn', 'Bắc Ninh', 'Bến Tre', 'Cao Bằng', 'Cà Mau', 'Cần Thơ', 'Gia Lai', 'Hà Nội', 'Hà Giang', 'Hà Nam', 'Hà Tĩnh', 'Hòa Bình', 'Hưng Yên', 'Hải Dương', 'Hải Phòng', 'Hậu Giang', 'Hồ Chí Minh', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum', 'Lai Châu', 'Long An', 'Lào Cai', 'Lâm Đồng', 'Lạng Sơn', 'Nam Định', 'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ', 'Phú Yên', 'Quảng Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị', 'Sóc Trăng', 'Sơn La', 'Thanh Hóa', 'Thái Bình', 'Thái Nguyên', 'Thừa Thiên Huế', 'Tiền Giang', 'Trà Vinh', 'Tuyên Quang', 'Tây Ninh', 'Vĩnh Long', 'Vĩnh Phúc', 'Yên Bái', 'Điện Biên', 'Đà Nẵng', 'Đắk Nông', 'Đồng Nai', 'Đồng Tháp');

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
  $result = array("status" => 0);
  switch ($action) {
    case 'remove-remind':
      $id = $nv_Request->get_string('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      $sql = 'delete from pet_form_remindv3 where id = '. $id;
      $query = $db->query($sql);

      $result['status'] = 1;
      $result['messenger'] = 'Đã xóa gợi ý';
      $result['data'] = getRemindv3($name);
    break;
    case 'insert-remind':
      $name = $nv_Request->get_string('name', 'post', '');
      $remind = $nv_Request->get_string('remind', 'post', '');

      $msg = '';
      if (empty($remind)) $msg = 'Nhập gợi ý trước đã';
      else {
        $sql = "select * from pet_form_remindv3 where remind = '$remind'";
        $query = $db->query($sql);
  
        if (!empty($row = $query->fetch())) $msg = 'Gợi ý đã đã tồn tại';
        else {
          $sql = "insert into pet_form_remindv3 (name, remind) values('$name', '$remind')";
          $db->query($sql);
          $result['status'] = 1;
          $result['messenger'] = 'Đã thêm';
          $result['data'] = getRemindv3($name);
        }
      }
      if ($msg) $result['messenger'] = $msg;
    break;
    case 'preview':
      $id = $nv_Request->get_string('id', 'post', '');
      
      $sql = 'select * from `pet_form_row` where id = ' . $id;
      $query = $db->query($sql);

      $form = $query->fetch();
      $xtpl = new XTemplate("form.tpl", PATH2);

      $xtpl->assign('noticetime_0', date('d', $form['noticetime']));
      $xtpl->assign('noticetime_1', date('m', $form['noticetime']));
      $xtpl->assign('noticetime_2', date('Y', $form['noticetime']));
      $xtpl->assign('senderemploy', $form['sender']);
      $xtpl->assign('xaddress', $form['xaddress']);

      $info = '';
      if (trim($form['ownermail']) || trim($form['ownerphone'])) {
        $info .= '<p class="p14"> &emsp;&emsp; Số điện thoại: '. $form['ownerphone'].'</p><p class="p14"> &emsp;&emsp; Email: '.$form['ownermail'].'</p>';
      }

      $owner = '';
      if ($form['owner']) {
        $owner .= '<p class="p14"> &emsp;&emsp;&emsp; Chủ hộ: '. $form['owner'].'</p>';
      }
      if ($form['sampleplace']) {
        $owner .= '<p class="p14"> &emsp;&emsp;&emsp; Nơi lấy mẫu: '.$form['sampleplace'].'</p>';
      }
      if ($owner) {
        $owner = '<p class="p14"> &emsp;&emsp; Thông tin mẫu:</p>' . $owner;
      }

      $note = '';
      if (strlen(trim($form['note']))) {
        $notes = explode('<br />', nl2br($form['note']));
        
        $list = array();
        foreach ($notes as $item) {
          if (strlen($item)) $list []= '<i>' . $item . '</i>';
        }
        $note = '<div class="p14"> <i> <b style="float: left; width: 80px;">Ghi chú:</b> </i> <span style="float: left; width: calc(100% - 80px);">' . implode('<br>', $list) . '</span></div>';
      }

      $list = explode('@@', $form['result']);
      $res = array();
      foreach ($list as $item) {
        $res [] = '<p> &emsp;&emsp;'. $item .' </p>';
      }
      $res = implode('', $res);

      $xtpl->assign('owner', $owner);
      $xtpl->assign('info', $info);
      $xtpl->assign('sample', $form['sample']);

      $type = $form['typevalue'];
      if (!empty($sampleType[$form['typeindex']])) {
        $type = $sampleType[$form['typeindex']];
      }

      // echo json_encode($row);die();
      // die("$row[typeindex], $row[typevalue]");

      $xtpl->assign('sampletype', $type);
      $xtpl->assign('numberword', $form['numberword']);
      $xtpl->assign('examsample', $form['examsample']);
      $xtpl->assign('samplecode', $form['samplecode']);
      $xtpl->assign('samplereceive', date('d/m/Y', $form['samplereceive']));
      $xtpl->assign('sampletime', date('d/m/Y', $form['receive']));
      $xtpl->assign('target', $form['target']);
      
      $exam = extractExam(json_decode($form['exam']));
      $xtpl->assign('exam', $exam);
      $xtpl->assign('note', $note);
      $xtpl->assign('result', $res);
      $xcode = explode(',', $form['xcode']);
      $xtpl->assign('xcode_0', $xcode[0]);
      $xtpl->assign('xcode_1', $xcode[1]);
      $xtpl->assign('xcode_2', $xcode[2]);
      $xtpl->assign('receivedis', nl2br($form['receivedis']));
      
      if ($form['xsign']) $xtpl->assign('xsigner', 'KT CHI CỤC TRƯỞNG<br>PHÓ CHI CỤC TRƯỞNG<br>');
      else $xtpl->assign('xsigner', 'CHI CỤC TRƯỞNG<br>');

      $sql = 'select * from pet_form_signer where id = '. $form['xsign'];
      $query = $db->query($sql);
      $sign = $query->fetch();

      if (empty($sign)) {
        $xtpl->assign('xsign', '');
        $xtpl->assign('receiveleader', '<br><br>'. $form['receiveleader']);
      }
      else {
        $xtpl->assign('xsign', $sign['url']);
        $xtpl->assign('receiveleader', $form['receiveleader']);
      }

      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
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
      $xtra = 'where (time between '. $filter['from'] .' and '. $filter['end'] .')'. (count($xtra) ? ' and '. implode(' and ', $xtra) : '');
      
      $sql = 'select id, time, owner, sampleplace, ig, printer from pet_form_row '. $xtra;
      // die($sql);
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
        
        $time = date('d/m/Y', $row['time']);
        $link = 0;
        if ($row['printer'] == 5) $link = $row['id'];

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
                  'link' => $link,
                  'disease' => $note->note,
                  'link' => $link,
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

      $i = 1;
      $prv_pro = '';
      $prv_unit = '';
      $start = ($filter['page'] - 1) * $filter['limit'];
      $end = $start + $filter['limit'];
      $xtpl2 = new XTemplate('pro.tpl', PATH2);
      foreach ($data as $province) {
        foreach ($province['unit'] as $unit) {
          foreach ($unit['list'] as $stat) {
            if ($i > $start && $i <= $end) {
              $xtpl2->assign('index', $i);
              $pro = empty($province['name']) ? 'Không có tên' : $province['name'];
              if ($prv_pro !== $pro) {
                $prv_pro = $pro;
                $xtpl2->assign('province', $pro);
              }
              else $xtpl2->assign('province', '');
  
              $uni = $unit['name'];
              if ($prv_unit !== $uni) {
                $prv_unit = $uni;
                $xtpl2->assign('unit', $uni);
              }
              else $xtpl2->assign('unit', '');
  
              $xtpl2->assign('date', $stat['time']);
              $xtpl2->assign('click', '');
              if ($stat['link'] > 0) $xtpl2->assign('click', 'class="click" onclick="preview('. $stat['link'] .')"');
              $xtpl2->assign('disease', $stat['disease']);
              $xtpl2->assign('stat', 'Âm: '. $stat['minus'] .', Dương: '. $stat['plus']);
              $xtpl2->parse('main.row');
            }
            $i ++;
          }
        }
      }

      $xtpl2->parse('main');
      $xtpl->assign('html', $xtpl2->text());
      $xtpl->assign('nav', navigator($i, $filter['page'], $filter['limit'], 'goPage'));
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

$xtpl->assign('species', json_encode(getRemindv3('species')));
$xtpl->assign('disease', json_encode(getRemindv3('disease')));

$time = time();

$xtpl2 = new XTemplate("modal.tpl", PATH2);

$week_start = date('d/m/Y', strtotime('-'.$time.' days'));
$week_end = date('d/m/Y', strtotime('+'.(6-$time).' days'));

$xtpl2->parse('main');

$xtpl->assign('modal', $xtpl2->text());
$xtpl->assign('from', date('01/m/Y', $time));
$xtpl->assign('end', date('d/m/Y', $time));

$xtpl->parse("main");
$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
