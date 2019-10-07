<?php

include("jdf.php");

function sanitize_output($buffer) {

    $search = array(
        '/\>[^\S ]+/s',     // strip whitespaces after tags, except space
        '/[^\S ]+\</s',     // strip whitespaces before tags, except space
        '/(\s)+/s',         // shorten multiple whitespace sequences
        '/<!--(.|\s)*?-->/' // Remove HTML comments
    );

    $replace = array(
        '>',
        '<',
        '\\1',
        ''
    );

    $buffer = preg_replace($search, $replace, $buffer);

    return $buffer;
}

ob_start("sanitize_output");


global $factionCa;
$factionCa = array(
	"اقلیت‌های ملایم",
	"گنگ‌ها",
	"دپارتمان‌ها",
	"اقلیت‌های مشترک"
);

global $factionCA;
$factionCA = array(
	"peaceful",
	"gang",
	"department",
	"mixt"
);

global $factions;
$factions = array(
	"شهروندان",
	"دپارتمان پلیس اس.اف.",
	"اداره تحقیقات فدرال",
	"دولت",
	"خبرنگاران",
	"شرکت تاکسی رانی",
	"یدک کشان",
	"آژانس هیتمن",
	"خاندان گروو استریت",
	"خاندان تایتان",
	"کارتل مکزیک",
	"خاندان ریفا",
	"گارد ملی",
	"دپارتمان پزشکان",
	"دپارتمان پلیس ال.اس.",
	"دپارتمان پلیس ال.وی."
);

global $factionA;
$factionA = array(
	"civillian",
	"sfpd",
	"fbi",
	"government",
	"nr",
	"taxi",
	"ttc",
	"hitmen",
	"grovestreet",
	"titan",
	"cartel",
	"rifa",
	"ng",
	"pm",
	"lspd",
	"lvpd"
);

global $factionC;
$factionC = array(
	"FFFFFF",
	"2641FE",
	"1E519D",
	"B3F856",
	"C2A2DA",
	"FFFF00",
	"F5DEB3",
	"A52A2A",
	"008000",
	"800080",
	"FFA500",
	"00FFFF",
	"456FCF",
	"FF0000",
	"2641FE",
	"2641FE"
);

global $jobs;
$jobs = array(
	"بیکار",
	"کاراگاه",
	"مواد فروش",
	"مکانیک",
	"چمن زن",
	"راننده کامیون",
	"پیک پیتزا",
	"آشغال جمع‌کن",
	"کشاورز",
	"اسلحه فروش",
	"جیب‌بر"
);

global $factionR;
$factionR = array(
	array("هیچ"),
	array(
		"Officer(1)",
		"Detective(2)",
		"Sergeant(3)",
		"Lieutenant(4)",
		"Captain(5)",
		"Chief Assistant(6)",
		"Chief(7)"
	),
	array(
		"Professional Staff(1)",
		"Special Agent(2)",
		"Supervisory Special Agent(3)",
		"Special Agent in Charge(4)",
		"Section Chief(5)",
		"Director Assistant(6)",
		"Director(7)"
	),
	array(
		"Driver(1)",
		"Bodyguard(2)",
		"",
		"",
		"",
		"",
		"Mayor(7)"
	),
	array(
		"Intern(1)",
		"Local Reporter(2)",
		"Local Editor(3)",
		"Network Anchor(4)",
		"Network Editor(5)",
		"Network Producer(6)",
		"Network Director(7)"
	),
	array(
		"Trainee(1)",
		"Taxi Rookie(2)",
		"Cabbie(3)",
		"Dispatcher(4)",
		"Shift Supervisor(5)",
		"Taxi Company Manager(6)",
		"Taxi Company Owner(7)"
	),
	array(
		"Trainee(1)",
		"Mechanic(2)",
		"Senior Mechanic(3)",
		"Supervisor(4)",
		"Manager(5)",
		"Under Boss(6)",
		"Tow Company Owner(7)"
	),
	array(
		"Freelancer(1)",
		"Marksman(2)",
		"Agent(3)",
		"Special Agent(4)",
		"Special Agent in Charge(5)",
		"Vice Director(6)",
		"Director(7)"
	),
	array(
		"Piccioto(1)",
		"Soldato(2)",
		"Sgarrista(3)",
		"Caporegime(4)",
		"Vicario(5)",
		"Consigliere(6)",
		"Don Green(7)"
	),
	array(
		"Piccioto(1)",
		"Soldato(2)",
		"Sgarrista(3)",
		"Caporegime(4)",
		"Vicario(5)",
		"Consigliere(6)",
		"Don Titan(7)"
	),
	array(
		"Piccioto(1)",
		"Soldato(2)",
		"Sgarrista(3)",
		"Caporegime(4)",
		"Vicario(5)",
		"Consigliere(6)",
		"Don Mexican(7)"
	),
	array(
		"Piccioto(1)",
		"Soldato(2)",
		"Sgarrista(3)",
		"Caporegime(4)",
		"Vicario(5)",
		"Consigliere(6)",
		"Don Rifa(7)"
	),
	array(
		"Private(1)",
		"Secound Lieutenant(2)",
		"First Lieutenant(3)",
		"Captain(4)",
		"Major(5)",
		"Colonel(6)",
		"General(7)"
	),
	array(
		"Candidate(1)",
		"Trainee(2)",
		"In Charge(3)",
		"Ambulance Commander(4)",
		"Field Chief(5)",
		"Chief Assistant(6)",
		"Chief(7)"
	),
	array(
		"Officer(1)",
		"Detective(2)",
		"Sergeant(3)",
		"Lieutenant(4)",
		"Captain(5)",
		"Chief Assistant(6)",
		"Chief(7)"
	),
	array(
		"Officer(1)",
		"Detective(2)",
		"Sergeant(3)",
		"Lieutenant(4)",
		"Captain(5)",
		"Chief Assistant(6)",
		"Chief(7)"
	)
);

global $alvls;
$alvls = array(
	"حامی مالی",
	"سرپرست",
	"مدیر اجرایی"
);

global $alvlC;
$alvlC = array(
	"66ffff",
	"3bb226",
	"FF0000"
);

global $reasontypes;
$reasontypes = array(
'نرم افزارهای تقلب',
'مودهای غیرمجاز',
'سوء استفاده از باگ',
'تبلیغات',
'کلاهبرداری و باج گیری',
'زبان ناپسند',
'اسپم',
'اخلاق خارج از زندگی',
'چت‌های عمومی',
'ایجاد مزاحمت، کلاهبرداری در مسابقات',
'سوء استفاده از دستورات',
'جعل مدارک',
'ایجاد مزاحمت در شغل‌ها',
'اشتباه تیم کارکنان'
);

global $factiontypes;
$factiontypes = array(
'در حال بررسی',
'رد شده',
'تائید شده / در انتظار تست',
'ناموفق در تست',
'دعوت شده'
);

global $namevehicles;
$namevehicles = array(
	400 => "Landstalker", 401 => "Bravura", 402 => "Buffalo", 403 => "Linerunner", 404 => "Perrenial", 405 => "Sentinel", 406 => "Dumper", 407 => "Firetruck",
	408 => "Trashmaster", 409 => "Stretch", 410 => "Manana", 411 => "Infernus", 412 => "Voodoo", 413 => "Pony", 414 => "Mule", 415 => "Cheetah", 
	416 => "Ambulance", 417 => "Leviathan", 418 => "Moonbeam", 419 => "Esperanto", 420 => "Taxi", 421 => "Washington", 422 => "Bobcat", 423 => "Whoopee",
	424 => "BFInjection", 425 => "Hunter", 426 => "Premier", 427 => "Enforcer", 428 => "Securicar", 429 => "Banshee", 430 => "Predator", 431 => "Bus", 
	432 => "Rhino", 433 => "Barracks", 434 => "Hotknife", 435 => "Trailer", 436 => "Previon", 437 => "Coach", 438 => "Cabbie", 439 => "Stallion", 
	440 => "Rumpo", 441 => "RCBandit", 442 => "Romero", 443 => "Packer", 444 => "Monster", 445 => "Admiral", 446 => "Squalo", 447 => "Seasparrow",
	448 => "Pizzaboy", 449 => "Tram", 450 => "Trailer", 451 => "Turismo", 452 => "Speeder", 453 => "Reefer", 454 => "Tropic", 455 => "Flatbed", 456 => "Yankee",
	457 => "Caddy", 458 => "Solair", 459 => "Berkley\'sRCVan", 460 => "Skimmer", 461 => "PCJ-600", 462 => "Faggio", 463 => "Freeway", 464 => "RCBaron", 
	465 => "RCRaider", 466 => "Glendale", 467 => "Oceanic", 468 => "Sanchez", 469 => "Sparrow", 470 => "Patriot", 471 => "Quad", 472 => "Coastguard", 
	473 => "Dinghy", 474 => "Hermes", 475 => "Sabre", 476 => "Rustler", 477 => "ZR-350", 478 => "Walton", 479 => "Regina", 480 => "Comet", 481 => "BMX",
	482 => "Burrito", 483 => "Camper", 484 => "Marquis", 485 => "Baggage", 486 => "Dozer", 487 => "Maverick", 488 => "NewsChopper", 489 => "Rancher",
	490 => "FBIRancher", 491 => "Virgo", 492 => "Greenwood", 493 => "Jetmax", 494 => "Hotring", 495 => "Sandking", 496 => "BlistaCompact", 
	497 => "PoliceMaverick", 498 => "Boxville", 499 => "Benson", 500 => "Mesa", 501 => "RCGoblin", 502 => "HotringRacerA", 503 => "HotringRacerB", 
	504 => "BloodringBanger", 505 => "Rancher", 506 => "SuperGT", 507 => "Elegant", 508 => "Journey", 509 => "Bike", 510 => "MountainBike",	511 => "Beagle",
	512 => "Cropduster", 513 => "Stunt", 514 => "Tanker", 515 => "Roadtrain", 516 => "Nebula", 517 => "Majestic", 518 => "Buccaneer", 519 => "Shamal",
	520 => "Hydra", 521 => "FCR-900", 522 => "NRG-500", 523 => "HPV1000", 524 => "CementTruck", 525 => "TowTruck", 526 => "Fortune", 527 => "Cadrona", 
	528 => "FBITruck",529 => "Willard", 530 => "Forklift", 531 => "Tractor", 532 => "Combine", 533 => "Feltzer", 534 => "Remington", 535 => "Slamvan", 
	536 => "Blade", 537 => "Freight",538 => "Streak", 539 => "Vortex", 540 => "Vincent", 541 => "Bullet", 542 => "Clover", 543 => "Sadler", 544 => "Firetruck",
	545 => "Hustler", 546 => "Intruder", 547 => "Primo", 548 => "Cargobob", 549 => "Tampa", 550 => "Sunrise", 551 => "Merit", 552 => "Utility", 553 => "Nevada",
	554 => "Yosemite", 555 => "Windsor", 556 => "Monster", 557 => "Monster", 558 => "Uranus", 559 => "Jester", 560 => "Sultan", 561 => "Stratium", 
	562 => "Elegy", 563 => "Raindance", 564 => "RCTiger", 565 => "Flash", 566 => "Tahoma", 567 => "Savanna", 568 => "Bandito", 569 => "FreightFlat", 
	570 => "StreakCarriage", 571 => "Kart", 572 => "Mower", 573 => "Dune", 574 => "Sweeper", 575 => "Broadway", 576 => "Tornado", 577 => "AT-400", 
	578 => "DFT-30", 579 => "Huntley", 580 => "Stafford", 581 => "BF-400", 582 => "NewsVan", 583 => "Tug", 584 => "Trailer", 585 => "Emperor", 586 => "Wayfarer",
	587 => "Euros", 588 => "Hotdog", 589 => "Club", 590 => "FreightBox", 591 => "Trailer", 592 => "Andromada", 593 => "Dodo", 594 => "RCCam", 595 => "Launch", 
	596 => "PoliceCar", 597 => "PoliceCar", 598 => "PoliceCar", 599 => "PoliceRanger", 600 => "Picador", 601 => "S.W.A.T", 602 => "Alpha", 603 => "Phoenix",
	604 => "Glendale", 605 => "Sadler", 606 => "Luggage", 607 => "Luggage", 608 => "Stairs", 609 => "Boxville", 610 => "Tiller", 611 => "UtilityTrailer"
);

global $vehColors;
$vehColors = array(
"000000","F5F5F5","2A77A1","840410","263739","86446E","D78E10","4C75B7","BDBEC6","5E7072",
"46597A","656A79","5D7E8D","58595A","D6DAD6","9CA1A3","335F3F","730E1A","7B0A2A","9F9D94",
"3B4E78","732E3E","691E3B","96918C","515459","3F3E45","A5A9A7","635C5A","3D4A68","979592",
"421F21","5F272B","8494AB","767B7C","646464","5A5752","252527","2D3A35","93A396","6D7A88",
"221918","6F675F","7C1C2A","5F0A15","193826","5D1B20","9D9872","7A7560","989586","ADB0B0",
"848988","304F45","4D6268","162248","272F4B","7D6256","9EA4AB","9C8D71","6D1822","4E6881",
"9C9C98","917347","661C26","949D9F","A4A7A5","8E8C46","341A1E","6A7A8C","AAAD8E","AB988F",
"851F2E","6F8297","585853","9AA790","601A23","20202C","A4A096","AA9D84","78222B","0E316D",
"722A3F","7B715E","741D28","1E2E32","4D322F","7C1B44","2E5B20","395A83","6D2837","A7A28F",
"AFB1B1","364155","6D6C6E","0F6A89","204B6B","2B3E57","9B9F9D","6C8495","4D8495","AE9B7F",
"406C8F","1F253B","AB9276","134573","96816C","64686A","105082","A19983","385694","525661",
"7F6956","8C929A","596E87","473532","44624F","730A27","223457","640D1B","A3ADC6","695853",
"9B8B80","620B1C","5B5D5E","624428","731827","1B376D","EC6AAE","000000",
// SA-MP extended colours (0.3x) 
"177517","210606","125478","452A0D","571E1E","010701","25225A","2C89AA","8A4DBD","35963A",
"B7B7B7","464C8D","84888C","817867","817A26","6A506F","583E6F","8CB972","824F78","6D276A",
"1E1D13","1E1306","1F2518","2C4531","1E4C99","2E5F43","1E9948","1E9999","999976","7C8499",
"992E1E","2C1E08","142407","993E4D","1E4C99","198181","1A292A","16616F","1B6687","6C3F99",
"481A0E","7A7399","746D99","53387E","222407","3E190C","46210E","991E1E","8D4C8D","805B80",
"7B3E7E","3C1737","733517","781818","83341A","8E2F1C","7E3E53","7C6D7C","020C02","072407",
"163012","16301B","642B4F","368452","999590","818D96","99991E","7F994C","839292","788222",
"2B3C99","3A3A0B","8A794E","0E1F49","15371C","15273A","375775","060820","071326","20394B",
"2C5089","15426C","103250","241663","692015","8C8D94","516013","090F02","8C573A","52888E",
"995C52","99581E","993A63","998F4E","99311E","0D1842","521E1E","42420D","4C991E","082A1D",
"96821D","197F19","3B141F","745217","893F8D","7E1A6C","0B370B","27450D","071F24","784573",
"8A653A","732617","319490","56941D","59163D","1B8A2F","38160B","041804","355D8E","2E3F5B",
"561A28","4E0E27","706C67","3B3E42","2E2D33","7B7E7D","4A4442","28344E"
);

function numberfa($string) {
    $persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    $num = range(0, 9);

    return str_replace($num, $persian, $string);
}


function number_formatfa($string) {
    $persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    $num = range(0, 9);

    return str_replace($num, $persian, @number_format($string));
}

function realPrice($price) {
	return ($price * .08);
}

$depName = array(
	'support' => "<span><i class='fa fa-handshake'></i> پشتیبانی</span>",
	'sale' => "<span><i class='fa fa-dollar-sign'></i> فروش</span>",
	'management' => "<span><i class='fa fa-user-secret'></i> مدیریت</span>",
	'sugs' => "<span><i class='fa fa-comments'></i> انتقادات و پیشنهادات</span>",
);

$tStatues = array(
	'<span class="label label-ar-new"> جدید </span>',
	'<span class="label label-ar-pending"> در انتظار بررسی </span>',
	'<span class="label label-ar-replied"> پاسخ‌داده شده </span>',
	'<span class="label label-ar-solved"> حل شده </span>',
	'<span class="label label-ar-closed"> بسته شده </span>',
);

$tPrios = array(
	'low' => 'کم',
	'normal' => 'متوسط',
	'high' => 'زیاد',
	'urgent' => 'فوری',
);

function totalDealer1($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `items` WHERE `type` = 1");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalDealer2($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `items` WHERE `type` = 2");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalDealer3($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `items` WHERE `type` = 3");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalDealer4($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `items` WHERE `type` = 4");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function minDealer1($con)
{
	$query = $con->prepare("SELECT MIN(`Price`) FROM `items` WHERE `type` = 1");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['MIN(`Price`)']);
}

function minDealer2($con)
{
	$query = $con->prepare("SELECT MIN(`Price`) FROM `items` WHERE `type` = 2");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['MIN(`Price`)']);
}

function minDealer3($con)
{
	$query = $con->prepare("SELECT MIN(`Price`) FROM `items` WHERE `type` = 3");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['MIN(`Price`)']);
}

function minDealer4($con)
{
	$query = $con->prepare("SELECT MIN(`Price`) FROM `items` WHERE `type` = 4");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['MIN(`Price`)']);
}

function newPlayers($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE -DATEDIFF(STR_TO_DATE(`RegisteredDate`, '%d/%m/%Y - %H:%i:%s'), CURDATE()) <= 7 AND `Registred` = 1;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalPlayers($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`), `MHoursPlayed` FROM `users` WHERE `MHoursPlayed` >= 1;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalTPlayers($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE `Registred` = 1");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalHours($con)
{
	$query = $con->prepare("SELECT SUM(`MHoursPlayed`) FROM `users`;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['SUM(`MHoursPlayed`)']);
}

function mostOnline($con)
{
	$query = $con->prepare("SELECT `Name`, `MHoursPlayed` FROM `users` ORDER BY `MHoursPlayed` DESC LIMIT 1;");
	$query->execute();
	$gData = $query->fetch();
	return $gData['Name'];
}

function totalOnline($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE `Status` != 0;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function newestPlayer($con)
{
	$query = $con->prepare("SELECT `Name`, `MHoursPlayed` FROM `users` WHERE `Registred` = 1 ORDER BY `ID` DESC LIMIT 1;");
	$query->execute();
	$gData = $query->fetch();
	return $gData['Name'];
}

function totalHouses($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `houses`;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalSkins($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `skins`;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalEvents($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `events` WHERE `StartTime` < CURRENT_TIMESTAMP() AND CURRENT_TIMESTAMP() < `EndTime`;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalClans($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `clans`;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalVehicles($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `cars`;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalBizes($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `business`;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalFactionOnline($con, $fID)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE `Status` != 0 AND (`Leader` + `Member` = {$fID});");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalFactionMembers($con, $fID)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE (`Leader` + `Member` = {$fID});");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalClanMembers($con, $cID)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE (`CLeader` + `CMember` = {$cID});");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function clanName($con, $cID)
{
	$query = $con->prepare("SELECT `Name` FROM `clans` WHERE (`ID` = '{$cID}');");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['Name']);
}

function totalAdmins($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE `AdminLevel` > 0 AND `AdminLevel` < 9;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalexAdmins($con)
{
	$query = $con->prepare("SELECT COUNT(users.ID) FROM `users`, `promotes` WHERE `AdminLevel` = 0 AND users.ID = promotes.Target AND `ActionDesc` = 0 AND `Action` = 1;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(users.ID)']);
}

function totalHelpers($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE `HelperLevel` > 0 AND `AdminLevel` = 0;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalexHelpers($con)
{
	$query = $con->prepare("SELECT COUNT(users.ID) FROM `users`, `promotes` WHERE `HelperLevel` = 0 AND users.ID = promotes.Target AND `ActionDesc` = 0 AND `Action` = 2;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(users.ID)']);
}

function totalexLeaders($con)
{
	$query = $con->prepare("SELECT COUNT(*) FROM(SELECT COUNT(*) FROM `users`, `promotes` WHERE `Leader` = 0 AND users.ID = promotes.Target AND `ActionDesc` = 0 AND `Action` = 3 GROUP BY users.ID) x");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(*)']);
}

function totalLeaders($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `users` WHERE `Leader` > 0 AND `AdminLevel` = 0;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalunAnsweredReports($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `reports` WHERE `Status` = 0;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function totalunAnsweredTickets($con)
{
	$query = $con->prepare("SELECT COUNT(`ID`) FROM `tickets` WHERE `Status` = 0;");
	$query->execute();
	$gData = $query->fetch();
	return ($gData['COUNT(`ID`)']);
}

function generalIDUrl($con, $name, $f, $fC, $fR)
{
	$query = $con->prepare("SELECT * FROM `users` WHERE `ID` = '{$name}' LIMIT 1;");
	$query->execute();
	while($dnn = $query->fetch()) {
		$clan = $dnn['CMember'] + $dnn['CLeader'];
		if($clan != 0)
		{
			$query2 = $con->prepare("SELECT * FROM `clans` WHERE `ID` = {$clan};");
			$query2->execute();
			$cnn = $query2->fetch();
		}
		?>
		<div class="tooltipstered" style="display: inline;" title="<table class=tooltipsterCustom>
			<tr>
				<td rowspan=8><img class=smallSkinImg src=/public/img/Skins/<?php echo $dnn['Skin'] ?>.png alt=Skin></td>
			</tr>

			<tr>
				<td colspan=2 class=centerAligned><img src=/public/img/<?php 
				if($dnn['Status'] == 0) echo "offline";
				else if($dnn['Status'] == 1) echo "online";
				else if($dnn['Status'] == 2) echo "afk";
				?>.png> <?php if($cnn['TagType'] == 1) { ?><span style=color:#<?php echo $cnn['Color']; ?> dir=ltr><?php echo $cnn['Tag'] ?></span><?php } ?><span style=color:#<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?> dir=ltr><?php echo $dnn['Name'] ?></span><?php if($cnn['TagType'] == 0) { ?><span style=color:#<?php echo $cnn['Color']; ?> dir=ltr><?php echo $cnn['Tag'] ?></span><?php } ?></td>
			</tr>
			<tr>
				<td class=leftAligned>سطح</td>
				<td class=rightAligned><?php echo $dnn['Level'] ?></td>
			</tr>
			<tr>
				<td class=leftAligned>امتیاز تجربه</td>
				<td class=rightAligned dir=ltr><?php echo $dnn['Respect'] ?> / <?php echo (($dnn['Level'] == 1) ? 2 : ($dnn['Level'] * 2) - 2); ?></td>
			</tr>
			<tr>
				<td class=leftAligned>رده بندی</td>
				<td class=rightAligned>--</td>
			</tr>
			<tr>
				<td class=leftAligned>اقلیت</td>
				<td class=rightAligned><font color=#<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?>><?php echo $f[($dnn['Member'] + $dnn['Leader'])] ?></font></td>
			</tr>
			<tr>
				<td class=leftAligned>درجه</td>
				<td class=rightAligned dir=ltr><?php echo ($dnn['Rank'] ? $fR[($dnn['Member'] + $dnn['Leader'])][$dnn['Rank'] - 1] : "هیچ") ?></td>
			</tr>
			<tr>
				<td colspan=2 class=centerAligned><?php if($dnn['AdminLevel'] != 0 && $dnn['AdminLevel'] < 9) { ?> <img src=/public/img/admin.png /><?php } ?><?php if($dnn['HelperLevel'] != 0) { ?> <img src=/public/img/helper.png /><?php } ?><?php if($dnn['Leader'] != 0) { ?> <img src=/public/img/leader.png /><?php } ?><?php if($dnn['CRank'] == 7) { ?> <img src=/public/img/clanOwner.png /><?php } ?> </td>
			</tr>
		</table>">
		<?php if($cnn['TagType'] == 0 && $dnn['CRank'] != 0) { ?>
		<span dir=ltr><a style="color: #<?php echo $cnn['Color']; ?>;"  href="/clans/view/<?php echo $cnn['Name'] ?>"><?php echo $cnn['Tag']; ?></a><a style="color: #<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?>;"  href="/players/general/<?php echo $dnn['Name'] ?>"><?php echo $dnn['Name']; ?></a></span>
		</div>
		<?php } else if($cnn['TagType'] == 1 && $dnn['CRank'] != 0) { ?>
		<span dir=ltr><a style="color: #<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?>;"  href="/players/general/<?php echo $dnn['Name'] ?>"><?php echo $dnn['Name']; ?></a><a style="color: #<?php echo $cnn['Color']; ?>;"  href="/clans/view/<?php echo $cnn['Name'] ?>"><?php echo $cnn['Tag']; ?></a></span>
		</div>
		<?php
		}
		else {
		?>
		<span dir=ltr><a style="color: #<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?>;"  href="/players/general/<?php echo $dnn['Name'] ?>"><?php echo $dnn['Name']; ?></a></span>
		</div>
		<?php }
	}
}

function generalUserUrl($con, $name, $f, $fC, $fR)
{
	$query = $con->prepare("SELECT * FROM `users` WHERE `Name` = '{$name}' LIMIT 1;");
	$query->execute();
	while($dnn = $query->fetch()) {
		$clan = $dnn['CMember'] + $dnn['CLeader'];
		if($clan != 0)
		{
			$query2 = $con->prepare("SELECT * FROM `clans` WHERE `ID` = {$clan};");
			$query2->execute();
			$cnn = $query2->fetch();
		}
		?>
		<div class="tooltipstered" style="display: inline;" title="<table class=tooltipsterCustom>
			<tr>
				<td rowspan=8><img class=smallSkinImg src=/public/img/Skins/<?php echo $dnn['Skin'] ?>.png alt=Skin></td>
			</tr>

			<tr>
				<td colspan=2 class=centerAligned><img src=/public/img/<?php 
				if($dnn['Status'] == 0) echo "offline";
				else if($dnn['Status'] == 1) echo "online";
				else if($dnn['Status'] == 2) echo "afk";
				?>.png> <?php if($cnn['TagType'] == 1) { ?><span style=color:#<?php echo $cnn['Color']; ?> dir=ltr><?php echo $cnn['Tag'] ?></span><?php } ?><span style=color:#<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?> dir=ltr><?php echo $dnn['Name'] ?></span><?php if($cnn['TagType'] == 0) { ?><span style=color:#<?php echo $cnn['Color']; ?> dir=ltr><?php echo $cnn['Tag'] ?></span><?php } ?></td>
			</tr>
			<tr>
				<td class=leftAligned>سطح</td>
				<td class=rightAligned><?php echo $dnn['Level'] ?></td>
			</tr>
			<tr>
				<td class=leftAligned>امتیاز تجربه</td>
				<td class=rightAligned dir=ltr><?php echo $dnn['Respect'] ?> / <?php echo (($dnn['Level'] == 1) ? 2 : ($dnn['Level'] * 2) - 2); ?></td>
			</tr>
			<tr>
				<td class=leftAligned>رده بندی</td>
				<td class=rightAligned>--</td>
			</tr>
			<tr>
				<td class=leftAligned>اقلیت</td>
				<td class=rightAligned><font color=#<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?>><?php echo $f[($dnn['Member'] + $dnn['Leader'])] ?></font></td>
			</tr>
			<tr>
				<td class=leftAligned>درجه</td>
				<td class=rightAligned dir=ltr><?php echo ($dnn['Rank'] ? $fR[($dnn['Member'] + $dnn['Leader'])][$dnn['Rank'] - 1] : "هیچ") ?></td>
			</tr>
			<tr>
				<td colspan=2 class=centerAligned><?php if($dnn['AdminLevel'] != 0 && $dnn['AdminLevel'] < 9) { ?> <img src=/public/img/admin.png /><?php } ?><?php if($dnn['HelperLevel'] != 0) { ?> <img src=/public/img/helper.png /><?php } ?><?php if($dnn['Leader'] != 0) { ?> <img src=/public/img/leader.png /><?php } ?><?php if($dnn['CRank'] == 7) { ?> <img src=/public/img/clanOwner.png /><?php } ?> </td>
			</tr>
		</table>">
		<?php if($cnn['TagType'] == 0 && $dnn['CRank'] != 0) { ?>
		<span dir=ltr><a style="color: #<?php echo $cnn['Color']; ?>;"  href="/clans/view/<?php echo $cnn['Name'] ?>"><?php echo $cnn['Tag']; ?></a><a style="color: #<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?>;"  href="/players/general/<?php echo $dnn['Name'] ?>"><?php echo $dnn['Name']; ?></a></span>
		</div>
		<?php } else if($cnn['TagType'] == 1 && $dnn['CRank'] != 0) { ?>
		<span dir=ltr><a style="color: #<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?>;"  href="/players/general/<?php echo $dnn['Name'] ?>"><?php echo $dnn['Name']; ?></a><a style="color: #<?php echo $cnn['Color']; ?>;"  href="/clans/view/<?php echo $cnn['Name'] ?>"><?php echo $cnn['Tag']; ?></a></span>
		</div>
		<?php
		}
		else {
		?>
		<span dir=ltr><a style="color: #<?php echo $fC[($dnn['Member'] + $dnn['Leader'])]; ?>;"  href="/players/general/<?php echo $dnn['Name'] ?>"><?php echo $dnn['Name']; ?></a></span>
		</div>
		<?php }
	}
}
?>