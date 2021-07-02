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

$permit = checkMaterialPermit();
if ($permit === false) {
  // không có quyền
  $contents = 'Người dùng chưa đăng nhập hoặc chưa cấp quyền';
  include NV_ROOTDIR . '/includes/header.php';
  echo nv_site_theme($contents);
  include NV_ROOTDIR . '/includes/footer.php';
}

$excel = $nv_Request->get_int('excel', 'get');
if ($nv_Request->get_int('excel', 'get')) {
  header('location: /excel-output.xlsx?time=' . time());
}
$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    // case 'report-excel':
    //   $xco = array(1 => 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
    //   //   // Tìm kiếm số lượng tồn kho trước 1 thời điểm

    //   include NV_ROOTDIR . '/PHPExcel/IOFactory.php';
    //   $fileType = 'Excel2007';

    //   $id = $nv_Request->get_int('id', 'post');
    //   $filter = $nv_Request->get_array('filter', 'post');
    //   $i = 3;

    //   if (empty($filter['start'])) $filter['start'] = strtotime(date('Y/m/d', time() - (date('d') - 1) * 60 * 60 * 24));
    //   else $filter['start'] = totime($filter['start']);

    //   if (empty($filter['end'])) $filter['end'] = strtotime(date('Y/m/d')) + 60 * 60 * 24 - 1;
    //   else $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;

    //   $sql = 'select * from `pet_manage_material_link` where item_id = ' . $id . ' or link_id = ' . $id;
    //   $query = $db->query($sql);
    //   if (empty($link_data = $query->fetch())) {
    //     // không phải vật liệu liên kết
    //     // loại 1
    //     $objPHPExcel = PHPExcel_IOFactory::load(NV_ROOTDIR . '/assets/excel-material-template.xlsx');

    //     $sql = 'select * from ((select a.number, b.export_date as time, 0 as type, a.note from `pet_manage_export_detail` a inner join `pet_manage_export` b on a.item_id = ' . $id . ' and a.export_id = b.id) union (select a.number, b.import_date as time, 1 as type, a.note from `pet_manage_import_detail` a inner join `pet_manage_import` b on a.item_id = ' . $id . ' and a.import_id = b.id)) as a where time between ' . $filter['start'] . ' and ' . $filter['end'] . ' order by time desc';
    //     $query = $db->query($sql);
    //     $summary = array(
    //       'import' => 0,
    //       'export' => 0
    //     );
    //     $data = array();

    //     while ($row = $query->fetch()) {
    //       $temp = array(
    //         'import_date' => '', 'export_date' => '', 'import' => 0, 'export' => 0, 'note' => $row['note']
    //       );
    //       if ($row['type']) {
    //         $summary['import'] += $row['number'];
    //         $temp['import_date'] = date('d/m/Y', $row['time']);
    //         $temp['import'] = $row['number'];
    //       } else {
    //         $summary['export'] += $row['number'];
    //         $temp['export_date'] = date('d/m/Y', $row['time']);
    //         $temp['export'] = $row['number'];
    //       }
    //       $data[] = $temp;
    //     }

    //     $objPHPExcel
    //       ->setActiveSheetIndex(0)
    //       ->setCellValue($xco[5] . 2, $summary['import'])
    //       ->setCellValue($xco[6] . 2, $summary['export'])
    //       ->setCellValue($xco[7] . 2, $summary['import'] - $summary['export']);

    //     foreach ($data as $key => $data_row) {
    //       $j = 1;

    //       $objPHPExcel
    //         ->setActiveSheetIndex(0)
    //         ->setCellValue($xco[$j++] . $i, $index++) // STT
    //         ->setCellValue($xco[$j++] . $i, $data_row['import_date']) // Ngày nhập
    //         ->setCellValue($xco[$j++] . $i, $data_row['export_date']) // Ngày xuất
    //         ->setCellValue($xco[$j++] . $i, $data_row['import']) // nhập
    //         ->setCellValue($xco[$j++] . $i, $data_row['export']) // xuất
    //         ->setCellValue($xco[$j++] . $i, $summary['import'] -= $data_row['export']) // tồn
    //         ->setCellValue($xco[$j++] . $i, $data_row['note']);  // ghi chú
    //       $i++;
    //     }
    //   } else {
    //     // loại 2
    //     $objPHPExcel = PHPExcel_IOFactory::load(NV_ROOTDIR . '/assets/excel-material-template-2.xlsx');

    //     $sql = 'select * from ((select a.id, b.export_date as time, 0 as type, a.note from `pet_manage_export_detail` a inner join `pet_manage_export` b on (a.item_id = ' . $link_data['item_id'] . ' or a.item_id = ' . $link_data['link_id'] . ') and a.export_id = b.id) union (select a.id, b.import_date as time, 1 as type, a.note from `pet_manage_import_detail` a inner join `pet_manage_import` b on (a.item_id = ' . $link_data['item_id'] . ' or a.item_id = ' . $link_data['link_id'] . ') and a.import_id = b.id)) as a where time between ' . $filter['start'] . ' and ' . $filter['end'] . ' order by time desc';
    //     $query = $db->query($sql);

    //     $summary = array(
    //       'import' => 0,
    //       'export' => 0,
    //       'import2' => 0,
    //       'export2' => 0
    //     );
    //     $data = array();

    //     while ($row = $query->fetch()) {
    //       $temp = array(
    //         'import_date' => '', 'export_date' => '', 'import' => 0, 'export' => 0, 'note' => '', 'import2' => 0, 'export2' => 0, 'note' => $row['note']
    //       );

    //       if ($row['type']) {
    //         $sql = 'select * from `pet_manage_import_detail` where import_id = ' . $row['id'] . ' and item_id = ' . $link_data['item_id'];
    //         $sql2 = 'select * from `pet_manage_import_detail` where import_id = ' . $row['id'] . ' and item_id = ' . $link_data['link_id'];
    //       } else {
    //         $sql = 'select * from `pet_manage_export_detail` where export_id = ' . $row['id'] . ' and item_id = ' . $link_data['item_id'];
    //         $sql2 = 'select * from `pet_manage_export_detail` where export_id = ' . $row['id'] . ' and item_id = ' . $link_data['link_id'];
    //       }

    //       $item = array('number' => 0, 'note' => '');
    //       $link = array('number' => 0, 'note' => '');
    //       if (!empty($link_data['item_id'])) {
    //         $item_query = $db->query($sql);
    //         $item = $item_query->fetch();
    //       }
    //       if (!empty($link_data['link_id'])) {
    //         $link_query = $db->query($sql2);
    //         $link = $link_query->fetch();
    //       }

    //       if ($row['type']) {
    //         $summary['import'] += $item['number'];
    //         $summary['import2'] += $link['number'];
    //         $temp['import_date'] = date('d/m/Y', $row['time']);
    //         $temp['import'] = $item['number'];
    //         $temp['import2'] = $link['number'];
    //       } else {
    //         $summary['export'] += $item['number'];
    //         $summary['export2'] += $link['number'];
    //         $temp['export_date'] = date('d/m/Y', $row['time']);
    //         $temp['export'] = $item['number'];
    //         $temp['export2'] = $link['number'];
    //       }
    //       $data[] = $temp;
    //     }

    //     $objPHPExcel
    //       ->setActiveSheetIndex(0)
    //       ->setCellValue($xco[4] . 2, $summary['import'])
    //       ->setCellValue($xco[5] . 2, $summary['export'])
    //       ->setCellValue($xco[6] . 2, $summary['import'] - $summary['export'])
    //       ->setCellValue($xco[7] . 2, $summary['import2'])
    //       ->setCellValue($xco[8] . 2, $summary['export2'])
    //       ->setCellValue($xco[9] . 2, $summary['import2'] - $summary['export2']);

    //     foreach ($data as $key => $data_row) {
    //       $j = 1;

    //       $summary['import'] -= $data_row['export'];
    //       $summary['import2'] -= $data_row['export2'];
    //       $objPHPExcel
    //         ->setActiveSheetIndex(0)
    //         ->setCellValue($xco[$j++] . $i, $index++) // STT
    //         ->setCellValue($xco[$j++] . $i, $data_row['import_date']) // Ngày nhập
    //         ->setCellValue($xco[$j++] . $i, $data_row['export_date']) // Ngày xuất
    //         ->setCellValue($xco[$j++] . $i, $data_row['import']) // nhập
    //         ->setCellValue($xco[$j++] . $i, $data_row['export']) // xuất
    //         ->setCellValue($xco[$j++] . $i, $summary['import']) // tồn
    //         ->setCellValue($xco[$j++] . $i, $data_row['import2']) // nhập
    //         ->setCellValue($xco[$j++] . $i, $data_row['export2']) // xuất
    //         ->setCellValue($xco[$j++] . $i, $summary['import2']) // tồn
    //         ->setCellValue($xco[$j++] . $i, $data_row['note']);  // ghi chú
    //       $i++;
    //     }
    //   }

    //   $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
    //   $objWriter->save(NV_ROOTDIR . '/assets/excel-material.xlsx');
    //   $objPHPExcel->disconnectWorksheets();
    //   unset($objWriter, $objPHPExcel);
    //   $result['status'] = 1;
    //   break;
      // $objPHPExcel = PHPExcel_IOFactory::load(NV_ROOTDIR . '/assets/excel-material-template.xlsx');

      // $i = 1;
      // $j = 1;

      // $id = $nv_Request->get_int('id', 'post');
      // $filter = $nv_Request->get_array('filter', 'post');

      // if (empty($filter['start'])) $filter['start'] = strtotime(date('Y/m/d', time() - (date('d') - 1) * 60 * 60 * 24));
      // else $filter['start'] = totime($filter['start']);
      // if (empty($filter['end'])) $filter['end'] = strtotime(date('Y/m/d')) + 60 * 60 * 24 - 1;
      // else $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;

      // if (!empty($link = $query->fetch())) {
      //   foreach ($title2 as $key => $value) {
      //     $objPHPExcel
      //     ->setActiveSheetIndex(0)
      //     ->setCellValue($xco[$j++] . $i, $value);
      //   }

      //   $sql = 'select * from ((select a.id, b.export_date as time, 0 as type, a.note from `'. PREFIX .'export_detail` a inner join `'. PREFIX .'export` b on (a.item_id = '. $link['item_id'] .' or a.item_id = '. $link['link_id'] .') and a.export_id = b.id) union (select a.id, b.import_date as time, 1 as type, a.note from `'. PREFIX .'import_detail` a inner join `'. PREFIX .'import` b on (a.item_id = '. $link['item_id'] .' or a.item_id = '. $link['link_id'] .') and a.import_id = b.id)) as a where time between '. $filter['start'] .' and '. $filter['end'] .' order by time desc';
      //   $query = $db->query($sql);

      //   $summary = array('import' => 0, 'export' => 0);
      //   $i = 4;
      //   $index = 1;

      //   while ($row = $query->fetch()) {
      //     $j = 1;
      //     if ($row['type']) {
      //       $sql = 'select * from `'. PREFIX .'import_detail` where import_id = ' . $row['id'] . ' and item_id = ' . $link['item_id'];
      //       $sql2 = 'select * from `'. PREFIX .'import_detail` where import_id = ' . $row['id'] . ' and item_id = ' . $link['link_id'];
      //     }
      //     else {
      //       $sql = 'select * from `'. PREFIX .'export_detail` where export_id = ' . $row['id'] . ' and item_id = ' . $link['item_id'];
      //       $sql2 = 'select * from `'. PREFIX .'export_detail` where export_id = ' . $row['id'] . ' and item_id = ' . $link['link_id'];
      //     }

      //     if (!empty($link['item_id'])) {
      //       $item_query = $db->query($sql);
      //       $item = $item_query->fetch();
      //     }
      //     if (!empty($link['link_id'])) {
      //       $link_query = $db->query($sql2);
      //       $link = $link_query->fetch();
      //     }

      //     // $title2 = array('STT', 'Ngày tháng mua', 'Ngày nhận', 'Nhập', 'Xuất', 'Tồn', 'Nhập', 'Xuất', 'Tồn', 'Ghi chú');

      //     $a = ''; $b = ''; $c = ''; $d = ''; $e = ''; $f = '';
      //     if ($row['type']) {
      //       $a = date('d/m/Y', $row['time']);
      //       $c = $item['number'];
      //       $e = $link['number'];
      //     }
      //     else {
      //       $b = date('d/m/Y', $row['time']);
      //       $d = $item['number'];
      //       $f = $link['number'];
      //     }

      //     $objPHPExcel
      //     ->setActiveSheetIndex(0)
      //     ->setCellValue($xco[$j++] . $i, $index++)
      //     ->setCellValue($xco[$j++] . $i, $a)
      //     ->setCellValue($xco[$j++] . $i, $b)
      //     ->setCellValue($xco[$j++] . $i, $c) // nhập
      //     ->setCellValue($xco[$j++] . $i, $d) // xuất
      //     ->setCellValue($xco[$j++] . $i, $b) // tồn
      //     ->setCellValue($xco[$j++] . $i, $e) // nhập
      //     ->setCellValue($xco[$j++] . $i, $f) // xuất
      //     ->setCellValue($xco[$j++] . $i, $b) // tồn
      //     ->setCellValue($xco[$j++] . $i, $row['note']);
      //     $i ++;
      //   }
      // }
      // else {
      //   foreach ($title as $key => $value) {
      //     $objPHPExcel
      //     ->setActiveSheetIndex(0)
      //     ->setCellValue($xco[$j++] . $i, $value);
      //   }

      //   $sql = 'select * from ((select a.number, b.export_date as time, 0 as type, a.note from `'. PREFIX .'export_detail` a inner join `'. PREFIX .'export` b on a.item_id = '. $id .' and a.export_id = b.id) union (select a.number, b.import_date as time, 1 as type, a.note from `'. PREFIX .'import_detail` a inner join `'. PREFIX .'import` b on a.item_id = '. $id .' and a.import_id = b.id)) as a where time between '. $filter['start'] .' and '. $filter['end'] .' order by time desc';
      //   $query = $db->query($sql);

      //   $summary = array('import' => 0, 'export' => 0);
      //   $i = 4;
      //   $index = 1;
      //   while ($row = $query->fetch()) {
      //     $j = 1;
      //     $a = ''; $b = ''; $c = ''; $d = '';
      //     if ($row['type'] == 0) {
      //       $summary['export'] += $row['number'];
      //       $b = date('d/m/Y', $row['time']);
      //       $d = $row['number'];
      //     }
      //     else {
      //       $summary['import'] += $row['number'];
      //       $a = date('d/m/Y', $row['time']);
      //       $c = $row['number'];
      //     }

      //     $objPHPExcel
      //     ->setActiveSheetIndex(0)
      //     ->setCellValue($xco[$j++] . $i, $index++)
      //     ->setCellValue($xco[$j++] . $i, $a)
      //     ->setCellValue($xco[$j++] . $i, $b)
      //     ->setCellValue($xco[$j++] . $i, $c)
      //     ->setCellValue($xco[$j++] . $i, $d)
      //     ->setCellValue($xco[$j++] . $i, $row['note']);
      //     $i++;
      //   }

      //   $objPHPExcel
      //   ->setActiveSheetIndex(0)
      //   ->setCellValue($xco[4] . 2, $summary['import'])
      //   ->setCellValue($xco[5] . 2, $summary['export'])
      //   ->setCellValue($xco[6] . 2, $summary['import'] - $summary['export']);
      // }

      // $sql = 'select * from '
      //   $filter = $nv_Request->get_array('filter', 'post');
      //   if (empty($filter['start'])) $filter['start'] = strtotime(date('Y/m/d', time() - (date('d') - 1) * 60 * 60 * 24));
      //   else $filter['start'] = totime($filter['start']);
      //   if (empty($filter['end'])) $filter['end'] = strtotime(date('Y/m/d')) + 60 * 60 * 24 - 1;
      //   else $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;

      //   $sql = 'select * from ((select a.number, b.export_date as time, 0 as type from `'. PREFIX .'export_detail` a inner join `'. PREFIX .'export` b on a.item_id = '. $id .' and a.export_id = b.id) union (select a.number, b.import_date as time, 1 as type from `'. PREFIX .'import_detail` a inner join `'. PREFIX .'import` b on a.item_id = '. $id .' and a.import_id = b.id)) as a order by time asc';
      //   $query = $db->query($sql);
      //   $i = 1; $j = 0;
      //   $index = 1;

      //   foreach ($title as $value) {
      //     $objPHPExcel
      //     ->setActiveSheetIndex(0)
      //     ->setCellValue($xco[$j++] . $i, $value);
      //   }

      //   while ($row = $query->fetch()) {
      //     $j = 0;
      //     $i ++;

      //     // $objPHPExcel
      //     // ->setActiveSheetIndex(0)
      //     // ->setCellValue($xco[$j++] . $i, $index ++)
      //     // ->setCellValue($xco[$j++] . $i, $index +);
      //   }

      //   $objPHPExcel
      //   ->setActiveSheetIndex(0)
      //   ->setCellValue($xco[$j++] . $i, $value);

      //   $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
      //   $objWriter->save(NV_ROOTDIR . '/assets/excel-material.xlsx');
      //   $objPHPExcel->disconnectWorksheets();
      //   unset($objWriter, $objPHPExcel);
      //   $result['status'] = 1;
      // break;
    case 'filter':
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

      // b1: thêm vào import
      // b2: kiểm tra từng item, source, expire từ detail
      // b3: nếu không tồn tại, thêm vào detail
      // b4: nếu tồn tại, cập nhật số lượng
      // b5: lấy importid, detailid thêm vào import detail

      // b1
      $sql = 'insert into `pet_manage_material_import` (time) values(' . time() . ')';
      $query = $db->query($sql);
      $importid = $db->lastInsertId();

      // b2
      foreach ($data as $row) {
        $row['date'] = totime($row['date']);
        $row['expire'] = totime($row['expire']);
        $sql = 'select * from `pet_manage_material_detail` where materialid = ' . $row['id'] . ' and source = ' . $row['source'] . ' and expire = ' . $row['expire'];
        $query = $db->query($sql);
        if (empty($detail = $query->fetch())) {
          // b3
          $sql = 'insert into `pet_manage_material_detail` (materialid, expire, number, source) values(' . $row['id'] . ', ' . $row['expire'] . ', ' . $row['number'] . ', ' . $row['source'] . ')';
          $db->query($sql);
          $detail = array('id' => $db->lastInsertId());
        } else {
          // b4
          $sql = 'update `pet_manage_material_detail` set number = number + ' . $row['number'] . ' where id = ' . $detail['id'];
          $db->query($sql);
        }

        // b5
        $sql = 'insert into `pet_manage_material_import_detail` (importid, detailid, number, note, date) values (' . $importid . ', ' . $detail['id'] . ', ' . $row['number'] . ', "' . $row['note'] . '", ' . $row['date'] . ')';
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['material'] = json_encode(getMaterialDataList(), JSON_UNESCAPED_UNICODE);
      $result['html'] = materialList();
      $result['html2'] = importList();
      break;
    case 'update-import':
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');

      // trừ số lượng cũ
      $sql = 'select a.id as ipid, a.number as sub, b.* from pet_manage_material_import_detail a inner join pet_manage_material_detail b on a.detailid = b.id where a.importid = '. $id;
      $query = $db->query($sql);
      $list = array();
      while ($row = $query->fetch()) {
        $list []= $row;
        $sql = 'update pet_manage_material_detail set number = number - '. $row['sub'] .' where id = '. $row['id'];
        $db->query($sql);
      }

      $index = 0;
      foreach ($list as $row) {
        $item = $data[$index ++];
        $expire = totime($item['expire']);
        // cập nhật số lượng mới
        $sql = 'select * from pet_manage_material_detail where materialid = '. $item['id'] .' and source = '. $item['source'] .' and expire = '. $expire;
        $query = $db->query($sql);
        $detail = $query->fetch();
        if (empty($detail)) {
          $sql = "insert into pet_manage_material_detail (materialid, expire, number, source) values($item[id], $expire, $item[number], $item[source])";
          $detail['id'] = $db->insert_id($sql);
        }
        else {
          $sql = "update pet_manage_material_detail set expire = $expire, number = number + $item[number], source = $item[source] where id = ". $detail['id'];
          $db->query($sql);
        }
        // cật nhật số lượng phiếu
        $sql = 'update pet_manage_material_import_detail set detailid = '. $detail['id'] .', number = '. $item['number'] .', note = "'. $item['note'] .'" where id = '. $row['ipid'];
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

      // trừ số lượng cũ
      $sql = 'select a.id as ipid, a.number as sub, b.* from pet_manage_material_export_detail a inner join pet_manage_material_detail b on a.detailid = b.id where a.exportid = '. $id;
      $query = $db->query($sql);
      $list = array();
      while ($row = $query->fetch()) {
        $list []= $row;
        $sql = 'update pet_manage_material_detail set number = number + '. $row['sub'] .' where id = '. $row['id'];
        $db->query($sql);
      }

      $index = 0;
      foreach ($list as $row) {
        $item = $data[$index ++];

        $sql = "update pet_manage_material_detail set number = number - $item[number] where id = ". $item['id'];
        $db->query($sql);
        // cật nhật số lượng phiếu
        $sql = 'update pet_manage_material_export_detail set number = '. $item['number'] .', note = "'. $item['note'] .'" where id = '. $row['ipid'];
        $db->query($sql);
      }

      $result['status'] = 1;
      $result['material'] = json_encode(getMaterialDataList(), JSON_UNESCAPED_UNICODE);
      $result['html'] = materialList();
      $result['html2'] = exportList();
      break;
    case 'get-detail':
      $id = $nv_Request->get_string('id', 'post');

      $sql = 'select id, source, number, expire from pet_manage_material_detail where number > 0 and materialid = '. $id;
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

      // b1
      $sql = 'insert into `pet_manage_material_export` (time) values (' . time() . ')';
      $db->query($sql);
      $exportid = $db->lastInsertId();

      foreach ($data as $row) {
        if ($row['number'] > 0) {
          // b2
          $row['date'] = totime($row['date']);

          $sql = 'insert into `pet_manage_material_export_detail` (exportid, detailid, number, note, date) values (' . $exportid . ', ' . $row['id'] . ', ' . $row['number'] . ', "' . $row['note'] . '", ' . $row['date'] . ')';
          $db->query($sql);

          $sql = 'update `pet_manage_material_detail` set number = number - ' . $row['number'] . ' where id = ' . $row['id'];
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

      $sql = 'select * from pet_manage_material_export_detail where exportid = '. $id;
      $query = $db->query($sql);

      while ($row = $query->fetch()) {
        $sql = 'update pet_manage_material_detail set number = number + '. $row['number'] . ' where id = '. $row['detailid'];
        $db->query($sql);
      }
      $sql = 'delete from pet_manage_material_export_detail where exportid = '. $id;
      $db->query($sql);
      $sql = 'delete from pet_manage_material_export where id = '. $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = materialList();
      $result['html2'] = exportList();
    break;
    case 'remove-import':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'select * from pet_manage_material_import_detail where importid = '. $id;
      $query = $db->query($sql);

      while ($row = $query->fetch()) {
        $sql = 'update pet_manage_material_detail set number = number - '. $row['number'] . ' where id = '. $row['detailid'];
        $db->query($sql);
      }
      $sql = 'delete from pet_manage_material_import_detail where importid = '. $id;
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
      $sql = 'select * from `pet_manage_material` where name like "%' . $data['keyword'] . '%" order by name';
      $query = $db->query($sql);
      $index = 1;

      $source = sourceDataList2();

      while ($item = $query->fetch()) {
        $sql = 'select * from `pet_manage_material_detail` where number > 0 and materialid = ' . $item['id'] . ' and expire < ' . $expire;
        $detailquery = $db->query($sql);
        $xtpl->assign('name', $item['name']);
        while ($detail = $detailquery->fetch()) {
          if ($detail['number'] > 0) {
            $xtpl->assign('index', $index++);
            $xtpl->assign('number', $detail['number']);
            $xtpl->assign('source', $source[$detail['source']]);
            $xtpl->assign('expire', date('d/m/Y', $detail['expire']));
            $xtpl->parse('main.row');
          }
        }
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
