<?php
require_once('../PDF/fpdf.php');
require_once('../connect.php');
require_once('../../CLASSES/Users.php');


if ($_GET['exempted'] == 'No') {
	// Not Exempted

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
	$item_size = $_GET['item_size'];
	$x = 60;
	$y = 48;
	$q = 54;
	$w = 57;
	$e = 60;
	$r = 63;
	$t = 66;
	$s = 69;
	$a = 72;
	$b = 13;
	$n = 48;
	$endline = 75;
	$endmessage = 77;
	$endmessage2 = 80;
	$endmessage3 = 83;
	$endmessage4 = 86;
	$endmessage5 = 91;
	$endmessage6 = 94;
	$endmessage7 = 97;
	$endmessage7 = 97;
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
			$this->Image('../../ASSETS/picture/inventogray.png',28,2,30);
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
	$pdf->SetXY(25,16);  
	$pdf->Cell(40, 5, 'Invento Souvenir Central' , 0, 'L'); 
	$pdf->Ln();
	$pdf->SetXY(12,19); 
	$pdf->Cell(10, 5, '2/F Starmall EDSA cor. Shaw Blvd.' , 0, 'L'); 
	$pdf->Ln();
	$pdf->SetXY(20,22);
	$pdf->Cell(10, 5, 'Wack Wack, Mandaluyong City' , 0, 'L'); 
	$pdf->Ln();
	$pdf->SetXY(14,25); 
	$pdf->Cell(10, 5, 'VAT REG TIN#922-515-884-002' , 0, 'L'); 
	$pdf->Ln();
	$pdf->Ln();
	$pdf->SetFont('Arial', 'B', 8); 
	$pdf->Cell(10, 5, 'Cashier:'." ".$user_id_fname." ".$user_id_lname, 0, 'L'); 
	$pdf->Ln();
	$pdf->Cell(10, 2,'-------------------------------------------------------------------------------------------', 0, 'L');
	$pdf->Ln();
	$pdf->Cell(10, 5,$date_time."                                         ".'TN#'.$TI, 0, 'L'); 
	$pdf->Ln();
	$pdf->Cell(10, 1,'-------------------------------------------------------------------------------------------', 0, 'L');
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
			$endmessage += 6;
			$endmessage2 += 6;
			$endmessage3 += 6;
			$endmessage4 += 6;
			$endmessage5 += 7;
			$endmessage6 += 7;
			$endmessage7 += 7;
		};
		$count += 1;
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Ln();
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetXY(5,$n);
		$pdf->Cell(10, 4,$v['product_quantity'], 0, 'L');
		$pdf->SetXY($b,$n);
		if ($v['item_has_size'] == 'f') {
			$pdf->Cell(10, 4, $v['product_receipt_name_2']."   ".$v['item_size_name'], 0, 'L');
		}else{
			$pdf->Cell(10, 4, $v['product_receipt_name_2'], 0, 'L');
		}
		$pdf->SetXY($x,$y);
		$pdf->Cell(10, 4,$v['tempo_total'], 0, 'L');
	}	

	$pdf->Ln();
	$pdf->Ln();
	$pdf->SetXY(5,$q);
	$pdf->Cell(10, 4,$counts, 0, 'L');
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
	$pdf->Cell(10, 4,'VAT_Tax', 0, 'L');
	$pdf->Ln();
	$pdf->SetXY(60,$a);
	$pdf->SetFont('Arial', 'B', 8); 
	$pdf->Cell(10, 4,$vat, 0, 'L');
	$pdf->Ln();
	$pdf->SetXY(0,$endline);
	$pdf->Cell(10, 2,'----------------------------------------------------------------------------------------------', 0, 'L');
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
	$pdf->Cell(10, 4,'you can reach us at invento_central@yahoo.com', 0, 'L');
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
}else{
	// Exempted

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
	$x = 60;
	$y = 48;
	$q = 54;
	$w = 57;
	$e = 60;
	$r = 63;
	$t = 66;
	$s = 69;
	$a = 72;
	$b = 13;
	$n = 48;
	$ve = 75;
	$endline = 78;
	$endmessage = 80;
	$endmessage2 = 83;
	$endmessage3 = 86;
	$endmessage4 = 89;
	$endmessage5 = 94;
	$endmessage6 = 97;
	$endmessage7 = 100;
	$endmessage7 = 100;
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
			$this->Image('../../ASSETS/picture/inventogray.png',28,2,30);
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
	$pdf->SetXY(25,16);  
	$pdf->Cell(40, 5, 'Invento Souvenir Central' , 0, 'L'); 
	$pdf->Ln();
	$pdf->SetXY(12,19); 
	$pdf->Cell(10, 5, '2/F Starmall EDSA cor. Shaw Blvd.' , 0, 'L'); 
	$pdf->Ln();
	$pdf->SetXY(20,22);
	$pdf->Cell(10, 5, 'Wack Wack, Mandaluyong City' , 0, 'L'); 
	$pdf->Ln();
	$pdf->SetXY(14,25); 
	$pdf->Cell(10, 5, 'VAT REG TIN#922-515-884-002' , 0, 'L'); 
	$pdf->Ln();
	$pdf->Ln();
	$pdf->SetFont('Arial', 'B', 8); 
	$pdf->Cell(10, 5, 'Cashier:'." ".$user_id_fname." ".$user_id_lname, 0, 'L'); 
	$pdf->Ln();
	$pdf->Cell(10, 2,'-------------------------------------------------------------------------------------------', 0, 'L');
	$pdf->Ln();
	$pdf->Cell(10, 5,$date_time."                                         ".'TN#'.$TI, 0, 'L'); 
	$pdf->Ln();
	$pdf->Cell(10, 1,'-------------------------------------------------------------------------------------------', 0, 'L');
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
			$ve += 5;
			$endline += 6;
			$endmessage += 6;
			$endmessage2 += 6;
			$endmessage3 += 6;
			$endmessage4 += 6;
			$endmessage5 += 7;
			$endmessage6 += 7;
			$endmessage7 += 7;
		};
		$count += 1;
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetFillColor(36, 96, 84);
		$pdf->Ln();
		$pdf->SetFont('Arial', 'B', 8); 
		$pdf->SetXY(5,$n);
		$pdf->Cell(10, 4,$v['product_quantity'], 0, 'L');
		$pdf->SetXY($b,$n);
		if ($v['item_has_size'] == 't') {
			$pdf->Cell(10, 4, $v['product_receipt_name_2']."    ".$v['item_size_name'], 0, 'L');
		}else{
			$pdf->Cell(10, 4, $v['product_receipt_name_2'], 0, 'L');
		}
		$pdf->SetXY($x,$y);
		$pdf->Cell(10, 4,$v['tempo_total'], 0, 'L');
	}	

	$pdf->Ln();
	$pdf->Ln();
	$pdf->SetXY(5,$q);
	$pdf->Cell(10, 4,$counts, 0, 'L');
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
	$pdf->SetXY(13,$ve);
	$pdf->SetFont('Arial', 'B', 7); 
	$pdf->Cell(10, 4,'VAT_Exempt', 0, 'L');
	$pdf->Ln();
	$pdf->SetXY(60,$ve);
	$pdf->SetFont('Arial', 'B', 7); 
	$pdf->Cell(10, 4,$vat, 0, 'L');
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
	$pdf->Cell(10, 4,'VAT_Tax', 0, 'L');
	$pdf->Ln();
	$pdf->SetXY(60,$a);
	$pdf->SetFont('Arial', 'B', 8); 
	$pdf->Cell(10, 4,$vat, 0, 'L');
	$pdf->Ln();
	$pdf->SetXY(0,$endline);
	$pdf->Cell(10, 2,'----------------------------------------------------------------------------------------------', 0, 'L');
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
	$pdf->Cell(10, 4,'you can reach us at invento_central@yahoo.com', 0, 'L');
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
}
?>