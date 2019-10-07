<?php
$query = $con->prepare("SELECT * FROM `events` WHERE `ID` = '{$user}';");
$query->execute();
while($dvc = $query->fetch())
{
?>
<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        رویدادها
    </div>
    <div id="contentMain">
    <div id="leftSidebar">
        <ul>
            <li class="first">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/events/list">لیست رویدادها</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<?php
			$query = $con->prepare("SELECT * FROM `events` ORDER BY `ID` DESC;");
			$query->execute();
			while($dnn = $query->fetch())
			{
			?>
			<li <?php if($dnn['ID'] == $user) echo 'class="active"'; ?>>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/events/info/<?php echo $dnn['ID']; ?>"><?php echo $dnn['Title']; ?></a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<?php } ?>
        </ul>
    </div>
    <div id="contentPage">
    <div class="contentTabberPage">
        <div class="subPageTitle pageTitle">
            <?php echo $dvc['Title']; ?></div>
        <br/><br/>
		<div id="ShopWrapper">
        <div class="bigCarImgContainer">
                <img src="public/img/event<?php echo $dvc['ID']; ?>.jpg" alt="رویداد <?php echo $dvc['Title']; ?>">
        </div>
        <table border="0" cellspacing="0" cellpadding="0" class="vTable" width="580px">
            <tbody>
			<tr class="firstRow"><td colspan="2" style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><span style="font-weight:bold; color:#FFFF00 !important; font-size:20px;">رویداد <?php echo $dvc['Title']; ?></span></td></tr>
            <tr>
				<td colspan="2" class="headerTd">
				<?php echo $dvc['Description']; ?>
				</td>
			</tr>
			<tr>
				<td class="headerTd">نوع رویداد</td>
				<td><?php echo $dvc['Type']; ?></td>
			</tr>
			<tr>
				<td class="headerTd">شرکت کنندگان</td>
				<td dir=ltr><?php if($dvc['MaxPlayers'] == -1) echo "تمامی بازیکنان"; else echo $dvc['Players'] . " / " . $dvc['MaxPlayers']; ?></td>
			</tr>
			<tr>
				<td class="headerTd">فرصت شرکت در رویداد</td>
				<td dir=ltr><?php echo ($dvc['JoinTime']) ? jdate("Y/m/d H:i:s", $dvc['JoinTime']) : "تنظیم نشده"; ?></td>
			</tr>
			<tr>
				<td class="headerTd">زمان شروع رویداد</td>
				<td dir=ltr><?php echo ($dvc['StartTime']) ? jdate("Y/m/d H:i:s", $dvc['StartTime']) : "تنظیم نشده"; ?></td>
			</tr>
			<tr>
				<td class="headerTd">زمان اتمام رویداد</td>
				<td dir=ltr><?php echo ($dvc['EndTime']) ? jdate("Y/m/d H:i:s", $dvc['EndTime']) : "تنظیم نشده"; ?></td>
			</tr>
			<tr>
				<td class="headerTd">هزینه ورود (برای هر نفر)</td>
				<td dir=ltr><?php echo ($dvc['Price'] == 0) ? "رایگان" : $dvc['Price']; ?></td>
			</tr>
			<tr>
				<td class="headerTd">جایزه رتبه اول</td>
				<td><?php echo numberfa($dvc['WR1']) ?></td>
			</tr>
			<tr>
				<td class="headerTd">جایزه رتبه دوم</td>
				<td><?php echo numberfa($dvc['WR2']) ?></td>
			</tr>
			<tr class="lastRow">
				<td class="headerTd">جایزه رتبه سوم</td>
				<td><?php echo numberfa($dvc['WR3']) ?></td>
			</tr>
        </tbody></table>
		<hr>
		<table border="0" cellspacing="0" cellpadding="0" class="vTable" width="580px">
            <tbody>
			<tr class="firstRow"><td colspan="3" style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><span style="font-weight:bold; color:#FF0000 !important; font-size:20px;">رده‌بندی</span></td></tr>
			<tr class="showTooltip" data-toggle"tooltip" data-placement="bottom" data-original-title="<?php echo numberfa($dvc['WR1']) ?>">
                <td class="headerTd" style="vertical-align: middle; background: gold; color: black;"><span>نفر اول</span></td>
                <td class="headerTd" style="vertical-align: middle; background: gold; color: black;text-shadow: 2px 2px 6px black;"><?php echo ($dvc['R1']) ? generalIDUrl($con, $dvc['R1'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td class="headerTd" style="vertical-align: middle; background: gold; color: black;"><?php echo number_formatfa($dvc['SR1']) ?></td>
            </tr>
			<tr class="showTooltip" data-toggle"tooltip" data-placement="bottom" data-original-title="<?php echo numberfa($dvc['WR2']) ?>">
                <td class="headerTd" style="vertical-align: middle; background: yellowgreen; color: black;"><span>نفر دوم</span></td>
                <td class="headerTd" style="vertical-align: middle; background: yellowgreen; color: black;text-shadow: 2px 2px 6px black;"><?php echo ($dvc['R2']) ? generalIDUrl($con, $dvc['R2'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td class="headerTd" style="vertical-align: middle; background: yellowgreen; color: black;"><?php echo number_formatfa($dvc['SR2']) ?></td>
            </tr>
			<tr class="showTooltip" data-toggle"tooltip" data-placement="bottom" data-original-title="<?php echo numberfa($dvc['WR3']) ?>">
                <td class="headerTd" style="vertical-align: middle; background: cyan; color: black;"><span>نفر سوم</span></td>
                <td class="headerTd" style="vertical-align: middle; background: cyan; color: black;text-shadow: 2px 2px 6px black;"><?php echo ($dvc['R3']) ? generalIDUrl($con, $dvc['R3'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td class="headerTd" style="vertical-align: middle; background: cyan; color: black;"><?php echo number_formatfa($dvc['SR3']) ?></td>
            </tr>
			<tr>
                <td class="headerTd" style="vertical-align: middle;"><span>نفر چهارم</span></td>
                <td><?php echo ($dvc['R4']) ? generalIDUrl($con, $dvc['R4'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td><?php echo number_formatfa($dvc['SR4']) ?></td>
            </tr>
			<tr>
                <td class="headerTd" style="vertical-align: middle;"><span>نفر پنجم</span></td>
                <td><?php echo ($dvc['R5']) ? generalIDUrl($con, $dvc['R5'], $factions, $factionC, $factionR) : "هیچ کس"; ?></td>
				<td><?php echo number_formatfa($dvc['SR5']) ?></td>
            </tr>
            <tr class="lastRow">
			</tr>
        </tbody></table><br />
		<table border="0" cellspacing="0" cellpadding="0" class="vTable" width="580px">
            <tbody>
			<tr class="firstRow"><td colspan="3" style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><span style="font-weight:bold; color:#3498db !important; font-size:20px;">جدول امتیازات</span></td></tr>
			<?php
			if($dvc['StartTime'] < time() && time() < $dvc['EndTime']) {
			$query = $con->prepare("SELECT * FROM `users` ORDER BY `MHoursPlayed` - `MUHoursPlayed` DESC, `HoursPlayed` ASC LIMIT 10;");
			$query->execute();
			$x = 0;
			while($dvl = $query->fetch())
			{
				$x++;
			?>
			<tr>
                <td class="headerTd" style="vertical-align: middle;"><span dir=ltr>#<?php echo $x; ?></span></td>
                <td><?php echo generalIDUrl($con, $dvl['ID'], $factions, $factionC, $factionR); ?></td>
				<td><?php echo number_formatfa($dvl['MHoursPlayed'] - $dvl['MUHoursPlayed']) ?> ساعت <sub>(کل: <?php echo number_formatfa($dvl['HoursPlayed']) ?> ساعت)</sub></td>
            </tr>
			<?php } } else { ?>
			<tr>
				<td colspan=3><span style="text-align; center"><?php if(time() > $dvc['EndTime']) { ?>این رویداد به اتمام رسیده است!<?php } else { ?>این رویداد شروع نشده است!<?php } ?></span></td>
            </tr>
			<?php } ?>
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