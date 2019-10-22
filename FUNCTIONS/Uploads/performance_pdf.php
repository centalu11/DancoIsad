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
	    $this->SetFont('Arial', 'B', 15); 
		$this->SetFillColor(36, 96, 84); 
		$this->Cell(0, 0, 'Sales Report', 0, 0, 'C'); 
		$this->Image('../../ASSETS/picture/grandpen.png',160,10,35);
	    $this->Ln(5);
	}

	function SetCellMargin($margin){
        // Set cell margin
        $this->cMargin = $margin;
    }
}
	$pdf = new PDF();
		// $pdf-$column_widths = ['50','50','50','50'];
		$pdf->construct();
		$pdf->AddPage('L','Legal');
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetXY(5,50);
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
		$pdf->Cell(40, 10, $v['first_name'].' '.$v['last_name'], 'LTBR', 0, 'L'); 
		$pdf->Cell(65, 10, $v['product_receipt_name'], 'LTBR', 0, 'L');
		$pdf->Cell(36, 10, $v['product_quantity'], 'LTBR', 0, 'L');
		if ($v['product_supplier_price'] == 'undefined') {
			$v['product_supplier_price'] = 0;
		}
		if ($v['product_supplier_price'] == null) {
			$v['product_supplier_price'] = 0;
		}
		if ($v['product_supplier_price'] == '') {
			$v['product_supplier_price'] = 0;
		}
		$pdf->Cell(30, 10, $v['product_supplier_price'].".00", 'LTBR', 0, 'L');
		$pdf->Cell(25, 10, $v['product_retail_price'], 'LTBR', 0, 'L');
		$pdf->Cell(20, 10, $v['discount'], 'LTBR', 0, 'L');
		$pdf->Cell(20, 10, $v['void_count'], 'LTBR', 0, 'L');
		$pdf->Cell(30, 10, $v['product_transaction_number'], 'LTBR', 0, 'L');
		$date1 = date($v['date_created']);
		$date11 = strtotime($date1);
		$date4 = date("M j, Y, g:i a" , $date11);
		$v['product_retail_price'] = (float)$v['product_retail_price'];
		$v['product_quantity'] = (float)$v['product_quantity'];

		$v['tempo_total'] = $v['product_retail_price'] * $v['product_quantity'];
		$v['tempo_total2'] = $v['tempo_total'].$zero;
		$pdf->Cell(48, 10, $date4, 'LTBR', 0, 'L');
		$pdf->Cell(30, 10, $str." ".$v['tempo_total2'], 'LTBR', 0, 'L');
		$pdf->Ln();
	}	
		$pdf->Cell(40, 10, '' , 0, 'L'); 
		$pdf->Cell(60, 10, '' , 0, 'L'); 
		$pdf->Cell(36, 10, '' , 0, 'L'); 
		$pdf->Cell(30, 10, '' , 0, 'L'); 
		$pdf->Cell(25, 10, '' , 0, 'L'); 
		$pdf->Cell(20, 10, '' , 0, 'L'); 
		$pdf->Cell(20, 10, '' , 0, 'L'); 
		$pdf->Cell(30, 10, '' , 0, 'L'); 
		$pdf->Cell(53, 10, 'Grand Total' , 'LTBR', 0, 'L'); 
		$pdf->Cell(30, 10, $str." ".$total, 'LTBR', 0, 'L'); 
		$pdf->Output();
?>