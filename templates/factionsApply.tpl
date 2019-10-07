<?php
$cuser = $_SESSION['username'];
$queryp = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
$queryp->execute();
$dnx = $queryp->fetch();
$fid = array_search($fac, $factionA);
$query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = '{$fid}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
if(!$dnn['Opened']) header("Location: ../");
else if(totalFactionMembers($con, $dnn['ID']) >= $dnn['Slot']) header("Location: ../");
else if($dnx['Level'] < $dnn['MinLvl']  || $dnx['Rank'] != 0) header("Location: ../");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	if($_POST['a1'] == null || $_POST['a2'] == null || $_POST['a3'] == null || $_POST['a4'] == null || $_POST['a5'] == null || $_POST['a6'] == null || $_POST['a7'] == null || $_POST['a8'] == null || $_POST['a9'] == null || $_POST['a10'] == null) $errMsg = "تمامی فیلدها اجباری است";
	else {
		$uid = $dnx['ID'];
		$a1 = $_POST['a1'];
		$a2 = $_POST['a2'];
		$a3 = $_POST['a3'];
		$a4 = $_POST['a4'];
		$a5 = $_POST['a5'];
		$a6 = $_POST['a6'];
		$a7 = $_POST['a7'];
		$a8 = $_POST['a8'];
		$a9 = $_POST['a9'];
		$a10 = $_POST['a10'];
		$queryw = $con->prepare("INSERT INTO `applications` (FactionID, Player, Date, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) VALUES ({$fid}, {$uid}, UNIX_TIMESTAMP(), '{$a1}', '{$a2}', '{$a3}', '{$a4}', '{$a5}', '{$a6}', '{$a7}', '{$a8}', '{$a9}', '{$a10}');");
		$queryw->execute();
		$queryw = $con->prepare("SELECT LAST_INSERT_ID() AS `ID`;");
		$queryw->execute();
		$qp = $queryw->fetch();
		$aid = $qp['ID'];
		header("Location: ../application/{$aid}");
	}
}
$xx = 1;
?>
<div id="content">
			<div id="contentWrap"><div id="contentBox">
	<div class="pageTitle">
		اقلیت‌ها
	</div>
	<div id="contentMain">
	<div id="leftSidebar">
		<ul>
			<li class="first">
				<ul>
					<li class="leftMenuItem" />
					<li class="menuItem"><a href="/factions/">اقلیت‌ها</a></li>
					<li class="rightMenuItem" />
				</ul>
			</li>
			<li>
				<ul>
					<li class="leftMenuItem" />
					<li class="menuItem"><a href="/factions/peacefulRules">قوانین اقلیت‌ها</a></li>
					<li class="rightMenuItem" />
				</ul>
			</li>
			
			<?php
			for($x = 0; $x < sizeof($factionCa); $x++)
			{
				if($x == 0) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 4 OR `ID` = 5 OR `ID` = 6 ORDER BY `ID`;");
				else if($x == 1) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 8 OR `ID` = 9 OR `ID` = 10 OR `ID` = 11 ORDER BY `ID`;");
				else if($x == 2) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 1 OR `ID` = 14 OR `ID` = 15 OR `ID` = 2 OR `ID` = 12 OR `ID` = 13 ORDER BY Field(`ID`,1,14,15,2,12,13);");
				else if($x == 3) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 3 OR `ID` = 7 ORDER BY `ID`;");
				$query->execute();
				$c = 0;
				while($dnb = $query->fetch())
				{
				$c++;
			?>
			<li <?php if($fid == $dnb['ID']) echo "class='active'"; ?>>
				<ul>
					<li class="leftMenuItem" />
					<li class="menuItem"><a href="/factions/view/<?php echo $factionA[($dnb['ID'])]; ?>"><?php echo $factions[($dnb['ID'])] ?></a></li>
					<li class="rightMenuItem" />
				</ul>
			</li>
			
			<?php
				}
			
			}
			?>
			
		</ul>
	</div>
	<div id="contentPage">
	<div class="contentTabberPage">
		<div class="topTabs">
			<ul>
			<li class="dropdown"><a class="dropdown-toggle data-toggle="dropdown" style="cursor:pointer;">اقلیت</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/view/<?php echo $fac ?>">توضیحات اقلیت</a></li>
					<li><a href="/factions/rules/<?php echo $fac ?>">قوانین اقلیت</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">اعضا، تاریخچه و آمار</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/members/<?php echo $fac ?>">اعضای اقلیت</a></li>
					<li><a href="/factions/logs/<?php echo $fac ?>">تاریخچه اقلیت</a></li>
					<li><a href="/factions/stats/<?php echo $fac ?>">آمار اقلیت</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">لیست سیاه</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/blacklist/<?php echo $fac ?>">لیست سیاه</a></li>
					<li><a href="/factions/blacklistLogs/<?php echo $fac ?>">تاریخچه لیست سیاه</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">شکایات و درخواست‌های عضویت</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/complainment/<?php echo $fac ?>">شکایات</a></li>
					<li><a href="/factions/applications/<?php echo $fac ?>">درخواست‌های عضویت</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">درخواست‌های مرخصی و استعفا</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/inactivities/<?php echo $fac ?>">درخواست‌های مرخصی</a></li>
					<li><a href="/factions/resignations/<?php echo $fac ?>">درخواست‌های استعفا</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">فعالیت‌های اقلیت</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/reports/<?php echo $fac ?>">گزارشات اقلیت</a></li>
				</ul>
			</li>
<?php if($dnn['Opened'] && (totalFactionMembers($con, $dnn['ID']) < $dnn['Slot']) && ($dnx['Level'] > $dnn['MinLvl']  || $dnx['Rank'] == 0)) { ?><li><a href="/factions/apply/<?php echo $fac ?>">درخواست عضویت</a></li><?php } ?>

					</ul>
	</div>        <br>
		<div class="subPageTitle pageTitle">
			درخواست عضویت برای اقلیت <?php echo $factions[$fid] ?>        </div>
			<div class="normalTextBox">
			<?php if(isset($errMsg)) { ?><div style="text-align: center; width: 300px; margin-left: auto; margin-right: auto;" class="normalTextBox"><?php echo $errMsg ?></div><?php } ?>
        <form action="" method="post" name="formular">
            <table border="0" style="width: 100%; padding: 50px;">
                        <tbody><tr>
                            <td>سن واقعی:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a1"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>ساعات بازی کردن در روز:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a2"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>فواصل زمانی بازی کردن:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a3"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>توضیحات خروج از اقلیت قبلی:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a4"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>توضیحات مجازات‌های دریافتی از ادمین‌ها:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a5"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>توصیف خود به عنوان یک متقاضی عضویت:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a6"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>مقدار آشنایی با زبان انگلیسی:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a7"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>دلیل درخواست برای این اقلیت:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a8"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>برنامه های آینده شما به عنوان یک بازیکن:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a9"></textarea></td>
                        </tr>
                                                                                <tr>
                            <td>اطلاعات مفید دیگر برای راهبر اقلیت:</td>
                        </tr>
                        <tr>
                            <td><textarea required type="text" class="normalTextarea small" name="a10"></textarea></td>
                        </tr>
                                                    <tr>
                    <td><input type="submit" class="normalButton" style="margin: 0 auto;" value="درخواست"></td>
                </tr>
            </tbody></table>
        </form>
    </div>

	</div>            </div>
				</div>
<?php
}
if(!$xx)
{
	header("Location: ../");
}
?>
</div></div></div>