<?php
class Remind {
  public $prefix;
  public $db;
  public function __construct() {
    global $db;
    $this->db = $db;
    $this->prefix = PREFIX . '_salary_remind';
  }

  public function check($name, $type) {
    $sql = 'select * from `'. $this->prefix .'` where name = "'. $name .'" and type = "'. $type .'"';
    $query = $this->db->query($sql);

    if (!empty($remind = $query->fetch())) {
      $sql = 'update `'. $this->prefix .'` set rate = rate + 1 where id = '. $remind['id'];
    }
    else {
      $sql = 'insert into `'. $this->prefix .'` (name, type) values ("'. $name .'", "'. $type .'")';
    }
    $this->db->query($sql);
  }

  public function get_list($type) {
    $list = array();

    $sql = 'select * from `'. $this->prefix .'` ' . (strlen($type) ? ' where type = "'. $type .'"' : '') . ' order by rate, name desc';
    $query = $this->db->query($sql);

    while ($remind = $query->fetch()) {
      $list []= mb_strtolower($remind['name']);
    }
    return $list;
  }
}
