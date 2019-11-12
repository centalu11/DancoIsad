<?php
require_once('../PDF/fpdf.php');
require_once('../connect.php');
require_once('../../CLASSES/Admin.php');

$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}


$class = new Admin($data);
$data = $class->get_accounts_logs($data);


$count=1;
$header=	'Action,Committed by, Committed Date';
$body="";
		foreach ($data['result'] as $k => $v) { 
			$body .= $v['action'].','.
					 $v['name'].',',
					 $v['datetime'].','.
		}

$filename = "HISTORY_LOGS".date('Ymd_His').".csv";
header ("Content-type: application/octet-stream");
header ("Content-Disposition: attachment; filename=".$filename);
echo $header."\n".$body;




?>