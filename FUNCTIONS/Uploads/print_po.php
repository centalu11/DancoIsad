<?php
require_once('../PDF/fpdf.php');
require_once('../connect.php');
require_once('../../CLASSES/Users.php');

$filter = array(
				"date_from" => $_GET['date_from'],
				"date_to" => $_GET['date_to']
);

$class = new Users();
$data = $class->get_request_order_data($filter);

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
		$this->Cell(0, 0, 'Product Order', 0, 0, 'C'); 
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
		$pdf->Cell(40, 10, 'Date Requested' , 'LTBR', 0, 'L'); 
		$pdf->Cell(100, 10, 'Date Needed' , 'LTBR', 0, 'L'); 
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) { 
			
				$pdf->SetFont('Arial', 'B', 10); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Cell(190, 10, $v['product_name'], 'LTBR', 0, 'L');
		$pdf->Cell(40, 10, $v['product_quantity'], 'LTBR', 0, 'L');
		if ($v['product_market_price'] == 'undefined') {
			$v['product_market_price'] = 0;
		}
		if ($v['product_market_price'] == null) {
			$v['product_market_price'] = 0;
		}
		if ($v['product_market_price'] == '') {
			$v['product_market_price'] = 0;
		}
		$pdf->Cell(40, 10, $v['product_market_price'], 'LTBR', 0, 'L');
		$date1 = date($v['date_created']);
		$date2 = strtotime($v['product_date_needed']);
		$date11 = strtotime($date1);
		$date22 = date($date2);
		$date4 = date("M j, Y", $date11);
		$date5 = date("M j, Y", $date22);
		$v['product_retail_price'] = (float)$v['product_retail_price'];
		$v['product_quantity'] = (float)$v['product_quantity'];
		$pdf->Cell(40, 10, $date4, 'LTBR', 0, 'L');
		$pdf->Cell(100, 10, $date5, 'LTBR', 0, 'L');
		$pdf->Ln();
			}
		
		$pdf->Output();
?>