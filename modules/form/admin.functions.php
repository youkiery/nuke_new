<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
  die('Stop!!!');
}

define('NV_IS_ADMIN_FORM', true);
define("PATH", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
define("PATH2", NV_ROOTDIR . "/modules/" . $module_file . '/template/admin/' . $op);

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
require NV_ROOTDIR . '/modules/' . $module_file . '/theme.php';

function lockerList($filter = array('page' => 1, 'limit' => 10, 'keyword' => '', 'xcode' => '', 'unit' => '', 'owner' => '', 'exam' => '', 'sample' => '', 'from' => '', 'end' => '')) {
  global $db;

  $tick = 0;
  $time_sql = '';
  if (!empty($filter['from'])) $tick += 1;
  if (!empty($filter['end'])) $tick += 2;
  $filter['from'] = totime($filter['from']);
  $filter['end'] = totime($filter['end']);

  switch ($tick) {
    case 1:
      // có from
      $time_sql = 'and receive > ' . $filter['from'];
    break;
    case 2:
      // có end
      $time_sql = 'and receive < ' . $filter['end'];
      break;
    case 3:
      // có cả 2
      if ($filter['from'] > $filter['end']) {
        // đầu > cuối => đảo vị
        $temp = $filter['from'];
        $filter['from'] = $filter['end'];
        $filter['from'] = $temp;
        $time_sql = 'and (receive between '. $filter['from'] .' and '. $filter['end'] .')';
      }
      else if ($filter['from'] == $filter['end']) {
        // Chỉ ngày đang chọn
        $time = strtotime(date('Y/m/d', $filter['from'])); 
        $time_sql = 'and (receive between '. $time .' and '. ($time + 60 * 60 * 24 - 1) .')';
      }
      else $time_sql = 'and (receive between '. $filter['from'] .' and '. $filter['end'] .')';
      break;
    default:
      // 0
  }
  // function lockerList($filter = array('page' => 1, 'limit' => 10, 'keyword' => '', 'xcode' => '', 'printer' => '', 'unit' => '', 'owner' => '', 'exam' => '', 'sample' => '', 'from' => '', 'end' => '')) {

  $xtpl = new XTemplate('locker-list.tpl', PATH2);
  // not yet
  $filter['xcode'] = explode(',', $filter['xcode']);
  $sql = "select count(*) as count from `". PREFIX ."_row` where code like '%$filter[keyword]%' and (xcode like '%". $filter['xcode'][0] ."%' or xcode like '%". $filter['xcode'][1] ."%' or xcode like '%". $filter['xcode'][2] ."%') and sender like '%$filter[unit]%' and owner like '%$filter[owner]%' and exam like '%$filter[exam]%' and sample like '%$filter[sample]%' $time_sql";
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = "select * from `". PREFIX ."_row` where code like '%$filter[keyword]%' and (xcode like '%". $filter['xcode'][0] ."%' or xcode like '%". $filter['xcode'][1] ."%' or xcode like '%". $filter['xcode'][2] ."%') and sender like '%$filter[unit]%' and owner like '%$filter[owner]%' and exam like '%$filter[exam]%' and sample like '%$filter[sample]%' $time_sql order by id desc limit $filter[limit] offset " . ($filter['page'] - 1) * $filter['limit'];
  // die($sql);
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('code', $row['code']);
    $xtpl->assign('mcode', $row['mcode']);
    $xtpl->assign('xcode', str_replace(',', '/', $row['xcode']));
    $xtpl->assign('sender', $row['sender']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('sample', $row['sample']);
    if ($row['locker']) $xtpl->parse('main.row.yes');
    else $xtpl->parse('main.row.no');
    $xtpl->parse('main.row');
  }
  
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function getNotAllow($key = '') {
  global $db, $db_config;

  $sql = 'select * from `'. $db_config['prefix'] .'_users` where first_name like "%'.$key.'%" and userid not in (select userid from `'. $db_config['prefix'] .'_user_allow` where module = '. PERMISSION_MODULE . ') limit 10';
  $query = $db->query($sql);

  $list = array();
  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function getAllowUser($key = '') {
  global $db, $db_config;

  $sql = 'select a.*, b.type, b.former, b.admin, b.salary from `'. $db_config['prefix'] .'_users` a inner join `'. $db_config['prefix'] .'_user_allow` b on a.userid = b.userid where a.first_name like "%'. $key .'%" and module = ' . PERMISSION_MODULE . ' order by type desc';
  $query = $db->query($sql);

  $list = array();
  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function checkEmptyPemission($userid) {
  global $db, $db_config;

  $sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $userid . ' and module = ' . PERMISSION_MODULE;
  $query = $db->query($sql);

  if (!empty($query->fetch())) {
    return false;
  }
  return true;
}

function checkUserPermission($userid) {
  global $db, $db_config;

  $sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $userid . ' and module = ' . PERMISSION_MODULE;
  $query = $db->query($sql);

  if (!empty($row = $query->fetch())) {
    return $row['id'];
  }
  return 0;
}
