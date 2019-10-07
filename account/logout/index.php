<?php
require_once($_SERVER['DOCUMENT_ROOT'] . "/index.php");
session_destroy();
header("Location: ../../");
?>