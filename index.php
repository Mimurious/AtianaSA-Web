<?php
	if(!isset($_SESSION)) session_start();

	require('includes/config.inc.php');
	require('includes/functions.inc.php');

	global $action;
	require('templates/header.tpl');

	$validactions = array (
		'error404',
		
		'serverRules',

		'playersOnline',
		'playersSearch',
		'playersGeneral',
		'playersFriends',
		'playersJob',
		'playersaddReport',
		'playersReport',
		'playersReports',
		'playersFaction',

		'staffAdmins',
		'staffHelpers',
		'staffLeaders',
		'staffexAdmins',
		'staffexHelpers',
		'staffexLeaders',

		'factions',
		'factionsView',
		'factionsMembers',
		'factionsApply',
		'factionsApp',
		'factionsApps',
		'peacefulRules',
		'gangRules',
		'departmentRules',
		'mixtRules',
		
		'clans',
		'clansView',
		'clansMembers',
		
		'shopVehicles',
		'shopVehiclesCars',
		'shopVehiclesBikes',
		'shopVehiclesBoats',
		'shopVehiclesPlanes',
		'shopAddCart',
		'shopCart',
		'shopDelete',
		'shopEdit',
		'shopRealPay',

		'updatesServer',
		'updatesWebsite',

		'accountLogin',
		'accountRegister',
		'accountrecoverPassword',
		'accountrecoverAccount',
		'accountGeneral',
		'accountJob',
		'accountFriends',
		'accountVerify',
		'accountFaction',
		'accountSecurity',
		'accountReferrals',
		
		'eventsList',
		'eventsInfo',
		
		'adminGeneral',
		'adminEdit',
		'adminAdd',
		'adminLoginAs',
		'adminVerify',
		'adminUsers',
		'adminTickets',
		'adminViewTicket',
		
		'warsTurfs',
		'warsZone',
		
		'supportGeneral',
		'supportNew',
		'supportView',
	);

	if(in_array($action, $validactions)) include_once("templates/{$action}.tpl");
	else include_once('templates/mainpage.tpl');

	require_once('templates/footer.tpl');
?>