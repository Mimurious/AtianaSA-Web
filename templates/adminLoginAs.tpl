<?php
session_start();
if($dncx['AdminLevel'] != 8) die();
$_SESSION['username'] = $user;
$query = $con->prepare("SELECT `ID` FROM `users` WHERE `Name` = '{$user}' LIMIT 1;");
$query->execute();
$dnn = $query->fetch();
$_SESSION['pid'] = $dnn['ID'];
header("Location: /account/general/");
?>