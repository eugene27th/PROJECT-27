/*
	written by eugene27.
	only client
*/

// local fnc
prj_fnc_set_textures = {
	params [
		"_textures_array"
	];
	for [{private _i = 0 }, { _i < (count _textures_array) }, { _i = _i + 1 }] do {
		{
			_x setObjectTexture [(_textures_array # _i) # 2, "img\" + ((_textures_array # _i) # 0)]
		} forEach ((_textures_array # _i) # 1);
	};
};

// Initializes the player/client side Dynamic Groups framework
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

// print version on screen
[] spawn {
	disableSerialization;
	waitUntil{ !isNull (findDisplay 46) };
	private _ctrlText = (findDisplay 46) ctrlCreate ["RscStructuredText",-1];
	private _text = "<t font='PuristaMedium' align='right' size='0.75' shadow='0'><br /><br /><br /><br />1.4.0 TEST | PROJECT 27</t>";
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

player createDiaryRecord ["Diary", [localize "STR_A3_FM_Welcome4","<br/><br/><font color='#33FF9C' size='16'>PROJECT27 1.3.0.5</font><br/><font color='#33FFF9'>https://github.com/eugene27r/PROJECT-27</font<br/><br/><br/>If you want to help with translation, write to:<br/><font color='#51C1E5'>discord - eugene27#2931</font><br/><font color='#51C1E5'>email - evgen.monreal@gmail.com</font><br/><br/>Report a problem:<br/><font color='#51C1E5'>https://github.com/eugene27r/PROJECT-27/issues</font>"], taskNull, "", false];

private _doc_start = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_START_TITLE", localize "STR_DOCUMENTATION_START_DESC"], taskNull, "", false];

//start screen
playMusic "start_music_1";
private _start_screen = [
	position spawn_zone, 
	"WELCOME TO PROJECT 27", 
	50, 
	80, 
	0, 
	0, 
	[
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa",[0,0.35,1,1],tr_treatment,1,1,0,"treatment"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",[0,0.35,1,1],tr_g_service,1,1,0,"repair/rearm"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",[0,0.35,1,1],tr_a_service,1,1,0,"repair/rearm"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa",[0,0.35,1,1],arsenal,1,1,0,"arsenal"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa",[0,0.35,1,1],laptop_hq,1,1,0,"HQ"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",[0,0.35,1,1],tr_g_shop,1,1,0,"ground garage"],
		["\A3\ui_f\data\igui\cfg\simpleTasks\types\heli_ca.paa",[0,0.35,1,1],tr_a_shop,1,1,0,"air garage"]
	], 
	0, 
	true, 
	45
] spawn BIS_fnc_establishingShot;

waitUntil {scriptDone _start_screen};
playMusic "";

//briefing
player removeDiaryRecord ["Diary", _doc_start];

prj_fnc_ProcessDiaryLink = {
    processDiaryLink createDiaryLink ["Diary", _this, ""];
};

doc_enemy = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_ENEMY_TITLE", localize "STR_DOCUMENTATION_ENEMY_DESC"], taskNull, "", false];

doc_talkorder = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_TALKANDORDER_TITLE", localize "STR_DOCUMENTATION_TALKANDORDER_DESC"], taskNull, "", false];

doc_tasks = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_TASKS_TITLE", localize "STR_DOCUMENTATION_TASKS_DESC"], taskNull, "", false];

doc_vehshop = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_VEHSHOP_TITLE", localize "STR_DOCUMENTATION_VEHSHOP_DESC"], taskNull, "", false];

doc_intel = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_INTEL_TITLE", localize "STR_DOCUMENTATION_INTEL_DESC"], taskNull, "", false];

doc_bank = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_BANK_TITLE", localize "STR_DOCUMENTATION_BANK_DESC"], taskNull, "", false];

doc_mhq = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_MHQ_TITLE", localize "STR_DOCUMENTATION_MHQ_DESC"], taskNull, "", false];

doc_stat = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_STAT_TITLE", localize "STR_DOCUMENTATION_STAT_DESC"], taskNull, "", false];

doc_laptop = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_LAPTOP_TITLE", localize "STR_DOCUMENTATION_LAPTOP_DESC"], taskNull, "", false];

doc_vehicle = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_VEHICLES_TITLE", localize "STR_DOCUMENTATION_VEHICLES_DESC"], taskNull, "", false];

doc_basics = player createDiaryRecord ["Diary", [localize "STR_DOCUMENTATION_BASICS_TITLE", localize "STR_DOCUMENTATION_BASICS_DESC"], taskNull, "", false];

// EH with death screen
player addEventHandler ["Killed", {
	private _quotations = ["A_hub_quotation","A_in_quotation","A_in2_quotation","A_m01_quotation","A_m02_quotation","A_m03_quotation","A_m04_quotation","A_m05_quotation","A_out_quotation","B_Hub01_quotation","B_in_quotation","B_m01_quotation","B_m02_1_quotation","B_m03_quotation","B_m05_quotation","B_m06_quotation","B_out2_quotation","C_EA_quotation","C_EB_quotation","C_in2_quotation","C_m01_quotation","C_m02_quotation","C_out1_quotation"];
	["A3\missions_f_epa\video\" + selectRandom _quotations + ".ogv"] spawn BIS_fnc_playVideo;
}];

player setPos getMarkerPos "respawn_west";

// set variables
private _player_points = "player_point_value_on_start" call BIS_fnc_getParamValue;
if (isNil "_player_points") then {_player_points = 1000};

[
	[
		[
			"missionNamespace",
			[
				getPlayerUID player,
				[
					["money",_player_points],
					["enemy_killings",0],
					["friend_killings",0],
					["civ_killings",0]
				],
				true
			],
			false
		]
	]
] call prj_fnc_set_variables;

// set textures
[
	[
		["vservice.paa",[service_board_blue],0],
		["laptopHQ.paa",[laptop_hq],1],
		["infoDisplay.paa",[infoDisplay],0]
	]
] call prj_fnc_set_textures;

//transformation intels to inter score
office_table addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];
	
	private _intel_objects = [
		["acex_intelitems_photo",30],
		["acex_intelitems_document",25],
		["ACE_Cellphone",10],
		["acex_intelitems_notepad",10]
	];

	private _office_table_items = [((getItemCargo office_table) # 0) + ((getMagazineCargo office_table) # 0),((getItemCargo office_table) # 1) + ((getMagazineCargo office_table) # 1)];

	clearItemCargoGlobal office_table;
	clearMagazineCargoGlobal office_table;
	clearWeaponCargoGlobal office_table;
	clearBackpackCargoGlobal office_table;

	{	
		private _finded = false;
		for [{private _i = 0 }, { _i < (count _intel_objects) }, { _i = _i + 1 }] do {

			private _intel_object = ((_intel_objects # _i) # 0);
			private _intel_object_coast = ((_intel_objects # _i) # 1);
			
			if (_x isEqualTo _intel_object) then {
				private _intel_coast = ((_office_table_items # 1) # _forEachIndex) * _intel_object_coast;
				private _value = (missionNamespace getVariable "intel_score") + _intel_coast;
				missionNamespace setVariable ["intel_score",_value,true];
				if (prj_debug) then {
					systemChat format ["найдено совпадение %1 и %2. начислено %3 очков",_x,_intel_object,_intel_coast]
				};
				_finded = true;
			};
		};

		if (!_finded) then {
			office_table addItemCargoGlobal [_x, ((_office_table_items # 1) # _forEachIndex)];
			if (prj_debug) then {
				systemChat format ["для %1 не найдено совпадений. вернуто в кол-ве %3",_x,((_office_table_items # 1) # _forEachIndex)]
			};
		};

	} forEach (_office_table_items # 0);
}];

// actions
laptop_hq addAction ["HQ menu", { call prj_fnc_hq_menu }];

if (!isNil "mhqterminal") then {call prj_fnc_add_mhq_action};

private "_action";
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
[arsenal, arsenal_black_list] call ace_arsenal_fnc_removeVirtualItems;

//check machine translate language
private _languages = ["Russian"];
private _MTlanguages = ["English"];

if (language in _MTlanguages) then {
	hintC format ["Hello. Machine translation applied for %1. If you want to help with translation, write to: discord - eugene27#2931 or email - evgen.monreal@gmail.com",language];
	hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
		0 = _this spawn {
			_this select 0 displayRemoveEventHandler ["unload", hintC_EH];
			hintSilent "";
		};
	}];
};

if !(language in (_MTlanguages + _languages)) then {
	hintC format ["Hello. Your language is not supported. The default is English"];
	hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
		0 = _this spawn {
			_this select 0 displayRemoveEventHandler ["unload", hintC_EH];
			hintSilent "";
		};
	}];
};

//sitrep, texttiles
uiSleep 10;
[[toUpper (player call BIS_fnc_locationDescription),2,2],[toUpper (getText(configFile >> "CfgWorlds" >> worldName >> "description")),2,2],[[daytime, "HH:MM"] call BIS_fnc_timeToString,2,2,5]] spawn BIS_fnc_EXP_camp_SITREP;
uiSleep 17;
[parseText "<t font='PuristaBold' size='1.6'>PROJECT 27</t><br />by eugene27", true, nil, 10, 2, 0] spawn BIS_fnc_textTiles;