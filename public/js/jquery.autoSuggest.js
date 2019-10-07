/*
 * AutoSuggest
 * Copyright 2009-2010 Drew Wilson
 * www.drewwilson.com
 * code.drewwilson.com/entry/autosuggest-jquery-plugin
 *
 * Version 1.4   -   Updated: Mar. 23, 2010
 *
 * This Plug-In will auto-complete or auto-suggest completed search queries
 * for you as you type. You can add multiple selections and remove them on
 * the fly. It supports keybord navigation (UP + DOWN + RETURN), as well
 * as multiple AutoSuggest fields on the same page.
 *
 * Inspied by the Autocomplete plugin by: Jšrn Zaefferer
 * and the Facelist plugin by: Ian Tearle (iantearle.com)
 *
 * This AutoSuggest jQuery plug-in is dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */

(function($){
    $.fn.autoSuggest = function(data, options) {

        var defaults = {
            minChars: 3,
            clickCallback: false,
            resultARender : false
        };
        var opts = $.extend(defaults, options);

        var d_count = 0;
        var d_data = null;
        var req_string = data;
        return this.each(function(){
            var input = $(this);
            input.attr("autocomplete","off").addClass("as-input");
            var x = input.attr("id");
            var input_focus = false;

            var results_holder = $('<div class="as-results" id="as-results-'+x+'"></div>').hide();

            var results_ul =  $('<ul class="as-list"></ul>');

            input.after(results_holder);

            var timeout = null;

            // Handle input field events
            input.focus(function(){
                if(input_focus){
                    if($(this).val() != ""){
                        results_holder.show();
                    }
                }
                input_focus = true;
                return true;
            }).blur(function(){
                    if(input_focus){
                        results_holder.hide();
                    }
                }).keydown(function(e) {
                    switch(e.keyCode) {
                        default:
                            if (timeout){ clearTimeout(timeout); }
                            timeout = setTimeout(function(){ keyChange(); }, 200);
                            break;
                    }
                });

            function keyChange() {
                var string = input.val().replace(/[\\]+|[\/]+/g,"");
                var fieldName = input.attr("name");
                var postData = {};
                postData[fieldName] = string;
                if (string.length >= opts.minChars) {
                        if(!processData(d_data, string))
                        {
                            $.post(req_string, postData, function(data) {
                                d_count = 0;
                                d_data = data;
                                for (k in data) if (data.hasOwnProperty(k)) d_count++;
                                processData(data, string);
                            }, 'json');
                        }
                }
                else
                {
                    if(string == '') results_holder.hide();
                    else if(!results_holder.is(':visible')) results_holder.show();
                }
            }

            var num_count = 0;
            function processData(data, query){
                query = query.toLowerCase();
                results_holder.html(results_ul.html("")).hide();
                var matchCount = 0;
                results_holder.html("").hide();
                for(var i=0;i<d_count;i++){
                    var num = i;
                    num_count++;
                    var forward = false;
                    var str = data[num]['value'];
                    if(str){
                        str = str.toLowerCase();
                        if(str.indexOf(query) != -1){
                            forward = true;
                        }
                    }
                    if(forward){
                        if(matchCount < 5)
                        {
                            var formatted = $('<li class="as-result-item" id="as-result-item-'+num+'"></li>').click(function(){
                                var raw_data = $(this).data("data");
                                var number = raw_data.num;
                            }).mousedown(function(){ input_focus = false; }).mouseover(function(){
                                    $("li", results_ul).removeClass("active");
                                    $(this).addClass("active");
                                }).data("data",{attributes: data[num], num: num_count});
                            var this_data = $.extend({},data[num]);
                            if (typeof this_data['click'] === 'undefined') {
                                this_data['click'] = "";
                            }
                            var $a;
                            if(isFunction(opts.resultARender))
                            {
                                $a = opts.resultARender(this_data['data'], this_data['value']);
                            }
                            else
                            {
                                $a = $('<a class="autosuggestResultA" data-data="'+this_data['data']+'" href="javascript:;">' + this_data['value'] + '</a>');
                            }
                            if(isFunction(opts.clickCallback))
                            {
                                $a.click(clickCallbackFunction(opts.clickCallback, $a, this_data['data'], this_data['value']));
                            }
                            else
                            {
                                $a.click(clickCallbackFunction(fillAutosuggestInput, $a, this_data['data'], this_data['value']));
                            }
                            formatted = formatted.append($a);
                            results_ul.append(formatted);
                            delete this_data;
                        }
                        matchCount++;
                    }
                }
                results_ul.css({"width": input.outerWidth(), "top": input.outerHeight()});
                results_holder.append(results_ul);
                results_holder.show();
                return matchCount;
            }
        });
    }
})(jQuery);

function clickCallbackFunction(callback, element, data, value) {
    return function()
    {
        callback(element, data, value);
    }
}

function isFunction(functionToCheck) {
    var getType = {};
    return functionToCheck && getType.toString.call(functionToCheck) === '[object Function]';
}

function fillAutosuggestInput(element, data, value)
{
    var $autosuggestDivContainer = $(element).closest(".autosuggestDivContainer");
    var $autosuggestNormalInput = $autosuggestDivContainer.find(".autosuggestNormalInput");
    $autosuggestDivContainer.find(".autosuggestHiddenInput").val(data);
    $autosuggestNormalInput.val(value);
    $autosuggestNormalInput.trigger('focus');
    $autosuggestNormalInput.trigger('blur');
};