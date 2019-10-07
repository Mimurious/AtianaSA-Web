<?php
session_start();
require_once($_SERVER['DOCUMENT_ROOT'] . '/includes/config.inc.php');
require_once($_SERVER['DOCUMENT_ROOT'] . '/includes/functions.inc.php');

if(isset($_POST['id']))
{
	$query = $con->prepare("SELECT * FROM `reports` WHERE `ID` = '{$_POST['id']}';");
	$query->execute();
	$c = 0;
	$rslt = "[";
	while($dnn = $query->fetch())
	{
		if($dnn['ReportedBy'] == $_SESSION['pid']) {
			$query = $con->prepare("UPDATE `reports` SET `status` = 1, `answerer` = 0, `ATime` = UNIX_TIMESTAMP() WHERE `ID` = '{$_POST['id']}';");
			$query->execute();
			$rslt .= '{"message":"عملیات موفقیت آمیز بود."}';
		}
		else {
			$rslt .= '{"error":"خطا! شما دسترسی ندارید."}';
		}
	}
	$rslt .= "]";
	echo $rslt;
}
else {
	header('Location: /');
}
?>