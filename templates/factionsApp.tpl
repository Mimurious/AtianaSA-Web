<?php
$cuser = $_SESSION['username'];
$queryp = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$cuser}' LIMIT 1;");
$queryp->execute();
$dnx = $queryp->fetch();
$query = $con->prepare("SELECT * FROM `applications` WHERE `ID` = '{$fac}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnq = $query->fetch())
{
$fid = $dnq['FactionID'];
$query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = '{$fid}' LIMIT 1;");
$query->execute();
$dnn = $query->fetch();

$player = $dnq['Player'];
$query = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$player}' LIMIT 1;");
$query->execute();
$pnn = $query->fetch();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$status = $_POST['status'];
	$answer = $_POST['answer'];
	$answerer = $dnx['ID'];
	
	$guery = $con->prepare("UPDATE `applications` SET `Status` = {$status}, `Answer` = '{$answer}', `Answerer` = {$answerer}, `AnswerDate` = UNIX_TIMESTAMP() WHERE `ID` = {$fac};");
	$guery->execute();
	
	$dnq['Status'] = $status;
	$dnq['Answer'] = $answer;
	$dnq['Answerer'] = $answerer;
}

$xx = 1;
?>
<div id="content">
			<div id="contentWrap"><div id="contentBox">
	<div class="pageTitle">
		اقلیت‌ها
	</div>
	<div id="contentMain">
	<div id="leftSidebar">
		<ul>
			<li class="first">
				<ul>
					<li class="leftMenuItem" />
					<li class="menuItem"><a href="/factions/">اقلیت‌ها</a></li>
					<li class="rightMenuItem" />
				</ul>
			</li>
			<li>
				<ul>
					<li class="leftMenuItem" />
					<li class="menuItem"><a href="/factions/peacefulRules">قوانین اقلیت‌ها</a></li>
					<li class="rightMenuItem" />
				</ul>
			</li>
			
			<?php
			for($x = 0; $x < sizeof($factionCa); $x++)
			{
				if($x == 0) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 4 OR `ID` = 5 OR `ID` = 6 ORDER BY `ID`;");
				else if($x == 1) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 8 OR `ID` = 9 OR `ID` = 10 OR `ID` = 11 ORDER BY `ID`;");
				else if($x == 2) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 1 OR `ID` = 14 OR `ID` = 15 OR `ID` = 2 OR `ID` = 12 OR `ID` = 13 ORDER BY Field(`ID`,1,14,15,2,12,13);");
				else if($x == 3) $query = $con->prepare("SELECT * FROM `safes` WHERE `ID` = 3 OR `ID` = 7 ORDER BY `ID`;");
				$query->execute();
				$c = 0;
				while($dnb = $query->fetch())
				{
				$c++;
			?>
			<li <?php if($fid == $dnb['ID']) echo "class='active'"; ?>>
				<ul>
					<li class="leftMenuItem" />
					<li class="menuItem"><a href="/factions/view/<?php echo $factionA[($dnb['ID'])]; ?>"><?php echo $factions[($dnb['ID'])] ?></a></li>
					<li class="rightMenuItem" />
				</ul>
			</li>
			
			<?php
				}
			
			}
			?>
			
		</ul>
	</div>
	<div id="contentPage">
	<div class="contentTabberPage">
		<div class="topTabs">
			<ul>
			<li class="dropdown"><a class="dropdown-toggle data-toggle="dropdown" style="cursor:pointer;">اقلیت</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/view/<?php echo $factionA[($dnq['FactionID'])] ?>">توضیحات اقلیت</a></li>
					<li><a href="/factions/rules/<?php echo $factionA[($dnq['FactionID'])] ?>">قوانین اقلیت</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">اعضا، تاریخچه و آمار</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/members/<?php echo $factionA[($dnq['FactionID'])] ?>">اعضای اقلیت</a></li>
					<li><a href="/factions/logs/<?php echo $factionA[($dnq['FactionID'])] ?>">تاریخچه اقلیت</a></li>
					<li><a href="/factions/stats/<?php echo $factionA[($dnq['FactionID'])] ?>">آمار اقلیت</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">لیست سیاه</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/blacklist/<?php echo $factionA[($dnq['FactionID'])] ?>">لیست سیاه</a></li>
					<li><a href="/factions/blacklistLogs/<?php echo $factionA[($dnq['FactionID'])] ?>">تاریخچه لیست سیاه</a></li>
				</ul>
			</li>
			<li class="dropdown active"><a class="dropdown-toggle active" data-toggle="dropdown" style="cursor:pointer;">شکایات و درخواست‌های عضویت</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/complainment/<?php echo $factionA[($dnq['FactionID'])] ?>">شکایات</a></li>
					<li class="active"><a href="/factions/applications/<?php echo $factionA[($dnq['FactionID'])] ?>">درخواست‌های عضویت</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">درخواست‌های مرخصی و استعفا</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/inactivities/<?php echo $factionA[($dnq['FactionID'])] ?>">درخواست‌های مرخصی</a></li>
					<li><a href="/factions/resignations/<?php echo $factionA[($dnq['FactionID'])] ?>">درخواست‌های استعفا</a></li>
				</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">فعالیت‌های اقلیت</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="background-color:#090909;">
					<li><a href="/factions/reports/<?php echo $factionA[($dnq['FactionID'])] ?>">گزارشات اقلیت</a></li>
				</ul>
			</li>
			<?php if($dnn['Opened'] && (totalFactionMembers($con, $dnn['ID']) < $dnn['Slot']) && ($dnx['Level'] > $dnn['MinLvl']  || $dnx['Rank'] == 0)) { ?><li><a href="/factions/apply/<?php echo $fac ?>">درخواست عضویت</a></li><?php } ?>

					</ul>
	</div>        <br>
		<div class="subPageTitle pageTitle">
			درخواست عضویت برای اقلیت <?php echo $factions[$fid] ?>        </div>
			<div class="normalTextBox">
            <table border="0" style="width: 100%; padding: 0 20px;">
                <tbody><tr>
                    <td class="applicationTitle"><b>بازیکن:</b></td>
                </tr>
                <tr>
                    <td><div style="display: inline; margin-right: 5px;"><img class="showTooltip" style="display: inline; margin-top: 3px;" src="public/img/<?php 
						if($pnn['Status'] == 0) echo "offline";
						else if($pnn['Status'] == 1) echo "online";
						else if($pnn['Status'] == 2) echo "afk";
						?>.png" alt="<?php 
						if($pnn['Status'] == 0) echo "آفلاین";
						else if($pnn['Status'] == 1) echo "آنلاین";
						else if($pnn['Status'] == 2) echo "دور از دسترس";
						?>" data-toggle="tooltip" title="<?php 
						if($pnn['Status'] == 0) echo "آفلاین";
						else if($pnn['Status'] == 1) echo "آنلاین";
						else if($pnn['Status'] == 2) echo "دور از دسترس";
						?>"/></div>
                    <?php generalUserUrl($con, $pnn['Name'], $factions, $factionC, $factionR); ?> - سطح <?php echo $pnn['Level']; ?> - تجربه <span dir=ltr><?php echo $pnn['Respect'] ?> / <?php echo (($pnn['Level'] == 1) ? 2 : ($pnn['Level'] * 2) - 2); ?></span></td>
                </tr>
                <tr>
                    <td class="applicationTitle"><b>اقلیت:</b></td>
                </tr>
                <tr>
                    <td><a href="/factions/view/<?php echo $factionA[($dnq['FactionID'])]; ?>" style="color: #<?php echo $factionC[($dnq['FactionID'])]; ?>;"><?php echo $factions[($dnq['FactionID'])] ?></a></td>
                </tr>
                                                            <tr>
                            <td class="applicationTitle"><b>سن واقعی:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a1']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>ساعات بازی کردن در روز:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a2']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>فواصل زمانی بازی کردن:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a3']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>توضیحات خروج از اقلیت قبلی:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a4']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>توضیحات مجازات‌های دریافتی از ادمین‌ها:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a5']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>توصیف خود به عنوان یک متقاضی عضویت:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a6']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>مقدار آشنایی با زبان انگلیسی:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a7']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>دلیل درخواست برای این اقلیت:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a8']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>برنامه های آینده شما به عنوان یک بازیکن:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a9']; ?></td>
                        </tr>
                                                                                <tr>
                            <td class="applicationTitle"><b>اطلاعات مفید دیگر برای راهبر اقلیت:</b></td>
                        </tr>
                        <tr>
                            <td class="applicationAnswer"><?php echo $dnq['a10']; ?></td>
                        </tr>
                                                    <tr>
                    <td class="applicationTitle"><b>وضعیت:</b></td>
                </tr>
                <tr>
                    <td class="applicationAnswer">
                        <?php echo $factiontypes[$dnq['Status']] ?>
					</td>
                </tr>
				<?php if($dnq['Answerer'] != 0) { ?>
				<tr>
                        <td class="applicationTitle"><b>پاسخ دهنده:</b></td>
                    </tr>
					<tr>
                        <td class="applicationAnswer"><?php echo generalIDUrl($con, $dnq['Answerer'], $factions, $factionC, $factionR); ?></td>
                    </tr>
					<tr>
                        <td class="applicationTitle"><b>پاسخ:</b></td>
                    </tr>
					<tr>
                        <td class="applicationAnswer"><?php echo $dnq['Answer']; ?></td>
                    </tr>
				<?php } ?>
				<?php if($dnx['Leader'] == $fid) { ?>
				<tr align=center>
                    <td><br />وضعیت:<br />
					<form action="" method="post" name="formular">
                        <select name="status">
							<?php
							for($i = 0; $i < sizeof($factiontypes); $i++)
							{
								$reason = $factiontypes[$i];
								$p = (($dnq['Status'] == $i) ? "selected" : "");
								echo "<option value={$i} {$p}>{$reason}</option>";
							}
							?>
						</select><br /><br />توضیحات تغییر وضعیت:<br/>
						<textarea required type="text" class="normalTextarea small"  name="answer" required><?php echo $dnq['Answer']; ?></textarea><br/>
						<input type="submit" class="normalButton" style="margin: 0 auto;" value="تغییر وضعیت">
					</form>
                    </td>
				</tr>
				<?php } ?>
                                            </tbody></table>
    </div>

	</div>            </div>
				</div>
<?php
}
if(!$xx)
{
	header("Location: ../");
}
?>
</div></div></div>