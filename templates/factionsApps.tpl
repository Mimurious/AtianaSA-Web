<?php
$fid = array_search($fac, $factionA);
$query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = '{$fid}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
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
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">اقلیت</a>
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
            <li class="dropdown active"><a class="dropdown-toggle active" data-toggle="dropdown" style="cursor:pointer;">شکایات و درخواست‌های عضویت</a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
                    <li><a href="/factions/complainment/<?php echo $fac ?>">شکایات</a></li>
                    <li class="active"><a href="/factions/applications/<?php echo $fac ?>">درخواست‌های عضویت</a></li>
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
            <?php echo $factions[$fid] ?>        </div>
			<div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">بازیکن</td>
                <td>تاریخ ایجاد</td>
                <td>پاسخ دهنده</td>
                <td>زمان پاسخ</td>
                <td>وضعیت</td>
                <td>نمایش</td>
            </tr>
			<?php
				$queryx = $con->prepare("SELECT * FROM `applications` WHERE `FactionID` = {$fid} ORDER BY `ID` DESC;");
				$queryx->execute();
				while($pnn = $queryx->fetch())
				{
				?>
                <tr>
                    <td><?php generalIDUrl($con, $pnn['Player'], $factions, $factionC, $factionR); ?></td>
                    <td dir=ltr><?php echo jdate('Y/m/d H:i:s', $pnn['Date']) ?></td>
                    <td><?php echo ($pnn['Answerer'] != 0) ? generalIDUrl($con, $pnn['Answerer'], $factions, $factionC, $factionR) : "هیچکس"; ?></td>
                    <td dir=ltr><?php echo ($pnn['AnswerDate']) ? jdate('Y/m/d H:i:s', $pnn['AnswerDate']) : "اطلاعاتی موجود نیست"; ?></td>
                    <td><?php echo $factiontypes[$pnn['Status']] ?></td>
                    <td><a href="/factions/application/<?php echo $pnn['ID']; ?>">نمایش</a></td>
                </tr>
				<?php } ?>
                    </tbody></table>
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