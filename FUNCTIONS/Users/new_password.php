<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
require_once('../PHPMailer/PHPMailerAutoload.php');

function random_string(){
    $character_set_array = array();
    $character_set_array[] = array('count' => 6, 'characters' => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
    $character_set_array[] = array('count' => 6, 'characters' => '123456789');
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
$_POST['random_string'] = md5($random_string);
$data=array();
foreach($_POST as $k=>$v){
  $data[$k] = $v;
}

$class = new Users($data);
$data = $class->new_password($data);

header("HTTP/1.0 400 No Email Found");
if($data['status']==true){

  $mail = new PHPMailer;
  $mail->isSMTP();                          
  $mail->Host = 'smtp.gmail.com';                       
  $mail->SMTPAuth = true;                              
  $mail->Username = 'dwinergina@gmail.com';                
  $mail->Password = 'ergina11'; 
  $mail->SMTPSecure = 'tls';                           
  $mail->Port = 587;                               
  $mail->setFrom('bunnypos@gmail.com', 'Bunny');
  $mail->addAddress($_POST['email'],'User');      
  $mail->isHTML(true);


  $mail->Subject = 'Bunny New Password';
  $mail->Body    = '<p>Hi,</p><p>Here is your new password</p><p>New Password: '.$random_string.'</p><p>Note: You can change this password later at the top right corner of the navigation bar.</p>';

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