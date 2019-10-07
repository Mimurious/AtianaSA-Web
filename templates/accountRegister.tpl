<?php
if(isset($_SESSION['username'])) header("Location: /account/general");
if($_GET['ref'] && !isset($_SESSION['referral'])) $_SESSION['referral'] = $_GET['ref'];
if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    $ip = $_SERVER['HTTP_CLIENT_IP'];
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
} else {
    $ip = $_SERVER['REMOTE_ADDR'];
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$username = $_POST['username'];
	$queryu = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE `Name` = '{$username}';");
	$queryu->execute();
	$uata = $queryu->fetch();
	if($_POST['username'] == null || $_POST['password'] == null || $_POST['cpassword'] == null || $_POST['sex'] == null || $_POST['lang'] == null || $_POST['birthday'] == null || $_POST['birthmonth'] == null || $_POST['birthyear'] == null) $errMsg = "اطلاعات ثبت نام به صورت کامل پر نشده است!";
	else if($_POST['password'] != $_POST['cpassword']) $errMsg = "رمزعبور و تائید آن مشابه نیستند!";
	else if(strlen($_POST['username']) < 3 || strlen($_POST['username']) > 20) $errMsg = "نام کاربری شما باید بین 3 تا 20 حرف باشد.";
	else if(strlen($_POST['password']) < 1 || strlen($_POST['username']) > 100) $errMsg = "رمز عبور شما باید بین 1 تا 100 کاراکتر باشد.";
	else if(!preg_match("/^[A-Za-z0-9\._\$@=\(\)\[\]]+$/",$_POST['username'])) $errMsg = "نام کاربری قابل قبول نیست.";
	else if (count(explode(' ', $_POST['username'])) > 1) $errMsg = "نام کاربری نمیتواند حاوی فاصله باشد.";
	else if($uata['COUNT(`ID`)'] != 0) $errMsg = "این نام کاربری وجود دارد.";
	else if($_SESSION['captcha']['code'] !== $_POST['captcha']) $errMsg = "کد امنیتی به حروف بزرگ و کوچک حساس است!";
	else
	{
		$username = $_POST['username'];
		$password = strtoupper(md5($_POST['password']));
		$sex = $_POST['sex'];
		$lang = $_POST['lang'];
		$gdate = new DateTime(jalali_to_gregorian($_POST['birthyear'], $_POST['birthmonth'], $_POST['birthday'], "-"));
		$birth = $gdate->format('U');
		$skin = $_COOKIE['skin'];
		unset($_COOKIE['skin']);
		if(!isset($_SESSION['referral'])) $referral = $_POST['registerReferral'];
		else $referral = $_SESSION['referral'];
		$regdate = date('d/m/Y - H:i:s');
		$salt = strtoupper(md5($ip));
		if($referral == null || $referral = "" || !isset($referral)) $referral = 0;
		if($skin == null || $skin == "" || !isset($skin) || $skin == 0) $skin = 1;
		$query = $con->prepare("INSERT INTO `users`(`Name`, `Password`, `Salt`, `Sex`, `Lang`, `BirthDay`, `Skin`, `RegIP`, `Level`, `Cash`, `Account`, `Registred`, `Tutorial`, `Referral`, `RegisteredDate`,`Status`) VALUES ('{$username}', '{$password}', '{$salt}', {$sex}, {$lang}, '{$birth}', '{$skin}', '{$ip}', 1, 100, 250, 0, 0, '{$referral}', '{$regdate}', 0);");
		$query->execute();
		$_SESSION['username'] = $username;
		$_SESSION['pid'] = $con->lastInsertId();
		header("Location: /account/verify");
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
        ثبت نام
    </div>
	<?php if(isset($errMsg)) { ?><div style="text-align: center; width: 300px; margin-left: auto; margin-right: auto;" class="normalTextBox"><?php echo $errMsg ?></div><?php } ?>
        <div class="normalContentBox" align="center">
        <form action="" method="post" name="formular" id="formular">
			<table border="0" cellspacing="0" cellpadding="0" border="0" valign="center" align="center">
			<tbody>
				<tr>
					<td>
						<div id="skin" style="padding-right: 60px;">
							<img class="skinImg" id="skinImg" src="public/img/Skins/1.png">
							<div style="" align="center">
								<a onclick="nextSkin()" style="padding: 8px 16px; background-color: #f1f1f1; border-radius: 50%; margin-left: 30px; user-select: none; cursor: pointer; color: #000;">‹</a>
								<a onclick="previousSkin()" style="padding: 8px 16px; background-color: #f1f1f1; border-radius: 50%; user-select: none; cursor: pointer; color: #000;">›</a>
							</div>
						</div>
					</td>
					<td style="vertical-align: inherit;">
						<table border="0" cellspacing="0" cellpadding="0" width="460" border="0">
							<tbody>
							<tr>
								<td width="120">
									<div class="formLabel">
										<span class="text">نام کاربری</span>:
									</div>
								</td>
								<td width="340" class="textarea">
									<input name="username" type="text" class="textarea" id="username" minlength="3" maxlength="20" dir=ltr required <?php if(isset($_POST['username'])) { ?>value="<?php echo $_POST['username']; ?>"<?php } ?>>
								</td>
							</tr>
							<tr>
								<td>
									<div class="formLabel">
										<span class="text">رمزعبور</span>:
									</div>
								</td>
								<td><input name="password" type="password" class="textarea" id="password" dir=ltr required></td>
							</tr>
							<tr>
								<td>
									<div class="formLabel">
										<span class="text">تائید رمزعبور</span>:
									</div>
								</td>
								<td><input name="cpassword" type="password" class="textarea" id="cpassword" dir=ltr required></td>
							</tr>
							</tbody></table>
							<hr style="width:50%; margin-left:25% !important; margin-right:25% !important;">
							<table border="0" cellspacing="0" cellpadding="0" width="460" border="0">
							<tbody>
							<tr>
								<td width="120">
									<div class="formLabel">
										<span class="text">معرف</span>:
									</div>
								</td>
								<td width="340" class="textarea">
									<?php if($_SESSION['referral']) { ?>
									<input dir=ltr name="refer" type="text" id="searchRefeer" autocomplete="off" value="<?php
									$refid = $_SESSION['referral'];
									$query = $con->prepare("SELECT `Name` FROM `users` WHERE `ID` = '{$refid}' LIMIT 1;");
									$query->execute();
									$snn = $query->fetch();
									echo $snn['Name'];
									?>" disabled>
									<?php
									}
									else {
									?>
									<div class="autosuggestDivContainer">
									<input type="hidden" class="autosuggestHiddenInput" name="registerReferral" id="registerReferral">
		                            <div class="inputSearchSuggestion" id="searchPlayerNameDiv">
		                                <input dir=ltr name="name" type="text" class="autosuggestNormalInput textarea as-input" id="searchRefeer" autocomplete="off"><div class="as-results" id="as-results-searchRefeer" style="display: none;"></div>
		                            </div>
									</div>
		                       		 <?php } ?>
								</td>
							</tr>
							<tr>
								<td width="120">
									<div class="formLabel">
										<span class="text">تاریخ تولد</span>:
									</div>
								</td>
								<td width="340" class="textarea">
									<select name="birthday" id="birthday" style="float:right; width:50px;">
										<option value="1">۱</option>
										<option value="2">۲</option>
										<option value="3">۳</option>
										<option value="4">۴</option>
										<option value="5">۵</option>
										<option value="6">۶</option>
										<option value="7">۷</option>
										<option value="8">۸</option>
										<option value="9">۹</option>
										<option value="10">۱۰</option>
										<option value="11">۱۱</option>
										<option value="12">۱۲</option>
										<option value="13">۱۳</option>
										<option value="14">۱۴</option>
										<option value="15">۱۵</option>
										<option value="16">۱۶</option>
										<option value="17">۱۷</option>
										<option value="18">۱۸</option>
										<option value="19">۱۹</option>
										<option value="20">۲۰</option>
										<option value="21">۲۱</option>
										<option value="22">۲۲</option>
										<option value="23">۲۳</option>
										<option value="24">۲۴</option>
										<option value="25">۲۵</option>
										<option value="26">۲۶</option>
										<option value="27">۲۷</option>
										<option value="28">۲۸</option>
										<option value="29">۲۹</option>
										<option value="30">۳۰</option>
										<option value="31">۳۱</option>
									</select>
									<select name="birthmonth" id="birthmonth" style="margin-right: 20px; float: right; width: 83px;">
										<option value="1">فروردین</option>
										<option value="2">اردیبهشت</option>
										<option value="3">خرداد</option>
										<option value="4">تیر</option>
										<option value="5">مرداد</option>
										<option value="6">شهریور</option>
										<option value="7">مهر</option>
										<option value="8">آبان</option>
										<option value="9">آذر</option>
										<option value="10">دی</option>
										<option value="11">بهمن</option>
										<option value="12">اسفند</option>
									</select>
									<select name="birthyear" id="birthyear" style="margin-right: 20px; width: 75px; padding-left: 5px;">
										<?php for($i = 1395; $i >= 1295; $i--) { ?>
										<option value="<?php echo $i; ?>"><?php echo numberfa($i); ?></option>
										<?php } ?>
									</select>
								</td>
							</tr>
							<tr>
								<td width="120">
									<div class="formLabel">
										<span class="text">جنسیت</span>:
									</div>
								</td>
								<td width="340" class="textarea">
									<input type="radio" id="sexm" name="sex" value="1" checked>
									<label for="sexm" style="display: inline; padding-right: 10px; padding-left: 50px;">مرد</label>

									<input type="radio" id="sexf" name="sex" value="2">
									<label for="sexf" style="display: inline; padding-right: 10px;">زن</label>
								</td>
							</tr>
							<tr>
								<td width="120">
									<div class="formLabel">
										<span class="text">زبان محیط بازی</span>:
									</div>
								</td>
								<td width="340" class="textarea">
									<input type="radio" id="langf" name="lang" value="1" checked>
									<label for="langf" style="display: inline; padding-right: 10px; padding-left: 50px;">فارسی</label>

									<input type="radio" id="lange" name="lang" value="0">
									<label for="lange" style="display: inline; padding-right: 10px;">انگلیسی</label>
								</td>
							</tr>
							</tbody></table>
						</td>
					</tr>
				</table>
				<br />
				<table border="0" cellspacing="0" cellpadding="0" width="460" border="0" align="center">
                <tbody>
				<tr>
                    <td colspan="2" style="padding:12px 0;" align=center>
                        <?php echo '<img src="' . $_SESSION['captcha']['image_src'] . '" alt="CAPTCHA" />'; ?><br /><br />
						<input name="captcha" type="text" class="textarea" id="captcha" minlength=5 maxlength=5 dir=ltr required>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div align="center">
                            <input class="loginButton" name="Register" type="submit" id="Register" value="ثبت نام">
                        </div>
                    </td>
                </tr>
				</tbody></table>
				<br /><p><font color=red>*</font> نشانی اینترنتی شما (<?php echo $ip; ?>) در فرایند ثبت نام برای حساب کاربری شما ثبت خواهد شد.</p>
        </form>
    </div>            </div>
                </div>
				<script type="text/javascript">
				  var skins = new Array(
					1, 4, 5, 7, 10, 13, 21, 22, 129, 159, 160, 168, 170, 196, 197, 200, 212, 213, 218, 222, 230, 231, 232, 239, 250
				  );
				  var image = new Array(
					<?php
					$skins = array(1, 4, 5, 7, 10, 13, 21, 22, 129, 159, 160, 168, 170, 196, 197, 200, 212, 213, 218, 222, 230, 231, 232, 239, 250);
					foreach($skins as $item) echo "\"public/img/Skins/{$item}.png\",";
					?>
					);

					var imgNumber=1;
					createCookie("skin", skins[imgNumber-1], 10);
					var numberOfImg = image.length;

					function previousSkin(){
					  if(imgNumber > 1){
						imgNumber--;
						}

					  else{
						imgNumber = numberOfImg;
						}

					document.getElementById('skinImg').src = image[imgNumber-1];
					createCookie("skin", skins[imgNumber-1], 10);
					  }
					  
					function nextSkin(){
					  if(imgNumber < numberOfImg){
						imgNumber++;
						}

					  else{
						imgNumber = 1;
						}

					document.getElementById('skinImg').src = image[imgNumber-1];
					createCookie("skin", skins[imgNumber-1], 10);
					  }
					  
					  function createCookie(name, value, days) {
						  var expires;
						  if (days) {
							var date = new Date();
							date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
							expires = "; expires=" + date.toGMTString();
						  } else {
						   expires = "";
						  }
						  document.cookie = escape(name) + "=" + escape(value) + expires + "; path=/";
						}
				        $(document).ready(function() {
				            $("#searchRefeer").autoSuggest("/players/autosuggest/");
				        });
				</script>
				</div></div></div>