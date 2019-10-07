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
<li class="prev"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/clan">کلن</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="active"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/job">شغل</a></li>
<li class="rightMenuItem"></li></ul>
</li><li class="next"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/vehicles">دارایی</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/mystats">اطلاعات من</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/friends">دوستان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li><ul><li class="leftMenuItem"></li>
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
        شغل
    </div>
        <div id="FactionWrapper">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTableSingle">
            <tbody><tr class="firstRow">
                <td class="headerTd">شغل کنونی</td>
                <td><?php echo $jobs[$dnn['Job']] ?></td>
            </tr>
        </tbody></table>
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTableSingle">
            <tbody><tr class="headerRow">
                <td class="firstTd">شغل</td>
                <td>مهارت</td>
                <td>پیشرفت</td>
            </tr>
                            <tr>
                    <td class="headerTd">رانندگی کامیون</td>
                    <td><?php
					$skillp = $dnn['TruckerSkill'];
					if($skillp >= 0 && $skillp <= 30) echo 1;
					else if($skillp > 30 && $skillp <= 90) echo 2;
					else if($skillp > 90 && $skillp <= 210) echo 3;
					else if($skillp > 210 && $skillp <= 450) echo 4;
					else if($skillp > 450) echo 5;
					?></td>
                    <td>
                        <div class="progress progress-danger progress-striped">
						<?php
						if($skillp >= 0 && $skillp <= 30) $percent = $skillp;
						else if($skillp > 30 && $skillp <= 90) $percent = (($skillp - 30) / 60) * 100;
						else if($skillp > 90 && $skillp <= 210) $percent = (($skillp - 90) / 120) * 100;
						else if($skillp > 210 && $skillp <= 450) $percent = (($skillp - 210) / 240) * 100;
						else if($skillp > 450) $percent = 100;
						?>
                            <div class="bar" style="width: <?php echo floor($percent) ?>%"><?php echo floor($percent) ?>%</div>
                        </div>
                    </td>
                </tr>
                            <tr>
                    <td class="headerTd">آشغال جمع‌کنی</td>
                    <td><?php
					$skillp = $dnn['GarbageSkill'];
					if($skillp >= 0 && $skillp <= 30) echo 1;
					else if($skillp > 30 && $skillp <= 90) echo 2;
					else if($skillp > 90 && $skillp <= 210) echo 3;
					else if($skillp > 210 && $skillp <= 450) echo 4;
					else if($skillp > 450) echo 5;
					?></td>
                    <td>
                        <div class="progress progress-danger progress-striped">
						<?php
						if($skillp >= 0 && $skillp <= 30) $percent = $skillp;
						else if($skillp > 30 && $skillp <= 90) $percent = (($skillp - 30) / 60) * 100;
						else if($skillp > 90 && $skillp <= 210) $percent = (($skillp - 90) / 120) * 100;
						else if($skillp > 210 && $skillp <= 450) $percent = (($skillp - 210) / 240) * 100;
						else if($skillp > 450) $percent = 100;
						?>
                            <div class="bar" style="width: <?php echo floor($percent) ?>%"><?php echo floor($percent) ?>%</div>
                        </div>
                    </td>
                </tr>
                            <tr>
                    <td class="headerTd">دزدی از بانک</td>
                    <td><?php
					$skillp = $dnn['RobSkill'];
					if($skillp >= 0 && $skillp <= 25) echo 1;
					else if($skillp > 25 && $skillp <= 75) echo 2;
					else if($skillp > 75 && $skillp <= 150) echo 3;
					else if($skillp > 150 && $skillp <= 250) echo 4;
					else if($skillp > 250) echo 5;
					?></td>
                    <td>
                        <div class="progress progress-danger progress-striped">
						<?php
						if($skillp >= 0 && $skillp <= 25) $percent = $skillp;
						else if($skillp > 25 && $skillp <= 75) $percent = (($skillp - 25) / 50) * 100;
						else if($skillp > 75 && $skillp <= 150) $percent = (($skillp - 75) / 75) * 100;
						else if($skillp > 150 && $skillp <= 250) $percent = (($skillp - 150) / 100) * 100;
						else if($skillp > 250) $percent = 100;
						?>
                            <div class="bar" style="width: <?php echo floor($percent) ?>%"><?php echo floor($percent) ?>%</div>
                        </div>
                    </td>
                </tr>
                            <tr>
                    <td class="headerTd">مکانیکی</td>
                    <td><?php
					$skillp = $dnn['MechanicSkill'];
					if($skillp >= 0 && $skillp <= 50) echo 1;
					else if($skillp > 50 && $skillp <= 100) echo 2;
					else if($skillp > 100 && $skillp <= 200) echo 3;
					else if($skillp > 200 && $skillp <= 400) echo 4;
					else if($skillp > 400) echo 5;
					?></td>
                    <td>
                        <div class="progress progress-danger progress-striped">
						<?php
						if($skillp >= 0 && $skillp <= 50) $percent = $skillp;
						else if($skillp > 50 && $skillp <= 100) $percent = (($skillp - 50) / 50) * 100;
						else if($skillp > 100 && $skillp <= 200) $percent = (($skillp - 100) / 100) * 100;
						else if($skillp > 200 && $skillp <= 400) $percent = (($skillp - 200) / 200) * 100;
						else if($skillp > 400) $percent = 100;
						?>
                            <div class="bar" style="width: <?php echo floor($percent) ?>%"><?php echo floor($percent) ?>%</div>
                        </div>
                    </td>
                </tr>
                            <tr>
                    <td class="headerTd">کشاورزی</td>
                    <td><?php
					$skillp = $dnn['FarmerSkill'];
					if($skillp >= 0 && $skillp <= 150) echo 1;
					else if($skillp > 150 && $skillp <= 450) echo 2;
					else if($skillp > 450 && $skillp <= 1050) echo 3;
					else if($skillp > 1050 && $skillp <= 2250) echo 4;
					else if($skillp > 2250) echo 5;
					?></td>
                    <td>
                        <div class="progress progress-danger progress-striped">
						<?php
						if($skillp >= 0 && $skillp <= 150) $percent = $skillp;
						else if($skillp > 150 && $skillp <= 450) $percent = (($skillp - 150) / 300) * 100;
						else if($skillp > 450 && $skillp <= 1050) $percent = (($skillp - 450) / 60) * 100;
						else if($skillp > 1050 && $skillp <= 2250) $percent = (($skillp - 1050) / 1200) * 100;
						else if($skillp > 2250) $percent = 100;
						?>
                            <div class="bar" style="width: <?php echo floor($percent) ?>%"><?php echo floor($percent) ?>%</div>
                        </div>
                    </td>
                </tr>
                            <tr>
                    <td class="headerTd">پیک پیتزایی</td>
                    <td><?php
					$skillp = $dnn['PizzaSkill'];
					if($skillp >= 0 && $skillp <= 150) echo 1;
					else if($skillp > 150 && $skillp <= 450) echo 2;
					else if($skillp > 450 && $skillp <= 1050) echo 3;
					else if($skillp > 1050 && $skillp <= 2250) echo 4;
					else if($skillp > 2250) echo 5;
					?></td>
                    <td>
                        <div class="progress progress-danger progress-striped">
						<?php
						if($skillp >= 0 && $skillp <= 150) $percent = $skillp;
						else if($skillp > 150 && $skillp <= 450) $percent = (($skillp - 150) / 300) * 100;
						else if($skillp > 450 && $skillp <= 1050) $percent = (($skillp - 450) / 60) * 100;
						else if($skillp > 1050 && $skillp <= 2250) $percent = (($skillp - 1050) / 1200) * 100;
						else if($skillp > 2250) $percent = 100;
						?>
                            <div class="bar" style="width: <?php echo floor($percent) ?>%"><?php echo floor($percent) ?>%</div>
                        </div>
                    </td>
                </tr>
                            <tr>
                    <td class="headerTd">چمن‌زنی</td>
                    <td><?php
					$skillp = $dnn['MowerSkill'];
					if($skillp >= 0 && $skillp <= 150) echo 1;
					else if($skillp > 150 && $skillp <= 450) echo 2;
					else if($skillp > 450 && $skillp <= 1050) echo 3;
					else if($skillp > 1050 && $skillp <= 2250) echo 4;
					else if($skillp > 2250) echo 5;
					?></td>
                    <td>
                        <div class="progress progress-danger progress-striped">
						<?php
						if($skillp >= 0 && $skillp <= 150) $percent = $skillp;
						else if($skillp > 150 && $skillp <= 450) $percent = (($skillp - 150) / 300) * 100;
						else if($skillp > 450 && $skillp <= 1050) $percent = (($skillp - 450) / 60) * 100;
						else if($skillp > 1050 && $skillp <= 2250) $percent = (($skillp - 1050) / 1200) * 100;
						else if($skillp > 2250) $percent = 100;
						?>
                            <div class="bar" style="width: <?php echo floor($percent) ?>%"><?php echo floor($percent) ?>%</div>
                        </div>
                    </td>
                </tr>
                            <tr>
                    <td class="headerTd">مواد فروشی</td>
                    <td><?php
					$skillp = $dnn['DrugsSkill'];
					if($skillp >= 0 && $skillp <= 150) echo 1;
					else if($skillp > 150 && $skillp <= 450) echo 2;
					else if($skillp > 450 && $skillp <= 1050) echo 3;
					else if($skillp > 1050 && $skillp <= 2250) echo 4;
					else if($skillp > 2250) echo 5;
					?></td>
                    <td>
                        <div class="progress progress-danger progress-striped">
						<?php
						if($skillp >= 0 && $skillp <= 150) $percent = $skillp;
						else if($skillp > 150 && $skillp <= 450) $percent = (($skillp - 150) / 300) * 100;
						else if($skillp > 450 && $skillp <= 1050) $percent = (($skillp - 450) / 60) * 100;
						else if($skillp > 1050 && $skillp <= 2250) $percent = (($skillp - 1050) / 1200) * 100;
						else if($skillp > 2250) $percent = 100;
						?>
                            <div class="bar" style="width: <?php echo floor($percent) ?>%"><?php echo floor($percent) ?>%</div>
                        </div>
                    </td>
                </tr>
            </tr>
        </tbody></table>
    </div>
	</div>
</div>
<?php } if(!$xx) header("Location: /account/login"); ?> 
</div></div></div>