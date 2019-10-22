<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
require_once('../PDF/fpdf.php');
$data=array();
foreach($_GET as $k=>$v){
	$data[$k] = $v;
}

$filter = array(
	"date_from" => $_GET['date_from'],
	"date_to" => $_GET['date_to']
);

$class = new Users();
$data = $class->get_customer_payment_filter($filter);

header("HTTP/1.0 400 No Data Found");

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
			$this->SetFont('Arial', 'B', 16); 
			$this->SetFillColor(36, 96, 84); 
			$this->Ln(5);
			// $this->Image('../../ASSETS/picture/bunnypos.png',150,-2,50);
			$this->Cell(0, 0, 'Customer Balance Payment Report', 0, 0, 'C'); 
			$this->Ln(5);
		}

		function SetCellMargin($margin){
			$this->cMargin = $margin;
		}
	}
	$pdf = new PDF();
	$pdf->construct();
	$pdf->AddPage('L','A4'); 
	$pdf->SetFont('Arial', 'B', 10); 
	$pdf->Cell(65, 5, 'Customer Name/Business Name' , 'LTBR', 0, 'L'); 
	$pdf->Cell(100, 5, 'Transaction Details' , 'LTBR', 0, 'L'); 
	$pdf->Cell(42, 5, 'Transaction Amount' , 'LTBR', 0, 'L'); 
	$pdf->Cell(20, 5, 'Balance' , 'LTBR', 0, 'L'); 
	$pdf->Cell(42, 5, 'Date Tendered' , 'LTBR', 0, 'L'); 
	$pdf->Ln();
	$count = 0;
	foreach ($data['result'] as $k => $v) { 
		$pdf->Cell(65, 5, $v['customer_name'], 'LTBR', 0, 'L');
		$pdf->Cell(100, 5,"Down payment amounted to ".$v['down_payment_amount']." pesos", 'LTBR', 0, 'L');
		$pdf->Cell(42, 5,$v['total'], 'LTBR', 0, 'L');
		$pdf->Cell(20, 5,$v['balance'], 'LTBR', 0, 'L');
		$date1 = date($v['date_created']);
		$date11 = strtotime($date1);
		$date4 = date("M j, Y, g:i a" , $date11);
		$pdf->Cell(42, 5, $date4, 'LTBR', 0, 'L');

		$pdf->Ln();
	}

	$pdf->Output();
	header("HTTP/1.0 200 OK");

// header('Content-Type: application/json');
// print(json_encode($data));
?>