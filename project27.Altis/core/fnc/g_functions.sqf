/*
	written by eugene27.
	global functions
*/

prj_fnc_set_textures = {
	params ["_textures_array"];
	
	for [{private _i = 0 }, { _i < (count _textures_array) }, { _i = _i + 1 }] do {
		{
			_x setObjectTexture [(_textures_array # _i) # 2, "img\" + ((_textures_array # _i) # 0)]
		} forEach ((_textures_array # _i) # 1);
	};
};

prj_fnc_changePlayerVariableLocal = {
	params ["_space","_name","_number", "_value",["_UID",(getPlayerUID player)]];

	private _variable = ((missionNamespace getVariable _UID) select _number) select 1;
	private _player_table = missionNamespace getVariable _UID;
	_player_table set [_number,[_name,_variable + _value]];
	(call (compile _space)) setVariable [_UID, _player_table, true];

	if (prj_debug) then {[format ["%1 changed to: %2",_UID,_player_table]] remoteExec ["systemChat"]};
};

prj_fnc_set_variables = {
	params ["_data"];

	for [{private _i = 0 }, { _i < (count _data) }, { _i = _i + 1 }] do {

		private _overwritting = ((_data # _i) # 2);
		
		private _variable = (call (compile ((_data # _i) # 0))) getVariable (((_data # _i) # 1) # 0);

		if (_overwritting) then {
			(call (compile ((_data # _i) # 0))) setVariable ((_data # _i) # 1);
			if (prj_debug) then {systemChat "таблица перезаписана"};
		} else {
			if (isNil "_variable") then {
				(call (compile ((_data # _i) # 0))) setVariable ((_data # _i) # 1);
				if (prj_debug) then {
					systemChat "таблица была пуста. записана новая таблица";
					systemChat format ["%1",((_data # _i) # 1)];
				};
			} else {
				if (prj_debug) then {
					systemChat "таблица уже существует. новая таблица не записана";
				};
			};
		};
	};
};

prj_fnc_add_mhq_action = {
	private _actiondeploy = [
		"a_hq_terminal_deploy",
		"Deploy MHQ",
		"\A3\Ui_f\data\Map\Markers\NATO\b_hq.paa",
		{
			([mhqterminal,3] call BIS_fnc_dataTerminalAnimate);
			([mhqterminal, -1] call ace_cargo_fnc_setSize);
			([mhqterminal, false, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable)
		},
		{true}
	] call ace_interact_menu_fnc_createAction;

	[mhqterminal, 0, ["ACE_MainActions"], _actiondeploy] call ace_interact_menu_fnc_addActionToObject;

	private _actionundeploy = [
		"a_hq_terminal_undeploy",
		"Undeploy MHQ",
		"\A3\Ui_f\data\Map\Markers\NATO\b_hq.paa",
		{
			([mhqterminal,0] call BIS_fnc_dataTerminalAnimate);
			([mhqterminal, 3] call ace_cargo_fnc_setSize);
			([mhqterminal, true, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable)
		},
		{true}
	] call ace_interact_menu_fnc_createAction;

	[mhqterminal, 0, ["ACE_MainActions"], _actionundeploy] call ace_interact_menu_fnc_addActionToObject;
};

prj_fnc_create_task = {
	private _taskID = missionNamespace getVariable ["taskID",0];
	private _oldTaskName = missionNamespace getVariable ["oldTaskName","side_null"];
	private _selected_task = selectRandom tasksConfig;

	while {(_selected_task # 0) == _oldTaskName} do {_selected_task = selectRandom tasksConfig};
	[_taskID,(_selected_task # 1)] execVM "core\tasks\side\" + (_selected_task # 0) + ".sqf";

	missionNamespace setVariable ["taskID",_taskID + 1,true];
	private _oldTaskName = missionNamespace setVariable ["oldTaskName",_selected_task # 0,true];

	if (prj_debug) then {
		systemChat format ["id: %1 | task: %2 | reward: %3",_taskID,_selected_task # 0,_selected_task # 1];
	};
};

prj_fnc_cancel_task = {
	params ["_task"];

	if (_task isEqualTo "") exitWith {hint localize "STR_PRJ_SELECT_TASK_ON_MAP"};

	private "_task";

	private _subTasks = _task call BIS_fnc_taskChildren;
	if (_subTasks isEqualTo []) then {
		private _taskParent = _task call BIS_fnc_taskParent;
		if !(_taskParent isEqualTo "") then {
			_task = _taskParent;
			_subTasks = _task call BIS_fnc_taskChildren;
		};
	};

	([_task] + _subTasks) apply {
		if !(_x call BIS_fnc_taskCompleted) then {
			[_x, "CANCELED"] call BIS_fnc_taskSetState
		} else {
			false
		};
	};
};

prj_fnc_request_supply_drop = {
	params ["_position"];

	if (missionNamespace getVariable ["supply_waiting",false]) exitWith {
		["HQ",localize "STR_PRJ_SUPPLY_REQUEST_DENIED"] remoteExec ["BIS_fnc_showSubtitle",0];
	};

	private _check_zone = (position arsenal) nearObjects ["Thing", 100];

	private ["_box","_arrow"];

	{
		if (typeOf _x == supply_box) exitWith {
			_x allowDamage false;
			_box = _x;
			private _pos = position _x;
			_arrow = createVehicle ["Sign_Arrow_Yellow_F", _pos, [], 0, "CAN_COLLIDE"];
			_arrow attachTo [_box, [0, 0, + 1]];
			_x enableSimulationGlobal false;
			_x lock true;
		};
	} forEach _check_zone;

	if (isNil "_box") exitWith {localize "STR_PRJ_BOX_NOT_FOUND" remoteExec ["systemChat",0]};

	[_box,_position,_arrow] spawn {
		params ["_box","_position","_arrow"];

		missionNamespace setVariable ["supply_waiting",true,true];

		private _wait_time = [140,300] call BIS_fnc_randomInt;
		["HQ",format [localize "STR_PRJ_BOX_SENDED",mapGridPosition _position,_wait_time]] remoteExec ["BIS_fnc_showSubtitle",0];

		uiSleep _wait_time;
		deleteVehicle _arrow;

		if (isNull _box) exitWith {missionNamespace setVariable ["supply_waiting",false,true]};

		_box enableSimulationGlobal true;
		uiSleep 1;
		_position set [2, 500];

		private _parachute = "B_parachute_02_F" createVehicle _position;
		_parachute setPos _position;
		_box attachTo [_parachute, [0, 0, 0]];

		["HQ",format [localize "STR_PRJ_BOX_DROPPED",mapGridPosition _position,_wait_time]] remoteExec ["BIS_fnc_showSubtitle",0];

		waitUntil {!alive _box || (position _box # 2) < 3};

		missionNamespace setVariable ["supply_waiting",false,true];
		if (isNull _box) exitWith {deleteVehicle _parachute};

		private _smoke = "SmokeShellOrange" createVehicle (position _box);
		_smoke attachTo [_box, [0, 0, 0]];

		detach _box;
		_box lock false;
		_box allowDamage true;
		uiSleep 30;
		{deleteVehicle _x} forEach [_smoke,_parachute];
	};
};

prj_fnc_civ_orders = {
	params ["_order","_position"];

	private _list = _position nearEntities [["Man"], 60];
	private _units = _list select {!(_x isEqualTo player) && ((side _x) isEqualTo civilian)};

	if (_units isEqualTo []) exitWith {true};
	{
		for "_i" from (count waypoints (group _x)) - 1 to 0 step -1 do {
			deleteWaypoint [group _x, _i];
		};
		(group _x) setBehaviour "CARELESS";
		switch (_order) do {
			case 1 : {
				doStop _x;
			};
			case 2 : {
				if ((animationState _x) == "amovpercmstpssurwnondnon") then {
					[_x, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
				};
				doStop _x;
				_x setUnitPos "DOWN";
			};
			case 3 : {
				if ((animationState _x) == "amovpercmstpssurwnondnon") then {
					[_x, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
				};
				_x setUnitPos "UP";
				(group _x) setSpeedMode "FULL";
				[_x] call ace_interaction_fnc_sendAway;
			};
			case 4 : {
				_x setUnitPos "UP";
				doStop _x;
				[_x, "AmovPercMstpSsurWnonDnon"] remoteExec ["playMove", 0];
			};
		};
	} forEach _units;
};

prj_fnc_near_pos_array = {
	params ["_pos","_pos_array","_distance"];

	if (_pos_array isEqualTo []) exitWith {[]};

	private _near_pos_array = [];
	{
		if ((_x distance _pos) < _distance) then {_near_pos_array pushBack _x};
	} forEach _pos_array;

	_near_pos_array
};

prj_fnc_localize_info = {
	params ["_pos","_pos_array",["_random",300]];

	private _selected_pos = selectRandom _pos_array;
	private _distance = (_pos distance _selected_pos) + (round (random _random)) - (round (random _random));
	private _dir = _pos getDir _selected_pos;
	private "_localize_dir";
	switch (true) do {
		case (_dir > 345 && _dir <= 15) : {_localize_dir = localize "STR_PRJ_SIDE_WORLD_N"};
		case (_dir > 15 && _dir <= 75) : {_localize_dir = localize "STR_PRJ_SIDE_WORLD_NE"};
		case (_dir > 75 && _dir <= 105) : {_localize_dir = localize "STR_PRJ_SIDE_WORLD_E"};
		case (_dir > 105 && _dir <= 165) : {_localize_dir = localize "STR_PRJ_SIDE_WORLD_SE"};
		case (_dir > 165 && _dir <= 195) : {_localize_dir = localize "STR_PRJ_SIDE_WORLD_S"};
		case (_dir > 195 && _dir <= 255) : {_localize_dir = localize "STR_PRJ_SIDE_WORLD_SW"};
		case (_dir > 255 && _dir <= 285) : {_localize_dir = localize "STR_PRJ_SIDE_WORLD_W"};
		case (_dir > 285 && _dir <= 345) : {_localize_dir = localize "STR_PRJ_SIDE_WORLD_NW"};
	};

	[_localize_dir,round _distance];
};

prj_fnc_civ_info = {
	params ["_position","_civilian"];

	if !(player getVariable ["interpreter",false]) exitWith {
		[localize "STR_PRJ_CIVIL", localize (selectRandom ["STR_PRJ_CIVIL_DOES_NOT_UNDERSTAND_1","STR_PRJ_CIVIL_DOES_NOT_UNDERSTAND_2","STR_PRJ_CIVIL_DOES_NOT_UNDERSTAND_3"])] spawn BIS_fnc_showSubtitle;
	};

	if (_civilian getVariable ["interviewed",false]) exitWith {
		[localize "STR_PRJ_CIVIL", localize (selectRandom ["STR_PRJ_CIVIL_INFO_INTERVIEWED_1","STR_PRJ_CIVIL_INFO_INTERVIEWED_2","STR_PRJ_CIVIL_INFO_INTERVIEWED_3"])] spawn BIS_fnc_showSubtitle;
	};

	private _kill_enemy = missionNamespace getVariable ["total_kill_enemy",0];
	private _civ_enemy = missionNamespace getVariable ["total_kill_civ",0];

	if ((_kill_enemy - (_civ_enemy * 5)) < 0) exitWith {
		[localize "STR_PRJ_CIVIL", localize (selectRandom ["STR_PRJ_CIVIL_BAD_KARMA_1","STR_PRJ_CIVIL_BAD_KARMA_2","STR_PRJ_CIVIL_BAD_KARMA_3"])] spawn BIS_fnc_showSubtitle;
	};

	if ((random 1) < 0.5) then {
		private _camps_coords = missionNamespace getVariable ["camps_coords",[]];
		private _near_camps = [_position, _camps_coords, 2500] call prj_fnc_near_pos_array;

		if ((count _near_camps) > 0 && (random 1) < 0.5) then {
			private _localize_info = [_position,_near_camps,500] call prj_fnc_localize_info;

			[localize "STR_PRJ_CIVIL", format [localize (selectRandom ["STR_PRJ_CIVIL_INFO_CAMP_1_INF","STR_PRJ_CIVIL_INFO_CAMP_2_INF","STR_PRJ_CIVIL_INFO_CAMP_3_INF"]), _localize_info # 0, _localize_info # 1]] spawn BIS_fnc_showSubtitle;
		} else {
			private _ied_coords = missionNamespace getVariable ["ied_array",[]];
			private	_near_ied = [_position, _ied_coords, 2000] call prj_fnc_near_pos_array;

			if ((count _near_ied) > 0 && (random 1) < 0.5) then { 
				private _localize_info = [_position,_near_ied,500] call prj_fnc_localize_info;
				
				[localize "STR_PRJ_CIVIL", format [localize (selectRandom ["STR_PRJ_CIVIL_INFO_1_IED","STR_PRJ_CIVIL_INFO_2_IED","STR_PRJ_CIVIL_INFO_3_IED"]), _localize_info # 0, _localize_info # 1]] spawn BIS_fnc_showSubtitle;
			} else {
				private _entities_array = _position nearEntities [enemy_infantry, 2500];
				if ((count _entities_array) > 0) then {
					private _localize_info = [_position,_entities_array,150] call prj_fnc_localize_info;

					[localize "STR_PRJ_CIVIL", format [localize (selectRandom ["STR_PRJ_CIVIL_INFO_1_INF","STR_PRJ_CIVIL_INFO_2_INF","STR_PRJ_CIVIL_INFO_3_INF"]), _localize_info # 0, _localize_info # 1]] spawn BIS_fnc_showSubtitle;
				} else {
					[localize "STR_PRJ_CIVIL", localize (selectRandom ["STR_PRJ_CIVIL_INFO_NEGATIVE_1","STR_PRJ_CIVIL_INFO_NEGATIVE_2","STR_PRJ_CIVIL_INFO_NEGATIVE_3"])] spawn BIS_fnc_showSubtitle;
				};
			};
		};
	} else {
		[localize "STR_PRJ_CIVIL", localize (selectRandom ["STR_PRJ_CIVIL_INFO_NEGATIVE_1","STR_PRJ_CIVIL_INFO_NEGATIVE_2","STR_PRJ_CIVIL_INFO_NEGATIVE_3"])] spawn BIS_fnc_showSubtitle;
	};

	_civilian setVariable ["interviewed",true,true];
};

prj_fnc_save_game = {

	// save general

	private _generalDataArray = [];
	{_generalDataArray pushBack (missionNamespace getVariable [_x,0])} forEach ["intel_score","g_garage_level","a_garage_level","total_kill_enemy","total_kill_friend","total_kill_civ"];

	"ArmaRequests" callExtension (format ["0|GET|https://heavens.pro/armaExtension/?k=erj36424523gXeCLiRrergeu734w87ef&t=saveGeneral&d=%1|null",_generalDataArray]);

	waitUntil {uiSleep 1; "ArmaRequests" callExtension "2" == "OK"};

	private _response = "ArmaRequests" callExtension "1";
	private _parsedResponse = parseSimpleArray _response;
	private _responseCode = _parsedResponse # 0;

	if (_responseCode != 9) then {"General data are saved" remoteExec ["systemChat"]} else {"Response error" remoteExec ["systemChat"]};

	// save players

	private _allUIDs = missionNamespace getVariable ["prj27UIDs",[]];

	{
		private _playerData = missionNamespace getVariable [_x,0];

		private _u = _x;
		private _m = (_playerData # 0) # 1;
		private _e = (_playerData # 1) # 1;
		private _f = (_playerData # 2) # 1;
		private _c = (_playerData # 3) # 1;

		"ArmaRequests" callExtension (format ["0|GET|https://heavens.pro/armaExtension/?k=erj36424523gXeCLiRrergeu734w87ef&t=savePlayer&u=%1&m=%2&e=%3&f=%4&c=%5|null",_u,_m,_e,_f,_c]);

		waitUntil {uiSleep 0.5; "ArmaRequests" callExtension "2" == "OK"};

		private _response = "ArmaRequests" callExtension "1";
		private _parsedResponse = parseSimpleArray _response;
		private _responseCode = _parsedResponse # 0;

		if (_responseCode == 9) then {"Response error" remoteExec ["systemChat"]};

	} forEach _allUIDs;

	"Player data saved" remoteExec ["systemChat"];

	// save vehicles

	private _vehs = nearestObjects [position arsenal,["Air","LandVehicle"], 1000] + nearestObjects [position tr_a_shop,["Air","LandVehicle"], 1000];

	private _vehsArray = [];
	{_vehsArray pushBack [typeOf _x,",",position _x,",",getDir _x]} forEach _vehs;
	
	"ArmaRequests" callExtension (format ["0|GET|https://heavens.pro/armaExtension/?k=erj36424523gXeCLiRrergeu734w87ef&t=saveVehicles&d=%1|null",_vehsArray]);

	waitUntil {uiSleep 1; "ArmaRequests" callExtension "2" == "OK"};

	private _response = "ArmaRequests" callExtension "1";
	private _parsedResponse = parseSimpleArray _response;
	private _responseCode = _parsedResponse # 0;

	if (_responseCode != 9) then {"Vehicles are saved" remoteExec ["systemChat"]} else {"Response error" remoteExec ["systemChat"]};

	"Data saved" remoteExec ["systemChat"];
};

prj_fnc_load_game = {
	params [["_vehs",true]];

	// load general

	"ArmaRequests" callExtension "0|GET|https://heavens.pro/armaExtension/?k=erj36424523gXeCLiRrergeu734w87ef&t=loadGeneral|null";

	waitUntil {uiSleep 1; "ArmaRequests" callExtension "2" == "OK"};

	private _response = "ArmaRequests" callExtension "1";
	private _parsedResponse = parseSimpleArray _response;
	private _responseCode = _parsedResponse # 0;
	private _dataArray = (_parsedResponse # 1) splitString ",";

	if (_responseCode != 9) then {

		{
			missionNamespace setVariable [_x,parseNumber (_dataArray # _forEachIndex),true];
		} forEach ["intel_score","g_garage_level","a_garage_level","total_kill_enemy","total_kill_friend","total_kill_civ"];

		"General data are loaded" remoteExec ["systemChat"];
	} else {
		"Response error" remoteExec ["systemChat"];
	};

	// load players

	"ArmaRequests" callExtension "0|GET|https://heavens.pro/armaExtension/?k=erj36424523gXeCLiRrergeu734w87ef&t=loadPlayers|null";

	waitUntil {uiSleep 1; "ArmaRequests" callExtension "2" == "OK"};

	private _response = "ArmaRequests" callExtension "1";
	private _parsedResponse = parseSimpleArray _response;
	private _responseCode = _parsedResponse # 0;
	private _stringArray = (_parsedResponse # 1) splitString "-";

	if (_responseCode != 9) then {
		
		{
			private _playerData = _x splitString ":";

			private _uid = (_playerData # 0);
			private _money = parseNumber (_playerData # 1);
			private _enemy = parseNumber (_playerData # 2);
			private _friend = parseNumber (_playerData # 3);
			private _civs = parseNumber (_playerData # 4);
		
			missionNamespace setVariable [
				_uid,
				[
					["money",_money],
					["enemy_killings",_enemy],
					["friend_killings",_friend],
					["civ_killings",_civs]
				],
				true
			];

		} forEach _stringArray;

		"All players data are loaded" remoteExec ["systemChat"];

	} else {
		"Response error" remoteExec ["systemChat"];
	};

	// load vehicles

	if (_vehs) then {

		"ArmaRequests" callExtension "0|GET|https://heavens.pro/armaExtension/?k=erj36424523gXeCLiRrergeu734w87ef&t=loadVehicles|null";

		waitUntil {uiSleep 1; "ArmaRequests" callExtension "2" == "OK"};

		private _response = "ArmaRequests" callExtension "1";
		private _parsedResponse = parseSimpleArray _response;
		private _responseCode = _parsedResponse # 0;
		private _stringArray = (_parsedResponse # 1) splitString "+";

		if (_responseCode != 9) then {

			{deleteVehicle _x} forEach (nearestObjects [position arsenal,["Air","LandVehicle"], 200]);

			{
				private _vehInfo = _x splitString ":";

				private _vehClass = call (compile (_vehInfo # 0));
				private _vehPosStr = (_vehInfo # 1) splitString "[,]";
				private _vehPosArr = [parseNumber (_vehPosStr # 0),parseNumber (_vehPosStr # 1),parseNumber (_vehPosStr # 2)];
				private _vehDir = parseNumber (_vehInfo # 2);
			
				private _veh = createVehicle [_vehClass, _vehPosArr, [], 0, "CAN_COLLIDE"];
				_veh setDir _vehDir;

			} forEach _stringArray;

			"All vehicles are loaded" remoteExec ["systemChat"];

		} else {
			"Response error" remoteExec ["systemChat"];
		};
	};

	// final message
	"Data loaded" remoteExec ["systemChat"];
};