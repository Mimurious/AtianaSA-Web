<?php
if($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['message']) && isset($_POST['title']))
{
	if($_POST['message'] == null || $_POST['title'] == null) $errMsg = "تمامی فیلد‌ها را پر کنید!";
	else {
		$user = $_SESSION['pid'];
		$title = $_POST['title'];
		$department = $_POST['department'];
		$handle = $_POST['handle'];
		$priority = $_POST['priority'];
		$msg = $_POST['message'];
		$query = $con->prepare("INSERT INTO `tickets`(`User`, `Title`, `Department`, `Handle`, `Priority`, `Message`, `SubmitDate`) VALUES ({$user}, '{$title}', '{$department}', '{$handle}', '{$priority}', '{$msg}', UNIX_TIMESTAMP())");
		$query->execute();
		header("Location: /support/tickets");
	}
}
?>
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
            درخواست‌ پشتیبانی جدید</div>
		<div class="topTabs"> <ul><li class="active"><a href="/support/newticket" class="active">درخواست جدید</a></li> </ul></div>
        <br/><br/>
		<div class="normalTextBox">
        <form action="" method="post" name="formular">
            <table border="0" style="width: 100%; padding: 50px;">
                <tbody><tr>
                    <td>عنوان</td>
                </tr>
                <tr>
                    <td><input id="name" type="text" class="form-control text-right" name="title" required></td>
                </tr>
                <tr>
                    <td>بخش پشتیبانی:</td>
                </tr>
                <tr>
                    <td>
                        <select name="department">
						  <option value="support">پشتیبانی</option>
						  <option value="sale">فروش</option>
						  <option value="management">مدیریت</option>
						  <option value="sugs">انتقادات و پیشنهادات</option>
						</select>
                    </td>
                </tr>
				<tr>
                    <td>مربوط به:</td>
                </tr>
                <tr>
                    <td>
                        <select name="handle">
						  <option value="dashboard">کنترل پنل کاربری</option>
							  <option value="profile">حساب کاربری</option>
							  <option value="game">محیط بازی</option>
							  <option value="others">سایر</option>
						</select>
                    </td>
                </tr>
				<tr>
                    <td>اهمیت:</td>
                </tr>
                <tr>
                    <td>
                        <select name="priority">
						  <option value="low">کم</option>
							  <option value="normal">متوسط</option>
							  <option value="high">زیاد</option>
							  <option value="urgent">فوری</option>
						</select>
                    </td>
                </tr>
                <tr>
                    <td>توضیحات:</td>
                </tr>
                <tr>
                    <td><textarea required type="text" class="normalTextarea big" name="message"></textarea></td>
                </tr>
                <tr>
                    <td><input type="submit" class="normalButton" style="margin: 0 auto;" value="ارسال درخواست"></td>
                </tr>
            </tbody></table>
        </form>
    </div>
	</div>
</div>
</div>
</div></div></div>