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
<li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/general/<?php echo $user ?>">اطلاعات عمومی</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/achievements/<?php echo $user ?>">دستاوردها</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/monthlyPlayed/<?php echo $user ?>">رده بندی ماهانه</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/faction/<?php echo $user ?>">اقلیت</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/clan/<?php echo $user ?>">کلن</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/job/<?php echo $user ?>">شغل</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/vehicles/<?php echo $user ?>">دارایی</a></li><li class="rightMenuItem"></li></ul></li><li class="prev"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/playerstats/<?php echo $user ?>">اطلاعات بازیکن</a></li><li class="rightMenuItem"></li></ul></li><li class="last active"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/friends/<?php echo $user ?>">دوستان</a></li><li class="rightMenuItem"></li></ul>
</ul></div><div id="contentPage">
    <div class="subPageContainer">
        <div class="subPageTitle pageTitle">
            دوستان
        </div>
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
				$query2 = $con->prepare("SELECT * FROM `friends` WHERE `AddBy` = '{$dnx['ID']}' ORDER BY `ID`;");
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