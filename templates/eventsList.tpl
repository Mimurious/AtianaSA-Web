<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        رویدادها
    </div>
    <div id="contentMain">
    <div id="leftSidebar">
        <ul>
            <li class="first active">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/events/list">لیست رویدادها</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<?php
			$query = $con->prepare("SELECT * FROM `events` ORDER BY `ID` DESC;");
			$query->execute();
			while($dnn = $query->fetch())
			{
			?>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/events/info/<?php echo $dnn['ID']; ?>"><?php echo $dnn['Title']; ?></a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<?php } ?>
        </ul>
    </div>
    <div id="contentPage">
    <div class="contentTabberPage">
        <div class="subPageTitle pageTitle">
            لیست رویدادها</div>
        <br/><br/>
			<div class="vehiclesContainer">
			<?php
				$query = $con->prepare("SELECT * FROM `events` ORDER BY `ID` DESC;");
				$query->execute();
				while($dnn = $query->fetch())
				{
				?>
				 <div class="eventBox">
					<table border="0" cellspacing="0" cellpadding="0" class="vTable generalEventTable">
						<tbody>
						<tr>
							<td colspan=2><a href="/events/info/<?php echo $dnn['ID']; ?>"><img width=460px src="public/img/event<?php echo $dnn['ID']; ?>.jpg" alt="رویداد <?php echo $dnn['Title']; ?>"></a></td>
						</tr>
						<tr>
							<td class="headerTd">نام رویداد</td>
							<td><?php echo $dnn['Title']; ?></td>
						</tr>
						<tr>
							<td class="headerTd">نوع رویداد</td>
							<td><?php echo $dnn['Type']; ?></td>
						</tr>
						<tr>
							<td class="headerTd">شرکت کنندگان</td>
							<td dir=ltr><?php if($dnn['MaxPlayers'] == -1) echo "تمامی بازیکنان"; else echo $dnn['Players'] . " / " . $dnn['MaxPlayers']; ?></td>
						</tr>
						<tr>
							<td class="headerTd">فرصت شرکت در رویداد</td>
							<td dir=ltr><?php echo ($dnn['JoinTime']) ? jdate("Y/m/d H:i:s", $dnn['JoinTime']) : "تنظیم نشده"; ?></td>
						</tr>
						<tr>
							<td class="headerTd">زمان شروع رویداد</td>
							<td dir=ltr><?php echo ($dnn['StartTime']) ? jdate("Y/m/d H:i:s", $dnn['StartTime']) : "تنظیم نشده"; ?></td>
						</tr>
						<tr>
							<td class="headerTd">زمان اتمام رویداد</td>
							<td dir=ltr><?php echo ($dnn['EndTime']) ? jdate("Y/m/d H:i:s", $dnn['EndTime']) : "تنظیم نشده"; ?></td>
						</tr>
						<tr>
							<td class="headerTd">هزینه ورود (برای هر نفر)</td>
							<td dir=ltr><?php echo ($dnn['Price'] == 0) ? "رایگان" : $dnn['Price']; ?></td>
						</tr>
						<tr class="lastRow">
							<td colspan="2" class="headerTd">
								<a href="/events/info/<?php echo $dnn['ID']; ?>" class="showTooltip" data-toggle="tooltip" data-placement="bottom" data-original-title="اطلاعات رویداد" style="color:#3498db; margin-left: 30px;"><i class="material-icons md-13">info</i></a>
								<?php if($dnn['MaxPlayers'] == -1) { ?><a class="showTooltip" data-toggle="tooltip" data-placement="bottom" data-original-title="شرکت در رویداد" style="color:#ff0000; margin-right: 30px;"><i class="material-icons md-13">person_add</i></a><?php } else { ?><a href="/events/join/<?php echo $dnn['ID']; ?>" class="showTooltip" data-toggle="tooltip" data-placement="bottom" data-original-title="شرکت در رویداد" style="color:#1bd427; margin-right: 30px;"><i class="material-icons md-13">person_add</i></a><?php } ?>
							</td>
						</tr>
					</tbody></table>
				</div>
			<?php } ?>
		</div>
	</div>
</div>
</div>
</div></div></div>