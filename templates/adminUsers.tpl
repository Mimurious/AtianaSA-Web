<?php
if($dncx['AdminLevel'] != 8)
{
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    کنترل پنل مدیریت
            </div>
    <div id="contentMain">
<div id="contentPage">
    <br> <br><div align="center"> <div class='normalTextBox'>شما به این بخش دسترسی ندارید، لطفا وارد شوید و یا از صحیح بودن دسترسی خود اطمینان حاصل کنید.
			</div>
           </div>
                </div>
			</div>
<?php
}
else {
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    کنترل پنل مدیریت
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul>

<li class="first active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/admin/users">حساب های کاربری</a></li></ul></li>
<li class="last next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/admin/tickets">تیکت‌های پشتیبانی <span class="numberBullet"><?php echo totalunAnsweredTickets($con); ?></span></a></li></ul></li>

</ul></div>
<div id="contentPage">
    <div class="subPageContainer">
        <div class="subPageTitle pageTitle">
            لیست حساب های کاربری
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
				<td>اخطارها</td>
                <td class="lastTd">عملیات</td>
            </tr>
				<?php
					$query3 = $con->prepare("SELECT * FROM `users`;");
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
					<td><?php if(!$dnn['Registred']) { ?><a href="/admin/verify/<?php echo $dnn['Name'] ?>"><img class="showTooltip" alt="تائید" data-toggle="tooltip" title="تائید" src="public/img/check.png"></a> <?php } ?><a href="/admin/edit/<?php echo $dnn['Name'] ?>"><img class="showTooltip" alt="ویرایش" data-toggle="tooltip" title="ویرایش" src="public/img/edit.png"></a> <a href="/admin/loginas/<?php echo $dnn['Name'] ?>"><img class="showTooltip" alt="ورود به عنوان" data-toggle="tooltip" title="ورود به عنوان" src="public/img/loginas.png"></a></td>
                </tr>
				<?php } ?>
				
                    </tbody></table>
    </div>
	<a href="/admin/add" class="normalButton" style="float: left; font-family: Vazir">افزودن یک کاربر جدید</a>
            </div>
		</div>
<?php } ?>
</div></div></div>