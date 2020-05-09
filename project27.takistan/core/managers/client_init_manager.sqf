/*
	written by eugene27.
	only client
	1.3.0
*/

// local fnc
pgn_fnc_set_textures = {
	params [
		"_textures_array"
	];
	for [{private _i = 0 }, { _i < (count _textures_array) }, { _i = _i + 1 }] do {
		{
			_x setObjectTexture [0, "img\" + ((_textures_array select _i) select 0)]
		} forEach ((_textures_array select _i) select 1);
	};
};

// Initializes the player/client side Dynamic Groups framework
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; 

// print version on screen
[] spawn {
	disableSerialization;
	waitUntil{ !isNull (findDisplay 46) };
	private _ctrlText = (findDisplay 46) ctrlCreate ["RscStructuredText",-1];
	private _text = "<t font='PuristaMedium' align='right' size='0.75' shadow='0'><br /><br /><br /><br />1.3.0.1 | PROJECT 27</t>";
	_ctrlText ctrlSetStructuredText parseText _text;
	_ctrlText ctrlSetTextColor [1,1,1,0.7];
	_ctrlText ctrlSetBackgroundColor [0,0,0,0];
	_ctrlText ctrlSetPosition [
		(safezoneW - 22 * (((safezoneW / safezoneH) min 1.2) / 40)) + (safeZoneX)
		,(safezoneH - 5.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + (safeZoneY)
		,20 * (((safezoneW / safezoneH) min 1.2) / 40)
		,5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
	];
	_ctrlText ctrlSetFade 0.5;
	_ctrlText ctrlCommit 0;
	true;
};

// start screen
private _start_screen = [
	position spawn_zone_blue, 
	"WELCOME TO PROJECT 27", 
	50, 
	80, 
	0, 
	0, 
	[
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa",[0,0.35,1,1],tr_treatment_blue,1,1,0,"treatment"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",[0,0.35,1,1],tr_g_service_blue,1,1,0,"repair/rearm"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",[0,0.35,1,1],tr_a_service_blue,1,1,0,"repair/rearm"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa",[0,0.35,1,1],arsenal_blue,1,1,0,"arsenal"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa",[0,0.35,1,1],inf_teleport_monitor_blue,1,1,0,"teleport"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa",[0,0.35,1,1],laptop_hq,1,1,0,"HQ"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",[0,0.35,1,1],g_garage_monitor_blue,1,1,0,"ground garage"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\heli_ca.paa",[0,0.35,1,1],a_garage_monitor_blue,1,1,0,"air garage"]
	], 
	0, 
	true, 
	20
] spawn BIS_fnc_establishingShot;

waitUntil {scriptDone _start_screen};

// EH with death screen
player addEventHandler ["Killed", {
	private _quotations = ["A_hub_quotation","A_in_quotation","A_in2_quotation","A_m01_quotation","A_m02_quotation","A_m03_quotation","A_m04_quotation","A_m05_quotation","A_out_quotation","B_Hub01_quotation","B_in_quotation","B_m01_quotation","B_m02_1_quotation","B_m03_quotation","B_m05_quotation","B_m06_quotation","B_out2_quotation","C_EA_quotation","C_EB_quotation","C_in2_quotation","C_m01_quotation","C_m02_quotation","C_out1_quotation"];
	["A3\missions_f_epa\video\" + selectRandom _quotations + ".ogv"] spawn BIS_fnc_playVideo;
}];

player setPos getMarkerPos "respawn_west";

// set variables
[
	[
		["player",["money",0,true]],
		["player",["enemy_killings",0,true]],
		["player",["friend_killings",0,true]],
		["player",["civ_killings",0,true]]
	]
] call prj_fnc_set_variables;

// set textures
[
	[
		["vservice.paa",[service_board_blue,service_board_red]],
		["inftp.paa",[inf_teleport_monitor_blue,inf_teleport_monitor_red]],
		["landv.paa",[g_garage_monitor_red,g_garage_monitor_blue]],
		["airv.paa",[a_garage_monitor_red,a_garage_monitor_blue]]
	]
] call pgn_fnc_set_textures;


// actions manager
private ["_action"];

g_garage_monitor_red addAction ["Land vehicle", { [true,g_garage_depot_red] call prj_fnc_vehicle_shop_window }];
g_garage_monitor_blue addAction ["Land vehicle", { [true,g_garage_depot_blue] call prj_fnc_vehicle_shop_window }];
a_garage_monitor_red addAction ["Air vehicle", { [false,a_garage_depot_red] call prj_fnc_vehicle_shop_window }];
a_garage_monitor_blue addAction ["Air vehicle", { [false,a_garage_depot_blue] call prj_fnc_vehicle_shop_window }];
laptop_hq addAction ["HQ menu", { call prj_fnc_hq_menu }];

if (!isNil "mhqterminal") then {call prj_fnc_add_mhq_action};

if ((getPlayerUID player) in hqUID || player getVariable ["officer",false]) then {
	_action = [
		"hq_menu",
		"HQ",
		"\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa",
		{},
		{}
	] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = [
		"cancel_task",
		"Cancel task",
		"\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa",
		{[player call BIS_fnc_taskCurrent] remoteExecCall ["prj_fnc_cancel_task",2]},
		{true}
	] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions", "hq_menu"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = [
		"task_request",
		"Task request",
		"\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa",
		{remoteExecCall ["prj_fnc_create_task",2]},
		{true}
	] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions", "hq_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
};

_action = ["Civil_Orders", "Civil Orders", "\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Stop", "STOP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk4_ca.paa", {
	player playActionNow "gestureFreeze";
	[1,position player] remoteExecCall ["prj_fnc_civ_orders", 2];
}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Get_down", "DOWN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk3_ca.paa", {
	player playActionNow "gestureCover";
	[2,position player] remoteExecCall ["prj_fnc_civ_orders", 2];
}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Go_away", "GO AWAY", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk2_ca.paa", {
	player playActionNow "gestureGo";
	[3,position player] remoteExecCall ["prj_fnc_civ_orders", 2];
}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Hands_Up", "HANDS UP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk1_ca.paa", {
	player playActionNow "gestureFreeze";
	[4,position player] remoteExecCall ["prj_fnc_civ_orders", 2];
}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

{
	_action = ["Civil_Go_Away", "GO AWAY", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk4_ca.paa", 
	{
		player playActionNow "gestureGo";
		if ((animationState (_this select 0)) == "amovpercmstpssurwnondnon") then {
			[_this select 0, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
		};
		(_this select 0) setUnitPos "UP";
		(group (_this select 0)) setSpeedMode "FULL";
		[_this select 0] call ace_interaction_fnc_sendAway;
	}, 
	{
		alive (_this select 0) && {[(_this select 0)] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
	}] call ace_interact_menu_fnc_createAction;
	[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

	_action = ["Civil_Down", "DOWN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk3_ca.paa", 
	{
		player playActionNow "gestureCover";
		if ((animationState (_this select 0)) == "amovpercmstpssurwnondnon") then {
			[_this select 0, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
		};
		doStop (_this select 0);
		(_this select 0) setUnitPos "DOWN";
	}, 
	{
		alive (_this select 0) && {[_this select 0] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
	}] call ace_interact_menu_fnc_createAction;
	[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

	_action = ["Civil_Hands_Up", "HANDS UP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk2_ca.paa", 
	{
		player playActionNow "gestureFreeze";
		(_this select 0) setUnitPos "UP";
		doStop (_this select 0);
		[_this select 0, "AmovPercMstpSsurWnonDnon"] remoteExec ["playMove", 0];
	}, 
	{
		alive (_this select 0) && {[_this select 0] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
	}] call ace_interact_menu_fnc_createAction;
	[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

	_action = ["Civil_Stop", "STOP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk1_ca.paa", 
	{
		player playActionNow "gestureFreeze";
		doStop (_this select 0);
	}, 
	{
		alive (_this select 0) && {[_this select 0] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
	}] call ace_interact_menu_fnc_createAction;
	[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

	_action = ["Ask_Info", "ASK INFO", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", 
	{
		[position (_this select 0),_this select 0] call prj_fnc_civ_info;
	}, 
	{
		alive (_this select 0) && {[_this select 0] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
	}] call ace_interact_menu_fnc_createAction;
	[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

	//remove ace3 "get down" order
	[_x, 0, ["ACE_MainActions", "ACE_GetDown"]] call ace_interact_menu_fnc_removeActionFromClass;
	//remove ace3 "go away" order
	[_x, 0, ["ACE_MainActions", "ACE_SendAway"]] call ace_interact_menu_fnc_removeActionFromClass;

} forEach civilian_units;

// ARSENAL
{
	[_x, arsenal_black_list] call ace_arsenal_fnc_removeVirtualItems;
} forEach [arsenal_blue,arsenal_red];

sleep 10;

[[player call BIS_fnc_locationDescription,2,2],[getText(configFile >> "CfgWorlds" >> worldName >> "description"),2,2],[[daytime, "HH:MM"] call BIS_fnc_timeToString,2,2,5]] spawn BIS_fnc_EXP_camp_SITREP;

sleep 17;
[parseText "<t font='PuristaBold' size='1.6'>PROJECT 27</t><br />by eugene27", true, nil, 10, 2, 0] spawn BIS_fnc_textTiles;