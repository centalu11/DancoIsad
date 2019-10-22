<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');

$filter = array(
				"name" => $_GET['user_id'],
				"date_from" => $_GET['date_from'],
				"date_to" => $_GET['date_to'],
	);

if ($filter['name'] == "undefined") {
	$filter['name'] = 'All';
}
if ($filter['date_from'] == "undefined") {
	$filter['date_from'] = undefined;
}
if ($filter['date_to'] == "undefined") {
	$filter['date_to'] = undefined;
}


$class = new Users();
$data = $class->get_reports($filter);
$str = 'Php';
$zero = '.00';

$count=1;
$header=	'#,Cashier Name,Stall Code,Sales Dept,Product Name,Quantity,Supplier Price,Input VAT,Markup Price,Selling Price,Output VAT,Discount,VAT,Voided #,No. Cancelled,Cancelled Amount,Transaction #,Date Tendered,Total,Non-Vat';
$body="";

foreach($data['result'] as $k=>$v){
	// print_r($v);
	if ($v['product_supplier_price'] == 'undefined') {
			$v['product_supplier_price'] = 0;
		}
	if ($v['product_supplier_price'] == null) {
		$v['product_supplier_price'] = 0;
	}
	if ($v['product_supplier_price'] == '') {
		$v['product_supplier_price'] = 0;
	}
	if ($v['cancelled_amount'] == '') {
		$v['cancelled_amount'] = 0;
	}
	if ($v['cancelled_amount'] == null) {
		$v['cancelled_amount'] = 0;
		$can_amnt = 0;
	}
	if ($v['cancelled_amount'] > '0') {
		$can_amnt = 1;
	}
	if ($v['cancelled_amount'] < '0') {
		$can_amnt = 1;
	}
	$date1 = date($v['date_created']);
	$date11 = strtotime($date1);
	$date4 = date("M j Y g:i a" , $date11);
	$v['product_retail_price'] = (float)$v['product_retail_price'];
	$v['product_quantity'] = (float)$v['product_quantity'];
	$v['tempo_total'] = $v['product_retail_price'] * $v['product_quantity'];
	$v['tempo_total'] = $v['tempo_total'].$zero;
	// print_r($data);
	$body .= $count.','.
			$v['first_name'].' '.$v['last_name'].','.
			$v['stall_code'].','.
			$v['sales_dept'].','.
			$v['product_receipt_name'].','.
			$v['product_quantity'].','.
			$v['product_supplier_price'].','.
			$v['input_vat'].','.
			$v['product_retail_price'].','.
			$v['selling_price'].','.
			$v['output_vat'].','.
			$v['discount'].','.
			$v['vat'].','.
			$v['void_count'].','.
			$can_amnt.','.
			$v['cancelled_amount'].','.
			$v['product_transaction_number'].','.
			$date4.','.
			$str." ".$v['tempo_total'].','.
			$str." ".$v['tempo_total']."\n";

	$count++;
}
$footer.='Grand Total'.$str." ".$total."\n";
$filename = "SALESREPORT".date('Ymd_His').".csv";

header ("Content-type: application/octet-stream");
header ("Content-Disposition: attachment; filename=".$filename);
echo $header."\n".$body;

?>