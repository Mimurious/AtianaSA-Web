<?php
$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$user}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
$uuid = $dnn['ID'];
$query2 = $con->prepare("SELECT * FROM `factionlogs` WHERE `Player` = {$uuid} ORDER BY `ID` DESC;");
$query2->execute();
$fnn = $query2->fetch();
$xx = 1;
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    <?php echo $user ?>
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li>
<li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/general/<?php echo $user ?>">اطلاعات عمومی</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/achievements/<?php echo $user ?>">دستاوردها</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/monthlyPlayed/<?php echo $user ?>">رده بندی ماهانه</a></li><li class="rightMenuItem"></li></ul></li><li class="active"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/faction/<?php echo $user ?>">اقلیت</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/clan/<?php echo $user ?>">کلن</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/job/<?php echo $user ?>">شغل</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/vehicles/<?php echo $user ?>">دارایی</a></li><li class="rightMenuItem"></li></ul></li><li class="prev"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/playerstats/<?php echo $user ?>">اطلاعات بازیکن</a></li><li class="rightMenuItem"></li></ul></li><li class="last"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/friends/<?php echo $user ?>">دوستان</a></li><li class="rightMenuItem"></li></ul>
</ul></div><div id="contentPage">
    <div class="contentTabberPage">
        <div class="topTabs">
    <ul>
        <li class="active"><a href="/players/faction/<?php echo $user ?>" class="active">اقلیت</a></li>
        <li><a href="/players/factionActivity/<?php echo $user ?>">فعالیت اقلیت</a></li>
        <li><a href="/players/factionReports/<?php echo $user ?>">گزارش اقلیت</a></li>
        <li><a href="/players/blacklist/<?php echo $user ?>">لیست سیاه</a></li>
    </ul>
</div>    <div class="subPageContainer">
        <div class="subPageTitle pageTitle">
            اقلیت
        </div>
        <div class="actionArea">
                                </div>
    </div>
    <div id="FactionWrapper">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTableSingle">
            <tbody><tr class="firstRow">
                <td class="headerTd">عضو اقلیت</td>
                <td><font color=<?php echo $factionC[$dnn['Leader'] + $dnn['Member']] ?>><?php echo $factions[$dnn['Leader'] + $dnn['Member']] ?></font></td>
            </tr>
            <tr>
                <td class="headerTd">تاریخ عضویت</td>
                <td dir=ltr><?php
				if($dnn['Leader']) {
					$ffid = $dnn['Leader'];
					$dpp = $con->prepare("SELECT * FROM `promotes` WHERE `Target` = {$dnn['ID']} AND `Action` = 3 AND `ActionDesc` = {$ffid} ORDER BY `ID` ASC LIMIT 1;");
					$dpp->execute();
					$cq = 0;
					while($dp = $dpp->fetch())
					{
						echo jdate('Y/m/d H:i:s', $dp['Date']);
						$cq++;
					}
					if($cq == 0) echo "اطلاعاتی موجود نیست";
				}
				else {
					echo ($dnn['Leader'] + $dnn['Member']) ? jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $fnn['Date'])))) : "اطلاعاتی موجود نیست";
				}
				?></td>
            </tr>
            <tr>
                <td class="headerTd">درجه</td>
                <td dir=ltr><?php echo ($dnn['Leader'] + $dnn['Member']) ? $factionR[$dnn['Leader'] + $dnn['Member']][$dnn['Rank'] - 1] : "هیچ" ?></td>
            </tr>
            <tr>
                <td class="headerTd">اخطارهای اقلیت</td>
                <td dir=ltr><?php echo $dnn['FWarns'] ?>/3</td>
            </tr>
            <tr class="lastRow">
                <td class="headerTd">مجازات اقلیت</td>
                <td dir=ltr><?php echo $dnn['FPunish'] ?>/60</td>
            </tr>
            <tr class="lastRow">
                <td class="headerTd">زمان حضور در اقلیت</td>
                <td><?php
				if($dnn['Leader']) {
					$ffid = $dnn['Leader'];
					$dpp = $con->prepare("SELECT * FROM `promotes` WHERE `Target` = {$dnn['ID']} AND `Action` = 3 AND `ActionDesc` = {$ffid} ORDER BY `ID` ASC LIMIT 1;");
					$dpp->execute();
					$cq = 0;
					while($dp = $dpp->fetch())
					{
						$hozur = time() - $dp['Date'];
						$cq++;
					}
				if($cq == 0) echo "اطلاعاتی موجود نیست";
				else echo gmdate("j",$hozur) . " روز";
				}
				else {
					$hozur = abs(strtotime(str_replace('/', '-', str_replace(' - ', ' ', $fnn['Date']))) - time());
					echo ($dnn['Leader'] + $dnn['Member']) ? gmdate("j",$hozur) . " روز" : "اطلاعاتی موجود نیست";
				}
				?></td>
            </tr>
        </tbody></table>
    </div>
    <div class="subPageTitle pageTitle">
        برترین درجات اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>اقلیت</td>
                <td class="lastTd">درجه</td>
            </tr>
                    </tbody></table>
    </div>
    <div class="subPageTitle pageTitle">
        آخرین درخواست‌های عضویت در اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>اقلیت</td>
                <td>وضعیت</td>
                <td class="lastTd">نمایش</td>
            </tr>
                <?php
				$queryx = $con->prepare("SELECT * FROM `applications` WHERE `Player` = {$uuid} ORDER BY `ID` DESC LIMIT 7;");
				$queryx->execute();
				while($pnn = $queryx->fetch())
				{
				?>
				<tr>
					<td dir=ltr><?php echo jdate('Y/m/d H:i:s', $pnn['Date']) ?></td>
					<td><a href="/factions/view/<?php echo $factionA[($pnn['FactionID'])]; ?>" style="color: #<?php echo $factionC[($pnn['FactionID'])]; ?>;"><?php echo $factions[($pnn['FactionID'])] ?></a></td>
					<td><?php echo $factiontypes[$pnn['Status']] ?></td>
					<td><a href="/factions/application/<?php echo $pnn['ID']; ?>">نمایش</a></td>
				</tr>
				<?php
				}
				?>
                    </tbody></table>
    </div>
    <div style="text-align: left">
        <a href="/players/factionapplications/<?php echo $user ?>">نمایش همه</a>
    </div>
    <div class="subPageTitle pageTitle">
        آخرین درخواست‌های استعفاء از اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>اقلیت</td>
                <td>درجه</td>
                <td>وضعیت</td>
                <td class="lastTd">نمایش</td>
            </tr>
                    </tbody></table>
    </div>
    <div style="text-align: left">
        <a href="/account/factionresignations/<?php echo $user ?>">نمایش همه</a>
    </div>
    <div class="subPageTitle pageTitle">
        آخرین درخواست‌های مرخصی اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>اقلیت</td>
                <td>وضعیت</td>
                <td class="lastTd">نمایش</td>
            </tr>
                    </tbody></table>
    </div>
    <div style="text-align: left">
        <a href="/players/factioninactivities/<?php echo $user ?>">نمایش همه</a>
    </div>
    <div class="subPageTitle pageTitle">
        آخرین تاریخچه اقلیت
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">تاریخ</td>
                <td>توسط</td>
                <td>اقلیت</td>
                <td class="lastTd">حرکت</td>
            </tr>
                    <?php
						$queryx = $con->prepare("SELECT * FROM `factionlogs` WHERE `Player` = {$uuid} ORDER BY `ID` DESC LIMIT 7;");
						$queryx->execute();
						while($pnn = $queryx->fetch())
						{
							$uxl = $pnn['Leader'];
							$queryql = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$uxl}';");
							$queryql->execute();
							$dnl = $queryql->fetch();
						?>
                        <tr>
                            <td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $pnn['Date'])))) ?></td>
							<td><?php generalUserUrl($con, $dnl['Name'], $factions, $factionC, $factionR); ?></td>
							<td><a href="/factions/view/<?php echo $factionA[($pnn['FactionID'])]; ?>" style="color: #<?php echo $factionC[($pnn['FactionID'])]; ?>;"><?php echo $factions[($pnn['FactionID'])] ?></a></td>
							<td><?php echo numberfa(str_replace("Promoted to rank", "ارتقا به درجه ", str_replace("Left the faction (with", "اخراج از اقلیت (با ", str_replace("Left the faction", "خروج از اقلیت", str_replace("Joined the faction", "ورود به اقلیت", str_replace("Was kicked out (3 warns)", "اخراج از اقلیت (3 اخطار)", str_replace("Received FactionWarn", "دریافت اخطار اقلیت", str_replace("with", "با", str_replace("FP", "مجازات اقلیت", $pnn['Text']))))))))); ?></td>
                        </tr>
						<?php
						}
						?>
                    </tbody></table>
    </div>
    <div style="text-align: left">
        <a href="/players/factionlogs/<?php echo $user ?>">نمایش همه</a>
    </div>
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