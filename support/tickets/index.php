<?php
session_start();
$action = 'supportGeneral';
if(!isset($_SESSION['pid'])) $action = 'error404';
require_once($_SERVER['DOCUMENT_ROOT'] . "/index.php");
?>