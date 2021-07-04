<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 10/03/2010 10:51
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_MOD_QUANLY', true);
define('PATH', NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
define('PATH2', NV_ROOTDIR . "/modules/" . $module_file . '/template/user/' . $op);
define('OVERCLOCK', 1);
define('NO_OVERCLOCK', 0);
require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
$check_image = '<img src="/assets/images/ok.png">';
// kiểm tra phân quyền

function usgModal($lang_module)
{
  global $filter_data;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $doctor = getdoctorlist();
  $xtpl->assign('keyword', $filter_data['keyword']);
  $xtpl->assign('filter' . $filter_data['filter'], 'selected');
  $xtpl->assign('overflow_content', overflowList());
  // $xtpl->assign('from', $filter_data['from']);
  // $xtpl->assign('end', $filter_data['end']);
  $xtpl->assign('lang', $lang_module);
  $xtpl->assign('now', date('d/m/Y', time()));
  $xtpl->assign('expecttime', date('d/m/Y', time() + 60 * 60 * 24 * 25));
  $xtpl->assign('new_content', newUsgContent());

  $diseases = getDiseaseList();
  foreach ($diseases as $value) {
    $xtpl->assign("id", $value["id"]);
    $xtpl->assign("name", $value["name"]);
    $xtpl->parse("main.disease");
    $xtpl->parse("main.disease2");
  }

  foreach ($doctor as $data) {
    $xtpl->assign('doctor_value', $data['userid']);
    $xtpl->assign('doctor_name', $data['fullname']);
    $xtpl->parse('main.doctor');
    $xtpl->parse('main.doctor2');
    $xtpl->parse('main.doctor3');
    $xtpl->parse('main.doctor4');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function newUsgContent() {
  global $db;
  $xtpl = new XTemplate("new-content.tpl", PATH2);
  $start = strtotime(date('Y/m/d'));
  $end = time();

  $sql = 'select a.id, a.expecttime, a.expectnumber, c.name, c.phone from '. VAC_PREFIX .'_usg2 a inner join '. VAC_PREFIX. '_pet b on a.petid = b.id inner join '. VAC_PREFIX. '_customer c on b.customerid = c.id where time between '. $start .' and '. $end .' order by id desc';
  $query = $db->query($sql);

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('customer', $row['name']);
    $xtpl->assign('phone', $row['phone']);
    $xtpl->assign('birthtime', date('d/m/Y', $row['expecttime']));
    $xtpl->assign('number', $row['expectnumber']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function overflowList($data = array())
{
  global $db;
  $xtpl = new XTemplate("overflow-list.tpl", PATH2);

  $tick = 0;
  if (empty($data['from'])) $tick += 1;
  if (empty($data['end'])) $tick += 2;
  if (empty($data['keyword'])) $data['keyword'] = '';

  $msg = '';
  switch ($tick) {
    case 1:
      $end = totime($data['end']) + 60 * 60 * 24 - 1;
      $time = 'and calltime < ' . $end;
      $msg = 'Danh sách trước ngày ' . date('d/m/Y', totime($data['end']));
      break;
    case 2:
      $from = totime($data['from']);
      $time = 'and calltime > ' . totime($data['from']);
      $msg = 'Danh sách sau ngày ' . date('d/m/Y', $from);
      break;
    case 3:
      $now = strtotime(date('Y/m/d'));
      $from = $now - 60 * 60 * 24 * 30;
      $end = $now + 60 * 60 * 24 - 1;
      $time = 'and (calltime between ' . $from . ' and ' . $end . ')';
      $msg = 'Danh sách từ ngày ' . date('d/m/Y', $from) . ' đến ngày ' . date('d/m/Y', totime($end));
      break;
    case 0:
      $end = totime($data['end']) + 60 * 60 * 24 - 1;
      $time = 'and (calltime between ' . totime($data['from']) . ' and ' . $end . ')';
      $msg = 'Danh sách từ ngày ' . date('d/m/Y', totime($data['from'])) . ' đến ngày ' . date('d/m/Y', totime($end));
      break;
  }
  $xtpl->assign('msg', $msg);

  $sql = 'select a.*, b.name as petname, c.name, c.phone from `' . VAC_PREFIX . '_usg` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id where a.status < 2 and (b.name like "%' . $data['keyword'] . '%" or c.name like "%' . $data['keyword'] . '%" or c.phone like "%' . $data['keyword'] . '%") ' . $time . ' order by calltime desc';
  // die($sql);
  $query = $db->query($sql);

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('petname', $row['petname']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('phone', $row['phone']);
    $xtpl->assign('recall', date('d/m/Y', $row['calltime']));
    $xtpl->parse('main.m1.row');
  }
  if ($index == 1) $xtpl->parse('main.m2');
  else $xtpl->parse('main.m1');
  $xtpl->parse('main');
  return $xtpl->text();
}

function usgManageList()
{
  global $db, $filter, $lang_module, $order, $sort, $page, $status, $link, $filter_data, $vacconfigv2;
  $xtpl = new XTemplate("manage-list.tpl", PATH2);
  $xtpl->assign("lang", $lang_module);

  $where = "where c.name like '%$filter_data[keyword]%' or phone like '%$filter[keyword]%' or b.name like '%$filter[keyword]%'";

  $sql = "select a.id, a.cometime, a.calltime, a.birth, a.expectbirth, a.vaccine, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone, d.name as doctor from " .  VAC_PREFIX . "_usg a inner join " .  VAC_PREFIX . "_pet b on a.petid = b.id inner join " .  VAC_PREFIX . "_customer c on b.customerid = c.id inner join " .  VAC_PREFIX . "_doctor d on a.doctorid = d.id $where $order[$sort] limit $filter offset " . ($page - 1) * $filter;
  $query = $db->query($sql);

  // echo $path; die();
  $stt = ($page - 1) * $filter + 1;
  while ($row = $query->fetch()) {
    // var_dump($row); die();
    $xtpl->assign("stt", $stt);
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("customer", $row["customer"]);
    $xtpl->assign("petname", $row["petname"]);
    $xtpl->assign("pet_link", $link . "patient&petid=" . $row["petid"]);
    $xtpl->assign("customer_link", $link . "customer&customerid=" . $row["customerid"]);
    $xtpl->assign("phone", $row["phone"]);
    $xtpl->assign("doctor", $row["doctor"]);
    $xtpl->assign("birth", $row["birth"]);
    $xtpl->assign("exbirth", $row["expectbirth"]);
    $xtpl->assign("cometime", date("d/m/Y", $row["cometime"]));
    $xtpl->assign("calltime", date("d/m/Y", $row["calltime"]));
    $recall = $row["recall"];
    if ($recall > 0 && $row["vaccine"] > 2) {
      $xtpl->assign("recall", date("d/m/Y", $recall));
      $xtpl->assign("vacname", "");
    } else {
      $xtpl->assign("recall", $lang_module["norecall"]);
      $xtpl->assign("vacname", " / " . $lang_module["confirm_value"][$row["vaccine"]]);
    }
    // $xtpl->assign("delete_link", "");

    $xtpl->parse("main.row");
    $stt++;
  }

  $sql = "select count(*) as number from " .  VAC_PREFIX . "_usg a inner join " .  VAC_PREFIX . "_pet b on a.petid = b.id inner join " .  VAC_PREFIX . "_customer c on b.customerid = c.id inner join " .  VAC_PREFIX . "_doctor d on a.doctorid = d.id $where $order[$sort]";
  $query = $db->query($sql);
  $num = $query->fetch()['number'];
  $nav = nv_generate_page_shop($link, $num, $filter, $page);
  $xtpl->assign("nav_link", nv_generate_page_shop($link, $num, $filter, $page));

  $xtpl->parse("main");
  return $xtpl->text("main");
}


function usgCurrentList($filter)
{
  switch ($filter['type']) {
    case 2:
      // danh sách đã sinh
      return usgBirthList($filter);
      break;
    case 3:
      // danh sách tiêm phòng
      return usgVaccineList($filter);
      break;
    case 4:
      // danh sách quản lý
      // closed
      break;
    default:
      // mạc định danh sách gần sinh
      return usgRecallList($filter);
  }
}

function usgRecallList()
{
  global $db, $module_name, $op, $vacconfigv2, $lang_module, $filter;

  $status_list = array('Chưa gọi', 'Đã gọi');
  $xtpl = new XTemplate("recall-list.tpl", PATH2);
  $xtpl->assign('lang', $lang_module);
  $index = 1;
  $time = time() + $vacconfigv2['filter'];
  $overtime = time();

  $sql = 'select a.id, a.usgtime, a.expecttime, a.expectnumber, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `' . VAC_PREFIX . '_usg2` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id where expecttime < ' . $time . ' and a.status = ' . $filter['status'] . ' order by expecttime asc';
  $query = $db->query($sql);

  $status = $filter['status'];
  $recall = array(0 => 'left', 'right');
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('customer', $row['customer']);
    $xtpl->assign('phone', $row['phone']);
    $xtpl->assign('expectnumber', $row['expectnumber']);
    $xtpl->assign('expecttime', date('d/m/Y', $row['expecttime']));
    if ($row['expecttime'] < $overtime) $xtpl->assign('bgcolor', 'orange');
    else $xtpl->assign('bgcolor', '');
    $xtpl->parse('main.row.' . $recall[$status]);
    $xtpl->parse('main.row');
  }
  for ($i = 0; $i < 2; $i++) {
    $filter['status'] = $i;
    if ($status == $i) $xtpl->assign('recall_select', 'btn-info');
    else $xtpl->assign('recall_select', 'btn-default');
    $xtpl->assign('recall_link', '/' . $module_name . '/' . $op . '/?' . http_build_query($filter));
    $xtpl->assign('recall_name', $status_list[$i]);
    $xtpl->parse('main.button');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function usgBirthList($filter)
{
  global $db, $module_name, $op, $vacconfigv2;

  $xtpl = new XTemplate("birth-list.tpl", PATH2);
  $index = 1;
  $time = time() + $vacconfigv2['filter'];
  $overtime = time();

  $sql = 'select a.id, a.usgtime, a.birthtime, a.number, b.id as petid, b.name as petname, c.name as customer, c.phone from `' . VAC_PREFIX . '_usg2` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id where birthtime < ' . $time . ' and a.status = 2 order by birthtime asc';
  $query = $db->query($sql);

  $recall = array(0 => 'left', 'right');
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('customer', $row['customer']);
    $xtpl->assign('phone', $row['phone']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('birthtime', date('d/m/Y', $row['birthtime']));
    if ($row['birthtime'] < $overtime) $xtpl->assign('bgcolor', 'orange');
    else $xtpl->assign('bgcolor', '');
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function usgVaccineList()
{
  global $db, $module_name, $op, $vacconfigv2, $filter;

  $xtpl = new XTemplate("vaccine-list.tpl", PATH2);
  $index = 1;
  $time = time() + $vacconfigv2['filter'];

  $sql = 'select a.id, a.usgtime, a.vaccinetime, a.number, b.id as petid, b.name as petname, c.name as customer, c.phone from `' . VAC_PREFIX . '_usg2` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id where vaccinetime < ' . $time . ' and a.status = 3 order by vaccinetime asc';
  $query = $db->query($sql);

  $recall = array(0 => 'left', 'right');
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('customer', $row['customer']);
    $xtpl->assign('phone', $row['phone']);
    $xtpl->assign('number', $row['number']);
    if ($row['vaccinetime']) $xtpl->assign('vaccinetime', date('d/m/Y', $row['vaccinetime']));
    else $xtpl->assign('vaccinetime', 'Không tiêm phòng');
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function vaccineModal()
{
  global $db, $lang_module, $vacconfigv2;
  $xtpl = new XTemplate('modal.tpl', PATH2);
  $xtpl->assign('lang', $lang_module);

  $xtpl->assign("now", date('d/m/Y'));
  $xtpl->assign("calltime", date('d/m/Y', time() + $vacconfigv2['recall']));

  $list = getdoctorlist();
  foreach ($list as $doctor) {
    $xtpl->assign("doctorid", $doctor["userid"]);
    $xtpl->assign("doctorname", $doctor["fullname"]);
    $xtpl->parse("main.doctor");
    $xtpl->parse("main.doctor2");
  }

  $diseases = getDiseaseList();
  foreach ($diseases as $key => $value) {
    $xtpl->assign("disease_id", $value["id"]);
    $xtpl->assign("disease_name", $value["name"]);
    $xtpl->parse("main.option");
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function vaccineList($vaclist, $overdate = 0, $search = 0)
{
  global $db, $module_info, $module_file, $lang_module, $nv_Request, $vacconfigv2, $filter;
  // initial
  $xtpl = new XTemplate("list.tpl", PATH2);
  $xtpl->assign("lang", $lang_module);
  $now = strtotime(date("Y-m-d"));
  $color = array('1' => 'yellow', '2' => 'green', '3' => 'gray');
  $diseases = getDiseaseData();

  $xtpl->assign('brickcolor', '');
  if ($overdate) {
    $xtpl->assign('brickcolor', 'orange');
  }

  foreach ($vaclist as $row) {
    $pet = selectPetId($row['petid']);
    $customer = selectCustomerId($pet['customerid']);

    $xtpl->assign("petname", $pet["name"]);
    $xtpl->assign("petid", $row["petid"]);
    $xtpl->assign("vacid", $row["id"]);
    $xtpl->assign("customer", $customer["name"]);
    $xtpl->assign("phone", $customer["phone"]);
    $xtpl->assign("diseaseid", $row["diseaseid"]);
    $xtpl->assign("disease", $diseases[$row["diseaseid"]]);
    $xtpl->assign("note", $row["note"]);
    $xtpl->assign("confirm", $lang_module["confirm_" . $row["status"]]);
    if ($search) {
      $xtpl->parse('main.row.note');
    } else {
      $xtpl->parse('main.row.note2');
      if ($filter['status'] < 2) {
        $xtpl->parse('main.row.right');
      }
      if ($filter['status'] == 1) {
        $xtpl->parse('main.row.left');
      }
    }

    $xtpl->assign("color", "red");
    if (!empty($color[$row['status']])) {
      $xtpl->assign("color", $color[$row['status']]);
    }
    $xtpl->assign("cometime", date("d/m/Y", $row["cometime"]));
    if ($filter['status'] == 2) {
      $xtpl->assign("calltime", date("d/m/Y", $row["recall"]));
    } else {
      $xtpl->assign("calltime", date("d/m/Y", $row["calltime"]));
    }
    $xtpl->parse("main.row");
  }
  $xtpl->parse("main");
  return $xtpl->text();
}

function vaccineSearchAll()
{
  global $db, $filter;
  $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, ctime, a.status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id where (c.name like '%$filter[keyword]%' or c.phone like '%$filter[keyword]%')  order by calltime desc limit 50";
  $query = $db->query($sql);
  $list = fetchall($db, $query);
  return vaccineList($list, 0, 1);
}

function vaccineContent()
{
  global $db, $vacconfigv2, $filter;
  // initial
  $today = strtotime(date("Y-m-d"));
  $list = array();
  $where = '';

  switch ($filter['page']) {
    case 1:
      // lọc thêm hôm nay
      $end = $today + 60 * 60 * 24 - 1;
      $where = "where ctime between $today and $end and a.status = $filter[status]";
      break;
    case 2:
      // lọc tái chủng hôm nay
      $end = $today + 60 * 60 * 24 - 1;
      $where = "where calltime between $today and $end and a.status = $filter[status]";
      break;
    default:
      // filter time
      $time = $vacconfigv2["filter"];
      if (empty($time)) {
        $time = 60 * 60 * 24 * 14;
      }
      $from = $today;
      $end = $today + $time - 1;
      $where = "where calltime between $from and $end and a.status = $filter[status]";
  }

  $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, ctime, a.status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id $where order by calltime";
  $query = $db->query($sql);
  $list = fetchall($db, $query);
  // nếu status = chưa gọi hoặc đã gọi, hiển thị quá hạn
  if ($filter['status'] < 2) {
    $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, ctime, a.status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id where calltime < " . $today . " && a.status = $filter[status] order by calltime desc limit 50";
    // die($sql);
    $query = $db->query($sql);
    $list2 = fetchall($db, $query);
    if (count($list2)) return vaccineList($list2, 1) . vaccineList($list);
  }
  return vaccineList($list);
}

function petOption($id)
{
  global $db;

  $sql = "select * from `" . VAC_PREFIX . "_pet` where customerid = " . $id;
  $query = $db->query($sql);
  $xtpl = new XTemplate('option.tpl', PATH2);
  while ($row = $query->fetch()) {
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('value', $row['id']);
    $xtpl->parse('main');
  }
  return $xtpl->text();
}

function kaizenList($userid)
{
  global $db, $filter, $module_name, $op, $type;

  $index = 1;
  $start = $filter['limit'] * ($filter['page'] - 1);
  $xtpl = new XTemplate("list.tpl", PATH2);
  $user = getUserList();

  $xtra = '';
  if ($type) {
    $xtpl->assign('time_cell', 3);
  } else {
    $xtpl->assign('time_cell', 2);
    $xtra = 'where userid = ' . $userid;
  }

  $sql = 'select count(id) as count from `' . VAC_PREFIX . '_kaizen` ' . $xtra;
  $query = $db->query($sql);
  $count = $query->fetch()['count'];

  $sql = 'select * from `' . VAC_PREFIX . '_kaizen` ' . $xtra . ' order by edit_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['limit'] * ($filter['page'] - 1));
  $query = $db->query($sql);
  $check = false;

  while ($row = $query->fetch()) {
    $check = true;
    $xtpl->assign('index', ($start + $index++));
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('user', $user[$row['userid']]['first_name']);
    $xtpl->assign('time', date('d/m/Y H:i', $row['edit_time']));
    $xtpl->assign('problem', $row['problem']);
    $xtpl->assign('solution', $row['solution']);
    $xtpl->assign('result', $row['result']);
    if ($type) {
      $xtpl->parse('main.inbox.row.manager');
      $xtpl->parse('main.inbox.row.manager2');
    }
    $xtpl->parse('main.inbox.row');
  }

  if ($check) {
    $xtpl->parse('main.inbox');
  } else {
    $xtpl->parse('main.empty');
  }

  $xtpl->assign('count', $count);
  $xtpl->assign('nav', nav_generater("/index.php?nv=$module_name&op=$op", $count, $filter['page'], $filter['limit']));

  $xtpl->parse('main');
  return $xtpl->text();
}

function kaizenModal()
{
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}


function xrayModal()
{
  global $lang_module, $db, $status_option;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->assign("lang", $lang_module);

  $today = date("d/m/Y", NV_CURRENTTIME);
  // echo $thongbao; die();

  $xtpl->assign("now", $today);

  $list = getdoctorlist();

  foreach ($list as $row) {
    $xtpl->assign("doctor_value", $row["userid"]);
    $xtpl->assign("doctor_name", $row["fullname"]);
    $xtpl->parse("main.doctor");
  }

  //   var_dump($status_option);die();

  foreach ($status_option as $key => $value) {
    // echo $value;
    $xtpl->assign("status_value", $key);
    $xtpl->assign("status_name", $value);
    $xtpl->parse("main.status");
  }
  // die();

  $xtpl->parse('main');
  return $xtpl->text();
}

function xrayContent()
{
  global $url, $filter, $status_option, $db;
  $xtpl = new XTemplate("content.tpl", PATH2);

  $sql = "select count(id) as count from `" . VAC_PREFIX . "_xray`";
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = "select * from `" . VAC_PREFIX . "_xray` order by cometime desc limit $filter[limit] offset " . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  while ($xray = $query->fetch()) {
    $pet = getPetById($xray['petid']);
    $customer = selectCustomerId($pet['customerid']);
    $xray_treat = getXrayTreat($xray['id']);
    $last_treat = $xray_treat[count($xray_treat) - 1];
    $xtpl->assign('id', $xray['id']);
    $xtpl->assign('customer', $customer['name']);
    $xtpl->assign('phone', $customer['phone']);
    $xtpl->assign('cometime', date('d/m/Y', $xray['cometime']));
    $xtpl->assign('condition', $status_option[$last_treat['condition']]);
    $xtpl->assign('color', '');
    if ($xray['insult'] == 1) $xtpl->assign('color', 'green');
    else if ($xray['insult'] == 2) $xtpl->assign('color', 'red');

    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater($url . '?', $number, $filter['page'], $filter['limit']));

  $xtpl->parse('main');
  return $xtpl->text();
}


function spaModal()
{
  global $lang_module, $weight_option, $spa_option;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->assign("lang", $lang_module);

  $list = getdoctorlist();
  foreach ($list as $doctor) {
    $xtpl->assign("doctor_value", $doctor["userid"]);
    $xtpl->assign("doctor_name", $doctor["fullname"]);
    $xtpl->parse("main.doctor");
    $xtpl->parse("main.doctor2");
    $xtpl->parse("main.doctor3");
  }
  
  foreach ($weight_option as $key => $value) {
    $xtpl->assign("weight_value", $key);
    $xtpl->assign("weight_name", $value);
    $xtpl->parse("main.weight");
    $xtpl->parse("main.weight2");
  }
  
  $xtpl2 = new XTemplate("check.tpl", PATH2);
  $index = 1;
  
  foreach ($spa_option as $key => $value) {
    $xtpl2->assign("c_index", $index);
    $xtpl2->assign("c_content", $value);
    $xtpl2->assign("c_id", $key);
    $xtpl2->parse("main");
    $index ++;
  }
  $xtpl->assign("insert_content", $xtpl2->text());
  $xtpl->parse('main');
  return $xtpl->text();
}

function bloodModal()
{
  global  $user_info;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->assign('statistic_content', bloodStatistic());

  $time = strtotime(date('Y/m/d'));
  // $time = strtotime(date('8/8/2019'));
  $filter['from'] = $time - 60 * 60 * 24 * 15;
  $filter['end'] = $time + 60 * 60 * 24 * 15;

  $xtpl->assign('from', date('d/m/Y', $filter['from']));
  $xtpl->assign('end', date('d/m/Y', $filter['end']));

  $sample = checkBloodSample();
  $last = checkLastBlood();
  $xtpl->assign('today', date('d/m/Y'));
  $xtpl->assign('number1', $sample['number1']);
  $xtpl->assign('number2', $sample['number2']);
  $xtpl->assign('number3', $sample['number3']);
  $xtpl->assign('number', $last);
  $xtpl->assign('last', $last);
  $xtpl->assign('nextlast', $last - 1);
  
  $list = getdoctorlist();
  foreach ($list as $row) {
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('name', $row['first_name']);
    if ($row['userid'] == $user_info['userid']) $xtpl->assign('selected', 'selected');
    else $xtpl->assign('selected', '');
    $xtpl->parse('main.doctor');
  }
  $xtpl->assign('today', date('d/m/Y'));

  $xtpl->parse('main');
  return $xtpl->text();
}

function bloodList()
{
  global $db, $type, $db_config, $link, $filter;
  $xtpl = new XTemplate("list.tpl", PATH2);

  if ($type == 1) {
    $xtpl->assign('show', 'hide');
  }

  $xtra = '';
  if ($filter['type'] > 0) $xtra = 'where type = ' . ($filter['type'] - 1);

  $target = array();
  $sql = 'select * from `' . VAC_PREFIX . '_remind` where name = "blood" order by id';
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $target[$row['id']] = $row['value'];
  }

  $sql = 'select count(*) as num from ((select id, 0 as type from `' . VAC_PREFIX . '_blood_row`) union (select id, 1 as type from `' . VAC_PREFIX . '_blood_import`)) a ' . $xtra;
  $query = $db->query($sql);
  $number = $query->fetch()['num'];
  
  $sql = 'select * from ((select id, time, 0 as type from `' . VAC_PREFIX . '_blood_row`) union (select id, time, 1 as type from `' . VAC_PREFIX . '_blood_import`)) a ' . $xtra . ' order by time desc, id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    if ($row['type']) $sql = 'select * from `' . VAC_PREFIX . '_blood_import` where id = ' . $row['id'];
    else $sql = 'select * from `' . VAC_PREFIX . '_blood_row` where id = ' . $row['id'];
    $query2 = $db->query($sql);
    $row2 = $query2->fetch();

    $sql = 'select * from `' . $db_config['prefix'] . '_users` where userid = ' . $row2['doctor'];
    $user_query = $db->query($sql);
    $user = $user_query->fetch();

    $xtpl->assign('index', $index++);
    $xtpl->assign('time', date('d-m', $row2['time']));
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('typeid', $row['type']);
    $xtpl->assign('doctor', (!empty($user['first_name']) ? $user['first_name'] : ''));
    if ($row['type']) {
      $xtpl->assign('target', 'Nhập ('. $row2['number1'] .'/'. $row2['number2'] .'/'. $row2['number3'] .') giá <span class="text-red">'. number_format($row2['price'], 0, '', ',') .' VND</span>');
      $xtpl->assign('number', '-');
      $xtpl->assign('number1', $row2['number1']);
      $xtpl->assign('number2', $row2['number2']);
      $xtpl->assign('number3', $row2['number3']);
    }
    else {
      $xtpl->assign('target', 'Xét nghiệm: '. (!empty($target[$row2['target']]) ? $target[$row2['target']] : ''));
      $xtpl->assign('number', $row2['number']);
    } 
    if ($type == 2) $xtpl->parse('main.row.test');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater($link . '?', $number, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function marketModal()
{
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceContent()
{
  global $db, $type, $module_name, $op, $filter;
  $xtpl = new XTemplate("list.tpl", PATH2);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $category = priceCategoryList();

  $sql = 'select count(*) as count from `' . VAC_PREFIX . '_price_item` where (name like "%' . $filter['keyword'] . '%" or code like "%' . $filter['keyword'] . '%") ' . ($filter['category'] ? 'and category = ' . $filter['category'] : '');
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = 'select * from `' . VAC_PREFIX . '_price_item` where (name like "%' . $filter['keyword'] . '%" or code like "%' . $filter['keyword'] . '%") ' . ($filter['category'] ? 'and category = ' . $filter['category'] : '') . ' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  if (!empty($allow)) $xtpl->parse('main.m1');
  while ($item = $query->fetch()) {
    $detailList = priceItemDetail($item['id']);
    $count = count($detailList);
    $xtpl->assign('row', $count + 1);
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $item['id']);
    $xtpl->assign('code', $item['code']);
    $xtpl->assign('name', $item['name']);

    $xtpl->assign('category', '');
    if (!empty($category[$item['category']])) $xtpl->assign('category', $category[$item['category']]['name']);

    foreach ($detailList as $detail) {
      $xtpl->assign('price', number_format($detail['price'], 0, '', ','));
      if (!empty($detail['number'])) {
        $xtpl->assign('number', $detail['number']);
        $xtpl->parse('main.row.section.p2');
      } else $xtpl->parse('main.row.section.p1');
      $xtpl->parse('main.row.section');
    }

    if ($type) $xtpl->parse('main.row.m2');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater('/index.php?nv=' . $module_name . '&op=' . $op, $number, $filter['page'], $filter['limit']));
  if ($type) $xtpl->parse('main.m1');
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceCategoryContent()
{
  $xtpl = new XTemplate("category-list.tpl", PATH2);
  $list = priceCategoryList();
  $index = 1;

  foreach ($list as $category) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $category['id']);
    $xtpl->assign('name', $category['name']);
    $xtpl->assign('active', ($category['active'] ? 'warning' : 'info'));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function dailyrouModal()
{
  $time = time();

  if (date('N', $time) < 23) {
    $time = time() - A_DAY * 23;
  }
  $startDate = strtotime(date("Y", $time) . "-" . date("m", $time) . "-24");
  $endDate = strtotime(date("Y", $time) . "-" . (intval(date("m", $time)) + 1) . "-23");

  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->assign("summary", adminSummary($startDate, $endDate));
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceModal()
{
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->assign('category_option', priceCategoryOption());
  $xtpl->assign('category_content', priceCategoryContent());
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceCategoryList()
{
  global $db;

  $sql = 'select * from `' . VAC_PREFIX . '_price_category`';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[$row['id']] = $row;
  }
  return $list;
}

function priceItemDetail($id)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_price_detail` where itemid = ' . $id . ' order by id';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function priceCategoryOption($categoryid = 0)
{
  $list = priceCategoryList();
  $html = '';

  foreach ($list as $category) {
    $check = '';
    if ($categoryid == $category['id']) $check = 'selected';
    $html .= '<option value="' . $category['id'] . '" ' . $check . '>' . $category['name'] . '</option>';
  }
  return $html;
}

function deviceModal()
{
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceManagerList()
{
  global $db, $start, $config;

  $xtpl = new XTemplate("device-manager-list.tpl", PATH2);
  $sql = 'select * from `' . VAC_PREFIX . '_device` order by id desc';
  $query = $db->query($sql);
  $index = 1;
  $depart = getDeviceDepartList();

  while ($row = $query->fetch()) {
    $sql = 'select time from `' . VAC_PREFIX . '_device_detail` where itemid = ' . $row['id'] . ' and (time between ' . $start . ' and ' . ($start + $config * 60 * 60 * 24) . ') order by id desc limit 1';

    $detail_query = $db->query($sql);
    $detail = $detail_query->fetch();
    $xtpl->assign('date', date('d/m/Y', $detail['time']));
    if (!empty($detail)) {
      $xtpl->parse('main.row.yes');
    } else $xtpl->parse('main.row.no');

    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('depart', checkDeviceDepart(json_decode($row['depart']), $depart));
    $xtpl->assign('employ', checkDeviceEmploy($row['id']));
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceList()
{
  global $db, $allow, $user_info, $start, $check_image;

  $xtpl = new XTemplate("device-list.tpl", PATH2);
  if (empty($user_info)) $xtpl->parse('main.no');
  else {
    $sql = 'select * from `' . VAC_PREFIX . '_device` where id in (select itemid from `' . VAC_PREFIX . '_device_employ` where userid = ' . $user_info['userid'] . ')';
    $query = $db->query($sql);
    $index = 1;

    while ($row = $query->fetch()) {
      $sql = 'select * from `' . VAC_PREFIX . '_device_detail` where itemid = ' . $row['id'] . ' and time >= ' . $start . ' order by id desc limit 1';
      $detail_query = $db->query($sql);
      $detail = $detail_query->fetch();
      $xtpl->assign('check', '');
      if (!empty($detail)) $xtpl->assign('check', $check_image);

      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xtpl->assign('name', $row['name']);
      $xtpl->assign('status', $row['status']);
      $xtpl->assign('note', $row['description']);
      $xtpl->assign('number', $row['number']);
      $manual = getDeviceManual($row['id']);
      if (!empty($manual)) $xtpl->parse('main.yes.row.manual');
      $xtpl->parse('main.yes.row');
    }
    $xtpl->parse('main.yes');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function getDeviceDepartList()
{
  global $db;

  $sql = 'select * from `' . VAC_PREFIX . '_device_depart`';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) $list[$row['id']] = $row['name'];
  return $list;
}

function checkDeviceDepart($depart_list, $depart)
{
  $list = array();
  foreach ($depart_list as $departid) {
    $list[] = $depart[$departid];
  }
  return implode(', ', $list);
}

function checkDeviceEmploy($itemid)
{
  global $db, $db_config;

  $sql = 'select concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where userid in (select userid from `' . VAC_PREFIX . '_device_employ` where itemid = ' . $itemid . ')';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) $list[] = $row['fullname'];
  return implode(', ', $list);
}

function bloodStatistic()
{
  global $db, $nv_Request;
  $filter = $nv_Request->get_array('filter', 'post');
  $total = array('import' => 0, 'number' => 0, 'count' => 0, 'real' => 0);

  $check = 0;
  if (empty($filter['from'])) {
    $check += 1;
  }
  if (empty($filter['end'])) {
    $check += 2;
  }

  switch ($check) {
    case 1:
      $filter['end'] = totime($filter['end']);
      $filter['from'] = $filter['from'] - 60 * 60 * 24 * 30;
      break;
    case 2:
      $filter['from'] = totime($filter['from']);
      $filter['end'] = $filter['end'] + 60 * 60 * 24 * 30;
      break;
    case 3:
      $time = strtotime(date('Y/m/d'));
      $filter['from'] = $time - 60 * 60 * 24 * 15;
      $filter['end'] = $time + 60 * 60 * 24 * 15;
      break;
    default:
      $filter['from'] = totime($filter['from']);
      $filter['end'] = totime($filter['end']);
  }

  $xtpl = new XTemplate("statistic-list.tpl", BLOCK);
  $xtpl->assign('from', date('d/m/Y', $filter['from']));
  $xtpl->assign('end', date('d/m/Y', $filter['end']));
  $doctor = getdoctorlist2();

  $sql = 'select * from `' . VAC_PREFIX . '_blood_row` where (time between ' . $filter['from'] . ' and ' . $filter['end'] . ')';
  $query = $db->query($sql);
  $data = array();
  while ($row = $query->fetch()) {
    if (empty($data[$row['doctor']])) {
      $data[$row['doctor']] = array(
        'number' => 0,
        'real' => 0,
        'count' => 0
      );
    }
    $total['count']++;
    $total['number'] += $row['number'];
    $total['real'] += ($row['start'] - $row['end']);
    $data[$row['doctor']]['count']++;
    $data[$row['doctor']]['number'] += $row['number'];
    $data[$row['doctor']]['real'] += ($row['start'] - $row['end']);
  }

  if (count($data)) {
    foreach ($data as $doctorid => $counter) {
      $xtpl->assign('doctor', $doctor[$doctorid]['first_name']);
      $xtpl->assign('number', $counter['number']);
      $xtpl->assign('real', $counter['real']);
      $xtpl->assign('count', $counter['count']);
      $xtpl->parse('main.row');
    }
  } else {
    $xtpl->parse('main.non');
  }

  $sql = 'select * from `' . VAC_PREFIX . '_blood_import` where (time between ' . $filter['from'] . ' and ' . $filter['end'] . ')';
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $total['import'] += $row['price']; // tổng tiền nhập
  }
  $xtpl->assign('import', number_format($total['import'] * 1000, 0, '', ',') . ' VNĐ');
  $xtpl->assign('count', $total['count']);
  $xtpl->assign('number', $total['number']);
  $xtpl->assign('real', $total['real']);

  $xtpl->parse('main');
  return $xtpl->text();
}

function checkUserPermit($overclock = 0)
{
  global $db, $user_info, $vacconfigv2;
  $check = false;

  if ($user_info && $user_info["userid"]) {
    $sql = "select * from `" . VAC_PREFIX . "_user` where userid = $user_info[userid]";
    $query = $db->query($sql);
    if (empty($permit = $query->fetch())) {
      $check = true;
      $contents = "Tài khoản không có quyền truy cập";
    } else if ($overclock && !$permit['manager']) {
      $today = strtotime(date('Y/m/d'));
      $time = time();
      $fromTime = $today + $vacconfigv2['hour_from'] * 60 * 60 + $vacconfigv2['minute_from'] * 60;
      $endTime = $today + $vacconfigv2['hour_end'] * 60 * 60 + $vacconfigv2['minute_end'] * 60;

      if ($time < $fromTime || $time > $endTime) {
        $check = true;
        $contents = '<p style="padding: 10px;">Đã quá thời gian làm việc, xin vui lòng quay lại sau</p>';
      }
    }
  } else {
    $check = true;
    $contents = "Bạn chưa đăng nhập";
  }
  if ($check) {
    include(NV_ROOTDIR . "/includes/header.php");
    echo nv_site_theme($contents);
    include(NV_ROOTDIR . "/includes/footer.php");
  }
}

function expireStatisticContent() {
  global $db, $time;

  $xtpl = new XTemplate("statistic.tpl", PATH2);
  $today = time() + 60 * 60 * 24 - 1;
  $limit = time() + $time * 60 * 60 * 24;
  $half_limit = time() + $time / 2 * 60 * 60 * 24;

  $sql = 'select a.*, b.name from `'. VAC_PREFIX .'_expire` a inner join `'. VAC_PREFIX .'_item` b on a.rid = b.id where exp_time < '. $limit .' and a.number > 0 order by exp_time';
  $query = $db->query($sql);
  // var_dump($query);die();

  $index = 1;
  // echo date('d/m/Y', $p1);die();
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    if ($row['exp_time'] < $today) {
      $xtpl->assign('color', 'red');
    }
    else if ($row['exp_time'] < $half_limit) {
      $xtpl->assign('color', 'yellow');
    }
    else {
      $xtpl->assign('color', '');
    }
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('time', date('d/m/Y', $row['exp_time']));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function expireModal() {
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->assign('statistic', expireStatisticContent());
  $xtpl->parse('main');
  return $xtpl->text();
}

function expireIdList() {
  global $db;

  $query = $db->query('select id from `'. VAC_PREFIX .'_expire`');
  $list = array();
  while ($row = $query->fetch()) {
    $list[] = $row['id'];
  }
  return $list;
}

function getItemList() {
  global $db;

  $query = $db->query('select * from `'. VAC_PREFIX .'_item`');
  $list = array();
  while($row = $query->fetch()) {
    $list[] = array('id' => $row['id'], 'name' => $row['name'], 'key' => convert($row['name']));
  }
  return json_encode($list, JSON_UNESCAPED_UNICODE);
}

function expireContent() {
  global $db, $filter, $link;

  $filter['type'] = intval($filter['type']);
  $xtra = 'order by id desc';
  switch ($filter['type']) {
    case 1:
      $xtra = 'order by exp_time asc';
    break;
    case 2:
      $xtra = 'order by exp_time desc';
    break;
  }

  $xtpl = new XTemplate("list.tpl", PATH2);
  $query = $db->query('select count(*) as number from `'. VAC_PREFIX .'_expire` a inner join `'. VAC_PREFIX .'_item` b on a.rid = b.id where b.name like "%'. $filter['keyword'] .'%"');
  $number = $query->fetch()['number'];

  // die('select * from `'. PREFIX .'row` '. $xtra .' desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select a.*, b.name from `'. VAC_PREFIX .'_expire` a inner join `'. VAC_PREFIX .'_item` b on a.rid = b.id where b.name like "%'. $filter['keyword'] .'%" '. $xtra .' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = $filter['limit'] * ($filter['page'] - 1) + 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('rid', $row['rid']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('time', date('d/m/Y', $row['exp_time']));
    $xtpl->parse('main.row');
  }
  $param = $filter;
  unset($param['page']);
  unset($param['limit']);
  $xtpl->assign('nav', nav_generater($link .'?'. http_build_query($param), $number, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}
