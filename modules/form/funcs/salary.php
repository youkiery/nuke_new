<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}
$user_list = array();
$sql = 'select userid from `pet_user_allow` where salary = 1';
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $user_list []= $row['userid'];
}

require_once(MODAL_PATH . '/promo.php');
require_once(MODAL_PATH . '/salary.php');
$promo = new Promo();
$salary = new Salary();
$const = array(
  'Bậc 1' => '2.34',
  'Bậc 2' => '2.67',
  'Bậc 3' => '3.00',
  'Bậc 4' => '3.33',
  'Bậc 5' => '3.66',
  'Bậc 6' => '3.99',
  'Bậc 7' => '4.32',
  'Bậc 8' => '4.65',
  'Bậc 9' => '4.98'
);

$filter = array(
  'name' => $nv_Request->get_string('name', 'get', ''),
  'note' => $nv_Request->get_string('note', 'get', ''),
  'page' => $nv_Request->get_string('page', 'get', '1'),
  'limit' => $nv_Request->get_string('limit', 'get', '15'),
  'timestart' => $nv_Request->get_string('timestart', 'get', ''),
  'timeend' => $nv_Request->get_string('timeend', 'get', ''),
  'nexttimestart' => $nv_Request->get_string('nexttimestart', 'get', ''),
  'nexttimeend' => $nv_Request->get_string('nexttimeend', 'get', ''),
);

$page_title = "Lương và bổ nhiệm lại";

$action = $nv_Request->get_string('action', 'post/get', "");
$type = $nv_Request->get_string('type', 'post/get', "");
if (!empty($action)) {
	switch ($action) {
    // case 'employ-insert':
    //   $name = $nv_Request->get_string('name', 'post/get', "");
      
    //   if ($employid = $salary->employ->insert($name)) {
    //     $salary->insert(array(
    //       'employid' => $employid,
    //       'formal' => '',
    //       'note' => '',
    //       'time' => date('Y/m/d')
    //     ));
    //     $promo->insert(array(
    //       'employid' => $employid,
    //       'note' => '',
    //       'time' => date('Y/m/d')
    //     ));
    //     $result->status = 1;
    //     $result->html = $salary->salary_content();
    //     $result->html2 = $salary->employ_content();
    //   }
    // break;
    // case 'employ-remove':
    //   $employid = $nv_Request->get_int('employid', 'post/get', "0");
      
    //   if ($salary->employ->remove($employid)) {
    //     $salary->remove($employid);
    //     $promo->remove($employid);
    //     $result->status = 1;
    //     $result->html = $salary->salary_content();
    //     $result->html2 = $salary->employ_content();
    //   }
    //   break;
    case 'salary-up':
      $data = $nv_Request->get_array('data', 'post/get');

      if ($salary->insert($data)) {
        $result->status = 1;
        $result->employ = $salary->remind->get_list('employ');;
        $result->formal = $salary->remind->get_list('formal');;
        $result->html = $salary->salary_content();
      }
    break;
    case 'salary-up-edit':
      $data = $nv_Request->get_array('data', 'post/get');

      if ($salary->update($data)) {
        $result->status = 1;
        $result->employ = $salary->remind->get_list('employ');;
        $result->formal = $salary->remind->get_list('formal');;
        $result->html = $salary->salary_content();
      }
    break;
    case 'promo-up-edit':
      $data = $nv_Request->get_array('data', 'post/get');

      if ($promo->update($data)) {
        $result->status = 1;
        $result->employ = $promo->remind->get_list('employ');;
        $result->formal = $promo->remind->get_list('formal');;
        $result->html = $promo->promo_content();
      }
    break;
    case 'promo-up':
      $data = $nv_Request->get_array('data', 'post/get');

      if ($promo->insert($data)) {
        $result->status = 1;
        $result->employ = $salary->remind->get_list('employ');
        $result->html = $promo->promo_content();
      }
    break;
    case 'remove':
      $id = $nv_Request->get_string('id', 'post/get');
      $result->status = 1;

      if ($type == 'promo') {
        $promo->remove($id);
        $result->html = $promo->promo_content();
      }
      else {
        $salary->remove($id);
        $result->html = $salary->salary_content();
      }
      break;
    // case 'history':
    //   $employid = $nv_Request->get_int('employid', 'post/get', "0");

    //   $result->status = 1;
    //   if ($type === 'promo') $result->html = $promo->history($employid);
    //   else $result->html = $salary->history($employid);
    // break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH2);

$xtpl->assign('name', $filter['name']);
$xtpl->assign('note', $filter['note']);
$xtpl->assign('timestart', $filter['timestart']);
$xtpl->assign('timeend', $filter['timeend']);
$xtpl->assign('nexttimestart', $filter['nexttimestart']);
$xtpl->assign('nexttimeend', $filter['nexttimeend']);

if ($type === 'promo') {
  $xtpl->assign('active_promo', 'class="active"');
  $xtpl->assign('link_salary', '/' . $module_name .'/salary');
  $xtpl->assign('link_promo', '#');
  $xtpl->assign('content', $promo->promo_content());
  $xtpl->parse('main.promo');
}
else {
  $xtpl->assign('active_salary', 'class="active"'); 
  $xtpl->assign('link_salary', '#');
  $xtpl->assign('link_promo', '/' . $module_name .'/salary?type=promo');
  $xtpl->assign('content', $salary->salary_content());
}

$xtpl2 = new XTemplate("modal.tpl", PATH2);
$time = time();
foreach ($const as $name => $value) {
  $xtpl2->assign('name', $name);
  $xtpl2->assign('value', $value);
  $xtpl2->parse('main.const');
}
$xtpl2->assign('time', date('d/m/Y', $time));
$xtpl2->assign('next_salary_time', date('d/m/Y', $time + 60 * 60 * 24 * 365.25 * 3));
$xtpl2->assign('next_promo_time', date('d/m/Y', $time + 60 * 60 * 24 * 365.25 * 5));
$xtpl2->parse('main');

$xtpl->assign('const', implode('|', $const));
$xtpl->assign('employ', implode('|', $salary->remind->get_list('employ')));
$xtpl->assign('formal', implode('|', $salary->remind->get_list('formal')));
$xtpl->assign('modal', $xtpl2->text());
$xtpl->parse('main');
$contents = $xtpl->text();

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

function navi_generater($number, $page, $limit) {
  global $module_name, $op, $type, $filter;
  $link .= "/$module_name/$op/?name=$filter[name]&note=$filter[note]";
  if ($type == 'promo')  $link = $link . '&type=promo';

  $total_pages = ceil($number / $limit);
  $html = '';

  for ($i = 1; $i <= $total_pages; $i++) { 
    if ($i == $page) $html .= '<li class="active"><a href="'. $link .'&page='. $i .'"> '. $i .' </a></li>';
    else $html .= '<li><a href="'. $link .'&page='. $i .'"> '. $i .' </a></li>';
  }
  return '<ul class="pagination">
    '. $html .'
  </ul>';
}

function getLevel($const_level) {
  global $const;
  foreach ($const as $key => $value) {
    if ($value == $const_level) return $key;
  }
}