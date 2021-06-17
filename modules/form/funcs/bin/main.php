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

$page_title = "Nhập hồ sơ một chiều";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$teriorname = array('endedcopy' => 'Bản copy', 'endedhour' => 'Giờ kết thúc', 'endedminute' => 'Phút kết thúc', 'code' => 'Mã phiếu', 'sender' => 'Người gửi', 'receive' => 'Người nhận', 'resend' => 'Ngày hẹn trả', 'state' => 'Hình thức nhận', 'receiver' => 'Người nhận', 'ireceive' => 'Ngày nhận', 'iresend' => 'Ngày hẹn trả', 'form' => 'Tên hồ sơ', 'number' => 'Số lượng mẫu', 'sample' => 'Loài được lấy mẫu', 'type' => 'Loại mẫu', 'samplecode' => 'Ký hiệu mẫu', 'exam' => 'Yêu cầu xét nghiệm', 'method' => 'Phương pháp', 'address' => 'Địa chỉ', 'phone' => 'Số điện thoại', 'samplereceive' => 'Ngày lấy mẫu', 'samplereceiver' => 'Người lấy mẫu', 'examdate' => 'Ngày xét nghiệm', 'result' => 'Kết quả', 'xcode' => 'Số ĐKXN', 'page' => 'Số trang', 'no' => 'Liên', 'customer' => 'Khách hàng', 'other' => 'Yêu cầu khác', 'receivehour' => 'Giờ nhận', 'receiveminute' => 'Phút nhận', 'isenderemploy' => 'Người gửi', 'isenderunit' => 'Đơn vị gửi', 'ireceiveremploy' => 'Người nhận', 'ireceiverunit' => 'Đơn vị nhận', 'status' => 'Tình trạng mẫu', 'xstatus' => 'Hình thức bảo quản', 'quality' => 'Chất lượng mẫu', 'ireceiver' => 'Người nhận', 'note' => 'Ghi chú', 'target' => 'Mục tiêu', 'receiveDis' => 'Nơi nhận', 'receiveLeader' => 'Người phụ trách', 'xaddress' => 'Địa chỉ khách hàng', 'sampleplace' => 'Nơi lấy mẫu', 'owner' => 'Chủ hộ', 'xphone' => 'Số điện thoại', 'xnote' => 'Ghi chú', 'numberword' => 'Ghi chú (chữ)', 'fax' => 'Fax');
	
	$result = array("status" => 0);
	switch ($action) {
		// case 'catch-form':
		// 	$formid = $nv_Request->get_string('formid', 'get/post', '');
		
		// 	$xtpl = XTemplate('edit/form-1.tpl', PATH);
		// 	$xtpl->parse('main');
		// 	$result['status'] = 1;
		// 	$result['html'] = $xtpl->text();
		// break;
		case 'summaryFilter':
			$from = $nv_Request->get_string('from', 'get/post', '');
			$end = $nv_Request->get_string('end', 'get/post', '');
			$exam = $nv_Request->get_string('exam', 'get/post', '');
			$unit = $nv_Request->get_string('unit', 'get/post', '');
			$sample = $nv_Request->get_string('sample', 'get/post', '');

			$from = totime($from);
			$end = totime($end);

			$result['status'] = 1;
			$result['html'] = summaryContent($from, $end, $exam, $unit, $sample);
		break;
		case 'removeRemind':
			$id = $nv_Request->get_string('id', 'get/post', '');

			if (!(empty($id) || empty(getRemindId($id)))) {
				$sql = 'update `'.PREFIX.'_remind` set visible = 0 where id = '. $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã xóa';
					$result['remind'] = json_encode(getRemind());
				}
			}
		break;
		case 'removeRemindv2':
			$id = $nv_Request->get_string('id', 'get/post', '');

			if (!(empty($id) || empty(getRemindIdv2($id)))) {
				$sql = 'update `'.PREFIX.'_remindv2` set visible = 0 where id = '. $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã xóa';
					$result['remind'] = json_encode(getRemindv2());
				}
			}
		break;
		// case 'removeMethod':
		// 	$id = $nv_Request->get_string('id', 'get/post', '');

		// 	if (!(empty($id) || empty(getMethodId($id)))) {
		// 		$sql = 'update `'.PREFIX.'_method` set visible = 0 where id = '. $id;
		// 		if ($db->query($sql)) {
		// 			$result['status'] = 1;
		// 			$result['notify'] = 'Đã xóa';
		// 			$result['method'] = json_encode(getMethod());
		// 		}
		// 	}
		// break;
		// case 'insertMethod':
		// 	$name = $nv_Request->get_string('name', 'get/post', '');

		// 	if (!(empty($name))) {
		// 		if (!checkMethod($name, '')) {
		// 			$sql = 'insert into `'. PREFIX .'_method` (name, symbol) values("'.$name.'", "'.$symbol.'")';
		// 			if ($db->query($sql)) {
		// 				$method = getMethod();
		// 				$methodHtml = '';
		// 				foreach ($method as $index => $row) {
		// 					$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
		// 				}
		// 				$result['html'] = $methodHtml;
		// 				$result['status'] = 1;
		// 				$result['method'] = json_encode($method);
		// 				$result['notify'] = 'Đã thêm phương pháp';
		// 			}
		// 		}
		// 		else {
		// 			$result['notify'] = 'Phương pháp đã tồn tại';
		// 		}
		// 	}
		// 	else {
		// 		$result['notify'] = 'Phương pháp đã tồn tại';
		// 	}
		// break;
		// case 'removeSymbol':
		// 	$id = $nv_Request->get_string('id', 'get/post', '');

		// 	if (!(empty($id) || empty(getSymbolId($id)))) {
		// 		$sql = 'update `'.PREFIX.'_symbol` set visible = 0 where id = '. $id;
		// 		if ($db->query($sql)) {
		// 			$result['status'] = 1;
		// 			$result['notify'] = 'Đã xóa';
		// 			$result['symbol'] = json_encode(getSymbol());
		// 		}
		// 	}
		// break;
		// case 'insertSymbol':
		// 	$name = $nv_Request->get_string('name', 'get/post', '');
		// 	$symbol = $nv_Request->get_string('symbol', 'get/post', '');

		// 	if (!(empty($name) || empty($symbol))) {
		// 		if (!checkMethod($name, $symbol)) {
		// 			$sql = 'insert into `'. PREFIX .'_method` (name, symbol) values("'.$name.'", "'.$symbol.'")';
		// 			if ($db->query($sql)) {
		// 				$method = getMethod();
		// 				$methodHtml = '';
		// 				foreach ($method as $index => $row) {
		// 					$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
		// 				}
		// 				$result['html'] = $methodHtml;
		// 				$result['status'] = 1;
		// 				$result['method'] = json_encode($method);
		// 				$result['notify'] = 'Đã thêm phương pháp';
		// 			}
		// 		}
		// 		else {
		// 			$result['notify'] = 'Phương pháp đã tồn tại';
		// 		}
		// 	}
		// 	else {
		// 		$result['notify'] = 'Phương pháp đã tồn tại';
		// 	}
		// break;
		case 'filter':
			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			// $printer = explode(', ',$nv_Request->get_string('printer', 'get/post', ''));
			$printer = $nv_Request->get_string('printer', 'get/post', '');
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			$result['status'] = 1;
			$result['html'] = formList($keyword, $page, $limit, $printer);
		break;
		case 'preview':
		case 'getForm':
			$id = $nv_Request->get_string('id', 'get/post', '');
		
			$sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
			$query = $db->query($sql);

			$result['form'] = $query->fetch();
			if (empty($result['form'])) {
				$result['notify'] = 'Có lỗi xảy ra';
			}
			else {
				$result['form']['receiver'] = getRemindId($result['form']['receiver']);
				$result['form']['sender'] = getRemindId($result['form']['sender']);
				$result['form']['ireceiveremploy'] = getRemindId($result['form']['ireceiveremploy']);
				$result['form']['ireceiverunit'] = getRemindId($result['form']['ireceiverunit']);
				$result['form']['isenderemploy'] = getRemindId($result['form']['isenderemploy']);
				$result['form']['isenderunit'] = getRemindId($result['form']['isenderunit']);

				$result['form']['receive'] = date('d/m/Y', $result['form']['receive']);
				$result['form']['resend'] = date('d/m/Y', $result['form']['resend']);
				$result['form']['ireceive'] = date('d/m/Y', $result['form']['ireceive']);
				$result['form']['iresend'] = date('d/m/Y', $result['form']['iresend']);
				$result['form']['receivetime'] = date('d/m/Y', $result['form']['receivetime']);
				$result['form']['samplereceive'] = date('d/m/Y', $result['form']['samplereceive']);
				$result['form']['sampletime'] = date('d/m/Y', $result['form']['sampletime']);
				$result['form']['noticetime'] = date('d/m/Y', $result['form']['noticetime']);

				$result['form']['examdate'] = date('d/m/Y', $result['form']['examdate']);
				$result['form']['note'] = str_replace('<br />', '', $result['form']['note']);

				if ($result['form']['typeindex'] >= 0) {
					$result['form']['type']['index'] = $result['form']['typeindex'];
					$result['form']['type']['value'] = $result['form']['typevalue'];
				}

				if ($result['form']['stateindex'] >= 0) {
					$result['form']['state']['index'] = $result['form']['stateindex'];
					$result['form']['state']['value'] = $result['form']['statevalue'];
				}
				
				if ($action == 'preview') {
					$result = $result['form'];
					if (!empty($result['form'])) {
						$result['form'] = explode(', ', $result['form']);
					}
					if (!empty($result['exam'])) {
						$result['exam'] = explode(', ', $result['exam']);
					}
					if (!empty($result['method'])) {
						$result['method'] = explode(', ', $result['method']);
					}
				}
				$result['status'] = 1;
			}
		break;
		case 'remove':
			$id = $nv_Request->get_string('id', 'get/post', '');
			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			// $printer = explode(', ',$nv_Request->get_string('printer', 'get/post', ''));
			$printer = $nv_Request->get_string('printer', 'get/post', '');
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			if (!empty($id)) {
				$sql = 'delete from `'. PREFIX .'_row` where id = ' . $id;
				$query = $db->query($sql);

				if ($query) {
					$result['status'] = 1;
					$result['notify'] = 'Đã xóa mẫu đơn';
					$result['html'] = formList($keyword, $page, $limit, $printer);
				}
			}
		break;
		case 'insert':
			$id = $nv_Request->get_string('id', 'get/post', '');
			$form = $nv_Request->get_string('form', 'get/post', '');
			$data = $nv_Request->get_array('data', 'get/post', '');

			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			$printer = $nv_Request->get_string('printer', 'get/post', '');
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			$result['notify'] = 'Nhập sai thông tin, hoặc thông tin lỗi';
			if (!checkIsMod($user_info['userid'])) {
				$result['notify'] = 'Tài khoản không có quyền truy cập';
			}
			else {
				switch ($form) {
					case '1': 
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
						}
						else {
							if ($key = precheck($data)) {
								$result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
							}
							else {
								$sender = checkRemindRow($data['sender'], 2);
								$receiver = checkRemindRow($data['receiver'], 1);

								foreach ($data['exams'] as $key => $value) {
									checkRemindRow($value, 3);
								}
								foreach ($data['symbol'] as $key => $value) {
									checkRemindv2($value, 'symbol');
								}
								foreach ($data['methods'] as $key => $value) {
									checkRemindv2($value, 'method');
								}
								if ($id) {
									$sql = 'update `'. PREFIX .'_row` set code = "'. $data['code'] .'", sender = ' . $sender . ', receive = ' . totime($data['receive']) . ', resend = ' . totime($data['resend']) . ', stateIndex = '. $data['state']['index'] .', stateValue = "'. $data['state']['value'] .'", receiver = ' . $receiver . ', ireceive = '. totime($data['ireceive']) . ', iresend = '. totime($data['iresend']) . ', form = "'. implode(', ', $data['forms']) .'", number = ' . $data['number'] .', exam = "' . implode(', ', $data['exams']) . '", sample = "'. $data['sample'] .'", sampleCode = "'. $data['samplecode'] .'", method = "'. implode(', ', $data['methods']) .'", symbol = "'. implode(', ', $data['symbol']) .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", xnote = "'. $data['xnote'] .'", numberword = "'. $data['numberword'] .'" where id = ' . $id;
									$query = $db->query($sql);
									$result['id'] = $id;
								}
								else {
									$sql = 'insert into `'. PREFIX .'_row` (code, sender, receive, resend, stateIndex, stateValue, receiver, ireceive, iresend, form, number, exam, sample, sampleCode, method, typeIndex, typeValue, time, xnote, symbol, numberword) values("'. $data['code'] .'", '. $sender .', ' . totime($data['receive']) . ', ' . totime($data['resend']) . ', '. $data['state']['index'] .', "'. $data['state']['value'] . '", ' . $receiver . ', '. totime($data['ireceive']) . ',  '. totime($data['ireceive']) . ', "'. implode(', ', $data['forms']) .'", ' . $data['number'] .', "' . implode(', ', $data['exams']) . '", "'. $data['sample'] .'", "'. $data['samplecode'] .'", "'. implode(', ', $data['methods']) .'", '. $data['type']['index'] .', "'. $data['type']['value'] .'", '. time() . ', "'. $data['xnote'] .'", "'. $data['symbol'] .'", "'. $data['numberword'] .'")';
									$query = $db->query($sql);
									$result['id'] = $db->lastInsertId();
								}
								if ($query) {
									checkPrinter($result['id'], $form);
									$result['status'] = 1;
									$result['notify'] = 'Đã lưu mẫu';
									$result['html'] = formList($keyword, $page, $limit, $printer);
									$result['remind'] = json_encode(getRemind());
									$result['remindv2'] = json_encode(getRemindv2());
								}
							}	
						}
					break;
					case '2':
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
						}
						else {
							$data['receive'] = totime($data['receive']);
							$data['isenderemploy'] = checkRemindRow($data['isenderemploy'], 1);
							$data['isenderunit'] = checkRemindRow($data['isenderunit'], 2);
							$data['ireceiveremploy'] = checkRemindRow($data['ireceiveremploy'], 1);
							$data['ireceiverunit'] = checkRemindRow($data['ireceiverunit'], 2);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
							foreach ($data['symbol'] as $key => $value) {
								checkRemindv2($value, 'symbol');
							}
							foreach ($data['methods'] as $key => $value) {
								checkRemindv2($value, 'method');
							}
							$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", isenderEmploy = '. $data['isenderemploy'] .',  isenderUnit = '. $data['isenderunit'] .', ireceiverEmploy = '. $data['ireceiveremploy'] .', ireceiverUnit = '. $data['ireceiverunit'] .', receiveHour = '.$data['receivehour'].', receiveMinute = '.$data['receiveminute'].', typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", sample = "'. $data['sample'] .'", number = '. $data['number'] .', status = "'. $data['status']['index'] .'", sampleCode = "'. $data['samplecode'] .'", xstatus = '. $data['xstatus']['index'] .', quality = "'. $data['quality']['index'] .'", exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'", endedCopy = '. $data['endedcopy'] .', endedHour = '. $data['endedhour'] .', endedMinute = '. $data['endedminute'] .', receive = '. $data['receive'] .', attach = "'. $data['attach']['index'] .'", xphone = "' . $data['xphone'] . '", xnote = "'. $data['xnote'] .'", numberword = "'. $data['numberword'] .'" where id = ' . $id;
							$query = $db->query($sql);
							if ($query) {
								checkPrinter($id, $form);
								$result['notify'] = 'Đã cập nhật mẫu';
								$result['status'] = 1;
								$result['id'] = $id;
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
								$result['remindv2'] = json_encode(getRemindv2());
							}
						}
					break;
					case '3':
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
						}
						else {
							$data['isenderunit'] = checkRemindRow($data['isenderunit'], 2);
							$receive = totime($data['receive']);
							$resend = totime($data['resend']);
							$data['note'] = nl2br($data['note']);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
							foreach ($data['symbol'] as $key => $value) {
								checkRemindv2($value, 'symbol');
							}
							foreach ($data['methods'] as $key => $value) {
								checkRemindv2($value, 'method');
							}
							$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", page = "'. implode(', ', $data['page']) .'", no = "'. implode(', ', $data['no']) .'",  isenderUnit = '. $data['isenderunit'] .', typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", number = '. $data['number'] .', sample = "'. $data['sample'] .'", sampleCode = "'. $data['samplecode'] .'", exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'", symbol = "'. implode(', ', $data['symbol']) .'", other = "'. $data['other'] .'", receive = '. $receive .', resend = '. $resend .', attach = "'.$data['attach'].'", numberword = "'. $data['numberword'] .'" where id = ' . $id;
							$query = $db->query($sql);
							if ($query) {
								checkPrinter($id, $form);
								$result['notify'] = 'Đã cập nhật mẫu';
								$result['status'] = 1;
								$result['id'] = $id;
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
								$result['remindv2'] = json_encode(getRemindv2());
							}
						}
					break;
					case '4':
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
						}
						else {
							$data['isenderunit'] = checkRemindRow($data['isenderunit'], 2);
							$data['ireceiveremploy'] = checkRemindRow($data['ireceiveremploy'], 1);
							$sampleReceive = totime($data['samplereceive']);
							$receive = totime($data['receive']);
							$examDate = totime($data['examdate']);
							$note = nl2br($data['note']);
							checkRemindRow($data['address'], 5);
							checkRemindRows($data['result'], 5);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
							foreach ($data['symbol'] as $key => $value) {
								checkRemindv2($value, 'symbol');
							}
							foreach ($data['methods'] as $key => $value) {
								checkRemindv2($value, 'method');
							}
							// isenderunit            

							$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", receiveHour = '.$data['receivehour'].', receiveMinute = '.$data['receiveminute'].', sampleReceive = "'.$sampleReceive.'", address = "'.$data['address'].'", sampleReceiver = "'.$data['samplereceiver'].'", examDate = "'.$examDate.'", result = "'. $data['result'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", number = '. $data['number'] .', status = "'. $data['status']['index'] .'", sampleCode = "'. $data['samplecode'] .'", receive = '. $receive .', note = "'. $note .'", xphone = "'. $data['xphone'] .'", sample = "'. $data['sample'] .'", isenderUnit = "'. $data['isenderunit'] .'", ireceiverEmploy = '. $data['ireceiveremploy'] .', exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'", symbol = "'. implode(', ', $data['symbol']) .'", numberword = "'. $data['numberword'] .'", fax = "'. $data['fax'] .'" where id = ' . $id;
							$query = $db->query($sql);
							if ($query) {
								checkPrinter($id, $form);
								$result['notify'] = 'Đã cập nhật mẫu';
								$result['status'] = 1;
								$result['id'] = $id;
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
								$result['remindv2'] = json_encode(getRemindv2());
							}
						}
					break;
					case '5':
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
						}
						else {
							$resend = totime($data['resend']);
							$receive = totime($data['receive']);
							$note = nl2br($data['note']);
							checkRemindRow($data['xaddress'], 8);
							checkRemindRow($data['onwer'], 9);
							checkRemindRow($data['sampleplace'], 10);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
							foreach ($data['symbol'] as $key => $value) {
								checkRemindv2($value, 'symbol');
							}
							foreach ($data['methods'] as $key => $value) {
								checkRemindv2($value, 'method');
							}
							$sender = checkRemindRow($data['sender'], 2);

							$sql = 'update `'. PREFIX .'_row` set xaddress = "'.$data['xaddress'].'", number = '. $data['number'] .', sampleCode = "'. $data['samplecode'] .'", note = "'. $note .'", noticetime = '. $resend .', target = "'. $data['target'].'", exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'", symbol = "'. implode(', ', $data['symbol']) .'", receiveDis = "'. $data['receivedis'] .'", receiveLeader = "'. $data['receiveleader'] .'", sampleplace = "'. $data['sampleplace'] .'", owner = "'. $data['owner'] .'", xcode = "'. implode(', ', $data['xcode']) .'", receive = "'. $receive .'", result = "'. $data['result'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", sender = "'. $sender .'", numberword = "'. $data['numberword'] .'" where id = ' . $id;
							$query = $db->query($sql);
							if ($query) {
								checkPrinter($id, $form);
								$result['notify'] = 'Đã cập nhật mẫu';
								$result['status'] = 1;
								$result['id'] = $id;
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
								$result['remindv2'] = json_encode(getRemindv2());
							}
						}
					break;
				}
			}
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH);

if (checkIsMod($user_info['userid'])) {
	$method = getMethod();
	$methodHtml = '';
	foreach ($method as $index => $row) {
		$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
	}
	
	for ($i = 0; $i < 60; $i++) { 
		if ($i < 10) {
			$xtpl->assign('value', '0' . $i);
		}
		else {
			$xtpl->assign('value', $i);
		}
		$xtpl->parse('main.mod2.minute');
		$xtpl->parse('main.mod2.minute2');
		if ($i < 24) {
			$xtpl->parse('main.mod2.hour');
			$xtpl->parse('main.mod2.hour2');
		}
	}
	$xtpl->parse('main.mod');
	$xtpl->parse('main.mod2');
}

$today = strtotime(date('Y-m-d'));
$from = $today - 60*60*24*7;
$end = $today + 60*60*24*7;

$xtpl->assign("methodOption", $methodHtml);
$xtpl->assign('summarycontent', summaryContent($from, $end));
$xtpl->assign('summaryfrom', date('d/m/Y', $from));
$xtpl->assign('summaryend', date('d/m/Y', $end));
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('content', formList());
$xtpl->assign("method", json_encode($method));
$xtpl->assign("remind", json_encode(getRemind()));
$xtpl->assign("remindv2", json_encode(getRemindv2()));
$xtpl->assign("relation", json_encode(getRelation()));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

