<?php
$cuser = $_SESSION['username'];
$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
$uuid = $dnn['ID'];
$query2 = $con->prepare("SELECT * FROM `factionlogs` WHERE `Player` = {$uuid} ORDER BY `ID` DESC;");
$query2->execute();
$fnn = $query2->fetch();
$xx = 1;
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle"> حساب کاربری من
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul>
<li class="first"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/general">اطلاعات عمومی</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/achievements">دستاوردها</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/monthlyPlayed">رده بندی ماهانه</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="active"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/faction">اقلیت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/clan">کلن</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/job">شغل</a></li>
<li class="rightMenuItem"></li></ul>
</li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/vehicles">دارایی</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="prev"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/mystats">اطلاعات من</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/friends">دوستان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="next"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/referrals">معرفی شدگان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/moneylog">درآمد</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/namelog">تاریخچه اسم</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/warSuspendLog">تاریخچه مسدودیت رقابت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/jaillog">تاریخچه زندان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/mutelog">تاریخچه محرومیت صحبت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/suspendlog">تاریخچه مسدودیت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/warnlog">تاریخچه اخطار</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/kicklog">تاریخچه کیک</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/banlog">تاریخچه محرومیت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/security">امنیت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/logins">آخرین ورود</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="last"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/shopTransactions">فروشگاه</a></li>
<li class="rightMenuItem"></li></ul>
</ul></div><div id="contentPage">
    <div class="contentTabberPage">
        <div class="topTabs">
    <ul>
        <li class="active"><a href="/account/faction" class="active">اقلیت</a></li>
        <li><a href="/account/factionActivity">فعالیت اقلیت</a></li>
        <li><a href="/account/factionReports">گزارش اقلیت</a></li>
        <li><a href="/account/blacklist">لیست سیاه</a></li>
    </ul>
</div>    <div class="subPageContainer">
        <div class="subPageTitle pageTitle">
            اقلیت
        </div>
        <div class="actionArea">
                                </div>
    </div>
    <div id="FactionWrapper">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTableSingle">
            <tbody><tr class="firstRow">
                <td class="headerTd">عضو اقلیت</td>
                <td><font color=<?php echo $factionC[$dnn['Leader'] + $dnn['Member']] ?>><?php echo $factions[$dnn['Leader'] + $dnn['Member']] ?></font></td>
            </tr>
            <tr>
                <td class="headerTd">تاریخ عضویت</td>
                <td dir=ltr><?php
				if($dnn['Leader']) {
					$ffid = $dnn['Leader'];
					$dpp = $con->prepare("SELECT * FROM `promotes` WHERE `Target` = {$dnn['ID']} AND `Action` = 3 AND `ActionDesc` = {$ffid} ORDER BY `ID` ASC LIMIT 1;");
					$dpp->execute();
					$cq = 0;
					while($dp = $dpp->fetch())
					{
						echo jdate('Y/m/d H:i:s', $dp['Date']);
						$cq++;
					}
					if($cq == 0) echo "اطلاعاتی موجود نیست";
				}
				else {
					echo ($dnn['Leader'] + $dnn['Member']) ? jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $fnn['Date'])))) : "اطلاعاتی موجود نیست";
				}
				?></td>
            </tr>
            <tr>
                <td class="headerTd">درجه</td>
                <td dir=ltr><?php echo ($dnn['Leader'] + $dnn['Member']) ? $factionR[$dnn['Leader'] + $dnn['Member']][$dnn['Rank'] - 1] : "هیچ" ?></td>
            </tr>
            <tr>
                <td class="headerTd">اخطارهای اقلیت</td>
                <td dir=ltr><?php echo $dnn['FWarns'] ?>/3</td>
            </tr>
            <tr class="lastRow">
                <td class="headerTd">مجازات اقلیت</td>
                <td dir=ltr><?php echo $dnn['FPunish'] ?>/60</td>
            </tr>
            <tr class="lastRow">
                <td class="headerTd">زمان حضور در اقلیت</td>
                <td><?php
				if($dnn['Leader']) {
					$ffid = $dnn['Leader'];
					$dpp = $con->prepare("SELECT * FROM `promotes` WHERE `Target` = {$dnn['ID']} AND `Action` = 3 AND `ActionDesc` = {$ffid} ORDER BY `ID` ASC LIMIT 1;");
					$dpp->execute();
					$cq = 0;
					while($dp = $dpp->fetch())
					{
						$hozur = time() - $dp['Date'];
						$cq++;
					}
				if($cq == 0) echo "اطلاعاتی موجود نیست";
				else echo gmdate("j",$hozur) . " روز";
				}
				else {
					$hozur = abs(strtotime(str_replace('/', '-', str_replace(' - ', ' ', $fnn['Date']))) - time());
					echo ($dnn['Leader'] + $dnn['Member']) ? gmdate("j",$hozur) . " روز" : "اطلاعاتی موجود نیست";
				}
				?></td>
            </tr>
        </tbody></table>
    </div>
    <div class="subPageTitle pageTitle">
        برترین درجات اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>اقلیت</td>
                <td class="lastTd">درجه</td>
            </tr>
                    </tbody></table>
    </div>
    <div class="subPageTitle pageTitle">
        آخرین درخواست‌های عضویت در اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>اقلیت</td>
                <td>وضعیت</td>
                <td class="lastTd">نمایش</td>
            </tr>
                <?php
				$queryx = $con->prepare("SELECT * FROM `applications` WHERE `Player` = {$uuid} ORDER BY `ID` DESC LIMIT 7;");
				$queryx->execute();
				while($pnn = $queryx->fetch())
				{
				?>
				<tr>
					<td dir=ltr><?php echo jdate('Y/m/d H:i:s', $pnn['Date']) ?></td>
					<td><a href="/factions/view/<?php echo $factionA[($pnn['FactionID'])]; ?>" style="color: #<?php echo $factionC[($pnn['FactionID'])]; ?>;"><?php echo $factions[($pnn['FactionID'])] ?></a></td>
					<td><?php echo $factiontypes[$pnn['Status']] ?></td>
					<td><a href="/factions/application/<?php echo $pnn['ID']; ?>">نمایش</a></td>
				</tr>
				<?php
				}
				?>
                    </tbody></table>
    </div>
    <div style="text-align: left">
        <a href="/account/factionapplications">نمایش همه</a>
    </div>
    <div class="subPageTitle pageTitle">
        آخرین درخواست‌های استعفاء از اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>اقلیت</td>
                <td>درجه</td>
                <td>وضعیت</td>
                <td class="lastTd">نمایش</td>
            </tr>
                    </tbody></table>
    </div>
    <div style="text-align: left">
        <a href="/account/factionresignations">نمایش همه</a>
    </div>
    <div class="subPageTitle pageTitle">
        آخرین درخواست‌های مرخصی اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>اقلیت</td>
                <td>وضعیت</td>
                <td class="lastTd">نمایش</td>
            </tr>
                    </tbody></table>
    </div>
    <div style="text-align: left">
        <a href="/account/factioninactivities">نمایش همه</a>
    </div>
    <div class="subPageTitle pageTitle">
        آخرین تاریخچه اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>توسط</td>
                <td>اقلیت</td>
                <td class="lastTd">حرکت</td>
            </tr>
                    <?php
						$queryx = $con->prepare("SELECT * FROM `factionlogs` WHERE `Player` = {$uuid} ORDER BY `ID` DESC LIMIT 7;");
						$queryx->execute();
						while($pnn = $queryx->fetch())
						{
							$uxl = $pnn['Leader'];
							$queryql = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$uxl}';");
							$queryql->execute();
							$dnl = $queryql->fetch();
						?>
                        <tr>
                            <td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $pnn['Date'])))) ?></td>
							<td><?php generalUserUrl($con, $dnl['Name'], $factions, $factionC, $factionR); ?></td>
							<td><a href="/factions/view/<?php echo $factionA[($pnn['FactionID'])]; ?>" style="color: #<?php echo $factionC[($pnn['FactionID'])]; ?>;"><?php echo $factions[($pnn['FactionID'])] ?></a></td>
							<td><?php echo numberfa(str_replace("Promoted to rank", "ارتقا به درجه ", str_replace("Left the faction (with", "اخراج از اقلیت (با ", str_replace("Left the faction", "خروج از اقلیت", str_replace("Joined the faction", "ورود به اقلیت", str_replace("Was kicked out (3 warns)", "اخراج از اقلیت (3 اخطار)", str_replace("Received FactionWarn", "دریافت اخطار اقلیت", str_replace("with", "با", str_replace("FP", "مجازات اقلیت", $pnn['Text']))))))))); ?></td>
                        </tr>
						<?php
						}
						?>
                    </tbody></table>
    </div>
    <div style="text-align: left">
        <a href="/account/factionlogs">نمایش همه</a>
    </div>
</div>
            </div>
		</div>
<?php } if(!$xx) header("Location: /account/login"); ?> 
</div></div></div>