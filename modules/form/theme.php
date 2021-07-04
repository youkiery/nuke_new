<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('PREFIX')) {
  die('Stop!!!');
}

$sampleType = array(0 => 'Nguyên con', 'Huyết thanh', 'Máu', 'Phủ tạng', 'Swab');
$permissionType = array('Bị cấm', 'Kế toán', 'Chỉ đọc', 'Nhân viên', 'Siêu nhân viên', 'Quản lý');
//                       0      , 1        , 2        , 3          , 4             ,  5
function employerList($key = '') {
  global $db, $permissionType;

  $xtpl = new XTemplate("allowed.tpl", PATH);
  $list = getAllowUser($key);

  foreach ($list as $row) {
    $xtpl->assign('userid', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['first_name']);
    $xtpl->assign('permission', $permissionType[$row['type']]);
    $permist = explode(',', $row['former']);
    $risk = '';
    foreach ($permist as $value) {
      if (trim($value)) {
        $risk .= '<button class="btn btn-xs">' . ($value + 1) . '</button>';
      }
    }
    $xtpl->assign('risk', $risk);
    if ($row['admin']) {
      $xtpl->parse('main.row.admin');
    }
    else {
      $xtpl->parse('main.row.noadmin');
    }
    if ($row['type'] < 5) {
      $xtpl->parse('main.row.up');
    }
    if ($row['type'] > 0) {
      $xtpl->parse('main.row.down');
    }
    
    $xtpl->assign('salary', $row['salary']);
    if ($row['salary']) {
      $xtpl->assign('salary_color', 'btn-warning');
      $xtpl->assign('salary_text', 'Sửa lương');
    }
    else {
      $xtpl->assign('salary_color', 'btn-info');
      $xtpl->assign('salary_text', 'Xem lương');
    }
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function notAllowList($key) {
  global $db;
  $html = '';

  $list = getNotAllow($key);

  foreach ($list as $row) {
    $html .= '<div class="suggest_item" onclick="addEmploy('.$row['userid'].')">'.$row['first_name'].'</div>';
  }
  return $html;
}

function summaryContent($from, $end, $exam = '', $unit = '', $sample = '') {
  global $db, $sampleType;

  $xtpl = new XTemplate("summary.tpl", PATH);
  $sql = 'select * from `'. PREFIX .'_row` where (time between ' . $from . ' and ' . $end . ') and exam like "%'. $exam .'%" and sender like "%'. $unit .'%" and sample like "%'. $sample .'%"';
  // die($sql);
  $query = $db->query($sql);
  $data = array();

  while ($row = $query->fetch()) {
    $sample = mb_strtolower($row['sample']);
    if (empty($data[$sample])) {
      $data[$sample] = array();
    }
    
    if (empty($data[$sample][$row['typeindex']])) {
      $data[$sample][$row['typeindex']] = "0";
    }

    $data[$sample][$row['typeindex']] += $row['number'];
  }
  // echo json_encode($data);die();

  foreach ($data as $sample => $types) {
    $count = 0;
    $xtpl->assign('sample', $sample);
    foreach ($types as $type => $number) {
      $typeName = 'Khác';
      if (!empty($sampleType[$type])) {
        $typeName = $sampleType[$type];
      }
      if ($count) {
        $xtpl->assign('type_more', $typeName);
        $xtpl->assign('number_more', $number);
        $xtpl->parse('main.row.more');
      }
      else {
        $xtpl->assign('type', $typeName);
        $xtpl->assign('number', $number);
      }
      $count ++;
    }
    $xtpl->assign('row', $count);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function secretaryList($filter = array('page' => 1, 'keyword' => '', 'sample' => '', 'unit' => '', 'exam' => '', 'xcode' => '', 'pay' => '0', 'limit' => 10, 'owner' => '')) {
  global $db, $user_info;
  $xtpl = new XTemplate("secretary-list.tpl", PATH2);

  $today = time();
  if (empty($filter['end'])) {
    $filter['end'] = date('d/m/Y', $today);
  }

  if (empty($filter['from'])) {
    $filter['from'] = date('d/m/Y', $today - 60 * 60 * 24 * 30);
  }

  $filter['from'] = totime($filter['from']);
  $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;

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

  $sqlCount = 'select count(*) as count from `'. PREFIX .'_row` where mcode like "%'. $filter['keyword'] .'%" and sample like "%'. $filter['sample'] .'%" and sender like "%'. $filter['unit'] .'%" and exam like "%'. $filter['exam'] .'%" and xcode like "%'. $filter['xcode'] .'%" and owner like "%'. $filter['owner'] .'%" and printer = 5 and (time between '. $filter['from'] .' and '. $filter['end'] .') ' . $exsql;

  $query = $db->query($sqlCount);
  $count = $query->fetch();

  $sql = 'select * from `'. PREFIX .'_row` where mcode like "%'. $filter['keyword'] .'%" and sample like "%'. $filter['sample'] .'%" and sender like "%'. $filter['unit'] .'%" and exam like "%'. $filter['exam'] .'%" and xcode like "%'. $filter['xcode'] .'%" and owner like "%'. $filter['owner'] .'%" and printer = 5 and (time between '. $filter['from'] .' and '. $filter['end'] .') '. $exsql .' order by cast(noticetime as UNSIGNED  INTEGER) desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  $index = 1;
  $from = ($filter['page'] - 1) * $filter['limit'] + 1;
  $end = $from - 1;
  while ($row = $query->fetch()) {
      $sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $row['id'];
      // die($sql);
      $squery = $db->query($sql);
      $secretary = $squery->fetch();
      $xtpl->assign('state', 'Chưa trả');
      if (!empty($secretary) && !empty($secretary['pay'])) {
        $xtpl->assign('state', 'Đã trả');
      }
      
      $end ++;
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xcode = str_replace(', ', '/', $row['xcode']);
      $xcode = str_replace(',', '/', $xcode);
      $xtpl->assign('xcode', $xcode);
      $xtpl->assign('notice', $row['mcode']);
      $xtpl->assign('noticetime', date('d/m/Y', $row['noticetime']));
      $xtpl->assign('number', $row['number']);
      $xtpl->assign('printer', $row['printer']);
      for ($i = 1; $i <= $row['printer']; $i++) { 
        $xtpl->assign('printercount', $i);
        $xtpl->parse('main.row.printer');
      }
      $xtpl->assign('unit', $row['sender']);

      if (getUserType($user_info['userid']) > 1) {
        // if (checkIsMod($user_info['userid'])) {
        $xtpl->parse('main.row.mod');
      }
      if ($row['pay']) {
        $xtpl->parse('main.row.yes');
      }
      else {
        $xtpl->parse('main.row.no');
      }
      $xtpl->parse('main.row');
  }
  $xtpl->assign('from', $from);
  $xtpl->assign('end', $end);
  $xtpl->assign('total', $count['count']);
  $xtpl->assign('nav', navList($count['count'], $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function secretaryList2($filter = array('page' => 1, 'keyword' => '', 'sample' => '', 'unit' => '', 'exam' => '', 'xcode' => '', 'pay' => '0', 'limit' => 100, 'owner' => '')) {
  global $db, $user_info;
  $xtpl = new XTemplate("secretary2-list.tpl", PATH2);

  $today = time();
  if (empty($filter['end'])) {
    $filter['end'] = date('d/m/Y');
  }

  if (empty($filter['from'])) {
    $filter['from'] = date('d/m/Y');
  }

  $filter['from'] = totime($filter['from']);
  $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;
//   echo totime($filter['end']);
//   die();

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

  $sqlCount = 'select count(*) as count from `'. PREFIX .'_row` where mcode like "%'. $filter['keyword'] .'%" and sample like "%'. $filter['sample'] .'%" and sender like "%'. $filter['unit'] .'%" and exam like "%'. $filter['exam'] .'%" and xcode like "%'. $filter['xcode'] .'%" and owner like "%'. $filter['owner'] .'%" and printer = 5 and (time between '. $filter['from'] .' and '. $filter['end'] .') ' . $exsql;

  $query = $db->query($sqlCount);
  $count = $query->fetch();

  $sql = 'select * from `'. PREFIX .'_row` where mcode like "%'. $filter['keyword'] .'%" and sample like "%'. $filter['sample'] .'%" and sender like "%'. $filter['unit'] .'%" and exam like "%'. $filter['exam'] .'%" and xcode like "%'. $filter['xcode'] .'%" and owner like "%'. $filter['owner'] .'%" and printer = 5 and (time between '. $filter['from'] .' and '. $filter['end'] .') '. $exsql .' order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
//   die($sql);
  $query = $db->query($sql);

  $index = 1;
  $from = ($filter['page'] - 1) * $filter['limit'] + 1;
  $end = $from - 1;
  while ($row = $query->fetch()) {
      $sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $row['id'];
      $squery = $db->query($sql);
      $secretary = $squery->fetch();
      $xtpl->assign('state', 'Chưa trả');
      if (!empty($secretary) && !empty($secretary['pay'])) {
        $xtpl->assign('state', 'Đã trả');
      }
      
      $end ++;
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xcode = str_replace(', ', '/', $row['xcode']);
      $xcode = str_replace(',', '/', $xcode);
      $xtpl->assign('xcode', $xcode);
      $xtpl->assign('notice', $row['mcode']);
      $xtpl->assign('noticetime', date('d/m/Y', $row['noticetime']));
      $xtpl->assign('number', $row['number']);
      $xtpl->assign('printer', $row['printer']);
      for ($i = 1; $i <= $row['printer']; $i++) { 
        $xtpl->assign('printercount', $i);
        $xtpl->parse('main.row.printer');
      }
      $xtpl->assign('unit', $row['sender']);

      if (getUserType($user_info['userid']) > 1) {
        // if (checkIsMod($user_info['userid'])) {
        $xtpl->parse('main.row.mod');
      }
      if ($row['pay']) {
        $xtpl->parse('main.row.yes');
      }
      else {
        $xtpl->parse('main.row.no');
      }
      $xtpl->parse('main.row');
  }
  $xtpl->assign('from', $from);
  $xtpl->assign('end', $end);
  $xtpl->assign('total', $count['count']);
  $xtpl->assign('nav', navList($count['count'], $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function formList($keyword = '', $page = 1, $limit = 10, $printer = 1, $other = array('exam' => '', 'unit' => '', 'sample' => ''), $xcode = '', $owner = '') {
  global $db, $sampleType, $user_info;
  $xtpl = new XTemplate("list.tpl", PATH);
  $xcode = str_replace('/', ', ', $xcode);

  $today = time();
  $lastdate = strtotime(date('Y/m/d')) - 1;
  if (empty($other['end'])) {
    $other['end'] = date('d/m/Y', $today);
  }

  if (empty($other['from'])) {
    $other['from'] = date('d/m/Y', $today - 60 * 60 * 24 * 30);
  }

  $locker_time = getLocker();
  $auto_locker = getAutolocker();

  $other['from'] = totime($other['from']);
  $other['end'] = totime($other['end']) + 60 * 60 * 24 - 1;

  // $lowest = 5;
  // if (!empty($user_info['userid'])) {
  //   $risk = getUserPermission($user_info['userid']);
  //   $risk = explode(',', $risk);
  //   if (count($risk)) {
  //     $lowest = $risk[0];
  //   }
  // }
  // if ($lowest >= $printer) {
  //   $printer = $lowest;
  // }

  $sqlCount = 'select count(*) as count from `'. PREFIX .'_row` where code like "%'. $keyword .'%" and sample like "%'. $other['sample'] .'%" and sender like "%'. $other['unit'] .'%" and exam like "%'. $other['exam'] .'%" and xcode like "%'. $xcode .'%" and owner like "%'. $owner .'%" and printer >= '. $printer .' and (time between '. $other['from'] .' and '. $other['end'] .')';

  $query = $db->query($sqlCount);
  $count = $query->fetch();

  $xtpl->assign('total', $count['count']);

  $sql = 'select * from `'. PREFIX .'_row` where code like "%'. $keyword .'%" and sample like "%'. $other['sample'] .'%" and sender like "%'. $other['unit'] .'%" and exam like "%'. $other['exam'] .'%" and xcode like "%'. $xcode .'%" and owner like "%'. $owner .'%" and printer >= '. $printer .' and (time between '. $other['from'] .' and '. $other['end'] .') order by xcode desc limit ' . $limit . ' offset ' . ($page - 1) * $limit;
  // die($sql);
  $query = $db->query($sql);

  $index = 1;
  $from = ($page - 1) * $limit + 1;
  $end = $from - 1;
  while ($row = $query->fetch()) {
      $end ++;
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xcode = str_replace(', ', '/', $row['xcode']);
      $xcode = str_replace(',', '/', $xcode);
      $xtpl->assign('xcode', $xcode);
      $xtpl->assign('code', $row['code']);
      $xtpl->assign('number', $row['number']);
      $xtpl->assign('sample', $row['sample']);
      $xtpl->assign('printer', $row['printer']);
      for ($i = 1; $i <= $row['printer']; $i++) { 
        $xtpl->assign('printercount', $i);
        $xtpl->parse('main.row.printer');
      }
      $xtpl->assign('unit', $row['sender']);
      if (getUserType($user_info['userid']) > 2) {
        // if (checkIsMod($user_info['userid'])) {
        if ($row['printer'] >= 5) {
          $xtpl->parse('main.row.mod.clone');
        } 

        // auto, time < lastdate
        // locker, time < locker

        if ($auto_locker && $row['time'] < $lastdate) {
          // lock
        }
        else if ($row['time'] <= $locker_time) {
          // lock
        }
        else if ($row['locker']) {
          // lock
        }
        else {
          $xtpl->parse('main.row.mod.lockg');
        }
        $xtpl->parse('main.row.mod');
      }
      // if (checkIsMod($user_info['userid'])) {
      //   $xtpl->parse('main.row.mod');
      // }
      $xtpl->parse('main.row');
  }
  // die();
  $xtpl->assign('from', $from);
  $xtpl->assign('end', $end);
  $xtpl->assign('total', $count['count']);
  $xtpl->assign('nav', navList($count['count'], $page, $limit));
  $xtpl->parse('main');
  return $xtpl->text();
}

function navigator($number, $page, $limit, $func) {
  $html = '';
  $total = floor($number / $limit) + ($number % $limit ? 1 : 0);
  for ($i = 1; $i <= $total; $i++) {
    // echo "$page, $i <br>";
    if ($page == $i) {
      $html .= '<li class="active"><a href="#">' . $i . '</a></li>';
    } 
    else {
      $html .= '<li><a href="#" onclick="goPage('. $i .', \''. $func .'\')">' . $i . '</a></li>';
    }
  }
  return '
    <ul class="pagination">
      '. $html .'
    </ul>';
}

function navList ($number, $page, $limit) {
  global $lang_global;
  $total_pages = ceil($number / $limit);

  $on_page = $page;
  $page_string = "";
  if ($total_pages > 10) {
    $init_page_max = ($total_pages > 3) ? 3 : $total_pages;
    for ($i = 1; $i <= $init_page_max; $i ++) {
      $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
      if ($i < $init_page_max) $page_string .= " ";
    }
    if ($total_pages > 3) {
      if ($on_page > 1 && $on_page < $total_pages) {
        $page_string .= ($on_page > 5) ? " ... " : ", ";
        $init_page_min = ($on_page > 4) ? $on_page : 5;
        $init_page_max = ($on_page < $total_pages - 4) ? $on_page : $total_pages - 4;
        for ($i = $init_page_min - 1; $i < $init_page_max + 2; $i ++) {
          $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
          if ($i < $init_page_max + 1)  $page_string .= " ";
        }
        $page_string .= ($on_page < $total_pages - 4) ? " ... " : ", ";
      }
      else {
        $page_string .= " ... ";
      }
      
      for ($i = $total_pages - 2; $i < $total_pages + 1; $i ++) {
        $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
        if ($i < $total_pages) $page_string .= " ";
      }
    }
  }
  else {
    if ($total_pages) {
      for ($i = 1; $i < $total_pages + 1; $i ++) {
        $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
        if ($i < $total_pages) $page_string .= " ";
      }
    }
    else {
      $page_string .= '<div class="btn">' . 1 . "</div>";
    }
  }
  return $page_string;
}
