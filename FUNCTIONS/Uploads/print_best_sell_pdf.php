<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
require_once('../PDF/fpdf.php');
$data=array();
foreach($_GET as $k=>$v){
	$data[$k] = $v;
}

$filter = array(
	"name" => 'All',
	"name2" => 'All',
	"date_from" => $_GET['date_from'],
	"date_to" => $_GET['date_to'],
);

$class = new Users();
$data = $class->get_best_selling($filter);

header("HTTP/1.0 400 No Data Found");
if($data['status']==true){
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
			$this->Cell(0, 0, 'Best Selling Products', 0, 0, 'C'); 
			$this->Ln(5);
		}

		function SetCellMargin($margin){
			$this->cMargin = $margin;
		}
	}
	$pdf = new PDF();
	$pdf->construct();
	$pdf->AddPage('P','A4'); 
	$pdf->SetFont('Arial', 'B', 10); 
	$pdf->Cell(10, 10, 'Top' , 'LTBR', 0, 'L'); 
	$pdf->Cell(130, 10, 'Name of the Product' , 'LTBR', 0, 'L'); 
	$pdf->Cell(60, 10, 'Quantity' , 'LTBR', 0, 'L'); 
	$pdf->Ln();
	$count = 0;
	foreach ($data['result'] as $k => $v) { 
		$count++;
		$pdf->Cell(10, 10,$count , 'LTBR', 0, 'L');
		$pdf->Cell(130, 10, $v['product_name'], 'LTBR', 0, 'L');
		$pdf->Cell(60, 10, $v['sum'], 'LTBR', 0, 'L');
	}

	$pdf->Output();
	header("HTTP/1.0 200 OK");
}

// header('Content-Type: application/json');
// print(json_encode($data));
?>