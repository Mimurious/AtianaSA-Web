<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        کارکنان
    </div>
    <div id="contentMain"><div id="leftSidebar"><ul><li class="first prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/admins">مدیران</a></li><li class="rightMenuItem"/></ul></li><li class="active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/helpers">کمک‌یاران</a></li><li class="rightMenuItem"/></ul></li><li class="last"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/staff/leaders">راهبران اقلیت</a></li><li class="rightMenuItem"/></ul></li></ul></div>
<div id="contentPage">
    <div class="contentTabberPage">
        <div class="topTabs">
    <ul>
        <li><a href="/staff/helpers">فعال</a></li>
        <li><a href="/staff/exHelpers">بازنشسته</a></li>
    </ul>
</div>        <div class="subPageTitle pageTitle">
            کمک‌یاران: <?php echo totalHelpers($con); ?>        </div>
        <br/><br/>
                    <?php
					for($x = 3; $x > 0; $x--)
					{
					?>
					<div class="tableFull">
                    <div class="subPageTitle pageTitle">
                        کمک‌یاران سطح <?php echo $x; ?>
                    </div>
                    <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
                        <tr class="headerRow">
							<td width="3%" class="firstTd"></td>
                            <td width="22%">بازیکن</td>
                            <td width="25%">منصوب شده در</td>
                            <td width="25%">آخرین ارتقاء</td>
                            <td width="25%" class="lastTd button">آخرین ورود</td>
                        </tr>
						<?php
						$query = $con->prepare("SELECT * FROM `users` WHERE `HelperLevel` = {$x} AND (`AdminLevel` = 0 OR `AdminLevel` > 8) ORDER BY `ID`;");
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
							$dpp = $con->prepare("SELECT * FROM `promotes` WHERE `Target` = {$dnn['ID']} AND `Action` = 2 ORDER BY `ID` ASC LIMIT 1;");
							$dpp->execute();
							$cq = 0;
							while($dp = $dpp->fetch())
							{
								echo jdate('Y/m/d H:i:s', $dp['Date']);
								$cq++;
							}
							if($cq == 0) echo "اطلاعاتی موجود نیست";
							?></td>
                            <td dir=ltr><?php 
							$dpp = $con->prepare("SELECT * FROM `promotes` WHERE `Target` = {$dnn['ID']} AND `Action` = 2 ORDER BY `ID` DESC LIMIT 1;");
							$dpp->execute();
							$cq = 0;
							while($dp = $dpp->fetch())
							{
								echo jdate('Y/m/d H:i:s', $dp['Date']);
								$cq++;
							}
							if($cq == 0) echo "اطلاعاتی موجود نیست";
							?></td>
                            <td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $dnn['LastLogin'])))) ?></td>
                        </tr>
						<?php
						}
						?>
                        </table>
                        <div class="tableSubtotal">تعداد: <?php echo $c; ?> کمک‌یار</div>
                    </div>
					<?php
					}
					?>
                        </div>            </div>
                </div>
</div></div></div>