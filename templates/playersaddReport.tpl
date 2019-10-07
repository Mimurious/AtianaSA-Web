<?php
$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$user}' LIMIT 1;");
$query->execute();
$xx = 0;
while($dnn = $query->fetch())
{
	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		$target = $dnn['ID'];
		$reporter = $_SESSION['pid'];
		$time = time();
		$reason = $_POST['reportExplanation'];
		$type = $_POST['reportReason'];
		$proof = $_POST['reportProof'];
		$witness1 = $_POST['reportWitnesses'][0];
		$witness2 = $_POST['reportWitnesses'][1];
		$queryx = $con->prepare("INSERT INTO `reports`(`Target`, `ReportedBy`, `Time`, `Reason`, `Type`, `Proofs`, `Witness1`, `Witness2`) VALUES ('{$target}', '{$reporter}', '{$time}', '{$reason}', '{$type}', '{$proof}', '{$witness1}', '{$witness2}');");
		$queryx->execute();
		
		$query = $con->prepare("SELECT * FROM `reports` WHERE `Time` = '{$time}' ORDER BY `ID` DESC;");
		$query->execute();
		$rep = $query->fetch();
		$repid = $rep['ID'];
		header("Location: /players/report/{$repid}");
	}

$xx = 1;
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    <?php echo $user ?>
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li class="prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li>
<li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/general/<?php echo $user ?>">اطلاعات عمومی</a></li><li class="rightMenuItem"></li></ul></li><li class="next"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/achievements/<?php echo $user ?>">دستاوردها</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/monthlyPlayed/<?php echo $user ?>">رده بندی ماهانه</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/faction/<?php echo $user ?>">اقلیت</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/clan/<?php echo $user ?>">کلن</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/job/<?php echo $user ?>">شغل</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/vehicles/<?php echo $user ?>">دارایی</a></li><li class="rightMenuItem"></li></ul></li><li><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/playerstats/<?php echo $user ?>">اطلاعات بازیکن</a></li><li class="rightMenuItem"></li></ul></li><li class="last"><ul><li class="leftMenuItem"></li><li class="menuItem"><a href="/players/friends/<?php echo $user ?>">دوستان</a></li><li class="rightMenuItem"></li></ul>
</ul></div><div id="contentPage">
    <div class="subPageTitle pageTitle">
        گزارش
		<?php echo $user; ?>
    </div>
	<div class="normalTextBox">
        <form action="" method="post" name="formular">
            <table border="0" style="width: 100%; padding: 50px;">
                <tbody><tr>
                    <td>اطلاعات بازیکنی که از او شکایت دارید:</td>
                </tr>
                <tr>
                    <td><div style="display: inline; margin-right: 5px;"><img class="showTooltip" style="display: inline; margin-top: 3px;" src="public/img/<?php 
						if($dnn['Status'] == 0) echo "offline";
						else if($dnn['Status'] == 1) echo "online";
						else if($dnn['Status'] == 2) echo "afk";
						?>.png" alt="<?php 
						if($dnn['Status'] == 0) echo "آفلاین";
						else if($dnn['Status'] == 1) echo "آنلاین";
						else if($dnn['Status'] == 2) echo "دور از دسترس";
						?>" data-toggle="tooltip" title="<?php 
						if($dnn['Status'] == 0) echo "آفلاین";
						else if($dnn['Status'] == 1) echo "آنلاین";
						else if($dnn['Status'] == 2) echo "دور از دسترس";
						?>"/></div>
                    <?php generalUserUrl($con, $dnn['Name'], $factions, $factionC, $factionR); ?> - سطح <?php echo $dnn['Level']; ?> - تجربه <span dir=ltr><?php echo $dnn['Respect'] ?> / <?php echo (($dnn['Level'] == 1) ? 2 : ($dnn['Level'] * 2) - 2); ?></span></td>
                </tr>
                <tr>
                    <td>دلیل شکایت:</td>
                </tr>
                <tr>
                    <td>
                        <select name="reportReason">
							<?php
							for($i = 1; $i < sizeof($reasontypes); $i++)
							{
								$reason = $reasontypes[$i];
								echo "<option value={$i}>{$reason}</option>";
							}
							?>
						</select>
                    </td>
                </tr>
                <tr>
                    <td>توضیحات:</td>
                </tr>
                <tr>
                    <td><textarea required type="text" class="normalTextarea big" name="reportExplanation"></textarea></td>
                </tr>
                <tr>
                    <td>مدارک:</td>
                </tr>
                <tr>
                    <td><textarea required type="text" class="normalTextarea big" name="reportProof"></textarea></td>
                </tr>
                <tr>
                    <td>شاهدین:</td>
                </tr>
                <tr>
                    <td>
                        <div class="autosuggestDivContainer">
                            <input type="hidden" class="autosuggestHiddenInput" name="reportWitnesses[]" id="reportWitness1">
                            <div class="inputSearchSuggestion" id="searchPlayerNameDiv">
                                <input name="name" type="text" class="autosuggestNormalInput textarea as-input" id="searchWitness1Name" autocomplete="off"><div class="as-results" id="as-results-searchWitness1Name" style="display: none;"></div>
                            </div>
                        </div>
                        <div class="autosuggestDivContainer">
                            <input type="hidden" class="autosuggestHiddenInput" name="reportWitnesses[]" id="reportWitness2">
                            <div class="inputSearchSuggestion" id="searchPlayerNameDiv">
                                <input name="name" type="text" class="autosuggestNormalInput textarea as-input" id="searchWitness2Name" autocomplete="off"><div class="as-results" id="as-results-searchWitness2Name" style="display: none;"></div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><input type="submit" class="normalButton" style="margin: 0 auto;" value="ثبت شکایت"></td>
                </tr>
            </tbody></table>
        </form>
    </div>
    </div>
	<script>

        $(document).ready(function() {
            $("#searchWitness1Name").autoSuggest("/players/autosuggest/");
            $("#searchWitness2Name").autoSuggest("/players/autosuggest/");
        });

    </script>
                </div>
<?php
}
if(!$xx)
{
?>
<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    بازیکنان
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li class="last"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li></ul></div><div id="contentPage">
   <div class="subPageTitle pageTitle">
        جستجوی بازیکن
    </div>
    <div align="center"> <div class='normalTextBox'>بازیکن مورد نظر پیدا نشد، از صحیح بودن اطلاعات ورودی اطمینان حاصل کنید.<br><br>
	<div class="autosuggestDivContainer">
                <div class="inputSearchSuggestion" id="searchPlayerNameDiv">
                    <input name="name" type="text" dir=ltr class="autosuggestNormalInput textarea" id="searchPlayerName" value="<?php echo $user ?>" />
                </div>
            </div>
			</div>
    
<script>
    $(document).ready(function() {
        $("#searchPlayerName").autoSuggest("/players/autosuggest/",
        {
            resultARender: function(data, value)
            {
                var $a = $('<a class="autosuggestResultA" data-data="'+data+'" href="/players/general/'+value+'">' + value + '</a>');
                return $a;
            }
        });
  
            });
</script>            </div>
                </div>
			</div>
		</div>
	</div>

<?php } ?>
</div></div></div>