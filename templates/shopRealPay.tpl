<?php
$cuser = $_SESSION['username'];
$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
$xx = 1;
	if(sizeof($_SESSION['cartitems']) < 1) return header("Location: ../cart");

	$MerchantID = 'e62261be-8f62-11e8-9ca6-005056a205be';
	$Amount = $_SESSION['totalR'];
	if($Amount < 5000) $Amount = 5000;

	if(isset($_GET['Authority'])) {
		$Authority = $_GET['Authority'];

		if ($_GET['Status'] == 'OK') {
			$client = new SoapClient('https://www.zarinpal.com/pg/services/WebGate/wsdl', ['encoding' => 'UTF-8']);

			$result = $client->PaymentVerification(
				[
				'MerchantID' => $MerchantID,
				'Authority' => $Authority,
				'Amount' => $Amount,
				]
			);
			if ($result->Status == 100) { $err = 8586; $ref = $result->RefID; }
			else $err = $result->Status;
		}
		else $err = 8585;
	}
	else {
		$Description = 'وسیله نقلیه: ';
		foreach($_SESSION['cartitems'] as $x) {
			$id = $x['ID'];
			$query = $con->prepare("SELECT * FROM `items` WHERE `ID` = '{$id}';");
			$query->execute();
			$dvc = $query->fetch();
			$Description .= $namevehicles[$dvc['Model']] . " - ";
		}
		$Description = substr($Description, 0, -3);
		$CallbackURL = 'https://roleplay.ir/shop/realpay';

		$client = new SoapClient('https://www.zarinpal.com/pg/services/WebGate/wsdl', ['encoding' => 'UTF-8']);

		$result = $client->PaymentRequest(
		[
		'MerchantID' => $MerchantID,
		'Amount' => $Amount,
		'Description' => $Description,
		'CallbackURL' => $CallbackURL,
		]
		);

		if ($result->Status == 100) {
		Header('Location: https://www.zarinpal.com/pg/StartPay/'.$result->Authority.'/ZarinGate');
		} else {
		$err = $result->Status;
		}
	}
	?>

	<div id="contentWrap"><div id="contentBox">
		<div class="pageTitle">
						فروشگاه
				</div>
		<div id="contentMain">
	<div id="contentPage">
		<br> <br><div align="center"> <div class='normalTextBox'><?php 
		switch($err) {
			case -1:
				echo "شما محصولی را جهت خرید انتخاب نکرده اید! به سبد خرید بازخواهید گشت...";
				header("refresh:5;url=../cart");
				break;
			case 101:
				echo "این پرداخت قبلا تائید شده، شما به سبد خرید بازخواهید گشت...";
				header("refresh:5;url=../cart");
				break;
			case 8585:
				echo "درخواست خرید توسط شما لغو و سبد خرید شما خالی شد. شما به سبد خرید بازخواهید گشت...";
				unset($_SESSION['cartitems']);
				header("refresh:5;url=../cart");
				break;
			case 8586:
				echo "خرید شما موفقیت آمیز بود، کد رهگیری: " . $ref . "<br />موقتاً امکان ارائه مستقیم محصول وجود ندارد، جهت دریافت کالای خریداری شده لطفا در بازی از دستور <span dir=ltr>/Report</span> استفاده نمائید.";
				unset($_SESSION['cartitems']);
				header("refresh:60;url=../cart");
				break;
		}
		?>
				</div>
			   </div>
					</div>
				</div>
<?php } if(!$xx) header("Location: /account/login"); ?> 