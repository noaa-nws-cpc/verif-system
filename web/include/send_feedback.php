<?php
ini_set("log_errors", 1);
ini_set("error_log", "/tmp/logfile.txt");

// Get POST vars
$name    = $_POST['name'];
$email   = $_POST['email'];
$message = $_POST['message'];

// Get email address to send feedback to
$settings = parse_ini_file(__DIR__.'/../../etc/verif_server.conf',true);
$feedback_settings = $settings['feedback'];
$to = $feedback_settings['email'];

if ($email)
{
	$from = $email;
}
else
{
	$from = 'anonymous@noaa.gov';
}

// Send an email with the feedback
$headers = "From:$from";
mail($to,'VWT Feedback',$message,$headers);

// error_log("$headers; $to; $message");

?>