<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
$class = new Users(
						NULL,
						NULL,
						NULL,
						NULL,
						NULL,
						NULL,
						NULL
					);

$data = $class->logout($_POST);

if($data['status']==true){
	header("HTTP/1.0 200 OK");
}

print(json_encode($data));
?>