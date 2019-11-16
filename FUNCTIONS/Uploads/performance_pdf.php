<?php
require_once('../PDF/fpdf.php');
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

$total = $_GET['total'];
$str = 'Php';
$zero = '.00';
class PDF extends FPDF
{
	function construct ($margin = 5) 
	{ 
		$this->SetTopMargin($margin); 
		$this->SetLeftMargin($margin); 
		$this->SetRightMargin($margin); 
		$this->SetAutoPageBreak(true, $margin); 
	} 

	function Header()
	{
		$currentDate = date("j/n/Y");
		$this->Image('../../ASSETS/picture/grandpen.png',10,2,20);
	    $this->SetFont('Arial', 'B', 12); 
		$this->SetFillColor(36, 96, 84); 
		$this->Cell(98, 0, 'Grand Pen Marketing',10,100, 'C'); 
		$this->Cell(157,9, 'Halcon Street Corner Boni Ave., Mandaluyong City',100,10,'C');
		$this->Cell(80,6, 'Sales Report',10,100,'C');
		$this->Cell(88, 3,	 'As of: '.''.$currentDate,10, 10, 'C');
	    $this->Ln(10);
	}

	function SetCellMargin($margin){
        // Set cell margin
        $this->cMargin = $margin;
    }
}
	$pdf = new PDF();
		// $pdf-$column_widths = ['50','50','50','50'];
		$w=array(40,65,36,30,25,20,20,30,48,30);
		$pdf->construct();
		$pdf->AddPage('L','Legal');
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetXY(5,25);
		$pdf->Cell(40, 10, 'Cashier Name' , 'LTBR', 0, 'L'); 
		$pdf->Cell(65, 10, 'Product Name' , 'LTBR', 0, 'L'); 
		$pdf->Cell(36, 10, 'Product Quantity' , 'LTBR', 0, 'L'); 
		$pdf->Cell(30, 10, 'Supplier Price' , 'LTBR', 0, 'L'); 
		$pdf->Cell(25, 10, 'Retail Price' , 'LTBR', 0, 'L'); 
		$pdf->Cell(20, 10, 'Discount' , 'LTBR', 0, 'L'); 
		$pdf->Cell(20, 10, 'Voided #' , 'LTBR', 0, 'L'); 
		$pdf->Cell(30, 10, 'Transaction #' , 'LTBR', 0, 'L'); 
		$pdf->Cell(48, 10, 'Date Tendered' , 'LTBR', 0, 'L'); 
		$pdf->Cell(30, 10, 'Total' , 'LTBR', 0, 'L'); 
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) { 
		$pdf->SetFont('Arial', 'B', 10); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Cell(40, 10, $v['first_name'].' '.$v['last_name'],  'LR'); 
		$pdf->Cell(65, 10, $v['product_receipt_name'],  'LR');
		$pdf->Cell(36, 10, $v['product_quantity'],  'LR');
		if ($v['product_supplier_price'] == 'undefined') {
			$v['product_supplier_price'] = 0;
		}
		if ($v['product_supplier_price'] == null) {
			$v['product_supplier_price'] = 0;
		}
		if ($v['product_supplier_price'] == '') {
			$v['product_supplier_price'] = 0;
		}
		$pdf->Cell(30, 10, $v['product_supplier_price'].".00",  'LR');
		$pdf->Cell(25, 10, $v['product_retail_price'],  'LR');
		$pdf->Cell(20, 10, $v['discount'], 'LR');
		$pdf->Cell(20, 10, $v['void_count'],  'LR');
		$pdf->Cell(30, 10, $v['product_transaction_number'],  'LR');
		$date1 = date($v['date_created']);
		$date11 = strtotime($date1);
		$date4 = date("M j, Y, g:i a" , $date11);
		$v['product_retail_price'] = (float)$v['product_retail_price'];
		$v['product_quantity'] = (float)$v['product_quantity'];

		$v['tempo_total'] = $v['product_retail_price'] * $v['product_quantity'];
		$v['tempo_total2'] = $v['tempo_total'].$zero;
		$pdf->Cell(48, 10, $date4,  'LR');
		$pdf->Cell(30, 10, $str." ".$v['tempo_total2'], 'LR');
		$pdf->Ln();
	}	
		//$pdf->Cell(array_sum($w),0,'','T');
		$pdf->Cell(40, 10, '' , 0, 'L'); 
		$pdf->Cell(60, 10, '' , 0, 'L'); 
		$pdf->Cell(36, 10, '' , 0, 'L'); 
		$pdf->Cell(30, 10, '' , 0, 'L'); 
		$pdf->Cell(25, 10, '' , 0, 'L'); 
		$pdf->Cell(20, 10, '' , 0, 'L'); 
		$pdf->Cell(20, 10, '' , 0, 'L'); 
		$pdf->Cell(30, 10, '' , 0, 'L'); 
		$pdf->Cell(53, 10, 'Grand Total' , 'LTBR', 0, 'LR'); 
		$pdf->Cell(30, 10, $str." ".$total, 'LTBR', 0, 'LR'); 
		$pdf->Cell(array_sum($w),0,'','T');
		$pdf->Output();

?>