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
            کمک‌یاران بازنشسته: <?php echo totalexHelpers($con); ?>        </div>
        <br/><br/>
                    <?php
					$arr = array();
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
                            <td width="20%">بازیکن</td>
                            <td width="19%">منصوب شده در</td>
                            <td width="19%" class="lastTd button">بازنشسته شده در</td>
                        </tr>
						<?php
						$query2 = $con->prepare("SELECT users.*, promotes.ID as 'pID', promotes.Target as 'pTarget', promotes.Action as 'pAction', promotes.ActionDesc as 'pActionDesc' FROM `users`,`promotes` WHERE `HelperLevel` = 0 AND `Action` = 2 AND `ActionDesc` = {$x} AND promotes.Target = users.ID ORDER BY promotes.ID ASC;");
						$query2->execute();
						$c = 0;
						while($dnn = $query2->fetch())
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