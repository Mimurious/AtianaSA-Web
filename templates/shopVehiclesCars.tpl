<?php if(!isset($_SESSION['cartitems'])) $_SESSION['cartitems'] = array() ?>
<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        فروشگاه
    </div>
    <div id="contentMain">
    <div id="leftSidebar">
        <ul>
            <li class="first">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/shop/cart">سبد خرید <span class="numberBullet"><?php echo sizeof($_SESSION['cartitems']) ?></span></a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
            <li class="active">
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
        <div class="topTabs">
    <ul>
        <li><a href="/shop/vehicles/cars">خودرو</a></li>
        <li><a href="/shop/vehicles/bikes">موتور و دوچرخه</a></li>
		<li><a href="/shop/vehicles/boats">قایق و کشتی</a></li>
		<li><a href="/shop/vehicles/planes">هلیکوپتر و هواپیما</a></li>
    </ul>
</div>        <div class="subPageTitle pageTitle">
            خرید وسیله نقلیه - خودرو        </div>
        <br/><br/>
		<div class="vehiclesContainer">  
		<?php
		$query = $con->prepare("SELECT * FROM `items` WHERE `type` = 1 ORDER BY `Price` ASC, `ID`;");
		$query->execute();
		while($dvc = $query->fetch())
		{
		?>
		 <div class="vehicleBox">
			<div class="vehicleImgContainer">
				<img class="vehicleImg" src="public/img/Vehicles/<?php echo $dvc['Model']; ?>.png" alt="وسیله نقلیه">
			</div>
			<table border="0" cellspacing="0" cellpadding="0" class="vTable generalVehicleTable">
				<tbody><tr>
					<td class="headerTd">مدل وسیله نقلیه</td>
					<td><?php echo $namevehicles[$dvc['Model']]; ?></td>
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
					<td colspan=2 class="headerTd"><a href="/shop/addcart/<?php echo $dvc['ID']; ?>"><i class="material-icons md-13" style="color:#1bd427;">shopping_cart</i></a></td>
				</tr>
			</tbody></table>
		</div>
		<?php
		}
		?>
	</div>
	</div>
</div>
</div>
</div></div></div>