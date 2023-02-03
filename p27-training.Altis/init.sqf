enemyInf = ["I_soldier_F", "I_Soldier_lite_F"];
enemyLightVehs = ["I_Truck_02_covered_F", "I_MRAP_03_F"];
enemyHeavyVehs = ["I_APC_tracked_03_cannon_F", "I_APC_tracked_03_cannon_F"];


prj_fnc_cleanup = {
	params [["_objects", []], ["_markers", []]];

	if !(_objects isEqualTo []) then {
		{
			deleteVehicle _x
		} forEach _objects;
	};
	
	if !(_markers isEqualTo []) then {
		{
			deleteMarker _x
		} forEach _markers;
	};
};

prj_fnc_fullRepair = {
	private _vehicle = vehicle player;

	_vehicle setDamage 0;
	_vehicle setFuel 1;
};

prj_fnc_setTaskState = {
	params ["_state", ["_task", "lzTask"]];

	[_task, _state] call BIS_fnc_taskSetState;
	[_task] call BIS_fnc_deleteTask;
};

prj_fnc_cancelTask = {
	params ["_task"];

	if (_task isEqualTo "") exitWith {};

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

prj_fnc_createSmoke = {
	params ["_pos", ["_color", "white"]];

	_color = switch (_color) do {
		case "white": {[[1,1,1,1], [1,1,1,1], [1,1,1,1]]};
		case "orange": {[[0.85,0.4,0,1], [0.85,0.4,0,1], [0.85,0.4,0,1]]};
		case "red": {[[0.9,0,0,1], [0.9,0,0,1], [0.9,0,0,1]]};
		case "yellow": {[[0.85,0.85,0,1], [0.85,0.85,0,1], [0.85,0.85,0,1]]};
		case "blue": {[[0,0,1,1], [0,0,1,1], [0,0,1,1]]};
		case "green": {[[0,0.8,0,1], [0,0.8,0,1], [0,0.8,0,1]]};
		case "pink": {[[1,0.3,0.4,1], [1,0.3,0.4,1], [1,0.3,0.4,1]]};
	};

	private _smoke = "#particlesource" createVehicleLocal _pos;

	_smoke setParticleParams [
		["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 9, 1],
		"", "Billboard", 1, 15,
		[0, 0, 0.5],
		[0, 0, 2.9],
		1, 1.275, 1, 0.066, [1, 2, 5, 5],
		_color,
		[0],
		1, 0,
		"", "",
		_smoke
	];
	_smoke setParticleRandom [0, [0, 0, 0], [0.5, 0.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
	_smoke setDropInterval 0.05;

	_smoke
};

prj_fnc_createLogo = {
	[] spawn {
		disableSerialization;
		waitUntil{!isNull (findDisplay 46)};
		private _ctrlText2 = (findDisplay 46) ctrlCreate ["RscStructuredText",-1];
		_ctrlText2 ctrlSetStructuredText parseText "<t font='PuristaMedium' align='right' size='0.75' shadow='0'><br /><br /><br /><br />PROJECT 27 | TRAINING GROUND</t>";
		_ctrlText2 ctrlSetTextColor [1,1,1,0.7];
		_ctrlText2 ctrlSetBackgroundColor [0,0,0,0];
		_ctrlText2 ctrlSetPosition [
			(safezoneW - 22 * (((safezoneW / safezoneH) min 1.2) / 40)) + (safeZoneX)
			,(safezoneH - 5.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + (safeZoneY)
			,20 * (((safezoneW / safezoneH) min 1.2) / 40)
			,5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
		];
		_ctrlText2 ctrlSetFade 0.5;
		_ctrlText2 ctrlCommit 0;
		true;
	};
};

prj_fnc_createSafePos = {
	params ["_curPos", ["_radius", [2000, 4000]], ["_safeRadius", 6]];
	
	private _locTypes = ["NameCityCapital", "NameCity", "NameVillage", "NameLocal", "Hill", "RockArea", "VegetationBroadleaf", "VegetationFir", "VegetationPalm", "VegetationVineyard", "ViewPoint", "BorderCrossing"];

	private _locations = nearestLocations [_curPos, _locTypes, _radius # 1] - nearestLocations [_curPos, _locTypes, _radius # 0];
	private _locationPos = locationPosition (selectRandom _locations);

	private _pos = [_locationPos, 100, 1400, _safeRadius, 0, 0.3] call BIS_fnc_findSafePos;
	_pos set [2, 0];

	_pos
};

prj_fnc_createVehicles = {
	params ["_pos", "_vehClasses"];

	private _vehs = [];

	for [{private _i = 0 }, { _i < [5,7] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
		private _veh = (selectRandom _vehClasses) createVehicle _pos;
		_veh setDir (round (random 359));
		_veh lock true;
		_vehs pushBack _veh;
		uiSleep 0.5;
	};

	_vehs
};

prj_fnc_createCrowd = {
    params ["_pos", ["_relPos", false], ["_radius", [4, 15]], ["_number_of", [10, 16]]];
  
    private _units = [];

	if (_relPos) then {
		_pos = [_pos, 80, 150, 3, 0] call BIS_fnc_findSafePos;
	};

	private _grp = createGroup [independent, true];

    for [{private _i = 0 }, { _i < (_number_of call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
        private _spawnPos = [_pos, _radius call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
        private _unit = _grp createUnit [selectRandom enemyInf, _spawnPos, [], 0, "NONE"];
        doStop _unit;
        _unit setDir (round (random 360));

        _units pushBack _unit;
    };

    _units
};

prj_fnc_createPatrol = {
	params ["_cpos", ["_radius", 70], ["_inf", [2, 4]]];

	private _units = [];

	if ((_inf # 0) != 0) then {
		for [{private _i = 0 }, { _i < (_inf # 0) }, { _i = _i + 1 }] do {

			private _group = createGroup [independent, true];
			private _pos = [_cpos, 10, _radius, 1, 0] call BIS_fnc_findSafePos;

			if (!isNil "_pos") then {
				for [{private _i = 0 }, { _i < (_inf # 1) }, { _i = _i + 1 }] do {
					private _unit = _group createUnit [selectRandom enemyInf, _pos, [], 0, "NONE"];
					[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];
					_units pushBack _unit;
					uiSleep 0.5;
				};

				_group setBehaviour "SAFE";
				_group setSpeedMode "LIMITED";
				_group setCombatMode "YELLOW";
				_group setFormation (["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"] call BIS_fnc_selectRandom);

				for "_i" from 1 to 5 do {
					private _pos = [_cpos, 10, _radius, 1, 0] call BIS_fnc_findSafePos;
					private _wp = _group addWaypoint [_pos, 0];
					_wp setWaypointType "MOVE";
					_wp setWaypointCompletionRadius 50;
					_wp setWaypointTimeout [0,2,6];
				};

				private _pos_wp = [_cpos, 10, _radius, 1, 0] call BIS_fnc_findSafePos;

				private _wp_cycle = _group addWaypoint [_pos_wp, 0];
				_wp_cycle setWaypointType "CYCLE";
				_wp_cycle setWaypointCompletionRadius 50;
			};

			uiSleep 0.5;
		};
	};
	
	_units
};

prj_fnc_createWp = {
	if (!isNil "trgLz") then {
		["CANCELED"] call prj_fnc_setTaskState;
		[[trgLz]] call prj_fnc_cleanup;
		uiSleep 1;
	};

	[parseText "<t size='2.0'>Выбираем LZ...</t>"] remoteExec ["hint"];

	private _vehicle = vehicle player;
	private _curPos = position player;

	private _lzPos = [_curPos] call prj_fnc_createSafePos;

	private _marker_lz_ellipse = createMarker ["marker_lz_ellipse_" + str _lzPos, _lzPos];
	_marker_lz_ellipse setMarkerSize [25, 25];
	_marker_lz_ellipse setMarkerShape "ELLIPSE";
	_marker_lz_ellipse setMarkerColor "ColorWEST";
	_marker_lz_ellipse setMarkerAlpha 0.5;

	private _marker_lz_line = createMarker ["marker_lz_line_" + str _lzPos, _lzPos];
	_marker_lz_line setMarkerShape "POLYLINE";
	_marker_lz_line setMarkerColor "ColorBlack";
	_marker_lz_line setMarkerPolyline [_curPos # 0, _curPos # 1, _lzPos # 0, _lzPos # 1];

	trgLz = createTrigger ["EmptyDetector", _lzPos, true];
	trgLz setTriggerArea [25, 25, 0, false, 20];
	trgLz setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	trgLz setTriggerStatements ["(vehicle player) in thisList and ((getPos vehicle player) # 2 < 1)", "", ""];
	trgLz setTriggerTimeout [3, 3, 3, true];

	private _smoke = [_lzPos, "orange"] call prj_fnc_createSmoke;

	private _heliSpeed = getNumber(configfile >> "CfgVehicles" >> typeOf _vehicle >> "maxSpeed");
	private _eta = floor ((_curPos distance _lzPos) / ((_heliSpeed / 2) / 3.6));

	[true, ["lzTask"], [format ["Приземлитесь сюды. ETA: %1 с.", _eta], "LZ", ""], _lzPos, "ASSIGNED", 2, true, "heli"] call BIS_fnc_taskCreate;
	
	[_vehicle, _lzPos, trgLz, _eta, _smoke, [_marker_lz_ellipse, _marker_lz_line]] spawn {

		params [
			"_vehicle", "_lzPos", "_trgLz", "_eta", "_smoke", "_markers"
		];

		private _distanceToFinish = _vehicle distance _lzPos;

		private _timeSpent = 0;
		private _timeLeft = _eta;
		private _timeColor = "";

		while {alive _vehicle && alive _trgLz && !triggerActivated _trgLz} do {

			_timeLeft = _timeLeft - 1;
			_timeSpent = _timeSpent + 1;

			if (_timeLeft > 30 && _timeLeft < 60) then {
				_timeColor = "color='#25E03F'";
			};

			if (_timeLeft > 0 && _timeLeft < 30) then {
				_timeColor = "color='#F77F00'";
			};

			if (_timeLeft > -30 && _timeLeft < 0) then {
				_timeColor = "color='#D64D4D'";
			};

			if (_timeLeft < -30) then {
				_timeColor = "color='#CB0000'";
			};

			[parseText format ["<t size='2.0' %1>%2</t><br/>Оставшееся расстояние: %3 м.", _timeColor, _timeLeft, floor (_vehicle distance _lzPos)]] remoteExec ["hint"];

			sleep 1;	
		};

		if (!alive _trgLz) exitWith {
			[[_smoke], _markers] call prj_fnc_cleanup;
			hintSilent "";
		};

		if (!alive _vehicle) exitWith {
			["FAILED"] call prj_fnc_setTaskState;
			[[trgLz, _smoke], _markers] call prj_fnc_cleanup;
		};

		private _status = "<t size='2.0' color='#E33535'>Нужно больше практики.</t>";

		switch (true) do {
			case (_timeLeft >= 30): {
				_status = "<t size='2.0' color='#01D5FF'>Превосходно!</t>";
			};
			case (_timeLeft >= 0): {
				_status = "<t size='2.0' color='#03C128'>Хорошо!</t>";
			};
			case (_timeLeft >= -20): {
				_status = "<t size='2.0' color='#FCD200'>Можно лучше.</t>";
			};
			case (_timeLeft >= -50): {
				_status = "<t size='2.0' color='#E33535'>Потренируемся ещё?</t>";
			};
		};

		[parseText format ["%1<br/>Потраченное время: %2 с. / %3 c.<br/>Расстояние до финиша: %4 м.<br/>Как будете готовы, запускайте следующую!", _status, _timeSpent, _eta, _distanceToFinish]] remoteExec ["hint"];

		["SUCCEEDED"] call prj_fnc_setTaskState;
		[[trgLz, _smoke], _markers] call prj_fnc_cleanup;
	};
};

prj_fnc_createTarget = {
	params ["_type"];

	private _vehicle = vehicle player;
	private _curPos = position player;
	
	private _pos = [_curPos] call prj_fnc_createSafePos;

	private _task = _type + str _pos;
	[true, [_task], ["Цель для уничтожения.", [format ["Цель (%1)", _type]], ""], _pos, "ASSIGNED", 2, true, "target"] call BIS_fnc_taskCreate;

	private _smoke = [_pos, "red"] call prj_fnc_createSmoke;

	private _objects = [_smoke];

	switch (_type) do {
		case "i": {
			_objects append ([_pos] call prj_fnc_createCrowd);
			_objects append ([_pos] call prj_fnc_createPatrol);
		};

		case "l": {
			_objects append ([_pos, enemyLightVehs] call prj_fnc_createVehicles);
		};

		case "h": {
			_objects append ([_pos, enemyHeavyVehs] call prj_fnc_createVehicles);
		};
	};

	[_task, _objects] spawn {
		params ["_task", "_objects"];

		waitUntil {uiSleep 1; {!alive _x} forEach _objects || _task call BIS_fnc_taskCompleted};

		if (_task call BIS_fnc_taskCompleted) then {
			[_task] call BIS_fnc_deleteTask;
		} else {
			["SUCCEEDED", _task] call prj_fnc_setTaskState;
		};

		[_objects] call prj_fnc_cleanup;
	};
};

prj_fnc_createAceActions = {
	private "_action";

	_action = ["mainMenu", "Меню миссии", "\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["vehRepair", "Починить технику", "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa", {
		call prj_fnc_fullRepair
	}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu"], _action] call ace_interact_menu_fnc_addActionToObject;


	_action = ["lzMenu", "Зона посадки", "\A3\ui_f\data\igui\cfg\simpleTasks\types\heli_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["lzCreate", "Создать зону посадки", "\A3\ui_f\data\igui\cfg\simpleTasks\types\move_ca.paa", {
		[] spawn {call prj_fnc_createWp}
	}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu", "lzMenu"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["lzDelete", "Удалить зону посадки", "\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa", {
		["CANCELED"] call prj_fnc_setTaskState;
		[[trgLz]] call prj_fnc_cleanup
	}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu", "lzMenu"], _action] call ace_interact_menu_fnc_addActionToObject;


	_action = ["targetMenu", "Создать цель", "\A3\ui_f\data\igui\cfg\simpleTasks\types\target_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["targetInfMenu", "Пехота", "\A3\ui_f\data\igui\cfg\simpleTasks\types\kill_ca.paa", {
		[] spawn {["i"] call prj_fnc_createTarget}
	}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu", "targetMenu"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["targetLightMenu", "Лёгкая техника", "\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa", {
		[] spawn {["l"] call prj_fnc_createTarget}
	}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu", "targetMenu"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["targetHeavyMenu", "Тяжёлая техника", "\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa", {
		[] spawn {["h"] call prj_fnc_createTarget}
	}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu", "targetMenu"], _action] call ace_interact_menu_fnc_addActionToObject;


	_action = ["targetCancel", "Отменить цель", "\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa", {
		[player call BIS_fnc_taskCurrent] call prj_fnc_cancelTask;
	}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "mainMenu"], _action] call ace_interact_menu_fnc_addActionToObject;	
};


call prj_fnc_createLogo;
call prj_fnc_createAceActions;