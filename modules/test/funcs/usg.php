<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Phan Tan Dung (phantandung92@gmail.com)
 * @Copyright (C) 2011
 * @Createdate 26-01-2011 14:43
 */
if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');

checkUserPermit(OVERCLOCK);

$filter = array(
  'keyword' => $nv_Request->get_string('keyword', 'get'),
  'order' => $nv_Request->get_int('order', 'get', 0),
  'type' => $nv_Request->get_int('type', 'get', 1),
  'status' => $nv_Request->get_int('status', 'get', 0)
);

$type = 0;
$sql = 'select * from `' . VAC_PREFIX . '_user` where userid = ' . $user_info['userid'];
$query = $db->query($sql);
$user = $query->fetch();
if (!empty($user)) {
  if ($user['manager']) $type = 1;
}

$action = $nv_Request->get_string('action', 'post', "");
if ($action) {
  $result = array("status" => 0, "data" => array());
  switch ($action) {
    case 'update-usg':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');
      if ($data['cometime'])
        $data['cometime'] = totime($data['cometime']);
      if ($data['calltime'])
        $data['calltime'] = totime($data['calltime']);
      if ($data['recall'])
        $data['recall'] = totime($data['recall']);
      if ($data['birthday'])
        $data['birthday'] = totime($data['birthday']);
      if ($data['firstvac'])
        $data['firstvac'] = totime($data['firstvac']);

      $sql = 'update `' . VAC_PREFIX . '_usg` set cometime = "' . $data['cometime'] . '", calltime = "' . $data['calltime'] . '", doctorid = "' . $data['doctorid'] . '", note = "' . $data['note'] . '", image = "' . $data['image'] . '", birth = "' . $data['birth'] . '", expectbirth = "' . $data['expectbirth'] . '", recall = "' . $data['recall'] . '", vaccine = "' . $data['vaccine'] . '", birthday = "' . $data['birthday'] . '", firstvac = "' . $data['firstvac'] . '" where id = ' . $id;
      if ($db->query($sql)) {
        $resut['status'] = 1;
      }
      break;
    case 'get-update':
      $id = $nv_Request->get_string('id', 'post', "");
      if (!empty($id)) {
        $sql = "select * from " . VAC_PREFIX . "_usg where id = $id";
        $query = $db->query($sql);

        if ($query) {
          $row = $query->fetch();
          $sql = "select * from " . VAC_PREFIX . "_pet where id = $row[petid]";
          $query = $db->query($sql);
          $row2 = $query->fetch();
          $result["status"] = 1;
          $recall = 0;
          if ($row["recall"]) {
            $recall = date("d/m/Y", $row["recall"]);
          }
          $vaccine = "";
          foreach ($lang_module["confirm_value"] as $key => $value) {
            $select = "";
            if ($row["vaccine"] == $key) {
              $select = "selected";
            }
            $vaccine .= "<option value='$key' $select>$value</option>";
          }
          $birthday = "";
          $firstvac = "";
          if ($row["birthday"] > 0) {
            $birthday = date("d/m/Y", $row["birthday"]);
          }
          if ($row["firstvac"] > 0) {
            $firstvac = date("d/m/Y", $row["firstvac"]);
          }
          $result["data"] = array("calltime" => date("d/m/Y", $row["calltime"]), "cometime" => date("d/m/Y", $row["cometime"]), "doctorid" => $row["doctorid"], "note" => $row["note"], "image" => $row["image"], "customerid" => $row2["customerid"], "petid" => $row["petid"], "birth" => $row["birth"], "exbirth" => $row["expectbirth"], "recall" => $recall, "vaccine" => $vaccine, "vacid" => $row["vaccine"], "firstvac" => $firstvac, "birthday" => $birthday);
          // var_dump($result);die();
        }
      }
      break;
    case 'edit-note':
      $note = $nv_Request->get_string('note', 'post', '');
      $id = $nv_Request->get_int('id', 'post', '');

      $sql = 'update `' . VAC_PREFIX . '_usg` set note = "' . $note . '" where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
      }
      break;
    case 'overflow':
      $data = $nv_Request->get_array('data', 'post');
      $result['status'] = 1;
      $result['html'] = overflowList($data);
      break;
    case 'change-status':
      $data = $nv_Request->get_array('data', 'post');
      $status_list = array(0 => "Chưa Gọi", "Đã Gọi", "Đã Siêu Âm");

      $sql = 'select * from `' . VAC_PREFIX . '_usg` where id = ' . $data['id'];
      $query = $db->query($sql);
      $usg = $query->fetch();

      $mod = $usg['status'] + ($data['type'] ? 1 : -1);

      if (!empty($status_list[$mod])) {
        $sql = 'update `' . VAC_PREFIX . '_usg` set status = ' . $mod . ' where id = ' . $data['id'];
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = usgRecallList();
        }
      }
      break;
    case 'change-vaccine-status':
      $data = $nv_Request->get_array('data', 'post');
      $status_list = array(0 => "Chưa Gọi", "Đã Gọi", "Đã Tiêm");

      $sql = 'select * from `' . VAC_PREFIX . '_usg` where id = ' . $data['id'];
      $query = $db->query($sql);
      $usg = $query->fetch();

      $mod = $usg['vaccine'] + ($data['type'] ? 1 : -1);

      if (!empty($status_list[$mod])) {
        $sql = 'update `' . VAC_PREFIX . '_usg` set vaccine = ' . $mod . ' where id = ' . $data['id'];
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = usgVaccineList();
        }
      }
      break;
    case 'recall':
      $data = $nv_Request->get_array('data', 'post');
      $recall = $data['recall'] + 60 * 60 * 24 * 30;

      $sql = "update `" . VAC_PREFIX . "_usg` set birth = $data[birth], birthday = " . totime($data['recall']) . ", firstvac = $recall, doctorid = $data[doctor], status = 4, cbtime = " . time() . " where id = $data[id]";
      // die($sql);
      // $sql = 'update `'. VAC_PREFIX .'_usg` set status = 4, birth = '. $data['birth'] .', birthday = ' . totime($data['recall']) . ', recall = '. $recall .', cbtime = '. time() .' where id = ' . $data['id'];

      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgRecallList();
      }
      break;
    case 'birth-recall':
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'select * from `' . VAC_PREFIX . '_usg` where id = ' . $data['id'];
      $query = $db->query($sql);
      $usg = $query->fetch();

      $sql = 'select * from `' . VAC_PREFIX . '_pet` where id = ' . $usg['petid'];
      $query = $db->query($sql);
      $pet = $query->fetch();

      $sql = "insert into `" . VAC_PREFIX . "_pet` values(null, '$data[petname]', $pet[customerid], 0, 0, 0, 0)";
      $sql2 = "insert into `" . VAC_PREFIX . "_vaccine` values(null, '$pet[id]', $data[disease], " . time() . ", " . totime($data['recall']) . ", '', 0, 0, $data[doctor], " . time() . ")";
      $sql3 = 'update `' . VAC_PREFIX . '_usg` set vaccine = 4 where id = ' . $data['id'];

      if ($db->query($sql) && $db->query($sql2) && $db->query($sql3)) {
        $result['status'] = 1;
        $result['html'] = usgVaccineList();
      }
      break;
    case 'remove-usg':
      $id = $nv_Request->get_int('id', 'post', 0);
      if (!empty($id)) {
        $sql = "delete from " . VAC_PREFIX . "_usg where id = $id";

        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = usgManageList();
        }
      }
      break;
    case 'usg_info':
      $id = $nv_Request->get_string('id', 'post', "");
      if (!empty($id)) {
        $sql = "select * from " . VAC_PREFIX . "_usg where id = $id";
        $query = $db->query($sql);

        if ($query) {
          $row = $query->fetch();
          $sql = "select * from " . VAC_PREFIX . "_pet where id = $row[petid]";
          $query = $db->query($sql);
          $row2 = $query->fetch();
          $result["status"] = 1;
          $recall = 0;
          if ($row["recall"]) {
            $recall = date("d/m/Y", $row["recall"]);
          }
          $vaccine = "";
          foreach ($lang_module["confirm_value"] as $key => $value) {
            $select = "";
            if ($row["vaccine"] == $key) {
              $select = "selected";
            }
            $vaccine .= "<option value='$key' $select>$value</option>";
          }
          $birthday = "";
          $firstvac = "";
          if ($row["birthday"] > 0) {
            $birthday = date("d/m/Y", $row["birthday"]);
          }
          if ($row["firstvac"] > 0) {
            $firstvac = date("d/m/Y", $row["firstvac"]);
          }
          $result["data"] = array("calltime" => date("d/m/Y", $row["calltime"]), "cometime" => date("d/m/Y", $row["cometime"]), "doctorid" => $row["doctorid"], "note" => $row["note"], "image" => $row["image"], "customerid" => $row2["customerid"], "petid" => $row["petid"], "birth" => $row["birth"], "exbirth" => $row["expectbirth"], "recall" => $recall, "vaccine" => $vaccine, "vacid" => $row["vaccine"], "firstvac" => $firstvac, "birthday" => $birthday);
        }
      }
      break;
    case 'update_usg':
      $id = $nv_Request->get_string('id', 'post', "");
      $cometime = $nv_Request->get_string('cometime', 'post', "");
      $calltime = $nv_Request->get_string('calltime', 'post', "");
      $doctorid = $nv_Request->get_string('doctorid', 'post', "");
      $birth = $nv_Request->get_string('birth', 'post', "");
      $exbirth = $nv_Request->get_string('exbirth', 'post', "");
      $recall = $nv_Request->get_string('recall', 'post', "");
      $vaccine = $nv_Request->get_int('vaccine', 'post', 0);
      $note = $nv_Request->get_string('note', 'post', "");
      $image = $nv_Request->get_string('image', 'post', "");
      $customer = $nv_Request->get_string('customer', 'post', "");

      $firstvac = $nv_Request->get_string('firstvac', 'post', "");
      $birthday = $nv_Request->get_string('birthday', 'post', "");
      if (!(empty($id) || empty($cometime) || empty($calltime) || empty($doctorid))) {
        $cometime = totime($cometime);
        $calltime = totime($calltime);
        $sql = "select * from `" . VAC_PREFIX . "_usg` where id = $id";
        $query = $db->query($sql);
        $usg = $query->fetch();
        // var_dump($usg);
        $today = strtotime(date("Y-m-d"));
        if (empty($firstvac)) {
          $firstvac = $today;
        } else {
          $firstvac = totime($firstvac);
        }
        if (empty($birthday)) {
          $birthday = $today;
        } else {
          $birthday = totime($birthday);
        }
        if ($usg["vaccine"] >= 2) {
          $vaccine = 2;
        }
        if ($vaccine == 2) {
          if ($recall == 0) {
            $recall = strtotime(date("Y-m-d"));
          } else {
            $recall = totime($recall);
          }
          if ($usg["childid"] == 0 && $customer > 0) {
            $sql = "insert into " . VAC_PREFIX . "_pet (name, customerid) values('" . date("d/m/Y", $calltime) . "', $customer)";
            $query = $db->query($sql);
            $pet_id = $db->lastInsertId();

            if ($pet_id > 0) {
              $sql = "update `" . VAC_PREFIX . "_usg` set childid = $pet_id, firstvac = $firstvac, birthday = $birthday, cbtime = " . time() . " where id = $id";
              $query = $db->query($sql);
            }

            $sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, diseaseid, cometime, calltime, status, note, recall, doctorid, ctime) values ($pet_id, 0, $firstvac, $recall, 0, '', 0, $doctorid, " . time() . ");";
            $query = $db->query($sql);
          }
        }
        if ($recall == 0) {
          $recall = 0;
        }
        $sql = "update " . VAC_PREFIX . "_usg set cometime = $cometime, calltime = $calltime, doctorid = $doctorid, note = '$note', image = '$image', birth = $birth, expectbirth = $exbirth, recall = $recall, vaccine = $vaccine, firstvac = $firstvac, birthday = $birthday  where id = $id";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
        }
      }
      break;
    case 'insert-usg':
      $data = $nv_Request->get_array('data', 'post');
      // var_dump($_POST);
      $sql = "select * from `" . VAC_PREFIX . "_customer` where phone = '$data[phone]'";
      $query = $db->query($sql);
      if (!empty($customer = $query->fetch())) {
        $data['customer'] = $customer['id'];
        $sql = "update `" . VAC_PREFIX . "_customer` set name = '$data[name]', address = '$data[address]' where phone = '$data[phone]'";
        $db->query($sql);
      } else {
        $sql = "insert into `" . VAC_PREFIX . "_customer` (name, phone, address) values ('$data[name]', '$data[phone]', '$data[address]');";
        $db->query($sql);
        $data['customer'] = $db->lastInsertId();

        $sql = "insert into `" . VAC_PREFIX . "_pet` (name, customerid) values ('Chưa đặt tên', $data[customer]);";
        $db->query($sql);
        $data['pet'] = $db->lastInsertId();
      }

      if (empty($data['pet'])) {
        // thêm thú cưng mặc định
        $sql = "insert into `" . VAC_PREFIX . "_pet` (name, customerid) values ('Chưa đặt tên', $data[customer]);";
        $db->query($sql);
        $data['pet'] = $db->lastInsertId();
      }

      $usgtime = totime($data['usgtime']);
      $expecttime = totime($data['expecttime']);
      $sql = "INSERT INTO `" . VAC_PREFIX . "_usg2` (petid, doctorid, usgtime, expecttime, expectnumber, vaccinetime, image, status, note, time) VALUES ($data[pet], $data[doctor], $usgtime, $expecttime, $data[expectnumber], 0, '', 0, '$data[note]', " . time() . ")";

      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = usgCurrentList($filter);
      $result['html2'] = newUsgContent();
      break;
    case 'change-recall':
      $id = $nv_Request->get_int('id', 'post');
      $type = $nv_Request->get_int('type', 'post');

      $sql = 'update `' . VAC_PREFIX . '_usg2` set status = ' . $type . ' where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgCurrentList($filter);
      }
      break;
    case 'birth':
      $id = $nv_Request->get_int('id', 'post');
      $number = $nv_Request->get_int('number', 'post', 0);
      $time = $nv_Request->get_string('time', 'post', 0);

      $sql = 'update `' . VAC_PREFIX . '_usg2` set number = ' . $number . ', birthtime = ' . totime($time) . ', status = 2 where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgCurrentList($filter);
      }
      break;
    case 'vaccine':
      $id = $nv_Request->get_int('id', 'post');
      $disease = $nv_Request->get_string('disease', 'post', 0);
      $doctor = $nv_Request->get_string('doctor', 'post', 0);
      $time = $nv_Request->get_string('time', 'post', 0);

      // kiểm tra thú cưng tồn tại
      $sql = "select b.id from `" . VAC_PREFIX . "_usg2` a inner join `" . VAC_PREFIX . "_pet` b on a.id = $id and a.petid = b.id";
      $query = $db->query($sql);

      if ($row = $query->fetch()) {
        $time = totime($time);

        $sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, cometime, calltime, doctorid, note, status, diseaseid, recall, ctime) values ($row[id], " . time() . ", $time, $doctor, '', 0, $disease, 0, " . time() . ");";
        $sql2 = "update `" . VAC_PREFIX . "_usg2` set status = 3, vaccinetime = " . $time . " where id = $id";
        if ($db->query($sql) && $db->query($sql2)) {
          $result['status'] = 1;
          $result['html'] = usgCurrentList($filter);
        }
      }
      break;
    case 'reject':
      $id = $nv_Request->get_int('id', 'post');

      $sql = "update `" . VAC_PREFIX . "_usg2` set status = 3 where id = " . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgCurrentList($filter);
      }
      break;
    case 'customer-remind':
      $name = $nv_Request->get_string('name', 'post', '');
      $type = $nv_Request->get_int('type', 'post', '');

      if ($type) {
        $list = getcustomer('', $name);
      } else {
        $list = getcustomer($name, '');
      }

      $html = '';
      foreach ($list as $customer) {
        $html .= '<div class="hr"><div class="item_suggest item_suggest2" onclick="selectCustomer(' . $customer['id'] . ', \'' . $customer['name'] . '\', \'' . $customer['phone'] . '\', `' . petOption($customer['id']) . '`)">' . $customer['name'] . ' <br>' . $customer['phone'] . '</div></div><div style="clear: both;"></div>';
      }
      $result["status"] = 1;
      $result["html"] = $html;
      break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign('module_name', $module_name);
$xtpl->assign('op', $op);
$filter_param = $filter;
unset($filter_param['type']);
$xtpl->assign('filter_param', '&' . http_build_query($filter_param));
// Hiển thị tab được chọn
for ($i = 1; $i <= 4; $i++) {
  if ($i == $filter['type'])
    $xtpl->assign('type_button' . $i, 'btn-info');
  else
    $xtpl->assign('type_button' . $i, 'btn-default');
}
// Hiển thị tab quản lý
if ($type) $xtpl->parse('main.manager');

$xtpl->assign('content', usgCurrentList($filter));

$xtpl->assign("modal", usgModal($lang_module));
$xtpl->parse("main");
$contents = $xtpl->text("main");

include(NV_ROOTDIR . "/includes/header.php");
echo nv_site_theme($contents);
include(NV_ROOTDIR . "/includes/footer.php");
