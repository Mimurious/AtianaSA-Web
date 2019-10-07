function getAccountId(name)
{
    /*

    $.ajax({
        //async: false,
        type: "POST",
        url: "/players/ajaxGetAccountId",
        data: {name: name},
        success: function(data)
        {
            if(data[0]['error']) x = data[0]['error'];
            else x = data[0]['message'];
        }
    });
    */
    var x = -1;
    $.when(
        $.ajax({
            type: "POST",
            url: "/players/ajaxGetAccountId",
            data: {name: name}
        })
    ).then(function(data) {
        x = data[0]['message'];
        alert(x);
        console.log(x);
    });
    //return x;
}

$(document).ready(function() {

    var currentPath = window.location.pathname;
    if(typeof(loginurl) != "undefined")
    {
        currentPath = loginurl;
    }
    var realPath = '';
    var depth = currentPath.split("/").length-1;
    for(var i=0;i<=depth;i++)
    {
        if(i>0) realPath += '/';
        realPath += currentPath.split("/")[i];
        $(".topMenu a[href='"+realPath+"']").addClass("active");
        $(".topMenu a[href='"+realPath+"']").parentsUntil( "#menu", "li").addClass("active");
        $(".topTabs a[href='"+realPath+"']").addClass("active");
        $(".topTabs a[href='"+realPath+"']").parentsUntil( ".topTabs", "li").addClass("active");
    }

    $("#selectAll").click(function()
    {
        $('.optionBox').prop('checked', true);
    });

    $("#deselectAll").click(function()
    {
        $('.optionBox').prop('checked', false);
    });

    $("#toggleAttack").click(function()
    {
        $.ajax({
            type: "POST",
            url: "/wars/toggleAttack",
            data: {id: null},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    });

    $("#toggleQuest").click(function()
    {
        $.ajax({
            type: "POST",
            url: "/admin/toggleQuest",
            data: {id: null},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    });

    $(".lastNotificationsMarkAllAsReadLink").click(function()
    {
        var url = $(this).data("url");
        $.ajax({
            type: "POST",
            url: "/notifications/markAllAsRead",
            data: {},
            success: function(data)
            {
                document.location.href = url;
            }
        });
    });

    $(".notificationMarkAsReadLink").click(function()
    {
        var url = $(this).data("url");
        var id = $(this).data("id");
        $.ajax({
            type: "POST",
            url: "/notifications/markAsRead",
            data: {id : id},
            success: function(data)
            {
                document.location.href = url;
            }
        });
    });

    $("#evictAll").click(function()
    {
        var houseId = $("#evictAll").data("id");
        evictAll(houseId);
    });

    var evictAll = function(houseId)
    {
        bootbox.confirm('Are you sure you want to evict all your offline renters?', function(confirm) {
            if(confirm)
                sendEvictAll(houseId);
            else return;
        });
    };

    var sendEvictAll = function(houseId)
    {
        $.ajax({
            type: "POST",
            url: "/account/evictAll",
            data: {houseId: houseId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".evictRenter").click(function()
    {
        var playerId = $(this).data("id");
        var playerName = $(this).data("name");
        evictRenter(playerId, playerName);
    });

    var evictRenter = function(playerId, playerName)
    {
        bootbox.confirm('Are you sure you want to evict '+playerName+' from your house?', function(confirm) {
            if(confirm)
                sendEvictRenter(playerId);
            else return;
        });
    };

    var sendEvictRenter = function(playerId)
    {
        $.ajax({
            type: "POST",
            url: "/account/evictRenter",
            data: {playerId: playerId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    function emptyStars(star) {
        for(var i = 1; i <= 5; i++) {
            star.html("star_border");
            star = star.next("i");
        }
    }

    function setDefaultStarFill(star, rating) {
        emptyStars(star);
        for(var i = 1; i <= rating; i++) {
            star.html("star");
            star = star.next("i");
        }
    }

    $(".stars").each(function() {
        var rating = $(this).data("rating");
        setDefaultStarFill($(this).first().children(".star-1"), rating);
    });

    $('.star').on('mouseenter', function() {
        var nr = $(this).data('star');
        var i, j;
        var star = $(this).parent().children(".star-1");
        for(i = 1; i <= nr; i++) {
            star.html('star');
            star = star.next("i");
        }
        //star = $(this).parent().children(".star-"+i);
        for(j = i; j <= 5; j++) {
            star.html('star_border');
            star = star.next("i");
        }
    }).on('mouseleave', function() {
        var rating = $(this).parent().data("rating");
        setDefaultStarFill($(this).parent().children(".star-1"), rating);
    });

    $(".star").click(function()
    {
        var rating = $(this).data("star");
        var updateId = $(this).data("update");
        addRating(rating, updateId);
    });

    var addRating = function(rating, updateId)
    {
        bootbox.confirm('آیا شما مطمئن هستید که میخواهید به این بروزرسانی '+rating+' امتیاز بدهید؟', function(confirm) {
            if(confirm)
                sendAddRating(rating, updateId);
            else return;
        });
    };

    var sendAddRating = function(rating, updateId)
    {
        $.ajax({
            type: "POST",
            url: "/updates/addRating/",
            data: {rating: rating, updateId: updateId},
            success: function(data)
            {
                bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#editWarns").click(function()
    {
        var playerName = $(this).data("player-name");
        editWarns(playerName);
    });

    var editWarns = function(playerName)
    {
        bootbox.dialog({
                title: "Edit Warns",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>New value: &nbsp;</td>' +
                                '<td><input type="text" name="newVal" id="newVal" style="height:30px; width:310px;" /></td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var newVal = $('#newVal').val();
                            sendEditWarns(playerName, newVal);
                        }
                    }
                }
            }
        );
    };

    var sendEditWarns = function(playerName, newVal)
    {
        $.ajax({
            type: "POST",
            url: "/players/editWarns",
            data: {playerName: playerName, newWarns: newVal},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".editStats").click(function()
    {
        var playerName = $(this).data("player-name");
        var statName = $(this).data("stat-name");
        editStats(playerName, statName);
    });

    var editStats = function(playerName, statName)
    {
        var premium = "";
        if(statName == "premium account")
            premium = " (dd-mm-yyyy)";
        bootbox.dialog({
                title: "Edit " + statName.substr(0, 1).toUpperCase() + statName.substr(1),
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>New value' + premium + ': &nbsp;</td>' +
                '<td><input type="text" name="newVal" id="newVal" style="height:30px; width:310px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var newVal = $('#newVal').val();
                            sendEditStats(playerName, statName, newVal);
                        }
                    }
                }
            }
        );
    };

    var sendEditStats = function(playerName, statName, newVal)
    {
        $.ajax({
            type: "POST",
            url: "/players/editStats",
            data: {playerName: playerName, statName: statName, newVal: newVal},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".editLicense").click(function()
    {
        var playerName = $(this).data("player-name");
        var licenseName = $(this).data("license-name");
        editLicense(playerName, licenseName);
    });

    var editLicense = function(playerName, licenseName)
    {
        bootbox.dialog({
                title: "Edit " + licenseName.substr(0, 1).toUpperCase() + licenseName.substr(1),
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>New value: &nbsp;</td>' +
                '<td><input type="text" name="newVal" id="newVal" style="height:30px; width:310px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var newVal = $('#newVal').val();
                            sendEditLicense(playerName, licenseName, newVal);
                        }
                    }
                }
            }
        );
    };

    var sendEditLicense = function(playerName, licenseName, newVal)
    {
        $.ajax({
            type: "POST",
            url: "/players/editLicense",
            data: {playerName: playerName, licenseName: licenseName, newVal: newVal},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#addCarSlot").click(function()
    {
        var playerId = $("#addCarSlot").data("player-id");
        var playerName = $("#addCarSlot").data("player-name");
        addCarSlot(playerId, playerName);
    });

    var addCarSlot = function(playerId, playerName)
    {
        bootbox.confirm('Are you sure you want to add a car slot to player '+playerName+'?', function(confirm) {
            if(confirm)
                sendAddCarSlot(playerId);
            else return;
        });
    };

    var sendAddCarSlot = function(playerId)
    {
        $.ajax({
            type: "POST",
            url: "/players/addCarSlot",
            data: {playerId: playerId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#addVehicle").click(function()
    {
        var playerId = $("#addVehicle").data("player-id");
        addVehicle(playerId);
    });

    var getCarsArray = function()
    {
        var carname = [];

        carname[400]='Landstalker';
        carname[401]='Bravura';
        carname[402]='Buffalo';
        carname[403]='Linerunner';
        carname[404]='Perennial';
        carname[405]='Sentinel';
        carname[406]='Dumper';
        carname[407]='Firetruck';
        carname[408]='Trashmaster';
        carname[409]='Stretch';
        carname[410]='Manana';
        carname[411]='Infernus';
        carname[412]='Voodoo';
        carname[413]='Pony';
        carname[414]='Mule';
        carname[415]='Cheetah';
        carname[416]='Ambulance';
        carname[418]='Moonbeam';
        carname[419]='Esperanto';
        carname[420]='Taxi';
        carname[421]='Washington';
        carname[422]='Bobcat';
        carname[423]='Mr Whoopee';
        carname[424]='BF Injection';
        carname[426]='Premier';
        carname[427]='Enforcer';
        carname[428]='Securicar';
        carname[429]='Banshee';
        carname[431]='Bus';
        carname[432]='Rhino';
        carname[433]='Barracks';
        carname[434]='Hotknife';
        carname[435]='Artic trailer 1';
        carname[436]='Previon';
        carname[437]='Coach';
        carname[438]='Cabbie';
        carname[439]='Stallion';
        carname[440]='Rumpo';
        carname[442]='Romero';
        carname[443]='Packer';
        carname[444]='Monster';
        carname[445]='Admiral';
        carname[449]='Tram';
        carname[450]='Artic trailer 2';
        carname[451]='Turismo';
        carname[455]='Flatbed';
        carname[456]='Yankee';
        carname[457]='Caddy';
        carname[458]='Solair';
        carname[459]='Top fun';
        carname[466]='Glendale';
        carname[467]='Oceanic';
        carname[470]='Patriot';
        carname[474]='Hermes';
        carname[475]='Sabre';
        carname[477]='ZR350';
        carname[478]='Walton';
        carname[479]='Regina';
        carname[480]='Comet';
        carname[482]='Burrito';
        carname[483]='Camper';
        carname[485]='Baggage';
        carname[486]='Dozer';
        carname[489]='Rancher';
        carname[490]='FBI Rancher';
        carname[491]='Virgo';
        carname[492]='Greenwood';
        carname[494]='Hotring';
        carname[495]='Sandking';
        carname[496]='Blista Compact';
        carname[498]='Boxville';
        carname[499]='Benson';
        carname[500]='Mesa';
        carname[502]='Hotring A';
        carname[503]='Hotring B';
        carname[504]='Blood ring banger';
        carname[505]='Rancher';
        carname[506]='Super GT';
        carname[507]='Elegant';
        carname[508]='Journey';
        carname[514]='Petrol';
        carname[515]='Roadtrain';
        carname[516]='Nebula';
        carname[517]='Majestic';
        carname[518]='Buccaneer';
        carname[524]='Cement';
        carname[525]='Towtruck';
        carname[526]='Fortune';
        carname[527]='Cadrona';
        carname[528]='FBI Truck';
        carname[529]='Williard';
        carname[530]='Fork lift';
        carname[531]='Tractor';
        carname[532]='Combine';
        carname[533]='Feltzer';
        carname[534]='Remington';
        carname[535]='Slamvan';
        carname[536]='Blade';
        carname[537]='Freight';
        carname[538]='Streak';
        carname[539]='Vortex';
        carname[540]='Vincent';
        carname[541]='Bullet';
        carname[542]='Clover';
        carname[543]='Sadler';
        carname[544]='Firetruck LA';
        carname[545]='Hustler';
        carname[546]='Intruder';
        carname[547]='Primo';
        carname[549]='Tampa';
        carname[550]='Sunrise';
        carname[551]='Merit';
        carname[552]='Utility van';
        carname[554]='Yosemite';
        carname[555]='Windsor';
        carname[556]='Monster A';
        carname[557]='Monster B';
        carname[558]='Uranus';
        carname[559]='Jester';
        carname[560]='Sultan';
        carname[561]='Stratum';
        carname[562]='Elegy';
        carname[565]='Flash';
        carname[566]='Tahoma';
        carname[567]='Savanna';
        carname[568]='Bandito';
        carname[569]='Freight flat';
        carname[570]='Streak';
        carname[571]='Kart';
        carname[572]='Mower';
        carname[573]='Duneride';
        carname[574]='Sweeper';
        carname[575]='Broadway';
        carname[576]='Tornado';
        carname[578]='DFT 30';
        carname[579]='Huntley';
        carname[580]='Stafford';
        carname[582]='News van';
        carname[583]='Tug';
        carname[584]='Petrol tanker';
        carname[585]='Emperor';
        carname[587]='Euros';
        carname[588]='Hotdog';
        carname[589]='Club';
        carname[590]='Freight box';
        carname[591]='Artic trailer 3';
        carname[596]='Cop car LS';
        carname[597]='Cop car SF';
        carname[598]='Cop car LV';
        carname[599]='Ranger';
        carname[600]='Picador';
        carname[601]='Swat tank';
        carname[602]='Alpha';
        carname[603]='Phoenix';
        carname[604]='Glendale';
        carname[605]='Sadler';
        carname[606]='Bag box A';
        carname[607]='Bag box B';
        carname[608]='Stairs';
        carname[609]='Boxville';
        carname[610]='Farm trailer';
        carname[611]='Utility van trailer';
        return carname;
    };

    var getBoatsArray = function()
    {
        var boatname = [];
        boatname[430]='Predator';
        boatname[446]='Squalo';
        boatname[452]='Speeder';
        boatname[453]='Reefer';
        boatname[454]='Tropic';
        boatname[472]='Coastgaurd';
        boatname[473]='Dinghy';
        boatname[484]='Marquis';
        boatname[493]='Jetmax';
        boatname[595]='Launch';

        return boatname;
    };

    var getRcArray = function()
    {
        var rcname = [];

        rcname[441]='RC Bandit';
        rcname[464]='RC Baron';
        rcname[465]='RC Raider';
        rcname[501]='RC Goblin';
        rcname[564]='RC Tiger';
        rcname[594]='RC Cam';

        return rcname;
    };

    var getHelisArray = function()
    {
        var heliname = [];

        heliname[417]='Levetian';
        heliname[425]='Hunter';
        heliname[447]='Seasparrow';
        heliname[469]='Sparrow';
        heliname[487]='Maverick';
        heliname[488]='VCN Maverick';
        heliname[497]='Police maverick';
        heliname[548]='Cargobob';
        heliname[563]='Raindance';

        return heliname;
    };

    var getBikesArray = function()
    {
        var bikename = [];

        bikename[448]='Pizza boy';
        bikename[461]='PCJ 600';
        bikename[462]='Faggio';
        bikename[463]='Freeway';
        bikename[468]='Sanchez';
        bikename[471]='Quad';
        bikename[481]='BMX';
        bikename[509]='Bike';
        bikename[510]='Mountain bike';
        bikename[521]='FCR 900';
        bikename[522]='NRG 500';
        bikename[523]='HPV 1000';
        bikename[581]='BF 400';
        bikename[586]='Wayfarer';

        return bikename;
    };

    var getPlanesArray = function()
    {
        var planename = [];

        planename[460]='Skimmer';
        planename[476]='Rustler';
        planename[511]='Beagle';
        planename[512]='Cropduster';
        planename[513]='Stuntplane';
        planename[519]='Shamal';
        planename[520]='Hydra';
        planename[553]='Nevada';
        planename[577]='AT 400';
        planename[592]='Andromada';
        planename[593]='Dodo';

        return planename;
    };

    var addVehicle = function(playerId)
    {
        var carname = getCarsArray();
        var bikename = getBikesArray();
        var planename = getPlanesArray();
        var heliname = getHelisArray();
        var boatname = getBoatsArray();
        var rcname = getRcArray();

        bootbox.dialog({
                title: "Choose vehicle category",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" />Vehicle category: &nbsp;</td>' +
                                '<td>' +
                                    '<select id="carCategory" name="carCategory"> ' +
                                        '<option value="1">Cars</option>' +
                                        '<option value="2">Bikes</option>' +
                                        '<option value="3">Planes</option>' +
                                        '<option value="4">Helicopters</option>' +
                                        '<option value="5">Boats</option>' +
                                        '<option value="6">RC Cars</option>' +
                                    '</select>' +
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var carCategory = $('#carCategory').val();
                            var playerId = $('#playerId').val();
                            if(carCategory < 0 || carCategory > 6) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                var vehicles = "";
                                if(carCategory == 1) {
                                    for(var i in carname) {
                                        vehicles += '<option value="'+i+'">'+i+' - '+carname[i]+'</option>'
                                    }
                                }
                                else if(carCategory == 2) {
                                    for(var i in bikename) {
                                        vehicles += '<option value="'+i+'">'+i+' - '+bikename[i]+'</option>'
                                    }
                                }
                                else if(carCategory == 3) {
                                    for(var i in planename) {
                                        vehicles += '<option value="'+i+'">'+i+' - '+planename[i]+'</option>'
                                    }
                                }
                                else if(carCategory == 4) {
                                    for(var i in heliname) {
                                        vehicles += '<option value="'+i+'">'+i+' - '+heliname[i]+'</option>'
                                    }
                                }
                                else if(carCategory == 5) {
                                    for(var i in boatname) {
                                        vehicles += '<option value="'+i+'">'+i+' - '+boatname[i]+'</option>'
                                    }
                                }
                                else if(carCategory == 6) {
                                    for(var i in rcname) {
                                        vehicles += '<option value="'+i+'">'+i+' - '+rcname[i]+'</option>'
                                    }
                                }
                                bootbox.dialog({
                                        title: "Choose vehicle",
                                        message:
                                        '<div>' +
                                            '<form>' +
                                                '<table class="sanctionTable">'+
                                                    '<tr>' +
                                                        '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" />Vehicle:&nbsp;</td>' +
                                                        '<td>' +
                                                            '<select id="carId" name="carId"> ' +
                                                                vehicles +
                                                            '</select>' +
                                                        '</td>' +
                                                    '</tr>' +
                                                '</table>' +
                                            '</form>'+
                                        '</div>',
                                        buttons: {
                                            success: {
                                                label: "Continue",
                                                className: "btn-success",
                                                callback: function () {
                                                    var playerId = $('#playerId').val();
                                                    var carId = $("#carId").val();
                                                    bootbox.dialog({
                                                            title: "Vehicle options",
                                                            message:
                                                            '<div>' +
                                                                '<form>' +
                                                                    '<table class="sanctionTable">'+
                                                                        '<tr>' +
                                                                            '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" />' +
                                                                            '<input type="hidden" name="carId" id="carId" value="'+carId+'" />Vehicle price:&nbsp;</td>' +
                                                                            '<td>' +
                                                                                '<input type="text" name="price" id="price" />'+
                                                                            '</td>' +
                                                                        '</tr>' +
                                                                        '<tr>' +
                                                                            '<td>Vehicle type:&nbsp;</td>' +
                                                                            '<td>' +
                                                                                '<select id="type" name="type"> ' +
                                                                                    '<option value="0">Normal</option>' +
                                                                                    '<option value="1">Shop</option>' +
                                                                                    '<option value="2">Tutorial</option>' +
                                                                                '</select>' +
                                                                            '</td>' +
                                                                        '</tr>' +
                                                                    '</table>' +
                                                                '</form>'+
                                                            '</div>',
                                                            buttons: {
                                                                success: {
                                                                    label: "Add vehicle",
                                                                    className: "btn-success",
                                                                    callback: function () {
                                                                        var price = $('#price').val();
                                                                        var type = $('#type').val();
                                                                        var carId = $('#carId').val();
                                                                        var playerId = $('#playerId').val();
                                                                        if(carCategory < 0 || carCategory > 6) {
                                                                            bootbox.alert('Error! Invalid fields!');
                                                                        }
                                                                        else {
                                                                            if (!price.match('^[0-9][0-9]{0,8}$')) {
                                                                                bootbox.alert('Error! Invalid fields!');
                                                                            }
                                                                            else {
                                                                                if(price > 10000000 || price < 0) {
                                                                                    bootbox.alert('Error! Invalid fields!');
                                                                                }
                                                                                else {
                                                                                    sendAddVehicle(playerId, carId, price, type);
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    );
                                                }
                                            }
                                        }
                                    }
                                );
                            }
                        }
                    }
                }
            }
        );
    };

    var sendAddVehicle = function(playerId, carId, price, type)
    {
        //bootbox.alert('Na ma: ID: '+playerId+' Car: '+carId+' Price: '+price+' Type: '+type);
        $.ajax({
            type: "POST",
            url: "/players/addVehicle",
            data: {playerId: playerId, carId: carId, price: price, type: type},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#clanRenewButton").click(function()
    {
        var id = $(this).data("id");
        clanRenew1(id);
    });

    var clanRenew1 = function(id)
    {
        bootbox.prompt("How many slots?", function(slots) {
            if (slots === null) {
                return;
            } else {
                //TODO verificare a slotului ajax
                if(slots % 1 != 0 || slots < 1)
                {
                    bootbox.alert('That is not a valid slots number', function()
                    {
                        clanRenew1(id);
                    });
                    return;
                }
                clanRenew2(id, slots);
            }
        });
    };

    var clanRenew2 = function(id, slots)
    {
        bootbox.prompt("How many days?", function(days) {
            if (days === null) {
                return;
            } else {
                //TODO verificare a slotului ajax
                if(days % 1 != 0 || days < 1)
                {
                    bootbox.alert('That is not a valid days number', function()
                    {
                        clanRenew2(id, slots);
                    });
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "/clans/renew",
                    data: {id : id, slots : slots, days: days},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    $("#changeEmail").click(function()
    {
        changeEmailPassword();
    });

    var changeEmailPassword = function()
    {
        bootbox.promptPassword("Enter your current password", function(password) {
            if (password === null) {
                return;
            } else {
                //TODO verificare a parolei ajax
                changeEmailEmail1(password);
            }
        });
    };

    var changeEmailEmail1 = function(password)
    {
        bootbox.prompt("Enter your new email", function(email1) {
            if (email1 === null) {
                return;
            } else {
                if(!isValidEmailAddress(email1))
                {
                    bootbox.alert('That is not a valid email address', function()
                    {
                        changeEmailEmail1(password);
                    });
                    return;
                }
                changeEmailEmail2(password, email1);
            }
        });
    };

    var changeEmailEmail2 = function(password, email1)
    {
        bootbox.prompt("Re-enter your new email", function(email2) {
            if (email2 === null) {
                return;
            } else {
                if(!isValidEmailAddress(email2))
                {
                    bootbox.alert('That is not a valid email address', function()
                    {
                        changeEmailEmail2(password, email1);
                    });
                    return;
                }
                else if(email1 != email2)
                {
                    bootbox.alert('Entered emails don\'t match', function()
                    {
                        changeEmailEmail2(password, email1);
                    });
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "/account/changeemail",
                    data: {email : email1, parola : password},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    $("#answerUnbanRequest").click(function()
    {
        var requestId = $("#hiddenRequestId").text();
        var requestType = $("#hiddenRequestType").text();
        setUnbanRequestAnswer(requestId, requestType);
    });

    var setUnbanRequestAnswer = function(requestId, requestType)
    {
        var options = "";
        if(requestType == 1) {
            options = '<option value="0">None</option>' +
                            '<option value="1">Unban Account</option>' +
                            '<option value="2">Unban Account + IP</option>' +
                            '<option value="3">Unban IP</option>' +
                            '<option value="4">Alter ban</option>';
        }
        else if(requestType == 2) {
            options = '<option value="0">None</option>' +
                            '<option value="3">Unban IP</option>';
        }
        bootbox.dialog({
            title: "Unban Request Board",
            message:
            '<div>' +
                '<form>' +
                    '<table class="sanctionTable">' +
                        '<tr>' +
                            '<td>' +
                                '<input type="hidden" name="requestId" id="requestId" value="'+requestId+'" />' +
                                '<input type="hidden" name="requestType" id="requestType" value="'+requestType+'" />Action: &nbsp;' +
                            '</td>' +
                            '<td>' +
                                '<select id="action" name="action"> ' +
                                    options +
                                '</select>' +
                            '</td>' +
                        '</tr>' +
                        '<tr>' +
                            '<td>Answer: &nbsp;</td>' +
                            '<td><textarea name="answer" id="answer" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;" /></textarea></td>' +
                        '</tr>' +
                    '</table>' +
                '</form>'+
            '</div>',
            buttons: {
                success: {
                    label: "Continue",
                    className: "btn-success",
                    callback: function () {
                        var requestId = $('#requestId').val();
                        var requestType = $('#requestType').val();
                        var answer = $("#answer").val();
                        var action = $("#action").val();
                        if(answer.length < 2 || answer.length > 200) {
                            bootbox.alert('Error! Invalid fields!');
                        }
                        else if(action == 4) {
                            bootbox.dialog({
                                    title: "Unban Request Board",
                                    message:
                                    '<div>' +
                                        '<form>' +
                                            '<table class="sanctionTable">'+
                                                '<tr>' +
                                                    '<td>New amount:&nbsp;</td>' +
                                                    '<td><input type="text" name="amount" id="amount" autofocus style="height:30px;" /> days</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                    '<td>New reason:&nbsp;</td>' +
                                                    '<td><input type="text" name="reason" id="reason" autofocus style="height:30px;" /></td>' +
                                                '</tr>' +
                                            '</table>' +
                                        '</form>'+
                                    '</div>',
                                    buttons: {
                                        success: {
                                            label: "Continue",
                                            className: "btn-success",
                                            callback: function () {
                                                var amount = $('#amount').val();
                                                var reason = $('#reason').val();
                                                if(amount < 0 || amount > 30)
                                                    bootbox.alert('Error! Invalid fields!');
                                                else
                                                    sendUnbanRequestAnswer(requestId, requestType, answer, action, amount, reason);
                                            }
                                        }
                                    }
                                }
                            );
                        }
                        else
                            sendUnbanRequestAnswer(requestId, requestType, answer, action);
                    }
                }
            }
        });
    };

    var sendUnbanRequestAnswer = function(requestId, requestType, answer, action, amount = null, reason = null) {
        $.ajax({
            type: "POST",
            url: "/player/unbanRequestAnswer",
            data: {requestId : requestId, requestType : requestType, answer : answer, action : action, amount : amount, reason : reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { document.location.href = "/admin/pendingUnbanRequests" });
            }
        });
    };

    $("#applyPunishment").click(function()
    {
        var reportId = $("#hiddenReportId").text();
        var reportReason = $("#hiddenReportReason").text();
        setPunishment(reportId,reportReason);
    });

    var setPunishment = function(reportId, reportReason)
    {
        bootbox.dialog({
                title: "Punishment Board",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td><input type="hidden" name="reportId" id="reportId" value="'+reportId+'" />Sanction: &nbsp;</td>' +
                                '<td>' +
                                    '<select id="sanction" name="sanction" autofocus> ' +
                                        '<option value="0">None</option>' +
                                        '<option value="1">Mute</option>' +
                                        '<option value="2">Suspend</option>' +
                                        '<option value="3">Ajail</option>' +
                                        '<option value="4">Warn</option>' +
                                        '<option value="5">Ban</option>' +
                                        '<option value="6">Ban (IP)</option>' +
                                        '<option value="7">Event Black List</option>' +
                                    '</select>' +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Answer: &nbsp;</td>' +
                                '<td><textarea name="answer" id="answer" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;" /></textarea></td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var sanction = $('#sanction').val();
                            var answer = $("#answer").val();
                            if((sanction < 0 || sanction > 7) || (answer.length < 2 || answer.length > 200)) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else if(sanction == 5 || sanction == 6) {
                                var cheattype = "";
                                if(reportReason == "Cheats")
                                    cheattype =     '<tr>' +
                                                        '<td>Cheat type: &nbsp;</td>' +
                                                        '<td>' +
                                                            '<select id="cheattype" name="cheattype" autofocus> ' +
                                                                '<option value="Aim/Norecoil">Aim/Norecoil</option>' +
                                                                '<option value="Rapidfire">Rapidfire</option>' +
                                                                '<option value="Wallhack">Wallhack</option>' +
                                                                '<option value="Teleport">Teleport</option>' +
                                                                '<option value="Weapons">Weapons</option>' +
                                                                '<option value="Vehicles">Vehicles</option>' +
                                                                '<option value="Troll">Troll</option>' +
                                                                '<option value="S0beit">S0beit</option>' +
                                                                '<option value="Camhack">Camhack</option>' +
                                                                '<option value="Other">Other</option>' +
                                                            '</select>' +
                                                        '</td>' +
                                                    '</tr>';
                                bootbox.dialog({
                                        title: "Punishment Options",
                                        message:
                                        '<div>' +
                                            '<form>' +
                                                '<table class="sanctionTable">'+
                                                    '<tr>' +
                                                        '<td>Duration:&nbsp;</td>' +
                                                        '<td><input type="text" name="duration" id="duration" autofocus style="height:30px;" /> days</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                        '<td>No unban:&nbsp;</td>' +
                                                        '<td>' +
                                                            '<select id="nounban" name="nounban"> ' +
                                                                '<option value="0" selected>No</option>' +
                                                                '<option value="1">Yes</option>' +
                                                            '</select>' +
                                                        '</td>' +
                                                    '</tr>' +
                                                    cheattype +
                                                '</table>' +
                                            '</form>'+
                                        '</div>',
                                        buttons: {
                                            success: {
                                                label: "Apply",
                                                className: "btn-success",
                                                callback: function () {
                                                    var duration = $('#duration').val();
                                                    var nounban = $("#nounban").val();
                                                    var type = $("#cheattype").val();
                                                    if(reportReason == "Cheats")
                                                        reportReason = "Cheats (" + type + ")";
                                                    if(nounban == 1)
                                                        reportReason = reportReason + " (No Unban)";
                                                    if(!duration.match('^[1-9][0-9]?$') && duration != 0) {
                                                        bootbox.alert('Error! Invalid fields!');
                                                    }
                                                    else {
                                                        if(duration > 30 || duration < 0) {
                                                            bootbox.alert('Error! Invalid fields!');
                                                        }
                                                        else {
                                                            sendSanction(reportId, reportReason, sanction, answer, duration);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                );
                            }
                            else if(sanction == 2 || sanction == 4) {
                                sendSanction(reportId, reportReason, sanction, answer, 0);
                            }
                            else if(sanction == 1 || sanction == 3) {
                                bootbox.dialog({
                                        title: "Punishment Options",
                                        message:
                                        '<div>' +
                                            '<form>' +
                                                '<table class="sanctionTable">'+
                                                    '<tr>' +
                                                        '<td>Duration:&nbsp;</td>' +
                                                        '<td><input type="text" name="duration" id="duration" autofocus style="height:30px;" /> minutes</td>' +
                                                    '</tr>' +
                                                '</table>' +
                                            '</form>'+
                                        '</div>',
                                        buttons: {
                                            success: {
                                                label: "Apply",
                                                className: "btn-success",
                                                callback: function () {
                                                    var duration = $('#duration').val();
                                                    if(!duration.match('^[1-9][0-9]{1,2}$')) {
                                                        bootbox.alert('Error! Invalid fields!');
                                                    }
                                                    else {
                                                        if(duration > 500 || duration < 0) {
                                                            bootbox.alert('Error! Invalid fields!');
                                                        }
                                                        else {
                                                            sendSanction(reportId, reportReason, sanction, answer, duration);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                );
                            }
                            else if(sanction == 7) {
                                bootbox.dialog({
                                        title: "Punishment Options",
                                        message:
                                        '<div>' +
                                            '<form>' +
                                                '<table class="sanctionTable">'+
                                                    '<tr>' +
                                                        '<td>Duration:&nbsp;</td>' +
                                                        '<td><input type="text" name="duration" id="duration" autofocus style="height:30px;" /> days</td>' +
                                                    '</tr>' +
                                                '</table>' +
                                            '</form>'+
                                        '</div>',
                                        buttons: {
                                            success: {
                                                label: "Apply",
                                                className: "btn-success",
                                                callback: function () {
                                                    var duration = $('#duration').val();
                                                    if(!duration.match('^[1-9]{1}[0-9]{0,2}$$')) {
                                                        bootbox.alert('Error! Invalid fields!');
                                                    }
                                                    else {
                                                        if(duration > 500 || duration < 0) {
                                                            bootbox.alert('Error! Invalid fields!');
                                                        }
                                                        else {
                                                            sendSanction(reportId, reportReason, sanction, answer, duration);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                );
                            }
                            else sendSanction(reportId, reportReason, sanction, answer, 0);
                        }
                    }
                }
            }
        );
    };

    var sendSanction = function(reportId, reportReason, sanction, answer, duration) {
        $.ajax({
            type: "POST",
            url: "/player/applysanction",
            data: {reportId : reportId, reportReason : reportReason, sanction : sanction, answer : answer, duration : duration},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else if(data[0]['message'] == 'This player was already banned permanently.')  bootbox.alert(data[0]['message'], function() { document.location.href = "/players/report/"+reportId });
                else bootbox.alert(data[0]['message'], function() { document.location.href = "/admin/pendingReports" });
            }
        });
    };

    $("#applyFactionPunishment").click(function()
    {
        var reportId = $("#hiddenReportId").text();
        var candidate = $(this).data("player-candidate");
        setFactionPunishment(reportId, candidate);
    });

    var setFactionPunishment = function(reportId, candidate)
    {
        var failTestOption = '', options = '';
        if(candidate == 0) {
            options = '<select id="sanction" name="sanction" autofocus> ' +
                    '<option value="0">None</option>' +
                    '<option value="6">Fail test</option>' +
                '</select>';
        }
        else
            options = '<select id="sanction" name="sanction" autofocus> ' +
                '<option value="0">None</option>' +
                '<option value="1">Verbal Warning</option>' +
                '<option value="2">Faction Warn</option>' +
                '<option value="3">Rank down</option>' +
                '<option value="4">Uninvite without FP</option>' +
                '<option value="5">Uninvite with 60 FP</option>' +
                '<option value="7">Uninvite with 10 FP (3 FWs)</option>' +
            '</select>';

        bootbox.dialog({
                title: "Punishment Board",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td><input type="hidden" name="reportId" id="reportId" value="'+reportId+'" />Sanction: &nbsp;</td>' +
                                '<td>' +
                                    options +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Report answer: &nbsp;</td>' +
                                '<td><textarea name="answer" id="answer" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;" /></textarea></td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var reportId = $('#reportId').val();
                            var sanction = $('#sanction').val();
                            var answer = $("#answer").val();
                            if((sanction < 0 || sanction > 7) || (answer.length < 2 || answer.length > 200)) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(sanction >= 2) {
                                    bootbox.dialog({
                                            title: "Punishment Options",
                                            message: '<div>' +
                                            '<form>' +
                                            '<table class="sanctionTable">' +
                                            '<tr>' +
                                            '<td>Sanction reason: &nbsp;</td>' +
                                            '<td><input type="text" name="reason" id="reason" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;" /></td>' +
                                            '</tr>' +
                                            '</table>' +
                                            '</form>' +
                                            '</div>',
                                            buttons: {
                                                success: {
                                                    label: "Apply",
                                                    className: "btn-success",
                                                    callback: function () {
                                                        var reason = $('#reason').val();
                                                        if (reason.length < 2 || reason.length > 32) {
                                                            bootbox.alert('Error! Invalid fields!');
                                                        }
                                                        else {
                                                            sendFactionSanction(reportId, sanction, answer, reason);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    );
                                }
                                else {
                                    sendFactionSanction(reportId, sanction, answer, "null");
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendFactionSanction = function(reportId, sanction, answer, reason) {
        $.ajax({
            type: "POST",
            url: "/factions/applySanction",
            data: {reportId : reportId, sanction : sanction, answer : answer, reason : reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { document.location.href = "/leader/pendingReports"});
            }
        });
    };

    $("#resetPlayerPassword").click(function()
    {
        var playerId = $("#resetPlayerPassword").data("player-id");
        var playerName = $("#resetPlayerPassword").data("player-name");
        resetPlayerPassword(playerId, playerName);
    });

    var resetPlayerPassword = function(playerId, playerName)
    {
        bootbox.confirm('Are you sure you want to reset '+ playerName +'\'s password? A random password will be automatically generated.', function(confirm) {
            if(confirm)
                sendResetPlayerPassword(playerId);
            else return;
        });
    };

    var sendResetPlayerPassword = function(playerId)
    {
        $.ajax({
            type: "POST",
            url: "/player/resetPlayerPassword",
            data: {id: playerId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#setEmail").click(function()
    {
        var playerName = $("#setEmail").data("player-name");
        setEmail(playerName);
    });

    var setEmail = function(playerName)
    {
        bootbox.prompt("Enter a new email address", function(newEmail) {
            if (newEmail === null) {
                return;
            } else {
                if(!isValidEmailAddress(newEmail))
                {
                    bootbox.alert('That is not a valid email address', function()
                    {
                        setEmail();
                    });
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "/player/setEmail",
                    data: {player: playerName, email: newEmail},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };
	
	$("#recoverPIN").click(function()
    {
        sendMail();
    });

	var sendMail = function() {
		$.ajax({
            type: "POST",
            url: "/account/recoverpin"
        });
		bootbox.alert("Your PIN was sent to your email address. <br/> Please check your SPAM folder also.");
	};

    $("#banPlayer").click(function()
    {
        var playerId = $("#banPlayer").data("player-id");
        banPlayer(playerId);
    });

    var banPlayer = function(playerId)
    {
        bootbox.dialog({
                title: "Ban options",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" />Duration: &nbsp;</td>' +
                                '<td><input type="text" name="duration" id="duration" autofocus style="height:30px;" /> days</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Reason: &nbsp;</td>' +
                                '<td><input type="text" name="reason" id="reason" style="height:30px;" /></td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>No unban:&nbsp;</td>' +
                                '<td>' +
                                    '<select id="nounban" name="nounban"> ' +
                                        '<option value="0" selected>No</option>' +
                                        '<option value="1">Yes</option>' +
                                    '</select>' +
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Ban",
                        className: "btn-danger",
                        callback: function () {
                            var duration = $('#duration').val();
                            var nounban = $("#nounban").val();
                            var reason = $("#reason").val();
                            if(!duration.match('^[1-9][0-9]?$') && duration != 0) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(duration > 30 || duration < 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    if(nounban == 1)
                                        reason = reason + " (No Unban)";
                                    sendBanPlayer(playerId, duration, reason);
                                }
                            }

                        }
                    }
                }
            }
        );
    };

    var sendBanPlayer = function(playerId, duration, reason)
    {
        $.ajax({
            type: "POST",
            url: "/player/banPlayer",
            data: {id: playerId, duration: duration, reason: reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#warnPlayer").click(function()
    {
        var playerId = $("#warnPlayer").data("player-id");
        warnPlayer(playerId);
    });

    var warnPlayer = function(playerId)
    {
        bootbox.dialog({
                title: "Warn options",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                        '<tr>' +
                            '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" />Reason: &nbsp;</td>' +
                            '<td><input type="text" name="reason" id="reason" style="height:30px;" /></td>' +
                        '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Warn",
                        className: "btn-danger",
                        callback: function () {
                            var reason = $("#reason").val();
                            sendWarnPlayer(playerId, reason);
                        }
                    }
                }
            }
        );
    };

    var sendWarnPlayer = function(playerId, reason)
    {
        $.ajax({
            type: "POST",
            url: "/player/warnPlayer",
            data: {id: playerId, reason: reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#jailPlayer").click(function()
    {
        var playerId = $("#jailPlayer").data("player-id");
        jailPlayer(playerId);
    });

    var jailPlayer = function(playerId)
    {
        bootbox.dialog({
                title: "Jail options",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                        '<tr>' +
                            '<td>Duration:&nbsp;</td>' +
                            '<td><input type="text" name="duration" id="duration" autofocus style="height:30px;" /> minutes</td>' +
                        '</tr>' +
                        '<tr>' +
                            '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" />Reason: &nbsp;</td>' +
                            '<td><input type="text" name="reason" id="reason" style="height:30px;" /></td>' +
                        '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Jail",
                        className: "btn-danger",
                        callback: function () {
                            var reason = $("#reason").val();
                            var duration = $("#duration").val();
                            if(!duration.match('^[1-9][0-9]{1,2}$')) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(duration > 500 || duration < 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendJailPlayer(playerId, duration, reason);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendJailPlayer = function(playerId, duration, reason)
    {
        $.ajax({
            type: "POST",
            url: "/player/jailPlayer",
            data: {id: playerId, duration: duration, reason: reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#mutePlayer").click(function()
    {
        var playerId = $("#mutePlayer").data("player-id");
        mutePlayer(playerId);
    });

    var mutePlayer = function(playerId)
    {
        bootbox.dialog({
                title: "Mute options",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>Duration:&nbsp;</td>' +
                                '<td><input type="text" name="duration" id="duration" autofocus style="height:30px;" /> minutes</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" />Reason: &nbsp;</td>' +
                                '<td><input type="text" name="reason" id="reason" style="height:30px;" /></td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Mute",
                        className: "btn-danger",
                        callback: function () {
                            var reason = $("#reason").val();
                            var duration = $("#duration").val();
                            if(!duration.match('^[1-9][0-9]{1,2}$')) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(duration > 500 || duration < 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendMutePlayer(playerId, duration, reason);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendMutePlayer = function(playerId, duration, reason)
    {
        $.ajax({
            type: "POST",
            url: "/player/mutePlayer",
            data: {id: playerId, duration: duration, reason: reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#searchPlayerNameOld").click(function()
    {
        var name = $("#oldPlayerName").val();
        $.ajax({
            type: "POST",
            url: "/account/searchOldName",
            data: {name: name},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message']);
            }
        });
    });

    $("#closeRecoveryTrue").click(function()
    {
        var requestId = $("#closeRecoveryTrue").data("request-id");
        $.ajax({
            type: "POST",
            url: "/admin/closeRecovery",
            data: {id: requestId, status: 1},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    });

    $("#closeRecoveryFalse").click(function()
    {
        var requestId = $("#closeRecoveryFalse").data("request-id");
        $.ajax({
            type: "POST",
            url: "/admin/closeRecovery",
            data: {id: requestId, status: 2},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    });

    $("#withdrawReport").click(function()
    {
        var reportId = $("#withdrawReport").data("report-id");
        bootbox.confirm('آیا شما از پس گرفتن شکایت خود مطمئن هستید؟', function(confirm) {
            if(confirm) {
                $.ajax({
                    type: "POST",
                    url: "/players/withdrawReport/",
                    data: {id: reportId},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
            else return;
        });
    });

    $("#withdrawFactionReport").click(function()
    {
        var reportId = $("#withdrawFactionReport").data("report-id");
        bootbox.confirm('Are you sure you want to withdraw this report?', function(confirm) {
            if(confirm) {
                $.ajax({
                    type: "POST",
                    url: "/factions/withdrawReport",
                    data: {id: reportId},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
            else return;
        });
    });

    $("#webSuspendPlayer").click(function()
    {
        var playerId = $("#webSuspendPlayer").data("player-id");
        webSuspendPlayer(playerId);
    });


    var webSuspendPlayer = function(playerId)
    {
        bootbox.dialog({
                title: "Web Suspend Player",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<td>Days:&nbsp;</td>' +
                '<td><input type="text" id="days" name="days" style="height:30px;" /></td>' +
                '</tr>' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td><input type="text" id="reason" name="reason" style="height:30px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var days = $("#days").val();
                            var reason = $("#reason").val();
                            if(reason.length < 1 || reason.length > 255) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(days < 1 || days > 999) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendWebSuspendPlayer(playerId, days, reason);
                                }
                            }
                        }
                    }
                }
            }
        );
    };


    var sendWebSuspendPlayer = function(playerId, days, reason)
    {
        $.ajax({
            type: "POST",
            url: "/player/webSuspendPlayer",
            data: {id: playerId, days: days, reason: reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteWebSuspend").click(function()
    {
        var logId = $(this).data("log-id");
        deleteWebSuspend(logId);
    });

    var deleteWebSuspend = function(logId)
    {
        bootbox.confirm('Are you sure you want to delete this log and the sanction?', function(confirm) {
            if(confirm)
                sendDeleteWebSuspend(logId);
            else return;
        });
    };

    var sendDeleteWebSuspend = function(logId)
    {
        $.ajax({
            type: "POST",
            url: "/player/deleteWebSuspend",
            data: {id: logId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#suspendPlayer").click(function()
    {
        var playerId = $("#suspendPlayer").data("player-id");
        suspendPlayer(playerId);
    });

    var suspendPlayer = function(playerId)
    {
        bootbox.confirm('Are you sure you want to suspend his license?', function(confirm) {
            if(confirm)
                sendSuspendPlayer(playerId);
            else return;
        });
    };

    var sendSuspendPlayer = function(playerId)
    {
        $.ajax({
            type: "POST",
            url: "/player/suspendPlayer",
            data: {id: playerId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteWarn").click(function()
    {
        var logId = $(this).data("log-id");
        deleteWarn(logId);
    });

    var deleteWarn = function(logId)
    {
        bootbox.confirm('Are you sure you want to delete this log?', function(confirm) {
            if(confirm)
                sendDeleteWarn(logId);
            else return;
        });
    };

    var sendDeleteWarn = function(logId)
    {
        $.ajax({
            type: "POST",
            url: "/player/deleteWarn",
            data: {id: logId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteSuspend").click(function()
    {
        var logId = $(this).data("log-id");
        deleteSuspend(logId);
    });

    var deleteSuspend = function(logId)
    {
        bootbox.confirm('Are you sure you want to delete this log?', function(confirm) {
            if(confirm)
                sendDeleteSuspend(logId);
            else return;
        });
    };

    var sendDeleteSuspend = function(logId)
    {
        $.ajax({
            type: "POST",
            url: "/player/deleteSuspend",
            data: {id: logId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteMute").click(function()
    {
        var logId = $(this).data("log-id");
        deleteMute(logId);
    });

    var deleteMute = function(logId)
    {
        bootbox.confirm('Are you sure you want to delete this log?', function(confirm) {
            if(confirm)
                sendDeleteMute(logId);
            else return;
        });
    };

    var sendDeleteMute = function(logId)
    {
        $.ajax({
            type: "POST",
            url: "/player/deleteMute",
            data: {id: logId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteJail").click(function()
    {
        var logId = $(this).data("log-id");
        deleteJail(logId);
    });

    var deleteJail = function(logId)
    {
        bootbox.confirm('Are you sure you want to delete this log?', function(confirm) {
            if(confirm)
                sendDeleteJail(logId);
            else return;
        });
    };

    var sendDeleteJail = function(logId)
    {
        $.ajax({
            type: "POST",
            url: "/player/deleteJail",
            data: {id: logId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteBan").click(function()
    {
        var logId = $(this).data("log-id");
        deleteBan(logId);
    });

    var deleteBan = function(logId)
    {
        bootbox.confirm('Are you sure you want to delete this log?', function(confirm) {
            if(confirm)
                sendDeleteBan(logId);
            else return;
        });
    };

    var sendDeleteBan = function(logId)
    {
        $.ajax({
            type: "POST",
            url: "/player/deleteBan",
            data: {id: logId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#unbanPlayer").click(function()
    {
        var playerId = $("#unbanPlayer").data("player-id");
        unbanPlayer(playerId);
    });

    var unbanPlayer = function(playerId)
    {
        bootbox.confirm('Are you sure you want to unban this account?', function(confirm) {
            if(confirm)
                sendUnbanPlayer(playerId);
            else return;
        });
    };

    var sendUnbanPlayer = function(playerId)
    {
        $.ajax({
            type: "POST",
            url: "/player/unbanAccount",
            data: {id: playerId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#deleteIpBan").click(function()
    {
        var ip = $("#deleteIpBan").data("ip");
        deleteIpBan(ip);
    });

    var deleteIpBan = function(ip)
    {
        bootbox.confirm('Are you sure you want to unban IP '+ip+'?', function(confirm) {
            if(confirm)
                sendDeleteIpBan(ip);
            else return;
        });
    };

    var sendDeleteIpBan = function(ip)
    {
        $.ajax({
            type: "POST",
            url: "/admin/deleteIpBan",
            data: {ip: ip},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".removeAuction").click(function()
    {
        var auctionId = $(this).data("auction-id");
        removeAuction(auctionId);
    });

    var removeAuction = function(auctionId)
    {
        bootbox.confirm('Are you sure you want to remove this auction?', function(confirm) {
            if(confirm)
                sendRemoveAuction(auctionId);
            else return;
        });
    };

    var sendRemoveAuction = function(auctionId)
    {
        $.ajax({
            type: "POST",
            url: "/economy/removeAuction",
            data: {id: auctionId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#addAuction").click(function()
    {
        addAuction();
    });

    var addAuction = function()
    {
        bootbox.dialog({
                title: "Add Auction",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>Property ID:&nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="propertyId" id="propertyId" style="height:30px;" />' +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Property Type:&nbsp;</td>' +
                                '<td>' +
                                    '<select name="propertyType" id="propertyType">' +
                                        '<option value="2">House</option>'+
                                        '<option value="1">Business</option>'+
                                    '</select>'+
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var propertyId = $("#propertyId").val();
                            var propertyType = $("#propertyType").val();
                            if(propertyType != 2 && propertyType != 1) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                sendAddAuction(propertyId, propertyType);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendAddAuction = function(propertyId, propertyType)
    {
        $.ajax({
            type: "POST",
            url: "/economy/addAuction",
            data: {propertyId: propertyId, propertyType: propertyType},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };


    $("#addClanModerator").click(function()
    {
        var members = $("#addClanModerator").data("members");
        addClanModerator(members);
    });

    var addClanModerator = function(members)
    {
        members = members.split("/");
        var nrM = members.length - 1; var membersArray = ""; var i;
        for(i = 0; i < nrM; i++) {
            membersArray += '<option value="' + members[i] + '">' + members[i] + '</option>';
        }
        bootbox.dialog({
                title: "Add Clan Moderator",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Choose member:&nbsp;</td>' +
                '<td>' +
                '<select id="member" name="member">' +
                membersArray +
                '</select>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    button: {
                        label: "No game account",
                        className: "btn-button",
                        callback: function () {
                            var member = "";
                            addClanModeratorForumAccount(false, member);
                        }
                    },
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var member = $("#member").val();
                            addClanModeratorForumAccount(true, member);
                        }
                    }
                }
            }
        );
    };

    var addClanModeratorForumAccount = function(gameAccount, member)
    {
        bootbox.dialog({
                title: "Add Clan Moderator",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Forum account:&nbsp;</td>' +
                '<td><input type="text" id="forumName" name="forumName" style="height:30px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var forumName = $("#forumName").val();
                            if(forumName.length < 2 || forumName.length > 30) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                sendAddClanModerator(forumName, member, gameAccount);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendAddClanModerator = function(forumName, member, gameAccount)
    {
        $.ajax({
            type: "POST",
            url: "/clans/addForumModerator",
            data: {forumName: forumName, member: member, gameAccount: gameAccount},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".removeForumModerator").click(function()
    {
        var memberId = $(this).data("forum-member");
        removeForumModerator(memberId);
    });

    var removeForumModerator = function(memberId)
    {
        bootbox.confirm('Are you sure you want to remove this clan forum moderator?', function(confirm) {
            if(confirm)
                sendRemoveForumModerator(memberId);
            else return;
        });
    };

    var sendRemoveForumModerator = function(memberId)
    {
        $.ajax({
            type: "POST",
            url: "/clans/removeForumModerator",
            data: {memberId: memberId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#removeForumSection").click(function()
    {
        var forumId = $("#removeForumSection").data("forum-id");
        removeForumSection(forumId);
    });

    var removeForumSection = function(forumId)
    {
        bootbox.confirm('Are you sure you want to remove your clan forum section?', function(confirm) {
            if(confirm)
                sendRemoveForumSection(forumId);
            else return;
        });
    };

    var sendRemoveForumSection = function(forumId)
    {
        $.ajax({
            type: "POST",
            url: "/clans/removeForumSection",
            data: {forumId: forumId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#createForumSection").click(function()
    {
        createForumSection();
    });

    var createForumSection = function()
    {
        bootbox.dialog({
                title: "Add Clan Moderator",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Forum account:&nbsp;</td>' +
                '<td><input type="text" id="forumName" name="forumName" style="height:30px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var forumName = $("#forumName").val();
                            if(forumName.length < 2 || forumName.length > 30) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                sendCreateForumSection(forumName);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendCreateForumSection = function(forumName)
    {
        $.ajax({
            type: "POST",
            url: "/clans/createForumSection",
            data: {forumName: forumName},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#deletePoll").click(function()
    {
        var pollId = $("#deletePoll").data("poll-id");
        deletePoll(pollId);
    });

    var deletePoll = function(pollId)
    {
        bootbox.confirm('Are you sure you want to delete this poll?', function(confirm) {
            if(confirm)
                sendDeletePoll(pollId);
            else return;
        });
    };

    var sendDeletePoll = function(pollId)
    {
        $.ajax({
            type: "POST",
            url: "/players/deletePoll",
            data: {pollId: pollId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location = "/players/polls" });
            }
        });
    };

    $("#addSkin").click(function()
    {
        var playerId = $("#addSkin").data("player-id");
        addSkin(playerId);
    });

    var addSkin = function(playerId)
    {
        bootbox.dialog({
                title: "Add Skin",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Skin ID:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="skinId" id="skinId" style="height:30px;" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var skinId = $("#skinId").val();
                            if(skinId > 311 || skinId < 0) {
                                bootbox.alert('Error! Invalid skin ID!');
                            }
                            else {
                                sendAddSkin(playerId, skinId);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendAddSkin = function(playerId, skinId)
    {
        $.ajax({
            type: "POST",
            url: "/players/addSkin",
            data: {playerId: playerId, skinId: skinId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteWar").click(function()
    {
        var warId = $(this).data("war-id");
        deleteWar(warId);
    });

    var deleteWar = function(warId)
    {
        bootbox.confirm('Are you sure you want to delete this war?', function(confirm) {
            if(confirm)
                sendDeleteWar(warId);
            else return;
        });
    };

    var sendDeleteWar = function(warId)
    {
        $.ajax({
            type: "POST",
            url: "/wars/deleteWar",
            data: {id: warId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#editAllianceDescription").click(function()
    {
        var id = $(this).data("alliance-id");
        var desc = $(this).data("description");
        editAllianceDescription(id, desc);
    });

    var editAllianceDescription = function(id, description)
    {
        bootbox.dialog({
                title: "Edit alliance description",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Description: &nbsp;</td>' +
                '<td>' +
                '<textarea name="desc" id="desc" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;">' + description + '</textarea>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var desc = $("#desc").val();
                            if (desc.length < 2 || desc.length > 1024) {
                                bootbox.alert('Error! Description too long or too short!');
                            }
                            else {
                                sendEditAllianceDescription(id, desc);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendEditAllianceDescription = function(id, desc)
    {
        $.ajax({
            type: "POST",
            url: "/clans/editAllianceDescription",
            data: {id: id, desc: desc},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#makeOffer").click(function()
    {
        var economyId = $(this).data("economy-id");
        var playerGoods = $(this).data("player-goods");
        var playerMoney = $(this).data("player-money");
        makeOffer(economyId, playerGoods, playerMoney);
    });

    var makeOffer = function(economyId, playerGoods, playerMoney)
    {
        var carname = getCarsArray();
        var goods = playerGoods.split("/");
        var nrG = playerGoods.length - 1; var goodsInput = ""; var i;
        for(i = 1; i < nrG; i+=2) {
            if($.inArray(goods[i+1], carname) != -1)
                goodsInput += '<input type="checkbox" name="playerGoods[]" class="playerGoods" style="margin-top:-2px;" value="' + goods[i] + '/1"/> Vehicle (Model: ' + goods[i+1] + ', ID ' + goods[i] + ')<br />';
            if(goods[i+1] == 2)
                goodsInput += '<input type="checkbox" name="playerGoods[]" class="playerGoods" style="margin-top:-2px;" value="' + goods[i] + '/' + goods[i+1] + '"/> House (ID ' + goods[i] +')<br />';
            if(goods[i+1] == 3)
                goodsInput += '<input type="checkbox" name="playerGoods[]" class="playerGoods" style="margin-top:-2px;" value="' + goods[i] + '/' + goods[i+1] + '"/> Business (ID ' + goods[i] +')<br />';
            if(goods[i+1] == 4)
                goodsInput += '<input type="checkbox" name="playerGoods[]" class="playerGoods" style="margin-top:-2px;" value="' + goods[i] + '/' + goods[i+1] + '"/> Clan (ID ' + goods[i] +')<br />';
        }
        var goodsTr = "", optionalText = "";
        if(goodsInput) {
            goodsTr = '<tr>' +
                '<td>Check goods (optional):<br />- MAX 6 items -</td>' +
                '<td>' +
                goodsInput +
                '</td>' +
                '</tr>';
            optionalText = " (optional)";
        }

        bootbox.dialog({
                title: "Make an offer",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>Offer money'+ optionalText +': &nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="money" id="money" style="height:30px; width:310px;" value="0" />' +
                                '</td>' +
                            '</tr>' +
                            goodsTr +
                            '<tr>' +
                                '<td>Comment (optional): &nbsp;</td>' +
                                '<td>' +
                                    '<textarea name="comment" id="comment" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;" /></textarea>' +
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Place offer",
                        className: "btn-success",
                        callback: function () {
                            var money = $("#money").val();
                            var comment = $("#comment").val();
                            if (isNaN(money) || money < 0 || money > playerMoney) {
                                bootbox.alert('Error! Invalid money value or you don\'t have that amount of money!');
                            }
                            else {
                                var checkboxes = $('.playerGoods');
                                var goodsArray = ""; var typesArray = ""; var nrC = checkboxes.length;
                                for(var i = 0; i < nrC; i++) {
                                    if(checkboxes[i].checked) {
                                        var partial = checkboxes[i].value.split("/");
                                        goodsArray += "/" + partial[0];
                                        typesArray += "/" + partial[1];
                                    }
                                }
                                sendMakeOffer(economyId, money, goodsArray, typesArray, comment);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendMakeOffer = function(economyId, money, goodsArray, typesArray, comment)
    {
        $.ajax({
            type: "POST",
            url: "/economy/makeOffer",
            data: {economyId: economyId, money: money, goodsArray: goodsArray, typesArray: typesArray, comment: comment},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".answerOffer").click(function()
    {
        var offerId = $(this).data("offer-id");
        var offerStatus = $(this).data("offer-status");
        answerOffer(offerId, offerStatus);
    });

    var answerOffer = function(offerId, offerStatus)
    {
        if(offerStatus) {
            bootbox.confirm('Are you sure you want to accept this offer? Your sale will be closed!', function(confirm) {
                if(confirm)
                    sendAnswerOffer(offerId, offerStatus);
                else return;
            });
        }
        else {
            bootbox.confirm('Are you sure you want to reject this offer?', function(confirm) {
                if(confirm)
                    sendAnswerOffer(offerId, offerStatus);
                else return;
            });
        }

    };

    var sendAnswerOffer = function(offerId, offerStatus)
    {
        $.ajax({
            type: "POST",
            url: "/economy/answerOffer",
            data: {offerId: offerId, offerStatus: offerStatus},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".placeForSale").click(function()
    {
        var propertyId = $(this).data("property-id");
        var propertyType = $(this).data("property-type");
        if(propertyType == 1 && $(this).data("for-sale"))
            bootbox.alert("Error: This vehicle can't be sold!", function() { location.reload(); });
        else
            placeForSale(propertyId, propertyType);
    });

    var placeForSale = function(propertyId, propertyType)
    {
        bootbox.dialog({
                title: "Place Property For Sale",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>Price: &nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="price" id="price" style="height:30px; width:310px;" />' +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Accept exchange: &nbsp;</td>' +
                                '<td>' +
                                    '<select id="exchange" name="exchange">' +
                                        '<option value="0">No</option>' +
                                        '<option value="1">Yes</option>' +
                                    '</select>' +
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var price = $("#price").val();
                            var exchange = $("#exchange").val();
                            if (isNaN(price) || price < 1 || price > 200000000) {
                                bootbox.alert('Error! Invalid price value!');
                            }
                            else {
                                if(exchange != 1 && exchange != 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendPlaceForSale(propertyId, propertyType, price, exchange);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendPlaceForSale = function(propertyId, propertyType, price, exchange)
    {
        $.ajax({
            type: "POST",
            url: "/account/propertyForSale",
            data: {forSale: 1, propertyId: propertyId, propertyType: propertyType, price: price, exchange: exchange},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".notForSale").click(function()
    {
        var propertyId = $(this).data("property-id");
        var propertyType = $(this).data("property-type");
        notForSale(propertyId, propertyType);
    });

    var notForSale = function(propertyId, propertyType)
    {
        var property = "";
        switch(propertyType) {
            case 1:
                property = "car";
                break;
            case 2:
                property = "house";
                break;
            case 3:
                property = "business";
                break;
            case 3:
                property = "clan";
                break;
        }
        bootbox.confirm('Are you sure you want to remove your '+ property +' from the sale list?', function(confirm) {
            if(confirm)
                sendNotForSale(propertyId, propertyType);
            else return;
        });
    };

    var sendNotForSale = function(propertyId, propertyType)
    {
        $.ajax({
            type: "POST",
            url: "/account/propertyForSale",
            data: {forSale: 0, propertyId: propertyId, propertyType: propertyType, price: 0, exchange: 0},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };



    $(".transferGood").click(function()
    {
        var propertyId = $(this).data("property-id");
        var propertyType = $(this).data("property-type");
        var sender = $(this).data("sender-id");
        transferGood(propertyId, propertyType, sender);
    });

    var transferGood = function(propertyId, propertyType, sender)
    {
        bootbox.dialog({
                title: "Transfer good",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>Transfer to: &nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="receiver" id="receiver" style="height:30px; width:310px;" />' +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Amount (optional): &nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="amount" id="amount" style="height:30px; width:310px;" />' +
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var receiver = $("#receiver").val();
                            var amount = $("#amount").val();
                            if (amount && propertyType == 0 && isNaN(amount)) {
                                bootbox.alert('Error! Invalid amount value!');
                            }
                            else {
                                var receiverId = -1;
                                $.when(
                                    $.ajax({
                                        type: "POST",
                                        url: "/players/ajaxGetAccountId",
                                        data: {name: receiver}
                                    })
                                ).then(function(data) {
                                    receiverId = data[0]['message'];
                                    console.log(receiverId);
                                    if(receiverId != -1) {
                                        bootbox.confirm('Are you sure you want to authorize the transfer to '+ receiver +'\'s ('+ receiverId +') account?', function(confirm) {
                                            if(confirm)
                                                sendTransferGood(propertyId, propertyType, receiverId, amount, sender);
                                            else bootbox.alert('Action canceled!');
                                        });
                                    }
                                    else {
                                        bootbox.alert('Error! Player not found! JS');
                                    }
                                });
                            }
                        }
                    }
                }
            }
        );
    };

    var sendTransferGood = function(propertyId, propertyType, receiver, amount, sender)
    {
        $.ajax({
            type: "POST",
            url: "/players/transferGood",
            data: {propertyId: propertyId, propertyType: propertyType, receiver: receiver, amount: amount, sender: sender},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#addAchievement").click(function()
    {
        var playerId = $(this).data("player-id");
        var ids = $(this).data("achievement-ids");
        var names = $(this).data("achievement-names");
        var categories = $(this).data("achievement-categories");
        addAchievement(playerId, ids, names, categories);
    });

    var addAchievement = function(playerId, ids, names, categories)
    {
        ids = ids.split("/"); var nrI = ids.length - 1;
        names = names.split("/"); var nrN = names.length - 1;
        categories = categories.split("/"); var nrC = categories.length - 1;
        var optionsC = ""; var optionsA = ""; var i;
        for(i = 1; i <= nrC; i++) {
            if(categories[i] != categories[i-1])
                optionsC += '<option>' + categories[i] + '</option>';
        }

        bootbox.dialog({
                title: "Add Achievement",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                        '<tr>' +
                            '<td>Category: &nbsp;</td>' +
                            '<td>' +
                                '<select id="category" name="category">' +
                                    optionsC +
                                '</select>' +
                            '</td>' +
                        '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var category = $("#category").val();
                            for(i = 1; i <= nrC; i++) {
                                if(categories[i] == category)
                                    optionsA += '<option value="' + ids[i] + '">' + names[i] + '</option>';
                            }

                            bootbox.dialog({
                                    title: "Add Achievement",
                                    message:
                                    '<div>' +
                                        '<form>' +
                                            '<table class="sanctionTable">' +
                                                '<tr>' +
                                                    '<td>Achievement: &nbsp;</td>' +
                                                    '<td>' +
                                                        '<select id="achievement" name="achievement">' +
                                                            optionsA +
                                                        '</select>' +
                                                    '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                    '<td>Highest / Times achieved: &nbsp;</td>' +
                                                    '<td><input type="text" name="highest" id="highest" style="height:30px; width:310px;" /></td>' +
                                                '</tr>' +
                                            '</table>' +
                                        '</form>'+
                                    '</div>',
                                    buttons: {
                                        success: {
                                            label: "Save",
                                            className: "btn-success",
                                            callback: function () {
                                                var achievementId = $("#achievement").val();
                                                var highest = $("#highest").val();
                                                if(highest < 0 || isNaN(highest)) {
                                                    bootbox.alert('Error! Invalid fields!');
                                                }
                                                else {
                                                    sendAddAchievement(playerId, achievementId, highest);
                                                }
                                            }
                                        }
                                    }
                                }
                            );
                        }
                    }
                }
            }
        );
    };

    var sendAddAchievement = function(playerId, achievementId, highest)
    {
        $.ajax({
            type: "POST",
            url: "/players/addAchievement",
            data: {playerId: playerId, achievementId: achievementId, highest: highest},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#unfollowFaction").click(function()
    {
        var factionId = $(this).data("faction-id");
        unfollowFaction(factionId);
    });

    var unfollowFaction = function(factionId)
    {
        bootbox.confirm('Are you sure you want to stop receiving notifications from this faction?', function(confirm) {
            if(confirm)
                sendUnfollowFaction(factionId);
            else return;
        });
    };

    var sendUnfollowFaction = function(factionId)
    {
        $.ajax({
            type: "POST",
            url: "/factions/unfollowFaction",
            data: {id: factionId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#followFaction").click(function()
    {
        var factionId = $(this).data("faction-id");
        followFaction(factionId);
    });

    var followFaction = function(factionId)
    {
        bootbox.confirm('Are you sure you want to receive notifications from this faction?', function(confirm) {
            if(confirm)
                sendFollowFaction(factionId);
            else return;
        });
    };

    var sendFollowFaction = function(factionId)
    {
        $.ajax({
            type: "POST",
            url: "/factions/followFaction",
            data: {id: factionId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#followClan").click(function()
    {
        var clanId = $(this).data("clan-id");
        followClan(clanId);
    });

    var followClan = function(clanId)
    {
        bootbox.confirm('Are you sure you want to receive notifications from this clan?', function(confirm) {
            if(confirm)
                sendFollowClan(clanId);
            else return;
        });
    };

    var sendFollowClan = function(clanId)
    {
        $.ajax({
            type: "POST",
            url: "/clans/followClan",
            data: {id: clanId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#unfollowClan").click(function()
    {
        var clanId = $(this).data("clan-id");
        unfollowClan(clanId);
    });

    var unfollowClan = function(clanId)
    {
        bootbox.confirm('Are you sure you want to stop receiving notifications from this clan?', function(confirm) {
            if(confirm)
                sendUnfollowClan(clanId);
            else return;
        });
    };

    var sendUnfollowClan = function(clanId)
    {
        $.ajax({
            type: "POST",
            url: "/clans/unfollowClan",
            data: {id: clanId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#editForumAccount").click(function()
    {
        var oldLink = $(this).data("old-link");
        bootbox.dialog({
                title: "Forum account options",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Old forum account: &nbsp;</td>' +
                '<td>'+oldLink+'</td>' +
                '</tr>' +
                '<tr>' +
                '<td>New forum account: &nbsp;</td>' +
                '<td><input type="text" name="link" id="link" style="height:30px; width:310px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var link = $('#link').val();
                            sendEditForumAccount(link);
                        }
                    }
                }
            }
        );
    });

    var sendEditForumAccount = function(link)
    {
        $.ajax({
            type: "POST",
            url: "/account/editForumAccount",
            data: {link: link},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#addGold").click(function()
    {
        var playerId = $("#addGold").data("player-id");
        addGold(playerId);
    });

    var addGold = function(playerId)
    {
        bootbox.dialog({
                title: "Add Gold",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>Gold amount:&nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="amount" id="amount" >' +
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var amount = $("#amount").val();
                            if (!amount.match('^-?[0-9][0-9]{0,8}$')) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(amount > 100000000) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendAddGold(playerId, amount);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendAddGold = function(playerId, amount)
    {
        $.ajax({
            type: "POST",
            url: "/players/addGold",
            data: {playerId: playerId, amount: amount},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#addAdminTitle").click(function()
    {
        var playerId = $("#addAdminTitle").data("player-id");
        addAdminTitle(playerId);
    });

    var addAdminTitle = function(playerId)
    {
        bootbox.dialog({
                title: "Add Admin Title",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>New title:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="role" id="role" >' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Color:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="color" id="color" >' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var role = $("#role").val();
                            var color = $("#color").val();
                            sendAddAdminTitle(playerId, role, color);
                        }
                    }
                }
            }
        );
    };

    var sendAddAdminTitle = function(playerId, role, color)
    {
        $.ajax({
            type: "POST",
            url: "/players/addAdminTitle",
            data: {playerId: playerId, role: role, color: color},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".removeAdminTitle").click(function()
    {
        var roleId = $(this).data("role-id");
        bootbox.confirm('Are you sure you want remove this title?', function(confirm) {
            if(confirm)
                sendRemoveAdminTitle(roleId);
            else return;
        });
    });

    var sendRemoveAdminTitle = function(roleId)
    {
        $.ajax({
            type: "POST",
            url: "/players/removeAdminTitle",
            data: {roleId: roleId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#addNote").click(function()
    {
        var playerId = $("#addNote").data("player-id");
        var playerName = $("#addNote").data("player-name");
        addNote(playerId, playerName);
    });

    var addNote = function(playerId, playerName)
    {
        bootbox.dialog({
                title: "Add a note on "+playerName+"'s profile",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Note title:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="title" id="title" >' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Sticky note:&nbsp;</td>' +
                '<td>' +
                '<select id="sticky" name="sticky">' +
                '<option value="0">No</option>' +
                '<option value="1">Yes</option>' +
                '</select>' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Note: &nbsp;</td>' +
                '<td>' +
                '<textarea name="note" id="note" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;" /></textarea>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var title = $("#title").val();
                            var note = $("#note").val();
                            var sticky = $("#sticky").val();
                            if (note.length < 2 || note.length > 1024) {
                                bootbox.alert('Error! Note too long or too short!');
                            }
                            else {
                                if (title.length < 2 || title.length > 64) {
                                    bootbox.alert('Error! Title too long or too short!');
                                }
                                else {
                                    sendAddNote(playerId, sticky, title, note);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendAddNote = function(playerId, sticky, title, note)
    {
        $.ajax({
            type: "POST",
            url: "/players/addNote",
            data: {playerId: playerId, sticky: sticky, title: title, note: note},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteNote").click(function()
    {
        var noteId = $(this).data("note-id");
        bootbox.confirm('Are you sure you want to delete this note?', function(confirm) {
            if(confirm)
                sendDeleteNote(noteId);
            else return;
        });
    });

    var sendDeleteNote = function(noteId)
    {
        $.ajax({
            type: "POST",
            url: "/players/deleteNote",
            data: {noteId: noteId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".editNote").click(function()
    {
        var noteId = $(this).data("note-id");
        var sticky = $(this).data("note-sticky");
        var title = $(this).data("note-title");
        var note = $(this).data("note-content");
        editNote(noteId, sticky, title, note);
    });

    var editNote = function(noteId, sticky, title, note)
    {
        var options = "";
        if(sticky) {
            options = '<option value="0">No</option>' +
                '<option value="1" selected>Yes</option>';
        }
        else {
            options = '<option value="0" selected>No</option>' +
                '<option value="1">Yes</option>';
        }
        bootbox.dialog({
                title: "Edit note",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Note title:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="title" id="title" value="'+title+'" />' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Sticky note:&nbsp;</td>' +
                '<td>' +
                '<select id="sticky" name="sticky">' +
                options +
                '</select>' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Note: &nbsp;</td>' +
                '<td>' +
                '<textarea name="note" id="note" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;">' + note + '</textarea>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var title = $("#title").val();
                            var note = $("#note").val();
                            var sticky = $("#sticky").val();
                            if (note.length < 2 || note.length > 1024) {
                                bootbox.alert('Error! Note too long or too short!');
                            }
                            else {
                                if (title.length < 2 || title.length > 64) {
                                    bootbox.alert('Error! Title too long or too short!');
                                }
                                else {
                                    sendEditNote(noteId, sticky, title, note);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendEditNote = function(noteId, sticky, title, note)
    {
        $.ajax({
            type: "POST",
            url: "/players/editNote",
            data: {noteId: noteId, sticky: sticky, title: title, note: note},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".viewNote").click(function()
    {
        var admin = $(this).data("note-admin");
        var sticky = $(this).data("note-sticky");
        var title = $(this).data("note-title");
        var note = $(this).data("note-content");
        var added = $(this).data("note-added");
        viewNote(admin, sticky, title, note, added);
    });

    var viewNote = function(admin, sticky, title, note, added)
    {
        if(sticky) {
            sticky = '<div style="float:left;"><i class="material-icons md-24" style="color:#e74015;">bookmark</i></div>&nbsp;';
        }
        else {
            sticky = '<div style="float:left;"><i class="material-icons md-24" style="color:#b8b8b8;">bookmark</i></div>&nbsp;';
        }
        bootbox.dialog({
                title: sticky + "View note",
                message:
                '<div>' +
                '<h4 style="text-align:center;">' + title + '</h4><hr /><br />' +
                '<div>' + note + '</div><hr />' +
                '<div style="float:right;">Added on <strong>' + added + '</strong> by <strong>' + admin + '</strong></div>' +
                '</div>',
                buttons: {
                    success: {
                        label: "Close",
                        className: "btn-danger",
                        callback: function () {
                            location.reload();
                        }
                    }
                }
            }
        );
    };

    $(".viewAdventProgram").click(function()
    {
        var program = $(this).data("program");
        var day = $(this).data("day");
        var sup = "th";
        if(day == 1)
            sup = "st";
        if(day == 2)
            sup = "nd";
        if(day == 3)
            sup = "rd";
        bootbox.dialog({
                title: "Advent Calendar",
                message:
                '<div>' +
                    '<h4 style="text-align:center;">December ' + day + '<sup>' + sup + '</sup></h4><hr /><br />' +
                    '<table class="adventProgramTable">' +
                        '<tr>' +
                            '<td>Hour</td>' +
                            '<td>Event</td>' +
                            '<td>Type</td>' +
                        '</tr>' +
                        program +
                    '</table><hr />' +
                    '<div>' +
                        '<strong>Side Note:</strong><br /><br />* For "Clear Warn" and "Clear FP" we will pick a winner that has Warnings or Faction Punish.<br />' +
                        '* The vehicles won in Advent Calendar will value $0 and cannot be sold to other players.<br />' +
                        '* In "Random Bronze Skin" we will randomly pick a skin that the player doesn\'t own. If the player owns all the skins he will receive the counter value of a Bronze skin($20.000).<br />' +
                        '* For "30 Days Clan Renewal" we will randomly pick a clan whose owner is online.<br />' +
                    '</div>' +
                '</div>',
                buttons: {
                    success: {
                        label: "Close",
                        className: "btn-danger",
                        callback: function () {
                            location.reload();
                        }
                    }
                }
            }
        );
    });

    $("#editRank").click(function()
    {
        var playerId = $("#editRank").data("player-id");
        editRank(playerId);
    });

    var editRank = function(playerId)
    {
        bootbox.dialog({
                title: "Rank options",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>New Rank value:&nbsp;</td>' +
                '<td><input type="text" name="value" id="value" autofocus style="height:30px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var value = $("#value").val();
                            if(!value.match('^[0-9]{1,3}$')) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(value > 6 || value < 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendEditRank(playerId, value);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendEditRank = function(playerId, value)
    {
        $.ajax({
            type: "POST",
            url: "/player/editRank",
            data: {id: playerId, value: value},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#editFaction").click(function()
    {
        var playerName = $("#editFaction").data("player-name");
        var playerId = $("#editFaction").data("player-id");
        editFaction(playerName, playerId);
    });

    var editFaction = function(playerName, playerId)
    {
        var options="", i;
        var factions = [
            "Civilian",
            "Paramedics",
            "News Reporters",
            "Tow Truck Company",
            "LS Taxi",
            "LV Taxi",
            "SF Taxi",
            "LS School Instructors",
            "LV School Instructors",
            "SF School Instructors",
            "Green Street Bloods",
            "Verdant Family",
            "Vietnamese Boys",
            "The Tsar Bratva",
            "Red Dragon Triad",
            "Southern Pimps",
            "Avispa Rifa",
            "69 Pier Mobs",
            "El Loco Cartel",
            "LSPD",
            "LVPD",
            "SFPD",
            "FBI",
            "National Guard",
            "Hitman Agency",
            "Mayor"
        ];
        var fids = [0,4,9,14,20,10,21,24,11,25,12,13,15,5,6,16,17,18,19,1,22,23,2,3,8,7];
        var reverse_fids = [0,19,22,23,1,13,14,25,24,2,5,8,10,11,3,12,15,16,17,18,4,6,20,21,7,9];
        for(i = 0; i <= 25; i++) {
            options += '<option value="'+fids[i]+'" data-id="'+i+'">'+factions[i]+'</option>';
        }
        bootbox.dialog({
                title: "Set Faction Member",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Set Faction:&nbsp;</td>' +
                '<td>' +
                '<select id="value" name="value">' +
                options +
                '</select>' +
                '</td>' +
                '<td><input type="hidden" name="playerName" id="playerName" value="'+playerName+'" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var value = $("#value").val();
                            var playerName = $("#playerName").val();
                            if(value > 25 || value < 0) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(value == 0) {
                                    bootbox.confirm('Are you sure you want to kick '+playerName+' out of his faction?', function(confirm) {
                                        if(confirm)
                                            sendEditFaction(playerId, value);
                                        else return;
                                    });
                                }
                                else {
                                    bootbox.confirm('Are you sure you want to set '+playerName+'\' faction to ' + factions[reverse_fids[value]] + '?', function(confirm) {
                                        if(confirm)
                                            sendEditFaction(playerId, value);
                                        else return;
                                    });
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendEditFaction = function(playerId, value)
    {
        $.ajax({
            type: "POST",
            url: "/player/editFaction",
            data: {id: playerId, value: value},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#editFW").click(function()
    {
        var playerId = $("#editFW").data("player-id");
        editFW(playerId);
    });

    var editFW = function(playerId)
    {
        bootbox.dialog({
                title: "Faction Warns options",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>New Faction Warns value:&nbsp;</td>' +
                '<td><input type="text" name="value" id="value" autofocus style="height:30px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var value = $("#value").val();
                            if(!value.match('^[0-9]{1,3}$')) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(value > 2 || value < 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendEditFW(playerId, value);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendEditFW = function(playerId, value)
    {
        $.ajax({
            type: "POST",
            url: "/player/editfw",
            data: {id: playerId, value: value},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#editFP").click(function()
    {
        var playerId = $("#editFP").data("player-id");
        editFP(playerId);
    });

    var editFP = function(playerId)
    {
        bootbox.dialog({
                title: "Faction Punish options",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>New Faction Punish value:&nbsp;</td>' +
                '<td><input type="text" name="value" id="value" autofocus style="height:30px;" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var value = $("#value").val();
                            if(!value.match('^[0-9]{1,3}$')) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(value > 300 || value < 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendEditFP(playerId, value);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendEditFP = function(playerId, value)
    {
        $.ajax({
            type: "POST",
            url: "/player/editfp",
            data: {id: playerId, value: value},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#makeAdmin").click(function()
    {
        var playerId = $("#makeAdmin").data("player-id");
        makeAdmin(playerId);
    });

    var makeAdmin = function(playerId)
    {
        bootbox.dialog({
                title: "Set Admin Level",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Set Admin Level:&nbsp;</td>' +
                '<td><input type="text" name="value" id="value" autofocus style="height:30px;" /></td>' +
                '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var value = $("#value").val();
                            if(!value.match('^[0-9]{1}$')) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(value > 6 || value < 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendMakeAdmin(playerId, value);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendMakeAdmin = function(playerId, value)
    {
        $.ajax({
            type: "POST",
            url: "/player/makeAdmin",
            data: {id: playerId, value: value},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#makeHelper").click(function()
    {
        var playerId = $("#makeHelper").data("player-id");
        makeHelper(playerId);
    });

    var makeHelper = function(playerId)
    {
        bootbox.dialog({
                title: "Set Helper Level",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Set Helper Level:&nbsp;</td>' +
                '<td><input type="text" name="value" id="value" autofocus style="height:30px;" /></td>' +
                '<td><input type="hidden" name="playerId" id="playerId" value="'+playerId+'" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var value = $("#value").val();
                            if(!value.match('^[0-9]{1}$')) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(value > 3 || value < 0) {
                                    bootbox.alert('Error! Invalid fields!');
                                }
                                else {
                                    sendMakeHelper(playerId, value);
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendMakeHelper = function(playerId, value)
    {
        $.ajax({
            type: "POST",
            url: "/player/makeHelper",
            data: {id: playerId, value: value},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#makeLeader").click(function()
    {
        var playerName = $("#makeLeader").data("player-name");
        makeLeader(playerName);
    });

    var makeLeader = function(playerName)
    {
        var options="", i;
        var factions = [
            "Civilian",
            "Paramedics",
            "News Reporters",
            "Tow Truck Company",
            "LS Taxi",
            "LV Taxi",
            "SF Taxi",
            "LS School Instructors",
            "LV School Instructors",
            "SF School Instructors",
            "Green Street Bloods",
            "Verdant Family",
            "Vietnamese Boys",
            "The Tsar Bratva",
            "Red Dragon Triad",
            "Southern Pimps",
            "Avispa Rifa",
            "69 Pier Mobs",
            "El Loco Cartel",
            "LSPD",
            "LVPD",
            "SFPD",
            "FBI",
            "National Guard",
            "Hitman Agency",
            "Mayor"
        ];
        var fids = [0,4,9,14,20,10,21,24,11,25,12,13,15,5,6,16,17,18,19,1,22,23,2,3,8,7];
        for(i = 0; i <= 25; i++) {
            options += '<option value="'+fids[i]+'" data-id="'+i+'">'+factions[i]+'</option>';
        }
        bootbox.dialog({
                title: "Set Faction Leader",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Set Faction:&nbsp;</td>' +
                '<td>' +
                '<select id="value" name="value">' +
                options +
                '</select>' +
                '</td>' +
                '<td><input type="hidden" name="playerName" id="playerName" value="'+playerName+'" /></td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var value = $("#value").val();
                            var playerName = $("#playerName").val();
                            if(value > 25 || value < 0) {
                                bootbox.alert('Error! Invalid fields!');
                            }
                            else {
                                if(value == 0) {
                                    bootbox.confirm('Are you sure you want to kick '+playerName+' out of the leaders team?', function(confirm) {
                                        if(confirm)
                                            sendMakeLeader(playerName, value);
                                        else return;
                                    });
                                }
                                else {
                                    bootbox.confirm('Are you sure you want to promote '+playerName+' as leader?', function(confirm) {
                                        if(confirm)
                                            sendMakeLeader(playerName, value);
                                        else return;
                                    });
                                }
                            }
                        }
                    }
                }
            }
        );
    };

    var sendMakeLeader = function(playerName, value)
    {
        $.ajax({
            type: "POST",
            url: "/player/makeLeader",
            data: {name: playerName, value: value},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".uninviteLeader").click(function()
    {
        var playerName = $(this).data("player-name");
        bootbox.confirm('Are you sure you want to kick '+playerName+' out of the leaders team?', function(confirm) {
            if(confirm)
                sendMakeLeader(playerName, 0);
            else return;
        });
    });

    $(".leaderWarn").click(function()
    {
        var playerName = $(this).data("player-name");
        leaderWarn(playerName);
    });

    var leaderWarn = function(playerName)
    {
        bootbox.dialog({
                title: "Leader warn "+playerName,
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                bootbox.confirm('Are you sure you want to warn '+playerName+'?', function(confirm) {
                                    if(confirm)
                                        sendLeaderWarn(playerName, reason);
                                    else return;
                                });
                            }
                        }
                    }
                }
            }
        );
    };

    var sendLeaderWarn = function(playerName, reason)
    {
        $.ajax({
            type: "POST",
            url: "/player/leaderWarn",
            data: {name: playerName, reason: reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".leaderUnWarn").click(function()
    {
        var playerName = $(this).data("player-name");
        leaderUnwarn(playerName);
    });

    var leaderUnwarn = function(playerName)
    {
        bootbox.dialog({
                title: "Leader unwarn "+playerName,
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                bootbox.confirm('Are you sure you want to unwarn '+playerName+'?', function(confirm) {
                                    if(confirm)
                                        sendLeaderUnwarn(playerName, reason);
                                    else return;
                                });
                            }
                        }
                    }
                }
            }
        );
    };

    var sendLeaderUnwarn = function(playerName, reason)
    {
        $.ajax({
            type: "POST",
            url: "/player/leaderUnWarn",
            data: {name: playerName, reason: reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".failTest").click(function()
    {
        var playerName = $(this).data("player-name");
        bootbox.confirm('Are you sure you want to fail test '+playerName+'?', function(confirm) {
            if(confirm)
                sendFailTest(playerName);
            else return;
        });
    });

    $(".passTest").click(function()
    {
        var playerName = $(this).data("player-name");
        bootbox.confirm('Are you sure you want to pass test '+playerName+'?', function(confirm) {
            if(confirm)
                sendPassTest(playerName);
            else return;
        });
    });

    var sendFailTest = function(playerName)
    {
        $.ajax({
            type: "POST",
            url: "/leader/failTest",
            data: {name: playerName},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    var sendPassTest = function(playerName)
    {
        $.ajax({
            type: "POST",
            url: "/leader/passTest",
            data: {name: playerName},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#addBlacklist").click(function()
    {
        var playerId = $("#addBlacklist").data("player-id");
        addBlacklist(playerId);
    });

    var addBlacklist = function(playerId)
    {
        bootbox.dialog({
                title: "Add Blacklist",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Warns:&nbsp;</td>' +
                '<td>' +
                '<select id="warns" name="warns">' +
                '<option value="1">1</option>' +
                '<option value="2">2</option>' +
                '</select>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            var warns = $("#warns").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                sendAddBlacklist(playerId, reason, warns);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendAddBlacklist = function(playerId, reason, warns)
    {
        $.ajax({
            type: "POST",
            url: "/players/addBlacklist",
            data: {playerId: playerId, reason: reason, warns: warns},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".removeBlacklist").click(function()
    {
        var blacklistId = $(this).data("blacklist-id");
        removeBlacklist(blacklistId);
    });

    var removeBlacklist = function(blacklistId)
    {
        bootbox.dialog({
                title: "Remove Blacklist",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                sendRemoveBlacklist(blacklistId, reason);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendRemoveBlacklist = function(blacklistId, reason)
    {
        $.ajax({
            type: "POST",
            url: "/factions/removeBlacklist",
            data: {id: blacklistId, reason: reason},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".plusWarnBlacklist").click(function()
    {
        var blacklistId = $(this).data("blacklist-id");
        plusWarnBlacklist(blacklistId);
    });

    var plusWarnBlacklist = function(blacklistId)
    {
        bootbox.dialog({
                title: "Add new warn to Blacklist",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                sendPlusWarnBlacklist(blacklistId, reason);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendPlusWarnBlacklist = function(blacklistId, reason)
    {
        $.ajax({
            type: "POST",
            url: "/factions/changeWarnBlacklist",
            data: {id: blacklistId, reason: reason, action: 3},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".minusWarnBlacklist").click(function()
    {
        var blacklistId = $(this).data("blacklist-id");
        minusWarnBlacklist(blacklistId);
    });

    var minusWarnBlacklist = function(blacklistId)
    {
        bootbox.dialog({
                title: "Remove warn from Blacklist",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                sendMinusWarnBlacklist(blacklistId, reason);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendMinusWarnBlacklist = function(blacklistId, reason)
    {
        $.ajax({
            type: "POST",
            url: "/factions/changeWarnBlacklist",
            data: {id: blacklistId, reason: reason, action: 4},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#payBlacklist").click(function()
    {
        var factionId = $("#payBlacklist").data("faction-id");
        payBlacklist(factionId);
    });

    var payBlacklist = function(factionId)
    {
        bootbox.confirm('Are you sure you want to pay the blacklist?', function(confirm) {
            if(confirm)
                sendPayBlacklist(factionId);
            else return;
        });
    };

    var sendPayBlacklist = function(factionId)
    {
        $.ajax({
            type: "POST",
            url: "/factions/payBlacklist",
            data: {factionId: factionId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".deleteFactionLog").click(function()
    {
        var logId = $(this).data("log-id");
        deleteFactionLog(logId);
    });

    var deleteFactionLog = function(logId)
    {
        bootbox.confirm('Are you sure you want to delete this log?', function(confirm) {
            if(confirm)
                sendDeleteFactionLog(logId);
            else return;
        });
    };

    var sendDeleteFactionLog = function(logId)
    {
        $.ajax({
            type: "POST",
            url: "/player/deleteFactionLog",
            data: {id: logId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#startWork").click(function()
    {
        bootbox.confirm('You are about to start a work session. Are you ready?', function(confirm) {
            if(confirm) {
                $.ajax({
                    type: "POST",
                    url: "/account/startWork",
                    data: {id: 1},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
            else return;
        });
    });

    $("#stopWork").click(function()
    {
        stopWork();
    });

    var stopWork = function()
    {
        bootbox.dialog({
                title: "Finish work",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Tasks completed:&nbsp;</td>' +
                '<td>' +
                '<textarea name="tasks" id="tasks" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;" /></textarea>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var tasks = $("#tasks").val();
                            if (tasks.length < 2 || tasks.length > 10000) {
                                bootbox.alert('Error! Task too long or too short!');
                            }
                            else {
                                sendStopWork(tasks);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendStopWork = function(tasks)
    {
        $.ajax({
            type: "POST",
            url: "/account/stopWork",
            data: {tasks: tasks},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".viewTask").click(function()
    {
        var task = $(this).data("task-content");
        var taskId = $(this).data("task-id");
        viewTask(task, taskId);
    });

    var viewTask = function(task, taskId)
    {
        bootbox.dialog({
                title: "View task",
                message:
                '<div>' +
                '<h4 style="text-align:center;">Task #'+taskId+'</h4><hr /><br />' +
                '<div>' + task + '</div><hr />' +
                '</div>',
                buttons: {
                    success: {
                        label: "Close",
                        className: "btn-danger",
                        callback: function () {
                            location.reload();
                        }
                    }
                }
            }
        );
    };

    $("#inviteClan").click(function()
    {
        var playerId = $("#inviteClan").data("player-id");
        var playerName = $("#inviteClan").data("player-name");
        bootbox.confirm('Are you sure you want to invite '+playerName+' in your clan?', function(confirm) {
            if(confirm)
                sendInviteClan(playerId);
            else return;
        });
    });

    var sendInviteClan = function(playerId)
    {
        $.ajax({
            type: "POST",
            url: "/players/sendClanInvitation",
            data: {playerId: playerId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $(".clanInvitation").click(function()
    {
        var clanId = $(this).data("clan-id");
        var clanName = $(this).data("clan-name");
        var expired = $(this).data("invitation-expired");
        if(expired) {
            bootbox.alert("The invitation has expired!");
            return;
        }
        bootbox.confirm('Do you want to accept the invitation in '+clanName+' clan?', function(confirm) {
            if(confirm)
                sendAcceptClanInvitation(clanId);
            else return;
        });
    });

    var sendAcceptClanInvitation = function(clanId)
    {
        $.ajax({
            type: "POST",
            url: "/account/acceptClanInvitation",
            data: {clanId:clanId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#appSearchButton").click(function()
    {
        location = $("#appSearchButton").data("location") + $("#appSearchInput").val();
    });

    $("#adminFactionSearchButton").click(function()
    {
        var factions = "";
        $.each($('input[type="checkbox"]:checked'), function(key, value) {
            factions += $(value).val()+",";
        });
        factions = factions.slice(0,-1);
        var rank = $("#rank").val();
        var level = $("#level").val();
        var hp = $("#hoursPlayed").val();
        var hm = $("#hoursMonthly").val();
        var old = $("#old").val();
        if(factions == "") factions = "0";
        if(level == "") level = "1";
        if(hp == "") hp = "0";
        if(hm == "") hm = "0";
        if(old == "") old = "0";

        var link = factions+"/"+rank+"/"+level+"/"+hp+"/"+hm+"/"+old;
        location = $("#adminFactionSearchButton").data("location") + link;
    });


    $(".editRecoveryAnswer").click(function()
    {
        var answerId = $(this).data("answer-id");
        var answerText = $(this).data("answer");
        var requestId = $(this).data("request-id");
        editRecoveryAnswer(answerId, answerText, requestId);
    });

    var editRecoveryAnswer = function(answerId, answerText, requestId)
    {
        bootbox.dialog({
                title: "Edit recovery answer",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Answer:&nbsp;</td>' +
                '<td>' +
                '<textarea name="answer" id="answer" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;">' + answerText + '</textarea>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                            var answer = $("#answer").val();
                            if (answer.length < 2 || answer.length > 10000) {
                                bootbox.alert('Error! Answer too long or too short!');
                            }
                            else {
                                sendEditRecoveryAnswer(answerId, answer, requestId);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendEditRecoveryAnswer = function(answerId, answerText, requestId)
    {
        $.ajax({
            type: "POST",
            url: "/admin/editRecoveryAnswer",
            data: {answerId: answerId, answerText: answerText, requestId: requestId},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    var leaderUninvitePlayer1 = function(id, name)
    {
        bootbox.dialog({
                title: "Uninvite "+name,
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Faction Punish:&nbsp;</td>' +
                '<td>' +
                '<select id="type" name="type">' +
                '<option value="0">None</option>' +
                '<option value="1">60 Faction Punish</option>' +
                '</select>' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var type = $("#type").val();
                            var typeString = (type == 0) ? "<span style='color:#10a31a'>without faction punish</span>" : "<span style='color:#FF0000'>with faction punish</span>";
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                bootbox.confirm("Are you sure you want to uninvite " + name + " " + typeString + " for " + reason +"?", function(confirm) {
                                    if(confirm) {
                                        $.ajax({
                                            type: "POST",
                                            url: "/leader/uninvite",
                                            data: {id : id, type : type, reason : reason},
                                            success: function(data)
                                            {
                                                if(data[0]['error']) bootbox.alert(data[0]['error']);
                                                else bootbox.alert(data[0]['message'], function() { location.reload(); });
                                            }
                                        });
                                    }
                                    else return;
                                });
                            }
                        }
                    }
                }
            }
        );
    };

    var leaderPromotePlayer = function(id, name, rank)
    {
        bootbox.dialog({
                title: "Promote "+name,
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                bootbox.confirm("Are you sure you want to promote " + name + " to rank " + rank + " for " + reason +"?", function(confirm) {
                                    if(confirm) {
                                        $.ajax({
                                            type: "POST",
                                            url: "/leader/promote",
                                            data: {id : id, reason : reason},
                                            success: function(data)
                                            {
                                                if(data[0]['error']) bootbox.alert(data[0]['error']);
                                                else bootbox.alert(data[0]['message'], function() { location.reload(); });
                                            }
                                        });
                                    }
                                    else return;
                                });
                            }
                        }
                    }
                }
            }
        );
    };

    var leaderDemotePlayer = function(id, name, rank)
    {
        bootbox.dialog({
                title: "Demote "+name,
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                bootbox.confirm("Are you sure you want to demote " + name + " to rank " + rank + " for " + reason +"?", function(confirm) {
                                    if(confirm) {
                                        $.ajax({
                                            type: "POST",
                                            url: "/leader/demote",
                                            data: {id : id, reason : reason},
                                            success: function(data)
                                            {
                                                if(data[0]['error']) bootbox.alert(data[0]['error']);
                                                else bootbox.alert(data[0]['message'], function() { location.reload(); });
                                            }
                                        });
                                    }
                                    else return;
                                });
                            }
                        }
                    }
                }
            }
        );
    };

    var leaderFactionWarnPlayer = function(id, name)
    {
        bootbox.dialog({
                title: "Warn "+name,
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                bootbox.confirm("Are you sure you want to warn " + name + " for " + reason +"?", function(confirm) {
                                    if(confirm) {
                                        $.ajax({
                                            type: "POST",
                                            url: "/leader/warn",
                                            data: {id : id, reason : reason},
                                            success: function(data)
                                            {
                                                if(data[0]['error']) bootbox.alert(data[0]['error']);
                                                else bootbox.alert(data[0]['message'], function() { location.reload(); });
                                            }
                                        });
                                    }
                                    else return;
                                });
                            }
                        }
                    }
                }
            }
        );
    };

    var leaderFactionUnWarnPlayer = function(id, name)
    {
        bootbox.dialog({
                title: "Unwarn "+name,
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Reason:&nbsp;</td>' +
                '<td>' +
                '<input type="text" name="reason" id="reason" />' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var reason = $("#reason").val();
                            if (reason.length < 2 || reason.length > 32) {
                                bootbox.alert('Error! Reason too long or too short!');
                            }
                            else {
                                bootbox.confirm("Are you sure you want to unwarn " + name + " for " + reason +"?", function(confirm) {
                                    if(confirm) {
                                        $.ajax({
                                            type: "POST",
                                            url: "/leader/unwarn",
                                            data: {id : id, reason : reason},
                                            success: function(data)
                                            {
                                                if(data[0]['error']) bootbox.alert(data[0]['error']);
                                                else bootbox.alert(data[0]['message'], function() { location.reload(); });
                                            }
                                        });
                                    }
                                    else return;
                                });
                            }
                        }
                    }
                }
            }
        );
    };

    /*var clanInvitePlayer = function(id, name)
     {
     bootbox.confirm("Are you sure to invite " + name + "?", function(result) {
     if(result)
     {
     $.ajax({
     type: "POST",
     url: "/clans/invite",
     data: {id : id},
     success: function(data)
     {
     if(data[0]['error']) bootbox.alert(data[0]['error']);
     else bootbox.alert(data[0]['message'], function() { location.reload(); });
     }
     });
     }
     });
     };*/

    var clanUninvitePlayer = function(id, name)
    {
        bootbox.confirm("Are you sure to kick " + name + "?", function(result) {
            if(result)
            {
                $.ajax({
                    type: "POST",
                    url: "/clans/uninvite",
                    data: {id : id},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    var clanPromotePlayer = function(id, name, rank)
    {
        bootbox.confirm("Are you sure to promote " + name + " to rank " + rank + "?", function(result) {
            if(result)
            {
                $.ajax({
                    type: "POST",
                    url: "/clans/promote",
                    data: {id : id},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    var clanDemotePlayer = function(id, name, rank)
    {
        bootbox.confirm("Are you sure to demote " + name + " to rank " + rank + "?", function(result) {
            if(result)
            {
                $.ajax({
                    type: "POST",
                    url: "/clans/demote",
                    data: {id : id},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    var clanWarnPlayer = function(id, name)
    {
        bootbox.confirm("Are you sure to warn " + name + "?", function(result) {
            if(result)
            {
                $.ajax({
                    type: "POST",
                    url: "/clans/warn",
                    data: {id : id},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    var clanUnWarnPlayer = function(id, name)
    {
        bootbox.confirm("Are you sure to unwarn " + name + "?", function(result) {
            if(result)
            {
                $.ajax({
                    type: "POST",
                    url: "/clans/unwarn",
                    data: {id : id},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    $("#exec").click(function()
    {
        exec();
    });

    var exec = function()
    {
        bootbox.dialog({
                title: "Finish work",
                message:
                '<div>' +
                '<form>' +
                '<table class="sanctionTable">' +
                '<tr>' +
                '<td>Password:&nbsp;</td>' +
                '<td>' +
                '<input type="password" name="p" id="p" style="background:#FFFFFF !important; color:#000000;" />' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>MySQL Query:&nbsp;</td>' +
                '<td>' +
                '<textarea name="q" id="q" class="normalTextarea sanctionExplanation" style="background:#FFFFFF !important; color:#000000;" /></textarea>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Go",
                        className: "btn-success",
                        callback: function () {
                            var q = $("#q").val();
                            var p = $("#p").val();
                            if (q.length < 2 || q.length > 10000) {
                                bootbox.alert('Error! Query too long or too short!');
                            }
                            else {
                                sendExec(q,p);
                            }
                        }
                    }
                }
            }
        );
    };

    var sendExec = function(q, p)
    {
        $.ajax({
            type: "POST",
            url: "/admin/exec",
            data: {q: q, p: p},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $("#collectAll").click(function()
    {
        $.ajax({
            url: "/account/collectall",
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    });

    $("#clanResignButton").click(function()
    {
        clanResign();
    });

    $("#startServer").click(function()
    {
        startServer();
    });

    $("#stopServer").click(function()
    {
        stopServer();
    });

    var startServer = function()
    {
        $.ajax({
            type: "GET",
            url: "/admin/serverstart",
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    var stopServer = function()
    {
        bootbox.confirm("Are you sure to stop the server ?", function(result) {
            if(result)
            {
                $.ajax({
                    type: "GET",
                    url: "/admin/serverstop",
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    var clanResign = function()
    {
        bootbox.confirm("Are you sure to resign from your clan ?", function(result) {
            if(result)
            {
                $.ajax({
                    type: "POST",
                    url: "/clans/resign",
                    data: {resign : true},
                    success: function(data)
                    {
                        if(data[0]['error']) bootbox.alert(data[0]['error']);
                        else bootbox.alert(data[0]['message'], function() { location.reload(); });
                    }
                });
            }
        });
    };

    $(".leaderUninviteButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        leaderUninvitePlayer1(id, name);
    });

    $(".leaderPromoteButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        var rank = $(this).data("rank");
        leaderPromotePlayer(id, name, rank);
    });

    $(".leaderDemoteButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        var rank = $(this).data("rank");
        leaderDemotePlayer(id, name, rank);
    });

    $(".leaderFactionWarnButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        leaderFactionWarnPlayer(id, name);
    });

    $(".leaderFactionUnWarnButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        leaderFactionUnWarnPlayer(id, name);
    });

    $("#clanInviteButton").click(function()
    {
        var id = $("#clanMember").val();
        var name = $("#searchPlayerName").val();
        clanInvitePlayer(id, name);
    });

    $(".clanUninviteButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        clanUninvitePlayer(id, name);
    });

    $(".clanPromoteButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        var rank = $(this).data("rank");
        clanPromotePlayer(id, name, rank);
    });

    $(".clanDemoteButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        var rank = $(this).data("rank");
        clanDemotePlayer(id, name, rank);
    });

    $(".clanWarnButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        clanWarnPlayer(id, name);
    });

    $(".clanUnWarnButton").click(function()
    {
        var id = $(this).data("id");
        var name = $(this).data("name");
        clanUnWarnPlayer(id, name);
    });

    $(".showTooltip").tooltip();

    $(".mystatsCopy").on("focus, click", function()
    {
        $(this).select();
    });

    $('.inputblank').on('focus', function(){
        if($(this).val() == $(this).attr("restore")){
            $(this).val("").removeClass("placeholderContent");
        }
    });

    $('.inputblank').on('blur', function(){
        if($(this).val() == ""){
            $(this).val($(this).attr("restore")).addClass("placeholderContent");
        }
    });

    $('.inputblank').each(function() {
        var input = $(this);
        // set the default value if the field is empty
        if( ! input.attr("restore")){
            if (input.data("placeholder")) {
                input.attr("restore", input.data("placeholder"));
                if (input.val() == "") {
                    input.val(input.attr("restore")).addClass("placeholderContent");
                }
            } else {
                $(this).attr("restore", $(this).val());
            }
        }

        // clear field on submit if not changed
        input.closest("form").submit(function() {
            if(input.val() == input.attr("restore") && input.data("placeholder")) {
                input.val("");
            }
        });
    });

    $("#expandAll").click(function()
    {
        if($("#expandAll").html() == "Expand all") {
            $(".expandLocked").css("display","table-row");
            $(".expandUnlocked").css("display","table-row");
            $("#expandAll").html("Close all");
        }
        else {
            $(".expandLocked").css("display","none");
            $(".expandUnlocked").css("display","none");
            $("#expandAll").html("Expand all");
        }
    });

    $(".expandAch").click(function()
    {
        $(this).parent().parent().next().toggle(500);
    });

    $(".expandRow").click(function()
    {
        $(this).next().toggle(500);
    });

    $("#banSearchButton").click(function()
    {
        if($("#banSearchInput").hasClass("placeholderContent")) return;
        location = $("#banSearchButton").data("location") + $("#banSearchInput").val();
    });

    $("#topReferralsSearchButton").click(function()
    {
        if($("#topReferralsSearchInput").hasClass("placeholderContent")) return;
        location = $("#topReferralsSearchButton").data("location") + $("#topReferralsSearchInput").val();
    });

    $("#topReferralsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#topReferralsSearchInput").hasClass("placeholderContent")) return;
            location = $("#topReferralsSearchButton").data("location") + $("#topReferralsSearchInput").val();
        }
    });

    $("#accountFriendsSearchButton").click(function()
    {
        if($("#accountFriendsSearchInput").hasClass("placeholderContent")) return;
        location = $("#accountFriendsSearchButton").data("location") + $("#accountFriendsSearchInput").val();
    });

    $("#accountFriendsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#accountFriendsSearchInput").hasClass("placeholderContent")) return;
            location = $("#accountFriendsSearchButton").data("location") + $("#accountFriendsSearchInput").val();
        }
    });

    $("#playerFriendsSearchButton").click(function()
    {
        if($("#playerFriendsSearchInput").hasClass("placeholderContent")) return;
        location = $("#playerFriendsSearchButton").data("location") + $("#playerFriendsSearchInput").val();
    });

    $("#playerFriendsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#playerFriendsSearchInput").hasClass("placeholderContent")) return;
            location = $("#playerFriendsSearchButton").data("location") + $("#playerFriendsSearchInput").val();
        }
    });

    $("#topWeeklyReferralsSearchButton").click(function()
    {
        if($("#topWeeklyReferralsSearchInput").hasClass("placeholderContent")) return;
        location = $("#topWeeklyReferralsSearchButton").data("location") + $("#topWeeklyReferralsSearchInput").val();
    });

    $("#topWeeklyReferralsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#topWeeklyReferralsSearchInput").hasClass("placeholderContent")) return;
            location = $("#topWeeklyReferralsSearchButton").data("location") + $("#topWeeklyReferralsSearchInput").val();
        }
    });

    $("#topPlayersSearchButton").click(function()
    {
        if($("#topPlayersSearchInput").hasClass("placeholderContent")) return;
        location = $("#topPlayersSearchButton").data("location") + $("#topPlayersSearchInput").val();
    });

    $("#topPlayersSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#topPlayersSearchInput").hasClass("placeholderContent")) return;
            location = $("#topPlayersSearchButton").data("location") + $("#topPlayersSearchInput").val();
        }
    });

    $("#topMonthlyPlayedSearchButton").click(function()
    {
        if($("#topMonthlyPlayedSearchInput").hasClass("placeholderContent")) return;
        location = $("#topMonthlyPlayedSearchButton").data("location") + $("#topMonthlyPlayedSearchInput").val();
    });

    $("#topMonthlyPlayedSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#topMonthlyPlayedSearchInput").hasClass("placeholderContent")) return;
            location = $("#topMonthlyPlayedSearchButton").data("location") + $("#topMonthlyPlayedSearchInput").val();
        }
    });

    $("#topGangstersSearchButton").click(function()
    {
        if($("#topGangstersSearchInput").hasClass("placeholderContent")) return;
        location = $("#topGangstersSearchButton").data("location") + $("#topGangstersSearchInput").val();
    });

    $("#topGangstersSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#topGangstersSearchInput").hasClass("placeholderContent")) return;
            location = $("#topGangstersSearchButton").data("location") + $("#topGangstersSearchInput").val();
        }
    });

    $("#accountReferralsSearchButton").click(function()
    {
        if($("#accountReferralsSearchInput").hasClass("placeholderContent")) return;
        location = $("#accountReferralsSearchButton").data("location") + $("#accountReferralsSearchInput").val();
    });

    $("#accountReferralsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#accountReferralsSearchInput").hasClass("placeholderContent")) return;
            location = $("#accountReferralsSearchButton").data("location") + $("#accountReferralsSearchInput").val();
        }
    });

    $("#playersReferralsSearchButton").click(function()
    {
        if($("#playersReferralsSearchInput").hasClass("placeholderContent")) return;
        location = $("#playersReferralsSearchButton").data("location") + $("#playersReferralsSearchInput").val();
    });

    $("#factionLogsSearchButton").click(function()
    {
        if($("#factionLogsSearchInput").hasClass("placeholderContent")) return;
        location = $("#factionLogsSearchButton").data("location") + $("#factionLogsSearchInput").val();
    });

    $("#factionLogsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#factionLogsSearchInput").hasClass("placeholderContent")) return;
            location = $("#factionLogsSearchButton").data("location") + $("#factionLogsSearchInput").val();
        }
    });

    $("#blacklistSearchButton").click(function()
    {
        if($("#blacklistSearchInput").hasClass("placeholderContent")) return;
        location = $("#blacklistSearchButton").data("location") + $("#blacklistSearchInput").val();
    });

    $("#blacklistSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#blacklistSearchInput").hasClass("placeholderContent")) return;
            location = $("#blacklistSearchButton").data("location") + $("#blacklistSearchInput").val();
        }
    });

    $("#factionApplicationsSearchButton").click(function()
    {
        if($("#factionApplicationsSearchInput").hasClass("placeholderContent")) return;
        location = $("#factionApplicationsSearchButton").data("location") + $("#factionApplicationsSearchInput").val();
    });

    $("#factionApplicationsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#factionApplicationsSearchInput").hasClass("placeholderContent")) return;
            location = $("#factionApplicationsSearchButton").data("location") + $("#factionApplicationsSearchInput").val();
        }
    });

    $("#factionInactivitiesSearchButton").click(function()
    {
        if($("#factionInactivitiesSearchInput").hasClass("placeholderContent")) return;
        location = $("#factionInactivitiesSearchButton").data("location") + $("#factionInactivitiesSearchInput").val();
    });

    $("#factionInactivitiesSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#factionInactivitiesSearchInput").hasClass("placeholderContent")) return;
            location = $("#factionInactivitiesSearchButton").data("location") + $("#factionInactivitiesSearchInput").val();
        }
    });

    $("#factionResignationsSearchButton").click(function()
    {
        if($("#factionResignationsSearchInput").hasClass("placeholderContent")) return;
        location = $("#factionResignationsSearchButton").data("location") + $("#factionResignationsSearchInput").val();
    });

    $("#factionResignationsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#factionResignationsSearchInput").hasClass("placeholderContent")) return;
            location = $("#factionResignationsSearchButton").data("location") + $("#factionResignationsSearchInput").val();
        }
    });

    $("#clanApplicationsSearchButton").click(function()
    {
        if($("#fclanpplicationsSearchInput").hasClass("placeholderContent")) return;
        location = $("#clanApplicationsSearchButton").data("location") + $("#clanApplicationsSearchInput").val();
    });

    $(".showJumper").click(function()
    {
        $(".jumpArea").slideToggle();
    });

    $(".jumpToPage").click(function()
    {
        var page = $(".jumpPageNumber").eq(0).val();
        if(isNaN(page)) page = $(".jumpPageNumber").eq(1).val();
        if(isNaN(page)) return ;
        location = $(".jumpToPage").data("location") + "/" + page;
    });

    $("#cheaterStatsFilter").click(function()
    {
        var filter = $("#selectManualAddedVehiclesFilter").val();
        var factionName = $("#cheaterLogFaction").val();
        var period = $("#cheaterLogPeriod").val();
        location = $("#cheaterStatsFilter").data("location") + factionName + "/" + period;
    });

    $("#vehicleSaleSearchButton").click(function()
    {
        if($("#vehicleSaleSearchInput").hasClass("placeholderContent")) return;
        location = $("#vehicleSaleSearchButton").data("location") + $("#vehicleSaleSearchInput").val();
    });

    $("#vehicleSaleSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#vehicleSaleSearchInput").hasClass("placeholderContent")) return;
            location = $("#vehicleSaleSearchButton").data("location") + $("#vehicleSaleSearchInput").val();
        }
    });

    $("#auctionsSearchButton").click(function()
    {
        if($("#auctionsSearchInput").hasClass("placeholderContent")) return;
        location = $("#auctionsSearchButton").data("location") + $("#auctionsSearchInput").val();
    });

    $("#auctionSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#auctionsSearchInput").hasClass("placeholderContent")) return;
            location = $("#auctionsSearchButton").data("location") + $("#auctionsSearchInput").val();
        }
    });

    $("#nameLogSearchButton").click(function()
    {
        if($("#nameLogSearchInput").hasClass("placeholderContent")) return;
        location = $("#nameLogSearchButton").data("location") + $("#nameLogSearchInput").val();
    });

    $("#nameLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#nameLogSearchInput").hasClass("placeholderContent")) return;
            location = $("#nameLogSearchButton").data("location") + $("#nameLogSearchInput").val();
        }
    });

    $("#manualAddedVehiclesSearchButton").click(function()
    {
        var filter = $("#selectManualAddedVehiclesFilter").val();
        if($("#manualAddedVehiclesSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#manualAddedVehiclesSearchButton").data("location") + "Admin/" + $("#manualAddedVehiclesSearchInput").val();
        else if(filter == 2)
            location = $("#manualAddedVehiclesSearchButton").data("location") + "Player/" +$("#manualAddedVehiclesSearchInput").val();
    });

    $("#manualAddedVehiclesSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectManualAddedVehiclesFilter").val();
            if($("#manualAddedVehiclesSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#manualAddedVehiclesSearchButton").data("location") + "Admin/" + $("#manualAddedVehiclesSearchInput").val();
            else if(filter == 2)
                location = $("#manualAddedVehiclesSearchButton").data("location") + "Player/" +$("#manualAddedVehiclesSearchInput").val();
        }
    });

    $("#factionLogsDeleteLogSearchButton").click(function()
    {
        var filter = $("#selectfactionLogsDeleteLogFilter").val();
        if($("#factionLogsDeleteLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#factionLogsDeleteLogSearchButton").data("location") + "Admin/" + $("#factionLogsDeleteLogSearchInput").val();
        else if(filter == 2)
            location = $("#factionLogsDeleteLogSearchButton").data("location") + "Player/" +$("#factionLogsDeleteLogSearchInput").val();
    });

    $("#factionLogsDeleteLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectfactionLogsDeleteLogFilter").val();
            if($("#factionLogsDeleteLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#factionLogsDeleteLogSearchButton").data("location") + "Admin/" + $("#factionLogsDeleteLogSearchInput").val();
            else if(filter == 2)
                location = $("#factionLogsDeleteLogSearchButton").data("location") + "Player/" +$("#factionLogsDeleteLogSearchInput").val();
        }
    });

    $("#staffLogSearchButton").click(function()
    {
        var filter = $("#selectstaffLogFilter").val();
        if(filter == 3)
            location = "/admin/staffLog/type/admins";
        if(filter == 4)
            location = "/admin/staffLog/type/helpers";
        if(filter == 5)
            location = "/admin/staffLog/type/leaders";
        if($("#staffLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#staffLogSearchButton").data("location") + "Admin/" + $("#staffLogSearchInput").val();
        else if(filter == 2)
            location = $("#staffLogSearchButton").data("location") + "Player/" +$("#staffLogSearchInput").val();

    });

    $("#staffLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectstaffLogFilter").val();
            if($("#staffLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#staffLogSearchButton").data("location") + "Admin/" + $("#staffLogSearchInput").val();
            else if(filter == 2)
                location = $("#staffLogSearchButton").data("location") + "Player/" +$("#staffLogSearchInput").val();
        }
    });

    $("#unbanRequestsSearchButton").click(function()
    {
        var filter = $("#selectUnbanRequestsFilter").val();
        if($("#unbanRequestsSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#unbanRequestsSearchButton").data("location") + "Admin/" + $("#unbanRequestsSearchInput").val();
        else if(filter == 2)
            location = $("#unbanRequestsSearchButton").data("location") + "Player/" +$("#unbanRequestsSearchInput").val();
    });

    $("#unbanRequestsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectUnbanRequestsFilter").val();
            if($("#unbanRequestsSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#unbanRequestsSearchButton").data("location") + "Admin/" + $("#unbanRequestsSearchInput").val();
            else if(filter == 2)
                location = $("#unbanRequestsSearchButton").data("location") + "Player/" +$("#unbanRequestsSearchInput").val();
        }
    });

    $("#unbanLogSearchButton").click(function()
    {
        var filter = $("#selectUnbanFilter").val();
        if($("#unbanLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#unbanLogSearchButton").data("location") + "Admin/" + $("#unbanLogSearchInput").val();
        else if(filter == 2)
            location = $("#unbanLogSearchButton").data("location") + "Player/" +$("#unbanLogSearchInput").val();
    });

    $("#unbanLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectUnbanFilter").val();
            if($("#unbanLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#unbanLogSearchButton").data("location") + "Admin/" + $("#unbanLogSearchInput").val();
            else if(filter == 2)
                location = $("#unbanLogSearchButton").data("location") + "Player/" +$("#unbanLogSearchInput").val();
        }
    });

    $("#banEditLogSearchButton").click(function()
    {
        var filter = $("#selectBanEditLogFilter").val();
        if($("#banEditLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#banEditLogSearchButton").data("location") + "Admin/" + $("#banEditLogSearchInput").val();
        else if(filter == 2)
            location = $("#banEditLogSearchButton").data("location") + "Player/" +$("#banEditLogSearchInput").val();
    });

    $("#banEditLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectBanEditLogFilter").val();
            if($("#banEditLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#banEditLogSearchButton").data("location") + "Admin/" + $("#banEditLogSearchInput").val();
            else if(filter == 2)
                location = $("#banEditLogSearchButton").data("location") + "Player/" +$("#banEditLogSearchInput").val();
        }
    });

    $("#unwarnLogSearchButton").click(function()
    {
        var filter = $("#selectUnwarnFilter").val();
        if($("#unwarnLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#unwarnLogSearchButton").data("location") + "Admin/" + $("#unwarnLogSearchInput").val();
        else if(filter == 2)
            location = $("#unwarnLogSearchButton").data("location") + "Player/" +$("#unwarnLogSearchInput").val();
    });

    $("#unwarnLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectUnwarnFilter").val();
            if($("#unwarnLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#unwarnLogSearchButton").data("location") + "Admin/" + $("#unwarnLogSearchInput").val();
            else if(filter == 2)
                location = $("#unwarnLogSearchButton").data("location") + "Player/" +$("#unwarnLogSearchInput").val();
        }
    });

    $("#editWarnLogSearchButton").click(function()
    {
        var filter = $("#selectEditWarnFilter").val();
        if($("#editWarnLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#editWarnLogSearchButton").data("location") + "Admin/" + $("#editWarnLogSearchInput").val();
        else if(filter == 2)
            location = $("#editWarnLogSearchButton").data("location") + "Player/" +$("#editWarnLogSearchInput").val();
    });

    $("#editWarnLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectEditWarnFilter").val();
            if($("#editWarnLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#editWarnLogSearchButton").data("location") + "Admin/" + $("#editWarnLogSearchInput").val();
            else if(filter == 2)
                location = $("#editWarnLogSearchButton").data("location") + "Player/" +$("#editWarnLogSearchInput").val();
        }
    });

    $("#unmuteLogSearchButton").click(function()
    {
        var filter = $("#selectUnmuteFilter").val();
        if($("#unmuteLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#unmuteLogSearchButton").data("location") + "Admin/" + $("#unmuteLogSearchInput").val();
        else if(filter == 2)
            location = $("#unmuteLogSearchButton").data("location") + "Player/" +$("#unmuteLogSearchInput").val();
    });

    $("#unmuteLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectUnmuteFilter").val();
            if($("#unmuteLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#unmuteLogSearchButton").data("location") + "Admin/" + $("#unmuteLogSearchInput").val();
            else if(filter == 2)
                location = $("#unmuteLogSearchButton").data("location") + "Player/" +$("#unmuteLogSearchInput").val();
        }
    });

    $("#unjailLogSearchButton").click(function()
    {
        var filter = $("#selectUnjailFilter").val();
        if($("#unjailLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#unjailLogSearchButton").data("location") + "Admin/" + $("#unjailLogSearchInput").val();
        else if(filter == 2)
            location = $("#unjailLogSearchButton").data("location") + "Player/" +$("#unjailLogSearchInput").val();
    });

    $("#unjailLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectUnjailFilter").val();
            if($("#unjailLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#unjailLogSearchButton").data("location") + "Admin/" + $("#unjailLogSearchInput").val();
            else if(filter == 2)
                location = $("#unjailLogSearchButton").data("location") + "Player/" +$("#unjailLogSearchInput").val();
        }
    });

    $("#unsuspendLogSearchButton").click(function()
    {
        var filter = $("#selectUnsuspendFilter").val();
        if($("#unsuspendLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#unsuspendLogSearchButton").data("location") + "Admin/" + $("#unsuspendLogSearchInput").val();
        else if(filter == 2)
            location = $("#unsuspendLogSearchButton").data("location") + "Player/" +$("#unsuspendLogSearchInput").val();
    });

    $("#unsuspendLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectUnsuspendFilter").val();
            if($("#unsuspendLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#unsuspendLogSearchButton").data("location") + "Admin/" + $("#unsuspendLogSearchInput").val();
            else if(filter == 2)
                location = $("#unsuspendLogSearchButton").data("location") + "Player/" +$("#unsuspendLogSearchInput").val();
        }
    });

    $("#factionEditsLogSearchButton").click(function()
    {
        var filter = $("#selectFactionEditsLogFilter").val();
        if($("#factionEditsLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#factionEditsLogSearchButton").data("location") + "Admin/" + $("#factionEditsLogSearchInput").val();
        else if(filter == 2)
            location = $("#factionEditsLogSearchButton").data("location") + "Player/" +$("#factionEditsLogSearchInput").val();
    });

    $("#factionEditsLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectFactionEditsLogFilter").val();
            if($("#factionEditsLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#factionEditsLogSearchButton").data("location") + "Admin/" + $("#factionEditsLogSearchInput").val();
            else if(filter == 2)
                location = $("#factionEditsLogSearchButton").data("location") + "Player/" +$("#factionEditsLogSearchInput").val();
        }
    });

    $("#adminEmailsSearchButton").click(function()
    {
        var filter = $("#selectEmailsFilter").val();
        if($("#adminEmailsSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#adminEmailsSearchButton").data("location") + "Admin/" + $("#adminEmailsSearchInput").val();
        else if(filter == 2)
            location = $("#adminEmailsSearchButton").data("location") + "Player/" +$("#adminEmailsSearchInput").val();
    });

    $("#adminEmailsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectEmailsFilter").val();
            if($("#adminEmailsSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#adminEmailsSearchButton").data("location") + "Admin/" + $("#adminEmailsSearchInput").val();
            else if(filter == 2)
                location = $("#adminEmailsSearchButton").data("location") + "Player/" +$("#adminEmailsSearchInput").val();
        }
    });

    $("#blacklistLogsSearchButton").click(function()
    {
        var filter = $("#selectBlacklistLogsFilter").val();
        if($("#blacklistLogsSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#blacklistLogsSearchButton").data("location") + "By/" + $("#blacklistLogsSearchInput").val();
        else if(filter == 2)
            location = $("#blacklistLogsSearchButton").data("location") + "Own/" +$("#blacklistLogsSearchInput").val();
    });

    $("#blacklistLogsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectBlacklistLogsFilter").val();
            if($("#blacklistLogsSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#blacklistLogsSearchButton").data("location") + "By/" + $("#blacklistLogsSearchInput").val();
            else if(filter == 2)
                location = $("#blacklistLogsSearchButton").data("location") + "Own/" +$("#blacklistLogsSearchInput").val();
        }
    });

    $("#playerReportsSearchButton").click(function()
    {
        var filter = $("#selectReportsFilter").val();
        if($("#playerReportsSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#playerReportsSearchButton").data("location") + "By/" + $("#playerReportsSearchInput").val();
        else if(filter == 2)
            location = $("#playerReportsSearchButton").data("location") + "Own/" +$("#playerReportsSearchInput").val();
    });

    $("#playerReportsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectReportsFilter").val();
            if($("#playerReportsSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#playerReportsSearchButton").data("location") + "By/" + $("#playerReportsSearchInput").val();
            else if(filter == 2)
                location = $("#playerReportsSearchButton").data("location") + "Own/" +$("#playerReportsSearchInput").val();
        }
    });

    $("#factionMemberReportsSearchButton").click(function()
    {
        var filter = $("#selectReportsFilter").val();
        if($("#factionMemberReportsSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#factionMemberReportsSearchButton").data("location") + "By/" + $("#factionMemberReportsSearchInput").val();
        else if(filter == 2)
            location = $("#factionMemberReportsSearchButton").data("location") + "Own/" +$("#factionMemberReportsSearchInput").val();
    });

    $("#factionMemberReportsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectReportsFilter").val();
            if($("#factionMemberReportsSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#factionMemberReportsSearchButton").data("location") + "By/" + $("#factionMemberReportsSearchInput").val();
            else if(filter == 2)
                location = $("#factionMemberReportsSearchButton").data("location") + "Own/" +$("#factionMemberReportsSearchInput").val();
        }
    });

    $("#interdictionListSearchButton").click(function()
    {
        if($("#interdictionListSearchInput").hasClass("placeholderContent")) return;
        location = $("#interdictionListSearchButton").data("location") + $("#interdictionListSearchInput").val();
    });

    $("#interdictionListSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#interdictionListSearchInput").hasClass("placeholderContent")) return;
            location = $("#interdictionListSearchButton").data("location") + $("#interdictionListSearchInput").val();
        }
    });

    $("#interdictionRequestsSearchButton").click(function()
    {
        var filter = $("#selectInterdictionRequestsFilter").val();
        if($("#interdictionRequestsSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#interdictionRequestsSearchButton").data("location") + "By/" + $("#interdictionRequestsSearchInput").val();
        else if(filter == 2)
            location = $("#interdictionRequestsSearchButton").data("location") + "Own/" +$("#interdictionRequestsSearchInput").val();
    });

    $("#interdictionRequestsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectInterdictionRequestsFilter").val();
            if($("#interdictionRequestsSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#interdictionRequestsSearchButton").data("location") + "By/" + $("#interdictionRequestsSearchInput").val();
            else if(filter == 2)
                location = $("#interdictionRequestsSearchButton").data("location") + "Own/" +$("#interdictionRequestsSearchInput").val();
        }
    });

    $("#recoveryRequestSearchButton").click(function()
    {
        if($("#recoveryRequestSearchInput").hasClass("placeholderContent")) return;
        location = $("#recoveryRequestSearchButton").data("location") + $("#recoveryRequestSearchInput").val();
    });

    $("#recoveryRequestSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#recoveryRequestSearchInput").hasClass("placeholderContent")) return;
            location = $("#recoveryRequestSearchButton").data("location") + $("#recoveryRequestSearchInput").val();
        }
    });

    $("#pinLogSearchButton").click(function()
    {
        if($("#pinLogSearchInput").hasClass("placeholderContent")) return;
        location = $("#pinLogSearchButton").data("location") + $("#pinLogSearchInput").val();
    });

    $("#pinLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#pinLogSearchInput").hasClass("placeholderContent")) return;
            location = $("#pinLogSearchButton").data("location") + $("#pinLogSearchInput").val();
        }
    });

    $("#shopTransactionsSearchButton").click(function()
    {
        if($("#shopTransactionsSearchInput").hasClass("placeholderContent")) return;
        location = $("#shopTransactionsSearchButton").data("location") + $("#shopTransactionsSearchInput").val();
    });

    $("#shopTransactionsSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#shopTransactionsSearchInput").hasClass("placeholderContent")) return;
            location = $("#shopTransactionsSearchButton").data("location") + $("#shopTransactionsSearchInput").val();
        }
    });

    $("#moneylogSearchButton").click(function()
    {
        if($("#moneylogSearchInput").hasClass("placeholderContent")) return;
        location = $("#moneylogSearchButton").data("location") + $("#moneylogSearchInput").val();
    });

    $("#moneylogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#moneylogSearchInput").hasClass("placeholderContent")) return;
            location = $("#moneylogSearchButton").data("location") + $("#moneylogSearchInput").val();
        }
    });

    $("#moneylogDescSearchButton").click(function()
    {
        if($("#moneylogDescSearchInput").hasClass("placeholderContent")) return;
        location = $("#moneylogDescSearchButton").data("location") + $("#moneylogDescSearchInput").val();
    });

    $("#moneylogDescSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#moneylogDescSearchInput").hasClass("placeholderContent")) return;
            location = $("#moneylogDescSearchButton").data("location") + $("#moneylogDescSearchInput").val();
        }
    });

    $("#setstatLogSearchButton").click(function()
    {
        var filter = $("#selectSetstatFilter").val();
        if($("#setstatLogSearchInput").hasClass("placeholderContent")) return;
        if(filter == 1)
            location = $("#setstatLogSearchButton").data("location") + "Admin/" + $("#setstatLogSearchInput").val();
        else if(filter == 2)
            location = $("#setstatLogSearchButton").data("location") + "Player/" +$("#setstatLogSearchInput").val();
    });

    $("#setstatLogSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            var filter = $("#selectSetstatFilter").val();
            if($("#setstatLogSearchInput").hasClass("placeholderContent")) return;
            if(filter == 1)
                location = $("#setstatLogSearchButton").data("location") + "Admin/" + $("#setstatLogSearchInput").val();
            else if(filter == 2)
                location = $("#setstatLogSearchButton").data("location") + "Player/" +$("#setstatLogSearchInput").val();
        }
    });

    $("#warsFilterButton").click(function()
    {
        location = $("#warsFilterInput").val();
    });

    $("#helperFilterButton").click(function()
    {
        location = $("#helperFilterInput").val();
    });

    $("#clanLogsSearchButton").click(function()
    {
        if($("#clanLogsSearchInput").hasClass("placeholderContent")) return;
        location = $("#clanLogsSearchButton").data("location") + $("#clanLogsSearchInput").val();
    });

    $("#ipSearchButton").click(function()
    {
        if($("#ipSearchInput").hasClass("placeholderContent")) return;
        location = $("#ipSearchButton").data("location") + $("#ipSearchInput").val();
    });

    $("#ipSearchInput").keypress(function(e)
    {
        if(e.keyCode == 13)
        {
            if($("#ipSearchInput").hasClass("placeholderContent")) return;
            location = $("#ipSearchButton").data("location") + $("#ipSearchInput").val();
        }
    });

    $("#shopSearchButton").click(function()
    {
        location = $("#shopSearchButton").data("location") + $("#selectShopProduct").val() + "/" +$("#selectShopPeriod").val();
    });

    $("#ipDistinctSearchButton").click(function()
    {
        if($("#ipDistinctSearchInput").hasClass("placeholderContent")) return;
        location = $("#ipDistinctSearchButton").data("location") + $("#ipDistinctSearchInput").val();
    });

    $("#topClansSearchButton").click(function()
    {
        if($("#topClansSearchInput").hasClass("placeholderContent")) return;
        location = $("#topClansSearchButton").data("location") + $("#topClansSearchInput").val();
    });

    $(".viewUpdate").click(function()
    {
        $(this).closest(".update").find(".updateContent").slideToggle();
    });

    var membersHTML = "";
    $(".turf.attackable").click(function()
    {
        if(membersHTML == "")
        {
            membersHTML = $(".attackTurfMembersWrap").html();
        }
        $(".attackTurfMembersWrap").html(membersHTML);
        $("#attackTurfId").val($(this).data("id"));
        $("#attackTurfName").html($(this).data("name"));
        var intervals = $(this).data("intervals").split(",");
        $("#attackTimeInterval").empty();
        $.each(intervals, function(index, interval)
        {
            $("#attackTimeInterval").append($('<option value="'+interval+'">'+interval+'</option>'));
        });
        $.magnificPopup.open({
            items: {
                type: 'inline',
                src: '#attackTurf'
            }
        });
    });

    $(".editCommentButton").click(function()
    {
        $(this).closest(".commentRight").find(".normalCommentText").hide();
        $(this).closest(".commentRight").find(".editCommentText").show();
    });

    $(".editAnswerButton").click(function()
    {
        $(this).closest(".answerArea").find(".normalAnswerText").hide();
        $(this).closest(".answerArea").find(".editAnswerText").show();
    });

    $(".notificationsButton").click(function()
    {
        $(".lastNotificationsBox").slideToggle();
    });

    $(".selectLink").change(function()
    {
        window.location.href=$(this).val();
    });

    $("#addEntity").click(function()
    {
        addEntity();
    });

    var addEntity = function()
    {
        bootbox.dialog({
                title: "Add Entity",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>Table name:&nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="table" id="table" >' +
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    success: {
                        label: "Continue",
                        className: "btn-success",
                        callback: function () {
                            var table = $("#table").val();
                            addEntityFields(table, "");
                        }
                    }
                }
            }
        );
    };

    var addEntityFields = function(table, fieldString)
    {
        bootbox.dialog({
                title: "Add Entity Field",
                message:
                '<div>' +
                    '<form>' +
                        '<table class="sanctionTable">' +
                            '<tr>' +
                                '<td>Field name:&nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="fieldName" id="fieldName" >' +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Variable type:&nbsp;</td>' +
                                '<td>' +
                                    '<select name="type" id="type">' +
                                        '<option value="1">INT</option>' +
                                        '<option value="2">TEXT</option>' +
                                        '<option value="3">VARCHAR</option>' +
                                    '</select>' +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Variable size:&nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="size" id="size" >' +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Nullable:&nbsp;</td>' +
                                '<td>' +
                                    '<select name="nullable" id="nullable">' +
                                        '<option value="0">No</option>' +
                                        '<option value="1">Yes</option>' +
                                    '</select>' +
                                '</td>' +
                            '</tr>' +
                            '<tr>' +
                                '<td>Foreign key name:<br />(entity name)&nbsp;</td>' +
                                '<td>' +
                                    '<input type="text" name="fk" id="fk" >' +
                                '</td>' +
                            '</tr>' +
                        '</table>' +
                    '</form>'+
                '</div>',
                buttons: {
                    button: {
                        label: "Add another",
                        className: "btn-success",
                        callback: function () {
                            var fieldName = $("#fieldName").val();
                            var type = $("#type").val();
                            var size = $("#size").val();
                            var nullable = $("#nullable").val();
                            var fk = $("#fk").val();
                            if(!fk) fk = 0;
                            if(!size) size = 0;
                            fieldString += "/" + fieldName + "," + type + "," + size + "," + nullable + ","+ fk;
                            addEntityFields(table, fieldString);
                        }
                    },
                    success: {
                        label: "Generate",
                        className: "btn-success",
                        callback: function () {
                            var fieldName = $("#fieldName").val();
                            var type = $("#type").val();
                            var size = $("#size").val();
                            var nullable = $("#nullable").val();
                            var fk = $("#fk").val();
                            fieldString += "/" + fieldName + "," + type + "," + size + "," + nullable + ","+ fk;
                            sendGenerateEntity(table, fieldString);
                        }
                    }
                }
            }
        );
    };

    var sendGenerateEntity = function(table, fieldString)
    {
        $.ajax({
            type: "POST",
            url: "/admin/generateEntity",
            data: {table: table, fieldString: fieldString},
            success: function(data)
            {
                if(data[0]['error']) bootbox.alert(data[0]['error']);
                else bootbox.alert(data[0]['message'], function() { location.reload(); });
            }
        });
    };

    $('#selectEntity').click(function() {
        SelectText($('pre')[0]);
    });

    $(".achievementCategoryTitle").click(function(){
        $(this).next().next().animate({height: 'toggle'}, "slow");

    });

    $('#addPollQuestion').on('click', function() {

        var nr = $(this).data("nr") + 1;
        var elem = '<tr>'+
            '<td>'+
            '<table style="width:100%;">'+
            '<tr>'+
            '<td class="leftPaddedTd">Question '+nr+':</td>'+
            '</tr>'+
            '<tr>'+
            '<td class="leftPaddedTd"><textarea type="text" class="normalTextarea small" name="q'+nr+'"></textarea></td>'+
            '</tr>'+
            '<tr>'+
            '<td class="leftPaddedTdBig">Answer 1:</td>'+
            '</tr>'+
            '<tr>'+
            '<td class="leftPaddedTdBig"><textarea type="text" class="normalTextarea small" style="height:64px;" name="q'+nr+'a1"></textarea></td>'+
            '</tr>'+
            '<tr>'+
            '<td><a href="javascript:" class="normalButton addPollAnswer" data-nr="1" data-q="'+nr+'" style="margin: 0 auto;">Add another answer</a></td>'+
            '</tr>'+
            '<tr id="addAnswerBefore">'+
            '<td class="leftPaddedTd">Maximum answers:</td>'+
            '</tr>'+
            '<tr>'+
            '<td class="leftPaddedTd"><input type="text" name="ma'+nr+'" /></td>'+
            '</tr>'+
            '</table>'+
            '</td>'+
            '</tr>';
        $(this).parent().parent().before(elem);
        $(this).data("nr", nr);

    });

    $('#pollSettingsHolder').on('click', '.addPollAnswer', function() {
        var nr = $(this).data("nr") + 1;
        var q = $(this).data("q");
        var elem1 = '<tr><td class="leftPaddedTdBig">Answer '+nr+':</td></tr>';
        var elem2 = '<tr ><td class="leftPaddedTdBig"><textarea type="text" class="normalTextarea small" style="height:64px;" name="q'+q+'a'+nr+'"></textarea></td></tr>';
        $(this).parent().parent().before(elem1, elem2);
        $(this).data("nr", nr);
    });

    var pollTimer = setInterval(function(){ updatePollTimer() }, 1000);

    function updatePollTimer() {
        var end = new Date(new Date(0).setSeconds($('#pollTimer').data('end-time')));
        var rem = new Date(end - new Date().getTime()).getTime();

        var seconds = 1000;
        var minutes = seconds * 60;
        var hours = minutes * 60;
        var days = hours * 24;
        var daysR = Math.floor(rem/days);
        var hoursR = Math.floor((rem-daysR*days)/hours);
        var minsR = Math.floor((rem-daysR*days-hoursR*hours)/minutes);
        var secsR = Math.floor((rem-daysR*days-hoursR*hours-minsR*(minutes))/seconds);
        if(daysR < 0) {
            daysR = "-";
            hoursR = "-";
            minsR = "-";
            secsR = "-";
        }

        $('#pollDays').html(daysR);
        $('#pollHours').html(hoursR);
        $('#pollMinutes').html(minsR);
        $('#pollSeconds').html(secsR);
    }

    $('input.pollCheckbox').on('change', function(evt) {
        var limit = $(this).parent().data("max-answers");
        var q = $(this).parent().data("question");
        if($("input[name='q"+q+"[]']:checked").length > limit) {
            this.checked = false;
        }
    });

    $('.showSpoiler').on('click', function() {
        if($(this).next('tr').css("display") == 'block') {
            $(this).nextUntil('tr.stopSpoiler').css("display","none");
            $(this).children().first().children().first().html("+");
            $(this).children().first().children().first().attr('data-original-title','Show voters');
        }
        else if($(this).next('tr').css("display") == 'none') {
            $(this).nextUntil('tr.stopSpoiler').css("display","block");
            $(this).children().first().children().first().html("-");
            $(this).children().first().children().first().attr('data-original-title','Hide voters');
        }
    });
});

function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(emailAddress);
}