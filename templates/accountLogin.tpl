<?php
if(isset($_SESSION['username'])) header("Location: /account/general");
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	if($_POST['username'] == null || $_POST['password'] == null) $errMsg = "نام کاربری و یا رمزعبور وارد نشده است!";
	else if($_SESSION['captcha']['code'] !== $_POST['captcha']) $errMsg = "کد امنیتی به حروف بزرگ و کوچک حساس است!";
	else
	{
		$username = $_POST['username'];
		$password = strtoupper(md5($_POST['password']));
		$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$username}' AND `Password` = '{$password}' ORDER BY `ID`;");
		$query->execute();
        $xx = 0;
		while($dnn = $query->fetch())
		{
            $xx = 1;
			$_SESSION['username'] = $dnn['Name'];
			$_SESSION['pid'] = $dnn['ID'];
			header("Location: /account/general");
		}
        if(!$xx) $errMsg = "نام کاربری و یا رمزعبور شما اشتباه است.";
	}
}

include("captcha.php");
$_SESSION['captcha'] = simple_php_captcha();
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        حساب کاربری من
    </div>
    <div id="contentMain"><div id="contentPage">
    <div class="subPageTitle pageTitle">
        ورود
    </div>
	<?php if(isset($errMsg)) { ?><div style="text-align: center; width: 300px; margin-left: auto; margin-right: auto;" class="normalTextBox"><?php echo $errMsg ?></div><?php } ?>
        <div class="normalContentBox">
        <form action="" method="post" name="formular" id="formular">
            <table border="0" cellspacing="0" cellpadding="0" width="380" border="0" align="center">
                <tbody><tr>
                    <td width="80">
                        <div class="formLabel">
                            <span class="text">نام کاربری</span>:
                        </div>
                    </td>
                    <td width="300" class="textarea">
                        <input name="username" type="text" class="textarea" id="username" dir=ltr>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="formLabel">
                            <span class="text">رمزعبور</span>:
                        </div>
                    </td>
                    <td><input name="password" type="password" class="textarea" id="password" dir=ltr></td>
                </tr>
                <tr>
                    <td colspan="2" style="padding:12px 0;" align=center>
                        <?php echo '<img src="' . $_SESSION['captcha']['image_src'] . '" alt="CAPTCHA" />'; ?><br /><br />
						<input name="captcha" type="text" class="textarea" id="captcha" minlength=5 maxlength=5 dir=ltr required>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div align="center">
                            <input class="loginButton" name="Login" type="submit" id="Login" value="ورود">
                        </div>
                    </td>
                </tr>
                </tbody></table>
            <div style="margin: 10px 0;">
                <a style="display: block; text-align: center; line-height:18px;" href="/account/recoverPassword">رمزعبور خود را فراموش کرده اید؟</a>
                <a style="display: block; text-align: center; line-height:18px;" href="/account/recoverAccount">به حساب کاربری خود دسترسی ندارید؟</a>
            </div>
        </form>
    </div>            </div>
                </div>
</div></div></div>