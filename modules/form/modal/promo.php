<?php
include_once(MODAL_PATH . '/remind.php');
class Promo {
  public $remind;
  public $prefix;
  public $db;
  public function __construct() {
    global $db;

    $this->db = $db;
    $this->remind = new Remind();
    $this->prefix = PREFIX .'_salary_promo';
    $this->default = array(
      'id' => 0,
      'employ' => '',
      'last_promo' => 0,
      'next_promo' => 0,
      'note' => '',
      'file' => ''
    );
  }

  // id, employid, note, file, time, next_time
  function insert($data) {
    $time = totime($data['time']);
    $next_time = totime($data['next_time']);
    $this->remind->check($data['name'], 'employ');

    $sql = 'insert into `'. $this->prefix .'` (employ, note, time, next_time, file) values("'. $data['name'] .'", "'. $data['note'] .'", '. $time .', '. $next_time .', "'. $data['file'] .'")';

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  function update($data) {
    $time = totime($data['time']);
    $next_time = totime($data['next_time']);
    $this->remind->check($data['name'], 'employ');
    $this->remind->check($data['formal'], 'formal');

    $sql = 'update `'. $this->prefix .'` set employ = "'. $data['name'] .'", note = "'. $data['note'] .'", time = "'. $time .'", next_time = "'. $next_time .'", file = "'. $data['file'] .'" where id = '. $data['id'];

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  function remove($id) {
    $sql = 'delete from `'. $this->prefix .'` where id = '. $id;

    if ($this->db->query($sql)) return 1;
    return 0;
  }

  public function promo_content() {
    global $filter, $user_info, $user_list;
    $xtpl = new XTemplate("promo-list.tpl", PATH2);

    $xtra = array('employ like "%'. $filter['name'] .'%"');
    $tick = 0;
    if ($filter['timestart']) $tick += 1;
    if ($filter['timeend']) $tick += 2;
    switch ($tick) {
      case 1:
        $filter['timestart'] = totime($filter['timestart']);
        $xtra []= 'time > '. $filter['timestart'];
        break;
      case 2:
        $filter['timeend'] = totime($filter['timeend']);
        $xtra []= 'time < '. $filter['timeend'];
        break;
      case 3:
        $filter['timestart'] = totime($filter['timestart']);
        $filter['timeend'] = totime($filter['timeend']);
        $xtra []= '(time between '. $filter['timestart'] . ' and '. $filter['timeend'] .')';
        break;
    }

    $tick = 0;
    if ($filter['nexttimestart']) $tick += 1;
    if ($filter['nexttimeend']) $tick += 2;
    switch ($tick) {
      case 1:
        $filter['nexttimestart'] = totime($filter['nexttimestart']);
        $xtra []= 'next_time > '. $filter['nexttimestart'];
        break;
      case 2:
        $filter['nexttimeend'] = totime($filter['nexttimeend']);
        $xtra []= 'next_time < '. $filter['nexttimeend'];
        break;
      case 3:
        $filter['nexttimestart'] = totime($filter['nexttimestart']);
        $filter['nexttimeend'] = totime($filter['nexttimeend']);
        $xtra []= '(next_time between '. $filter['nexttimestart'] . ' and '. $filter['nexttimeend'] .')';
        break;
    }

    $sql = 'select count(id) as number from `'. $this->prefix .'` where ' . implode(' and ', $xtra);
    $query = $this->db->query($sql);
    $number = $query->fetch()['number'];

    $time = time();
    $list = array();
    $first_day_of_year = strtotime(date('Y/1/1', $time));
    $last_day_of_year = strtotime(date('Y', $time) + 1 . '/1/1') - 1;

    $sql = 'select id from `'. $this->prefix .'` where ' . implode(' and ', $xtra) .' and (next_time between '. $first_day_of_year .' and '. $last_day_of_year .')  order by next_time';
    $query = $this->db->query($sql);
    while ($row = $query->fetch()) {
      $list []= $row['id'];
    }

    $sql = 'select id from `'. $this->prefix .'` where ' . implode(' and ', $xtra) .' and (next_time not between '. $first_day_of_year .' and '. $last_day_of_year .')  order by next_time desc';
    $query = $this->db->query($sql);
    while ($row = $query->fetch()) {
      $list []= $row['id'];
    }

    $index = ($filter['page'] - 1) * $filter['limit'];
    $last_index = ($index + $filter['limit'] > $number ? $number : $index + $filter['limit']);
    if (in_array($user_info['userid'], $user_list)) $check = true;
    else $check = false;

    for ($i = $index; $i < $last_index; $i++) { 
      $id = $list[$i];
      $promo = $this->get_promo_id($id);
      $xtpl->assign('index', $i + 1);
      $xtpl->assign('id', $promo['id']);
      $xtpl->assign('employ', $promo['employ']);
      $xtpl->assign('last_promo', $this->parse_time($promo['time']));
      $xtpl->assign('next_promo', $this->parse_time($promo['next_time']));
      $xtpl->assign('note', $promo['note']);
      $xtpl->assign('file', $promo['file']);
    //   die("$promo[next_time], $first_day_of_year, $last_day_of_year");
      if (!($promo['next_time'] < $first_day_of_year || $promo['next_time'] > $last_day_of_year)) $xtpl->assign('color', 'red');
      else $xtpl->assign('color', '');

      if (strlen($promo['file'])) $xtpl->parse('main.row.file');
      if ($check) $xtpl->parse('main.row.manager');
      $xtpl->parse('main.row');
    }
    $xtpl->assign('nav', navi_generater($number, $filter['page'], $filter['limit']));
    $xtpl->parse('main');
    return $xtpl->text();
  }

  public function get_promo_id($id) {
    $sql = 'select * from `'. $this->prefix .'` where id = '. $id;
    $query = $this->db->query($sql);
    $salary = $query->fetch();
    if (empty($salary)) return $this->default;
    return $salary;
  }

  // public function history($employid) {
  //   $xtpl = new XTemplate("promo-history.tpl", PATH2);

  //   $list = $this->promo_employ($employid);
  //   $index = 1;
  //   foreach ($list as $promo) {
  //     $xtpl->assign('index', $index++);
  //     $xtpl->assign('id', $promo['id']);
  //     $xtpl->assign('last_promo', $this->parse_time($promo['time']));
  //     $xtpl->assign('next_promo', $this->parse_time($promo['next_time']));
  //     $xtpl->assign('note', $promo['note']);
  //     $xtpl->assign('file', $promo['file']);
  //     if (strlen($promo['file'])) $xtpl->parse('main.row.file');
  //     $xtpl->parse('main.row');
  //   }
  //   $xtpl->parse('main');
  //   return $xtpl->text();
  // }

  // public function promo_employ($employid) {
  //   $sql = 'select * from `'. $this->prefix .'` where employid = '. $employid .' order by id desc';
  //   $query = $this->db->query($sql);

  //   $list = array();
  //   while ($promo = $query->fetch()) {
  //     $list []= $promo;
  //   }
  //   return $list;
  // }

  public function parse_time($time) {
    if (intval($time) > 0) return date('d/m/Y', $time);
    return 'Chưa bổ nhiệm';
  }
}
