<?php 

$filter = array(
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' )
);

$data = array(
  'id' => parseGetData('id'),
  'type' => parseGetData('type', 0)
);

$filter = array(
  'starttime' => parseGetData('starttime'),
  'endtime' => parseGetData('endtime'),
  'keyword' => parseGetData('keyword'),
  'sort' => parseGetData('sort')
);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen('test');

$result['status'] = 1;
$result['time'] = $kaizen->checkData($data['id'], $data['type']);
$result['list'] = $kaizen->getKaizenList();
$result['unread'] = $kaizen->getNotifyUnread();
