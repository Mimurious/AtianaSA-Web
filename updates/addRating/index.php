<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/includes/config.inc.php');
require_once($_SERVER['DOCUMENT_ROOT'] . '/includes/functions.inc.php');
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$rate = $_POST['rating'];
	$upi = $_POST['updateId'];
	$query = $con->prepare("UPDATE `updates` SET `score` = ((`score` + {$rate}) / 2) WHERE `id` = {$upi};");
	$query->execute();
	echo '{"message":"امتیاز شما با موفقیت ثبت شد."}';
}
else {
	echo '{"message":"خطا!"}';
}
?>