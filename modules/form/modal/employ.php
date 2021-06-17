<?php
class Employ {
  public $prefix;
  public $default;
  public $db;
  public function __construct() {
    global $db;
    $this->db = $db;
    $this->prefix = PREFIX . '_salary_employ';
    $this->default = array(
      'id' => 0,
      'name' => 'Nhân viên không tồn tại'
    );
  }

  public function insert($name) {
    $sql = 'select * from `'. $this->prefix .'` where name = "'. $name .'" limit 1';
    $query = $this->db->query($sql);

    if (empty($query->fetch())) {
      $sql = 'insert into `'. $this->prefix .'` (name) values ("'. $name .'")';
      if ($this->db->query($sql)) {
        return $this->db->lastInsertId();
      }
    }
    return 0; // nhan vien da ton tai
  }

  public function remove($id) {
    $sql = 'delete from `'. $this->prefix .'` where id = '. $id;
    if ($this->db->query($sql)) {
      return 1;
    }
    return 0; // loi
  }

  public function get_list() {
    $list = array();
    $sql = 'select * from `'. $this->prefix .'` order by name desc';
    $query = $this->db->query($sql);

    while ($row = $query->fetch()) {
      $list[$row['id']] = $row['name'];
    }
    return $list;
  }

  public function get_id($id) {
    $sql = 'select * from `'. $this->prefix .'` where id = ' . $id;
    $query = $this->db->query($sql);
    $employ = $query->fetch();
    if (empty($employ)) return $this->default;
    return $employ;
  }
}
