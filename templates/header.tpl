<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>آتیانا: سن آندریاس - زندگی مجازی | 
	<?php
	if($action == "accountFriends") echo "دوستان من";
	else if($action == "accountGeneral") echo "اطلاعات کاربری من";
	else if($action == "accountJob") echo "شغل‌‌های من";
	else if($action == "accountLogin") echo "ورود به حساب کاربری";
	else if($action == "accountRegister") echo "ساخت حساب کاربری جدید";
	else if($action == "accountVerify") echo "تائید حساب کاربری";
	else if($action == "accountrecoverPassword") echo "فراموشی رمزعبور";
	else if($action == "accountrecoverAccount") echo "بازیابی حساب کاربری";
	else if($action == "accountFaction") echo "اقلیت من";
	else if($action == "accountSecurity") echo "امنیت من";
	else if($action == "accountReferrals") echo "معرفی‌شدگان من";
	
	else if($action == "clans") echo "کلن‌ها";
	else if($action == "clansMembers") echo "اعضای کلن " . $fac;
	else if($action == "clansView") echo "اطلاعات کلن " . $fac;
	
	else if($action == "departmentRules") echo "قوانین دپارتمان‌ها";
	else if($action == "factions") echo "اقلیت‌ها";
	else if($action == "factionsMembers") echo "اعضای اقلیت " . $factions[array_search($fac, $factionA)];
	else if($action == "factionsView") echo "اطلاعات اقلیت " . $factions[array_search($fac, $factionA)];
	else if($action == "factionsApply") echo "درخواست عضویت در اقلیت " . $factions[array_search($fac, $factionA)];
	else if($action == "factionsApps") echo "درخواست‌های عضویت اقلیت " . $factions[array_search($fac, $factionA)];
	else if($action == "factionsApps") echo "درخواست عضویت #" . $fac;
	else if($action == "gangRules") echo "قوانین گنگ‌ها";
	else if($action == "mixtRules") echo "قوانین اقلیت‌های مشترک";
	else if($action == "peacefulRules") echo "قوانین اقلیت‌های ملایم";
	
	else if($action == "playersaddReport") echo "گزارش دادن " . $user;
	else if($action == "playersFriends") echo "دوستان " . $user;
	else if($action == "playersFaction") echo "اقلیت " . $user;
	else if($action == "playersJob") echo "شغل‌های " . $user;
	else if($action == "playersGeneral") echo "اطلاعات عمومی ". $user;
	else if($action == "playersOnline") echo "بازیکنان آنلاین";
	else if($action == "playersReport") echo "گزارش #" . $user;
	else if($action == "playersReports") echo "شکایات از اعضا";
	else if($action == "playersSearch") echo "جستجوی بازیکن";
	
	else if($action == "serverRules") echo "قوانین و مقررات سرور";
	
	else if($action == "eventsList") echo "لیست رویدادها";
	else if($action == "eventsInfo") echo "اطلاعات رویداد #" . $user;
	
	else if($action == "shopAddCart") echo "افزودن به سبد خرید";
	else if($action == "shopCart") echo "سبد خرید";
	else if($action == "shopVehicles") echo "فروشگاه - وسایل نقلیه";
	else if($action == "shopVehiclesCars") echo "فروشگاه - وسایل نقلیه: خودرو";
	else if($action == "shopVehiclesBikes") echo "فروشگاه - وسایل نقلیه: موتور و دوچرخه";
	else if($action == "shopVehiclesBoats") echo "فروشگاه - وسایل نقلیه: قایق و کشتی";
	else if($action == "shopVehiclesPlanes") echo "فروشگاه - وسایل نقلیه: هواپیما و هلیکوپتر";
	
	else if($action == "staffAdmins") echo "کارکنان - مدیران";
	else if($action == "staffexAdmins") echo "کارکنان - مدیران بازنشسته";
	else if($action == "staffexHelpers") echo "کارکنان - کمک‌یاران بازنشسته";
	else if($action == "staffexLeaders") echo "کارکنان - راهبران اقلیت بازنشسته";
	else if($action == "staffHelpers") echo "کارکنان - کمک‌یاران";
	else if($action == "staffLeaders") echo "کارکنان - راهبران اقلیت";
	
	else if($action == "updatesServer") echo "بروزرسانی‌های سرور";
	else if($action == "updatesWebsite") echo "بروزرسانی‌های کنترل پنل";
	
	else if($action == "warsTurfs") echo "مناطق رقابتی";
	else if($action == "warsZone") echo "منطقه رقابتی #" . $user;
	
	else if($action == "supportGeneral") echo "پشتیبانی";
	else if($action == "warsZone") echo "درخواست پشتیبانی #" . $user;
	else if($action == "supportNew") echo "درخواست پشتیبانی جدید";
	
	else if($action == "error404") echo "عدم دسترسی - 403";
	else echo "کنترل پنل کاربری";
	?></title>
	<base href="<?php echo (isset($_SERVER["HTTPS"]) ? 'https' : 'http') . "://" . $_SERVER['SERVER_NAME']; ?>">
	

    <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
    <link rel="manifest" href="/site.webmanifest">
    <meta name="msapplication-TileColor" content="#000000">
	<meta name="theme-color" content="#ee0819">
	<meta name="msapplication-navbutton-color" content="#ee0819">
	<meta name="apple-mobile-web-app-status-bar-style" content="#ee0819">

    <link href="public/jQueryUI/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
	<link href="public/MagnificPopup/magnific-popup.css" rel="stylesheet" type="text/css"/>
	<link href="public/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="public/bootstrap/css/bootstrap.rtl.css" rel="stylesheet" type="text/css"/>
	<link href="public/css/style.css?<?php echo filemtime($_SERVER['DOCUMENT_ROOT'] . "/public/css/style.css") ?>" rel="stylesheet" type="text/css"/>
	
    <link href="public/css/tooltipster/tooltipster.bundle.css" rel="stylesheet" type="text/css"/>
	<link href="public/css/tooltipster/plugins/tooltipster-follower.min.css" rel="stylesheet" type="text/css"/>
	<link href="public/css/tooltipster/tooltipster-custom.css" rel="stylesheet" type="text/css"/>
	
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	
	<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
	<script type="text/javascript" src="public/js/jquery.autoSuggest.js" defer></script>
	<script type="text/javascript" src="public/js/bootbox.js" defer></script>
	<script type="text/javascript" src="public/js/jquery.scrollTo-1.4.3.1-min.js" defer></script>
	<script type="text/javascript" src="public/js/jquery.cookie.js" defer></script>
	<script type="text/javascript" src="public/jQueryUI/jquery-ui.min.js" defer></script>
	<script type="text/javascript" src="public/js/jquery.switchButton.js" defer></script>
	<script type="text/javascript" src="public/bootstrap/js/bootstrap.min.js" defer></script>
	<script type="text/javascript" src="public/js/jquery-datetimepicker.js" defer></script>
	<script type="text/javascript" src="public/js/sorttable.js" defer></script>
	<script type="text/javascript" src="public/MagnificPopup/magnificPopup.min.js" defer></script>
	<script type="text/javascript" src="public/js/tooltipster/tooltipster.bundle.min.js" defer></script>
	<script type="text/javascript" src="public/js/toolBox.js" defer></script>
	<script type="text/javascript" src="public/js/tooltipster/plugins/tooltipster-follower.min.js" defer></script>

	<script defer>
		$(document).ready(function() {
			$('.tooltipstered').tooltipster({
				contentAsHTML: true,
				interactive: true,
				position: 'top-left',
				relative: true,
				delay: 300,
				plugins: ['follower'],
				theme: ['tooltipster-noir', 'tooltipster-noir-customized'],
			});

		});
	</script>
	<!--BEGIN RAYCHAT CODE--> <script type="text/javascript">!function(){function t(){var t=document.createElement("script");t.type="text/javascript",t.async=!0,localStorage.getItem("rayToken")?t.src="https://app.raychat.io/scripts/js/"+o+"?rid="+localStorage.getItem("rayToken")+"&href="+window.location.href:t.src="https://app.raychat.io/scripts/js/"+o;var e=document.getElementsByTagName("script")[0];e.parentNode.insertBefore(t,e)}var e=document,a=window,o="ee724ad0-6968-4eab-9206-83f62b24cd66";"complete"==e.readyState?t():a.attachEvent?a.attachEvent("onload",t):a.addEventListener("load",t,!1)}();</script> <!--END RAYCHAT CODE-->
</head>
<body>
<?php
 $user_ip = getenv('REMOTE_ADDR');
 $geo = json_decode(file_get_contents("http://extreme-ip-lookup.com/json/$user_ip"));
 $isp = $geo->isp;
 if($geo->countryCode == "IR") $irr = true;
 else $irr = false;
 
 if($irr) echo "<div class=box-bar><span class=message>شما در حال استفاده از خدمات اینترنت {$isp} هستید و ترافیک مصرفی شما در این وبسایت و بازی به صورت نیم بها محاسبه خواهد شد!</span></div>";
?>
<div style="position: fixed;top: 20%;left: 0;z-index: 99999;">
    <a href="https://t.me/AtianaSA" target="_blank">
        <img src="https://atiana.ir/telegram-side.png"></a>
</div>
<?php if(!isset($_SESSION['username'])) { ?>
<div style="position: fixed;top: 40%;left: 0;z-index: 99999;">
    <a href="https://atiana.ir/playasa" target="_blank">
        <img src="https://atiana.ir/atianasa-side.png"></a>
</div>
<?php } ?>
    <div id="header">
        <div id="headerContentBg" style="background-image: url(public/img/actual<?php echo rand(1, 2); ?>.png);"><div id="headerContentHov"></div></div>
		<div id="headerTopWrap">
            <div id="headerTopContentWrap">
                <div id="headerTopContent">
                    <div id="menu">
                        <ul class="topMenu">
                            <li><a href="/">خانه</a></li>
                            <li><a href="/server/serverRules" style="color:#F00;">قوانین و مقررات</a></li>
                            <li><a href="/players">بازیکنان</a></li>
                            <li><a href="/staff">کارکنان</a></li>
                            <li><a href="/factions">اقلیت‌ها</a></li>
                            <li><a href="/wars">رقابت‌ها</a></li>
                            <li><a href="/clans">کلن‌ها</a></li>
							<li><a href="/events">رویدادها</a></li>
                            <li>
                                <a href="/updates">
                                    بروزرسانی‌ها <span class="new">جدید</span>
                                </a>
                            </li>
							<?php if(isset($_SESSION['username'])) { ?><li>
                                <a href="/support">
                                    پشتیبانی
                                </a>
                            </li><?php } ?>
                        </ul>
                    </div>
                    <div id="userHeader">
                        <?php if(!isset($_SESSION['username'])) { ?>
						<ul>
                            <li><a href="/account/login"><img src="public/img/login.png"/> ورود</a></li>
                            <li><a href="/account/register"><img src="public/img/regb.jpg"/> ثبت نام</a></li>
                        </ul>
						<?php } else {
						$cuser = $_SESSION['username'];
						$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
						$query->execute();
						$dncx = $query->fetch();
						?>
						<ul>
								<li id="profileImg"><a href="/account"><img class="userPhoto" src="public/img/Skins/thumb/<?php echo $dncx['Skin'] ?>.png" alt="profile"></a></li>
								<li id="profileName"><a href="/account"><?php echo $dncx['Name'] ?></a></li>						
								<?php if($dncx['AdminLevel'] > 1) { ?><li id="adminPage"><a href="/admin">کنترل پنل مدیریت</a></li><?php } ?>
								<li id="profileSignOut"><a href="/account/logout">خروج</a></li>
						</ul>
						<?php } ?>
                    </div>
            </div>
        </div>
		<div id="headerContentWrap"><a href="/"><div id="logo"></div></a></div>
    </div>
</div></div></div>
<div id="bannerWrap">
            <div id="bannerContent" style="background: rgba(41, 41, 41, 0.9); border: 1px solid rgba(95, 95, 95, 0.9);">
                <p style="text-align:center"><span style="color:red">توجه:</span> <span style="color:#FFFFFF"><strong>بازی به صورت محدود مجدداً در دسترس قرار گرفته است، همچنین محدودیت تعداد بازیکنان به <?php echo numberfa("150"); ?> نفر نیز موقتاً بر قرار است.</strong><br /><strong>تمامی افرادی که در اقلیت‌ها بودند نیز از آنها خارج شده و قوانین اقلیت‌ها و چگونگی ورود به آنها در دست بازنگری می‌باشد.</strong></p>
            </div>
        </div>