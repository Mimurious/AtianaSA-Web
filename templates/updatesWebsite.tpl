<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        بروزرسانی‌ها
    </div>
    <div id="contentMain"><div id="contentPage">
    <div class="contentTabberPage">
        <div class="topTabs">
    <ul>
        <li>
            <a href="/updates/server">
                                بروزرسانی‌های سرور <span class="new">جدید</span>
            </a>
        </li>
        <li>
            <a href="/updates/website">
                                بروزرسانی‌های کنترل پنل <span class="new">جدید</span>
            </a>
        </li>
    </ul>
</div>        <div class="subPageTitle pageTitle">
            بروزرسانی‌های کنترل پنل
        </div>
    </div>
        <div id="pageContent">
        <?php
		$query = $con->prepare("SELECT * FROM `updates` WHERE `type` = 2 ORDER BY `id` DESC;");
		$query->execute();
		$c = 0;
		while($du = $query->fetch())
		{
			if($du['score'] == 0)
			{
				$scolor = '';
			}
			else if($du['score'] >= 1 && $du['score'] < 3)
			{
				$scolor = 'rgb(239,71,35)';
			}
			else if($du['score'] >= 3 && $du['score'] < 4)
			{
				$scolor = 'rgb(255,120,0)';
			}
			else if($du['score'] >= 4)
			{
				$scolor = '#FFB90F';
			}
		?>
		<div class="update" data-id="<?php echo $du['id'] ?>">
                <a name="<?php echo $du['id'] ?>">
                    <div class="updateTop clearfix">
                        <a href="javascript:;" class="viewUpdate normalButton" style="float: right;" dir=ltr>
                                                        <?php echo $du['version'] ?> - by <?php echo $du['author'] ?> - <?php echo $du['date'] ?></a>
                        <div class="stars" style="float:left; margin-top:20px; padding-left:10px;" data-rating="<?php echo $du['score'] ?>">
                                                            <i class="material-icons md-16 star star-1" data-star="1" data-update="<?php echo $du['id'] ?>" style="color:<?php echo $scolor ?>;">star_border</i>
                                                            <i class="material-icons md-16 star star-2" data-star="2" data-update="<?php echo $du['id'] ?>" style="color:<?php echo $scolor ?>;">star_border</i>
                                                            <i class="material-icons md-16 star star-3" data-star="3" data-update="<?php echo $du['id'] ?>" style="color:<?php echo $scolor ?>;">star_border</i>
                                                            <i class="material-icons md-16 star star-4" data-star="4" data-update="<?php echo $du['id'] ?>" style="color:<?php echo $scolor ?>;">star_border</i>
                                                            <i class="material-icons md-16 star star-5" data-star="5" data-update="<?php echo $du['id'] ?>" style="color:<?php echo $scolor ?>;">star_border</i>
															<span style="font-weight:bold; color:#fff; margin-right: 10px;"><?php echo $du['score'] ?>&nbsp;&nbsp;&nbsp;</span>
                                                    </div>
                                            </div>
                </a>
                <div class="updateContent"style="display: <?php echo ($c == 0) ? 'block' : 'none'; ?>">
                <div class="editUpdateContent" style="display: none;">
                    <table>
                        <tr>
                            <td width="100">تاریخ</td>
                            <td><input type="text" class="editUpdateDate" value="<?php echo $du['date'] ?>"/></td>
                        </tr>
                        <tr>
                            <td>نسخه</td>
                            <td><input type="text" class="editUpdateVersion" value="<?php echo $du['version'] ?>"/></td>
                        </tr>
                    </table>
                </div>
                <div id="editUpdateContentElement135" class="normalTextBox editUpdateContentElement">
				<?php echo $du['text'] ?>
                </div>
            </div>
        </div>
		<?php
		$c++;
		}
		?>		
			</div>
		</div>
    </div>
	</div></div></div>