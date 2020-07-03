<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 20),
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'tag' => $nv_Request->get_string('tag', 'get', '')
);
$http = array(
  'keyword' => $filter['keyword'],
  'tag' => $nv_Request->get_string('tag', 'get', '')
);

$url = '/index.php?nv=' . $module_name . '&op=' . $op .'&' . http_build_query($http);

// $x = array("SHOP", "SHOP>>Balo, giỏ xách", "SHOP>>Bình xịt", "SHOP>>Cát vệ sinh", "SHOP>>Dầu tắm", "SHOP>>Đồ chơi", "SHOP>>Đồ chơi - vật dụng", "SHOP>>Giỏ-nệm-ổ", "SHOP>>Khay vệ sinh", "SHOP>>Nhà, chuồng", "SHOP>>Thức ăn", "SHOP>>Thuốc bán", "SHOP>>Thuốc bán>>thuốc sát trung", "SHOP>>Tô - chén", "SHOP>>Vòng-cổ-khớp", "SHOP>>Xích-dắt-yếm");
// foreach ($x as $a) {
//   $sql = 'insert into `'. PREFIX .'product_category` (name) values("'. $a .'")';
//   $db->query($sql);
// }
// die();
$tag_data = getTagList();
$tag_search_data = getTagSearchList();

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'update':
      $check = $nv_Request->get_int('check', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');

      foreach ($data as $item) {
        $item['code'] = (empty($item['code']) ? '' : $item['code']);
        $item['name'] = (empty($item['name']) ? '' : $item['name']);
        $item['n1'] = (empty($item['n1']) ? 0 : $item['n1']);
        $item['n2'] = (empty($item['n2']) ? 0 : $item['n2']);
        $item['low'] = (empty($item['low']) ? 0 : $item['low']);
        $item['pos'] = (empty($item['pos']) ? '' : $item['pos']);
        $item['tag'] = (empty($item['tag']) ? array() : explode(', ', $item['tag']));
        $sql = 'select * from `'. PREFIX .'catalog` where code = "'. $item['code'] .'"';
        $query = $db->query($sql);
        $row = $query->fetch();
        if (empty($row)) {
          // insert catalog
          $sql = 'insert into `'. PREFIX .'catalog` (code, name, unit, categoryid, price) values("'. $item['code'] .'", "'. $item['name'] .'", "", 0, 0)';
          $db->query($sql);
          $row['id'] = $db->lastInsertId();
        }
        $sql = 'select * from `'. PREFIX .'product` where itemid = ' . $row['id'];
        $query = $db->query($sql);
        $product = $query->fetch();
        if (empty($product)) {
          if ($check) {
            $sql = 'insert into `'. PREFIX .'product` (itemid, tag, pos, low, n1, n2) values('. $row['id'] .', \''. json_encode(array()) .'\', "'. $item['pos'] .'", "'. $item['low'] .'", '. $item['n1'] .', '. $item['n2'] .')';
            $db->query($sql);
          }
        }
        else {
          $xtra = '';
          if (!count($item['tag'])) {
            $tag = explode(', ', $item['tag']);
            checkTag($tag, $tag_data);
          }
          $xtra .= 'tag = \''. json_encode($item['tag'], JSON_UNESCAPED_UNICODE) .'\', ';
          if (!empty($item['pos']) && strlen($item['pos'])) $xtra .= 'pos = "'. $item['pos'] .'", ';
          if (!empty($item['low']) && strlen($item['low'])) $xtra .= 'low = "'. $item['low'] .'", ';

          $sql = 'update `'. PREFIX .'product` set '. (strlen($xtra) ? $xtra : '') .' n1 = '. $item['n1'] .', n2 = '. $item['n2'] .' where id = ' . $product['id'];
          $db->query($sql);
        }
      }
      $result['status'] = 1;
    break;
    case 'statistic':
      $keyword = $nv_Request->get_string('keyword', 'post', '');
      $tag = $nv_Request->get_array('tag', 'post');

      $result['status'] = 1;
      $result['html'] = productStatisticContent($keyword, $tag);
    break;
    case 'insert-product':
      $id = $nv_Request->get_int('id', 'post', 0);
      $low = $nv_Request->get_int('low', 'post', 0);
      $keyword = mb_strtolower($nv_Request->get_string('keyword', 'post', ''));

      $sql = 'insert into `'. PREFIX .'product` (itemid, low, tag) values ('. $id .', '. $low .', \''. json_encode(array()) .'\')';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = productList($url, $filter);
        $result['html2'] = productSuggest($keyword);
      }
    break;
    case 'product-suggest':
      $keyword = mb_strtolower($nv_Request->get_string('keyword', 'post', ''));

      $result['status'] = 1;
      $result['html'] = productSuggest($keyword);
    break;
    case 'remove':
      $list = $nv_Request->get_array('list', 'post');
      
      foreach ($list as $id) {
        $sql = 'delete from `'. PREFIX .'product` where id = ' . $id;
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['notify'] = 'Đã xóa sản phẩm';
      $result['html'] = productList($url, $filter);
    break;
    case 'change-category':
      $list = $nv_Request->get_array('list', 'post');
      $category = $nv_Request->get_int('category', 'post');

      foreach ($list as $id) {
        $sql = 'update `'. PREFIX .'product` set category = '. $category .' where id = ' . $id;
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['notify'] = 'Đã lưu thông tin sản phẩm';
      $result['html'] = productList($url, $filter);
    break;
    case 'get-product':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'select b.*, a.pos, a.id, a.low, a.tag from `'. PREFIX .'product` a inner join `'. PREFIX .'catalog` b on a.itemid = b.id where a.itemid = '. $id;
      $query = $db->query($sql);
      $product = $query->fetch();
      $result = array(
        'status' => 1,
        'name' => $product['name'],
        'code' => $product['code'],
        'pos' => $product['pos'],
        'low' => $product['low'],
        'tag' => json_decode($product['tag'])
      );
    break;
    case 'edit-product':
      $data = $nv_Request->get_array('data', 'post');
      if (empty($data['tag'])) $data['tag'] = array();

      $sql = 'update `'. PREFIX .'product` set pos = "'. $data['pos'] .'", low = ' . $data['low'] . ', tag = \''. json_encode($data['tag'], JSON_UNESCAPED_UNICODE) .'\' where itemid = ' . $data['id'];
      $sql2 = 'update `'. PREFIX .'catalog` set name = "'. $data['name'] .'", code = "' . $data['code'] . '" where id = ' . $data['id'];
      if ($db->query($sql) && $db->query($sql2)) {
        checkTag($data['tag'], $tag_data);
        $result['status'] = 1;
        $result['html'] = productList($url, $filter);
      }
    break;
    case 'insert-item':
      // kiểm tra item có trong catalog chưa
      // nếu chưa, thêm vào catalog 
      // xong, thêm item vào product

      $code = $nv_Request->get_string('code', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');
      
      // kiểm tra trong catalog có mã hàng chưa
      $sql = 'select * from `'. PREFIX .'catalog` where code = "'. $code .'"';
      $query = $db->query($sql);
      if (empty($row = $query->fetch())) {
        // nếu chưa thêm vào catalog
        $sql = 'insert into `'. PREFIX .'catalog` (code, name, unit, categoryid, price) values ("'. $code .'", "'. $name .'", "", "", "")';
        $db->query($sql);
        $row = array('id' => $db->lastInsertId());
      }
      $sql = 'insert into `'. PREFIX .'product` (itemid, low, tag) values ('. $row['id'] .', 0, \''. json_encode(array()) .'\')';
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = productList($url, $filter);
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('nv', $module_name);
$xtpl->assign('op', $op);
$xtpl->assign('keyword', $filter['keyword']);
$xtpl->assign('tag', $filter['tag']);
$xtpl->assign('tags', json_encode($tag_search_data, JSON_UNESCAPED_UNICODE));
$xtpl->assign('check' . $filter['limit'], 'selected');

// $sql = 'select * from `'. PREFIX .'product`';
// $query = $db->query($sql);
// $list = array();

// while ($row = $query->fetch()) {
//   $list[$row['code']] = 1;
// }

// $sql = 'select * from `'. PREFIX .'product_category`';
// $query = $db->query($sql);

// while($row = $query->fetch()) {
//   $xtpl->assign('id', $row['id']);
//   $xtpl->assign('name', $row['name']);
//   $xtpl->assign('check', '');
//   if ($filter['category'] == $row['id']) $xtpl->assign('check', 'selected');
//   $xtpl->parse('main.category');
// }

$xtpl->assign('excelurl', '/index.php?nv=' . $module_name . '&op=excel');
$xtpl->assign('content', productList($url, $filter));

$xtpl->assign('modal', productModal());
$xtpl->assign('list', json_encode($list));
$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';