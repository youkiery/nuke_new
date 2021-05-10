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
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'order' => $nv_Request->get_string('limit', 'get', ''),
  'type' => $nv_Request->get_string('limit', 'get', '')
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
    case 'insert-product':
      $data = $nv_Request->get_array('data', 'post');
      $data['name'] = mb_strtolower($data['name']);
      $data['code'] = mb_strtolower($data['code']);

      if (empty($data['code'])) $result['code'] = 'Mã hàng trống';
      if (empty($data['name'])) $result['name'] = 'Tên hàng trống';
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
          $result['data'] = productContent();
        }
      }
      break;
    case 'update-product':
      $id = $nv_Request->get_string('id', 'post');
      $data = $nv_Request->get_array('data', 'post');
      
      if (empty($data['code'])) $result['code'] = 'Mã hàng trống';
      if (empty($data['name'])) $result['name'] = 'Tên hàng trống';
      else {
        $sql = "select * from pet_daklak_product where name = '$data[name]' and id <> $id limit 1";
        $query = $db->query($sql);
        $name = $query->fetch();

        $sql = "select * from pet_daklak_product where code = '$data[code]' and id <> $id limit 1";
        $query = $db->query($sql);
        $code = $query->fetch();
  
        if (!empty($name)) {
          $result['msg'] = 'Tên hàng đã tồn tại';
        }
        else if (!empty($code)) {
          $result['msg'] = 'Mã hàng đã tồn tại';
        }
        else {
          $sql = "update pet_daklak_product set code = '$data[code]', name = '$data[name]', unit = '$data[unit]', buy_price = $data[buy_price], sell_price = $data[sell_price] where id = $id";
          $db->query($sql);

          $result['status'] = 1;
          $result['data'] = productContent();
        }
      }
      break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('content', productContent());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
