<?php 

require_once(NV_ROOTDIR . '/ionic/work.php');
$work = new Work();
if (empty($_GET['id'])) $result['messenger'] = 'Công việc không tồn tại';
else if (!$work->role) $result['messenger'] = 'Chưa cấp quyền truy cập';
else {
  $data = array(
    'id' => parseGetData('id')
  );

  $filter = array(
    'startdate' => ( !empty($_GET['startdate']) ? $_GET['startdate'] : '' ),
    'enddate' => ( !empty($_GET['enddate']) ? $_GET['enddate'] : '' ),
    'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' ),
    'user' => ( !empty($_GET['user']) ? $_GET['user'] : '' )
  );

  if (!$work->checkWorkId($data['id'])) $result['messenger'] = 'Công việc không tồn tại';
  else {
    $time = time();
    $work->doneWork($data, $time);
    $result['status'] = 1;
    $result['messenger'] = 'Đã hoàn thành công việc';
    $result['time'] = $time;
    $result['unread'] = $work->getNotifyUnread();
    $result['data'] = $work->getWork($filter);
  }
}

echo json_encode($result);
die();