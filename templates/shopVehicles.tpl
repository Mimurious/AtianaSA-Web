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
                    <li class="menuItem"><a href="/shop/cart">سبد خرید <span class="numberBullet"><?php echo sizeof($_SESSION['cartitems']) ?></a></li>
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
            خرید وسیله نقلیه</div>
        <br/><br/>
			<div class="vehiclesContainer">  
			 <div class="vehicleBox">
				<table border="0" cellspacing="0" cellpadding="0" class="vTable generalVehicleTable">
					<tbody>
					<tr>
						<td colspan=2><a href="/shop/vehicles/cars"><img width=230px src="public/img/dealCar.jpg" alt="وسیله نقلیه"></a></td>
					</tr>
					<tr>
						<td class="headerTd">تعداد مدل‌ها</td>
						<td><?php echo totalDealer1($con); ?> نوع</td>
					</tr>
					<tr>
						<td class="headerTd">شروع از</td>
						<td dir=ltr>$<?php echo number_format(minDealer1($con),0,"",","); ?></td>
					</tr>
				</tbody></table>
			</div>
			<div class="vehicleBox">
				<table border="0" cellspacing="0" cellpadding="0" class="vTable generalVehicleTable">
					<tbody>
					<tr>
						<td colspan=2><a href="/shop/vehicles/bikes"><img width=230px src="public/img/dealBikes.jpg" alt="Bikes"></a></td>
					</tr>
					<tr>
						<td class="headerTd">تعداد مدل‌ها</td>
						<td><?php echo totalDealer2($con); ?> نوع</td>
					</tr>
					<tr>
						<td class="headerTd">شروع از</td>
						<td dir=ltr>$<?php echo number_format(minDealer2($con),0,"",","); ?></td>
					</tr>
				</tbody></table>
			</div>
			<div class="vehicleBox">
				<table border="0" cellspacing="0" cellpadding="0" class="vTable generalVehicleTable">
					<tbody>
					<tr>
						<td colspan=2><a href="/shop/vehicles/boats"><img width=230px src="public/img/dealBoats.jpg" alt="Boats"></td>
					</tr>
					<tr>
						<td class="headerTd">تعداد مدل‌ها</td>
						<td><?php echo totalDealer3($con); ?> نوع</td>
					</tr>
					<tr>
						<td class="headerTd">شروع از</td>
						<td dir=ltr>$<?php echo number_format(minDealer3($con),0,"",","); ?></td>
					</tr>
				</tbody></table>
			</div>
			<div class="vehicleBox">
				<table border="0" cellspacing="0" cellpadding="0" class="vTable generalVehicleTable">
					<tbody>
					<tr>
						<td colspan=2><a href="/shop/vehicles/planes"><img width=230px src="public/img/dealPlanes.jpg" alt="Planes"></td>
					</tr>
					<tr>
						<td class="headerTd">تعداد مدل‌ها</td>
						<td><?php echo totalDealer4($con); ?> نوع</td>
					</tr>
					<tr>
						<td class="headerTd">شروع از</td>
						<td dir=ltr>$<?php echo number_format(minDealer4($con),0,"",","); ?></td>
					</tr>
				</tbody></table>
			</div>
		</div>
	</div>
</div>
</div>
</div></div></div>