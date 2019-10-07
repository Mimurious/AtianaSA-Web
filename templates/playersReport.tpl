<?php
$query = $con->prepare("SELECT * FROM `reports` WHERE `ID` = '{$user}' LIMIT 1;");
$query->execute();
$xx = 0;
while($repp = $query->fetch())
{
$xx = 1;
$reported = $repp['Target'];
$query = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$reported}' LIMIT 1;");
$query->execute();
$dnn = $query->fetch();

$reporter = $repp['ReportedBy'];
$query = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$reporter}' LIMIT 1;");
$query->execute();
$snn = $query->fetch();
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    بازیکنان
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li class="active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li class="prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li>
</ul>
</ul></div><div id="contentPage">
    <div class="subPageTitle pageTitle">
        گزارش #<?php echo $user; ?>
    </div>
	<div class="normalTextBox">
        <table border="0" style="width: 100%; padding: 0 20px;">
            <tbody><tr>
                <td class="reportTitle">تاریخ ایجاد شکایت:</td>
            </tr>
            <tr>
                <td class="reportAnswer" dir=ltr style=float:right><?php echo jdate('Y/m/d H:i:s', $repp['Time']); ?></td>
            </tr>
            <tr>
                <td class="reportTitle">بازیکن گزارش شده:</td>
            </tr>
            <tr>
                    <td><div style="display: inline; margin-right: 5px;"><img class="showTooltip" style="display: inline; margin-top: 3px;" src="public/img/<?php 
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
                    <?php generalUserUrl($con, $dnn['Name'], $factions, $factionC, $factionR); ?> - سطح <?php echo $dnn['Level']; ?> - تجربه <span dir=ltr><?php echo $dnn['Respect'] ?> / <?php echo (($dnn['Level'] == 1) ? 2 : ($dnn['Level'] * 2) - 2); ?></span></td>
                </tr>
            <tr>
                <td class="reportTitle">گزارش دهنده:</td>
            </tr>
            <tr>
                    <td><div style="display: inline; margin-right: 5px;"><img class="showTooltip" style="display: inline; margin-top: 3px;" src="public/img/<?php 
						if($snn['Status'] == 0) echo "offline";
						else if($snn['Status'] == 1) echo "online";
						else if($snn['Status'] == 2) echo "afk";
						?>.png" alt="<?php 
						if($snn['Status'] == 0) echo "آفلاین";
						else if($snn['Status'] == 1) echo "آنلاین";
						else if($snn['Status'] == 2) echo "دور از دسترس";
						?>" data-toggle="tooltip" title="<?php 
						if($snn['Status'] == 0) echo "آفلاین";
						else if($snn['Status'] == 1) echo "آنلاین";
						else if($snn['Status'] == 2) echo "دور از دسترس";
						?>"/></div>
                    <?php generalUserUrl($con, $snn['Name'], $factions, $factionC, $factionR); ?> - سطح <?php echo $snn['Level']; ?> - تجربه <span dir=ltr><?php echo $snn['Respect'] ?> / <?php echo (($snn['Level'] == 1) ? 2 : ($snn['Level'] * 2) - 2); ?></span></td>
                </tr>
            <tr>
            <tr>
                <td class="reportTitle">دلیل شکایت:</td>
            </tr>
            <tr>
                <td class="reportAnswer"><?php echo $reasontypes[$repp['Type']]; ?></td>
            </tr>
            <tr>
                <td class="reportTitle">توضیحات شکایت:</td>
            </tr>
            <tr>
                <td class="reportAnswer"><?php echo $repp['Reason']; ?></td>
            </tr>
            <tr>
                <td class="reportTitle">مدارک:</td>
            </tr>
            <tr>
                <td class="reportAnswer"><?php echo $repp['Proofs']; ?></td>
            </tr>
            <tr>
                <td class="reportTitle">شاهد(ین):</td>
            </tr>
            <tr>
                <td class="reportAnswer">
					<?php 
						if($repp['Witness1'])
						{
							$wit = $repp['Witness1'];
							$query = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$wit}' LIMIT 1;");
							$query->execute();
							while($wnn = $query->fetch())
							{
							?>
								<div style="display: inline; margin-right: 5px;"><img class="showTooltip" style="display: inline; margin-top: 3px;" src="public/img/<?php 
									if($wnn['Status'] == 0) echo "offline";
									else if($wnn['Status'] == 1) echo "online";
									else if($wnn['Status'] == 2) echo "afk";
									?>.png" alt="<?php 
									if($wnn['Status'] == 0) echo "آفلاین";
									else if($wnn['Status'] == 1) echo "آنلاین";
									else if($wnn['Status'] == 2) echo "دور از دسترس";
									?>" data-toggle="tooltip" title="<?php 
									if($wnn['Status'] == 0) echo "آفلاین";
									else if($wnn['Status'] == 1) echo "آنلاین";
									else if($wnn['Status'] == 2) echo "دور از دسترس";
									?>"/></div> 
								<?php generalUserUrl($con, $wnn['Name'], $factions, $factionC, $factionR); ?> - سطح <?php echo $wnn['Level']; ?> - تجربه <span dir=ltr><?php echo $wnn['Respect'] ?> / <?php echo (($wnn['Level'] == 1) ? 2 : ($wnn['Level'] * 2) - 2); ?></span><br />
							<?php	
							}
						}
						if($repp['Witness2'])
						{
							$wit = $repp['Witness2'];
							$query = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$wit}' LIMIT 1;");
							$query->execute();
							while($wnn = $query->fetch())
							{
							?>
								<div style="display: inline; margin-right: 5px;"><img class="showTooltip" style="display: inline; margin-top: 3px;" src="public/img/<?php
									if($wnn['Status'] == 0) echo "offline";
									else if($wnn['Status'] == 1) echo "online";
									else if($wnn['Status'] == 2) echo "afk";
									?>.png" alt="<?php 
									if($wnn['Status'] == 0) echo "آفلاین";
									else if($wnn['Status'] == 1) echo "آنلاین";
									else if($wnn['Status'] == 2) echo "دور از دسترس";
									?>" data-toggle="tooltip" title="<?php 
									if($wnn['Status'] == 0) echo "آفلاین";
									else if($wnn['Status'] == 1) echo "آنلاین";
									else if($wnn['Status'] == 2) echo "دور از دسترس";
									?>"/></div> 
								<?php generalUserUrl($con, $wnn['Name'], $factions, $factionC, $factionR); ?> - سطح <?php echo $wnn['Level']; ?> - تجربه <span dir=ltr><?php echo $wnn['Respect'] ?> / <?php echo (($wnn['Level'] == 1) ? 2 : ($wnn['Level'] * 2) - 2); ?></span><br />
							<?php	
							}
						}
						if($repp['Witness1'] + $repp['Witness2'] == 0) echo "--<br>";
					?>
                    </td>
            </tr>
        </tbody></table>
        <table border="0" style="width: 100%; padding: 0 20px;">
            <tbody><tr>
                <td class="reportTitle"><b>وضعیت:</b></td>
            </tr>
            <tr>
                <td class="reportAnswer"><?php if($repp['Status'] == 0) echo "در حال بررسی"; else if($repp['Status'] == 1) echo "پس گرفته شده"; else if($repp['Status'] == 2) echo "بررسی شده";  ?></td>
            </tr>
			<?php if($repp['Answerer'] != -1) { ?>
			<tr>
                <td class="reportTitle">پاسخ دهنده:</td>
            </tr>
            <tr>
            <?php
                $war = $repp['Answerer'];
				$query = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$war}' LIMIT 1;");
				$query->execute();
				$wna = $query->fetch();
            ?>
                <td class="reportAnswer"><?php if($repp['Answerer'] == 0) echo "ربات"; else { ?>
				<div style="display: inline; margin-right: 5px;"><img class="showTooltip" style="display: inline; margin-top: 3px;" src="public/img/<?php
				if($wna['Status'] == 0) echo "offline";
				else if($wna['Status'] == 1) echo "online";
				else if($wna['Status'] == 2) echo "afk";
				?>.png" alt="<?php 
				if($wna['Status'] == 0) echo "آفلاین";
				else if($wna['Status'] == 1) echo "آنلاین";
				else if($wna['Status'] == 2) echo "دور از دسترس";
				?>" data-toggle="tooltip" title="<?php 
				if($wna['Status'] == 0) echo "آفلاین";
				else if($wna['Status'] == 1) echo "آنلاین";
				else if($wna['Status'] == 2) echo "دور از دسترس";
				?>"/></div> 
			<?php generalUserUrl($con, $wna['Name'], $factions, $factionC, $factionR); } ?></td>
            </tr>
			<?php } ?>
			<?php if($dncx['ID'] == $repp['ReportedBy'] && $repp['Status'] == 0) { ?>
			<tr>
                <td><a id="withdrawReport" href="javascript:;" data-report-id="<?php echo $repp['ID'] ?>" class="normalButton" style="margin: 0 auto;">پس گرفتن</a></td>
            </tr>
			<?php } ?>
                                                    </tbody></table>
    </div>
    </div>
                </div>
<?php
}
if(!$xx)
{
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    بازیکنان
            </div>
	<div align="center"> <div class='normalTextBox'>شکایت موردنظر وجود ندارد.</div></div>
		</div>
	</div>

<?php } ?>
</div></div></div>