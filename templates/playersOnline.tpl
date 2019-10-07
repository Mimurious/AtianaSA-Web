<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    بازیکنان
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li class="last"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li></ul></div><div id="contentPage">
    <div class="subPageTitle pageTitle">
        بازیکنان آنلاین: <?php echo totalOnline($con); ?>    </div>

<?php
if(totalOnline($con) > 0)
{
?>
<div style="clear:both;">
</div>

<?php
	for($i = 0; $i < sizeof($factions); $i++)
	{
	if(totalFactionOnline($con, $i) == 0) continue;
?>
	<div class="subPageTitle pageTitle"><?php echo "<font color='#{$factionC[$i]}'>{$factions[$i]}</font> (" . totalFactionOnline($con, $i) . " نفر آنلاین)" ?>:</div>
	<br />
	<div dir=ltr>
	<?php
	$query = $con->prepare("SELECT * FROM `users` WHERE `Status` != 0 AND `Member` + `Leader` = {$i} ORDER BY `Rank` DESC, `Level` DESC;");
	$query->execute();
	$c = 0;
	while($dnn = $query->fetch())
	{
	$c++;
	?>
	<div style="float:left;"><a href="/players/general/<?php echo $dnn['Name'] ?>"><img class="onlinePhoto" src="public/img/Skins/thumb/<?php echo $dnn['Skin']; ?>.png" alt="skin"></a><?php generalUserUrl($con, $dnn['Name'], $factions, $factionC, $factionR); ?> 
	<?php
	if($dnn['Rank']) echo "(" . ($dnn['Rank'] == 7 ? "Leader" : $dnn['Rank']) . ")";
	?></div>
	<?php
	}
	?>
	</div>
	<br />
	<br />
<?php
	}

}
else echo "هیچ بازیکنی آنلاین نیست.";
?>

<div style="clear:both;">
</div>

<br /><br /></div>
                </div>
</div></div></div>