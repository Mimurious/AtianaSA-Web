<div id="content">
            <div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
        رقابت‌ها
        </div>
    <div id="contentMain">
    <div id="leftSidebar">
        <ul>
			<li class="first active">
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/turfs">مناطق</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
            <li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/gangsters">برترین گانگسترها</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/upcoming">در پیش رو</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/viewall">نمایش همه</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/interdictionRequests">درخواست‌های مسدودیت</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/interdictionList">لیست مسدودیت</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
			<li>
                <ul>
                    <li class="leftMenuItem" />
                    <li class="menuItem"><a href="/wars/allianceWars">رقابت‌های آخرهفته</a></li>
                    <li class="rightMenuItem" />
                </ul>
            </li>
        </ul>
    </div>
    <div id="contentPage">
    <div class="contentTabberPage">
        <div class="subPageTitle pageTitle">
        مناطق
    </div>
    <div class="actionArea">
            </div>
        <div class="map" dir=ltr>
					<?php
					$query = $con->prepare("SELECT * FROM `zones`;");
					$query->execute();
					while($tvc = $query->fetch())
					{
					?>
                    <a href="/wars/zone/<?php echo $tvc['ID'] ?>">
                    <div title=""
					class="showTooltip turf"
					data-name="<?php echo $tvc['Name'] ?>"
					data-id="<?php echo $tvc['ID'] ?>"
					data-intervals=""
					style="top: <?php echo -($tvc['MinY'] / (6000 / 710) - 306) ?>px;
					left: <?php echo ($tvc['MinX'] / (6000 / 710)) + 355 ?>px;
					width: <?php echo ($tvc['MaxX'] - $tvc['MinX']) / (6000 / 710) ?>px;
					height: <?php echo ($tvc['MaxY'] - $tvc['MinY']) / (6000 / 710) ?>px;
					background-color: #<?php echo $factionC[$tvc['Team']] ?>;"
					data-original-title="<?php echo $tvc['Name'] ?>">
					</div>
                    </a>
					<?php
					}
					?>
    </div>
    <div class="turfLegend">
        <ul class="turfGangList">
            <li class="turfTitle">مافیاها</li>
            <li>
                <div class="vehicleColor" style="background-color: #<?php echo $factionC[8]; ?>; margin-top:4px;"></div>&nbsp;- <?php echo $factions[8]; ?>
            </li>
            <li>
                <div class="vehicleColor" style="background-color: #<?php echo $factionC[10]; ?>; margin-top:4px;"></div>&nbsp;- <?php echo $factions[10]; ?>
            </li>
        </ul>
        <ul class="turfGangList">
            <li class="turfTitle">خاندان‌ها</li>
            <li>
                <div class="vehicleColor" style="background-color: #<?php echo $factionC[9]; ?>; margin-top:4px;"></div>&nbsp;- <?php echo $factions[9]; ?>
            </li>
            <li>
                <div class="vehicleColor" style="background-color: #<?php echo $factionC[11]; ?>; margin-top:4px;"></div>&nbsp;- <?php echo $factions[11]; ?>
            </li>
        </ul>

    </div>            </div>
                </div>