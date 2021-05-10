<?php

/**
 * @Project Thanhxuanpet 0.1
 * @Author Võ Anh Dư <vodaityr@gmail.com>
 * @Copyright (C) 2021 Thanhxuanpet
 * @License Nope
 * @Createdate 22/01/2021 14:15
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_TX', true);
define('NV_IS_MOD_USER', true);
define('PATH', NV_ROOTDIR . '/modules/daklak-exchange/funcs/template/');

function productContent() {
  global $db, $filter;
  $list = array('code', 'name', 'unit', 'number', 'sell_price', 'buy_price');
  $filter['type'] = mb_strtolower($filter['type']);
  $xtra = '';
  if ($filter['type'] != 'asc') $filter['type'] = 'desc';
  if (in_array($filter['order'], $list)) $xtra []= "order by $filter[order] $filter[type]"; 

  $sql = "select count(*) as count from pet_daklak_product where name like '%$filter[keyword]%'";
  $query = $db->query($sql);
  $data = $query->fetch();
  $number = $data['count'];

  $sql = "select * from pet_daklak_product where name like '%$filter[keyword]%' $xtra limit $filter[limit] offset ". ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $list = array();

  $xtpl = new XTemplate('list.tpl', PATH);

  while ($product = $query->fetch()) {
    $xtpl->assign('unit', '');
    if (!empty($product['unit'])) $xtpl->assign('unit', '('. $product['unit'] . ')');
    $xtpl->assign('id', $product['id']);
    $xtpl->assign('code', $product['code']);
    $xtpl->assign('name', $product['name']);
    $xtpl->assign('buy_price', $product['buy_price']);
    $xtpl->assign('sell_price', $product['sell_price']);
    $xtpl->assign('number', $product['number']);
    $xtpl->parse('main.row');
  }
  $link = "/daklak-exchange/?keyword=$filter[keyword]&order=$filter[order]&type=$filter[type]";
  $xtpl->assign('nav', navBar($link, $numnber, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function importContent() {
  global $db, $filter;

  $xtra = array();
  if (!empty($filter['keyword'])) $xtra []= 'c.name like "%'. $filter['keyword'] .'%" or code like "%'. $filter['keyword'] .'%"';
  $tick = 0;
  if (!empty($filter['from'])) $tick += 1;
  if (!empty($filter['end'])) $tick += 2;
  switch ($tick) {
    case 1:
      $filter['from'] = totime($filter['from']);
      $xtra []= 'a.time > '. $filter['from'];
      break;
    case 2:
      $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;
      $xtra []= 'a.time < '. $filter['end'];
      break;
    case 3:
      $filter['from'] = totime($filter['from']);
      $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;
      $xtra []= '(a.time between '. $filter['from'] .' and '. $filter['end'] .')';
      break;
  }
  $xtra = (count($xtra) ? ' where '. implode(' and ', $xtra) : '');

  $sql = "select count(*) as count from pet_daklak_import a inner join pet_daklak_import_row b on a.id = b.importid inner join pet_daklak_product c on b.itemid = c.id $xtra group by a.id";
  $query = $db->query($sql);
  $data = $query->fetch();
  $number = $data['count'];

  $sql = "select a.* from pet_daklak_import a inner join pet_daklak_import_row b on a.id = b.importid inner join pet_daklak_product c on b.itemid = c.id $xtra group by a.id order by id desc limit $filter[limit] offset ". ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $list = array();

  $xtpl = new XTemplate('import-list.tpl', PATH);

  while ($import = $query->fetch()) {
    $source = getSource($import['sourceid']);
    $user = getUser($import['userid']);
    $xtpl->assign('id', $import['id']);
    $xtpl->assign('time', date('d/m/Y', $import['time']));
    $xtpl->assign('source', $source['name']);
    $xtpl->assign('total', $import['total']);
    $xtpl->assign('user', $user['name']);
    $xtpl->parse('main.row');
  }
  $link = "/daklak-exchange/?op=import&";
  $xtpl->assign('nav', navBar($link, $number, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportContent() {
  global $db, $filter;

  $xtra = array();
  if (!empty($filter['keyword'])) $xtra []= 'c.name like "%'. $filter['keyword'] .'%" or code like "%'. $filter['keyword'] .'%"';
  $tick = 0;
  if (!empty($filter['from'])) $tick += 1;
  if (!empty($filter['end'])) $tick += 2;
  switch ($tick) {
    case 1:
      $filter['from'] = totime($filter['from']);
      $xtra []= 'a.time > '. $filter['from'];
      break;
    case 2:
      $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;
      $xtra []= 'a.time < '. $filter['end'];
      break;
    case 3:
      $filter['from'] = totime($filter['from']);
      $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;
      $xtra []= '(a.time between '. $filter['from'] .' and '. $filter['end'] .')';
      break;
  }
  $xtra = (count($xtra) ? ' where '. implode(' and ', $xtra) : '');

  $sql = "select count(*) as count from pet_daklak_export a inner join pet_daklak_export_row b on a.id = b.exportid inner join pet_daklak_product c on b.itemid = c.id $xtra group by a.id";
  $query = $db->query($sql);
  $data = $query->fetch();
  $number = $data['count'];

  $sql = "select a.* from pet_daklak_export a inner join pet_daklak_export_row b on a.id = b.exportid inner join pet_daklak_product c on b.itemid = c.id $xtra group by a.id order by id desc limit $filter[limit] offset ". ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $list = array();

  $xtpl = new XTemplate('export-list.tpl', PATH);

  while ($export = $query->fetch()) {
    $source = getSource($export['sourceid']);
    $user = getUser($export['userid']);
    $xtpl->assign('id', $export['id']);
    $xtpl->assign('time', date('d/m/Y', $export['time']));
    $xtpl->assign('source', $source['name']);
    $xtpl->assign('total', $export['total']);
    $xtpl->assign('user', $user['name']);
    $xtpl->parse('main.row');
  }
  $link = "/daklak-exchange/?op=export&";
  $xtpl->assign('nav', navBar($link, $number, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function getSource($id) {
  global $db;

  $sql = 'select * from pet_daklak_source where id = '. $id;
  $query = $db->query($sql);
  return $query->fetch();
}

function getUser($id) {
  global $db;

  $sql = 'select userid, concat(last_name, "", first_name) as name, username from pet_users where userid = '. $id;
  $query = $db->query($sql);
  return $query->fetch();
}

function navBar($url, $number, $page, $limit) {
  $html = '';
  $total = floor($number / $limit) + ($number % $limit ? 1 : 0);
  for ($i = 1; $i <= $total; $i++) {
    if ($page == $i) {
      $html .= '<li class="active"><a>' . $i . '</a></li>';
    } 
    else {
      $html .= '<li><a href="'. $url .'&page='. $i .'&limit='. $limit .'">' . $i . '</a></li>';
    }
  }
  return "<ul class='pagination'>$html</ul>";
}

function totime($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    if (!$time) {
      $time = time();
    }
  }
  else {
    $time = time();
  }
  return $time;
}

function alias($str) {
  $str = mb_strtolower($str);
  $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", "a", $str);
  $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", "e", $str);
  $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", "i", $str);
  $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", "o", $str);
  $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", "u", $str);
  $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", "y", $str);
  $str = preg_replace("/(đ)/", "d", $str);
  return $str;
}
