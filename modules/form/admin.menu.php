<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_ADMIN')) {
    die('Stop!!!');
}

$submenu['locker'] = "Danh sách văn bản";
$submenu['locked'] = "Khóa văn bản";
// $submenu['except'] = "Người ngoại lệ";

$allow_func = array('main', 'locked', 'locker'); 
