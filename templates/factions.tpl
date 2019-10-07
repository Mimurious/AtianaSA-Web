<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        اقلیت‌ها
    </div>
    <div id="contentMain">
    <div id="leftSidebar">
        <ul>
            <li class="first active">
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
            <li>
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
    <?php
	for($x = 0; $x < sizeof($factionCa); $x++)
	{
	?>
    <div class="subPageTitle pageTitle">
        <?php echo $factionCa[$x]; ?>
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tr><td colspan="7"  style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><a href="/factions/<?php echo $factionCA[$x]; ?>Rules" style="font-weight:bold; color:#FF0000 !important; font-size:20px;">قوانین <?php echo $factionCa[$x]; ?></a></td></tr>
            <tr class="headerRow">
                <td width="20%" style="padding-top:10px;">نام</td>
                <td width="8%" style="padding-top:10px;">اعضا</td>
                <td width="8%" style="padding-top:10px;">پیش نیاز</td>
                <td width="20%" style="padding-top:10px;">وضعیت درخواست‌های عضویت</td>
                <td width="20%" style="padding-top:10px;">زمان اتمام فرصت درخواست</td>
                <td width="24%" style="padding-top:10px;">عملیات</td>
            </tr>
				<?php
					if($x == 0) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 4 OR `ID` = 5 OR `ID` = 6 ORDER BY `ID`;");
					else if($x == 1) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 8 OR `ID` = 9 OR `ID` = 10 OR `ID` = 11 ORDER BY `ID`;");
					else if($x == 2) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 1 OR `ID` = 14 OR `ID` = 15 OR `ID` = 2 OR `ID` = 12 OR `ID` = 13 ORDER BY Field(`ID`,1,14,15,2,12,13);");
					else if($x == 3) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 3 OR `ID` = 7 ORDER BY `ID`;");
					$query->execute();
					$c = 0;
					while($dnn = $query->fetch())
					{
					$c++;
					?>
                                            <tr>
                    <td><a href="/factions/view/<?php echo $factionA[($dnn['ID'])]; ?>" style="color: #<?php echo $factionC[($dnn['ID'])]; ?>;"><?php echo $factions[($dnn['ID'])] ?></a></td>
                    <td dir=ltr><?php echo totalFactionMembers($con, $dnn['ID']) ?> / <?php echo ($dnn['Slot']) ?></td>
                    <td>سطح <?php echo ($dnn['MinLvl']) ?></td>
                    <td>
					<?php
					if($dnn['Opened']) echo "<i class='showTooltip material-icons' data-toggle='tooltip' title='باز' style='color:#1bd427;'>lock_open</i>";
					else echo "<i class='showTooltip material-icons' data-toggle='tooltip' title='بسته' style='color:#e74015;'>lock</i>";
					 ?>
                                            </td>
                    <td dir=ltr><?php echo ($dnn['EndDate']) ? jdate("Y/m/d H:i:s", $dnn['EndDate']) : "تنظیم نشده"; ?></td>
                    <td>
					<?php
					$cuser = $_SESSION['username'];
					$queryp = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
					$queryp->execute();
					$dnx = $queryp->fetch();
					if(!$dnn['Opened']) echo "<span style='color:#5f5f5f;'>درخواست‌های عضویت بسته هستند</span>";
					else if(totalFactionMembers($con, $dnn['ID']) >= $dnn['Slot']) echo "<span style='color:#5f5f5f;'>ظرفیت اقلیت تکمیل است</span>";
					else if($dnx['Level'] < $dnn['MinLvl'] || $dnx['Rank'] != 0) echo "<span style='color:#5f5f5f;'>شما نمیتوانید برای اینجا درخواست دهید</span>";
					else
					{
					?>
					<a class="normalButton" style="margin: 5px auto;" href="/factions/apply/<?php echo $factionA[($dnn['ID'])]; ?>">درخواست</a>
					<?php } ?>
					</td>
                </tr>
					<?php
					}
					?>
                    </table>
                        </div>
						<?php
					}
					?>
						</div>
                </div>
				</div></div></div>
