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

$page_title = "Nhập hồ sơ một cửa";
$sampleType = array(0 => 'Nguyên con', 'Huyết thanh', 'Máu', 'Phủ tạng', 'Swab');
$xco = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
$yco = array('index' => 'STT','set' => 'Kết quả xét nghiệm','code' => 'Số phiếu','sender' => 'Tên đơn vị','receive' => 'Ngày nhận mẫu','resend' => 'Ngày hẹn trả kết quả','status' => 'Hình thức nhận','ireceiver' => 'Người nhận hồ sơ','ireceive' => 'Ngày nhận hồ sơ','iresend' => 'Ngay trả hồ sơ','number' => 'Số lượng mẫu','sampletype' => 'Loại mẫu','sample' => 'Loài vật lấy mẫu','xcode' => 'Số ĐKXN','isenderunit' => 'Bộ phận giao mẫu','ireceiverunit' => 'Bộ phận nhận mẫu','examdate' => 'Ngày phân tích','examdate2' => 'Ngày phân tích','xresender' => 'Người phụ trách bộ phận xét nghiệm','xexam' => 'Bộ phận xét nghiệm','examsample' => 'Lượng mẫu xét nghiệm','receiver' => 'Người lấy mẫu','samplereceive' => 'Thời gian lấy mẫu','senderemploy' => 'Khách hàng','xaddress' => 'Địa chỉ','ownermail' => 'Email','ownerphone' => 'Điện thoại','owner' => 'Chủ hộ','sampleplace' => 'Nơi lấy mẫu','target' => 'Mục đích','receivedis' => 'Nơi nhận','receiveleader' => 'Người phụ trách', 'ownaddress' => 'Địa chỉ', 'ownmobile' => 'Số điện thoại');

// $sql = "select * from `". PREFIX ."_row`";
// $query = $db->query($sql);

// while ($row = $query->fetch()) {
//   var_dump($row);
  // $row['form'] = explode(', ', $row['form']);
  // $row['exam'] = json_decode($row['exam']);
  
  // checkRemindv2($row['sample'], 'sample');
  // checkRemindv2($row['sender'], 'sender-employ');
  // checkRemindv2($row['receiver'], 'receiver-employ');
  // foreach ($row['form'] as $value) {
  //   checkRemindv2($value, 'form');
  // }
  // foreach ($row['exam'] as $examMain) {
  //   checkRemindv2($examMain->{'symbol'}, 'symbol');
  //   checkRemindv2($examMain->{'method'}, 'method');
  //   foreach ($examMain->{'exam'} as $examNote) {
  //     checkRemindv2($examNote, 'exam');
  //   }
  // }
  
  // checkRemindv2($row['isenderunit'], 'isender-unit');
  // checkRemindv2($row['ireceiverunit'], 'ireceiver-unit');
  // checkRemindv2($row['xreceiver'], 'xreceiver');
  // checkRemindv2($row['xresender'], 'xresender');
  // checkRemindv2($row['xsender'], 'xsender');
  // checkRemindv2($row['page2'], 'page2');

  // checkRemindv2($row['xresender'], 'xresender');
  // checkRemindv2($row['xexam'] , 'xexam');
  // checkRemindv2($row['page3'], 'page3');

  // checkRemindv2($row['address'], 'address');
  // checkRemindv2($row['samplereceiver'], 'sample-receiver');
  // checkRemindv2($row['ireceiveremploy'], 'ireceiver-employ');
  // checkRemindv2($row['isenderunit'], 'isender-unit');
  // checkRemindv2($row['xphone'], 'xphone');
  // checkRemindv2($row['fax'], 'fax');
  // checkRemindv2($row['page4'], 'page4');

  // checkRemindv2($row['receiveleader'], 'receive-leader');
  // checkRemindv2($row['sender'], 'sender-employ');
  // checkRemindv2($row['sampleplace'], 'sample-place');
  // checkRemindv2($row['owner'], 'owner');
  // checkRemindv2($row['xaddress'], 'xaddress');
  // checkRemindv2($row['ownerphone'], 'ownerphone');
  // checkRemindv2($row['ownermail'], 'ownermail');
// }
// die();  

if ($nv_Request->isset_request("excel", "get")) {
  $data = array('index', 'set', 'code', 'code', 'receive', 'number', 'xcode');
  if (strlen($temp = $nv_Request->get_string('data', 'get', '')) > 0) {
    $data = explode(',', $temp);
  }

  $excelf = totime($nv_Request->get_string('excelf', 'get/post', ''));
  $excelt = totime($nv_Request->get_string('excelt', 'get/post', ''));
  include 'PHPExcel/IOFactory.php';
  $fileType = 'Excel2007'; 

  $objPHPExcel = PHPExcel_IOFactory::load('excel.xlsx');

  $j = 0;

  foreach ($data as $tag) {
    if ($tag == 'set') {
      $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue($xco[$j ++] . '1', 'Số lượng mẫu')
      ->setCellValue($xco[$j ++] . '1', 'Ký hiệu mẫu')
      ->setCellValue($xco[$j ++] . '1', 'Chỉ tiêu xét nghiệm')
      ->setCellValue($xco[$j ++] . '1', 'Kết quả');
    }
    else if (!empty($yco[$tag])) {
      $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue($xco[$j ++] . '1', $yco[$tag]);
    }
  }

  $i = 2;
  $query = "SELECT * FROM " . PREFIX . "_row where time between $excelf and $excelt";

  $re = $db->query($query);
  $index = 1;
  while ($row = $re->fetch()) {
    $objPHPExcel->setActiveSheetIndex(0);
    $j = 0;
    $xtag = 0;
    $ytag = 0;

    foreach ($data as $tag) {
      if ($xtag > 0) {
        $i = $xtag;
      }
      switch ($tag) {
        case 'index':
          $objPHPExcel
            ->setActiveSheetIndex(0)
            ->setCellValue($xco[$j ++] . $i, (($index < 10 ? '0' : '') . $index));
          $index ++;
        break;
        case 'set':
          $temp = $j;
          $xtag = $i;
          $tempData = json_decode($row['ig']);
          if (!empty($tempData)) {
            $length = count($tempData);
            foreach ($tempData as $sample) {
              $j = $temp;
              $objPHPExcel
              ->setActiveSheetIndex(0)
              ->setCellValue($xco[$j ++] . $i, $sample->{'number'})
              ->setCellValue($xco[$j ++] . $i, $sample->{'code'});
              foreach ($sample->{'mainer'} as $main) {
                $xlength = count($main->{'note'});
                foreach ($main->{'note'} as $note) {
                  $j = $temp + 2;
                  $objPHPExcel
                  ->setActiveSheetIndex(0)
                  ->setCellValue($xco[$j ++] . $i, $note->{'note'})
                  ->setCellValue($xco[$j ++] . $i, $note->{'result'});
                  $xlength --;
                  if (!empty($xlength)) {
                    $i ++;
                  }
                }
              }
              $length --;
              if (!empty($length)) {
                $i ++;
              }
            }
            $ytag = $i;
          }
          else {
            $j += 4;
          }
        break;
        case 'receive':
        case 'resend':
        case 'ireceive':
        case 'iresend':
        case 'examdate':
        case 'samplereceive':
            $objPHPExcel
            ->setActiveSheetIndex(0)
            ->setCellValue($xco[$j ++] . $i, date('d/m/Y', $row[$tag]));
        break;
        case 'status':
          if ($row['typeindex'] < 1) $value = 'Trực tiếp';
          else if ($row['typeindex'] < 2) $value = 'Bưu điện';
          else $value = $row['typevalue'];
          $objPHPExcel
             ->setActiveSheetIndex(0)
             ->setCellValue($xco[$j ++] . $i, $value);
        break;
        case 'sampletype':
          if (!empty($sampleType[$row['typeindex']])) {
            $value = $sampleType[$row['typeindex']];
          }
          else {
            $value = $row['typevalue'];
          }
          $objPHPExcel
            ->setActiveSheetIndex(0)
            ->setCellValue($xco[$j ++] . $i, $value);
        break;
        default:
          if (!empty($yco[$tag])) {
            $objPHPExcel
              ->setActiveSheetIndex(0)
              ->setCellValue($xco[$j ++] . $i, $row[$tag]);
          }
        break;
      }
      if ($ytag > 0) {
        $i = $ytag;
      }
    }
    
    $i++;
  }

  $outFile = 'excel/excel-'. time() .'.xlsx';
  $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
  $objWriter->save($outFile);
  $objPHPExcel->disconnectWorksheets();
  unset($objWriter, $objPHPExcel);
  header('location: /' . $outFile);
}

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
  $teriorname = array('endedcopy' => 'Bản copy', 'endedhour' => 'Giờ kết thúc', 'endedminute' => 'Phút kết thúc', 'code' => 'Mã phiếu', 'sender' => 'Người gửi', 'receive' => 'Người nhận', 'resend' => 'Ngày hẹn trả', 'state' => 'Hình thức nhận', 'receiver' => 'Người nhận', 'ireceive' => 'Ngày nhận', 'iresend' => 'Ngày hẹn trả', 'form' => 'Tên hồ sơ', 'number' => 'Số lượng mẫu', 'sample' => 'Loài được lấy mẫu', 'type' => 'Loại mẫu', 'samplecode' => 'Ký hiệu mẫu', 'exam' => 'Yêu cầu xét nghiệm', 'method' => 'Phương pháp', 'address' => 'Địa chỉ', 'phone' => 'Số điện thoại', 'samplereceive' => 'Ngày lấy mẫu', 'samplereceiver' => 'Người lấy mẫu', 'examdate' => 'Ngày xét nghiệm', 'examdate2' => 'Ngày xét nghiệm', 'result' => 'Kết quả', 'xcode' => 'Số ĐKXN', 'page' => 'Số trang', 'no' => 'Liên', 'customer' => 'Khách hàng', 'other' => 'Yêu cầu khác', 'receivehour' => 'Giờ nhận', 'receiveminute' => 'Phút nhận', 'isenderemploy' => 'Người gửi', 'isenderunit' => 'Đơn vị gửi', 'ireceiveremploy' => 'Người nhận', 'ireceiverunit' => 'Đơn vị nhận', 'status' => 'Tình trạng mẫu', 'xstatus' => 'Hình thức bảo quản', 'quality' => 'Chất lượng mẫu', 'ireceiver' => 'Người nhận', 'note' => 'Ghi chú', 'target' => 'Mục đích xét nghiệm', 'receivedis' => 'Nơi nhận', 'receiveleader' => 'Người phụ trách', 'xaddress' => 'Địa chỉ khách hàng', 'sampleplace' => 'Nơi lấy mẫu', 'owner' => 'Chủ hộ', 'xphone' => 'Số điện thoại', 'xnote' => 'Ghi chú', 'numberword' => 'Ghi chú (chữ)', 'fax' => 'Fax', 'xsender' => 'Người giao mẫu', 'xsend' => 'Ngày giao mẫu', 'xreceiver' => 'Người nhận mẫu', 'xreceive' => 'Ngày nhận mẫu', 'xresend' => 'Ngày giao kết quả', 'xresender' => 'Người phụ trách', 'ig' => 'Thông tin mẫu', 'vnote' => 'Ghi chú', 'samplecode5' => 'Ký hiệu mẫu', 'examsample' => 'Số lượng mẫu xét nghiệm', 'ownermail' => 'Email', 'ownerphone' => 'Số điện thoại', 'page2' => 'Số trang', 'page3' => 'Số trang', 'page4' => 'Số trang', 'date' => 'Ngày tháng', 'org' => 'Tên tổ chức', 'address' => 'Địa chỉ', 'phone' => 'Điện thoại', 'mail' => 'email', 'content' => 'Nội dung công việc', 'type' => 'Loại mẫu', 'sample' => 'Loại động vật', 'mcode' => 'Số phiếu', 'reformer' => 'Người đề nghị');

  $result = array("status" => 0);
  switch ($action) {
    // case 'catch-form':
    //   $formid = $nv_Request->get_string('formid', 'get/post', '');
    
    //   $xtpl = XTemplate('edit/form-1.tpl', PATH2);
    //   $xtpl->parse('main');
    //   $result['status'] = 1;
    //   $result['html'] = $xtpl->text();
    // break;
    case 'print-x-list':
      $list = $nv_Request->get_array('list', 'post');
      $page = $nv_Request->get_int('page', 'post');
      $filter = $nv_Request->get_array('filter', 'post');

      $xtpl = new XTemplate("print-x-list.tpl", PATH2);

      foreach ($list as $id) {
        $sql = 'select * from `'. PREFIX .'_print` where rid = ' . $id;
        $query = $db->query($sql);

        if (!empty($print = $query->fetch())) {
          $xtpl->assign('id', $id);
          $xtpl->assign('customer', $print['customer']);
          $xtpl->assign('address', $print['address']);
          $xtpl->assign('mobile', $print['mobile']);
          $xtpl->assign('fax', $print['fax']);
          $xtpl->assign('mail', $print['mail']);
          $xtpl->parse('main');
        }
        else {
          $sql = 'select sender, xaddress, ownerphone, fax, ownermail from `'. PREFIX .'_row` where id = ' . $id;
          $query = $db->query($sql);

          if (!empty($print = $query->fetch())) {
            $xtpl->assign('id', $id);
            $xtpl->assign('customer', $print['sender']);
            $xtpl->assign('address', $print['xaddress']);
            $xtpl->assign('mobile', $print['ownerphone']);
            $xtpl->assign('fax', $print['fax']);
            $xtpl->assign('mail', $print['ownermail']);
            $xtpl->parse('main');
          }
        }
      }      
      $result['html'] = $xtpl->text();
      $result['status'] = 1;
    break;
    case 'get-remind':
      $name = $nv_Request->get_string('name', 'post');
      $type = $nv_Request->get_string('type', 'post');
      $key = $nv_Request->get_string('key', 'post');

      $sql = 'select * from `'. PREFIX .'_remindv2` where type = "'. $type .'" and name like "%'. $key .'%" and visible = 1 order by rate desc limit 20';
      $query = $db->query($sql);

      $html = '';
      while ($row = $query->fetch()) {
        $html .= '
          <div class="suggest_item" onclick="selectRemindv2(\''. $name . '\', \'' . $type . '\', \'' . $row['name'] . '\')">
            <p class="right-click">'. $row['name'] . '</p>
            <button class="close right" data-dismiss="modal" onclick="removeRemindv2(\'' . $name . '\', \'' . $type . '\', '. $row['id'] .')">&times;</button></div>
        ';
      }
      $result['html'] = $html;
      $result['status'] = 1;
    break;
    case 'print-x':
      $list = $nv_Request->get_array('list', 'post');

      $xtpl = new XTemplate("print-x.tpl", PATH2);

      foreach ($list as $id) {
        $sql = 'select * from `'. PREFIX .'_print` where rid = ' . $id;
        $query = $db->query($sql);

        if (!empty($print = $query->fetch())) {
          $xtpl->assign('customer', $print['customer']);
          $xtpl->assign('address', $print['address']);
          $xtpl->assign('mobile', $print['mobile']);
          $xtpl->assign('fax', $print['fax']);
          $xtpl->assign('mail', $print['mail']);
          $xtpl->parse('main.block');
        }
        else {
          $sql = 'select sender, xaddress, ownerphone, fax, ownermail from `'. PREFIX .'_row` where id = ' . $id;
          $query = $db->query($sql);

          if (!empty($print = $query->fetch())) {
            $xtpl->assign('customer', $print['sender']);
            $xtpl->assign('address', $print['xaddress']);
            $xtpl->assign('mobile', $print['ownerphone']);
            $xtpl->assign('fax', $print['fax']);
            $xtpl->assign('mail', $print['ownermail']);
            $xtpl->parse('main.block');
          }
        }
      }      
      $xtpl->parse('main');
      $result['html'] = $xtpl->text();
      $result['status'] = 1;
    break;
    case 'save-print':
      $data = $nv_Request->get_array('data', 'post');

      foreach ($data as $id => $row) {
        $sql = 'select * from `'. PREFIX .'_print` where rid = ' . $id;
        $query = $db->query($sql);

        if (empty($query->fetch())) {
          $sql = 'insert into `'. PREFIX .'_print` (rid, customer, address, mobile, fax, mail) values('. $id .', "'. $row['customer'] .'", "'. $row['address'] .'", "'. $row['mobile'] .'", "'. $row['fax'] .'", "'. $row['mail'] .'")';
          $db->query($sql);
        }
        else {
          $sql = 'update  `'. PREFIX .'_print` set customer = "'. $row['customer'] .'", address = "'. $row['address'] .'", mobile = "'. $row['mobile'] .'", fax = "'. $row['fax'] .'", mail = "'. $row['mail'] .'" where rid = ' . $id;
          $db->query($sql);
        }
      }
      $result['status'] = 1;
    break;
    case 'change-pay':
      $list = $nv_Request->get_array('list', 'post');
      $type = $nv_Request->get_int('type', 'post');
      $page = $nv_Request->get_int('page', 'post');
      $filter = $nv_Request->get_array('filter', 'post');

      foreach ($list as $id) {
        $sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
        $query = $db->query($sql);
        $row = $query->fetch();

        if (empty($row)) {
          $sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
          $query = $db->query($sql);
          $row2 = $query->fetch();

          $ig = json_decode($row2['ig']);
          foreach ($ig as $sample) {
            foreach ($sample->{'mainer'} as $mainer) {
              foreach ($mainer->{'note'} as $note) {
                if (empty($tempData[$note->{'note'}])) {
                  $tempData[$note->{'note'}] = 0;
                }
                $tempData[$note->{'note'}] += $sample->{'number'};
              }
            }
          }
          $ig = json_encode($tempData);

          $sql = 'insert into `'. PREFIX .'_secretary` (date, org, address, phone, fax, mail, content, type, sample, xcode, ig, mcode, reformer, rid, pay) values('. $row2['xresend'] .', "'. $row2['sender'] .'", "'. $row2['xaddress'] .'", "'. $row2['ownerphone'] .'", "'. $row2['fax'] .'", "'. $row2['ownermail'] .'", "'. $row2['target'] .'", '. $row2['typeindex'] .', "'. $row2['sample'] .'", "'. $row2['xcode'] .'", \''. $ig .'\', "", "'. $row2['reformer'] .'", '. $id .', '. $type .')';
        }
        else {
          $sql = 'update `'. PREFIX .'_secretary` set pay = '. $type . ' where rid = ' . $id;
        }
        $db->query($sql);
      }
      
      if ($html = secretaryList($page, $filter)) {
        $result['status'] = 1;
        $result['notify'] = 'Cập nhật thành công';
        $result['html'] = $html;
      }
    break;
    case 'editSecret':
      $id = $nv_Request->get_string('id', 'get/post', 0);

      if (!empty($id)) {
        $sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
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
          $ig = json_decode($row['ig']);
          foreach ($ig as $sample) {
            foreach ($sample->{'mainer'} as $mainer) {
              foreach ($mainer->{'note'} as $note) {
                if (empty($tempData[$note->{'note'}])) {
                  $tempData[$note->{'note'}] = 0;
                }
                $tempData[$note->{'note'}] += $sample->{'number'};
              }
            }
          }
          $result['ig'] = json_encode($tempData);
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
              $temp2[] = '\''. json_encode($dataRow) .'\'';
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
          $result['remind'] = json_encode(getRemindv2());
          $result['status'] = 1;
        }
      }
    break;
    // case 'payChange':
    //   $id = $nv_Request->get_string('id', 'get/post', 0);
    //   $pay = $nv_Request->get_string('pay', 'get/post', 0);


    //   $sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
    //   $query = $db->query($sql);

    //   if (empty($query->fetch())) {
    //     $result['notice'] = 'Lưu mẫu trước khi thay đổi trạng thái';
    //   }
    //   else {
    //     $sql = 'update `'. PREFIX .'_secretary` set pay = "'. $pay .'" where id = ' . $id;
    //     if ($db->query($sql)) {
    //       $result['notice'] = 'Đã cập nhật trạng thái';
    //     }
    //   }
    //   $result['status'] = 1;
    // break;
    case 'summaryFilter':
      $from = $nv_Request->get_string('from', 'get/post', '');
      $end = $nv_Request->get_string('end', 'get/post', '');
      $exam = $nv_Request->get_string('exam', 'get/post', '');
      $unit = $nv_Request->get_string('unit', 'get/post', '');
      $sample = $nv_Request->get_string('sample', 'get/post', '');

      $from = totime($from);
      $end = totime($end);

      $result['status'] = 1;
      $result['html'] = summaryContent($from, $end, $exam, $unit, $sample);
    break;
    case 'secretaryPage':
      $page = $nv_Request->get_string('page', 'get/post', '');

      if (empty($page) || $page < 1) {
        $page = 1;
      }

      $result['status'] = 1;
      $result['html'] = secretaryList($page);
    break;
    case 'removeRemind':
      $id = $nv_Request->get_string('id', 'get/post', '');

      if (!(empty($id) || empty(getRemindId($id)))) {
        $sql = 'update `'.PREFIX.'_remind` set visible = 0 where id = '. $id;
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['notify'] = 'Đã xóa';
          $result['remind'] = json_encode(getRemind());
        }
      }
    break;
    case 'removeRemindv2':
      $id = $nv_Request->get_string('id', 'get/post', '');
      // $type = $nv_Request->get_string('type', 'get/post', '');
      // $type = $nv_Request->get_string('type', 'get/post', '');

      if (!(empty($id) || empty(getRemindIdv2Id($id)))) {
        $sql = 'update `'.PREFIX.'_remindv2` set visible = 0 where id = '. $id;
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['notify'] = 'Đã xóa';
          $result['remind'] = json_encode(getRemindv2());
        }
      }
    break;
    case 'filter':
      $page = $nv_Request->get_string('page', 'get/post', 1);
      $limit = $nv_Request->get_string('limit', 'get/post', 1);
      $printer = $nv_Request->get_string('printer', 'get/post', '');
      $keyword = $nv_Request->get_string('keyword', 'get/post', 1);
      $other = $nv_Request->get_array('other', 'get/post', 1);
      $xcode = $nv_Request->get_string('xcode', 'get/post', 1);
      $owner = $nv_Request->get_string('owner', 'get/post', '');

      $result['status'] = 1;
      $result['html'] = formList($keyword, $page, $limit, $printer, $other, $xcode, $owner);
    break;
    case 'secretaryfilter':
      $page = $nv_Request->get_string('page', 'get/post', 1);
      $filter = $nv_Request->get_array('filter', 'get/post');

      $result['status'] = 1;
      $result['html'] = secretaryList($page, $filter);
    break;
    case 'secretaryfilter2':
      $filter = $nv_Request->get_array('filter', 'get/post');

      $result['status'] = 1;
      $result['html'] = secretaryList2($filter);
    break;
    case 'preview':
    case 'getForm':
      $id = $nv_Request->get_string('id', 'get/post', '');
    
      $sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
      $query = $db->query($sql);

      $result['form'] = $query->fetch();
      if (empty($result['form'])) {
        $result['notify'] = 'Có lỗi xảy ra';
      }
      else {
        $result['form']['receive'] = date('d/m/Y', $result['form']['receive']);
        $result['form']['resend'] = date('d/m/Y', $result['form']['resend']);
        $result['form']['ireceive'] = date('d/m/Y', $result['form']['ireceive']);
        $result['form']['iresend'] = date('d/m/Y', $result['form']['iresend']);
        $result['form']['samplereceive'] = date('d/m/Y', $result['form']['samplereceive']);
        $result['form']['sampletime'] = date('d/m/Y', $result['form']['sampletime']);
        $result['form']['noticetime'] = date('d/m/Y', $result['form']['noticetime']);
        $result['form']['xreceive'] = date('d/m/Y', $result['form']['xreceive']);
        $result['form']['xresend'] = date('d/m/Y', $result['form']['xresend']);
        $result['form']['xsend'] = date('d/m/Y', $result['form']['xsend']);

        $result['form']['examdate'] = date('d/m/Y', $result['form']['examdate']);
        $result['form']['result'] = explode('@@', $result['form']['result']);
        if (count($result['form']['result']) == 1) $result['form']['result'] = $result['form']['result'][0];
        
        if (!empty($result['form']['examdate2'])) $result['form']['examdate2'] = date('d/m/Y', $result['form']['examdate2']);
        else $result['form']['examdate2'] = '';
        $result['form']['note'] = str_replace('<br />', '', $result['form']['note']);

        if ($result['form']['typeindex'] >= 0) {
          $result['form']['type']['index'] = $result['form']['typeindex'];
          $result['form']['type']['value'] = $result['form']['typevalue'];
        }

        if ($result['form']['stateindex'] >= 0) {
          $result['form']['state']['index'] = $result['form']['stateindex'];
          $result['form']['state']['value'] = $result['form']['statevalue'];
        }
        
        $temp = $result['form']['status'];
        $result['form']['status'] = array();
        $result['form']['status']['index'] = $temp;
        $result['status'] = 1;
      }
    break;
    case 'remove':
      $id = $nv_Request->get_string('id', 'get/post', '');
      $page = $nv_Request->get_string('page', 'get/post', 1);
      $limit = $nv_Request->get_string('limit', 'get/post', 1);
      // $printer = explode(', ',$nv_Request->get_string('printer', 'get/post', ''));
      $printer = $nv_Request->get_string('printer', 'get/post', '');
      $keyword = $nv_Request->get_string('keyword', 'get/post', 1);
      $other = $nv_Request->get_array('other', 'get/post', 1);

      if (!empty($id)) {
        $sql = 'delete from `'. PREFIX .'_row` where id = ' . $id;
        $query = $db->query($sql);

        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã xóa mẫu đơn';
          $result['html'] = formList($keyword, $page, $limit, $printer);
        }
      }
    break;
    case 'insert':
      $id = $nv_Request->get_string('id', 'get/post', '');
      $form = $nv_Request->get_string('form', 'get/post', '');
      $data = $nv_Request->get_array('data', 'get/post', '');

      $page = $nv_Request->get_string('page', 'get/post', 1);
      $limit = $nv_Request->get_string('limit', 'get/post', 1);
      $printer = $nv_Request->get_string('printer', 'get/post', '');
      $keyword = $nv_Request->get_string('keyword', 'get/post', 1);
      $other = $nv_Request->get_array('other', 'get/post', 1);
      $signer = $nv_Request->get_array('signer', 'get/post', 1);

      $clone = $nv_Request->get_int('clone', 'get/post', 0);

      $result['notify'] = 'Nhập sai thông tin, hoặc thông tin lỗi';
      $permission = getUserType($user_info['userid']);
      if ($permission < 2) {
        $result['notify'] = 'Tài khoản không có quyền truy cập';
      }
      else {
        if ($clone) {
          if ($key = precheck($data)) {
            $result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
          }
          else {
            if (!empty($_POST['data']) && !empty($_POST['data']['note'])) {
              $note = $_POST['data']['note'];
            }
            
            if (!empty($_POST['data']) && !empty($_POST['data']['vnote'])) {
              $vnote = $_POST['data']['vnote'];
            }

            $data['result'] = implode('@@', $data['result']);
  
            $iresend = totime($data['iresend']);
            $xreceive = totime($data['xreceive']);
            $xresend = totime($data['xresend']);
            $xsend = totime($data['xsend']);
            $examdate = totime($data['examdate']);
            $examdate2 = 0;
            if (!empty($data['examdate2'])) $examdate2 = totime($data['examdate2']);
            $sampleReceive = totime($data['samplereceive']);
            $receive = totime($data['receive']);          
            $resend = totime($data['resend']);
            
            checkRemindv2($data['sample'], 'sample');
            checkRemindv2($data['sender'], 'sender-employ');
            checkRemindv2($data['receiver'], 'receiver-employ');
            checkRemindv2($data['isenderunit'], 'isender-unit');
            checkRemindv2($data['ireceiverunit'], 'ireceiver-unit');
            checkRemindv2($data['xreceiver'], 'xreceiver');
            checkRemindv2($data['xresender'], 'xresender');
            checkRemindv2($data['xsender'], 'xsender');
            checkRemindv2($data['page2'], 'page2');
            checkRemindv2($data['xexam'] , 'xexam');
            checkRemindv2($data['page3'], 'page3');
            checkRemindv2($data['address'], 'address');
            checkRemindv2($data['samplereceiver'], 'sample-receiver');
            checkRemindv2($data['ireceiveremploy'], 'ireceiver-employ');
            checkRemindv2($data['xphone'], 'xphone');
            checkRemindv2($data['fax'], 'fax');
            checkRemindv2($data['page4'], 'page4');
            checkRemindv2($data['receiveleader'], 'receive-leader');
            checkRemindv2($data['sampleplace'], 'sample-place');
            checkRemindv2($data['owner'], 'owner');
            checkRemindv2($data['xaddress'], 'xaddress');
            checkRemindv2($data['ownerphone'], 'ownerphone');
            checkRemindv2($data['ownermail'], 'ownermail');
  
            foreach ($data['form'] as $value) {
              checkRemindv2($value, 'form');
            }

            foreach ($data['exam'] as $examMain) {
              checkRemindv2($examMain['symbol'], 'symbol');
              checkRemindv2($examMain['method'], 'method');
              foreach ($examMain['exam'] as $examNote) {
                checkRemindv2($examNote, 'exam');
              }
            }
  
            foreach ($data['ig'] as $sample) {
              foreach ($sample['mainer'] as $mainer) {
                checkRemindv2($mainer['main'], 'symbol');
                checkRemindv2($mainer['method'], 'method');
                foreach ($mainer['note'] as $examNote) {
                  checkRemindv2($examNote['note'], 'exam');
                }
              }
            }
  
            $exam = json_encode($data['exam'], JSON_UNESCAPED_UNICODE);
            $ig = json_encode($data['ig'], JSON_UNESCAPED_UNICODE);
            $signer = json_encode($signer, JSON_UNESCAPED_UNICODE);
  
            $sql = 'insert into `'. PREFIX .'_row` (code, sender, receive, resend, stateIndex, stateValue, receiver, ireceive, iresend, form, number, exam, sample, sampleCode, typeIndex, typeValue, time, xnote, numberword, xcode, isenderunit, ireceiverunit, xreceiver, xresender, xsender, xreceive, xresend, xsend, ig, examdate, examdate2, result, note, page2, xexam, vnote, page3, receiveHour, receiveMinute, sampleReceive, address, sampleReceiver, status, sampleCode5, xphone, ireceiveremploy, fax, page4, xaddress, examsample, noticetime, target, receiveDis, receiveLeader, sampleplace, owner, ownermail, ownerphone, mcode, signer, printer, xsign, locker) values("'. $data['code'] .'", "'. $data['sender'] .'", ' . totime($data['receive']) . ', ' . totime($data['resend']) . ', '. $data['state']['index'] .', "'. $data['state']['value'] . '", "' . $data['receiver'] . '", '. totime($data['ireceive']) . ',  '. totime($data['iresend']) . ', "'. implode(', ', $data['form']) .'", ' . $data['number'] .', \'' . $exam . '\', "'. $data['sample'] .'", "'. $data['samplecode'] .'", '. $data['type']['index'] .', "'. $data['type']['value'] .'", '. time() . ', "'. $data['xnote'] .'", "'. $data['numberword'] .'", "'. implode(',', $data['xcode']) .'", "'. $data['isenderunit'] .'", "'. $data['ireceiverunit'] .'", "'. $data['xreceiver'] .'", "'. $data['xresender'] .'", "'. $data['xsender'] .'", '. $xreceive .', "'. $xresend .'", '. $xsend .', \''. $ig .'\', '. $examdate .', '. $examdate2 .', "'. $data['result'] .'", "'.$note.'", "'. $data['page2'] .'", "'. $data['xexam'] .'", "'. $vnote .'", "'. $data['page3'] .'", '.$data['receivehour'].', '.$data['receiveminute'].', "'.$sampleReceive.'", "'.$data['address'].'", "'.$data['samplereceiver'].'", "'. $data['status']['index'] .'", "'. $data['samplecode5'] .'", "'. $data['xphone'] .'", "'. $data['ireceiveremploy'] .'", "'. $data['fax'] .'", "'. $data['page4'] .'", "'.$data['xaddress'].'", "'. $data['examsample'] .'", '. $resend .', "'. $data['target'].'", "'. $data['receivedis'] .'", "'. $data['receiveleader'] .'", "'. $data['sampleplace'] .'", "'. $data['owner'] .'", "'. $data['ownermail'] .'", "'. $data['ownerphone'] .'", "'. $data['mcode'] .'", \''. $signer .'\', 5, '. $data['xsign'] .', '. (empty($data['locker']) ? 0 : 1) .')';

            $query = $db->query($sql);
            $result['id'] = $db->lastInsertId();
            
            if ($query) {
              checkPrinter($result['id'], $form);
              $result['status'] = 1;
              $result['notify'] = 'Đã lưu mẫu';
              $result['html'] = formList($keyword, $page, $limit, $printer, $other);
              $result['remind'] = json_encode(getRemind());
              $result['remindv2'] = json_encode(getRemindv2());
              $result['default'] = json_encode(getDefault());
            }
          }
        }
        else {
          switch ($form) {
            case '1': 
              if ($key = precheck($data)) {
                $result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
              }
                else {
                  // reminded exam
                  checkRemindv2($data['sample'], 'sample');
                  checkRemindv2($data['sender'], 'sender-employ');
                  checkRemindv2($data['receiver'], 'receiver-employ');
                  foreach ($data['form'] as $value) {
                    checkRemindv2($value, 'form');
                  }
                  foreach ($data['exam'] as $examMain) {
                    checkRemindv2($examMain['symbol'], 'symbol');
                    checkRemindv2($examMain['method'], 'method');
                    foreach ($examMain['exam'] as $examNote) {
                      checkRemindv2($examNote, 'exam');
                    }
                  }
                  $exam = json_encode($data['exam'], JSON_UNESCAPED_UNICODE);
                  $signer = json_encode($signer, JSON_UNESCAPED_UNICODE);
  
                  if ($id) {
                    $sql = 'update `'. PREFIX .'_row` set code = "'. $data['code'] .'", sender = "' . $data['sender'] . '", receive = ' . totime($data['receive']) . ', resend = ' . totime($data['resend']) . ', stateIndex = '. $data['state']['index'] .', stateValue = "'. $data['state']['value'] .'", receiver = "' . $data['receiver'] . '", ireceive = '. totime($data['ireceive']) . ', iresend = '. totime($data['iresend']) . ', form = "'. implode(', ', $data['form']) .'", number = ' . $data['number'] .', exam = \'' . $exam . '\', sample = "'. $data['sample'] .'", sampleCode = "'. $data['samplecode'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", xnote = "'. $data['xnote'] .'", numberword = "'. $data['numberword'] .'", signer = \''. $signer .'\' where id = ' . $id;
                    $query = $db->query($sql);
                    $result['id'] = $id;
                  }
                  else {
                    $sql = 'insert into `'. PREFIX .'_row` (code, sender, receive, resend, stateIndex, stateValue, receiver, ireceive, iresend, form, number, exam, sample, sampleCode, typeIndex, typeValue, time, xnote, numberword, signer) values("'. $data['code'] .'", "'. $data['sender'] .'", ' . totime($data['receive']) . ', ' . totime($data['resend']) . ', '. $data['state']['index'] .', "'. $data['state']['value'] . '", "' . $data['receiver'] . '", '. totime($data['ireceive']) . ',  '. totime($data['ireceive']) . ', "'. implode(', ', $data['form']) .'", ' . $data['number'] .', \'' . $exam . '\', "'. $data['sample'] .'", "'. $data['samplecode'] .'", '. $data['type']['index'] .', "'. $data['type']['value'] .'", '. time() . ', "'. $data['xnote'] .'", "'. $data['numberword'] .'", \''. $signer .'\')';
                    // die($sql);
                    $query = $db->query($sql);
                    $result['id'] = $db->lastInsertId();
                  }
                  if ($query) {
                    checkPrinter($result['id'], $form);
                    $result['status'] = 1;
                    $result['notify'] = 'Đã lưu mẫu';
                    $result['html'] = formList($keyword, $page, $limit, $printer, $other);
                    $result['remind'] = json_encode(getRemind());
                    $result['remindv2'] = json_encode(getRemindv2());
                    $result['default'] = json_encode(getDefault());
                  }
                }  
            break;
            case '2':
              if ($key = precheck($data)) {
                $result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
              }
              else {
                if (!empty($_POST['data']) && !empty($_POST['data']['note'])) {
                  $note = $_POST['data']['note'];
                }
  
                foreach ($data['ig'] as $sample) {
                  foreach ($sample['mainer'] as $mainer) {
                    checkRemindv2($mainer['main'], 'symbol');
                    checkRemindv2($mainer['method'], 'method');
                    foreach ($mainer['note'] as $examNote) {
                      checkRemindv2($examNote['note'], 'exam');
                    }
                  }
                }
  
                checkRemindv2($data['isenderunit'], 'isender-unit');
                checkRemindv2($data['ireceiverunit'], 'ireceiver-unit');
                checkRemindv2($data['xreceiver'], 'xreceiver');
                checkRemindv2($data['xresender'], 'xresender');
                checkRemindv2($data['xsender'], 'xsender');
                checkRemindv2($data['page2'], 'page2');
  
                $data['result'] = implode('@@', $data['result']);

                $iresend = totime($data['iresend']);
                $xreceive = totime($data['xreceive']);
                $xresend = totime($data['xresend']);
                $xsend = totime($data['xsend']);
                $examdate = totime($data['examdate']);
                $examdate2 = 0;
                if (!empty($data['examdate2'])) $examdate2 = totime($data['examdate2']);
            
  
                $ig = json_encode($data['ig'], JSON_UNESCAPED_UNICODE);
                $signer = json_encode($signer, JSON_UNESCAPED_UNICODE);
  
                $sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(',', $data['xcode']) .'", isenderunit = "'. $data['isenderunit'] .'", ireceiverunit = "'. $data['ireceiverunit'] .'", xreceiver = "'. $data['xreceiver'] .'", xresender = "'. $data['xresender'] .'", xsender = "'. $data['xsender'] .'", iresend = '. $iresend .', xreceive = '. $xreceive .', xresend = "'. $xresend .'", xsend = '. $xsend .', ig = \''. $ig .'\', examdate = '. $examdate .', examdate2 = '. $examdate2 .', result = "'. $data['result'] .'", note = "'.$note.'", page2 = "'. $data['page2'] .'", signer = \''. $signer .'\' where id = ' . $id;
                if ($db->query($sql)) {
                  checkPrinter($id, $form);
                  $result['notify'] = 'Đã cập nhật mẫu';
                  $result['status'] = 1;
                  $result['id'] = $id;
                  $result['html'] = formList($keyword, $page, $limit, $printer, $other);
                  $result['remind'] = json_encode(getRemind());
                  $result['remindv2'] = json_encode(getRemindv2());
                  $result['default'] = json_encode(getDefault());
                }
              }
            break;
            case '3':
              if ($key = precheck($data)) {
                $result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
              }
              else {
                if (!empty($_POST['data']) && !empty($_POST['data']['vnote'])) {
                  $vnote = $_POST['data']['vnote'];
                }        
                $ig = json_encode($data['ig'], JSON_UNESCAPED_UNICODE);
                $signer = json_encode($signer, JSON_UNESCAPED_UNICODE);

                checkRemindv2($data['xresender'], 'xresender');
                checkRemindv2($data['xexam'] , 'xexam');
                checkRemindv2($data['page3'], 'page3');
                foreach ($data['ig'] as $sample) {
                  foreach ($sample['mainer'] as $mainer) {
                    checkRemindv2($mainer['main'], 'symbol');
                    checkRemindv2($mainer['method'], 'method');
                    foreach ($mainer['note'] as $examNote) {
                      checkRemindv2($examNote['note'], 'exam');
                    }
                  }
                }
  
                $sql = 'update `'. PREFIX .'_row` set  xcode = "'. implode(',', $data['xcode']) .'", ig = \''. $ig .'\', xresender = "'. $data['xresender'] .'", xexam = "'. $data['xexam'] .'", vnote = "'. $vnote .'", page3 = "'. $data['page3'] .'", signer = \''. $signer .'\' where id = ' . $id;
                if ($db->query($sql)) {
                  checkPrinter($id, $form);
                  $result['notify'] = 'Đã cập nhật mẫu';
                  $result['status'] = 1;
                  $result['id'] = $id;
                  $result['html'] = formList($keyword, $page, $limit, $printer, $other);
                  $result['remind'] = json_encode(getRemind());
                  $result['remindv2'] = json_encode(getRemindv2());
                  $result['default'] = json_encode(getDefault());
                }
              }
            break;
            case '4':
              if ($key = precheck($data)) {
                $result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
              }
              else {
                $sampleReceive = totime($data['samplereceive']);
                $receive = totime($data['receive']);
                $examDate = totime($data['examdate']);
                $examdate2 = 0;
                if (!empty($data['examdate2'])) $examdate2 = totime($data['examdate2']);
            
                $note = nl2br($data['note']);
                $data['result'] = implode('@@', $data['result']);
  
                checkRemindv2($data['address'], 'address');
                checkRemindv2($data['samplereceiver'], 'sample-receiver');
                checkRemindv2($data['ireceiveremploy'], 'ireceiver-employ');
                checkRemindv2($data['isenderunit'], 'isender-unit');
                checkRemindv2($data['xphone'], 'xphone');
                checkRemindv2($data['fax'], 'fax');
                checkRemindv2($data['page4'], 'page4');
                // check reminded
                
                foreach ($data['exam'] as $examMain) {
                  checkRemindv2($examMain['symbol'], 'symbol');
                  checkRemindv2($examMain['method'], 'method');
                  foreach ($examMain['exam'] as $examNote) {
                    checkRemindv2($examNote, 'exam');
                  }
                }
                $exam = json_encode($data['exam'],JSON_UNESCAPED_UNICODE);
                $signer = json_encode($signer, JSON_UNESCAPED_UNICODE);

                $sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(',', $data['xcode']) .'", receiveHour = '.$data['receivehour'].', receiveMinute = '.$data['receiveminute'].', sampleReceive = "'.$sampleReceive.'", address = "'.$data['address'].'", sampleReceiver = "'.$data['samplereceiver'].'", examdate = "'.$examDate.'", examdate2 = "'.$examdate2.'", result = "'. $data['result'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", number = '. $data['number'] .', status = "'. $data['status']['index'] .'", sampleCode5 = "'. $data['samplecode5'] .'", receive = '. $receive .', note = "'. $note .'", xphone = "'. $data['xphone'] .'", sample = "'. $data['sample'] .'", isenderUnit = "'. $data['isenderunit'] .'", ireceiverEmploy = "'. $data['ireceiveremploy'] .'", exam = \''. $exam .'\', numberword = "'. $data['numberword'] .'", fax = "'. $data['fax'] .'", page4 = "'. $data['page4'] .'", xexam = "'. $data['xexam'] .'", xresender = "'. $data['xresender'] .'", signer = \''. $signer .'\' where id = ' . $id;
                $query = $db->query($sql);
                if ($query) {
                  checkPrinter($id, $form);
                  $result['notify'] = 'Đã cập nhật mẫu';
                  $result['status'] = 1;
                  $result['id'] = $id;
                  $result['html'] = formList($keyword, $page, $limit, $printer, $other);
                  $result['remind'] = json_encode(getRemind());
                  $result['remindv2'] = json_encode(getRemindv2());
                  $result['default'] = json_encode(getDefault());
                }
              }
            break;
            case '5':
              if ($key = precheck($data)) {
                $result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
              }
              else {
                $resend = totime($data['resend']);
                $receive = totime($data['receive']);
                $samplereceive = totime($data['samplereceive']);
                $note = nl2br($data['note']);
                
                checkRemindv2($data['receiveleader'], 'receive-leader');
                checkRemindv2($data['sender'], 'sender-employ');
                checkRemindv2($data['sampleplace'], 'sample-place');
                checkRemindv2($data['owner'], 'owner');
                checkRemindv2($data['xaddress'], 'xaddress');
                checkRemindv2($data['ownerphone'], 'ownerphone');
                checkRemindv2($data['ownermail'], 'ownermail');
                foreach ($data['exam'] as $examMain) {
                  checkRemindv2($examMain['symbol'], 'symbol');
                  checkRemindv2($examMain['method'], 'method');
                  foreach ($examMain['exam'] as $examNote) {
                    checkRemindv2($examNote, 'exam');
                  }
                }
                $exam = json_encode($data['exam'], JSON_UNESCAPED_UNICODE);
                $signer = json_encode($signer, JSON_UNESCAPED_UNICODE);
                $data['result'] = implode('@@', $data['result']);
      
                $sql = 'update `'. PREFIX .'_row` set xaddress = "'.$data['xaddress'].'", number = '. $data['number'] .', samplecode5 = "'. $data['samplecode5'] .'", examsample = "'. $data['examsample'] .'", note = "'. $note .'", noticetime = '. $resend .', target = "'. $data['target'].'", exam = \''. $exam .'\', receiveDis = "'. $data['receivedis'] .'", receiveLeader = "'. $data['receiveleader'] .'", sampleplace = "'. $data['sampleplace'] .'", owner = "'. $data['owner'] .'", xcode = "'. implode(',', $data['xcode']) .'", receive = "'. $receive .'", result = "'. $data['result'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", sender = "'. $data["sender"] .'", numberword = "'. $data['numberword'] .'", ownermail = "'. $data['ownermail'] .'", ownerphone = "'. $data['ownerphone'] .'", mcode = "'. $data['mcode'] .'", samplereceive = '. $samplereceive .', signer = \''. $signer .'\', xsign = '. $data['xsign'] .', locker = '. (empty($data['locker']) ? 0 : 1) .' where id = ' . $id;
                $query = $db->query($sql);
                if ($query) {
                  checkPrinter($id, $form);
                  $result['notify'] = 'Đã cập nhật mẫu';
                  $result['status'] = 1;
                  $result['id'] = $id;
                  $result['html'] = formList($keyword, $page, $limit, $printer);
                  $result['remind'] = json_encode(getRemind());
                  $result['remindv2'] = json_encode(getRemindv2());
                  $result['default'] = json_encode(getDefault());
                }
              }
            break;
          }
        }
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign('module_name', $module_name);

$today = time();

$xtpl->assign('today', date('d/m/Y', $today));
$xtpl->assign('last_week', date('d/m/Y', $today - 60 * 60 * 24 * 30));

$today = strtotime(date('Y-m-d'));
$tomorrow = $today + 60*60*24;
$yesterday = $today - 60*60*24;
$from = $today - 60*60*24*7;
$end = $today + 60*60*24*7;

$remind = getDefault();

$defaultData = array('code' => '-19', 'xcode' => '05,20,', 'result' => 'Âm tính (-)', 'receivedis' => '- Lưu: VT, Dịch tễ, Kế toán.', 'number' => '1', 'numberword' => 'Một', 'today' => date("d/m/Y", $today), 'yesterday' => date("d/m/Y", $yesterday), 'tomorrow' => date("d/m/Y", $tomorrow), 'remind' => $remind);


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
    $top = 1;
    foreach ($permist as $key) {
      $xtpl->assign('top', $top += 1);  
      $xtpl->parse('main.super_user3.p' . ($key + 1));
    }
    $xtpl->assign('top', $top += 1);  

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
    $top = 1;
    foreach ($permist as $key) {
      $xtpl->assign('top', $top += 1);  
      $xtpl->parse('main.super_user3.p' . ($key + 1));
    }
    $xtpl->assign('top', $top += 1);  

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

    $top = 1;
    foreach ($permist as $key) {
      $xtpl->assign('top', $top += 1);  
      $xtpl->parse('main.super_user3.p' . ($key + 1));
    }
    $xtpl->assign('top', $top += 1);  

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

/** */

// $permist = '';
// if (!empty($user_info)) {
//   if (in_array('1', $user_info['in_groups'])) {
//     $permist = '1,2,3,4,5';
//   }
//   else {
//     $permist = getUserPermission($user_info['userid']);
//   }
// }
// $xtpl->assign('permist', $permist);  


/** */

// $permist = '0,1,2,3,4';
// $permist = explode(',', $permist);
// $top = 10;
// foreach ($permist as $key) {
//   $xtpl->assign('top', $top += 35);  
//   $xtpl->parse('main.mod2.p' . ($key + 1));
// }
// $xtpl->assign('top', $top += 35);  
// $permission = getUserType($user_info['userid']);
// if ($permission >= 2) {
//   $xtpl->assign('secretary', secretaryList());
//   $xtpl->parse('main.secretary2');
//   $xtpl->parse('main.secretary');
// }

/** */

// if ($permission || checkIsMod($user_info['userid'])) {
  
//   for ($i = 0; $i < 60; $i++) { 
//     if ($i < 10) {
//       $xtpl->assign('value', '0' . $i);
//     }
//     else {
//       $xtpl->assign('value', $i);
//     }
//     $xtpl->parse('main.mod2.minute');
//     $xtpl->parse('main.mod2.minute2');
//     if ($i < 24) {
//       $xtpl->parse('main.mod2.hour');
//       $xtpl->parse('main.mod2.hour2');
//     }
//   }
//   if ($permission > 2) {
//     $method = getMethod();
//     $methodHtml = '';
//     foreach ($method as $index => $row) {
//       $methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
//     }
//     $xtpl->parse('main.mod');
//     $xtpl->parse('main.mod2');
//   }
// }
/** */
$day = date('w');
$week_start = date('d/m/Y', strtotime('-'.$day.' days'));
$week_end = date('d/m/Y', strtotime('+'.(6-$day).' days'));

for ($i = 1; $i <= 5; $i ++) { 
  $xtpl2 = new XTemplate('form'. $i .'.xtpl', NV_ROOTDIR . '/modules/'. $module_file . '/template/user');
  $xtpl2->parse('main');
  $xtpl->assign("form". $i, $xtpl2->text());
}

$xtpl->assign("excelf", $week_start);
$xtpl->assign("excelt", $week_end);

$xtpl->assign('permist', implode(',', $permist));  
$xtpl->assign('summarycontent', summaryContent($from, $end));
$xtpl->assign('summaryfrom', date('d/m/Y', $from));
$xtpl->assign('summaryend', date('d/m/Y', $end));
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign("method", json_encode($method));
$xtpl->assign("remind", json_encode(getRemind()));
$xtpl->assign("remindv2", json_encode(getRemindv2(), JSON_UNESCAPED_UNICODE));
$xtpl->assign("relation", json_encode(getRelation()));
$xtpl->assign("signer", json_encode(getSigner()));
$xtpl->assign("default", json_encode($defaultData));
$xtpl->parse("main");
$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
die();
include ( NV_ROOTDIR . "/includes/footer.php" );
