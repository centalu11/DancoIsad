<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
$data=array();
foreach($_GET as $k=>$v){
	$data[$k] = $v;
}

$filter = array(
	"name" => 'All',
	"name2" => 'All',
	"date_from" => $_GET['date_from'],
	"date_to" => $_GET['date_to'],
);

$class = new Users();
$data = $class->get_best_selling($filter);


	$count=1;
	$header=	'Top,Product Name,Quantity';
	$body="";

foreach($data['result'] as $k=>$v){
	$body .= $count.','.
			$v['product_name'].','.
			$v['sum']."\n";

	$count++;
	}

	$filename = "BESTSELLING".date('Ymd_His').".csv";

	header ("Content-type: application/octet-stream");
	header ("Content-Disposition: attachment; filename=".$filename);
	echo $header."\n".$body;

?>