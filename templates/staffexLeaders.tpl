<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        کارکنان
    </div>
    <div id="contentMain"><div id="leftSidebar"><ul><li class="first"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/admins">مدیران</a></li><li class="rightMenuItem"/></ul></li><li class="prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/helpers">کمک‌یاران</a></li><li class="rightMenuItem"/></ul></li><li class="last active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/leaders">راهبران اقلیت</a></li><li class="rightMenuItem"/></ul></li></ul></div>
<div id="contentPage">
    <div class="contentTabberPage">
        <div class="topTabs">
    <ul>
        <li><a href="/staff/leaders">فعال</a></li>
        <li><a href="/staff/exLeaders">بازنشسته</a></li>
    </ul>
</div>        <div class="subPageTitle pageTitle">
            راهبران اقلیت بازنشسته: <?php echo totalexLeaders($con); ?>        </div>
        <br/><br/>
                    <?php
					$arr = array();
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
							<td width="20%" class="lastTd button">بازنشسته شده در</td>
                        </tr>
						<?php
						if($x == 0) $query = $con->prepare("SELECT users.*, promotes.ID as 'pID', promotes.Target as 'pTarget', promotes.Action as 'pAction', promotes.ActionDesc as 'pActionDesc' FROM `users`,`promotes` WHERE `Leader` = 0 AND `Action` = 3 AND promotes.Target = users.ID AND (`ActionDesc` = 4 OR `ActionDesc` = 5 OR `ActionDesc` = 6) ORDER BY `ActionDesc`;");
						else if($x == 1) $query = $con->prepare("SELECT users.*, promotes.ID as 'pID', promotes.Target as 'pTarget', promotes.Action as 'pAction', promotes.ActionDesc as 'pActionDesc' FROM `users`,`promotes` WHERE `Leader` = 0 AND `Action` = 3 AND promotes.Target = users.ID AND (`ActionDesc` = 8 OR `ActionDesc` = 9 OR `ActionDesc` = 10 OR `ActionDesc` = 11) ORDER BY `ActionDesc`;");
						else if($x == 2) $query = $con->prepare("SELECT users.*, promotes.ID as 'pID', promotes.Target as 'pTarget', promotes.Action as 'pAction', promotes.ActionDesc as 'pActionDesc' FROM `users`,`promotes` WHERE `Leader` = 0 AND `Action` = 3 AND promotes.Target = users.ID AND (`ActionDesc` = 1 OR `ActionDesc` = 14 OR `ActionDesc` = 15 OR `ActionDesc` = 2 OR `ActionDesc` = 12 OR `ActionDesc` = 13) ORDER BY Field(`ActionDesc`,1,14,15,2,12,13);");
						else if($x == 3) $query = $con->prepare("SELECT users.*, promotes.ID as 'pID', promotes.Target as 'pTarget', promotes.Action as 'pAction', promotes.ActionDesc as 'pActionDesc' FROM `users`,`promotes` WHERE `Leader` = 0 AND `Action` = 3 AND promotes.Target = users.ID AND (`ActionDesc` = 3 OR `ActionDesc` = 7) ORDER BY `ActionDesc`;");
						$query->execute();
						$c = 0;
						while($dnn = $query->fetch())
						{
						if(in_array($dnn['ID'], $arr)) break;
						$arr = array_merge($arr, array($c => $dnn['ID']));
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
                    <?php generalUserUrl($con, $dnn['Name'], $factions, $factionC, $factionR); ?>
                </div></td>
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
                            <td><a href="/factions/view/<?php echo $factionA[($dnn['pActionDesc'])]; ?>" style="color: #<?php echo $factionC[$dnn['pActionDesc']]; ?>;"><?php echo $factions[$dnn['pActionDesc']] ?></a></td>
							<td dir=ltr><?php 
							$dpp = $con->prepare("SELECT * FROM `promotes` WHERE `Target` = {$dnn['ID']} AND `Action` = 3 ORDER BY `ID` DESC LIMIT 1;");
							$dpp->execute();
							$cq = 0;
							while($dp = $dpp->fetch())
							{
								echo jdate('Y/m/d H:i:s', $dp['Date']);
								$cq++;
							}
							if($cq == 0) echo "اطلاعاتی موجود نیست";
							?></td>
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