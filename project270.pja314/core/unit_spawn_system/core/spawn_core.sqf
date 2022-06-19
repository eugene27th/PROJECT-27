/* 
	written by eugene27.
	server only
*/

params ["_trigger"];

if (_trigger getVariable "active") exitWith {};

_trigger setVariable ["active",true];

private _trigger_pos = position _trigger;
private _capture_sectores = "capture_of_sectors" call BIS_fnc_getParamValue;
private _sector_radius = ((triggerArea _trigger) # 0);

private _trigger_special = _trigger getVariable ["special","none"];

if (_trigger_special != "none") exitWith {
	private _vehicles = [];
	private _infantry = [];
	private _captRadius = 100;

	switch (_trigger_special) do {
		case "checkpoint": {
			private _dir = _trigger getVariable "cp_direction";

			private _checkpointData = [_trigger_pos,_dir] call prj_fnc_createCheckpoint;
			_vehicles = _checkpointData # 0;
			_infantry = (_checkpointData # 1) + (_checkpointData # 2);
		};

		case "camp": {
			_infantry = [_trigger_pos] call prj_fnc_createCrowd;
			_infantry append ([_trigger_pos,150,[2,2]] call prj_fnc_createPatrol);

			if (dayTime > 5 && dayTime < 19) then {
				for "_i" from 1 to 2 do {
					private _static = (selectRandom enemy_turrets) createVehicle (_trigger_pos findEmptyPosition [(60 * _i), 200, "B_HMG_01_high_F"]);
					_static setDir (round (random 360));
					_vehicles pushBack _static;

					private _staticCrew = [_static,enemy_infantry] call prj_fnc_createCrew;
					_infantry append _staticCrew;
				};
			};
		};
	};

	// zombie
	if (dayTime >= 19 || dayTime < 5) then {
		{
			private _type = [2,5] call BIS_fnc_randomInt;
			[_x, _type] call WBK_LoadAIThroughEden;
		} forEach _infantry;

		if (_capture_sectores == 1) then {
			_capt_trg = [_trigger_pos, [_captRadius, _captRadius, 50], "GUER", "NOT PRESENT", false, "[thisTrigger] call prj_fnc_zoneCapture;", false] call prj_fnc_createTrigger;
			_capt_trg setVariable ["parent_trigger",_trigger];
		};
	} else {
		if (_capture_sectores == 1) then {
			_capt_trg = [_trigger_pos, [_captRadius, _captRadius, 50], "WEST SEIZED", "PRESENT", false, "[thisTrigger] call prj_fnc_zoneCapture;", false] call prj_fnc_createTrigger;
			_capt_trg setVariable ["parent_trigger",_trigger];
		};
	};

	private _deleting = false;

	while {!_deleting} do {
		uiSleep 5;
		if (isNil "mhqterminal") then {
			if (!triggerActivated _trigger) exitWith {_deleting = true};
		} else {
			if (!triggerActivated _trigger && (mhqterminal distance _trigger) > _sector_radius) exitWith {_deleting = true};
		};
	};

	if (!isNil "_capt_trg") then {deleteVehicle _capt_trg};

	[_vehicles,_infantry,_trigger] spawn {
		params ["_vehicles","_infantry","_trigger"];
		uiSleep 60;

		{
			deleteVehicle _x
		} forEach _infantry;

		{
			if !(_x getVariable ["cannotDeleted",false]) then {
				deleteVehicle _x
			}
		} forEach _vehicles;

		_trigger setVariable ["active",false];
	};
};

private _distance = 800;
private _trigger_radius = ((triggerArea _trigger) # 0) - _distance;
private _enemy_config = (_trigger getVariable "config") # 0;
private _civil_config = (_trigger getVariable "config") # 1;

if (prj_debug) then {[format ["%1 activated\nenemy - %2\nciv - %3",_trigger,_enemy_config,_civil_config]] remoteExec ["hint",0]};

//functions
prj_fnc_getNumberOfUnits = {
	params ["_number"];

	private _number_result = switch (_number) do {
		case 0: {1};
		case 1: {[2,4] call BIS_fnc_randomInt};
		case 2: {[4,8] call BIS_fnc_randomInt};
		case 3: {[8,12] call BIS_fnc_randomInt};
		default {1};
	};
	_number_result
};

private _usefulBuildingsPos = [];

prj_fnc_createHouseGroups = {
	params ["_side","_class_units","_config",["_voice",true]];

	if (((_config # 0) # 0) == 0) exitWith {};

	private _house_units = [];

	if (_usefulBuildingsPos isEqualTo []) then {
		private _allBuildings = nearestObjects [_trigger_pos, ["Building"], _trigger_radius];
		private _usefulBuildings = _allBuildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};
		
		{_usefulBuildingsPos append (_x buildingPos -1)} forEach _usefulBuildings;

		if (prj_debug) then {[format ["позиций в строениях: %1",count _usefulBuildingsPos]] remoteExec ["systemChat"]};
	};

	for [{private _i = 0 }, { _i < ((_config # 0) # 0) }, { _i = _i + 1 }] do {
		if (count _usefulBuildingsPos < 1) exitWith {};

		private _group = createGroup [_side, true];

		for [{private _i = 0 }, { _i < [((_config # 0) # 1)] call prj_fnc_getNumberOfUnits }, { _i = _i + 1 }] do {
			if (count _usefulBuildingsPos < 1) exitWith {};

			private _buildingPos = selectRandom _usefulBuildingsPos;

			private _unit = _group createUnit [selectRandom _class_units, _buildingPos, [], 0, "NONE"];
			doStop _unit;

			if (dayTime >= 19 || dayTime < 5) then {
				private _type = [2,5] call BIS_fnc_randomInt;
				[_unit, _type] call WBK_LoadAIThroughEden;
			};

			if (_voice) then {[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit]};

			_house_units pushBack _unit;
			_usefulBuildingsPos deleteAt (_usefulBuildingsPos find _buildingPos);

			if (prj_debug) then {"юнит создан в доме" remoteExec ["systemChat"]};
			
			uiSleep 0.5;
		};
	};

	_house_units
};

prj_fnc_createPatrolGroups = {
	params ["_side","_class_units","_config",["_voice",false]];

	if (((_config # 1) # 0) == 0) exitWith {};

	private _patrols_units = [];

	for [{private _i = 0 }, { _i < ((_config # 1) # 0) }, { _i = _i + 1 }] do {
		private _group = createGroup [_side, true];
		private _pos = [_trigger_pos, 10, _trigger_radius, 1, 0] call BIS_fnc_findSafePos;
		
		if (!isNil "_pos") then {

			for [{private _i = 0 }, { _i < [((_config # 1) # 1)] call prj_fnc_getNumberOfUnits }, { _i = _i + 1 }] do {
				private _unit = _group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
				if (dayTime >= 19 || dayTime < 5) then {
					private _type = [2,5] call BIS_fnc_randomInt;
					[_unit, _type] call WBK_LoadAIThroughEden;
				};
				if (!_voice) then {
					[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];
				};
				_patrols_units pushBack _unit;
				if (prj_debug) then {"юнит патруля создан" remoteExec ["systemChat"]};
				uiSleep 0.5;
			};

			_group setBehaviour "SAFE";
			_group setSpeedMode "LIMITED";
			_group setCombatMode "YELLOW";
			_group setFormation (["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"] call BIS_fnc_selectRandom);

			//create waypoints
			for "_i" from 1 to 5 do {
				private _pos = [_trigger_pos, 10, _trigger_radius, 1, 0] call BIS_fnc_findSafePos;
				private _wp = _group addWaypoint [_pos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointCompletionRadius 50;
				_wp setWaypointTimeout [0,2,6];
				if (prj_debug) then {"WP для группы создан" remoteExec ["systemChat"]};
			};

			private _pos_wp = [_trigger_pos, 10, _trigger_radius, 1, 0] call BIS_fnc_findSafePos;

			private _wp_cycle = _group addWaypoint [_pos_wp, 0];
			_wp_cycle setWaypointType "CYCLE";
			_wp_cycle setWaypointCompletionRadius 50;
		};
	};
	_patrols_units
};

prj_fnc_createVehicles = {
	params ["_side","_class_units","_class_vehicles","_config",["_index_config",2],["_behaviour","SAFE"]];

	if (((_config # _index_config) # 0) == 0) exitWith {};

	private _vehicles = [];
	private _vehicle_crew_units = [];
	private _roads = (_trigger_pos) nearRoads _trigger_radius;
	_roads = _roads select {isOnRoad _x};

	for [{private _i = 0 }, { _i < ((_config # _index_config) # 0) }, { _i = _i + 1 }] do {

		if ((random 1) < (_config # _index_config) # 1) then {

			private ["_pos","_pos_wp","_direction"];

			if ((count _roads) > 5) then {
				_road = selectRandom _roads;
				_pos = getPos _road;
				_pos set [2, 0];
				_roadConnectedTo = roadsConnectedTo _road;
				_connectedRoad = _roadConnectedTo # 0;
				_direction = _road getDir _connectedRoad;
			} else {
				_pos = [_trigger_pos, 0, _trigger_radius, 5, 0] call BIS_fnc_findSafePos;
				_direction = 0;
			};

			if (prj_debug) then {"позиция спавна транспорта выбрана" remoteExec ["systemChat"]};

			if (isNil "_pos") exitWith {};

			_vehicle = (selectRandom _class_vehicles) createVehicle _pos;
			_vehicle setDir _direction;
			_vehicles pushBack _vehicle;

			if (prj_debug) then {"транспорт создан" remoteExec ["systemChat"]};

			uiSleep 0.5;

			//create crew
			private _vehicle_crew_group = createGroup [_side, true];

			if ((_vehicle emptyPositions "commander") != 0) then {
				private _unit = _vehicle_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
				_unit moveInCommander _vehicle;
				_vehicle_crew_units pushBack _unit;
				if (prj_debug) then {"командир создан" remoteExec ["systemChat"]};
			};

			if ((_vehicle emptyPositions "gunner") != 0) then {
				private _unit = _vehicle_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
				_unit moveInGunner _vehicle;
				_vehicle_crew_units pushBack _unit;
				if (prj_debug) then {"стрелок создан" remoteExec ["systemChat"]};
			};

			if ((_vehicle emptyPositions "driver") != 0) then {
				private _unit = _vehicle_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
				_unit moveInDriver _vehicle;
				_vehicle_crew_units pushBack _unit;
				if (prj_debug) then {"водитель создан" remoteExec ["systemChat"]};
			};
			
			uiSleep 0.5;

			//create passengers
			private _empty_seats = round (random (_vehicle emptyPositions "cargo"));

			for "_i" from 1 to _empty_seats do {
				private _unit = _vehicle_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
				_unit moveInCargo _vehicle;
				_vehicle_crew_units pushBack _unit;
				if (prj_debug) then {"пассажир создан" remoteExec ["systemChat"]};
				uiSleep 0.3;
			};

			_vehicle_crew_group setBehaviour _behaviour;
			_vehicle_crew_group setSpeedMode "LIMITED";
			_vehicle_crew_group setCombatMode "YELLOW";

			//create waypoints
			for "_i" from 1 to 3 do {
				if ((count _roads) > 5) then {
					private _road = selectRandom _roads;
					_pos = getPos _road;
					_pos set [2, 0];
				} else {
					_pos = [_trigger_pos, 0, _trigger_radius, 5, 0] call BIS_fnc_findSafePos;
				};
				_wp = _vehicle_crew_group addWaypoint [_pos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointCompletionRadius 50;
				if (prj_debug) then {"WP для транспорта создан" remoteExec ["systemChat"]};
				uiSleep 0.3;
			};

			if ((count _roads) > 5) then {
				private _road = selectRandom _roads;
				_pos_wp = getPos _road;
				_pos_wp set [2, 0];
			} else {
				_pos_wp = [_trigger_pos, 0, _trigger_radius, 5, 0] call BIS_fnc_findSafePos;
			};
			private _wp_cycle = _vehicle_crew_group addWaypoint [_pos_wp, 0];
			_wp_cycle setWaypointType "CYCLE";
			_wp_cycle setWaypointCompletionRadius 50;
		};
	};
	[_vehicles,_vehicle_crew_units]
};

prj_fnc_createStatic = {
	params ["_side","_class_units","_class_static","_config"];

	if (((_config # 4) # 0) == 0) exitWith {};

	private _statics = [];
	private _static_crew_units = [];

	for [{private _i = 0 }, { _i < ((_config # 4) # 0) }, { _i = _i + 1 }] do {

		if ((random 1) < (_config # 4) # 1) then {

			private _pos = [_trigger_pos, 0, _trigger_radius, 5, 0] call BIS_fnc_findSafePos;

			if (prj_debug) then {"позиция статика создан" remoteExec ["systemChat"]};

			if (isNil "_pos") exitWith {};

			private _static = (selectRandom _class_static) createVehicle _pos;
			_statics pushBack _static;

			if (prj_debug) then {"статик создан" remoteExec ["systemChat"]};

			//create crew
			private _static_crew_group = createGroup [_side, true];

			if ((_static emptyPositions "commander") != 0) then {
				private _unit = _static_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
				_unit moveInCommander _static;
				_static_crew_units pushBack _unit;
				if (prj_debug) then {"командир статика создан" remoteExec ["systemChat"]};
			};

			if ((_static emptyPositions "gunner") != 0) then {
				private _unit = _static_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
				_unit moveInGunner _static;
				_static_crew_units pushBack _unit;
				if (prj_debug) then {"стрелок статика создан" remoteExec ["systemChat"]};
			};
		};
		uiSleep 0.5;
	};
	[_statics,_static_crew_units]
};

/////////////////////SPAWN ENEMY\\\\\\\\\\\\\\\\\\\\\\\\
private ["_enemy_house_units","_enemy_patrols_units","_enemy_light_vehicles","_enemy_heavy_vehicles","_enemy_statics","_capt_trg"];

if (!(_trigger getVariable "captured")) then {
	if (dayTime > 5 && dayTime < 19) then {
		_enemy_light_vehicles = [enemySide,enemy_infantry,enemy_vehicles_light,_enemy_config] call prj_fnc_createVehicles;
		_enemy_heavy_vehicles = [enemySide,enemy_infantry,enemy_vehicles_heavy,_enemy_config,3] call prj_fnc_createVehicles;
		_enemy_patrols_units = [enemySide,enemy_infantry,_enemy_config] call prj_fnc_createPatrolGroups;
		_enemy_statics = [enemySide,enemy_infantry,enemy_turrets,_enemy_config] call prj_fnc_createStatic;
		_enemy_house_units = [enemySide,enemy_infantry,_enemy_config] call prj_fnc_createHouseGroups;

		if (_capture_sectores == 1) then {
			_capt_trg = [_trigger_pos, [_trigger_radius, _trigger_radius, 50], "WEST SEIZED", "PRESENT", false, "[thisTrigger] call prj_fnc_zoneCapture;", false] call prj_fnc_createTrigger;
			_capt_trg setVariable ["parent_trigger",_trigger];
		};
	} else {
		_enemy_patrols_units = [enemySide,enemy_infantry,[[0],[35,0],[0],[0],[0]]] call prj_fnc_createPatrolGroups;

		if (_capture_sectores == 1) then {
			_capt_trg = [_trigger_pos, [_trigger_radius, _trigger_radius, 50], "GUER", "NOT PRESENT", false, "[thisTrigger] call prj_fnc_zoneCapture;", false] call prj_fnc_createTrigger;
			_capt_trg setVariable ["parent_trigger",_trigger];
		};
	};
};

//////////////////////SPAWN CIVILIAN\\\\\\\\\\\\\\\\\\\\\\\
private ["_civilian_house_units","_civilian_patrols_units","_civilian_light_vehicles"];

if (dayTime > 5 && dayTime < 19) then {
	_civilian_house_units = [civilian,civilian_units,_civil_config,false] call prj_fnc_createHouseGroups;
	_civilian_patrols_units = [civilian,civilian_units,_civil_config,false] call prj_fnc_createPatrolGroups;
	_civilian_light_vehicles = [civilian,civilian_units,civilian_vehicles,_civil_config,2,"CARELESS"] call prj_fnc_createVehicles;
};

private _civilian_global_infantry = [];

if (!isNil "_civilian_house_units") then {_civilian_global_infantry append _civilian_house_units};
if (!isNil "_civilian_patrols_units") then {_civilian_global_infantry append _civilian_patrols_units};

if !(_civilian_global_infantry isEqualTo []) then {
	{
		[_x] spawn {
			params ["_civ"];
			_civ call prj_fnc_civBehaviour;
		};
	} forEach _civilian_global_infantry;
};

//////////////////////SET VARIABLES\\\\\\\\\\\\\\\\\\\\\\\

private _global_vehicles = [];
private _global_infantry = [];

if !(_civilian_global_infantry isEqualTo []) then {_global_infantry append _civilian_global_infantry};

if (!isNil "_civilian_light_vehicles") then {
	_global_vehicles append (_civilian_light_vehicles # 0);
	_global_infantry append (_civilian_light_vehicles # 1)
};

if (!isNil "_enemy_house_units") then {_global_infantry append _enemy_house_units};
if (!isNil "_enemy_patrols_units") then {_global_infantry append _enemy_patrols_units};

if (!isNil "_enemy_light_vehicles") then {
	_global_vehicles append (_enemy_light_vehicles # 0);
	_global_infantry append (_enemy_light_vehicles # 1)
};
if (!isNil "_enemy_heavy_vehicles") then {
	_global_vehicles append (_enemy_heavy_vehicles # 0);
	_global_infantry append (_enemy_heavy_vehicles # 1)
};
if (!isNil "_enemy_statics") then {
	_global_vehicles append (_enemy_statics # 0);
	_global_infantry append (_enemy_statics # 1)
};

{
	_x addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];

		if (isPlayer _unit) then {
			_vehicle removeEventHandler ["GetIn",_thisEventHandler];
			_vehicle setVariable ["cannotDeleted",true,true];
			systemChat "машина игрока";
		};
	}];
} forEach _global_vehicles;

/////////////////////////WAITING\\\\\\\\\\\\\\\\\\\\\\\\\\\\
private _deleting = false;

while {!_deleting} do {
	uiSleep 5;
	if (isNil "mhqterminal") then {
		if (!triggerActivated _trigger) exitWith {_deleting = true};
	} else {
		if (!triggerActivated _trigger && (mhqterminal distance _trigger) > _sector_radius) exitWith {_deleting = true};
	};
};

////////////////////////DELETE ALL\\\\\\\\\\\\\\\\\\\\\\\\\\
if (!isNil "_capt_trg") then {deleteVehicle _capt_trg};

if !(_global_vehicles isEqualTo []) then {
	private _vehicles_players = [];

	{
		if (_x getVariable ["cannotDeleted",false]) then {
			_vehicles_players pushBack _x;
		};
	} forEach _global_vehicles;

	_global_vehicles = _global_vehicles - _vehicles_players;
};

private _deleteArray = [_global_vehicles,_global_infantry];
for [{private _i = 0 }, { _i < (count _deleteArray) }, { _i = _i + 1 }] do {
	if !((_deleteArray # _i) isEqualTo []) then {
		{deleteVehicle _x} forEach (_deleteArray # _i)
	};
};

_trigger setVariable ["active",false];

if (prj_debug) then {
	[format ["%1 deactivated\ndeleted:\n%2 - vehicles\n%3 - people",_trigger,count _global_vehicles,count _global_infantry]] remoteExec ["hint",0];
};