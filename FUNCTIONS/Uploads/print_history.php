<?php
require_once('../PDF/fpdf.php');
require_once('../connect.php');
require_once('../../CLASSES/Admin.php');

$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}

$class = new Admin($data);
$data = $class->get_accounts_logs($data);

class PDF extends FPDF
{
	function construct ($margin = 10) 
	{ 
		$this->SetTopMargin($margin); 
		$this->SetLeftMargin($margin); 
		$this->SetRightMargin($margin); 
		$this->SetAutoPageBreak(true, $margin); 
	} 

	function Header()
	{
		$currentDate = date("j/n/Y");
		$this->Image('../../ASSETS/picture/grandpen.png',10,5,20);
	    $this->SetFont('Arial', 'B', 13); 
		$this->SetFillColor(36, 96, 84); 
		$this->Cell(89, 0, 'Grand Pen Marketing',10,100, 'C'); 
		$this->Cell(71,9, 'History Logs',10,100,'C');
		$this->Cell(80, 1, 'As of: '.''.$currentDate,10, 10, 'C');
		$this->Cell(72, 10, 'Prepared by: '.''.$v['name'],10, 10, 'C');
	    $this->Ln(3);
	}

	function SetCellMargin($margin){
        // Set cell margin
        $this->cMargin = $margin;
    }
}
	$pdf = new PDF();
		// $pdf-$column_widths = ['50','50','50','50'];
		$w = array(70,70,55);
		$pdf->construct();
		$pdf->AddPage('P','Legal'); 
		$pdf->SetFont('Arial','B',10);
		$pdf->Cell(70, 10, 'Action' , 'LTBR', 0, 'C'); 
		$pdf->Cell(70, 10, 'Committed by' , 'LTBR', 0, 'C'); 
		$pdf->Cell(55, 10, 'Committed Date' , 'LTBR', 0, 'C'); 
		//$pdf->Cell(150, 10, 'Action' , 'LTBR', 0, 'L'); 
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) { 
		$pdf->SetFont('Arial', 'B', 10); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Cell(70, 10, $v['action'], 'LR');
		$pdf->Cell(70, 10, $v['name'], 'LR');
		$pdf->Cell(55, 10, $v['datetime'],  'LR');
		$pdf->Ln();
			}
		$pdf->Cell(array_sum($w),0,'','T');
		$pdf->Output();
?>