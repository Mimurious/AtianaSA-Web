<?php
if($dncx['AdminLevel'] != 7) die();
	
function get_client_ip() {
	$ipaddress = '';
	if (getenv('HTTP_CLIENT_IP'))
		$ipaddress = getenv('HTTP_CLIENT_IP');
	else if(getenv('HTTP_X_FORWARDED_FOR'))
		$ipaddress = getenv('HTTP_X_FORWARDED_FOR');
	else if(getenv('HTTP_X_FORWARDED'))
		$ipaddress = getenv('HTTP_X_FORWARDED');
	else if(getenv('HTTP_FORWARDED_FOR'))
		$ipaddress = getenv('HTTP_FORWARDED_FOR');
	else if(getenv('HTTP_FORWARDED'))
	   $ipaddress = getenv('HTTP_FORWARDED');
	else if(getenv('REMOTE_ADDR'))
		$ipaddress = getenv('REMOTE_ADDR');
	else
		$ipaddress = 'UNKNOWN';
	return $ipaddress;
}
	
if($_POST['name']) {
	$name = $_POST['name'];
	$pass = strtoupper(md5($_POST['pass']));
	$warns = $_POST['warns'];
	$spouse = $_POST['spouse'];
	$premium = $_POST['premiumaccount'];
	$level = $_POST['level'];
	$respect = $_POST['respect'];
	$hoursplayed = $_POST['hoursplayed'];
	$phonenumber = $_POST['phone'];
	$crimes = $_POST['crimes'];
	$arrests = $_POST['arrests'];
	$wanteddeaths = $_POST['wanteddeaths'];
	$drivinglic = $_POST['drivinglic'];
	$flyinglic = $_POST['flyinglic'];
	$saillic = $_POST['saillic'];
	$gunlic = $_POST['gunlic'];
	$regip = get_client_ip();
	$date = date("d/m/Y H:i");
	$queryx = $con->prepare("INSERT INTO `users`(`Name`, `Password`, `RegIP`, `LastIP`, `Registred`, `Tutorial`, `RegisteredDate`, `Warns`, `Spouse`, `PremiumAccount`, `Level`, `Respect`, `HoursPlayed`, `PhoneNumber`, `Crimes`, `Arrests`, `WantedDeaths`, `DrivingLic`, `FlyingLic`, `SailLic`, `GunLic`) VALUES ('{$name}', '{$pass}', '{$regip}', '{$regip}', 1, 1, '{$date}', {$warns}, '{$spouse}', {$premium}, {$level}, {$respect}, {$hoursplayed}, {$phonenumber}, {$crimes}, {$arrests}, {$wanteddeaths}, {$drivinglic}, {$flyinglic}, {$saillic}, {$gunlic});");
	$queryx->execute();
	
	header("Location: /players/general/{$name}");
}
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
			افزودن یک حساب کاربری جدید
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first  active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/admin/general">حساب های کاربری</a></li></ul>
</div><div id="contentPage">
    <div class="subPageTitle pageTitle">
حساب کاربری جدید    </div>
    <div id="wrapper">
	<?php if($_POST['warns']) { ?><div align="center"><div class='normalTextBox'>تغییرات ثبت شد. جهت بازدید از پروفایل این کاربر <a href="/players/general/<?php echo $name ?>">اینجا</a> کلیک کنید.</div></div><?php } ?>
	<form method="post">
        <div id="skin">
            <img class="skinImg" src="public/img/Skins/0.png" alt="اسکین">
        </div>
        <div class="generalRight">
            <div class="centerbox-outer">
                <div class="centerbox-inner">
                </div>
            </div>
            <table border="0" cellspacing="0" cellpadding="0" class="vTable generalRightTable">
            <tr class="firstRow">
            <td class="headerTd">اسم</td>
				<td>
					 <input type="text" name="name" style="width: 80%; text-align: center;" dir="ltr" required>
				</td>
			</tr>
			<td class="headerTd">رمزعبور</td>
				<td>
					 <input type="password" name="pass" style="width: 80%; text-align: center;" dir="ltr" required>
				</td>
			</tr>
        <tr>
            <td class="headerTd">اخطارها</td>
            <td dir=ltr><input type="text" name="warns" style="width: 20%; text-align: center;" dir="ltr" value=0 required> / 3
                            </td>
        </tr>
        <tr>
            <td class="headerTd">وضعیت تاهل</td>
            <td><input type="text" name="spouse" style="width: 60%; text-align: center;" dir="ltr" value="No-one" required></td>
        </tr>
                <tr class="lastRow">
            <td class="headerTd">پرمیوم</td>
            <td><input type="text" name="premiumaccount" style="width: 20%; text-align: center;" dir="ltr" value=0 required></td>
        </tr>
        </table>
            <div class="playerButtons" style="margin-left:78px;"></div>
    </div>
</div>

<div id="generalTableWrapper">
    <div id="generalTableLeft">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTable">
            <tr>
                <td class="headerTd">سطح</td>
                <td><input type="text" name="level" style="width: 20%; text-align: center;" dir="ltr" value=1 required>                                  </td>
            </tr>
            <tr>
                <td class="headerTd">امتیاز تجربه</td>
                <td dir=ltr><input type="text" name="respect" style="width: 60%; text-align: center;" dir="ltr" value=0 required></td>
            </tr>
            <tr>
                <td class="headerTd">ساعات بازی کرده</td>
                <td><input type="text" name="hoursplayed" style="width: 20%; text-align: center;" dir="ltr" value=0 required>                                    </td>
            </tr>
            <tr>
                <td class="headerTd">ساعات بازی کرده این ماه</td>
                <td>--</td>
            </tr>
                        <tr>
                <td class="headerTd">شماره تلفن</td>
                <td><input type="text" name="phone" style="width: 80%; text-align: center;" dir="ltr" value=1111111 required></td>
            </tr>
        </table>
    </div>

    <div id="generalTableRight">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTable">
            <tr class="firstRow">
                <td class="headerTd">جرایم ثبت شده</td>
                <td><input type="text" name="crimes" style="width: 50%; text-align: center;" dir="ltr" value=0 required></td>
            </tr>
            <tr>
                <td class="headerTd">تعداد دستگیری</td>
                <td><input type="text" name="arrests" style="width: 50%; text-align: center;" dir="ltr" value=0 required></td>
            </tr>
            <tr>
                <td class="headerTd">مرگ هنگام تحت تعقیب</td>
                <td><input type="text" name="wanteddeaths" style="width: 50%; text-align: center;" dir="ltr" value=0 required></td>
            </tr>
                    </table>
    </div>
    </div>
    <div id="licensesWrap">
        <div id="licenses">
		<div class="lic" style="background-color: inherit; border: 0;"></div>
            <div class="lic">
                <div class="licIcon carlic"><img src="public/img/carlic.png" alt="license"/></div>
                <div id="licText">
                    مجوز رانندگی<br/>
                    <input type="text" name="drivinglic" style="width: 60%; text-align: center;" dir="ltr" value=0 required></div>
            </div>
            <div class="lic">
                <div class="licIcon flylic"><img src="public/img/flylic.png" alt="license"/></div>
                <div id="licText">
                    مجوز پرواز<br/>
                    <input type="text" name="flyinglic" style="width: 60%; text-align: center;" dir="ltr" value=0 required>                                    </div>
            </div>
            <div class="lic">
                <div class="licIcon boatlic"><img src="public/img/boatlic.png" alt="license"/></div>
                <div id="licText">
                    مجوز قایق‌رانی<br/>
                    <input type="text" name="saillic" style="width: 60%; text-align: center;" dir="ltr" value=0 required>                                    </div>
            </div>
            <div class="lic">
                <div class="licIcon gunlic"><img src="public/img/gunlic.png" alt="license"/></div>
                <div id="licText">
                    مجوز اسلحه<br/>
                    <input type="text" name="gunlic" style="width: 60%; text-align: center;" dir="ltr" value=0 required>                                   </div>
            </div>
        </div>
    </div>            
	<input type="submit" class="normalButton" style="float: left; font-family: Vazir" value="ثبت">
	</div>
                </div>
				</div></div></div>