<?php
require_once('../PDF/fpdf.php');
require_once('../connect.php');
require_once('../../CLASSES/Admin.php');

$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}


$class = new Admin($data);
$data = $class->get_history_logs($data);


$count=1;
$header=	'Name,Committed by, Committed Date,Action';
$body="";
		foreach ($data['result'] as $k => $v) { 
			$body .= $v['name'].','.
					 $v['first_name'].' '.$v['last_name'].','.
					 $v['date_created'].','.
					 $v['action']."\n";
		}

$filename = "ACTIVITY_LOGS".date('Ymd_His').".csv";
header ("Content-type: application/octet-stream");
header ("Content-Disposition: attachment; filename=".$filename);
echo $header."\n".$body;




?>