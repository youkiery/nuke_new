<?php 

$filter = array(
  'time' => ( !empty($_GET['time']) ? $_GET['time'] : '' ),
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' )
);
$filter['time'] = intval($filter['time']);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen();

$last = $kaizen->getLastUpdate();

$result['status'] = 1;
if ($filter['time'] < $last) {
  $result['time'] = $last;
  $result['list'] = $kaizen->getKaizenList();
  $result['unread'] = $kaizen->getNotifyUnread();
}
