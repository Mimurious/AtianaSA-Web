<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        کلن‌ها
    </div>
    <div id="contentMain">
	<div id="leftSidebar">
        <ul>
            <li class="first active">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/clans/">کلن‌ها</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/clans/wars">جنگ کلن‌ها</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
		</ul>
	</div>
    <div id="contentPage">
    <div class="subPageTitle pageTitle">
        کلن‌های برتر
    </div>
    <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tr class="headerRow">
				<td>#</td>
                <td>نام</td>
				<td>تگ</td>
                <td>تاریخ تاسیس</td>
				<td>اعضا</td>
				<td>مقر (HQ)</td>
                <td>پیش نیاز</td>
                <td>وضعیت درخواست‌های عضویت</td>
                <td>عملیات</td>
            </tr>
				<?php
					$query = $con->prepare("SELECT * FROM `clans` ORDER BY `ID`;");
					$query->execute();
					$c = 0;
					while($dnn = $query->fetch())
					{
					$c++;
					?>
                    <tr>
					<td><?php echo $dnn['ID'] ?></td>
                    <td><a href="/clans/view/<?php echo $dnn['Name'] ?>" style="color: #<?php echo $dnn['Color']; ?>;"><?php echo $dnn['Name'] ?></a></td>
					<td><?php echo $dnn['Tag'] ?></td>
					<td dir=ltr><?php echo ($dnn['CreateDate']) ? jdate("Y/m/d H:i:s", $dnn['CreateDate']) : "اطلاعاتی موجود نیست"; ?></td>
                    <td dir=ltr><?php echo totalClanMembers($con, $dnn['ID']) ?> / <?php echo ($dnn['Slots']) ?></td>
					<td><?php echo ($dnn['HouseHQ']) ? "خانه <span dir=ltr>#" . $dnn['HouseHQ'] : "ندارد" ?></span></td>
                    <td>سطح <?php echo ($dnn['MinLvl']) ?></td>
                    <td>
							<?php
							if($dnn['Opened']) echo "<i class='showTooltip material-icons' data-toggle='tooltip' title='باز' style='color:#1bd427;'>lock_open</i>";
							else echo "<i class='showTooltip material-icons' data-toggle='tooltip' title='بسته' style='color:#e74015;'>lock</i>";
							 ?>
					</td>
                    <td>
					<?php
					$cuser = $_SESSION['username'];
					$queryp = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
					$queryp->execute();
					$dnx = $queryp->fetch();
					if(!$dnn['Opened']) echo "<span style='color:#5f5f5f;'>درخواست‌های عضویت بسته هستند</span>";
					else if(totalClanMembers($con, $dnn['ID']) >= $dnn['Slots']) echo "<span style='color:#5f5f5f;'>ظرفیت کلن تکمیل است</span>";
					else if($dnx['Level'] < $dnn['MinLvl']) echo "<span style='color:#5f5f5f;'>شما نمیتوانید برای اینجا درخواست دهید</span>";
					else
					{
					?>
					<a href="/clans/applications/<?php echo $dnn['Name']; ?>">ثبت درخواست عضویت</a>
					<?php } ?>
					</td>
                </tr>
					<?php
					}
					?>
                    </table>
                        </div>
						</div>
                </div>
				</div></div></div>
