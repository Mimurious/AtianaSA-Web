<?php
$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$user}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnx = $query->fetch())
{
$xx = 1;
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    <?php echo $user ?>
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li>
<li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/general/<?php echo $user ?>">اطلاعات عمومی</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/achievements/<?php echo $user ?>">دستاوردها</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/monthlyPlayed/<?php echo $user ?>">رده بندی ماهانه</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/faction/<?php echo $user ?>">اقلیت</a></li><li class="rightMenuItem"></li></ul></li><li class="prev"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/clan/<?php echo $user ?>">کلن</a></li><li class="rightMenuItem"></li></ul></li><li class="active"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/job/<?php echo $user ?>">شغل</a></li><li class="rightMenuItem"></li></ul></li><li class="next"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/vehicles/<?php echo $user ?>">دارایی</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/playerstats/<?php echo $user ?>">اطلاعات بازیکن</a></li><li class="rightMenuItem"></li></ul></li><li class="last"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/friends/<?php echo $user ?>">دوستان</a></li><li class="rightMenuItem"></li></ul>
</ul></div><div id="contentPage">
    <div class="subPageContainer">
        <div class="subPageTitle pageTitle">
            شغل
        </div>
    </div>
        <div id="FactionWrapper">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTableSingle">
            <tbody><tr class="firstRow">
                <td class="headerTd">شغل کنونی</td>
                <td><?php echo $jobs[$dnx['Job']] ?></td>
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
					$skillp = $dnx['TruckerSkill'];
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
					$skillp = $dnx['GarbageSkill'];
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
					$skillp = $dnx['RobSkill'];
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
					$skillp = $dnx['MechanicSkill'];
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
					$skillp = $dnx['FarmerSkill'];
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
					$skillp = $dnx['PizzaSkill'];
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
					$skillp = $dnx['MowerSkill'];
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
					$skillp = $dnx['DrugsSkill'];
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
<?php
}
if(!$xx)
{
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    بازیکنان
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li class="last"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li></ul></div><div id="contentPage">
   <div class="subPageTitle pageTitle">
        جستجوی بازیکن
    </div>
    <div align="center"> <div class='normalTextBox'>بازیکن مورد نظر پیدا نشد، از صحیح بودن اطلاعات ورودی اطمینان حاصل کنید.<br><br>
	<div class="autosuggestDivContainer">
                <div class="inputSearchSuggestion" id="searchPlayerNameDiv">
                    <input name="name" type="text" dir=ltr class="autosuggestNormalInput textarea" id="searchPlayerName" value="<?php echo $user ?>" />
                </div>
            </div>
			</div>
    
<script>
    $(document).ready(function() {
        $("#searchPlayerName").autoSuggest("/players/autosuggest/",
        {
            resultARender: function(data, value)
            {
                var $a = $('<a class="autosuggestResultA" data-data="'+data+'" href="/players/general/'+value+'">' + value + '</a>');
                return $a;
            }
        });
  
            });
</script>            </div>
                </div>
			</div>
		</div>
	</div>

<?php } ?>
</div></div></div>