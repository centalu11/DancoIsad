<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
require_once('../PHPMailer/PHPMailerAutoload.php');
// print_r($_POST);
$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}

$class = new Users($data);
$data = $class->send_remarks($data);

header("HTTP/1.0 500 Internal Server Error");
if($data['status']==true){
	header("HTTP/1.0 200 OK");

	$mail = new PHPMailer;

	//$mail->SMTPDebug = 3;                               // Enable verbose debug output
	$mail->isSMTP();                                      // Set mailer to use SMTP
	$mail->Host = 'smtp.gmail.com';                       // Specify main and backup SMTP servers
	$mail->SMTPAuth = true;                               // Enable SMTP authentication
	$mail->Username = 'trueshot18@gmail.com';                
	$mail->Password = 'nicogarcia18'; 
	$mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
	$mail->Port = 587;                                    // TCP port to connect to

	$mail->setFrom('gosaricare@chrsglobal.com', 'GoSari');
	$mail->addAddress($_POST['email']);     // Add a recipient
	//$mail->addReplyTo('info@example.com', 'Information');
	$mail->addBCC('');

	$mail->addAttachment($receiptfile);        
	// Add attachments
	//$mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
	$mail->isHTML(true);                                  // Set email format to HTML

	$mail->Subject = 'GoSari Product Order Request';
	$mail->Body    = $_POST['message'];

	if(!$mail->send()) {
		
	} else {
	} 
}

header('Content-Type: application/json');
print(json_encode($data));
?>