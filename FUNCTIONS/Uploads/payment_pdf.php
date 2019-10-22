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
$data = $class->get_payment_data($filter);

$total = $_GET['total'];
$str = 'Php';
$zero = '.00';
class PDF extends FPDF
{
	function construct ($margin = 3) 
	{ 
		$this->SetTopMargin($margin); 
		$this->SetLeftMargin($margin); 
		$this->SetRightMargin($margin); 
		$this->SetAutoPageBreak(true, $margin); 
	} 

	function Header()
	{
	    $this->SetFont('Arial', 'B', 6); 
		$this->SetFillColor(36, 96, 84); 
		$this->Cell(0, 0, 'Sales Report', 0, 0, 'C'); 
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
		$pdf->Cell(28, 8, 'Product Name' , 'LTBR', 0, 'L'); 
		$pdf->Cell(12, 8, 'Product Amount' , 'LTBR', 0, 'L'); 
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) { 
	
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
		$pdf->Cell(17, 8, $v['product_supplier_price'], 'LTBR', 0, 'L');
		$pdf->Cell(15, 8, $v['input_vat'], 'LTBR', 0, 'L');
		$pdf->Cell(16, 8, $v['product_retail_price'], 'LTBR', 0, 'L');
		$pdf->Cell(15, 8, $v['selling_price'], 'LTBR', 0, 'L');
		$pdf->Cell(15, 8, $v['output_vat'], 'LTBR', 0, 'L');
		$pdf->Cell(12, 8, $v['discount'], 'LTBR', 0, 'L');
		$pdf->Cell(13, 8, $v['vat'], 'LTBR', 0, 'L');
		$pdf->Cell(11, 8, $v['void_count'], 'LTBR', 0, 'L');
		$pdf->Cell(16, 8, $can_amnt, 'LTBR', 0, 'L');
		$pdf->Cell(18, 8, $v['cancelled_amount'], 'LTBR', 0, 'L');
		$pdf->Cell(16, 8, $v['product_transaction_number'], 'LTBR', 0, 'L');
		$date1 = date($v['date_created']);
		$date11 = strtotime($date1);
		$date4 = date("M j, Y, g:i a" , $date11);
		$v['product_retail_price'] = (float)$v['product_retail_price'];
		$v['product_quantity'] = (float)$v['product_quantity'];

		$v['tempo_total'] = $v['product_retail_price'] * $v['product_quantity'];
		$v['tempo_total'] = $v['tempo_total'].$zero;
		$pdf->Cell(19, 8, $date4, 'LTBR', 0, 'L');
		$pdf->Cell(18, 8, $str." ".$v['tempo_total'], 'LTBR', 0, 'L');
		$pdf->Cell(18, 8, $str." ".$v['tempo_total'], 'LTBR', 0, 'L');
		$pdf->Ln();
	}	
		$pdf->Cell(35, 8, '' , 0, 'L'); 
		$pdf->Cell(14, 8, '' , 0, 'L'); 
		$pdf->Cell(15, 8, '' , 0, 'L'); 
		$pdf->Cell(65, 8, '' , 0, 'L'); 
		$pdf->Cell(13, 8, '' , 0, 'L'); 
		$pdf->Cell(19, 8, '' , 0, 'L'); 
		$pdf->Cell(18, 8, '' , 0, 'L'); 
		$pdf->Cell(12, 8, '' , 0, 'L'); 
		$pdf->Cell(13, 8, '' , 0, 'L'); 
		$pdf->Cell(12, 8, '' , 0, 'L'); 
		$pdf->Cell(19, 8, '' , 0, 'L'); 
		$pdf->Cell(20, 8, '' , 0, 'L'); 
		$pdf->Cell(18, 8, '' , 0, 'L'); 
		$pdf->Cell(26, 8, '' , 0, 'L'); 
		$pdf->Cell(20, 8, 'Grand Total' , 'LTBR', 0, 'L'); 
		$pdf->Cell(20, 8, $str." ".$total, 'LTBR', 0, 'L'); 
		$pdf->Output();
?>