<?php
$cuser = $_SESSION['username'];
	$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
$xx = 1;
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle"> حساب کاربری من
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul>
<li class="first"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/general">اطلاعات عمومی</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/achievements">دستاوردها</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/monthlyPlayed">رده بندی ماهانه</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/faction">اقلیت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/clan">کلن</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/job">شغل</a></li>
<li class="rightMenuItem"></li></ul>
</li><li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/vehicles">دارایی</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="prev"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/mystats">اطلاعات من</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="active"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/friends">دوستان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="next"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/referrals">معرفی شدگان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/moneylog">درآمد</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/namelog">تاریخچه اسم</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/warSuspendLog">تاریخچه مسدودیت رقابت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/jaillog">تاریخچه زندان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/mutelog">تاریخچه محرومیت صحبت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/suspendlog">تاریخچه مسدودیت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/warnlog">تاریخچه اخطار</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/kicklog">تاریخچه کیک</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/banlog">تاریخچه محرومیت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/security">امنیت</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/logins">آخرین ورود</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="last"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/shopTransactions">فروشگاه</a></li>
<li class="rightMenuItem"></li></ul>
</ul></div><div id="contentPage">
    <div class="subPageTitle pageTitle">
        دوستان
    </div>
        <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">نام</td>
                <td>
                    
                    آخرین ورود
                    
                </td>
                <td>
                    
                    سطح
                    
                </td>
                <td>
                    
                    امتیاز تجربه
                   
                </td>
                <td>
                    
                    ساعات بازی کرده
                    
                </td>
                <td>اقلیت</td>
                <td>
                    
                    درجه
                    
                </td>
                <td>شغل</td>
                <td class="lastTd">اخطارها</td>
            </tr>
				<?php
				$query2 = $con->prepare("SELECT * FROM `friends` WHERE `AddBy` = '{$dnn['ID']}' ORDER BY `ID`;");
				$query2->execute();
				while($dnf = $query2->fetch())
				{
					$query3 = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$dnf['friendID']}';");
					$query3->execute();
					$c = 0;
					while($dnn = $query3->fetch())
					{
					$c++
				?>
                    <tr>
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
                    <td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $dnn['LastLogin'])))) ?></td>
                    <td><?php echo $dnn['Level']; ?></td>
                    <td dir=ltr><?php echo $dnn['Respect'] ?> / <?php echo (($dnn['Level'] == 1) ? 2 : ($dnn['Level'] * 2) - 2); ?></td>
                    <td><?php echo $dnn['HoursPlayed']; ?></td>
                    <td><a href="/factions/view/<?php echo $factionA[($dnn['Member'] + $dnn['Leader'])]; ?>" style="color: #<?php echo $factionC[($dnn['Member'] + $dnn['Leader'])]; ?>;"><?php echo $factions[($dnn['Member'] + $dnn['Leader'])] ?></a></td>
                    <td dir=ltr><?php echo ($dnn['Rank'] ? $factionR[($dnn['Member'] + $dnn['Leader'])][$dnn['Rank'] - 1] : "هیچ") ?></td>
                    <td><?php echo $jobs[$dnn['Job']] ?></td>
                    <td dir=ltr><?php echo $dnn['Warns'] ?> / 3</td>
                </tr>
				<?php } } ?>
				
                    </tbody></table>
    </div>
            </div>
		</div>
<?php } if(!$xx) header("Location: /account/login"); ?> 
</div></div></div>