<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
// print_r($_POST);
$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}

$filter = array(
				"date_from" => $_POST['date_from'],
				"date_to" => $_POST['date_to']
	);

$class = new Users();
$data = $class->get_aomos_payment_filter($filter);

header("HTTP/1.0 404 No Data Found");
if($data['status']==true){
	header("HTTP/1.0 200 OK");
}

header('Content-Type: application/json');
print(json_encode($data));
?>