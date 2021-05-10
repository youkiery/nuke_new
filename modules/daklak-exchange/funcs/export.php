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
  'from' => $nv_Request->get_string('from', 'get', ''),
  'end' => $nv_Request->get_string('end', 'get', ''),
  'keyword' => $nv_Request->get_string('keyword', 'get', '')
);

$action = $nv_Request->get_string('action', 'post');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'remove-export':
      $id = $nv_Request->get_string('id', 'post');

      $sql = 'select * from pet_daklak_export_row where exportid = '. $id;
      $query = $db->query($sql);

      while ($row = $query->fetch()) {
        $sql = 'update pet_daklak_product set number = number + '. $row['number'] .' where id = '. $row['itemid'];
        $db->query($sql);
      }
      $sql = 'delete from pet_daklak_export_row where exportid = '. $id;
      $db->query($sql);
      $sql = 'delete from pet_daklak_export where id = '. $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = exportContent();
      break;
    case 'get-export':
      $id = $nv_Request->get_string('id', 'post');

      $sql = "select * from pet_daklak_export where id = $id";
      $query = $db->query($sql);
      $export = $query->fetch();
      $source = getSource($export['sourceid']);

      $sql = "select a.number, a.price, b.id, b.code, b.name from pet_daklak_export_row a inner join pet_daklak_product b on a.itemid = b.id where exportid = $id";
      $query = $db->query($sql);
      $list = array();
      while ($item = $query->fetch()) {
        $list [$item['id']] = array(
          'code' => $item['code'],
          'name' => $item['name'],
          'number' => $item['number'],
          'price' => $item['price']
        );
      }

      $result['status'] = 1;
      $result['total'] = $export['total'];
      $result['source'] = array(
        'id' => $source['id'],
        'name' => $source['name']
      );
      $result['list'] = $list;
    break;
    case 'update-export':
      $iid = $nv_Request->get_string('id', 'post');
      $source = $nv_Request->get_string('source', 'post');
      $data = $nv_Request->get_array('data', 'post');

      /**
       * 1. kiểm tra current, lưu vào trong biến
       * 2. for data, so sánh thay đổi
       * 3. cập nhật thay đổi trên export_row
       * 4. cập nhật số lượng product
       */

      $sql = "select a.number, a.price, b.id, b.code, b.name from pet_daklak_export_row a inner join pet_daklak_product b on a.itemid = b.id where exportid = $iid";
      $query = $db->query($sql);
      $list = array();
      while ($item = $query->fetch()) {
        $list [$item['id']] = array(
          'status' => 0,
          'compare' => $item['number'] * 1,
          'number' => $item['number'],
          'price' => $item['price']
        );
      }

      $total = 0;
      foreach ($data as $id => $item) {
        if (empty($list[$id])) $list[$id]['status'] = 1;
        else $list[$id]['status'] = 2;
        $list[$id]['compare'] -= $item['number'];
        $list[$id]['number'] = $item['number'];
        $list[$id]['price'] += $item['price'];
        $total += $item['price'] * $item['number'];
      }

      foreach ($list as $id => $item) {
        switch ($item['status']) {
          case 0:
            // remove
            $sql = "delete from pet_daklak_export_row where itemid = $id and exportid = $iid";
            $db->query($sql);
            break;
          case 1:
            // insert
            $sql = "insert into pet_daklak_export_row (exportid, itemid, number, price, total) values($iid, $id, $item[number], $item[price], ". ($item['number'] * $item['price']) .")";
            $db->query($sql);
            break;
          case 0:
            // update
            $sql = "update pet_daklak_export_row set number = $item[number] where itemid = $id and exportid = $iid";
            $db->query($sql);
            break;
        }

        $sql = "update pet_daklak_product set number = number ". ($item['compare'] > 0 ? '+' : '-') ." $item[compare] where id = $id";
        $db->query($sql);
      }
      $sql = "update pet_daklak_export set total = $total, sourceid = $source where id = $iid";
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = exportContent();
      break;
    case 'insert-export':
      $source = $nv_Request->get_string('source', 'post');
      $data = $nv_Request->get_array('data', 'post');

      // id => [code, name, number]

      $total = 0;
      foreach ($data as $id => $row) {
        $total += $row['number'] * $row['price'];
      }
      $sql = 'insert into pet_daklak_export (userid, sourceid, total, time) values('. $user_info['userid'] .', '. $source .', '. $total .', '. time() .')';
      $db->query($sql);
      $iid = $db->lastInsertId();

      foreach ($data as $id => $row) {
        $sql = 'insert into pet_daklak_export_row (exportid, itemid, number, price, total) values('. $iid .', '. $id .', '. $row['number'] .', '. $row['price'] .', '. ($row['number'] * $row['price']) .')';
        $db->query($sql);

        $sql = 'update pet_daklak_product set number = number + '. $row['number'] .', sell_price = '. $row['price']. ' where id = '. $id .'';
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['html'] = exportContent();
      break;
    case 'get-product':
      $id = $nv_Request->get_string('id', 'post', '0');

      $sql = 'select * from pet_daklak_product where id = '. $id;
      $query = $db->query($sql);
      $product = $query->fetch();

      $result['status'] = 1;
      $result['data'] = $product;
      break;
    case 'insert-product':
      $data = $nv_Request->get_array('data', 'post');
      $data['name'] = mb_strtolower($data['name']);
      $data['code'] = mb_strtolower($data['code']);

      if (empty($data['code'])) $result['msg'] = 'Mã hàng trống';
      if (empty($data['name'])) $result['msg'] = 'Tên hàng trống';
      else {
        $sql = "select * from pet_daklak_product where name = '$data[name]' limit 1";
        $query = $db->query($sql);
        $name = $query->fetch();

        $sql = "select * from pet_daklak_product where code = '$data[code]' limit 1";
        $query = $db->query($sql);
        $code = $query->fetch();
  
        if (!empty($name)) {
          $result['msg'] = 'Hàng hóa đã tồn tại';
        }
        else if (!empty($code)) {
          $result['msg'] = 'Mã hàng đã tồn tại';
        }
        else {
          $sql = "insert into pet_daklak_product (code, name, unit, number, buy_price, sell_price) values('$data[code]', '$data[name]', '$data[unit]', 0, $data[buy_price], $data[sell_price])";
          $db->query($sql);
          $result['status'] = 1;
          $result['data'] = array(
            'id' => $db->lastInsertId(),
            'code' => $data['code'],
            'name' => $data['name'],
            'price' => $data['sell_price'],
          );
        }
      }
      break;
      case 'get-item':
        $key = $nv_Request->get_string('keyword', 'post');
        $xtra = '';
        if (!empty($key)) $xtra = "where name like '%$key%' or code like '%$key%'";

        $sql = "select * from pet_daklak_product $xtra limit 20";
        $query = $db->query($sql);
        $xtpl = new XTemplate("item-select.tpl", PATH);
        while ($row = $query->fetch()) {
          $xtpl->assign('id', $row['id']);
          $xtpl->assign('code', $row['code']);
          $xtpl->assign('name', $row['name']);
          $xtpl->assign('price', $row['sell_price']);
          $xtpl->parse('main');
        }
        $result['status'] = 1;
        $result['html'] = $xtpl->text();
      break;
      case 'get-source':
        $key = $nv_Request->get_string('keyword', 'post');
        $xtra = '';
        if (!empty($key)) $xtra = "where name like '%$key%' or phone like '%$key%'";

        $sql = "select * from pet_daklak_source $xtra limit 20";
        $query = $db->query($sql);
        $xtpl = new XTemplate("source-select.tpl", PATH);
        while ($row = $query->fetch()) {
          $xtpl->assign('id', $row['id']);
          $xtpl->assign('name', $row['name']);
          $xtpl->assign('phone', $row['phone']);
          $xtpl->parse('main');
        }
        $result['status'] = 1;
        $result['html'] = $xtpl->text();
      break;
      case 'insert-source':
        $data = $nv_Request->get_array('data', 'post');
        $data['name'] = mb_strtolower($data['name']);

        $sql = 'select * from pet_daklak_source where name = "'. $data['name'] .'" or phone = "'. $data['phone'] .'"';
        $query = $db->query($sql);
        $row = $query->fetch();
        if (!empty($row)) $result['msg'] = 'Nguồn cung đã tồn tại';
        else {
          $sql = 'insert into pet_daklak_source (name, phone, address) values("'. $data['name'] .'", "'. $data['phone'] .'", "'. $data['address'] .'")';
          $db->query($sql);

          $result['status'] = 1;
          $result['id'] = $db->lastInsertId();
          $result['name'] = $data['name'];
        }
      break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("export-content.tpl", PATH);

$xtpl->assign('from', $filter['from']);
$xtpl->assign('end', $filter['end']);
$xtpl->assign('keyword', $filter['keyword']);
$xtpl->assign('content', exportContent());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
