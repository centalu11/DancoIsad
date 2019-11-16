<?php
require_once('../PDF/fpdf.php');
require_once('../connect.php');
require_once('../../CLASSES/Admin.php');

$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}


$class = new Admin($data);
$data = $class->get_history_logs($data);

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
	    $this->SetFont('Arial', 'B', 13); 
		$this->SetFillColor(36, 96, 84); 
		$this->Cell(99, 0, 'Grand Pen Marketing',10,100, 'C'); 
		$this->Cell(82,10, 'Activity Logs',10,100,'C');
		$this->Cell(90, 1, 'As of: '.''.$currentDate,10, 10, 'C');
	    $this->Ln(10);
	}

	function SetCellMargin($margin){
        // Set cell margin
        $this->cMargin = $margin;
    }
}
	$pdf = new PDF();
		// $pdf-$column_widths = ['50','50','50','50'];
		$w = array(40, 70, 80, 150);
		$pdf->construct();
		$pdf->AddPage('L','Legal'); 
		$pdf->SetFont('Arial','B',10);
		$pdf->Cell(40, 10, 'Name' ,1, 0, 'L'); 
		$pdf->Cell(70, 10, 'Committed by' ,1,  0, 'L'); 
		$pdf->Cell(80, 10, 'Committed Date' ,1,  0, 'L'); 
		$pdf->Cell(150, 10, 'Action' ,1,  0, 'L'); 
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) { 
		$pdf->SetFont('Arial', 'B', 10); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Cell(40, 10, $v['name'], 'LR');
		$pdf->Cell(70, 10, $v['first_name'].' '.$v['last_name'],  'LR');
		$pdf->Cell(80, 10, $v['date_created'], 'LR');
		$pdf->Cell(150, 10, $v['action'], 'LR');
		$pdf->Ln();
			}
		$pdf->Cell(array_sum($w),0,'','T');
		$pdf->Output();
?>