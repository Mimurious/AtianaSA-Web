<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        پشتیبانی
    </div>
    <div id="contentMain">
    <div id="leftSidebar">
        <ul>
			<li class="first active">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/support/tickets">درخواست‌های پشتیبانی</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
        </ul>
    </div>
    <div id="contentPage">
    <div class="contentTabberPage">
        <div class="subPageTitle pageTitle">
            درخواست‌های پشتیبانی</div>
		<div class="topTabs"> <ul><li><a href="/support/newticket">درخواست جدید</a></li> </ul></div>
        <br/><br/>
		<div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">ردیف</td>
                <td>عنوان</td>
                <td>بخش پشتیبانی</td>
                <td>زمان</td>
                <td>وضعیت</td>
				<td class="lastTd"></td>
            </tr>
					<?php
					$uid = $_SESSION['pid'];
					$query = $con->prepare("SELECT * FROM `tickets` WHERE `User` = '{$uid}' ORDER BY `ID` DESC;");
					$query->execute();
					$xx = 0;
					while($tn = $query->fetch()){
						$xx++;
					?>
                    <tr>
						<td dir=ltr>#<?php echo $tn['ID']; ?></td>
						<td><?php echo $tn['Title']; ?></td>
						<td><?php echo $depName[$tn['Department']]; ?></td>
						<td><span dir=ltr><?php echo jdate("Y/m/d H:i", $tn['SubmitDate']); ?></span></td>
						<td><?php echo $tStatues[$tn['Status']]; ?></td>
						<td style="text-align: center;"><a class="normalButton" style="display: contents;" href="/support/view/<?php echo $tn['ID']; ?>"> نمایش </a></td>
					</tr>
					<?php } if(!$xx) echo "<tr><td colspan=6><p class='notexist'>هیچ درخواست پشتیبانی‌ای وجود ندارد.</p></td></tr>"; ?>
					</tbody></table><br />
					<div class="alert alert-danger">
  <strong>توجه!</strong> در صورتی که مشکل شما بسیار جدی بوده و نیاز به بررسی فوری دارد، موارد مربوطه را از طریق شماره تلفن <span dir=ltr>(0922) 685 4716</span> با ما در میان بگذارید.
</div>
		</div>
	</div>
</div>
</div>
</div></div></div>