<?php
try {
	$con = new PDO("mysql:host=localhost;dbname=atiana_sa;charset=utf8", 'atiana_sa', '######');
	$con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
}
catch (PDOException $e)
{
	header("Refresh: 10");
}

date_default_timezone_set("Asia/Tehran");
error_reporting(0);
?>
