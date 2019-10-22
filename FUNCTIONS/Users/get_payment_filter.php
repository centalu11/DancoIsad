<?php
require_once('../connect.php');
require_once('../../CLASSES/Admin.php');
// print_r($_POST);
$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}

$filter = array(
				"date_from" => $_POST['productname'],
				"date_to" => $_POST['productamount'],
	);

$class = new Admin();
$data = $class->get_payment_filter($filter);

header("HTTP/1.0 400 No User Found");
if($data['status']==true){
	header("HTTP/1.0 200 OK");
}

header('Content-Type: application/json');
print(json_encode($data));
?>