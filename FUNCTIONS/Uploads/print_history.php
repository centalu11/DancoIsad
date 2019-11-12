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
	    $this->SetFont('Arial', 'B', 10); 
		$this->SetFillColor(36, 96, 84); 
		$this->Cell(0, 0, 'History Logs', 0, 0, 'C'); 
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
		$pdf->AddPage('P','Legal'); 
		$pdf->Cell(70, 10, 'ACTION' , 'LTBR', 0, 'C'); 
		$pdf->Cell(70, 10, 'Committed by' , 'LTBR', 0, 'C'); 
		$pdf->Cell(55, 10, 'Committed Date' , 'LTBR', 0, 'C'); 
		//$pdf->Cell(150, 10, 'Action' , 'LTBR', 0, 'L'); 
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) { 
		$pdf->SetFont('Arial', 'B', 10); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Cell(70, 10, $v['action'], 'LTBR', 0, 'C');
		$pdf->Cell(70, 10, $v['name'], 'LTBR', 0, 'C');
		$pdf->Cell(55, 10, $v['date_created'], 'LTBR', 0, 'C');
		$pdf->Ln();
			}
		
		$pdf->Output();
?>