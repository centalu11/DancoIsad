<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
// print_r($_POST);
$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}

$filter = array(
				"filter" => $_POST['barcode']
	);


$class = new Users();
$data = $class->get_barcode($filter);

header("HTTP/1.0 400 No User Found");
if($data['status']==true){
	header("HTTP/1.0 200 OK");
}

header('Content-Type: application/json');
print(json_encode($data));
?>