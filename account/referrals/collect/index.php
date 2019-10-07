<?php
require_once($_SERVER['DOCUMENT_ROOT'] . "/index.php");

$cuser = $_SESSION['username'];
$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
$query->execute();
while($dnn = $query->fetch())
{
	if($dnn['Status'] == 0) {
		$query2 = $con->prepare("UPDATE `users` SET `Respect` = `Respect` + `ReferralRespect`, `Cash` = `Cash` + `ReferralMoney`, `ReferralRespect` = 0, `ReferralMoney` = 0 WHERE `Name` = '{$cuser}';");
		$query2->execute();
		header("Location: ../");
	}
	else header("Location: ../");
}
?>