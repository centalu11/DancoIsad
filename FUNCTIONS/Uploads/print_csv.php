<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');

$filter = array(
				"wildcard" => $_GET['wildcard'],
				"wildcard2" => $_GET['wildcard2'],
				"wildcard3" => $_GET['wildcard3']
);

if ($filter['wildcard'] == 'undefined') {
	$filter['wildcard'] = undefined;
}
if ($filter['wildcard2'] == 'undefined') {
	$filter['wildcard2'] = undefined;
}
if ($filter['wildcard3'] == 'undefined') {
	$filter['wildcard3'] = undefined;
}

$class = new Users();
$data = $class->get_product_data_search($filter);
$str = 'Php';
$zero = '.00';

$count=1;
$header=	'#,Product Name,Product Quantity,Retail Price';
$body="";
foreach($data['result'] as $k=>$v){

	if ($v['product_price'] == 'undefined') {
		$v['product_price'] = 0;
	}
	if ($v['product_price'] == null) {
		$v['product_price'] = 0;
	}
	if ($v['product_price'] == '') {
		$v['product_price'] = 0;
	}
	$body .= $count.','.
			$v['product_name'].','.
			$v['product_stocks'].','.
			$v['product_price'].','."\n";

	$count++;
}


$filename = "PRODUCTLIST".date('Ymd_His').".csv";

header ("Content-type: application/octet-stream");
header ("Content-Disposition: attachment; filename=".$filename);
echo $header."\n".$body;

?>