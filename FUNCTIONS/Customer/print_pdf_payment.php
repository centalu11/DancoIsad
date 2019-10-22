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
$data = $class->get_payment_filter($filter);

header("HTTP/1.0 400 No Data Found");

	class PDF extends FPDF
	{
		function construct ($margin) 
		{ 
			$this->SetTopMargin(5); 
			$this->SetLeftMargin(17); 
			$this->SetRightMargin($margin); 
			$this->SetAutoPageBreak(true, $margin); 
		} 

		function Header()
		{
			$this->SetFont('Arial', 'B', 16); 
			$this->SetFillColor(36, 96, 84); 
			$this->Ln(5);
			// $this->Image('../../ASSETS/picture/bunnypos.png',150,-2,50);
			$this->Cell(0, 0, 'Petty Cash Out Report', 0, 0, 'C'); 
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
	$pdf->Cell(65, 5, 'Item/s Bought' , 'LTBR', 0, 'L'); 
	$pdf->Cell(100, 5, 'Amount of Item/s' , 'LTBR', 0, 'L'); 
	$pdf->Cell(100, 5, 'Date Initiated' , 'LTBR', 0, 'L'); 
	$pdf->Ln();
	$count = 0;
	foreach ($data['result'] as $k => $v) { 
		$pdf->Cell(65, 5, $v['productname'], 'LTBR', 0, 'L');
		$pdf->Cell(100, 5,$v['productamount'], 'LTBR', 0, 'L');
		$date1 = date($v['date_created']);
		$date11 = strtotime($date1);
		$date4 = date("M j, Y, g:i a" , $date11);
		$pdf->Cell(100, 5, $date4, 'LTBR', 0, 'L');
		$pdf->Ln();
	}

	$pdf->Output();
	header("HTTP/1.0 200 OK");

// header('Content-Type: application/json');
// print(json_encode($data));
?>