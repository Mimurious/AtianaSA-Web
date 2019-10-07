<?php
$tid = $user;
if($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['message']))
{
	$uid = $_SESSION['pid'];
	$msg = $_POST['message'];
	$query = $con->prepare("INSERT INTO `tickets_comments` (`ticketID`, `uName`, `isStaff`, `Message`, `aTime`) VALUES ('{$tid}', '{$uid}', '0', '{$msg}', UNIX_TIMESTAMP());");
	$query->execute();
}

$username = $_SESSION['pid'];
$query = $con->prepare("SELECT * FROM `tickets` WHERE `User` = '{$username}' AND `ID` = '{$tid}';");
$query->execute();
$xxl = 0;
while($tn = $query->fetch()){
	$xxl++;
	$query2 = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$username}' LIMIT 1;");
	$query2->execute();
	$dnn = $query2->fetch();
?>
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
    <div class="subPageTitle pageTitle">
        پشتیبانی #<?php echo $user; ?>
		<div class="pull-right"><?php echo $tStatues[$tn['Status']]; ?></div>
    </div>
	<div class="pageTitle"><h4><?php echo $tn['Title']; ?> <span class="mh">-</span> <small> <?php echo $depName[$tn['Department']]; ?> با اهمیت <?php echo $tPrios[$tn['Priority']]; ?> </small> </h4></div>
	<div class="comment normalTextBox  clearfix">
				<div class="commentLeft">
					<a href="/players/general/<?php echo $dnn['Name'] ?>"><img class="commentPhoto" src="public/img/Skins/thumb/<?php echo $dnn['Skin']; ?>.png" alt="skin"></a>
                </div>
                <div class="commentRight">
                    <div class="commentRightTop clearfix">
                        <div class="commentAuthor">
                            <div style="float: right;">
                                <span class="report_badge reporter_badge">بازیکن</span>
                            </div>
                                                        <div style="float: right;">
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
                    <?php generalUserUrl($con, $dnn['Name'], $factions, $factionC, $factionR); ?></div>                            </div>
                            <div style="float: right;">
                                &nbsp;در <?php echo jdate("H:i Y/m/d", $tn['SubmitDate']); ?>                            </div>
                                                    </div>
                                            </div>
                    <div class="commentText">
                        <div class="normalCommentText">
                            <?php echo $tn['Message']; ?>                        </div>
                    </div>
                </div>
            </div>
			<?php
			$query3 = $con->prepare("SELECT * FROM `tickets_comments` WHERE `ticketID` = '{$tid}' ORDER BY `ID` ASC;");
			$query3->execute();
			while($tc = $query3->fetch()){
				$anwrrr = $tc['uName'];
				$query4 = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$anwrrr}' LIMIT 1;");
				$query4->execute();
				$dnc = $query4->fetch();
			?>
			<div class="comment normalTextBox  clearfix">
				<div class="commentLeft">
					<a href="/players/general/<?php echo $dnc['Name'] ?>"><img class="commentPhoto" src="public/img/Skins/thumb/<?php echo $dnc['Skin']; ?>.png" alt="skin"></a>
                </div>
                <div class="commentRight">
                    <div class="commentRightTop clearfix">
                        <div class="commentAuthor">
                            <div style="float: right;">
                                <?php if($tc['isStaff']) { ?><span class="report_badge reported_badge">مدیر</span><?php } else { ?>
								<span class="report_badge reporter_badge">بازیکن</span>
								<?php } ?>
                            </div>
                                                        <div style="float: right;">
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
                    <?php generalUserUrl($con, $dnc['Name'], $factions, $factionC, $factionR); ?></div>                            </div>
                            <div style="float: right;">
                                &nbsp;در <?php echo jdate("H:i Y/m/d", $tc['aTime']); ?>                            </div>
                                                    </div>
                                            </div>
                    <div class="commentText">
                        <div class="normalCommentText">
                            <?php echo $tc['Message']; ?>                        </div>
                    </div>
                </div>
            </div>
			<?php
			}
			?>
			<div class="comment normalTextBox  clearfix">
				<div class="commentLeft">
					<a href="/players/general/<?php echo $dnn['Name'] ?>"><img class="commentPhoto" src="public/img/Skins/thumb/<?php echo $dnn['Skin']; ?>.png" alt="skin"></a>
                </div>
                <div class="commentRight">
                    <div class="commentRightTop clearfix">
                        <div class="commentAuthor">
                            <div style="float: right;">
                                <span class="report_badge reporter_badge">بازیکن</span>
                            </div>
                                                        <div style="float: right;">
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
                    <?php generalUserUrl($con, $dnn['Name'], $factions, $factionC, $factionR); ?></div>                            </div>
                            <div style="float: right;">
                                &nbsp;در <?php echo jdate("H:i Y/m/d"); ?>                            </div>
                                                    </div>
                                            </div>
                    <div class="commentText">
                        <div class="normalCommentText">
                            <form id="ticketcomment" method="post">
								<textarea name="message" class="normalTextarea big" dir="rtl" required></textarea>
								<input type="submit" class="normalButton pull-right" value="ارسال">
								</form>
							</div>
                    </div>
                </div>
            </div>
    </div>
                </div>
<?php
}
if(!$xxl)
{
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    پشتیبانی
            </div>
	<div align="center"> <div class='normalTextBox'>درخواست مورد نظر وجود ندارد.</div></div>
		</div>
	</div>

<?php } ?>
</div></div></div>