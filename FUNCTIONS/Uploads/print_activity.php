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
		$this->Cell(0, 0, 'Activity Logs', 0, 0, 'C'); 
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
		$pdf->Cell(40, 10, 'Name' , 'LTBR', 0, 'L'); 
		$pdf->Cell(70, 10, 'Committed by' , 'LTBR', 0, 'L'); 
		$pdf->Cell(80, 10, 'Committed Date' , 'LTBR', 0, 'L'); 
		$pdf->Cell(150, 10, 'Action' , 'LTBR', 0, 'L'); 
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) { 
		$pdf->SetFont('Arial', 'B', 10); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Cell(40, 10, $v['name'], 'LTBR', 0, 'L');
		$pdf->Cell(70, 10, $v['first_name'].' '.$v['last_name'], 'LTBR', 0, 'L');
		$pdf->Cell(80, 10, $v['date_created'], 'LTBR', 0, 'L');
		$pdf->Cell(150, 10, $v['action'], 'LTBR', 0, 'L');
		$pdf->Ln();
			}
		
		$pdf->Output();
?>