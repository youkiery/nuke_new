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

// $sql = "select * from pet_form_remindv2 where name like '%%'";
// $query = $db->query($sql);

// while ($row = $query->fetch()) {
//     $name = str_replace('', '', $row['name']);
//     $sql = "update pet_form_remindv2 set name = $name where id = $row[id]";
//     $db->query($sql);
// }

// cập nhật chủ hộ thư ký
// $query = $db->query('select * from `'. PREFIX .'_secretary`');
// while ($row = $query->fetch()) {
//   if (empty($row['mcode'])) {
//     $query2 = $db->query('select * from `'. PREFIX .'_row` where id = ' . $row['rid']);
//     $f5 = $query2->fetch();

//     if (!empty($f5['mcode'])) {
//       echo 'update `'. PREFIX .'_secretary` set mcode = "'. $f5['mcode'] .'" where id = '. $row['id'] .'<br>';
//       $db->query('update `'. PREFIX .'_secretary` set mcode = "'. $f5['mcode'] .'" where id = '. $row['id']);
//     }
//   }
//   if (empty($row['owner'])) {
//     $query2 = $db->query('select * from `'. PREFIX .'_row` where id = ' . $row['rid']);
//     $f5 = $query2->fetch();

//     if (!empty($f5['owner'])) {
//       echo 'update `'. PREFIX .'_secretary` set owner = "'. $f5['owner'] .'" where id = '. $row['id'] .'<br>';
//       $db->query('update `'. PREFIX .'_secretary` set owner = "'. $f5['owner'] .'" where id = '. $row['id']);
//     }
//   }
//   if (empty($row['ownaddress'])) {
//     $query2 = $db->query('select * from `'. PREFIX .'_row` where id = ' . $row['rid']);
//     $f5 = $query2->fetch();

//     if (!empty($f5['sampleplace'])) {
//       echo 'update `'. PREFIX .'_secretary` set ownaddress = "'. $f5['sampleplace'] .'" where id = '. $row['id'] .'<br>';
//       $db->query('update `'. PREFIX .'_secretary` set ownaddress = "'. $f5['sampleplace'] .'" where id = '. $row['id']);
//     }
//   }
// }
// die();

// cập nhật 
// $query = $db->query($sql = 'select * from `'. PREFIX .'_notires`');

// while ($row = $query->fetch()) {
//   $data = json_decode($row['data']);
//   $secq = $db->query($secs = 'select * from `'. PREFIX .'_secretary` where rid = ' . $row['rid']);
//   // echo $secs . '<br>';
//   if (!empty($sec = $secq->fetch())) {
//     $data->{datetime} = $sec['mcode'] . '/THTY-5 ngày ' . date('d/m/Y', $sec['date']);
//     echo 'update `'. PREFIX .'_notires` set data = \''. json_encode($data, JSON_UNESCAPED_UNICODE) .'\' where rid = ' . $row['rid'] . '<br>';
//     $db->query('update `'. PREFIX .'_notires` set data = \''. json_encode($data, JSON_UNESCAPED_UNICODE) .'\' where rid = ' . $row['rid']);
//   }
//   else {
//     $f5q = $db->query($f5s = 'select * from `'. PREFIX .'_row` where rid = ' . $row['rid']);
//     // echo $f5s . '<br>';
//     if (!empty($f5 = $f5q->fetch())) {
//       $data->{datetime} = $f5['mcode'] . '/THTY-5 ngày ' . date('d/m/Y', $f5['xresend']);
//       echo 'update `'. PREFIX .'_notires` set data = \''. json_encode($data, JSON_UNESCAPED_UNICODE) .'\' where rid = ' . $row['rid'] . '<br>';
//       $db->query('update `'. PREFIX .'_notires` set data = \''. json_encode($data, JSON_UNESCAPED_UNICODE) .'\' where rid = ' . $row['rid']);
//     }
//   }
//   var_dump($row);
// }
// die();

$page_title = "Nhập hồ sơ một cửa";
$sampleType = array(0 => 'Nguyên con', 'Huyết thanh', 'Máu', 'Phủ tạng', 'Swab');
$xco = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
$yco = array('index' => 'STT','set' => 'Kết quả xét nghiệm','code' => 'Số phiếu','sender' => 'Tên đơn vị','receive' => 'Ngày nhận mẫu','resend' => 'Ngày hẹn trả kết quả','status' => 'Hình thức nhận','ireceiver' => 'Người nhận hồ sơ','ireceive' => 'Ngày nhận hồ sơ','iresend' => 'Ngay trả hồ sơ','number' => 'Số lượng mẫu','sampletype' => 'Loại mẫu','sample' => 'Loài vật lấy mẫu','xcode' => 'Số ĐKXN','isenderunit' => 'Bộ phận giao mẫu','ireceiverunit' => 'Bộ phận nhận mẫu','examdate' => 'Ngày phân tích','xresender' => 'Người phụ trách bộ phận xét nghiệm','xexam' => 'Bộ phận xét nghiệm','examsample' => 'Lượng mẫu xét nghiệm','receiver' => 'Người lấy mẫu','samplereceive' => 'Thời gian lấy mẫu','senderemploy' => 'Khách hàng','xaddress' => 'Địa chỉ','ownermail' => 'Email','ownerphone' => 'Điện thoại','owner' => 'Chủ hộ','sampleplace' => 'Nơi lấy mẫu','target' => 'Mục đích','receivedis' => 'Nơi nhận','receiveleader' => 'Người phụ trách', 'ownaddress' => 'Địa chỉ', 'ownmobile' => 'Số điện thoại');

/**
 * Cập nhật type {name => number} thành {name => {code, number}}
 */
// $sql = 'select * from `'. PREFIX .'_secretary`';
// $query = $db->query($sql);

// while ($row = $query->fetch()) {
//   $ig = json_decode($row['ig']);
//   foreach ($ig as $name => $data) {
//     if (!$data->{number}) {
//       $number = $data;
//       $ig->{$name} = array('number' => $number, 'code' => '0');
//     }
//     $sql = 'update `'. PREFIX .'_secretary` set ig = \''. json_encode($ig, JSON_UNESCAPED_UNICODE) .'\' where id = ' . $row['id'] ;
//     $db->query($sql);
//   }
// }

$sql = 'select * from `'. PREFIX .'_notires_cash`';
$select_data = array('0' => 0);
$query = $db->query($sql);
$select = '<option>0</option>';
while ($row = $query->fetch()) {
  $select_data[$row['code']] = number_format($row['price'], 0, '', ',');
  $select .= '
    <option value="'. number_format($row['price'], 0, '', ',') .'">
      '. $row['code'] .'
    </option>';
}

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$teriorname = array('endedcopy' => 'Bản copy', 'endedhour' => 'Giờ kết thúc', 'endedminute' => 'Phút kết thúc', 'code' => 'Mã phiếu', 'sender' => 'Người gửi', 'receive' => 'Người nhận', 'resend' => 'Ngày hẹn trả', 'state' => 'Hình thức nhận', 'receiver' => 'Người nhận', 'ireceive' => 'Ngày nhận', 'iresend' => 'Ngày hẹn trả', 'form' => 'Tên hồ sơ', 'number' => 'Số lượng mẫu', 'sample' => 'Loài được lấy mẫu', 'type' => 'Loại mẫu', 'samplecode' => 'Ký hiệu mẫu', 'exam' => 'Yêu cầu xét nghiệm', 'method' => 'Phương pháp', 'address' => 'Địa chỉ', 'phone' => 'Số điện thoại', 'samplereceive' => 'Ngày lấy mẫu', 'samplereceiver' => 'Người lấy mẫu', 'examdate' => 'Ngày xét nghiệm', 'result' => 'Kết quả', 'xcode' => 'Số ĐKXN', 'page' => 'Số trang', 'no' => 'Liên', 'customer' => 'Khách hàng', 'other' => 'Yêu cầu khác', 'receivehour' => 'Giờ nhận', 'receiveminute' => 'Phút nhận', 'isenderemploy' => 'Người gửi', 'isenderunit' => 'Đơn vị gửi', 'ireceiveremploy' => 'Người nhận', 'ireceiverunit' => 'Đơn vị nhận', 'status' => 'Tình trạng mẫu', 'xstatus' => 'Hình thức bảo quản', 'quality' => 'Chất lượng mẫu', 'ireceiver' => 'Người nhận', 'note' => 'Ghi chú', 'target' => 'Mục đích xét nghiệm', 'receivedis' => 'Nơi nhận', 'receiveleader' => 'Người phụ trách', 'xaddress' => 'Địa chỉ khách hàng', 'sampleplace' => 'Nơi lấy mẫu', 'owner' => 'Chủ hộ', 'xphone' => 'Số điện thoại', 'xnote' => 'Ghi chú', 'numberword' => 'Ghi chú (chữ)', 'fax' => 'Fax', 'xsender' => 'Người giao mẫu', 'xsend' => 'Ngày giao mẫu', 'xreceiver' => 'Người nhận mẫu', 'xreceive' => 'Ngày nhận mẫu', 'xresend' => 'Ngày giao kết quả', 'xresender' => 'Người phụ trách', 'ig' => 'Thông tin mẫu', 'vnote' => 'Ghi chú', 'samplecode5' => 'Ký hiệu mẫu', 'examsample' => 'Số lượng mẫu xét nghiệm', 'ownermail' => 'Email', 'ownerphone' => 'Số điện thoại', 'page2' => 'Số trang', 'page3' => 'Số trang', 'page4' => 'Số trang', 'date' => 'Ngày tháng', 'org' => 'Tên tổ chức', 'address' => 'Địa chỉ', 'phone' => 'Điện thoại', 'mail' => 'email', 'content' => 'Nội dung công việc', 'type' => 'Loại mẫu', 'sample' => 'Loại động vật', 'mcode' => 'Số phiếu', 'reformer' => 'Người đề nghị');

  function getPrice($name) {
    global $db;
    if (empty($name)) {
      $sql = 'select * from pet_form_notires_row where match(name) against("'. $name .'" in boolean mode) limit 1';
    }
    else {
      $sql = 'select * from pet_form_notires_row where match(name) against(\''. $name .'\' in boolean mode) limit 1';
    }
    $query = $db->query($sql);
    if ($row = $query->fetch()) {
      return $row['price'];
    }
    return 0;
  }

  function getPrice2($name) {
    global $db;
    $sql = 'select * from pet_form_notires_cash where code = "'. $name .'" limit 1';
    $query = $db->query($sql);
    if ($row = $query->fetch()) {
      return $row['price'];
    }
    return 0;
  }
  
	$result = array("status" => 0);
	switch ($action) {
	    
    case 'get-remind':
      $name = $nv_Request->get_string('name', 'post');
      $type = $nv_Request->get_string('type', 'post');
      $key = $nv_Request->get_string('key', 'post');

      $sql = 'select * from `'. PREFIX .'_remindv2` where type = "'. $type .'" and name like "%'. $key .'%" and visible = 1 order by rate desc limit 20';
      // die($sql);
      $query = $db->query($sql);

      $html = '';
      while ($row = $query->fetch()) {
        $html .= '<div class="suggest_item" onclick="selectRemindv2(\''. $name . '\', \'' . $type . '\', \'' . $row['name'] . '\')">
          <p class="right-click">'. $row['name'] . '</p>
          <button class="close right" data-dismiss="modal" onclick="removeRemindv2(\'' . $name . '\', \'' . $type . '\', '. $row['id'] .')">&times;</button></div>';
      }
      $result['html'] = $html;
      $result['status'] = 1;
    break;

    case 'excel':
      $list = $nv_Request->get_array('list', 'post');

      include 'PHPExcel/IOFactory.php';
      $fileType = 'Excel2007'; 
      $objPHPExcel = PHPExcel_IOFactory::load('excel/thong-bao.xlsx');
      $x = 2;
      $index = 1;
      $sql = 'select * from `'. PREFIX .'_notires` where rid in ('. implode(', ', $list) .') order by rid desc';
      $query = $db->query($sql);
      while ($row = $query->fetch()) {
        $objPHPExcel
        ->setActiveSheetIndex(0)
        ->setCellValue("A" . $x, $index++);
        $irow = json_decode($row['data']);
        foreach ($irow->{data} as $val) {
          $price = getPrice2($val->{code});
          $total = $val->{number} * $price;
          $objPHPExcel
          ->setActiveSheetIndex(0)
          ->setCellValue("B" . $x, $val->{result})
          ->setCellValue("C" . $x, $val->{serotype})
          ->setCellValue("D" . $x, $val->{number})
          ->setCellValue("E" . $x, number_format($price, 0, '', ','))
          ->setCellValue("F" . $x, number_format($total, 0, '', ','))
          ->setCellValue("G" . $x, $irow->{datetime});
          $x++;
        }
      }

      $time = time(); 
      $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
      $objWriter->save('excel/thong-bao-out-'. $time .'.xlsx');
      $objPHPExcel->disconnectWorksheets();
      unset($objWriter, $objPHPExcel);
      $result['status'] = 1;
      $result['time'] = $time;
      // header('location: /excel/thong-bao-out.xlsx');
    break;
    case 'save':
      $data = $nv_Request->get_array('data', 'post');

      foreach ($data as $id => $res) {
        $sql = 'select * from `'. PREFIX .'_notires` where rid = ' . $id;
        $query = $db->query($sql);
        if (!empty($query->fetch())) {
          $sql = 'update `'. PREFIX .'_notires` set data = \'' . json_encode($res, JSON_UNESCAPED_UNICODE) . '\' where rid = ' . $id;
        }
        else {
          $sql = 'insert into `'. PREFIX .'_notires` (rid, data) values('. $id .', \'' . json_encode($res, JSON_UNESCAPED_UNICODE) . '\')';
        }
        // die($sql);
        // echo "$sql <br>";
        $db->query($sql);
      }
      $result['status'] = 1;
    break;
    case 'print-x':
      $list = $nv_Request->get_array('list', 'post');

  		$xtpl = new XTemplate('lp1-print.tpl', PATH2);
      $sql = 'select * from `'. PREFIX .'_notires` where rid in ('. implode(', ', $list) .')';
      $query = $db->query($sql);

      if (empty($query->fetch())) {
        $result['status'] = 1;
        $result['notify'] = 'Chọn lưu trước khi in';
      }
      else {
        $index = 1;
        foreach ($list as $id) {
          $sql = 'select * from `'. PREFIX .'_notires` where rid = ' . $id;
          $query = $db->query($sql);
          if ($row = $query->fetch()) {
            $ig = json_decode($row['data']);
            $xtpl->assign('row', count($ig->{data}));
            $xtpl->assign('index', $index++);
            $xtpl->assign('type', 1);
            $xtpl->assign('datetime', $ig->{datetime});
            $xtpl->parse('main.row.index');
            $xtpl->parse('main.row.datetime');
            foreach ($ig->{data} as $val) {
              $xtpl->assign('result', $val->{result});
              $xtpl->assign('serotype', $val->{serotype});
              $xtpl->assign('price', $val->{price});
              $xtpl->assign('number', number_format($val->{number}, 0, ',', ''));
              $xtpl->assign('total', number_format($val->{number} * $val->{price}, 0, ',', ''));
              $xtpl->parse('main.row');
            }
          }
        }
      }

      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'print':
      $list = $nv_Request->get_array('list', 'post');
      rsort($list);

  		$xtpl = new XTemplate('lp1-form.tpl', PATH2);
      $xtpl->assign('select', $select);

      $gindex = 1;
      $index = 1;
      foreach ($list as $id) {
        $sql = 'select * from `'. PREFIX .'_notires` where rid = '. $id;
        $query = $db->query($sql);

        $xtpl->assign('id', $id);
        if (!empty($row = $query->fetch())) {
          $data = json_decode($row['data']);
          // echo json_encode($data->{datetime}) . "<br>";
          $xtpl->assign('datetime', $data->{datetime});
          $xtpl->assign('row', count($data->{data}));
          $xtpl->assign('gindex', $gindex++);
          // $xtpl->assign('data', 1);
          // $xtpl->assign('data', json_encode($data, JSON_UNESCAPED_UNICODE));
          $xtpl->parse('main.col');
          $xtpl->parse('main.col2');
          foreach ($data->{data} as $val) {
            $price = getPrice2($val->{code});
            $xtpl->assign('index', $index++);
            $xtpl->assign('select', cashcodetohtml($val->{code}, $select_data));
            // die(cashcodetohtml($val->{code}, $select_data) . '');
            $xtpl->assign('result', $val->{result});
            $xtpl->assign('price', number_format($price, 0, '', ','));
            $xtpl->assign('serotype', $val->{serotype});
            $xtpl->assign('number', $val->{number});
            $xtpl->assign('total', number_format($val->{number} * $price, 0, '', ','));
            $xtpl->parse('main');
          }
        }
        else {
          $sql = 'select * from `'. PREFIX .'_secretary` where rid = '. $id;
          $query = $db->query($sql);

          if (!empty($row = $query->fetch())) {
            $ig = json_decode($row['ig']);
            $xtpl->assign('datetime', $row['mcode'] . '/TYV5-TH ngày ' . date('d/m/Y', $row['date']));
            $count = 0;
            foreach ($ig as $name => $number) {
              $count ++;
            }
          // $xtpl->assign('data', json_encode($data, JSON_UNESCAPED_UNICODE));
            // $xtpl->assign('data', '<span style="color: red;">2</span>');
            $xtpl->assign('row', $count);
            $xtpl->assign('gindex', $gindex++);
            $xtpl->parse('main.col');
            $xtpl->parse('main.col2');
            foreach ($ig as $name => $ig_data) {
              $price = getPrice2($ig_data->{code});
              $xtpl->assign('select', cashcodetohtml($ig_data->{code}, $select_data));
              $xtpl->assign('index', $index++);
              $xtpl->assign('result', $name);
              $xtpl->assign('price', number_format($price, 0, '', ','));
              $xtpl->assign('serotype', '');
              $xtpl->assign('number', $ig_data->{number});
              $xtpl->assign('total', number_format($ig_data->{number} * $price, 0, '', ','));
              $xtpl->parse('main');
            }
          }
          else {
            $sql = 'select mcode, ig, xresend from `'. PREFIX .'_row` where id = ' . $id;
            $query = $db->query($sql);

            if (!empty($row = $query->fetch())) {

              // $ig = json_decode($row['ig']);
              // $tempData = array();
              // foreach ($ig as $sample) {
              //   foreach ($sample->{'mainer'} as $mainer) {
              //     foreach ($mainer->{'note'} as $note) {
              //       if (empty($tempData[$note->{'note'}])) {
              //         $tempData[$note->{'note'}] = 0;
              //       }
              //       $tempData[$note->{'note'}] += $sample->{'number'};
              //     }
              //   }
              // }
              // $ig = $tempData;
              $ig = f5igtosec($row['ig']);
              // echo json_encode($ig);die();

              $xtpl->assign('datetime', $row['mcode'] . '/TYV5-TH ngày ' . date('d/m/Y', $row['xresend']));
              
              $xtpl->assign('row', count($ig));
              $xtpl->assign('gindex', $gindex++);
              // $xtpl->assign('data', 3);
              // $xtpl->assign('data', json_encode($ig, JSON_UNESCAPED_UNICODE));
              $xtpl->parse('main.col');
              $xtpl->parse('main.col2');
              foreach ($ig as $name => $data) {
                $price = getPrice2($data['code']);
                $xtpl->assign('index', $index++);
                $xtpl->assign('result', $name);
                $xtpl->assign('price', number_format($price, 0, '', ','));
                $xtpl->assign('serotype', '');
                $xtpl->assign('number', $data['number']);
                $xtpl->assign('total', number_format($data['number'] * $price, 0, '', ','));
                $xtpl->parse('main');
                // $ig_row;
              }
            }
          }
        }
      }
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'select-all':
      $filter = $nv_Request->get_array('filter', 'post');

      $today = time();
      if (empty($filter['end'])) {
        $filter['end'] = date('d/m/Y', $today);
      }

      if (empty($filter['from'])) {
        $filter['from'] = date('d/m/Y', $today - 60 * 60 * 24 * 30);
      }

      $filter['from'] = totime($filter['from']);
      $filter['end'] = totime($filter['end'] + 60 * 60 * 24 * - 1);

      $exsql = '';
      if ($filter['pay'] > 0) {
        $filter['pay'] --;

        if ($filter['pay'] > 0) {
          $exsql .= ' and id in (select rid from `'. PREFIX .'_secretary` where pay = 1)';
        }
        else {
          $exsql .= ' and id not in (select rid from `'. PREFIX .'_secretary` where pay = 1)';
        }
      }

      $sql = 'select id from `'. PREFIX .'_row` where mcode like "%'. $filter['keyword'] .'%" and sample like "%'. $filter['sample'] .'%" and sender like "%'. $filter['unit'] .'%" and exam like "%'. $filter['exam'] .'%" and xcode like "%'. $filter['xcode'] .'%" and owner like "%'. $filter['owner'] .'%" and printer = 5 and (time between '. $filter['from'] .' and '. $filter['end'] .') '. $exsql;
      $query = $db->query($sql);
      $list = array();
      while ($row = $query->fetch()) {
        $list[] = strval($row['id']);
      }

      $result['status'] = 1;
      $result['list'] = json_encode($list);
    break;
    case 'change-pay':
      $list = $nv_Request->get_array('list', 'post');
      $type = $nv_Request->get_int('type', 'post');
      $filter = $nv_Request->get_array('filter', 'post');

      foreach ($list as $id) {
        $sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
        $query = $db->query($sql);
        $row = $query->fetch();

        if (empty($row)) {
          $sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
          $query = $db->query($sql);
          $row2 = $query->fetch();

        	// $ig = json_decode($row2['ig']);
					// foreach ($ig as $sample) {
					// 	foreach ($sample->{'mainer'} as $mainer) {
					// 		foreach ($mainer->{'note'} as $note) {
					// 			if (empty($tempData[$note->{'note'}])) {
					// 				$tempData[$note->{'note'}] = 0;
					// 			}
					// 			$tempData[$note->{'note'}] += $sample->{'number'};
					// 		}
					// 	}
					// }
					// $ig = json_encode($tempData, JSON_UNESCAPED_UNICODE);
					$ig = json_encode(f5igtosec($row2['ig']), JSON_UNESCAPED_UNICODE);

          $sql = 'insert into `'. PREFIX .'_secretary` (date, org, address, phone, fax, mail, content, type, sample, xcode, ig, mcode, reformer, rid, pay, owner, ownphone, ownaddress) values('. $row2['xresend'] .', "'. $row2['sender'] .'", "'. $row2['xaddress'] .'", "'. $row2['ownerphone'] .'", "'. $row2['fax'] .'", "'. $row2['ownermail'] .'", "'. $row2['target'] .'", '. $row2['typeindex'] .', "'. $row2['sample'] .'", "'. $row2['xcode'] .'", \''. $ig .'\', "", "'. $row2['reformer'] .'", '. $id .', '. $type .', "", "", "")';
        }
        else {
          $sql = 'update `'. PREFIX .'_secretary` set pay = '. $type . ' where rid = ' . $id;
        }
        $db->query($sql);
      }
      
      if ($html = secretaryList($filter)) {
        $result['status'] = 1;
        $result['notify'] = 'Cập nhật thành công';
        $result['html'] = $html;
      }
    break;
    case 'reload':
      // rid => html(table)
			$id = $nv_Request->get_string('id', 'get/post', 0);
			$index = $nv_Request->get_string('index', 'get/post', 0);

      if (empty($data = getSerectaryById($id))) {
        if (empty($data = getF5ById($id))) {
          $result['status'] = 0;
        }
        else {
          $result['status'] = 1;
          $result['html'] = rowing(f5todata($data), $id, $index);
        }
      }
      else {
        $result['status'] = 1;
        $result['html'] = rowing(sectodata($data), $id, $index);
      }
    break;
    // rid => html(table)
    case 'reload-all':
			$list = $nv_Request->get_array('list', 'get/post', 0);
      $result['html'] = '';      
      $index = 1;

      foreach ($list as $id) {
        if (empty($data = getSerectaryById($id))) {
          if (empty($data = getF5ById($id))) {
            // do nothing
          }
          else {
            $result['html'] .= rowing(f5todata($data), $id, $index++);
          }
        }
        else {
          $result['html'] .= rowing(sectodata($data), $id, $index++);
        }
      }

      if ($result['html']) {
        $result['status'] = 1;
      }

    break;
		case 'editSecret':
			$id = $nv_Request->get_string('id', 'get/post', 0);

			if (!empty($id)) {
				$sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
        // die($sql);
				$query = $db->query($sql);
				$xtpl = new XTemplate('secretary.tpl', PATH2);
				if (!empty($row = $query->fetch())) {
					$xtpl->assign('date', date('d/m/Y', $row['date']));
					$xtpl->assign('org', $row['org']);
					$xtpl->assign('address', $row['address']);
					$xtpl->assign('fax', $row['fax']);
					$xtpl->assign('phone', $row['phone']);
					$xtpl->assign('mail', $row['mail']);
					$xtpl->assign('content', $row['content']);
					$xtpl->assign('type', $row['type']);
					$xtpl->assign('pay' . $row['pay'], 'checked');
					$xtpl->assign('owner', $row['owner']);
					$xtpl->assign('ownaddress', $row['ownaddress']);
					$xtpl->assign('ownphone', $row['ownphone']);
					$result['ig'] = $row['ig'];
				}
				else {
					$sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
          // die($sql);
					$query = $db->query($sql);
					$row = $query->fetch();
					$xtpl->assign('date', date('d/m/Y', $row['xresend']));
					$xtpl->assign('org', $row['sender']);
					$xtpl->assign('address', $row['xaddress']);	
					$xtpl->assign('phone', $row['ownerphone']);
					$xtpl->assign('mail', $row['ownermail']);
					$xtpl->assign('content', $row['target']);
					$xtpl->assign('owner', $row['owner']);
					$xtpl->assign('ownaddress', $row['sampleplace']);
					$xtpl->assign('ownmobile', '');
					$xtpl->assign('type', (!empty($sampleType[$row['typeindex']] ? $sampleType[$row['typeindex']] : $row['typevalue'])));
					$xtpl->assign('pay0', 'checked');
					$tempData = array();
					// $ig = json_decode($row['ig']);
					// foreach ($ig as $sample) {
					// 	foreach ($sample->{'mainer'} as $mainer) {
					// 		foreach ($mainer->{'note'} as $note) {
					// 			if (empty($tempData[$note->{'note'}])) {
					// 				$tempData[$note->{'note'}] = 0;
					// 			}
					// 			$tempData[$note->{'note'}] += $sample->{'number'};
					// 		}
					// 	}
					// }
					// $result['ig'] = json_encode($tempData);
					$result['ig'] = json_encode(f5igtosec($row['ig']), JSON_UNESCAPED_UNICODE);
				}
				$xtpl->assign('sample', $row['sample']);
				$xcode = explode(',', $row['xcode']);
				$xtpl->assign('xcode0', $xcode[0]);
				$xtpl->assign('xcode1', $xcode[1]);
				$xtpl->assign('xcode2', $xcode[2]);
				$xtpl->assign('mcode', $row['mcode']);
				$xtpl->assign('reformer', $row['reformer']);
				$permission = getUserType($user_info['userid']);
				if ($permission == 1 || $permission == 5) {
					$xtpl->parse('main.secretary');
				}
				$xtpl->parse('main');
				$result['status'] = 1;
				$result['html'] = $xtpl->text();
			}
		break;
		case 'secretary':
			$id = $nv_Request->get_string('id', 'get/post', 0);
			$data = $nv_Request->get_array('data', 'get/post', 0);

			if ($key = precheck($data)) {
				$result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
			}
			else {
				$sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
				$query = $db->query($sql);

				$rowd = $query->fetch();

				$sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
				$query = $db->query($sql);

				foreach ($data['ig'] as $igKey => $igVal) {
					checkRemindv2($igKey, 'examsx');
				}
				checkRemindv2($data['reformer'], 'reformer');

				$permission = getUserType($user_info['userid']);

				if (!empty($row = $query->fetch())) {
					// update
					$temp = array();
					foreach ($data as $dataKey => $dataRow) {
						if ($dataKey == 'pay') {
							if ($permission == 1 || $permission == 5) {
								$temp[] = $dataKey . ' = "'. $dataRow .'"';
							}
						}
						else if ($dataKey == 'date') {
							$temp[] = $dataKey . ' = "'. totime($dataRow) .'"';
						}
						else if ($dataKey == 'ig') {
							$temp[] = $dataKey . ' = \''. json_encode($dataRow, JSON_UNESCAPED_UNICODE) .'\'';
						}
						else {
							$temp[] = $dataKey . ' = "'. $dataRow .'"';
						}
					}
					$sql = 'update `'. PREFIX .'_secretary` set ' . implode(', ', $temp) . ' where id = ' . $row['id'];
				}
				else {
					// insert
					$temp = array();
					$temp2 = array();
					foreach ($data as $dataKey => $dataRow) {
						if ($dataKey == 'date') {
							$temp2[] = totime($dataRow);
						}
						else if ($dataKey == 'ig') {
							$temp2[] = '\''. json_encode($dataRow, JSON_UNESCAPED_UNICODE) .'\'';
						}
						else {
							$temp2[] = '"'. $dataRow .'"';
						}
						$temp[] = $dataKey;
					}
					$sql = 'insert `'. PREFIX .'_secretary` ('. implode(', ', $temp) .', rid) values (' . implode(', ', $temp2) . ', '. $id .')';
				}
        // die($sql);
				if ($db->query($sql)) {
					$result['notify'] = 'Đã cập nhật thành công';
					$result['remind'] = json_encode(getRemindv2(), JSON_UNESCAPED_UNICODE);
					$result['status'] = 1;
				}
			}
		break;
		case 'secretaryfilter':
			$filter = $nv_Request->get_array('filter', 'get/post');

			$result['status'] = 1;
			$result['html'] = secretaryList($filter);
		break;
	}
	echo json_encode($result, JSON_UNESCAPED_UNICODE);
	die();
}

$xtpl = new XTemplate("lp1.tpl", PATH2);
$xtpl->assign('select', json_encode($select_data));

$today = time();

$xtpl->assign('module_name', $module_name);
$xtpl->assign('today', date('d/m/Y', $today));
$xtpl->assign('last_week', date('d/m/Y', $today - 60 * 60 * 24 * 30));

$today = strtotime(date('Y-m-d'));
$tomorrow = $today + 60*60*24;
$yesterday = $today - 60*60*24;
$from = $today - 60*60*24*7;
$end = $today + 60*60*24*7;

$remind = getDefault();

$defaultData = array('code' => '-19', 'xcode' => '05,19,', 'result' => 'Âm tính (-)', 'receivedis' => '- Lưu: VT, Dịch tễ, Kế toán.', 'number' => '1', 'numberword' => 'Một', 'today' => date("d/m/Y", $today), 'yesterday' => date("d/m/Y", $yesterday), 'tomorrow' => date("d/m/Y", $tomorrow), 'remind' => $remind);


$methodHtml = '';
$method = array();
$permission = getUserType($user_info['userid']);

// $permissionType = array('Bị cấm', 'Kế toán', 'Chỉ đọc', 'Nhân viên', 'Siêu nhân viên', 'Quản lý');
//                          0      , 1        , 2        , 3          , 4               ,  5

$permist = array();

switch ($permission) {
	case 1:
		$xtpl->assign('secretary_active', 'active');
		$xtpl->assign('secretary', secretaryList());
		$xtpl->parse('main.secretary2');
		$xtpl->parse('main.secretary');
	break;
	case 2:
		$xtpl->assign('content', formList());
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user2');
	break;
	case 3:
		$method = getMethod();
		$methodHtml = '';
		foreach ($method as $index => $row) {
			$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
		}
		$xtpl->assign("methodOption", $methodHtml);

		for ($i = 0; $i < 60; $i++) { 
			if ($i < 10) {
				$xtpl->assign('value', '0' . $i);
			}
			else {
				$xtpl->assign('value', $i);
			}
			$xtpl->parse('main.super_user3.minute');
			$xtpl->parse('main.super_user3.minute2');
			if ($i < 24) {
				$xtpl->parse('main.super_user3.hour');
				$xtpl->parse('main.super_user3.hour2');
			}
		}

		$permist = getUserPermission($user_info['userid']);
		$permist = explode(',', $permist);
		$top = 10;
		foreach ($permist as $key) {
			$xtpl->assign('top', $top += 35);	
			$xtpl->parse('main.super_user3.p' . ($key + 1));
		}
		$xtpl->assign('top', $top += 35);	

		$xtpl->assign('content', formList());
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
		$xtpl->parse('main.super_user2');
		$xtpl->parse('main.super_user3');
	break;
	case 4: 
		$method = getMethod();
		$methodHtml = '';
		foreach ($method as $index => $row) {
			$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
		}
		$xtpl->assign("methodOption", $methodHtml);

		for ($i = 0; $i < 60; $i++) { 
			if ($i < 10) {
				$xtpl->assign('value', '0' . $i);
			}
			else {
				$xtpl->assign('value', $i);
			}
			$xtpl->parse('main.super_user3.minute');
			$xtpl->parse('main.super_user3.minute2');
			if ($i < 24) {
				$xtpl->parse('main.super_user3.hour');
				$xtpl->parse('main.super_user3.hour2');
			}
		}

		$permist = getUserPermission($user_info['userid']);
		$permist = explode(',', $permist);
		$top = 10;
		foreach ($permist as $key) {
			$xtpl->assign('top', $top += 35);	
			$xtpl->parse('main.super_user3.p' . ($key + 1));
		}
		$xtpl->assign('top', $top += 35);	

		$xtpl->assign('content', formList());
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
		$xtpl->parse('main.super_user2');
		$xtpl->parse('main.super_user3');
		$xtpl->assign('secretary', secretaryList());
		$xtpl->parse('main.secretary2');
		$xtpl->parse('main.secretary');
		$xtpl->assign('printx', secretaryList2());
		$xtpl->parse('main.printx2');
		$xtpl->parse('main.printx');
	break;
	case 5: 
		$method = getMethod();
		$methodHtml = '';
		foreach ($method as $index => $row) {
			$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
		}
		$xtpl->assign("methodOption", $methodHtml);

		$permist = '0,1,2,3,4';
		$permist = explode(',', $permist);

		for ($i = 0; $i < 60; $i++) { 
			if ($i < 10) {
				$xtpl->assign('value', '0' . $i);
			}
			else {
				$xtpl->assign('value', $i);
			}
			$xtpl->parse('main.super_user3.minute');
			$xtpl->parse('main.super_user3.minute2');
			if ($i < 24) {
				$xtpl->parse('main.super_user3.hour');
				$xtpl->parse('main.super_user3.hour2');
			}
		}

		$top = 10;
		foreach ($permist as $key) {
			$xtpl->assign('top', $top += 35);	
			$xtpl->parse('main.super_user3.p' . ($key + 1));
		}
		$xtpl->assign('top', $top += 35);	

		$xtpl->assign('content', formList());
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
		$xtpl->parse('main.super_user2');
		$xtpl->parse('main.super_user3');
		$xtpl->assign('secretary', secretaryList());
		$xtpl->parse('main.secretary2');
		$xtpl->parse('main.secretary');
		$xtpl->assign('printx', secretaryList2());
		$xtpl->parse('main.printx2');
		$xtpl->parse('main.printx');
	break;
}

$day = date('w');
$week_start = date('d/m/Y', strtotime('-'.$day.' days'));
$week_end = date('d/m/Y', strtotime('+'.(6-$day).' days'));


$xtpl->assign("excelf", $week_start);
$xtpl->assign("excelt", $week_end);

$xtpl->assign('permist', implode(',', $permist));	
$xtpl->assign('summarycontent', summaryContent($from, $end));
$xtpl->assign('summaryfrom', date('d/m/Y', $from));
$xtpl->assign('summaryend', date('d/m/Y', $end));
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign("method", json_encode($method));
$xtpl->assign("remind", json_encode(getRemind()));
$xtpl->assign("remindv2", json_encode(getRemindv2(), JSON_HEX_QUOT));
$xtpl->assign("relation", json_encode(getRelation()));
$xtpl->assign("signer", json_encode(getSigner()));
$xtpl->assign("default", json_encode($defaultData));
$xtpl->parse("main");
$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
die("");
include ( NV_ROOTDIR . "/includes/footer.php" );

