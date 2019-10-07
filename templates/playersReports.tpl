<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    شکایات
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li class="active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li class="prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li>
</ul>
</ul></div><div id="contentPage">
    <div class="subPageContainer">
        <div class="subPageTitle pageTitle">
            شکایات از کاربران
        </div>
		<div style="overflow: hidden;">
        <div class="searchBox">
            <select id="selectReportsFilter" style="float:right; margin-left:5px; height:30px;">
                <option value="1">گزارش داده شده توسط</option>
                <option value="2">بازیکن گزارش شده</option>
            </select>
            <input id="playerReportsSearchInput" class="searchInput inputblank placeholderContent" style="height:30px;" value="جستجو بر اساس اسم بازیکن" type="text" restore="جستجو بر اساس اسم بازیکن">
            <input data-location="/players/reports/search" id="playerReportsSearchButton" type="button" class="searchButton" value="جستجو">
        </div>
    </div>
    </div>
    </div>
        <div class="tableFull">
        <table border="0" cellspacing="0" cellpadding="0" class="fullTable">
            <tbody><tr class="headerRow">
                <td class="firstTd">بازیکن</td>
                <td>گزارش دهنده</td>
                <td>تاریخ ثبت</td>
                <td>پاسخ دهنده</td>
                <td>تاریخ پاسخ</td>
                <td>وضعیت</td>
                <td>مجازات شده</td>
                <td>مشاهده</td>
            </tr>
				<?php
					$query3 = $con->prepare("SELECT * FROM `reports` ORDER BY `ID` DESC;");
					$query3->execute();
					$c = 0;
					while($dnn = $query3->fetch())
					{
						$target = $dnn['Target'];
						$query4 = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$target}';");
						$query4->execute();
						$dnt = $query4->fetch();
						$reporter = $dnn['ReportedBy'];
						$query5 = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$reporter}';");
						$query5->execute();
						$dnr = $query5->fetch();
						$answerer = $dnn['Answerer'];
						if($answerer != -1) {
							$query6 = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$answerer}';");
							$query6->execute();
							$dna = $query6->fetch();
						}
						$c = 0;
						$c++
				?>
                    <tr>
                    <td>
                    <?php generalUserUrl($con, $dnt['Name'], $factions, $factionC, $factionR); ?>
						</div>
					</td>
					<td>
                    <?php generalUserUrl($con, $dnr['Name'], $factions, $factionC, $factionR); ?>
						</div>
					</td>
                    <td dir=ltr><?php echo jdate('Y/m/d H:i:s', $dnn['Time']) ?></td>
                    <td><?php
					if($answerer == -1) echo "هیچکس";
					else if($answerer == 0) echo "ربات";
					else {
					?>
                    <?php generalUserUrl($con, $dna['Name'], $factions, $factionC, $factionR); } ?></td>
                    <td dir=ltr><?php echo jdate('Y/m/d H:i:s', $dnn['ATime']) ?></td>
                    <td><?php if($dnn['Status'] == 0) echo "در حال بررسی"; else if($dnn['Status'] == 1) echo "پس گرفته شده"; else if($dnn['Status'] == 2) echo "بررسی شده";  ?></td>
                    <td><?php if($dnn['Punished'] == 0) { ?><i class="material-icons md-16" style="color:#1bd427;">tag_faces</i><?php } else { ?><i class="material-icons md-16" style="color:#e74015;">mood_bad</i><?php } ?></td>
                    <td><a href="/players/report/<?php echo $dnn['ID'] ?>">مشاهده</a></td>
	                </tr>
				<?php } ?>
				
                    </tbody></table>
    </div>
            </div>
		</div>
</div></div></div>