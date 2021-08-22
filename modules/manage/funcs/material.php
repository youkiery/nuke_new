<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) {
  die('Stop!!!');
}
$page_title = "Quản lý vật tư, hóa chất";

$url = "/$module_name/$op?";
$filter = array(
  'func' => $nv_Request->get_string('func', 'post', 'material'),
  'page' => $nv_Request->get_int('page', 'post', 1),
  'limit' => $nv_Request->get_int('limit', 'post', 20)
);

// $sql = "select * from pet_manage_material";
// $list = all($sql);

// foreach ($list as $row) {
//   $sql = "update pet_manage_material_detail set number = 0 where materialid = $row[id]";
//   $db->query($sql);
// }

// $sql = "select b.id, b.number, b.remain, b.detailid, b.date, c.materialid, d.name, 'export' as type from pet_manage_material_export b inner join pet_manage_material_detail c on b.detailid = c.id inner join pet_manage_material d on c.materialid = d.id";
// $list = all($sql);
// $sql = "select b.id, b.number, b.remain, b.detailid, b.date, c.materialid, d.name, 'import' as type from pet_manage_material_import b inner join pet_manage_material_detail c on b.detailid = c.id inner join pet_manage_material d on c.materialid = d.id";
// $list = array_merge($list, all($sql));

// // sắp xếp lại theo time
// usort($list, "cmp");

// $change = array();
// // echo json_encode($list);
// // die();
// foreach ($list as $row) {
//   if (empty($change[$row['materialid']])) $change[$row['materialid']] = array(
//     'name' => $row['name'],
//     'remain' => 0,
//     'expect' => 0
//   );
//   $change[$row['materialid']]['expect'] += $row['number'] * ( $row['type'] == 'export' ? -1 : 1 );

//   // if ($row['type'] == 'export') $sql = "update pet_manage_material_export set remain = ". $change[$row['materialid']]['expect'] . " where id = $row[id]";
//   // else $sql = "update pet_manage_material_import set remain = ". $change[$row['materialid']]['expect'] . " where id = $row[id]";
//   // $db->query($sql);

//   // if ($row['type'] == 'export') $sql = "update pet_manage_material_detail set number = number - $row[number] where id = $row[detailid]";
//   // else $sql = "update pet_manage_material_detail set number = number + $row[number] where id = $row[detailid]";
//   // $db->query($sql);
// }

// foreach ($change as $key => $value) {
//   $value['remain'] = materialRemain($key);
//   echo $value['name'] . ": tồn - $value[remain] - thực tế - $value[expect]<br>";
// }

// die();

// select * from pet_manage_material a inner join pet_manage_material_detail b on b.materialid = a.id where a.name like "%Thùng bảo quản mẫu%"


$permit = checkMaterialPermit();
if ($permit === false) {
  // không có quyền
  $contents = 'Người dùng chưa đăng nhập hoặc chưa cấp quyền';
  include NV_ROOTDIR . '/includes/header.php';
  echo nv_site_theme($contents);
  include NV_ROOTDIR . '/includes/footer.php';
}

if ($nv_Request->isset_request("excel", "get")) {
  $xco = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

  $material = $nv_Request->get_string('material', 'get', '');
  $list = explode(',', $material);
  if (!empty($material) && count($list)) $xtra = "and d.id in ($material)";
  else $xtra = "";

  $excelf = totime(str_replace('-', '/', $nv_Request->get_string('excelf', 'get/post', '')));
  $excelt = totime(str_replace('-', '/', $nv_Request->get_string('excelt', 'get/post', ''))) + 60 * 60 * 24 - 1;
  include 'PHPExcel/IOFactory.php';
  $fileType = 'Excel2007'; 
  $objPHPExcel = PHPExcel_IOFactory::load(NV_ROOTDIR . '/assets/excel/material.xlsx');

  $i = 2;
  $list = array();
  $sql = "select a.date, a.number, a.remain, d.name, 'export' as type from pet_manage_material_export a inner join pet_manage_material_detail c on a.detailid = c.id inner join pet_manage_material d on c.materialid = d.id where (date between $excelf and $excelt) $xtra";
  $list = all($sql);
  $sql = "select a.date, a.number, a.remain, d.name, 'import' as type from pet_manage_material_import a inner join pet_manage_material_detail c on a.detailid = c.id inner join pet_manage_material d on c.materialid = d.id where (date between $excelf and $excelt) $xtra";

  $list = array_merge($list, all($sql));
  
  // sắp xếp lại theo time
  usort($list, "cmp");
  // foreach ($list as $row) {
  //   echo date('d/m/Y', $row['date']) . "<br>";
  // }
  // die();

  // tính tồn kho
  $index = 1;

  $objPHPExcel->setActiveSheetIndex(0);
  foreach ($list as $row) {
    $j = 0;

    $temp = array(
      'export' => '',
      'exporttime' => '',
      'import' => '',
      'importtime' => '',
    );
    if ($row['type'] == 'export') {
      $temp['export'] = $row['number'];
      $temp['exporttime'] = date('d/m/Y', $row['date']);
    }
    else {
      $temp['import'] = $row['number'];
      $temp['importtime'] = date('d/m/Y', $row['date']);
    }

    $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue($xco[$j ++] . $i, (($index < 10 ? '0' : '') . ($index++)))
      ->setCellValue($xco[$j ++] . $i, $row['name'])
      ->setCellValue($xco[$j ++] . $i, $temp['export'])
      ->setCellValue($xco[$j ++] . $i, $temp['exporttime'])
      ->setCellValue($xco[$j ++] . $i, $temp['import'])
      ->setCellValue($xco[$j ++] . $i, $temp['importtime'])
      ->setCellValue($xco[$j ++] . $i, $row['remain']);
    $i ++;
  }

  $outFile = 'excel/excel-'. time() .'.xlsx';
  $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
  $objWriter->save($outFile);
  $objPHPExcel->disconnectWorksheets();
  unset($objWriter, $objPHPExcel);
  header('location: /' . $outFile);
}

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'excel-suggest':
      $id = $nv_Request->get_string('id', 'post', '');
      $keyword = $nv_Request->get_string('keyword', 'post', '');

      $sql = "select * from pet_manage_material where name like '%$keyword%' " . (strlen($id) ? "and id not in ($id)" : "");
      $query = $db->query($sql);
      $html = "";

      while ($row = $query->fetch()) {
        $html .= "<div class='item' onclick='excelInsert($row[id], \"$row[name]\")' id='excel-$row[id]'> [+] $row[name] </div>";
      }
      $result['status'] = 1;
      $result['html'] = $html;
      break;
    case 'filter':
      $keyword = $nv_Request->get_string('keyword', 'post', '');
      switch ($filter['func']) {
        case 'material':
          $result['status'] = 1;
          $result['html'] = materialList();
          break;
        case 'import':
          $result['status'] = 1;
          $result['html'] = importList();
          break;
        case 'export':
          $result['status'] = 1;
          $result['html'] = exportList();
          break;
        case 'source':
          $result['status'] = 1;
          $result['html'] = sourceList();
          break;
      }
    break;
    case 'get-import':
      $id = $nv_Request->get_int('id', 'post', 0);

      $result['status'] = 1;
      $result['data'] = getImportId($id);
    break;
    case 'get-export':
      $id = $nv_Request->get_int('id', 'post', 0);

      $result['status'] = 1;
      $result['data'] = getExportId($id);
    break;
    case 'report-source-suggest':
      $keyword = $nv_Request->get_string('keyword', 'post');

      $xtpl = new XTemplate('report-source-suggest.tpl', PATH);
      $sql = 'select * from pet_manage_material_source where active = 1 and name like "%'. $keyword .'%" limit 20';
      $query = $db->query($sql);

      while ($row = $query->fetch()) {
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->parse('main');
      }
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'report-suggest':
      $keyword = $nv_Request->get_string('keyword', 'post');

      $sql = 'select id, name from pet_manage_material where active = 1 and name like "%'. $keyword .'%"';
      $query = $db->query($sql);
      $list = array();
      while ($row = $query->fetch()) {
        $list []= $row;
      }
      $result['status'] = 1;
      $result['list'] = $list;
    break;
    case 'insert-material':
      $data = $nv_Request->get_array('data', 'post');

      if (!strlen($data['name'])) {
        $result['notify'] = 'Tên vật tư trống';
      } else if (checkMaterialName($data['name'])) {
        $result['notify'] = 'Trùng tên vật tư';
      } else {
        // insert
        $sql = 'insert into `pet_manage_material` (name, unit, description) values("' . $data['name'] . '", "' . $data['unit'] . '", "' . $data['description'] . '")';
        // die($sql);
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['id'] = $db->lastInsertId();
          $result['name'] = $data['name'];
          $result['html'] = materialList();
          $result['json'] = array('id' => $result['id'], 'name' => $data['name'], 'unit' => $data['unit'], 'description' => $data['description']);
        }
      }
      break;
    case 'update-material':
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');

      if (!strlen($data['name'])) {
        $result['notify'] = 'Tên vật tư trống';
      } else if (checkMaterialName($data['name'], $id)) {
        $result['notify'] = 'Trùng tên vật tư';
      } else {
        // insert
        $sql = 'update `pet_manage_material` set name = "' . $data['name'] . '", unit = "' . $data['unit'] . '", description = "' . $data['description'] . '" where id = ' . $id;
        // die($sql);
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = materialList();
          $result['json'] = array('id' => $id, 'name' => $data['name'], 'unit' => $data['unit'], 'description' => $data['description']);
        }
      }
      break;
    case 'remove-item':
      // xóa hàng hóa
      $id = $nv_Request->get_int('id', 'post');

      // deactive hàng hóa
      $sql = 'select * from `'. PREFIX .'material` where id = '. $id;
      $query = $db->query($sql);
      $material = $query->fetch();
      if (!empty($material)) {
        $sql = 'update `'. PREFIX .'material` set active = 0 where id = '. $id;
        $db->query($sql);

        $result['html'] = materialList();
        $result['material'] = getMaterialDataList();
      }
      $result['status'] = 1;
      break;
    case 'get-item':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'select * from `pet_manage_material` where id = ' . $id;
      $query = $db->query($sql);
      $material = $query->fetch();

      $result['status'] = 1;
      $result['data'] = $material;
      break;
    case 'insert-import':
      $data = $nv_Request->get_array('data', 'post');

      // b2: kiểm tra từng item, source, expire từ detail
      // b3: nếu không tồn tại, thêm vào detail
      // b4: nếu tồn tại, cập nhật số lượng
      // b5: lấy importid, detailid thêm vào import detail

      // b2
      foreach ($data as $row) {
        // nếu không có itemid
        if (empty($data['itemid'])) {
          // tìm kiếm item trong csdl
          $sql = "select * from pet_manage_material where name like '$row[item]'";
          $query = $db->query($sql);
          
          // chưa có thì thêm
          if (empty($item = $query->fetch())) {
            $sql = "insert into pet_manage_material (name, unit, description) values ('$row[item]', '', '')";
            $db->query($sql);
            $row['itemid'] = $db->lastInsertid();
          }
          else {
            // có rồi thì đưa vào itemid
            $row['itemid'] = $item['id'];
          }
        }
        // nếu không có sourceid
        if (empty($row['sourceid'])) {
          // tìm kiếm item trong csdl
          $sql = "select * from pet_manage_material_source where name like '$row[source]'";
          $query = $db->query($sql);
          
          // chưa có thì thêm
          if (empty($item = $query->fetch())) {
            $sql = "insert into pet_manage_material_source (name, note) values ('$row[source]', '')";
            $db->query($sql);
            $row['sourceid'] = $db->lastInsertid();
          }
          else {
            // có rồi thì đưa vào sourceid
            $row['sourceid'] = $item['id'];
          }
        }

        $row['date'] = totime($row['date']);
        $row['expire'] = totime($row['expire']);
        $sql = 'select * from `pet_manage_material_detail` where materialid = ' . $row['itemid'] . ' and source = ' . $row['sourceid'] . ' and expire = ' . $row['expire'];
        $query = $db->query($sql);
        if (empty($detail = $query->fetch())) {
          // b3
          $sql = "insert into `pet_manage_material_detail` (materialid, expire, number, source) values($row[itemid], $row[expire], $row[number], $row[sourceid])";
          $db->query($sql);
          $detail = array('id' => $db->lastInsertId());
        } else {
          // b4
          $sql = 'update `pet_manage_material_detail` set number = number + ' . $row['number'] . ' where id = ' . $detail['id'];
          $db->query($sql);
        }

        // b5
        $sql = "insert into `pet_manage_material_import` (detailid, number, remain, note, date) values ($detail[id], $row[number], ". materialRemain($row['itemid']) .", '$row[note]', $row[date])";
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['material'] = json_encode(getMaterialDataList(), JSON_UNESCAPED_UNICODE);
      $result['html'] = materialList();
      $result['html2'] = importList();
      $result['html3'] = sourceList();
      break;
    case 'update-import':
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');

      // trừ số lượng cũ
      $sql = 'select a.id as ipid, a.number as sub, b.* from pet_manage_material_import a inner join pet_manage_material_detail b on a.detailid = b.id where a.id = '. $id;
      $query = $db->query($sql);
      $list = array();
      $change = array();
      while ($row = $query->fetch()) {
        $change[$row['materialid']] = -1 * $row['sub'];
        $list []= $row;
        $sql = 'update pet_manage_material_detail set number = number - '. $row['sub'] .' where id = '. $row['id'];
        $db->query($sql);
      }

      $index = 0;
      foreach ($list as $row) {
        $item = $data[$index ++];
        $expire = totime($item['expire']);
        // cập nhật số lượng mới
        $sql = 'select * from pet_manage_material_detail where materialid = '. $item['itemid'] .' and source = '. $item['sourceid'] .' and expire = '. $expire;
        $query = $db->query($sql);
        $detail = $query->fetch();
        if (empty($change[$item['itemid']])) $change[$item['itemid']] = 0;
        $change[$item['itemid']] += $item['number'];
        if (empty($detail)) {
          $sql = "insert into pet_manage_material_detail (materialid, expire, number, source) values($item[itemid], $expire, $item[number], $item[sourceid])";
          $detail['id'] = $db->insert_id($sql);
        }
        else {
          $sql = "update pet_manage_material_detail set expire = $expire, number = number + $item[number], source = $item[sourceid] where id = ". $detail['id'];
          $db->query($sql);
        }
        // cật nhật số lượng phiếu

        $xtra = "remain = remain ". ($change[$item['itemid']] >= 0 ? '+' : '') . " ". $change[$item['itemid']];
        $sql = "update pet_manage_material_import set detailid = $detail[id], number = $item[number], $xtra, note = '$item[note]' where id = $row[ipid]";
        $db->query($sql);
      }

      $result['status'] = 1;
      $result['material'] = json_encode(getMaterialDataList(), JSON_UNESCAPED_UNICODE);
      $result['html'] = materialList();
      $result['html2'] = importList();
      break;
    case 'update-export':
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');

      $item = $data[0];
      $sql = 'select a.id as ipid, a.number as sub, b.* from pet_manage_material_export a inner join pet_manage_material_detail b on a.detailid = b.id where a.id = '. $id;
      $row = fetch($sql);
      $change = $row['sub'] - $item['number'];
      
      $xtra = "number = number ". ($change >= 0 ? '+' : '') . " ". $change;
      // cập nhập số lượng mới
      $sql = 'update pet_manage_material_detail set '. $xtra .' where id = '. $row['id'];
      $db->query($sql);

      // cập nhật chênh lệch tồn
      $xtra = "remain = remain ". ($change >= 0 ? '+' : '') . " ". $change;
      $sql = "update pet_manage_material_export set number = $item[number], $xtra, note = '$item[note]' where id = $row[ipid]";

      // $query = $db->query($sql);
      // $change = array();
      // $list = array();
      // while ($row = $query->fetch()) {
      //   $list []= $row;
      //   $sql = 'update pet_manage_material_detail set number = number + '. $row['sub'] .' where id = '. $row['id'];
      //   $db->query($sql);
      //   $change[$row['materialid']] = $row['sub'];
      // }

      // $index = 0;
      // foreach ($list as $row) {
      //   $item = $data[$index ++];
      //   if (empty($change[$row['materialid']])) $change[$row['materialid']] = 0;
      //   $change[$row['materialid']] -= $item['number'];

      //   // cật nhật số lượng phiếu

      //   $db->query($sql);
      // }

      $result['status'] = 1;
      $result['material'] = json_encode(getMaterialDataList(), JSON_UNESCAPED_UNICODE);
      $result['html'] = materialList();
      $result['html2'] = exportList();
      break;
    case 'get-detail':
      $id = $nv_Request->get_string('id', 'post');

      $sql = 'select id, source, number, expire from pet_manage_material_detail where number <> 0 and materialid = '. $id;
      $query = $db->query($sql);
      $list = array();
      $name = getItemId($id);

      while ($row = $query->fetch()) {
        $row['name'] = $name;
        $row['source'] = getSourceId($row['source']);
        $row['expire'] = date('d/m/Y', $row['expire']);
        $list []= $row;
      }
      $result['status'] = 1;
      $result['list'] = $list;
    break;
    case 'item-suggest':
      $keyword = $nv_Request->get_string('keyword', 'post');

      $xtpl = new XTemplate('item-suggest.tpl', PATH);
      $sql = 'select a.id, a.name from pet_manage_material a inner join pet_manage_material_detail b on a.id = b.materialid where a.active = 1 and b.number > 0 and a.name like "%'. $keyword .'%" group by a.id limit 20';
      $query = $db->query($sql);

      while ($row = $query->fetch()) {
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->parse('main');
      }
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'source-suggest':
      $keyword = $nv_Request->get_string('keyword', 'post');
      $ia = $nv_Request->get_string('ia', 'post');

      $xtpl = new XTemplate('source-suggest.tpl', PATH);
      $sql = 'select * from pet_manage_material_source where active = 1 and name like "%'. $keyword .'%" limit 20';
      $query = $db->query($sql);
      $xtpl->assign('ia', $ia);

      while ($row = $query->fetch()) {
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->parse('main');
      }
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'material-suggest':
      $keyword = $nv_Request->get_string('keyword', 'post');
      $ia = $nv_Request->get_string('ia', 'post');

      $xtpl = new XTemplate('material-suggest.tpl', PATH);
      $sql = 'select * from pet_manage_material where active = 1 and name like "%'. $keyword .'%" limit 20';
      $query = $db->query($sql);
      $xtpl->assign('ia', $ia);

      while ($row = $query->fetch()) {
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->parse('main');
      }
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'insert-export':
      $data = $nv_Request->get_array('data', 'post');

      // b1: thêm phiếu xuất
      // b2: nếu number > 0, thêm import_detail, cập nhật số lượng detail

      foreach ($data as $row) {
        if ($row['number'] !== 0) {
          // b2
          $sql = "select * from pet_manage_material_detail where id = $row[id]";
          $query = $db->query($sql);
          $detail = $query->fetch();

          $row['date'] = totime($row['date']);
          $sql = 'update `pet_manage_material_detail` set number = number - ' . $row['number'] . ' where id = ' . $row['id'];
          $db->query($sql);

          $sql = "insert into `pet_manage_material_export` (detailid, number, remain, note, date) values ($row[id], $row[number], ". materialRemain($detail['materialid']) .", '$row[note]', $row[date])";
          $db->query($sql);
        }
      }
      $result['status'] = 1;
      $result['material'] = json_encode(getMaterialDataList(), JSON_UNESCAPED_UNICODE);
      $result['html'] = materialList();
      $result['html2'] = exportList();
    break;
    case 'remove-export':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'select * from pet_manage_material_export where id = '. $id;
      $row = fetch($sql);

      $sql = 'update pet_manage_material_detail set number = number + '. $row['number'] . ' where id = '. $row['detailid'];
      $db->query($sql);

      $sql = 'delete from pet_manage_material_export where id = '. $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = materialList();
      $result['html2'] = exportList();
    break;
    case 'remove-import':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'select * from pet_manage_material_import where id = '. $id;
      $row = fetch($sql);

      $sql = 'update pet_manage_material_detail set number = number - '. $row['number'] . ' where id = '. $row['detailid'];
      $db->query($sql);

      $sql = 'delete from pet_manage_material_import where id = '. $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = materialList();
      $result['html2'] = importList();
    break;
    case 'report':
      $data = $nv_Request->get_array('data', 'post');
      $data['date'] = totime($data['date']);
      $list = array();
      if (!count($data['list'])) {
        $sql = 'select * from pet_manage_material where active = 1';
        $query = $db->query($sql);
        
        while ($row = $query->fetch()) $data['list'] []= $row['id'];
      }

      $xtpl = new XTemplate("report-list.tpl", PATH);

      $source = sourceDataList2();

      foreach ($data['list'] as $type) {
        $sql = 'select * from `pet_manage_material` where id = ' . $type;
        $query = $db->query($sql);
        $material = $query->fetch();
        $xtpl->assign('name', $material['name']);

        $sql = 'select * from `pet_manage_material_detail` where materialid = ' . $type . ($data['source'] > 0 ? ' and source = ' . $data['source'] : '');
        $query = $db->query($sql);
        $remain = 0;
        while ($material = $query->fetch()) $remain += $material['number'];

        // lấy dữ liệu trong khoảng thời gian, kiểm tra tick, xuất dữ liệu
        // b1, lấy danh sách nhập, xuất
        // b2, hợp danh sách, foreach, tính tồn đầu tiên
        // b3, kiểm tra tick, xuất dữ liệu
        $sql = 'select a.*, b.source, b.expire from `pet_manage_material_import_detail` a inner join `pet_manage_material_detail` b on a.detailid = b.id where b.materialid = ' . $type . ' and ' . ($data['source'] > 0 ? ' b.source = ' . $data['source'] . ' and ' : '') . ' a.date > ' . $data['date'] . ' and a.number > 0 order by date desc';
        // if ($type == 9) die($sql);
        // die($sql);
        $query = $db->query($sql);
        $import = array();

        while ($row = $query->fetch()) {
          $remain -= $row['number'];
          $import[] = $row;
        }

        $sql = 'select a.*, b.source, b.expire from `pet_manage_material_export_detail` a inner join `pet_manage_material_detail` b on a.detailid = b.id where b.materialid = ' . $type . ' and ' . ($data['source'] > 0 ? ' b.source = ' . $data['source'] . ' and ' : '') . ' a.date > ' . $data['date'] . ' and a.number > 0 order by date desc';
        $query = $db->query($sql);
        $export = array();

        while ($row = $query->fetch()) {
          $remain += $row['number'];
          $export[] = $row;
        }

        $ci = count($import) - 1;
        $ce = count($export) - 1;
        $count = $ci + $ce + 2;
        // chạy import_index, export_index, kiểm tra ngày nhỏ hơn, xuất dòng
        while ($count) {
          $count--;
          $check = true;
          if ($ci >= 0) {
            if ($ce > 0) {
              if ($import[$ci]['date'] > $export[$ce]['date']) {
                $check = false;
              }
            }
          } else {
            $check = false;
          }

          if ($check) {
            $piece = array(
              'type' => 'Nhập',
              'source' => $import[$ci]['source'],
              'date' => date('d/m/Y', $import[$ci]['date']),
              'number' => $import[$ci]['number'],
              'remain' => ($remain += $import[$ci]['number']),
              'expire' => date('d/m/Y', $import[$ci]['expire']),
              'note' => $import[$ci]['note']
            );
            $ci--;
          } else {
            $piece = array(
              'type' => 'Xuất',
              'source' => $export[$ce]['source'],
              'date' => date('d/m/Y', $export[$ce]['date']),
              'number' => $export[$ce]['number'],
              'remain' => ($remain -= $export[$ce]['number']),
              'expire' => date('d/m/Y', $export[$ce]['expire']),
              'note' => $export[$ce]['note']
            );
            $ce--;
          }

          if (!empty($source[$piece['source']])) $source2 = $source[$piece['source']];
          else $source2 = '';
          $xtpl->assign('source', $source2);
          $xtpl->assign('type', $piece['type']);
          $xtpl->assign('date', $piece['date']);
          $xtpl->assign('number', $piece['number']);
          $xtpl->assign('remain', $piece['remain']);
          $xtpl->assign('expire', $piece['expire']);
          $xtpl->assign('note', $piece['note']);
          $xtpl->parse('main.row');
        }
        // die();
        $xtpl->parse('main');
      }
      // die();
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
      break;
    case 'detail':
      $id = $nv_Request->get_string('id', 'post');

      $xtpl = new XTemplate("material-detail.tpl", PATH);
      $sql = "select * from `pet_manage_material` where id = $id";
      $item = fetch($sql);

      $sql = "select * from `pet_manage_material_detail` where number <> 0 and materialid = $id order by expire asc";
      $query = $db->query($sql);

      $index = 1;

      $xtpl->assign('material', $item['name']);
      while ($item = $query->fetch()) {
        $xtpl->assign('index', $index++);
        $xtpl->assign('number', $item['number']);
        $xtpl->assign('source', getSourceId($item['source']));
        $xtpl->assign('expire', date('d/m/Y', $item['expire']));
        $xtpl->parse('main.row');
      }
      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'report_limit':
      $data = $nv_Request->get_array('data', 'post');

      $xtpl = new XTemplate("report-limit-list.tpl", PATH);
      $sql = 'select * from `pet_manage_material` where active = 1 and name like "%' . $data['keyword'] . '%" order by name';
      $query = $db->query($sql);
      $index = 1;

      while ($item = $query->fetch()) {
        $number = 0;
        $sql = 'select * from `pet_manage_material_detail` where materialid = ' . $item['id'] . ' and number > 0';
        // die($sql);
        $detailquery = $db->query($sql);
        while ($detail = $detailquery->fetch()) {
          $number += $detail['number'];
        }
        if ($number <= $data['limit']) {
          $xtpl->assign('index', $index++);
          $xtpl->assign('name', $item['name']);
          $xtpl->assign('number', $number);
          $xtpl->assign('expire', '');
          $xtpl->parse('main.row');
        }
      }
      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();;
      break;
    case 'report_expire':
      $data = $nv_Request->get_array('data', 'post');
      $expire = totime($data['expire']);

      $xtpl = new XTemplate("report-expire-list.tpl", PATH);
      $sql = "select a.name, b.number, b.source, b.expire from `pet_manage_material` a inner join pet_manage_material_detail b on a.id = b.materialid where b.number > 0 and a.name like '%$data[keyword]%' and expire < $expire order by b.expire asc, a.name asc";
      $query = $db->query($sql);
      $index = 1;

      $source = sourceDataList2();

      while ($item = $query->fetch()) {
        $xtpl->assign('name', $item['name']);
        $xtpl->assign('index', $index++);
        $xtpl->assign('number', $item['number']);
        $xtpl->assign('source', $source[$item['source']]);
        $xtpl->assign('expire', date('d/m/Y', $item['expire']));
        $xtpl->parse('main.row');
      }
      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();;
      break;
      // case 'filter-report':
      //   $result['status'] = 1;
      //   $result['html'] = reportList();
      //   break;
      // case 'report':
      //   $result['status'] = 1;
      //   $result['html'] = reportDetail();
      //   break;
      // case 'overlow':
      //   $result['status'] = 1;
      //   $result['html'] = materialOverlowList();
      //   break;
      // case 'expire-filter':
      //   $limit = $nv_Request->get_int('limit', 'post', 0);
      //   $result['status'] = 1;
      //   $result['html'] = expireList($limit);
      //   break;
      // case 'expire':
      //   $id = $nv_Request->get_int('id', 'post', 0);
      //   $limit = $nv_Request->get_int('limit', 'post', 0);

      //   $sql = "update `" . PREFIX . "import_detail` set expire = 1 where id = $id";
      //   if ($db->query($sql)) {
      //     $result['status'] = 1;
      //     $result['html'] = expireList($limit);
      //   }
      //   break;
      // case 'insert-type':
      //   $name = $nv_Request->get_string('name', 'post', '');

      //   $sql = 'select * from `pet_manage_material_type` where name = "' . $name . '"';
      //   $query = $db->query($sql);
      //   if (empty($query->fetch)) {
      //     $sql = 'insert into `pet_manage_material_type` (name) values ("' . $name . '")';
      //     $db->query($sql);
      //     $result['status'] = 1;
      //     $result['id'] = $db->lastInsertId();
      //     $result['html'] = typeOptionList();
      //   }
      //   break;

    case 'get-source':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'select * from pet_manage_material_source where id = '. $id;
      $query = $db->query($sql);
      $result['status'] = 1;
      $result['data'] = $query->fetch();
    break;
    case 'update-source':
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'update pet_manage_material_source set name = "'. $data['name'] .'", note = "'. $data['note'] .'" where id = '. $id;
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = sourceList();
    break;
    case 'remove-source':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'update pet_manage_material_source set active = 0 where id = '. $id;
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = sourceList();
    break;
    case 'insert-source':
      $name = $nv_Request->get_string('name', 'post', '');
      $note = $nv_Request->get_string('note', 'post', '');

      $sql = 'select * from `pet_manage_material_source` where name = "' . $name . '"';
      $query = $db->query($sql);
      if (!empty($source = $query->fetch())) {
        $sql = 'update `pet_manage_material_source` set active = 1, note = "'. $note .'" where name = "' . $name . '"';
        $query = $db->query($sql);

        $result['status'] = 1;
        $result['id'] = $source['id'];
      } else {
        $sql = 'insert into `pet_manage_material_source` (name, note) values ("' . $name . '", "' . $note . '")';
        $db->query($sql);
        $result['status'] = 1;
        $result['data'] = array(
          'id' => $db->lastInsertId(),
          'name' => $name,
          'alias' => simplize($name)
        );
        $result['id'] = $db->lastInsertId();
      }
      break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
// die();

$xtpl->assign('last_week', date('d/m/Y', time() - 60 * 60 * 24 * 7));
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('modal', materialModal());
// var_dump(importList());die();
$xtpl->assign('import_content', importList());
$xtpl->assign('export_content', exportList());
$xtpl->assign('source_content', sourceList());
$xtpl->assign('content', materialList());
$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
