<?php
if(!isset($_SESSION['cartitems'])) $_SESSION['cartitems'] = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$idx = sizeof($_SESSION['cartitems']);
	$_SESSION['cartitems'][$idx]['Type'] = 1;
	$_SESSION['cartitems'][$idx]['ID'] = $user;
	$_SESSION['cartitems'][$idx]['Color'] = $_POST['vColor'];
	$_SESSION['cartitems'][$idx]['Turbo'] = $_POST['turbo'];
	
	header("Location: /shop/cart");
}

$query = $con->prepare("SELECT * FROM `items` WHERE `ID` = '{$user}' ORDER BY `Price` ASC, `ID`;");
$query->execute();
while($dvc = $query->fetch())
{
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
            افزودن به سبد خرید</div>
        <br/><br/>
		<?php if($dvc['Type'] == 1 || $dvc['Type'] == 2 || $dvc['Type'] == 3 || $dvc['Type'] == 4) { ?>
		<div id="ShopWrapper">
        <div class="bigCarImgContainer">
                <img src="public/img/Vehicles/<?php echo $dvc['Model'] ?>.png" alt="وسیله نقلیه">
        </div>
		<form name="shopForm" id="showForm" method="post">
        <table border="0" cellspacing="0" cellpadding="0" class="vTable" width="580px">
            <tbody>
			<tr class="firstRow"><td colspan="2" style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><span style="font-weight:bold; color:#FFFF00 !important; font-size:20px;"><?php echo $namevehicles[$dvc['Model']]; ?></span></td></tr>
			<tr>
                <td class="headerTd">نوع محصول</td>
                <td><?php
				if($dvc['Type'] == 1) echo "خودرو";
				else if($dvc['Type'] == 2) echo "موتور/دوچرخه";
				else if($dvc['Type'] == 3) echo "قایق/کشتی";
				else if($dvc['Type'] == 4) echo "هواپیما";
				?></td>
            </tr>
            <tr>
				<td class="headerTd">قیمت بازی</td>
				<td dir=ltr>$<?php echo number_format($dvc['Price'],0,"",","); ?></td>
			</tr>
			<tr>
				<td class="headerTd">قیمت واقعی</td>
				<td><?php echo number_formatfa(realPrice($dvc['Price'])); ?> تومان</td>
			</tr>
			<tr>
				<td class="headerTd">حداکثر سرعت</td>
				<td dir=ltr><?php echo $dvc['MaxSpeed']; ?> km/h</td>
			</tr>
            <tr class="lastRow">
                            </tr>
        </tbody></table>
		<hr>
		<table border="0" cellspacing="0" cellpadding="0" class="vTable" width="580px">
            <tbody>
			<tr class="firstRow"><td colspan="2" style="text-align:center; padding:10px 0; padding-bottom:10px; border-bottom: 1px groove #a2a2a2;;"><span style="font-weight:bold; color:#FF0000 !important; font-size:20px;">پیکربندی</span></td></tr>
			<tr>
                <td class="headerTd" style="vertical-align: middle;">رنگ وسیله نقلیه</td>
                <td>
				<input type="hidden" id="vColor" name="vColor" value="0">
				<div style="display: inline-block">
				رنگ های معمولی <br />
<?php for($i = 0; $i < sizeof($vehColors) / 2; $i++) { ?>
<div class="shopVehicleColor showTooltip <?php echo ($i == 0) ? "shopVehicleSelected" : "" ?>" id="<?php echo $i ?>" onclick="selectColor('<?php echo $i ?>');" data-toggle="tooltip" data-placement="bottom" style="background-color: #<?php echo $vehColors[$i] ?>" data-original-title="<?php echo $i ?>"></div>
<?php } ?>
</div> <br /><br />رنگ های ویژه <font color=red>(30% قیمت بیشتر)</font> <br /> <div style="display: inline-block">
<?php for($i = sizeof($vehColors) / 2; $i < sizeof($vehColors); $i++) { ?>
<div class="shopVehicleColor showTooltip" id="<?php echo $i ?>" onclick="selectColor('<?php echo $i ?>');" data-toggle="tooltip" data-placement="bottom" style="background-color: #<?php echo $vehColors[$i] ?>" data-original-title="<?php echo $i ?>"></div>
<?php } ?></div>
				</td>
            </tr>
			<tr>
                <td class="headerTd" style="vertical-align: middle;"><span class="showTooltip" data-toggle"tooltip" data-placement="bottom" data-original-title="20% توان موتور وسیله نقلیه و حداکثر سرعت آن را افزایش می دهد!">موتور توربوشارژ</span></td>
                <td><?php if($dvc['Type'] == 4 || $dvc['Price'] < 700000) echo "غیرقابل خرید برای این وسیله نقلیه"; else { ?><select name="turbo" style="margin-bottom: 0px;"> <option value="0">خیر</option> <option value="1">بله (60% قیمت بیشتر)</option> </select><?php } ?></td>
            </tr>
            <tr class="lastRow">
					<td colspan=2 class="headerTd"><a style="cursor: pointer; color:#1bd427;" onclick="document.getElementById('showForm').submit();"><i class="material-icons md-13" style="vertical-align: middle;">check</i> تائید و پردازش سفارش</a></td>
				</tr>
        </tbody></table>
		</form>
    </div>
	<?php } ?>
	</div>
</div>
</div>
</div></div></div>
<script>
function selectColor(id)
{
	$("#vColor").val(id);
	xx = document.getElementsByClassName("shopVehicleSelected");
	for (i = 0; i < xx.length; i++) {
		xx[i].classList.remove("shopVehicleSelected");
	}
	document.getElementById(id).classList.add("shopVehicleSelected");
}
</script>
<?php
}
?>