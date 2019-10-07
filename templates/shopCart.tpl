<?php
if(!isset($_SESSION['cartitems'])) $_SESSION['cartitems'] = array();
else $_SESSION['cartitems'] = array_values($_SESSION['cartitems']);
?>
<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        فروشگاه
    </div>
    <div id="contentMain">
    <div id="leftSidebar">
        <ul>
			<li class="first active">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/shop/cart">سبد خرید <span class="numberBullet"><?php echo sizeof($_SESSION['cartitems']) ?></a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
            <li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/shop/vehicles">وسایل نقلیه</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
        </ul>
    </div>
    <div id="contentPage">
    <div class="contentTabberPage">
        <div class="subPageTitle pageTitle">
            سبد خرید</div>
        <br/><br/>
		<div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">ردیف</td>
                <td>نام محصول</td>
                <td>تنظیمات</td>
                <td>قیمت نهایی محصول</td>
                <td class="lastTd">عملیات</td>
            </tr>
					<?php
					if(sizeof($_SESSION['cartitems']) == 0)
					{
						echo "<tr><td colspan=5>هیچ آیتمی در سبد خرید شما وجود ندارد.</td></tr>";
					}
					else {
					$ix = 0;
					$total = 0;
					$totalR = 0;
					foreach($_SESSION['cartitems'] as $x) {
					$ix++;
					?>
                    <tr>
						<td dir=ltr>#<?php echo $ix; ?></td>
						<td>
							<?php
								$id = $x['ID'];
								$query = $con->prepare("SELECT * FROM `items` WHERE `ID` = '{$id}';");
								$query->execute();
								$dvc = $query->fetch();
								
								$prc = $dvc['Price'];
								$add = 0;
								if($x['Color'] > 128) $add += $prc * 30 / 100;
								if($x['Turbo']) $add += $prc * 60 / 100;
								if(isset($add)) $prc += $add;
								
								$total += $prc;
								$totalR += realPrice($prc);
								
								$_SESSION['total'] = $total;
								$_SESSION['totalR'] = $totalR;
							?>
							<?php echo $namevehicles[$dvc['Model']]; ?>
						</td>
						<td>
						<?php echo ($x['Turbo']) ? "توربوشارژ | " : ""; ?> رنگ: <div class="showTooltip" style="display: inline-block; width: 10px; height: 10px; margin: 0 2px; border: 1px solid #000000; background-color: #<?php echo $vehColors[$x['Color']] ?>" data-toggle="tooltip" data-placement="bottom" data-original-title="<?php echo $x['Color'] ?>"></div>
						</td>
						<td>
						<span dir=ltr style="float:left">$<?php echo number_format($prc,0,"",","); ?></span><span style="float:right"><?php echo number_formatfa(realPrice($prc)); ?> تومان</span>
						</td>
						<td>
						<a href="/shop/edit/<?php echo $ix?>"><img class="showTooltip" alt="ویرایش" data-toggle="tooltip" title="" src="public/img/edit.png" data-original-title="ویرایش"></a>
						<a href="/shop/delete/<?php echo $ix ?>"><img class="showTooltip" alt="حذف" data-toggle="tooltip" title="" src="public/img/delete.png" data-original-title="حذف"></a>
						</td>
					</tr>
					<?php } ?>
					</tbody></table><br />
					<div style="float: left">
					<div class="subPageAddButton" style="background: #0000FF;"><a class="showTooltip" data-toggle="tooltip" data-placement="bottom" data-original-title="خرید با پول درون بازی موقتاً امکان پذیر نیست.">خرید با پول بازی (<span dir=ltr>$<?php echo number_format($total,0,"",","); ?></span>)</a></div>
					<?php if($totalR > 5000) { ?><div class="subPageAddButton"><a href="/shop/realpay">خرید با پول واقعی (<span><?php echo number_formatfa($totalR); ?> تومان</span>)</a></div> <?php } else { ?>
					<div class="subPageAddButton" style="background: #FF0000;"><a href="/shop/realpay" class="showTooltip" data-toggle="tooltip" data-placement="bottom" data-original-title="امکان خرید برای مبالغ کمتر از 5000 تومان وجود ندارد.">خرید با پول واقعی (<span><s><?php echo number_formatfa($totalR); ?> تومان</s> <?php echo number_formatfa(5000); ?> تومان</span>)</a></div><?php } ?>
					</div>
					<?php } ?>
                    </tbody></table><br /><br /><br />
					<div class="alert alert-danger">
  <strong>توجه!</strong> در صورتی که در هنگام فرایند خرید با هرگونه مشکل مواجه شدید موارد مربوطه را به وسیله آدرس ایمیل info@atiana.ir و یا از طریق شماره تلفن <span dir=ltr>(021) 2842 7590</span> یا <span dir=ltr>(035) 3821 9392</span> با ما در میان بگذارید.
</div>
		</div>
	</div>
</div>
</div>
</div></div></div>