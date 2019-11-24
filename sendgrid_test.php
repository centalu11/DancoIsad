<?php
require 'vendor/autoload.php'; 

$senderEmail = "grandpen11@gmail.com";
$senderName = "Grand Pen";
$receiverEmail = "centjann@gmail.com";
$receiverName = "Cent Jann";

$from = new \SendGrid\Mail\From($senderEmail, $senderName);
$to = new \SendGrid\Mail\To(
    $receiverEmail,
    $receiverName,
    array(
        'subject' => 'Temporary Password',
        'temp_pass' => 'blahblahblah'
    )
);

$email = new \SendGrid\Mail\Mail(
    $from,
    $to
);

$email->setTemplateId("d-e0d23431dbd94cf7827be0862cf55aa1");
$email->setReplyTo($senderEmail, $senderName);
$sendgrid = new \SendGrid("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");

try {
    $response = $sendgrid->send($email);
    print $response->statusCode() . "\n";
    print_r($response->headers());
    print $response->body() . "\n";
} catch (Exception $e) {
    echo 'Caught exception: '. $e->getMessage() ."\n";
}