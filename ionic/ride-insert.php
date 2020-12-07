<?php
require_once(NV_ROOTDIR . '/ionic/ride.php');
$ride = new Ride();

$type = parseGetData('type', 0);
if ($type) {
  $data = array(
    'amount' => parseGetData('amount', 0),
    'note' => parseGetData('note', '')
  );

  $sql = "insert into `" . $ride->prefix . "` (type, driver_id, doctor_id, customer_id, amount, clock_from, clock_to, destination, note, time) values (1, $userid, 0, 0, $data[amount], 0, 0, '', '$data[note]', " . time() . ")";
}
else {
  $data = array(
    'doctorid' => parseGetData('doctorid', ''),
    'from' => parseGetData('from', ''),
    'end' => parseGetData('end', ''),
    'amount' => parseGetData('amount', 0),
    'destination' => parseGetData('destination', ''),
    'note' => parseGetData('note', '')
  );

  $sql = "insert into `" . $ride->prefix . "` (type, driver_id, doctor_id, customer_id, amount, clock_from, clock_to, price, destination, note, time) values (0, $userid, $data[driverid], 0, 0, $data[start], $data[end], '$data[amount]', '$data[destination]', '$data[note]', " . time() . ")";
}

$ride->db->query($sql);
$result['status'] = 1;

