<?php
if(!isset($_SESSION['step'])) $_SESSION['step'] = 1;
$cuser = $_SESSION['username'];
$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
	function timestampdiff($qw,$saw)
	{
		$datetime1 = new DateTime("@$qw");
		$datetime2 = new DateTime("@$saw");
		$interval = $datetime1->diff($datetime2);
		return $interval->format('%i دقیقه و %s ثانیه');
	}
	
	if(isset($_GET['retry'])) {
		if($_SESSION['lasttry'] > time()) {
			$diff = timestampdiff(time(), $_SESSION['lasttry']);
			$errMsg = "برای تلاش مجدد شما باید {$diff} دیگر صبر کنید...";
		}
		else {
			if(!isset($_SESSION['sCode'])) $_SESSION['sCode'] = numberfa(rand(10000, 99999));
			$phone = $_SESSION['phone'];
			$client = new SoapClient("http://37.130.202.188/class/sms/wsdlservice/server.php?wsdl");
			$user = "REMOVED";
			$pass = "REMOVED";
			$fromNum = "+985000125475";
			$toNum = array($phone);
			$pattern_code = "256";
			$input_data = array(
			 "project" => "تغییرات امنیتی در آتیانا: سن آندریاس - زندگی مجازی",
			 "code" => numberfa($_SESSION['sCode'])
			);
			$client->sendPatternSms($fromNum,$toNum,$user,$pass,$pattern_code,$input_data);
			
			$_SESSION['step'] = 2;
		}
	}
}

else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	if($_SESSION['step'] == 1) {
		$_SESSION['phone'] = strtolower($_POST['phone']);
		$cuser = $_SESSION['username'];
		$phone = $_SESSION['phone'];
		
		$_SESSION['lasttry'] = time() + 300;
		if($phone != $dnn['Phone']) {
			$errMsg = "شماره تلفن وارد شده صحیح نیست!";
		}
		else {
			$_SESSION['sCode'] = rand(10000, 99999);
			$client = new SoapClient("http://37.130.202.188/class/sms/wsdlservice/server.php?wsdl");
			$user = "REMOVED";
			$pass = "REMOVED";
			$fromNum = "+98100020400";
			$toNum = array($phone);
			$pattern_code = "256";
			$input_data = array(
			 "project" => "تغییرات امنیتی در آتیانا: سن آندریاس - زندگی مجازی",
			 "code" => numberfa($_SESSION['sCode'])
			);
			$client->sendPatternSms($fromNum,$toNum,$user,$pass,$pattern_code,$input_data);
			
			$_SESSION['step'] = 2;
		}
	}
	else if($_SESSION['step'] == 2) {
		if($_POST['phoneverify'] == $_SESSION['sCode']) {
			$_SESSION['step'] = 3;
		}
		else {
			$errMsg = "خطا! کد وارد شده اشتباه است.";
		}
	}
	else if($_SESSION['step'] == 3) {
		if($_POST['newpass'] == $dnn['Password'])
		{
			$errMsg = "رمز عبور کنونی و جدید شما یکسان است!";
		}
		else {
			$_SESSION['step'] = 4;
		}
	}
}
if(!$dnn['Registred']) header("Location: ../");
$xx = 1;
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle"> حساب کاربری من
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul>
<li class="first"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/general">اطلاعات عمومی</a></li>
<li class="rightMenuItem"></li></ul></li><li class="next"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/achievements">دستاوردها</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/monthlyPlayed">رده بندی ماهانه</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/faction">اقلیت</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/clan">کلن</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/job">شغل</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/vehicles">دارایی</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/mystats">اطلاعات من</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/friends">دوستان</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/referrals">معرفی شدگان</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/moneylog">درآمد</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/namelog">تاریخچه اسم</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/warSuspendLog">تاریخچه مسدودیت رقابت</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/jaillog">تاریخچه زندان</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/mutelog">تاریخچه محرومیت صحبت</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/suspendlog">تاریخچه مسدودیت</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/warnlog">تاریخچه اخطار</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/kicklog">تاریخچه کیک</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/banlog">تاریخچه محرومیت</a></li>
<li class="rightMenuItem"></li></ul></li><li class="active"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/security">امنیت</a></li>
<li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/logins">آخرین ورود</a></li>
<li class="rightMenuItem"></li></ul></li><li class="last"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/shopTransactions">فروشگاه</a></li>
<li class="rightMenuItem"></li></ul>
</ul></div><div id="contentPage">
    <div class="subPageTitle pageTitle">
        امنیت حساب کاربری  </div>
	<form method="post">
    <div id="wrapper">
    برای تغییر رمز عبور و بازگردانی PIN Code حساب خود شما نیاز دارید که توسط شماره تائید شده خود کد دریافت شده را تائید کنید تا هویت شما احراز گردد، سپس اجازه تغییر رمز عبور و بازگردانی PIN Code را خواهید داشت.<br /><br />
	<?php if($_SESSION['step'] == 1) { ?>
    <font color=red>مرحله اول)</font><br />
    شماره تلفن خود را که قبلا وارد کرده اید (<font color=red>بدون صفر و کد کشور</font>) وارد کرده و بر روی دکمه ارسال جهت دریافت کد تائید کلیک کنید:<br /><br /><br />
    <div align="center"><input name="phone" type="text" minlength="10" maxlength="10" class="textarea" id="phone" placeholder="<?php echo substr($dnn['Phone'], 0, 3) . '****' . substr($dnn['Phone'],  -4); ?>" dir=ltr required></div>
    <input class="loginButton" name="Send" type="submit" id="Send" value="ارسال"><br />
	<?php if(isset($errMsg)) { ?><div style="text-align: center; width: 300px; margin-left: auto; margin-right: auto;" class="normalTextBox"><?php echo $errMsg ?></div><?php } ?>
	<br /><br />
	<?php } if($_SESSION['step'] == 2) { ?>
    <font color=red>مرحله دوم)</font><br />
    تلفن همراه خود را بررسی کرده و کد ارسال شده را در این قسمت وارد کنید، سپس بر روی دکمه ثبت کلیک کنید:<br /><br /><br />
    <div align="center"><input name="phoneverify" type="text" class="textarea" id="phoneverify" dir=ltr required></div>
    <input class="loginButton" name="Send" type="submit" id="Send" value="ثبت"><br />
	<?php if(isset($errMsg)) { ?><div style="text-align: center; width: 300px; margin-left: auto; margin-right: auto;" class="normalTextBox"><?php echo $errMsg ?></div><?php } ?>
	<div align=center><a href="/account/security/?retry">کدی دریافت نکردید؟</a></div><br />
	<?php } if($_SESSION['step'] == 3) { ?>
    <font color=red>مرحله سوم)</font><br />
    هویت شما جهت تغییرات امنیتی احراز گردید، هم اکنون میتوانید اقدام به تغییر رمز عبور و بازگردانی PIN Code خود نمایید:<br /><br />
	
	<div align="center">رمزعبور جدید:<br /><input name="newpass" type="text" class="textarea" id="newpass" dir=ltr required></div>
    <input class="loginButton" name="Send" type="submit" id="Send" value="ثبت"><br />
	<?php } if($_SESSION['step'] == 4) {
		$newpass = $_POST['newpass'];
		$queryz = $con->prepare("UPDATE `users` SET `Password` = UPPER(md5('{$newpass}')), `Pin` = '0' WHERE `Name` = '{$cuser}';");
		$queryz->execute();
		unset($_SESSION['step']);
		header("refresh:5;url=../general");
	?>
    <font color=red>تبریک!</font><br />
    رمز عبور شما با موفقیت تغییر پیدا کرد و PIN Code حساب شما غیرفعال شد، تا لحظاتی دیگر به صفحه اصلی منتقل خواهید شد...<br /><?php } ?>
	</form>
                </div>
                </div>
<?php } if(!$xx) header("Location: /account/login"); ?> 
</div></div></div>
