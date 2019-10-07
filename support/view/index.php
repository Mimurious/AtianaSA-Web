<?php
session_start();
$user = (isset($_GET['user'])) ? $_GET['user'] : "u";
$action = 'supportView';
if(!isset($_SESSION['username'])) $action = 'error404';
require_once($_SERVER['DOCUMENT_ROOT'] . "/index.php");
?>