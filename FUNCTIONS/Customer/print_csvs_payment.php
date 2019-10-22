<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
$data=array();
foreach($_GET as $k=>$v){
	$data[$k] = $v;
}

$filter = array(
	"date_from" => $_GET['date_from'],
	"date_to" => $_GET['date_to'],
	);

$class = new Users();
$data = $class->get_payment_filter($filter);


$count=1;
$header=	'Item/s Bought,Amount of Item/s,Date Initiated';
$body="";

foreach($data['result'] as $k=>$v){
	$date1 = date($v['date_created']);
	$date11 = strtotime($date1);
	$date4 = date("M j Y g:i a" , $date11);
	$body .= 
	$v['productname'].','.
	$v['productamount'].','.
	$date4.','."\n";

	$count++;
}

$filename = "Petty Cash Out Report".date('Ymd_His').".csv";

header ("Content-type: application/octet-stream");
header ("Content-Disposition: attachment; filename=".$filename);
echo $header."\n".$body;

?>