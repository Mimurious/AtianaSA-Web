<?php
if($dncx['AdminLevel'] != 8) die();
$queryx = $con->prepare("UPDATE `users` SET `Registred` = 1 WHERE `Name` = '{$user}';");
$queryx->execute();
header("Location: /admin/general/");
?>