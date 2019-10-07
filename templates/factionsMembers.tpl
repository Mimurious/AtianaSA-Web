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
            <li class="dropdown active"><a class="dropdown-toggle active" data-toggle="dropdown" style="cursor:pointer;">اعضا، تاریخچه و آمار</a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
                    <li class="active"><a href="/factions/members/<?php echo $fac ?>">اعضای اقلیت</a></li>
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
            <?php echo $factions[$fid] ?>        </div>
			
			<b>اعضا: <?php echo totalFactionMembers($con, $fid) ?></b>
        <br><br>
		<?php
		for($x = 7; $x > 0; $x--)
		{
			if($fid == 3) if($x != 7 && $x != 2 && $x != 1) continue;
		?>
        <div class="tableFull">
        <div class="tableLabel">اعضای <span dir=ltr><?php echo $factionR[$fid][$x - 1]; ?></span></div>
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
				<td width="3%" class="firstTd"></td>
                <td width="50%">بازیکن</td>
                <td class="lastTd">آخرین ورود</td>
            </tr>
				<?php
				$query = $con->prepare("SELECT * FROM `users` WHERE `Leader` + `Member` = {$fid} AND `Rank` = {$x} ORDER BY `ID`;");
				$query->execute();
				$c = 0;
				while($dnn = $query->fetch())
				{
				$c++;
				?>
                <tr>
				<td><a href="/players/general/<?php echo $dnn['Name'] ?>"><img class="onlinePhoto" src="public/img/Skins/thumb/<?php echo $dnn['Skin']; ?>.png" alt="skin"></a></td>
                <td><div style="overflow: hidden; display: table; margin: 0 auto;">
                    <div style="float: right; margin-left: 5px;"><img class="showTooltip" style="display: block; margin-top: 3px;" src="public/img/<?php 
						if($dnn['Status'] == 0) echo "offline";
						else if($dnn['Status'] == 1) echo "online";
						else if($dnn['Status'] == 2) echo "afk";
						?>.png" alt="<?php 
						if($dnn['Status'] == 0) echo "آفلاین";
						else if($dnn['Status'] == 1) echo "آنلاین";
						else if($dnn['Status'] == 2) echo "دور از دسترس";
						?>" data-toggle="tooltip" title="<?php 
						if($dnn['Status'] == 0) echo "آفلاین";
						else if($dnn['Status'] == 1) echo "آنلاین";
						else if($dnn['Status'] == 2) echo "دور از دسترس";
						?>"/></div>
                    <?php generalUserUrl($con, $dnn['Name'], $factions, $factionC, $factionR); ?></div></td>
                <td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $dnn['LastLogin'])))) ?></td>
				<?php
				}
				?>
            </tr>
        </tbody>
		</table>
		<div class="tableSubtotal">تعداد: <?php echo $c; ?> عضو</div>
		</div>
		<?php
		}
		?>
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