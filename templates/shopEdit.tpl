<?php
unset($_SESSION['cartitems'][$user - 1]);
header("Location: /shop/cart/");
?>