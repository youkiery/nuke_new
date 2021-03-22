<?php
class Schedule extends Module {
  function __construct() {
    parent::__construct();
    $this->module = 'row';
    $this->prefix = 'pet_' . $this->table .'_'. $this->module;
    $this->role = $this->getRole();
  }

  function getList($filter) {
    $list = array();
    if (!$filter['time']) $filter['time'] = time();
    $starttime = date("N", $filter['time']) == 1 ? strtotime(date("Y-m-d", $filter['time'])) : strtotime(date("Y-m-d", strtotime('last monday', $filter['time'])));
    $endtime = $starttime + 60 * 60 * 24 * 7 - 1;
    $reversal = array(
      1 => 0, 1, 2, 3, 4, 5, 6
    );

    $data = array();

    if ($this->role) {
      $list = $this->getUserList(true);
      foreach ($list as $id => $name) {
        $aday = 60 * 60 * 24;
        $sheet = array(
          0 => array(1 => date('d/m', $starttime), 'green', 'green'),
          array(1 => date('d/m', $starttime + $aday), 'green', 'green'),
          array(1 => date('d/m', $starttime + $aday * 2), 'green', 'green'),
          array(1 => date('d/m', $starttime + $aday * 3), 'green', 'green'),
          array(1 => date('d/m', $starttime + $aday * 4), 'green', 'green'),
          array(1 => date('d/m', $starttime + $aday * 5), 'green', 'green'),
          array(1 => date('d/m', $starttime + $aday * 6), 'green', 'green'),
        );
        $sql = 'select id, user_id, type, time from `'. $this->prefix .'` where (type = 2 or type = 3) and (time between '. $starttime .' and '. $endtime .') and user_id = ' . $id;
        $query = $this->db->query($sql);
        while ($row = $query->fetch_assoc()) {
          $day = date('N', $row['time']);
          $sheet[$reversal[$day]][$row['type']] = 'blue';
        }
        
        $data []= array('id' => $id, 'name' => $name, 'day' => $sheet);
      }
    }
    else {
      for ($i = 0; $i < 7; $i++) { 
        $data []= array(
          'data' => array(
            1 => array(),
            array(),
            array()
          ), 
          'time' => date('d/m', $starttime + 60 * 60 * 24 * $i)
        );
      }
  
      $sql = 'select id, user_id, type, time from `'. $this->prefix .'` where (time between '. $starttime .' and '. $endtime .')';
      $query = $this->db->query($sql);
      $row = array();
      $userList = $this->getUserList();
  
      while ($row = $query->fetch_assoc()) {
        $day = date('N', $row['time']);
        $name = $userList[$row['user_id']];
        if ($row['type']) $data[$reversal[$day]]['data'][$row['type']] []= $name;
        // echo json_encode($data);die();
      }
    }

    return $data;
  }

  function getScheduleById($id) {
    $sql = 'select * from `'. $this->prefix .'` where id = '. $id;
    $query = $this->db->query($sql);
    if (!empty($row = $query->fetch_assoc())) return $row;
    return array();
  }

  function insert($userid, $time, $type, $action) {
    $start = $time;
    $end = $start + 60 * 60 * 24 - 1;

    $sql = 'select * from `'. $this->prefix .'` where user_id = '. $userid . ' and (time between '. $start .' and '. $end .') and type = '. $type;
    $query = $this->db->query($sql);
    $row = $query->fetch_assoc();
    // echo $action . '<br>';
    if ($action) {
      if ($row) $sql = 'delete from `'. $this->prefix .'` where id = ' . $row['id'];
    }
    else if (!$row) $sql = 'insert into `'. $this->prefix .'` (user_id, type, time, reg_time) values('. $userid .', '. $type .', '. $time .', '. time() .')';
    if ($sql) $this->db->query($sql);
  }
}
