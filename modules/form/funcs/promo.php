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

require_once(MODAL_PATH . '/promo.php');
require_once(MODAL_PATH . '/salary.php');
$promo = new Promo();
$salary = new Salary();

$page_title = "Lương và bổ nhiệm lại";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	switch ($action) {
    case 'employ-insert':
      $name = $nv_Request->get_string('name', 'post/get', "");
      
      if ($employid = $salary->employ->insert($name)) {
        $salary->insert(array(
          'employid' => $employid,
          'formal' => '',
          'note' => '',
          'time' => date('Y/m/d')
        ));
        $promo->insert(array(
          'employid' => $employid,
          'note' => '',
          'time' => date('Y/m/d')
        ));
        $result->status = 1;
        $result->html = $promo->promo_content();
        $result->html2 = $promo->employ_content();
      }
    break;
    case 'employ-remove':
      $id = $nv_Request->get_int('id', 'post/get', "0");
      
      if ($promo->employ->remove($id)) {
        $salary->remove($id);
        $promo->remove($id);
        $result->status = 1;
        $result->html = $promo->promo_content();
        $result->html2 = $promo->employ_content();
      }
      break;
    case 'promo-up':
      $data = $nv_Request->get_array('data', 'post/get');

      if ($promo->insert($data)) {
        $result->status = 1;
        $result->html = $promo->promo_content();
      }
    break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH2);

$xtpl->assign('modal', $promo->modal());
$xtpl->assign('content', $promo->promo_content());
$xtpl->parse('main');
$contents = $xtpl->text();

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

