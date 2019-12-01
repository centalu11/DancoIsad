<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');

$_id = md5('pk');

if(isset($_COOKIE[$_id]) && !empty($_COOKIE[$_id])){
	setcookie($_id, $_COOKIE[$_id], time()+7200000, '/');
}
else{
	header("HTTP/1.0 404 No active session");
	print('No Session Found'); die();
}

$data=array('pk'=>$_COOKIE[$_id]);

$class = new Users($data);
$data = $class->get_user($data);

header("HTTP/1.0 400 No User Found");
if($data['status']==true){
	header("HTTP/1.0 200 OK");
}

header('Content-Type: application/json');
print(json_encode($data));
?>