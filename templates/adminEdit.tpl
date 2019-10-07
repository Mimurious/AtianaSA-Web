<?php
if($dncx['AdminLevel'] != 8) die();

if(isset($_POST['warns'])) {
	$warns = $_POST['warns'];
	$spouse = $_POST['spouse'];
	$premium = $_POST['premiumaccount'];
	$level = $_POST['level'];
	$respect = $_POST['respect'];
	$hoursplayed = $_POST['hoursplayed'];
	$phonenumber = $_POST['phone'];
	$crimes = $_POST['crimes'];
	$arrests = $_POST['arrests'];
	$wanteddeaths = $_POST['wanteddeaths'];
	$drivinglic = $_POST['drivinglic'];
	$flyinglic = $_POST['flyinglic'];
	$saillic = $_POST['saillic'];
	$gunlic = $_POST['gunlic'];
	
	$queryx = $con->prepare("UPDATE `users` SET `Warns` = {$warns}, `Spouse` = '{$spouse}', `PremiumAccount` = {$premium}, `Level` = {$level}, `Respect` = {$respect}, `HoursPlayed` = {$hoursplayed}, PhoneNumber = {$phonenumber}, `Crimes` = {$crimes}, `Arrests` = {$arrests}, `WantedDeaths` = {$wanteddeaths}, `DrivingLic` = {$drivinglic}, `FlyingLic` = {$flyinglic}, `SailLic` = {$saillic}, `GunLic` = {$gunlic} WHERE `Name` = '{$user}';");
	$queryx->execute();
}

$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$user}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
$xx = 1;
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    <?php echo $user ?>
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first  active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/admin/general">حساب های کاربری</a></li></ul>
</div><div id="contentPage">
    <div class="subPageTitle pageTitle">
        اطلاعات عمومی
		<?php echo $user; ?>
    </div>
    <div id="wrapper">
	<?php if(isset($_POST['warns'])) { ?><div align="center"><div class='normalTextBox'>تغییرات ثبت شد. جهت بازدید از پروفایل این کاربر <a href="/players/general/<?php echo $dnn['Name'] ?>">اینجا</a> کلیک کنید.</div></div><?php } ?>
	<form method="post">
        <div id="skin">
            <img class="skinImg" src="public/img/Skins/<?php echo $dnn['Skin']; ?>.png" alt="اسکین">
        </div>
        <div class="generalRight">
            <div class="centerbox-outer">
                <div class="centerbox-inner">
                    <div class="badges">
												<?php if($dnn['AdminLevel'] != 0) { ?><div class="badgeIcon"><img class="showTooltip" data-toggle="tooltip" title="<?php echo ($dnn['AdminLevel'] >= 6 ? $alvls[$dnn['AdminLevel']] : "مدیر سطح {$dnn['AdminLevel']}") ?>" src="public/img/admin.png"/></div><?php } ?>
												<?php if($dnn['HelperLevel'] != 0) { ?><div class="badgeIcon"><img class="showTooltip" data-toggle="tooltip" title="کمک‌یار سطح <?php echo $dnn['HelperLevel'] ?>" src="public/img/helper.png"/></div><?php } ?>
												<?php if($dnn['Leader'] != 0) { ?><div class="badgeIcon"><img class="showTooltip" data-toggle="tooltip" title="راهبر <?php echo $factions[$dnn['Leader']] ?>" src="public/img/leader.png"/></div><?php } ?>
												<?php if($dnn['CRank'] == 7) { ?><div class="badgeIcon"><img class="showTooltip" data-toggle="tooltip" title="صاحب کلن <?php echo clanName($con, $dnn['Clan']) ?>" src="public/img/clanOwner.png"/></div><?php } ?>
				</div>
                </div>
            </div>
            <table border="0" cellspacing="0" cellpadding="0" class="vTable generalRightTable">
                                <tr class="firstRow">
                                        <td class="headerTd">اسم</td>
                    <td>
                        <div style="overflow: hidden; display: table; margin: 0 auto;">
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
                    <?php generalUserUrl($con, $dnn['Name'], $factions, $factionC, $factionR); ?></div>
                </div>
        </td>
        </tr>
                                <tr>
            <td class="headerTd">تاریخ عضویت</td>
            <td dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $dnn['RegisteredDate'])))) ?></td>
        </tr>
        <tr>
            <td class="headerTd">آخرین ورود</td>
            <td  dir=ltr><?php echo jdate('Y/m/d H:i:s', strtotime(str_replace('/', '-', str_replace(' - ', ' ', $dnn['LastLogin'])))) ?></td>
        </tr>
        <tr>
            <td class="headerTd">آخرین جلسه</td>
            <td>اطلاعاتی موجود نیست</td>
        </tr>
        <tr>
            <td class="headerTd">وضعیت</td>
            <td>حساب کاربری فعال</td>
        </tr>
        <tr>
            <td class="headerTd">اخطارها</td>
            <td dir=ltr><input type="text" name="warns" style="width: 20%; text-align: center;" dir="ltr" value="<?php echo $dnn['Warns'] ?>" required> / 3
                            </td>
        </tr>
        <tr>
            <td class="headerTd">وضعیت تاهل</td>
            <td><input type="text" name="spouse" style="width: 60%; text-align: center;" dir="ltr" value="<?php echo $dnn['Spouse'] ?>" required></td>
        </tr>
                <tr class="lastRow">
            <td class="headerTd">پرمیوم</td>
            <td><input type="text" name="premiumaccount" style="width: 20%; text-align: center;" dir="ltr" value="<?php echo $dnn['PremiumAccount'] ?>" required></td>
        </tr>
        </table>
            <div class="playerButtons" style="margin-left:78px;"></div>
    </div>
</div>

<div id="generalTableWrapper">
    <div id="generalTableLeft">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTable">
            <tr class="firstRow">
                <td class="headerTd">رده بندی</td>
                <td><a href="/stats/players/rank/">--</a></td>
            </tr>
            <tr class="firstRow">
                <td class="headerTd">رده بندی ماهانه</td>
                <td><a href="/stats/monthlyPlayed/rank/">--</a></td>
            </tr>
            <tr>
                <td class="headerTd">سطح</td>
                <td><input type="text" name="level" style="width: 20%; text-align: center;" dir="ltr" value="<?php echo $dnn['Level']; ?>" required>                                  </td>
            </tr>
            <tr>
                <td class="headerTd">امتیاز تجربه</td>
                <td dir=ltr><input type="text" name="respect" style="width: 20%; text-align: center;" dir="ltr" value="<?php echo $dnn['Respect']; ?>" required> / <?php echo (($dnn['Level'] == 1) ? 2 : ($dnn['Level'] * 2) - 2); ?>                                    </td>
            </tr>
            <tr>
                <td class="headerTd">ساعات بازی کرده</td>
                <td><input type="text" name="hoursplayed" style="width: 20%; text-align: center;" dir="ltr" value="<?php echo $dnn['HoursPlayed'] ?>" required>                                    </td>
            </tr>
            <tr>
                <td class="headerTd">ساعات بازی کرده این ماه</td>
                <td>--</td>
            </tr>
                        <tr>
                <td class="headerTd">شماره تلفن</td>
                <td><input type="text" name="phone" style="width: 80%; text-align: center;" dir="ltr" value="<?php echo $dnn['PhoneNumber'] ?>" required></td>
            </tr>
        </table>
    </div>

    <div id="generalTableRight">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable generalNormalTable">
            <tr class="firstRow">
                <td class="headerTd">جرایم ثبت شده</td>
                <td><input type="text" name="crimes" style="width: 50%; text-align: center;" dir="ltr" value="<?php echo $dnn['Crimes'] ?>" required></td>
            </tr>
            <tr>
                <td class="headerTd">تعداد دستگیری</td>
                <td><input type="text" name="arrests" style="width: 50%; text-align: center;" dir="ltr" value="<?php echo $dnn['Arrests'] ?>" required></td>
            </tr>
            <tr>
                <td class="headerTd">مرگ هنگام تحت تعقیب</td>
                <td><input type="text" name="wanteddeaths" style="width: 50%; text-align: center;" dir="ltr" value="<?php echo $dnn['WantedDeaths'] ?>" required></td>
            </tr>
                    </table>
    </div>
    </div>
    <div id="licensesWrap">
        <div id="licenses">
		<div class="lic" style="background-color: inherit; border: 0;"></div>
            <div class="lic">
                <div class="licIcon carlic"><img src="public/img/carlic.png" alt="license"/></div>
                <div id="licText">
                    مجوز رانندگی<br/>
                    <input type="text" name="drivinglic" style="width: 60%; text-align: center;" dir="ltr" value="<?php echo $dnn['DrivingLic'] ?>" required></div>
            </div>
            <div class="lic">
                <div class="licIcon flylic"><img src="public/img/flylic.png" alt="license"/></div>
                <div id="licText">
                    مجوز پرواز<br/>
                    <input type="text" name="flyinglic" style="width: 60%; text-align: center;" dir="ltr" value="<?php echo $dnn['FlyingLic'] ?>" required>                                    </div>
            </div>
            <div class="lic">
                <div class="licIcon boatlic"><img src="public/img/boatlic.png" alt="license"/></div>
                <div id="licText">
                    مجوز قایق‌رانی<br/>
                    <input type="text" name="saillic" style="width: 60%; text-align: center;" dir="ltr" value="<?php echo $dnn['SailLic'] ?>" required>                                    </div>
            </div>
            <div class="lic">
                <div class="licIcon gunlic"><img src="public/img/gunlic.png" alt="license"/></div>
                <div id="licText">
                    مجوز اسلحه<br/>
                    <input type="text" name="gunlic" style="width: 60%; text-align: center;" dir="ltr" value="<?php echo $dnn['GunLic'] ?>" required>                                   </div>
            </div>
        </div>
    </div>            
	<input type="submit" class="normalButton" style="float: left; font-family: Vazir" value="ثبت">
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