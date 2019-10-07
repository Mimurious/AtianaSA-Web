<?php
session_start();
$action = 'supportNew';
if(!isset($_SESSION['pid'])) $action = 'error404';
require_once($_SERVER['DOCUMENT_ROOT'] . "/index.php");
?>