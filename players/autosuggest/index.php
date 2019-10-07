<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/includes/config.inc.php');
require_once($_SERVER['DOCUMENT_ROOT'] . '/includes/functions.inc.php');

if(isset($_POST['name']))
{
	$query = $con->prepare("SELECT `Name`, `ID` FROM `users` WHERE `Name` LIKE '%{$_POST['name']}%' ORDER BY `ID`;");
	$query->execute();
	$c = 0;
	$rslt = "[";
	while($dnn = $query->fetch())
	{
		$rslt .= '{"value":"' . $dnn["Name"] . '","data":'. $dnn["ID"] . '},';
	}
	$rslt = substr($rslt, 0, strlen($rslt) - 1);
	$rslt .= "]";
	echo $rslt;
}
else {
	header('Location: /');
}
?>