<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
require_once('../PHPMailer/PHPMailerAutoload.php');

function random_string(){
    $character_set_array = array();
    $character_set_array[] = array('count' => 4, 'characters' => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
    $character_set_array[] = array('count' => 5, 'characters' => '123456789');
    $temp_array = array();
    foreach ($character_set_array as $character_set) {
        for ($i = 0; $i < $character_set['count']; $i++) {
            $temp_array[] = $character_set['characters'][rand(0, strlen($character_set['characters']) - 1)];
        }
    }

    shuffle($temp_array);
    return implode('', $temp_array);
}
$random_string = random_string();
$data=array();
foreach($_POST as $k=>$v){
	$data[$k] = $v;
}

$class = new Users($data);
$data = $class->check_email($data);

header("HTTP/1.0 400 No Email Found");
if($data['status']==true){
	$datas=array();
	foreach ($data['result'] as $key => $value) {
		$datas['random_string'] = $random_string;
		$datas['pk'] = $value['pk'];
	}
	$data['random_string'] = $random_string;
	$classes = new Users($datas);
	$datas = $classes->send_email($datas);
  // print_r($datas);
  $mail = new PHPMailer;
  $mail->isSMTP();                          
  $mail->Host = 'smtp.gmail.com';                       
  $mail->SMTPAuth = true;                              
  $mail->Username = 'gosaricare@gmail.com';                
  $mail->Password = 'User123456!'; 
  $mail->SMTPSecure = 'tls';                           
  $mail->Port = 587;                               
  foreach ($data['result'] as $k => $v) {
    $mail->setFrom('bunnypos@gmail.com', 'Bunny');
    $mail->addAddress($v['email'],'User');      
    $mail->isHTML(true);
  }

  $mail->Subject = 'Bunny Email Verification';
  $mail->Body    = '<p>Hi,</p><p>In order for Bunny to verify your identity please copy and paste the code below to the Bunny User Verification.</p><p>Code: '.$random_string.'</p>';

  if(!$mail->send()) {
    echo "Mailer Error: " . $mail->ErrorInfo;
    header("HTTP/1.0 500 Internal Server Error");
  } else {
    header("HTTP/1.0 200 OK");
  }
}

header('Content-Type: application/json');
print(json_encode($data));
?>