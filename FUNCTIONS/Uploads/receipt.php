<?php
require_once('../PDF/fpdf.php');
require_once('../connect.php');
require_once('../../CLASSES/Users.php');

$filter = array(
				"transact_number" => $_GET['TI']
);

$class = new Users();
$data = $class->get_tender_data_receipt($filter);
$total = $_GET['total'];
$user_id_fname = $_GET['user_id_fname'];
$user_id_lname = $_GET['user_id_lname'];
$date_time = $_GET['date_time'];
$TI = $_GET['TI'];
$counts = $_GET['count'];
$net_amnt = $_GET['net_amnt'];
$vat = $_GET['vat'];
$change = $_GET['change'];
$total = $_GET['total'];
$discount = $_GET['discount'];
$cash = $_GET['cash'];
$rname = $_GET['rname'];
if ($_GET['is_walkin'] == 'false') {
	$customerName = $_GET['customer_name'];
	$customerAddress = $_GET['customer_address'];
	$customerTin = $_GET['customer_tin'];
}

$x = 60;
$y = 51;
$q = 54;
$w = 57;
$e = 60;
$r = 63;
$t = 66;
$s = 69;
$a = 72;
$b = 13;
$n = 51;
$endline = 75;
if ($_GET['is_walkin'] == 'false') {
	$customerNameLine = 78;
	$customerAddressLine = 81;
	$customerTinLine = 84;
	$customerDataEndLine = 87;
	$endmessage = 90;
	$endmessage2 = 93;
	$endmessage3 = 96;
	$endmessage4 = 99;
	$endmessage5 = 102;
	$endmessage6 = 105;
	$endmessage7 = 108;
} else {
	$endmessage = 78;
	$endmessage2 = 81;
	$endmessage3 = 84;
	$endmessage4 = 87;
	$endmessage5 = 90;
	$endmessage6 = 93;
	$endmessage7 = 96;	
}
$count = 0;
$str = 'Php';
$heights = 130;

	foreach ($data['result'] as $k => $v) {
		$heights += 5;
	};

class PDF extends FPDF
{
	function construct ($margin = 10,$marginleft = 0) 
	{ 
		$this->SetTopMargin($margin); 
		$this->SetLeftMargin($marginleft); 
		$this->SetRightMargin($margin); 
		$this->SetAutoPageBreak(true, $margin); 
	} 

	function Header()
	{
	    $this->SetFont('Arial', 'B', 10); 
		$this->SetFillColor(36, 96, 84); 
		$this->Image('../../ASSETS/picture/grandpen.png',33,2,14);
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
		$pdf->AddPage('P',array($heights,87));
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetXY(24,16); 
		$pdf->Cell(40, 5, 'Grand Pen Marketing' , 0, 'L'); 
		$pdf->Ln();
		$pdf->SetXY(12,19); 
		$pdf->Cell(10, 5, 'Halcon Street corner Boni Avenue' , 0, 'L'); 
		$pdf->Ln();
		$pdf->SetXY(24,22); 
		$pdf->Cell(10, 5, 'Mandaluyong City' , 0, 'L'); 
		$pdf->Ln();
		$pdf->SetXY(18,25); 
		$pdf->Cell(10, 5, 'VAT REG TIN#147-749-490-000' , 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(12,28); 
		$pdf->Cell(10, 5, 'THIS SERVE AS YOUR SALES INVOICE' , 0, 'L'); 
		$pdf->Ln();
		$pdf->Ln();
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 5, 'Cashier:'." ".$user_id_fname." ".$user_id_lname, 0, 'L'); 
		$pdf->Ln();
		$pdf->Cell(10, 2,'------------------------------------------------------------------------', 0, 'L');
		$pdf->Ln();
		$pdf->Cell(10, 5,$date_time."             ".'OR#'.$TI, 0, 'L'); 
		$pdf->Ln();
		$pdf->Cell(10, 1,'------------------------------------------------------------------------', 0, 'L');
		$pdf->Ln();
		foreach ($data['result'] as $k => $v) {
		if ($count >= 1) {
		$y += 4;
		$n += 4;
		$q += 5;
		$w += 5;
		$e += 5;
		$r += 5;
		$t += 5;
		$s += 5;
		$a += 5;
		$endline += 6;
		$customerNameLine += 7;
		$customerAddressLine += 7;
		$customerTinLine += 7;
		$customerDataEndLine += 7;	
		$endmessage += 8;
		$endmessage2 += 8;
		$endmessage3 += 8;
		$endmessage4 += 8;
		$endmessage5 += 9;
		$endmessage6 += 9;
		$endmessage7 += 9;
		};
		$count += 1;
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Ln();
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetXY(5,$n);
		$pdf->Cell(10, 4,$v['product_quantity'], 0, 'L');
		$pdf->SetXY($b,$n);
		$pdf->Cell(10, 4, $v['product_receipt_name_2']."                      ".$v['product_quantity']." @ " .$v['product_retail_price'].".00", 0, 'L');
		$pdf->SetXY($x,$y);
		$tempo_total_2 = $v['tempo_total'] * $v['product_quantity'];
		$pdf->Cell(10, 4,$tempo_total_2.".00", 0, 'L');
		$valued = (int)$v['product_quantity'];
		$values += $valued;
	}	

		$pdf->Ln();
		$pdf->Ln();
		$pdf->SetXY(5,$q);
		$pdf->Cell(10, 4,$values, 0, 'L');
		$pdf->SetXY(13,$q);
		$pdf->Cell(10, 4,'Item(s)', 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(13,$w);
		$pdf->Cell(10, 4,'Total Due', 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(60,$w);
		$pdf->SetFont('Arial', 'B', 10); 
		$pdf->Cell(10, 4,$total, 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(13,$e);
		$pdf->SetFont('Arial', 'B', 7); 
		$pdf->Cell(10, 4,$rname, 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(60,$e);
		$pdf->SetFont('Arial', 'B', 7); 
		$pdf->Cell(10, 4,$cash, 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(13,$r);
		$pdf->SetFont('Arial', 'B', 7); 
		$pdf->Cell(10, 4,'Change', 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(60,$r);
		$pdf->SetFont('Arial', 'B', 10); 
		$pdf->Cell(10, 4,$change, 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(13,$t);
		$pdf->SetFont('Arial', 'B', 7); 
		$pdf->Cell(10, 4,'VATable', 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(60,$t);
		$pdf->SetFont('Arial', 'B', 7); 
		$pdf->Cell(10, 4,$net_amnt, 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(13,$s);
		$pdf->SetFont('Arial', 'B', 7); 
		$pdf->Cell(10, 4,'Discount', 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(60,$s);
		$pdf->SetFont('Arial', 'B', 7); 
		$pdf->Cell(10, 4,$discount, 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(13,$a);
		$pdf->SetFont('Arial', 'B', 7); 
		$pdf->Cell(10, 4,'VAT 12%', 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(60,$a);
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 4,$vat, 0, 'L');
		$pdf->Ln();
		$pdf->SetXY(0,$endline);
		$pdf->Cell(10, 2,'------------------------------------------------------------------------', 0, 'L');
		if ($_GET['is_walkin'] == 'false') {
			$pdf->Ln();
			$pdf->SetXY(0,$customerNameLine);
			$pdf->Cell(10, 4,'Customer Name: ' . $customerName, 0, 'L');
			$pdf->Ln();
			$pdf->SetXY(0,$customerAddressLine);
			$pdf->Cell(10, 4,'Address: ' . $customerAddress, 0, 'L');
			$pdf->Ln();
			$pdf->SetXY(0,$customerTinLine);
			$pdf->Cell(10, 4,'TIN: ' . $customerTin, 0, 'L');
			$pdf->Ln();
			$pdf->SetXY(0,$customerDataEndLine);
			$pdf->Cell(10, 2,'------------------------------------------------------------------------', 0, 'L');
		}
		$pdf->SetXY(0,$endmessage);
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 4,'THIS SERVES AS AN OFFICIAL RECEIPT', 0, 'L');
		$pdf->SetXY(0,$endmessage2);
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 4,'THANK YOU !', 0, 'L');
		$pdf->SetXY(0,$endmessage3);
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 4,'For comments and suggestions', 0, 'L');
		$pdf->SetXY(0,$endmessage4);
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 4,'you can reach us at grandpenmarketing@gmail.com', 0, 'L');
		$pdf->SetXY(0,$endmessage5);
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 4,'THIS INVOICE / RECEIPT SHALL BE VALID FOR', 0, 'L');
		$pdf->SetXY(0,$endmessage6);
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 4,'FIVE (5) YEARS FROM THE DATE OF THE PERMIT TO', 0, 'L');
		$pdf->SetXY(0,$endmessage7);
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->Cell(10, 4,'USE.', 0, 'L');

		$pdf->Output();
?>