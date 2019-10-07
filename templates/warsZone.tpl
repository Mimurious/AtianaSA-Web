<?php
$query = $con->prepare("SELECT * FROM `zones` WHERE `ID` = '{$user}';");
$query->execute();
while($dvc = $query->fetch())
{
?>
<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        رقابت‌ها
        </div>
    <div id="contentMain">
    <div id="leftSidebar">
        <ul>
			<li class="first active">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/turfs">مناطق</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
            <li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/gangsters">برترین گانگسترها</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/upcoming">در پیش رو</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/viewall">نمایش همه</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/interdictionRequests">درخواست‌های مسدودیت</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/interdictionList">لیست مسدودیت</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/allianceWars">رقابت‌های آخرهفته</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
        </ul>
    </div>
    <div id="contentPage">
    <div class="contentTabberPage">
        <div class="subPageTitle pageTitle">
            منطقه <span dir=ltr><?php echo $dvc['Name']; ?> (#<?php echo $dvc['ID']; ?>)</span></div>
        <br/><br/>
		<div id="ShopWrapper">
        <div class="zoneContainer" dir=ltr>
			<a href="/wars/zone/<?php echo $dvc['ID'] ?>">
			<div title=""
			class="showTooltip turf"
			data-name="<?php echo $dvc['Name'] ?>"
			data-id="<?php echo $dvc['ID'] ?>"
			data-intervals=""
			style="top: <?php echo -($dvc['MinY'] / (6000 / 580) - 257) ?>px;
			left: <?php echo ($dvc['MinX'] / (6000 / 580)) + 290 ?>px;
			width: <?php echo ($dvc['MaxX'] - $dvc['MinX']) / (6000 / 580) ?>px;
			height: <?php echo ($dvc['MaxY'] - $dvc['MinY']) / (6000 / 580) ?>px;
			background-color: #<?php echo $factionC[$dvc['Team']] ?>;"
			data-original-title="<?php echo $dvc['Name'] ?>">
			</div>
			</a>
    </div>
        <table border="0" cellspacing="0" cellpadding="0" class="vTable" width="580px">
            <tbody>
			<tr class="firstRow"><td colspan="2" style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><span style="font-weight:bold; color:#FFFF00 !important; font-size:20px;">منطقه <span dir=ltr><?php echo $dvc['Name']; ?> (#<?php echo $dvc['ID']; ?>)</span></span></td></tr>
            <tr>
				<td colspan="2" class="headerTd">
				<?php echo $dvc['Description']; ?>
				</td>
			</tr>
			<tr>
				<td class="headerTd">مالک منطقه</td>
				<td><a style="color: #<?php echo $factionC[($dvc['Team'])]; ?>;" href="/factions/view/<?php echo $factionA[($dvc['Team'])]; ?>"><?php echo $factions[($dvc['Team'])] ?></a></td>
			</tr>
			<tr>
				<td class="headerTd">قفل رقابت</td>
				<td><?php if($dvc['Hours']) echo "بله (". $dvc['Hours'] ." ساعت)"; else echo "خیر" ?></td>
			</tr>
			<tr>
				<td class="headerTd">زمان انجام آخرین رقابت</td>
				<td dir=ltr><?php echo ($dvc['LastWar']) ? jdate("Y/m/d H:i:s", $dvc['LastWar']) : "اطلاعاتی موجود نیست"; ?></td>
			</tr>
        </tbody></table>
		<hr>
		<table border="0" cellspacing="0" cellpadding="0" class="vTable" width="580px">
            <tbody>
			<tr class="firstRow"><td colspan="3" style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><span style="font-weight:bold; color:#FF0000 !important; font-size:20px;">رده‌بندی مالکان منطقه</span></td></tr>
			<tr class="showTooltip" data-toggle"tooltip" data-placement="bottom" data-original-title="<?php echo numberfa($dvc['WR1']) ?>">
                <td class="headerTd" style="vertical-align: middle; background: gold; color: black;"><span>اقلیت اول</span></td>
                <td class="headerTd" style="vertical-align: middle; background: gold; color: black;text-shadow: 2px 2px 6px black;"><?php echo ($dvc['R1']) ? generalIDUrl($con, $dvc['R1'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td class="headerTd" style="vertical-align: middle; background: gold; color: black;"><?php echo number_formatfa($dvc['SR1']) ?></td>
            </tr>
			<tr class="showTooltip" data-toggle"tooltip" data-placement="bottom" data-original-title="<?php echo numberfa($dvc['WR2']) ?>">
                <td class="headerTd" style="vertical-align: middle; background: yellowgreen; color: black;"><span>اقلیت دوم</span></td>
                <td class="headerTd" style="vertical-align: middle; background: yellowgreen; color: black;text-shadow: 2px 2px 6px black;"><?php echo ($dvc['R2']) ? generalIDUrl($con, $dvc['R2'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td class="headerTd" style="vertical-align: middle; background: yellowgreen; color: black;"><?php echo number_formatfa($dvc['SR2']) ?></td>
            </tr>
			<tr class="showTooltip" data-toggle"tooltip" data-placement="bottom" data-original-title="<?php echo numberfa($dvc['WR3']) ?>">
                <td class="headerTd" style="vertical-align: middle; background: cyan; color: black;"><span>اقلیت سوم</span></td>
                <td class="headerTd" style="vertical-align: middle; background: cyan; color: black;text-shadow: 2px 2px 6px black;"><?php echo ($dvc['R3']) ? generalIDUrl($con, $dvc['R3'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td class="headerTd" style="vertical-align: middle; background: cyan; color: black;"><?php echo number_formatfa($dvc['SR3']) ?></td>
            </tr>
			<tr>
                <td class="headerTd" style="vertical-align: middle;"><span>اقلیت چهارم</span></td>
                <td><?php echo ($dvc['R4']) ? generalIDUrl($con, $dvc['R4'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td><?php echo number_formatfa($dvc['SR4']) ?></td>
            </tr>
			<tr>
                <td class="headerTd" style="vertical-align: middle;"><span>اقلیت پنچم</span></td>
                <td><?php echo ($dvc['R5']) ? generalIDUrl($con, $dvc['R5'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td><?php echo number_formatfa($dvc['SR5']) ?></td>
            </tr>
            <tr class="lastRow">
			</tr>
        </tbody></table><br />
		<table border="0" cellspacing="0" cellpadding="0" class="vTable" width="580px">
            <tbody>
			<tr class="firstRow"><td colspan="3" style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><span style="font-weight:bold; color:#3498db !important; font-size:20px;">آخرین رقابت‌های انجام شده</span></td></tr>
			<tr>
				<td colspan=3><span style="text-align; center"><?php if(time() > $dvc['EndTime']) { ?>اطلاعاتی موجود نیست<?php } else { ?>اطلاعاتی موجود نیست<?php } ?></span></td>
            </tr>
            <tr class="lastRow">
			</tr>
        </tbody></table>
    </div>
	</div>
</div>
</div>
</div></div></div>
<?php
}
?>