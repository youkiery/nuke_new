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

function navBar($url, $number, $page, $limit) {
  $html = '';
  $total = floor($number / $limit) + ($number % $limit ? 1 : 0);
  for ($i = 1; $i <= $total; $i++) {
    if ($page == $i) {
      $html .= '<li><a class="active">' . $i . '</a></li>';
    } 
    else {
      $html .= '<a href="'. $url .'&page='. $i .'&limit='. $limit .'">' . $i . '</a>';
    }
  }
  return "<ul class='pagination'>$html</ul>";
}


