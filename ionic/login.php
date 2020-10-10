<?php
include_once(NV_ROOTDIR . '/ionic/Encryption.php');

$result = array(
    'status' => 0,
    'messenger' => ''
);

$crypt = new NukeViet\Core\Encryption($sitekey);

if (empty($_GET['username'])) $result['messenger'] = 'empty username';
else if (empty($_GET['username'])) $result['messenger'] = 'empty password';
else {
    $username = mb_strtolower($_GET['username']);
    $password = $_GET['password'];
    $sql = 'select * from `pet_users` where LOWER(username) = "'. $username .'"';
    $query = $mysqli->query($sql);
    $user_info = $query->fetch_assoc();
    if (empty($user_info)) $result['messenger'] = 'username not exist';
    else if (!$crypt->validate_password($password, $user_info['password'])) $result['messenger'] = 'incorrect password';
    else {
      $role = checkUserRole($user_info['userid']);
      if ($role) {
        $list = array();
        $sql = 'select a.userid, b.username as username, concat(last_name, " ", first_name) as name from `pet_petwork_employ` a inner join `pet_users` b on a.userid = b.userid';
        $query = $mysqli->query($sql);

        while ($row = $query->fetch_assoc()) {
            $list []= $row;
        }
        $result['employ'] = $list;

        $list = array();
        $sql = 'select a.userid, b.username as username, concat(last_name, " ", first_name) as name from `pet_test_user` a inner join `pet_users` b on a.userid = b.userid and a.except = 1';
        $query = $mysqli->query($sql);

        while ($row = $query->fetch_assoc()) {
            $list []= $row;
        }
        $result['except'] = $list;
        $result['today'] = date('d/m/Y');
      }
        $result['status'] = 1;
        $result['messenger'] = 'login successfully';
        $result['userid'] = $user_info['userid'];
        $result['username'] = $username;
        $result['password'] = $password;
        $result['name'] = (!empty($user_info['last_name']) ? $user_info['last_name'] . ' ': '') . $user_info['first_name'];
        $result['role'] = $role;
    }
}

echo json_encode($result);
die();