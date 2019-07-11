<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_MAINFILE')) {
	die('Stop!!!');
}

define("PREFIX", $db_config['prefix'] . "_" . $module_name);

function getUserFloor($userid = 0) {
  global $db, $db_config;
  $list = array();
  
  if (empty($userid)) {
    $sql = 'select a.position, b.first_name from `'. PREFIX .'_user_position` a inner join `'. $db_config['prefix'] .'_users` b on a.userid = b.userid';
    $query = $db->query($sql);

    while ($row = $query->fetch()) {
      if (empty($list[$row['position']])) {
        $list[$row['position']] = array();
      } 
      $list[$row['position']][] = $row['first_name'];
    }
  }
  else {
    $sql = 'select * from `'. PREFIX .'_user_position` where userid = ' . $userid;
    $query = $db->query($sql);
  
    $row = $query->fetch();
    $list = $row['position'];
  }

  return $list;
}

function getWeekRegister($time) {
  global $db;

  $day = date('w', strtotime(date('Y/m/d', $time)));
  $week_start = strtotime(date('Y', $time) . '/' .  date('m', $time) . '/' . (date('d', $time) - $day + 1));
  $week_end = $week_start + 60 * 60 * 24 * 7 - 1;

  $sql = 'select * from `'. PREFIX .'_row` where time between ' . $week_start . ' and ' . $week_end;
  $query = $db->query($sql);
  $data = array(
    0 => array(
      0 => array(), array(), array(), array()
    ),
    array(
      0 => array(), array(), array(), array()
    ),
    array(
      0 => array(), array(), array(), array()
    ),
    array(
      0 => array(), array(), array(), array()
    ),
    array(
      0 => array(), array(), array(), array()
    ),
    array(
      0 => array(), array(), array(), array()
    ),
    array(
      0 => array(), array(), array(), array()
    )
  );

  while ($row = $query->fetch()) {
    $day = date('w', $row['time']);
    $day = reparseDay($day);
    $data[$day][$row['type']][] = $row['user_id'];
  } 
  return json_encode($data);
}

function getUserList() {
  global $db, $db_config;

  $sql = 'select userid, last_name, first_name from `'. $db_config['prefix'] .'_users` where userid in (select user_id from `'. $db_config['prefix'] .'_rider_user` where type = 1)';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[$row['userid']] = $row['first_name'];
  }
  return $list;
}

function reparseDay($day) {
  if ($day == 0) {
    $day = 6;
  }
  else {
    $day --;
  }
  return $day;
}

function getPosition() {
  global $db;

  $list = array();
  $sql = 'select * from `'. PREFIX .'_position`';
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function doctorPositionList() {
  global $db, $db_config;
  $list = array();

  $sql = "select userid, username, last_name, first_name from `" .  $db_config["prefix"] . "_users` where userid in (select user_id from `" . $db_config["prefix"] . "_rider_user` where type = 1)";
  $query = $db->query($sql);
  
  while ($row = $query->fetch()) {
    $sql = 'select * from `'. PREFIX .'_user_position` where userid = ' . $row['userid'];
    $userPositionQuery = $db->query($sql);
    $userPositionData = $userPositionQuery->fetch();
    $row['position'] = 0;
    if (!empty($userPositionData) && !empty($userPositionData['position'])) {
      $row['position'] = $userPositionData['position'];
    }
    $list[$row["userid"]] = $row;
  }

  return $list;
}

function doctorByPositionList() {
  global $db, $db_config;
  $position = getPosition();
  $list = [];

  $sql = "select userid, username, last_name, first_name from `" .  $db_config["prefix"] . "_users` where userid in (select user_id from `" . $db_config["prefix"] . "_rider_user` where type = 1)";
  $query = $db->query($sql);
  
  while ($row = $query->fetch()) {
    $sql = 'select * from `'. PREFIX .'_user_position` where userid = ' . $row['userid'];
    $userPositionQuery = $db->query($sql);
    $userPositionData = $userPositionQuery->fetch();
    if (!empty($userPositionData) && !empty($userPositionData['position'])) {
      $row['position'] = $userPositionData['position'];
      if (empty($list[$row['position']])) {
        $list[$row['position']] = array();
      }
      $list[$row['position']][] = $row;
    }
  }

  return $list;
}

function checkPositionName($name) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_position` where name = "'. $name .'"';
  $query = $db->query($sql);

  if (!empty($query->fetch())) {
    return true;
  }
  return false;
}

function insertPosition($name) {
  global $db;

  $sql = 'insert into `'. PREFIX .'_position` (name) values("'. $name .'")';

  if ($db->query($sql)) {
    return $db->lastInsertId();
  }
  return 0;
}

function removePosition($id) {
  global $db;

  $sql = 'delete from `'. PREFIX .'_position` where id = ' . $id;

  if ($db->query($sql)) {
    $sql = 'delete from `'. PREFIX .'_user_position` where position = ' . $id;

    if ($db->query($sql)) {
      return true;
    }
  }
  return false;
}

function setUserPosition($type, $userid, $id) {
  global $db;

  if ($positionid = checkUserPosition($userid)) {
    if (!empty($type)) {
      $id = 0;
    }
    $sql = 'update `'. PREFIX .'_user_position` set position = '. $id .' where userid = ' . $userid;
  }
  else {
    $sql = 'insert into `'. PREFIX .'_user_position` (userid, position) values ('. $userid .', '. $id .')';
  }
  if ($db->query($sql)) {
    return true;
  }
  return false;
}

// function insertUserPosition($user, $id) {
//   global $db;

//   $sql = 'insert into `'. PREFIX .'_user_position` (userid, position) values ('. $userid .', '. $position .')';

//   if ($db->query($sql)) {
//     return true;
//   }
//   return false;
// }

// function updateUserPosition($positionid, $id) {
//   global $db;

//   $sql = 'update `'. PREFIX .'_user_position` set  (userid, position) values ('. $userid .', '. $position .')';

//   if ($db->query($sql)) {
//     return true;
//   }
//   return false;
// }

function checkUserPosition($userid) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_user_position` where userid = ' . $userid;
  $query = $db->query($sql);

  if (!empty($row = $query->fetch())) {
    return $row['id'];
  }
  return 0;
}

function userList() {
  global $db, $db_config;
  $list = array();

  $sql = "select userid, username, last_name, first_name from `" .  $db_config["prefix"] . "_users`";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[$row["userid"]] = $row;
  }

  return $list;
}

function doctorList() {
  global $db, $db_config;
  $list = array();

  $sql = "select userid, username, last_name, first_name from `" .  $db_config["prefix"] . "_users` where userid in (select user_id from `" . $db_config["prefix"] . "_rider_user` where type = 1)";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[$row["userid"]] = $row;
  }

  return $list;
}

function totime($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    if (!$time) {
      $time = time();
    }
  }
  else {
    $time = time();
  }
  return $time;
}

function checkUser($userId) {
  global $db, $db_config;

  $sql = "select * from `" .  $db_config["prefix"] . "_users` where userid = $userId";
  $query = $db->query($sql);

  if ($user = $query->fetch()) {
    return $user;
  }
  return 0;
}

function checkLimit($userid, $time, $type) {
  global $db, $db_config;

  $sql = 'select count(*) as row from `'. PREFIX .'_row` where time = '. $time .' and type = '. $type .' and user_id not in (select user_id from `'. $db_config['prefix'] .'_rider_user` where type = 1 and except = 1)';
  $query = $db->query($sql);
  $row = $query->fetch();
  if ($row['row'] > 2) {
    return 0;
  }
  return 1;
}

function deuft8($str) {
  $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", "a", $str);
  $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", "e", $str);
  $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", "i", $str);
  $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", "o", $str);
  $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", "u", $str);
  $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", "y", $str);
  $str = preg_replace("/(đ)/", "d", $str);
  $str = preg_replace("/(À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)/", "A", $str);
  $str = preg_replace("/(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)/", "E", $str);
  $str = preg_replace("/(Ì|Í|Ị|Ỉ|Ĩ)/", "I", $str);
  $str = preg_replace("/(Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)/", "O", $str);
  $str = preg_replace("/(Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)/", "U", $str);
  $str = preg_replace("/(Ỳ|Ý|Ỵ|Ỷ|Ỹ)/", "Y", $str);
  $str = preg_replace("/(Đ)/", "D", $str);
  $str = mb_strtolower($str);
  //$str = str_replace(" ", "-", str_replace("&*#39;","",$str));
  return $str;
}
