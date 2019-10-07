<?php
$query = $con->prepare("SELECT * FROM `clans` WHERE `Name` = '{$fac}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
$xx = 1;
?>
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
    <div class="contentTabberPage">
        <div class="topTabs">
            <ul>
			<li class="active"><a href="/clans/view/<?php echo $fac ?>" style="cursor:pointer;">توضیحات کلن</a>
            </li>
            <li><a href="/clans/members/<?php echo $fac ?>" style="cursor:pointer;">اعضای کلن</a>
            <li><a href="/clans/logs/<?php echo $fac ?>" style="cursor:pointer;">تاریخچه کلن</a>
			<li><a href="/clans/applications/<?php echo $fac ?>" style="cursor:pointer;">درخواست‌های عضویت</a>
                    </ul>
    </div>        <br>
        <div class="subPageTitle pageTitle">
            کلن <?php echo $fac ?>        </div>
			<p style="text-align:center"><img alt="" src="<?php echo $dnn['imageUrl'] ?>"></p>
                <div style="font-weight: bold; padding: 20px 0; font-size: 15px;">
                        درخواست‌های عضویت: <?php
						if(!$dnn['Opened']) echo '<span style="color: #ff0000;">بسته</span>';
						else echo '<span style="color: #00ff00;">باز</span>';
						?><br>
            حداقل سطح موردنیاز: <?php echo $dnn['MinLvl'] ?>
			
			<p style="text-align:left"><a href="<?php echo $dnn['forumURL'] ?>">بخش کلن <?php echo $dnn['Name'] ?> در انجمن</a></p>
			</div>
        <div id="pageContent" class="allow-list">
	
<?php echo $dnn['text'] ?>
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