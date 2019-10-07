<div id="contentWrap"><div id="contentBox">
    <div class="pageTitle">
                    بازیکنان
            </div>
    <div id="contentMain">
<div id="leftSidebar"><ul><li class="first prev"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/online">بازیکنان آنلاین</a></li><li class="rightMenuItem"/></ul></li><li class="active"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/search">جستجوی بازیکن</a></li><li class="rightMenuItem"/></ul></li><li class="next"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/reports">شکایات <span class='numberBullet'><?php echo totalunAnsweredReports($con); ?></span></a></li><li class="rightMenuItem"/></ul></li><li><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/unbanRequests">رفع محرومیت <span class='numberBullet'>0</span></a></li><li class="rightMenuItem"/></ul></li><li class="last"><ul><li class="leftMenuItem"/><li class="menuItem"><a href="/players/polls">نظرسنجی‌ها</a></li><li class="rightMenuItem"/></ul></li></ul></div><div id="contentPage">
   <div class="subPageTitle pageTitle">
        جستجوی بازیکن
    </div>
    <div align="center">
        نام بازیکن موردنظر را وارد کنید
        <br/><br/>
            <div class="autosuggestDivContainer">
                <div class="inputSearchSuggestion" id="searchPlayerNameDiv">
                    <input name="name" type="text" dir=ltr class="autosuggestNormalInput textarea" id="searchPlayerName" />
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
</div></div></div>