<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 12/31/2009 0:51
 */

if (!defined('NV_SYSTEM')) {
    die('Stop!!!');
}

include_once(NV_ROOTDIR . "/modules/". $module_file ."/global.functions.php");

define('NV_IS_MOD_MODULE', true);
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template/user/". $op);
