<?php
$query = $con->prepare("SELECT * FROM `clans` WHERE `Name` = '{$fac}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnc = $query->fetch())
{
$fid = $dnc['ID'];
$xx = 1;
?>
<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        کلن‌ها
    </div>
    <div id="contentMain">
	<div id="leftSidebar">
        <ul>
            <li class="first active">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/clans/">کلن‌ها</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/clans/wars">جنگ کلن‌ها</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
		</ul>
	</div>
    <div id="contentPage">
    <div class="contentTabberPage">
        <div class="topTabs">
            <ul>
			<li class="active"><a href="/clans/view/<?php echo $fac ?>" style="cursor:pointer;">توضیحات کلن</a>
            </li>
            <li><a href="/clans/members/<?php echo $fac ?>" style="cursor:pointer;">اعضای کلن</a>
            <li><a href="/clans/logs/<?php echo $fac ?>" style="cursor:pointer;">تاریخچه کلن</a>
			<li><a href="/clans/applications/<?php echo $fac ?>" style="cursor:pointer;">درخواست‌های عضویت</a>
                    </ul>
    </div>        <br>
        <div class="subPageTitle pageTitle">
            کلن <?php echo $fac ?>        </div>
			
			<b>اعضا: <?php echo totalClanMembers($con, $fid) ?></b>
        <br><br>
		<?php
		for($x = 7; $x > 0; $x--)
		{
		?>
        <div class="tableFull">
        <div class="tableLabel"><?php echo ($x != 7) ? "اعضای <span dir=ltr>" . $dnc['RankName' . $x] . "</span>" : "صاحبان کلن"; ?></div>
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
				<td width="3%" class="firstTd"></td>
                <td width="50%">بازیکن</td>
                <td class="lastTd">آخرین ورود</td>
            </tr>
				<?php
				$query = $con->prepare("SELECT * FROM `users` WHERE `CLeader` + `CMember` = {$fid} AND `CRank` = {$x} ORDER BY `ID`;");
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