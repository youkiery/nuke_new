<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$sql = 'select * from pet_general_catalog';
$query = $db->query($sql);

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
//   $sql = 'insert into `pet_daklak_item_floor_category` (name) values("'. $a .'")';
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
        $sql = 'select * from `pet_daklak_item` where code = "'. $item['code'] .'"';
        $query = $db->query($sql);
        $row = $query->fetch();
        if (empty($row)) {
          // insert catalog
          $sql = 'insert into `pet_daklak_item` (code, name, unit, categoryid, price) values("'. $item['code'] .'", "'. $item['name'] .'", "", 0, 0)';
          $db->query($sql);
          $row['id'] = $db->lastInsertId();
        }
        $sql = 'select * from `pet_daklak_item_floor` where itemid = ' . $row['id'];
        $query = $db->query($sql);
        $product = $query->fetch();
        if (empty($product)) {
          if ($check) {
            $sql = 'insert into `pet_daklak_item_floor` (itemid, tag, pos, low, n1, n2) values('. $row['id'] .', \''. json_encode(array()) .'\', "'. $item['pos'] .'", "'. $item['low'] .'", '. $item['n1'] .', '. $item['n2'] .')';
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

          $sql = 'update `pet_daklak_item_floor` set '. (strlen($xtra) ? $xtra : '') .' n1 = '. $item['n1'] .', n2 = '. $item['n2'] .' where id = ' . $product['id'];
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

      $sql = 'insert into `pet_daklak_item_floor` (itemid, low, tag) values ('. $id .', '. $low .', \''. json_encode(array()) .'\')';
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
    case 'parent-suggest':
      $keyword = mb_strtolower($nv_Request->get_string('keyword', 'post', ''));

      $result['status'] = 1;
      $result['html'] = parentSuggest($keyword);
    break;
    case 'remove':
      $list = $nv_Request->get_array('list', 'post');
      
      foreach ($list as $id) {
        $sql = 'delete from `pet_daklak_item_floor` where id = ' . $id;
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
        $sql = 'update `pet_daklak_item_floor` set category = '. $category .' where id = ' . $id;
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['notify'] = 'Đã lưu thông tin sản phẩm';
      $result['html'] = productList($url, $filter);
    break;
    case 'get-item':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'select a.id, a.itemid, a.position, a.transfer, a.purchase, b.code, b.name, b.image, b.price, b.storaup, b.storadown, b.parentid, b.value from `pet_daklak_item_floor` a inner join `pet_daklak_item` b on a.itemid = b.id where a.id = '. $id;
      $query = $db->query($sql);
      $product = $query->fetch();
      $result = array(
        'code' => $product['code'],
        'name' => $product['name'],
        'price' => $product['price'],
        'parent' => $product['parent'],
        'value' => $product['value'],
        'down' => $product['down'],
        'up' => $product['up'],
        'position' => $product['position'],
        'image' => $product['image'],
        'status' => 1
      );
    break;
    // case 'edit-product':
    //   $id = $nv_Request->get_int('id', 'post', 0);
    //   $low = $nv_Request->get_int('low', 'post', 0);
    //   $tags = $nv_Request->get_array('tag', 'post');

    //   $sql = 'update `pet_daklak_item_floor` set low = ' . $low . ', tag = \''. json_encode($tags, JSON_UNESCAPED_UNICODE) .'\' where id = ' . $id;
    //   if ($db->query($sql)) {
    //     checkTag($tags, $tag_data);
    //     $result['status'] = 1;
    //   }
    // break;
    case 'insert-item':
      $data = array(
        'code' => $nv_Request->get_string('code', 'post', ''),
        'name' => $nv_Request->get_string('name', 'post', ''),
        'price' => $nv_Request->get_string('price', 'post', ''),
        'parent' => $nv_Request->get_string('parent', 'post', ''),
        'value' => $nv_Request->get_string('value', 'post', ''),
        'down' => $nv_Request->get_string('down', 'post', ''),
        'up' => $nv_Request->get_string('up', 'post', ''),
        'position' => $nv_Request->get_string('position', 'post', ''),
      );
      $name = '';
      $image_path = '';
      if (!empty($_FILES) && !empty($_FILES['image'])) {
        $maxDim = 300;
        $file = $_FILES['image'];
        $file_name = $file['tmp_name'];
        list($width, $height, $type, $attr) = getimagesize( $file_name );
        if ( $width > $maxDim || $height > $maxDim ) {
            $target_filename = $file_name;
            $ratio = $width/$height;
            if( $ratio > 1) {
                $new_width = $maxDim;
                $new_height = $maxDim/$ratio;
            } else {
                $new_width = $maxDim*$ratio;
                $new_height = $maxDim;
            }
            $src = imagecreatefromstring( file_get_contents( $file_name ) );
            $dst = imagecreatetruecolor( $new_width, $new_height );
            imagecopyresampled( $dst, $src, 0, 0, 0, 0, $new_width, $new_height, $width, $height );
            imagedestroy( $src );
            imagejpeg($dst, $target_filename); // adjust format as needed
            imagedestroy( $dst );
        }
        $image_path = "/uploads/daklak/". time() .'.jpg';
        
        move_uploaded_file($file['tmp_name'], $image_path);
      }

      $sql = 'select * from pet_daklak_item where name = "'. $data['name'] .'"';
      $query = $db->query($sql);
      $item = $query->fetch();

      if (empty($item)) {
        $sql = "insert into pet_daklak_item (code, name, image, price, storaup, storadown, parentid, value) values ('$data[code]', '$data[name]', '$image_path', $data[price], 0, 0, $data[parent], $data[value])";
        $db->query($sql);
        $itemid = $db->lastInsertId();

        $sql = "insert into pet_daklak_item_floor (itemid, position, transfer, purchase) values ($itemid, '$data[position]', $data[up], $data[down])";
        $db->query($sql);
        $result['status'] = 1;
        $result['html'] = productList($url, $filter);
      }
      break;
    case 'update-item':
      $data = array(
        'id' => $nv_Request->get_string('id', 'post', ''),
        'code' => $nv_Request->get_string('code', 'post', ''),
        'name' => $nv_Request->get_string('name', 'post', ''),
        'price' => $nv_Request->get_string('price', 'post', ''),
        'parent' => $nv_Request->get_string('parent', 'post', ''),
        'value' => $nv_Request->get_string('value', 'post', ''),
        'down' => $nv_Request->get_string('down', 'post', ''),
        'up' => $nv_Request->get_string('up', 'post', ''),
        'position' => $nv_Request->get_string('position', 'post', ''),
      );
      if (!empty($_FILES) && !empty($_FILES['image'])) {
        $maxDim = 300;
        $file = $_FILES['image'];
        $file_name = $file['tmp_name'];
        list($width, $height, $type, $attr) = getimagesize( $file_name );
        if ( $width > $maxDim || $height > $maxDim ) {
            $target_filename = $file_name;
            $ratio = $width/$height;
            if( $ratio > 1) {
                $new_width = $maxDim;
                $new_height = $maxDim/$ratio;
            } else {
                $new_width = $maxDim*$ratio;
                $new_height = $maxDim;
            }
            $src = imagecreatefromstring( file_get_contents( $file_name ) );
            $dst = imagecreatetruecolor( $new_width, $new_height );
            imagecopyresampled( $dst, $src, 0, 0, 0, 0, $new_width, $new_height, $width, $height );
            imagedestroy( $src );
            imagejpeg($dst, $target_filename); // adjust format as needed
            imagedestroy( $dst );
        }
        $image_path = "/uploads/daklak/". time() .'.jpg';
        
        move_uploaded_file($file['tmp_name'], $image_path);
      }
      else $image_path = $nv_Request->get_string('image', 'post', '');

      $sql = 'select * from pet_daklak_item where name = "'. $data['name'] .'" and id <> '. $data['id'];
      $query = $db->query($sql);
      $item = $query->fetch();

      if (empty($item)) {
        $sql = "update pet_daklak_item set code = '$data[code]', name = '$data[name]', image = '$image_path', price = $data[price], parentid = $data[parentid], value = $data[value] where id = ". $data['id'];
        $db->query($sql);
        $itemid = $db->lastInsertId();

        $sql = "update pet_daklak_item_floor set position = '$data[position]', transfer = $data[up], purchase = $data[down] where id = $data[id]";
        $db->query($sql);
        $result['status'] = 1;
        $result['html'] = productList($url, $filter);
      }
      break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('keyword', $filter['keyword']);
$xtpl->assign('tag', $filter['tag']);
$xtpl->assign('tags', json_encode($tag_search_data, JSON_UNESCAPED_UNICODE));
$xtpl->assign('check' . $filter['limit'], 'selected');
$xtpl->assign('item', json_encode(array()));

// $sql = 'select * from `pet_daklak_item_floor`';
// $query = $db->query($sql);
// $list = array();

// while ($row = $query->fetch()) {
//   $list[$row['code']] = 1;
// }

// $sql = 'select * from `pet_daklak_item_floor_category`';
// $query = $db->query($sql);

// while($row = $query->fetch()) {
//   $xtpl->assign('id', $row['id']);
//   $xtpl->assign('name', $row['name']);
//   $xtpl->assign('check', '');
//   if ($filter['category'] == $row['id']) $xtpl->assign('check', 'selected');
//   $xtpl->parse('main.category');
// }

// $sql = 'select';

$xtpl->assign('content', productList($url, $filter));

$xtpl->assign('modal', productModal());
$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';