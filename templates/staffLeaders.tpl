<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        کارکنان
    </div>
    <div id="contentMain"><div id="leftSidebar"><ul><li class="first"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/admins">مدیران</a></li><li class="rightMenuItem"/></ul></li><li class="prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/helpers">کمک‌یاران</a></li><li class="rightMenuItem"/></ul></li><li class="last active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/leaders">راهبران اقلیت</a></li><li class="rightMenuItem"/></ul></li></ul></div>
<div id="contentPage">
    <div class="contentTabberPage">
        <div class="topTabs">
    <ul>
        <li><a href="/staff/leaders" class="active">فعال</a></li>
        <li><a href="/staff/exLeaders">بازنشسته</a></li>
    </ul>
</div>        <div class="subPageTitle pageTitle">
            راهبران اقلیت: <?php echo totalLeaders($con); ?>        </div>
        <br/><br/>
                    <?php
					for($x = 0; $x < sizeof($factionCa); $x++)
					{
					
					?>
					<div class="tableFull">
                    <div class="subPageTitle pageTitle">
                        <?php echo $factionCa[$x]; ?>
                    </div>
                    <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
                        <tr class="headerRow">
							<td width="3%" class="firstTd"></td>
                            <td width="22%">بازیکن</td>
                            <td width="20%">منصوب شده در</td>
                            <td width="20%">اقلیت</td>
							<td width="15%">اخطارهای راهبری</td>
                            <td width="20%" class="lastTd button">آخرین ورود</td>
                        </tr>
						<?php
						if($x == 0) $query = $con->prepare("SELECT * FROM `users` WHERE (`Leader` = 4 OR `Leader` = 5 OR `Leader` = 6) AND (`AdminLevel` = 0 OR `AdminLevel` > 8) ORDER BY `Leader`;");
						else if($x == 1) $query = $con->prepare("SELECT * FROM `users` WHERE (`Leader` = 8 OR `Leader` = 9 OR `Leader` = 10 OR `Leader` = 11) AND (`AdminLevel` = 0 OR `AdminLevel` > 8) ORDER BY `Leader`;");
						else if($x == 2) $query = $con->prepare("SELECT * FROM `users` WHERE (`Leader` = 1 OR `Leader` = 14 OR `Leader` = 15 OR `Leader` = 2 OR `Leader` = 12 OR `Leader` = 13) AND (`AdminLevel` = 0 OR `AdminLevel` > 8) ORDER BY Field(`Leader`,1,14,15,2,12,13);");
						else if($x == 3) $query = $con->prepare("SELECT * FROM `users` WHERE (`Leader` = 3 OR `Leader` = 7) AND (`AdminLevel` = 0 OR `AdminLevel` > 8) ORDER BY `Leader`;");
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
                            <td dir=ltr><?php 
							$dpp = $con->prepare("SELECT * FROM `promotes` WHERE `Target` = {$dnn['ID']} AND `Action` = 3 ORDER BY `ID` ASC LIMIT 1;");
							$dpp->execute();
							$cq = 0;
							while($dp = $dpp->fetch())
							{
								echo jdate('Y/m/d H:i:s', $dp['Date']);
								$cq++;
							}
							if($cq == 0) echo "اطلاعاتی موجود نیست";
							?></td>
                            <td><a href="/factions/view/<?php echo $factionA[$dnn['Leader']]; ?>" style="color: #<?php echo $factionC[($dnn['Member'] + $dnn['Leader'])]; ?>;"><?php echo $factions[($dnn['Member'] + $dnn['Leader'])] ?></a></td>
							<td dir=ltr><?php echo $dnn['FWarns'] ?>/3</td>
                            <td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $dnn['LastLogin'])))) ?></td>
                        </tr>
						<?php
						}
						?>
                        </table>
                        <div class="tableSubtotal">تعداد: <?php echo $c; ?> راهبر</div>
                    </div>
					<?php
					}
					?>
                        </div>            </div>
                </div>
</div></div></div>