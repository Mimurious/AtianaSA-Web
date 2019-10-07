<div id="contentWrap"><div id="contentBox">
	<div class="pageTitle">
		خانه
	</div>
	<div id="contentMain">
		<div id="contentPage" style="padding: 20px 20px 40px 20px;">
			<div id="homeHeaderContent" style="position:relative;">
			<?php if (file_exists($_SERVER['DOCUMENT_ROOT'] . "/public/img/announce.jpg")) {
			?>
			<div align="center">
			<img src="public/img/announce.jpg?<?php echo filemtime($_SERVER['DOCUMENT_ROOT'] . "/public/img/announce.jpg") ?>" width=100%>
			</div>
			<br />
			<?php } ?>
				<div class="homeStats" style="display: block; margin: auto;">
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#1bd427;">person_add</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#1bd427;"><?php echo number_formatfa(newPlayers($con)); ?></span><br /> بازیکن جدید در هفته اخیر
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#e5575e;">directions_run</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#e5575e;"><?php echo number_formatfa(totalPlayers($con)) . " از " . number_formatfa(totalTPlayers($con)); ?></span><br /> بازیکن فعال در هفته اخیر
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#9c7ee7">query_builder</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#9c7ee7;"><?php echo number_formatfa(totalHours($con)); ?></span><br /> ساعات بازی شده این ماه
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#C4C4C4">trending_up</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#FF0000;"><?php generalUserUrl($con, mostOnline($con), $factions, $factionC, $factionR); ?></span><br />فعال ترین بازیکن این ماه
						</div>
					</div>
					<div class="statsArea" style="clear:left;">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#d2527f;">face</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#d2527f;"><?php echo number_formatfa(totalSkins($con)); ?></span><br /> چهره در سرور
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#F9690E;">group_work</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#F9690E;"><?php echo number_formatfa(totalClans($con)); ?></span><br /> کلن در سرور
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#41b691;">calendar_today</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#41b691;"><?php echo number_formatfa(totalEvents($con)); ?></span><br /> رویداد فعال
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#8e44ad;">accessibility_new</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#FF0000;"><?php generalUserUrl($con, newestPlayer($con), $factions, $factionC, $factionR); ?></span><br /> جدیدترین بازیکن
						</div>
					</div>
					<div class="statsArea" style="clear:left;">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#87D37C;">supervisor_account</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#87D37C;"><?php echo number_formatfa(totalOnline($con)); ?></span><br /> بازیکنان آنلاین
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#eef02e;">home</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#eef02e;"><?php echo number_formatfa(totalHouses($con)); ?></span><br /> خانه در سرور
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#28a2bd;">drive_eta</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#28a2bd;"><?php echo number_formatfa(totalVehicles($con)); ?></span><br /> وسیله نقلیه در سرور
						</div>
					</div>
					<div class="statsArea">
						<div style="float:right;">
							<i class="material-icons md-48" style="color:#eca520;">location_city</i>
						</div>
						<div style="float:right; padding:4px; line-height: 20px;">
							<span style="font-size:15px; color:#eca520;"><?php echo number_formatfa(totalBizes($con)); ?></span><br /> تجارت در سرور
						</div>
					</div>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div id="pageContent">
				<p><span style="font-size:20px"><strong>چرا آتیانا: سن آندریاس - زندگی مجازی؟</strong></span></p>

				<p>&nbsp;</p>

				<p><a href="https://sa.atiana.ir">آتیانا: سن آندریاس - زندگی مجازی</a> در تاریخ <span style="color:#FF0000"><strong><?php echo numberfa("22 بهمن 1396"); ?></strong></span> افتتاح گردید. از همان لحظه افتتاح در مدت زمانی کوتاه به موفقیتی بزرگ دست یافت و سریعاً به معروفیت رسید. </p>
				
				<p>&nbsp;</p>
				
				<p>در سرورها و بازی‌های آتیانا شما ریسک از دست دادن اطلاعات خود را ندارید. سرورها برای مدت زمانی طولانی بی وقفه آنلاین بوده و ما نگهداری آن‌ها را وظیفه خود می دانیم. اطلاعات اعضا در سرور هیچگاه از بین نرفته و همیشه در هر لحظه ما در حال تلاش برای بهبود کیفیت و امنیت آن بوده ایم.</p>

				<p>&nbsp;</p>

				<p>کارکنان سرورها و بازی‌های آتیانا از بین افراد باتجربه انتخاب شده اند و تابع قوانین وضع شده برای سرور هستند. حتی اگر کارکنان برخورد بد و ناپسند و یا حتی اشتباهی با شما داشتند به راحتی میتوانید از آنها شکایت کرده و در صورت صحیح بودن شکایت خود حق خود را از آنها بگیرید. حقوق و راحتی بازیکنان برای ما نسبت به کارکنان ارجحیت نسبتاً بالایی دارد.</p>

				
				<p>&nbsp;</p>
				
				<p>هدف ما در سرورها و بازی‌های آتیانا راحتی بازیکنان بوده، هست و خواهد بود. در راستای تحقق اهدافمان نیز کنترل پنل‌های کاربری برای بازی‌ها را برای راحتی آنها تولید و در دسترس قرار داده ایم که قابلیت‌های زیادی از قبیل عضویت در اقلیت ها، شکایات، دیدن پروفایل بازیکنان دیگر، گزارش مشکلات و ... در آن گنجانده شده و قابل استفاده می باشد.</p>

				
				<p>&nbsp;</p>

				<p>دسترسی به آتیانا: سن آندریاس - زندگی مجازی از طریق آدرس‌های زیر امکان پذیر می‌باشد:
				<li>
				آدرس ثابت اتصال به سرور زندگی مجازی: <span style="color:#FF0000"><strong>SA.Atiana.IR:7777</strong></span>
				</li>
				<li>
				آدرس داخلی اتصال به سرور زندگی مجازی: <span style="color:#FF0000"><strong>193.176.242.123:7777</strong></span>
				</li>
				</p>
				
				<!--
				<p>&nbsp;</p>
				<p>
				<div id="15352310176373507" style="text-align: center;"><script type="text/JavaScript" src="https://www.aparat.com/embed/CX5Aq?data[rnddiv]=15352310176373507&data[w]=640"></script></div>
				</p>
				
				<p>&nbsp;</p>
				<p><span style="font-size:20px"><strong>لینک‌های کاربردی</strong></span></p>
				<p><br>
				<a href="http://forum.caspiansamp.ir/forum/13-%D8%A2%D9%85%D9%88%D8%B2%D8%B4%E2%80%8C%D9%87%D8%A7/" target="_blank"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">آموزش‌های مجموعه</font></font></a><br>
				<a href="http://forum.caspiansamp.ir/forum/51-%D8%A2%D9%85%D9%88%D8%B2%D8%B4%E2%80%8C%D9%87%D8%A7%DB%8C-%D8%B2%D9%86%D8%AF%DA%AF%DB%8C-%D9%85%D8%AC%D8%A7%D8%B2%DB%8C/" target="_blank"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">آموزش‌های سرور زندگی مجازی </font></font></a><br>
				<a href="http://forum.caspiansamp.ir/forum/12-%D9%BE%D8%B1%D8%B3%D8%B4-%D9%88-%D9%BE%D8%A7%D8%B3%D8%AE/"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">پرسش و پاسخ </font></font></a><br>
				<a href="http://forum.caspiansamp.ir/forum/44-%D9%BE%D8%B4%D8%AA%DB%8C%D8%A8%D8%A7%D9%86%DB%8C/" target="_blank"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">مشکلات و پشتیبانی سرور زندگی مجازی </font></font></a></p></div>
				!-->
			</div>
		</div>
	</div>
</div></div></div>
