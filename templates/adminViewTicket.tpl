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

$tid = $user;

$query = $con->prepare("SELECT * FROM `tickets` WHERE `ID` = '{$tid}';");
$query->execute();
$xxl = 0;
while($tn = $query->fetch()){
	$xxl++;
	$username = $tn['User'];
	$query2 = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$username}' LIMIT 1;");
	$query2->execute();
	$dnn = $query2->fetch();
	
if($_SERVER['REQUEST_METHOD'] === 'POST')
{
	if(isset($_POST['message']) && $_POST['message'] != null) {
		$uid = $_SESSION['pid'];
		$msg = $_POST['message'];
		$queryX = $con->prepare("INSERT INTO `tickets_comments` (`ticketID`, `uName`, `isStaff`, `Message`, `aTime`) VALUES ('{$tid}', '{$uid}', '1', '{$msg}', UNIX_TIMESTAMP());");
		$queryX->execute();
		
		$phone = $dnn['Phone'];
		$client = new SoapClient("http://37.130.202.188/class/sms/wsdlservice/server.php?wsdl");
		$input_data = array(
		 "website" => "آتیانا: سن آندریاس - زندگی مجازی",
		 "ticketnum" => numberfa($tid)
		);
		$client->sendPatternSms("+985000125475",array($phone),"nfdllc","09120948462Cd@","866",$input_data);
	}
	
	if(isset($_POST['status'])) {
		$status = $_POST['status'];
		$query22 = $con->prepare("UPDATE `tickets` SET `Status` = {$status} WHERE `ID` = {$tid}");
		$query22->execute();
	}
}
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
					<a href="/players/general/<?php echo $dncx['Name'] ?>"><img class="commentPhoto" src="public/img/Skins/thumb/<?php echo $dncx['Skin']; ?>.png" alt="skin"></a>
                </div>
                <div class="commentRight">
                    <div class="commentRightTop clearfix">
                        <div class="commentAuthor">
                            <div style="float: right;">
                                <span class="report_badge reported_badge">مدیر</span>
                            </div>
                                                        <div style="float: right;">
                                <div style="overflow: hidden; display: table; margin: 0 auto;">
                    <div style="float: right; margin-left: 5px;"><img class="showTooltip" style="display: block; margin-top: 3px;" src="public/img/<?php 
                        if($dncx['Status'] == 0) echo "offline";
                        else if($dncx['Status'] == 1) echo "online";
                        else if($dncx['Status'] == 2) echo "afk";
                        ?>.png" alt="<?php 
                        if($dncx['Status'] == 0) echo "آفلاین";
                        else if($dncx['Status'] == 1) echo "آنلاین";
                        else if($dncx['Status'] == 2) echo "دور از دسترس";
                        ?>" data-toggle="tooltip" title="<?php 
                        if($dncx['Status'] == 0) echo "آفلاین";
                        else if($dncx['Status'] == 1) echo "آنلاین";
                        else if($dncx['Status'] == 2) echo "دور از دسترس";
                        ?>"/></div>
                    <?php generalUserUrl($con, $dncx['Name'], $factions, $factionC, $factionR); ?></div>                            </div>
                            <div style="float: right;">
                                &nbsp;در <?php echo jdate("H:i Y/m/d"); ?>                            </div>
                                                    </div>
                                            </div>
                    <div class="commentText">
                        <div class="normalCommentText">
                            <form id="ticketcomment" method="post">
								وضعیت: <select name="status">
									<?php
									for($i = 0; $i < sizeof($tStatues); $i++)
									{
										$reason = $tStatues[$i];
										$p = (($tn['Status'] == $i) ? "selected" : "");
										echo "<option value={$i} {$p}>{$reason}</option>";
									}
									?>
								</select><br/><br/>
								<textarea name="message" class="normalTextarea big" dir="rtl"></textarea>
								<input type="submit" class="normalButton pull-right" value="ارسال و تغییر وضعیت">
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

<?php } } ?>
</div></div></div>