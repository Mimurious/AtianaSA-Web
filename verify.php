<?php
require('includes/config.inc.php');
require('includes/functions.inc.php');

$phone = $_GET['phone'];
$queryp = $con->prepare("SELECT COUNT(`ID`) as cnt FROM `users` WHERE `Phone` = '{$phone}';");
$queryp->execute();
$pata = $queryp->fetch();
if($pata['cnt'] > 2) {
	header('HTTP/1.0 403 Forbidden');
	echo "Number exist.";
}
else {
	$sCode = $_GET['code'];
	
	$client = new SoapClient("http://188.0.240.110/class/sms/wsdlservice/server.php?wsdl", ['trace' => true, 'cache_wsdl' => WSDL_CACHE_MEMORY]);
	$user = "######";
	$pass = "#####";
	$fromNum = "+98#####";
	$toNum = array($phone);
	$pattern_code = "344";
	$input_data = array(
	 "sign" => "آتیانا: سن آندریاس - زندگی مجازی",
	 "code" => numberfa($sCode)
	);
	echo $client->sendPatternSms($fromNum, $toNum, $user, $pass, $pattern_code, $input_data);
}
?>
