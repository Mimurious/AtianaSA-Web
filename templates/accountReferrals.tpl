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
<li><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/mystats">اطلاعات من</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="prev"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/friends">دوستان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="active"><ul><li class="leftMenuItem"></li>
<li class="menuItem"><a href="/account/referrals">معرفی شدگان</a></li>
<li class="rightMenuItem"></li></ul></li>
<li class="next"><ul><li class="leftMenuItem"></li>
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
</ul></div>
<div class="contentTabberPage">
        <div class="topTabs">
    <ul>
        <li class="active"><a href="/account/referrals" class="active">فعال</a></li>
        <li><a href="/account/inactiveReferrals">غیرفعال</a></li>
    </ul>
</div>
    <div class="subPageContainer">
        <div class="subPageTitleRight pageTitle">
            معرفی شدگان
        </div>
        <div class="searchBox" style="margin: 15px 15px;">
            <input id="accountReferralsSearchInput" class="searchInput inputblank placeholderContent" value="جستجو بر اساس نام بازیکن" type="text" restore="جستجو بر اساس نام بازیکن">
            <input data-location="/account/referrals/search/" id="accountReferralsSearchButton" type="button" class="searchButton" value="جستجو">
        </div>
    </div>
    <div class="normalTextBox">
				<b>شناسه معرفی شما: <?php echo $dnn['ID']; ?></b><br><br>
				این شناسه‌ای است که برای معرفی به سایر بازیکنان برای دعوت آنها به این بازی در هنگام ثبت نام از درون خود بازی نیاز خواهید داشت.<br><br><br>
                <b>آدرس معرفی شما: <textarea style="width:500px; height:20px; direction: ltr;">https://sa.atiana.ir/account/register/?ref=<?php echo $dnn['ID']; ?></textarea></b><br><br>
        این آدرسی است که برای معرفی به سایر بازیکنان برای دعوت آنها به این بازی نیاز خواهید داشت.<br>
        <br><br>
        در هنگام فعالیت و ارتقاء سطح توسط آنها، شما نیز مشمول دریافت جوایزی خواهید شد.<br><br>
        شما 25% از تعداد امتیازات تجربه موردنیاز فرد برای ارتقاء سطح با استفاده از دستور <span dir=ltr>/levelup</span> را دریافت خواهید کرد.<br>
        شما 200% از مجموع پولی که فرد برای ارتقاء سطح با استفاده از دستور <span dir=ltr>/levelup</span> از دست خواهد داد را دریافت خواهید کرد.<br>
    </div>
		<div class="tableFull">
            <table class="fullTable" cellspacing="0" cellpadding="0" border="0">
                                    <tbody><tr class="headerRow">
                        <td class="firstTd">بازیکن</td>
                        <td>تاریخ عضویت</td>
                        <td>
                            آخرین ورود
                        </td>
                        <td>
                            ساعات بازی‌کرده
                        </td>
                        <td>
                            سطح
                        </td>
                        <td class="lastTd">
                            امتیاز تجربه
                        </td>
                    </tr> 
        <?php
				$query2 = $con->prepare("SELECT * FROM `users` WHERE `Referral` = '{$dnn['ID']}' ORDER BY `ID`;");
				$query2->execute();
				while($dnf = $query2->fetch())
				{
				?>
                    <tr>
                    <td><div style="overflow: hidden; display: table; margin: 0 auto;">
                    <div style="float: right; margin-left: 5px;"><img class="showTooltip" style="display: block; margin-top: 3px;" src="public/img/<?php 
						if($dnf['Status'] == 0) echo "offline";
						else if($dnf['Status'] == 1) echo "online";
						else if($dnf['Status'] == 2) echo "afk";
						?>.png" alt="<?php 
						if($dnf['Status'] == 0) echo "آفلاین";
						else if($dnf['Status'] == 1) echo "آنلاین";
						else if($dnf['Status'] == 2) echo "دور از دسترس";
						?>" data-toggle="tooltip" title="<?php 
						if($dnf['Status'] == 0) echo "آفلاین";
						else if($dnf['Status'] == 1) echo "آنلاین";
						else if($dnf['Status'] == 2) echo "دور از دسترس";
						?>"/></div>
                    <?php generalUserUrl($con, $dnf['Name'], $factions, $factionC, $factionR); ?>
                </div></td>
					<td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $dnf['RegisteredDate'])))) ?></td>
                    <td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $dnf['LastLogin'])))) ?></td>
                    <td><?php echo $dnf['HoursPlayed']; ?></td>
					<td><?php echo $dnf['Level']; ?></td>
                    <td dir=ltr><?php echo $dnf['Respect'] ?> / <?php echo (($dnf['Level'] == 1) ? 2 : ($dnf['Level'] * 2) - 2); ?></td>
                </tr>
				<?php } ?>
				</tbody></table>
                                </div>
		
    <div class="normalTextBox">
        <b>مقدار جوایز پول قابل دریافت:</b> $<?php echo number_format($dnn['ReferralMoney']); ?><br>
        <b>مقدار پول‌ها تا به حال:</b> $<?php echo number_format($dnn['TReferralMoney']); ?><br>
        <b>تعداد جوایز امتیازات تجربه قابل دریافت:</b> <?php echo $dnn['ReferralRespect']; ?><br>
        <b>تعداد امتیازات تجربه تا به حال:</b> <?php echo $dnn['TReferralRespect']; ?><br>
		<?php if($dnn['Status'] != 0) { ?>
		<button class="normalButton" style="margin: 0 auto;"><s>جمع‌آوری جوایز</s> - <font color=red>برای جمع‌آوری جوایز شما نباید در بازی آنلاین باشید.</font></button>
		<?php } else { ?><a href="/account/referrals/collect"><button class="normalButton" style="margin: 0 auto;">جمع‌آوری جوایز</button></a><?php } ?>
    </div>
    </div>
		</div>
<?php } if(!$xx) header("Location: /account/login"); ?> 
</div></div></div>