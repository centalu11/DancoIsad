<?php
require_once('../PDF/fpdf.php');
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
	    $this->SetFont('Arial', 'B', 10); 
		$this->SetFillColor(36, 96, 84); 
		$this->Cell(0, 0, 'Product List', 0, 0, 'C'); 
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
		$pdf->Cell(190, 10, 'Product Name' , 'LTBR', 0, 'L'); 
		$pdf->Cell(40, 10, 'Product Quantity' , 'LTBR', 0, 'L'); 
		$pdf->Cell(40, 10, 'Supplier Price' , 'LTBR', 0, 'L'); 
		$pdf->Cell(40, 10, 'Retail Price' , 'LTBR', 0, 'L'); 
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) { 
		$pdf->SetFont('Arial', 'B', 10); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Cell(190, 10, $v['product_name'], 'LTBR', 0, 'L');
		$pdf->Cell(40, 10, $v['product_stocks'], 'LTBR', 0, 'L');
		if ($v['product_price'] == 'undefined') {
			$v['product_price'] = 0;
		}
		if ($v['product_price'] == null) {
			$v['product_price'] = 0;
		}
		if ($v['product_price'] == '') {
			$v['product_price'] = 0;
		}
		if ($v['product_supplier'] == 'undefined') {
			$v['product_supplier'] = 0;
		}
		if ($v['product_supplier'] == null) {
			$v['product_supplier'] = 0;
		}
		if ($v['product_supplier'] == '') {
			$v['product_supplier'] = 0;
		}
		$pdf->Cell(40, 10, $v['product_srp'], 'LTBR', 0, 'L');
		$pdf->Cell(40, 10, $v['product_price'], 'LTBR', 0, 'L');
		$v['product_quantity'] = (float)$v['product_quantity'];
		$pdf->Cell(100, 10, $date5, 'LTBR', 0, 'L');
		$pdf->Ln();
			}
		
		$pdf->Output();
?>