<?php
if($dncx['AdminLevel'] < 1)
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

<li class="first prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/admin/users">حساب های کاربری</a></li></ul></li>
<li class="last active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/admin/tickets">تیکت‌های پشتیبانی <span class="numberBullet"><?php echo totalunAnsweredTickets($con); ?></span></a></li></ul></li>

</ul></div>
<div id="contentPage">
    <div class="subPageContainer">
        <div class="subPageTitle pageTitle">
            تیکت‌های پشتیبانی</div>
		<div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">ردیف</td>
                <td>عنوان</td>
				<td>توسط</td>
                <td>بخش پشتیبانی</td>
                <td>زمان</td>
                <td>وضعیت</td>
				<td class="lastTd"></td>
            </tr>
					<?php
					$query = $con->prepare("SELECT * FROM `tickets` ORDER BY `SubmitDate` DESC, `Status` ASC;");
					$query->execute();
					$xx = 0;
					while($tn = $query->fetch()){
						$xx++;
					?>
                    <tr>
						<td dir=ltr>#<?php echo $tn['ID']; ?></td>
						<td><?php echo $tn['Title']; ?></td>
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
                    <?php generalIDUrl($con, $tn['User'], $factions, $factionC, $factionR); ?></div></td>
						<td><?php echo $depName[$tn['Department']]; ?></td>
						<td><span dir=ltr><?php echo jdate("Y/m/d H:i", $tn['SubmitDate']); ?></span></td>
						<td><?php echo $tStatues[$tn['Status']]; ?></td>
						<td style="text-align: center;"><a class="normalButton" style="display: contents;" href="/admin/viewTicket/<?php echo $tn['ID']; ?>"> نمایش </a></td>
					</tr>
					<?php } if(!$xx) echo "<tr><td colspan=6><p class='notexist'>هیچ درخواست پشتیبانی‌ای وجود ندارد.</p></td></tr>"; ?>
					</tbody></table><br />
		</div>
	</div>
</div>
<?php } ?>
</div>
</div></div></div>