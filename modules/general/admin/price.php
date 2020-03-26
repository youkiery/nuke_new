<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$filter = array(
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'category' => $nv_Request->get_int('category', 'get', 0),
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 20)
);

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'item-insert':
      $data = $nv_Request->get_array('data', 'post');

      $sql = "insert into `". PREFIX ."price_item` (code, name, category) values('$data[code]', '$data[name]', '$data[category]')";
      if ($db->query($sql)) {
        $id = $db->lastInsertId();
        foreach ($data['section'] as $section) {
          $sql = "insert into `". PREFIX ."price_detail` (itemid, number, price) values($id, '$section[number]', ". str_replace(',', '', $section['price']) .")";
          $db->query($sql);
        }
        $result['status'] = 1;
        $result['notify'] = 'Thêm hàng hóa thành công';
        $result['html'] = priceContent($filter);
      }
    break;
    case 'item-edit':
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');
      $section = $data['section'];
      $count = count($section);

      $sql = "update `". PREFIX ."price_item` set code = '$data[code]', name = '$data[name]', category = $data[category] where id = " . $id;
      if ($db->query($sql)) {
        $sql = "select * from `". PREFIX ."price_detail` where itemid = " . $id;
        $query = $db->query($sql);
        $current = 0;

        while ($row = $query->fetch()) {
          if ($current < $count) {
            // cập nhật
            $sql = "update `". PREFIX ."price_detail` set number = '". $section[$current]['number'] ."', price = ". str_replace(',', '', $section[$current]['price']) ." where id = " . $row['id'];
          }
          else {
            // xóa
            $sql = "delete from `". PREFIX ."price_detail` where id = " . $row['id'];
          }
          // echo $sql . '<br>';
          $db->query($sql);
          $current ++;
        }
        // thêm phần còn lại
        for ($i = $current; $i < $count; $i++) { 
          $sql = "insert into `". PREFIX ."price_detail` (itemid, number, price) values($id, '". $section[$current]['number'] ."', ". str_replace(',', '', $section[$current]['price']) .")";
          $db->query($sql);
        }
        $result['status'] = 1;
        $result['notify'] = 'Đã cập nhật thông tin';
        $result['html'] = priceContent($filter);
      }
    break;
    case 'item-get':
      $id = $nv_Request->get_int('id', 'post');
      
      $sql = 'select * from `'. PREFIX .'price_detail` where itemid = ' . $id;
      $query = $db->query($sql);
      $section = array();
      while ($row = $query->fetch()) {
        $row['price'] = number_format($row['price'], 0, '', ',');
        $section[]= $row;
      }

      $sql = 'select * from `'. PREFIX .'price_item` where id = ' . $id;
      $query = $db->query($sql);
      if ($row = $query->fetch()) {
        $row['section'] = $section;
        $result['status'] = 1;
        $result['data'] = $row;
      }
    break;
    case 'item-remove':
      $id = $nv_Request->get_int('id', 'post');
      
      $sql = 'delete from `'. PREFIX .'price_item` where id = ' . $id;
      $sql2 = 'delete from `'. PREFIX .'price_detail` where itemid = ' . $id;
      if ($db->query($sql) && $db->query($sql2)) {
        $result['status'] = 1;
        $result['html'] = priceContent($filter);
        $result['notify'] = 'Đã xóa mặt hàng';
      }
    break;
    case 'category-insert':
      $name = $nv_Request->get_string('name', 'post');
      
      $sql = 'insert into `'. PREFIX .'price_category` (name) values("'. $name .'")';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = priceCategoryContent();
        $result['notify'] = 'Đã thêm danh mục';
      }
    break;
    case 'category-toggle':
      $id = $nv_Request->get_int('id', 'post');
      
      $sql = 'select * from `'. PREFIX .'price_category` where id = ' . $id;
      $query = $db->query($sql);
      $category = $query->fetch();

      $sql = 'update `'. PREFIX .'price_category` set active = '. (intval(!$category['active'])) .' where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = priceCategoryContent();
      }
    break;
    case 'category-update':
      $id = $nv_Request->get_int('id', 'post');
      $name = $nv_Request->get_string('name', 'post');
      
      $sql = 'update `'. PREFIX .'price_category` set name = "'. $name .'" where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã cập nhật';
      }
    break;
    case 'filter-user':
      $name = $nv_Request->get_string('name', 'post');
      
      $result['status'] = 1;
      $result['html'] = priceFilterUser($name);
    break;
    case 'insert-allower':
      $id = $nv_Request->get_int('id', 'post');
      $name = $nv_Request->get_string('name', 'post');
      
      $sql = 'insert into `'. PREFIX .'price_allow` (userid) values('. $id .')';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = priceAllowerContent();
        $result['html2'] = priceFilterUser($name);
        $result['notify'] = 'Đã thêm quản lý';
      }
    break;
    case 'remove-allower':
      $id = $nv_Request->get_int('id', 'post');
      $name = $nv_Request->get_string('name', 'post');
      
      $sql = 'delete from `'. PREFIX .'price_allow` where userid = '. $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = priceAllowerContent();
        $result['html2'] = priceFilterUser($name);
        $result['notify'] = 'Đã xóa quản lý';
      }
    break;
    case 'get-suggest':
      $keyword = $nv_Request->get_string('keyword', 'post');
      $xtpl = new XTemplate("item-suggest.tpl", PATH);
      $sql = 'select * from `'. PREFIX .'catalog` where name like "%'. $keyword .'%" order by id desc limit 10';
      $query = $db->query($sql);
      
      while ($row = $query->fetch()) {
        $xtpl->assign('unit', '');
        if (!empty($row['unit'])) $xtpl->assign('unit', '('. $row['unit'] .')');
        $xtpl->assign('code', $row['code']);
        $xtpl->assign('name', $row['name']);
        $xtpl->assign('price', number_format($row['price'], 0, '', ','));
        $xtpl->assign('categoryid', $row['categoryid']);
        $xtpl->parse('main');
      }
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign('module_name', $module_name);
$xtpl->assign('op', $op);
$xtpl->assign('modal', priceModal());
$xtpl->assign('category_option', priceCategoryOption($filter['category']));
$xtpl->assign('content', priceContent($filter));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");