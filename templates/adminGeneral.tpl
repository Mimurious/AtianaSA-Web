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

<li class="first"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/admin/users">حساب های کاربری</a></li></ul></li>
<li class="last"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/admin/tickets">تیکت‌های پشتیبانی <span class="numberBullet"><?php echo totalunAnsweredTickets($con); ?></span></a></li></ul></li>

</ul></div>
<div id="contentPage">
    <div class="subPageContainer">
        <div class="subPageTitle pageTitle">
            پیشخوان
        </div>
		
		<div class="tableFull">
		سلام! 
		اینجا کنترل پنل مدیریت شماست! از منوی سمت راست بخش‌های مورد نظر خود را انتخاب کنید.
		</div>
    </div>
</div>
<?php } ?>
</div></div></div>