/* 
	written by eugene27.
	server only
	1.3.0
*/

params [
	"_trigger"
];

if (uss_debug) then {
	[format ["%1 activated\nenemy - %2\nciv - %3",_trigger,(_trigger getVariable "config") select 0,(_trigger getVariable "config") select 1]] remoteExec ["hint",0];
};

private ["_distance"];

_distance = 600;

//functions
prj_fnc_number_of_units = {
	params [
		"_number"
	];

	private ["_number_result"];

	_number_result = switch (_number) do {
		case 0: {1};
		case 1: {[2,4] call BIS_fnc_randomInt};
		case 2: {[4,8] call BIS_fnc_randomInt};
		case 3: {[8,12] call BIS_fnc_randomInt};
		default {1};
	};
	_number_result
};

prj_fnc_spawn_house_groups = {
	params [
		"_side","_class_units","_config"
	];

	private ["_house_units","_house_pos","_group"];

	_house_units = [];

	for [{private _i = 0 }, { _i < ((_config select 0) select 0) }, { _i = _i + 1 }] do {
		_group = createGroup _side;
		for [{private _i = 0 }, { _i < [((_config select 0) select 1)] call prj_fnc_number_of_units }, { _i = _i + 1 }] do {
			_buildings = nearestObjects [position _trigger, ["Building"], ((triggerArea _trigger) select 0) - _distance];
			_useful = _buildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};
			if ((count _useful) > 5) then {
				_allpositions = (selectRandom _useful) buildingPos -1;
				_house_pos = selectRandom _allpositions;
			};
			if (!isNil "_house_pos") then {
				private _unit = _group createUnit [selectRandom _class_units, _house_pos, [], 0, "NONE"];
				doStop _unit;
				_house_units pushBack _unit;
			};
		};
	};
	_house_units
};

prj_fnc_spawn_patrols_groups = {
	params [
		"_side","_class_units","_config"
	];

	private ["_patrols_units","_pos","_group"];

	_patrols_units = [];

	for [{private _i = 0 }, { _i < ((_config select 1) select 0) }, { _i = _i + 1 }] do {
		_group = createGroup _side;
		_pos = [position _trigger, 10, ((triggerArea _trigger) select 0) - _distance, 1, 0] call BIS_fnc_findSafePos;
		if (!isNil "_pos") then {
			for [{private _i = 0 }, { _i < [((_config select 1) select 1)] call prj_fnc_number_of_units }, { _i = _i + 1 }] do {
				private _unit = _group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
				_patrols_units pushBack _unit;
			};
			_group setBehaviour "SAFE";
			_group setSpeedMode "LIMITED";
			_group setCombatMode "YELLOW";
			_group setFormation (["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"] call BIS_fnc_selectRandom);

			//create waypoints
			for "_i" from 1 to ([4,8] call BIS_fnc_randomInt) do {
				private _pos = [position _trigger, 10, ((triggerArea _trigger) select 0) - _distance, 1, 0] call BIS_fnc_findSafePos;
				private _wp = _group addWaypoint [_pos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointCompletionRadius 50;
				_wp setWaypointTimeout [0,2,6];
			};

			private _pos_wp = [position _trigger, 10, ((triggerArea _trigger) select 0) - _distance, 1, 0] call BIS_fnc_findSafePos;

			private _wp_cycle = _group addWaypoint [_pos_wp, 0];
			_wp_cycle setWaypointType "CYCLE";
			_wp_cycle setWaypointCompletionRadius 50;
		};
	};
	_patrols_units
};

prj_fnc_spawn_vehicles = {
	params [
		"_side","_class_units","_class_vehicles","_config",["_index_config",2],["_behaviour","SAFE"]
	];

	private ["_vehicles","_vehicle_crew_units","_vehicle_cargo_units","_vehicle_crew_group"];

	_vehicles = [];
	_vehicle_crew_units = [];
	_vehicle_cargo_units = [];

	for [{private _i = 0 }, { _i < ((_config select _index_config) select 0) }, { _i = _i + 1 }] do {

		if ((random 1) < (_config select _index_config) select 1) then {

			private ["_pos","_pos_wp","_direction"];

			_roads = (position _trigger) nearRoads ((triggerArea _trigger) select 0) - _distance;
			if ((count _roads) > 5) then {
				_roads = _roads select {isOnRoad _x};
				_road = selectRandom _roads;
				_pos = getPos _road;
				_pos set [2, 0];
				_roadConnectedTo = roadsConnectedTo _road;
				_connectedRoad = _roadConnectedTo select 0;
				_direction = _road getDir _connectedRoad;
			}
			else
			{
				_pos = [position _trigger, 0, ((triggerArea _trigger) select 0) - _distance, 5, 0] call BIS_fnc_findSafePos;
				_direction = 0;
			};

			if (!isNil "_pos") then {

				_vehicle = (selectRandom _class_vehicles) createVehicle _pos;
				_vehicle setDir _direction;
				_vehicles pushBack _vehicle;

				//create crew
				_vehicle_crew_group = createGroup _side;

				if ((_vehicle emptyPositions "commander") != 0) then {
					private _unit = _vehicle_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
					_unit moveInCommander _vehicle;
					_vehicle_crew_units pushBack _unit;
				};

				if ((_vehicle emptyPositions "gunner") != 0) then {
					private _unit = _vehicle_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
					_unit moveInGunner _vehicle;
					_vehicle_crew_units pushBack _unit;
				};

				if ((_vehicle emptyPositions "driver") != 0) then {
					private _unit = _vehicle_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
					_unit moveInDriver _vehicle;
					_vehicle_crew_units pushBack _unit;
				};
				
				//create passengers
				private _empty_seats = round (random (_vehicle emptyPositions "cargo"));

				for "_i" from 1 to _empty_seats do {
					private _unit = _vehicle_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
					_unit moveInCargo _vehicle;
					_vehicle_cargo_units pushBack _unit;
				};

				_vehicle_crew_group setBehaviour _behaviour;
				_vehicle_crew_group setSpeedMode "LIMITED";
				_vehicle_crew_group setCombatMode "YELLOW";

				//create waypoints
				for "_i" from 1 to ([4,8] call BIS_fnc_randomInt) do {
					_roads = (position _trigger) nearRoads ((triggerArea _trigger) select 0) - _distance;
					if ((count _roads) > 5) then {
						private _roads = _roads select {isOnRoad _x};
						private _road = selectRandom _roads;
						_pos = getPos _road;
						_pos set [2, 0];
					}
					else
					{
						_pos = [position _trigger, 0, ((triggerArea _trigger) select 0) - _distance, 5, 0] call BIS_fnc_findSafePos;
					};
					_wp = _vehicle_crew_group addWaypoint [_pos, 0];
					_wp setWaypointType "MOVE";
					_wp setWaypointCompletionRadius 50;
				};

				_roads = (position _trigger) nearRoads ((triggerArea _trigger) select 0) - _distance;
				if ((count _roads) > 5) then {
					_roads = _roads select {isOnRoad _x};
					private _road = selectRandom _roads;
					_pos_wp = getPos _road;
					_pos_wp set [2, 0];
				}
				else
				{
					_pos_wp = [position _trigger, 0, ((triggerArea _trigger) select 0) - _distance, 5, 0] call BIS_fnc_findSafePos;
				};
				private _wp_cycle = _vehicle_crew_group addWaypoint [_pos_wp, 0];
				_wp_cycle setWaypointType "CYCLE";
				_wp_cycle setWaypointCompletionRadius 50;
			};
		};
	};
	[_vehicles,_vehicle_crew_units,_vehicle_cargo_units]
};

prj_fnc_spawn_static = {
	params [
		"_side","_class_units","_class_static","_config"
	];

	private ["_statics"];

	_statics = [];
	_static_crew_units = [];

	for [{private _i = 0 }, { _i < ((_config select 4) select 0) }, { _i = _i + 1 }] do {

		if ((random 1) < (_config select 4) select 1) then {

			private ["_pos"];

			_pos = [position _trigger, 0, ((triggerArea _trigger) select 0) - _distance, 5, 0] call BIS_fnc_findSafePos;

			if (!isNil "_pos") then {
				_static = (selectRandom _class_static) createVehicle _pos;
				_statics pushBack _static;

				//create crew
				_static_crew_group = createGroup _side;

				if ((_static emptyPositions "commander") != 0) then {
					private _unit = _static_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
					_unit moveInCommander _static;
					_static_crew_units pushBack _unit;
				};

				if ((_static emptyPositions "gunner") != 0) then {
					private _unit = _static_crew_group createUnit [selectRandom _class_units, _pos, [], 0, "NONE"];
					_unit moveInGunner _static;
					_static_crew_units pushBack _unit;
				};
			};
		};
	};
	[_statics,_static_crew_units]
};

private ["_enemy_house_units","_enemy_patrols_units","_enemy_light_vehicles","_civilian_house_units","_civilian_patrols_units","_civilian_light_vehicles","_global_vehicles","_global_vehicles_cargo","_players_array","_units_deleted","_vehicles_players"];

/////////////////////SPAWN ENEMY\\\\\\\\\\\\\\\\\\\\\\\\
//spawn house groups
_enemy_house_units = [independent,enemy_units_array,(_trigger getVariable "config") select 0] call prj_fnc_spawn_house_groups;

//spawn patrol group
_enemy_patrols_units = [independent,enemy_units_array,(_trigger getVariable "config") select 0] call prj_fnc_spawn_patrols_groups;

//spawn light vehicles
_enemy_light_vehicles = [independent,enemy_units_array,enemy_cars_array + civilian_cars_array,(_trigger getVariable "config") select 0] call prj_fnc_spawn_vehicles;

//spawn heavy vehicles
_enemy_heavy_vehicles = [independent,enemy_units_array,enemy_heavy_armed_vehicle_array,(_trigger getVariable "config") select 0,3] call prj_fnc_spawn_vehicles;

//spawn statics
_enemy_statics = [independent,enemy_units_array,enemy_static_array,(_trigger getVariable "config") select 0] call prj_fnc_spawn_static;

/////////////////////SPAWN CIVILIAN\\\\\\\\\\\\\\\\\\\\\\\\
//spawn house groups
_civilian_house_units = [civilian,civilian_units_array,(_trigger getVariable "config") select 1] call prj_fnc_spawn_house_groups;

//spawn patrol group
_civilian_patrols_units = [civilian,civilian_units_array,(_trigger getVariable "config") select 1] call prj_fnc_spawn_patrols_groups;

//spawn vehicles
_civilian_light_vehicles = [civilian,civilian_units_array,civilian_cars_array,(_trigger getVariable "config") select 1,2,"CARELESS"] call prj_fnc_spawn_vehicles;

{
	if (side _x == civilian) then {
		_x execVM "core\unit_spawn_system\core\bad_civ.sqf";
		_x addEventHandler ["FiredNear", {
			params [
				"_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"
			];

			private ["_unit"];

			if ((animationState _unit) == "amovpercmstpssurwnondnon") exitWith {};

			unAssignVehicle _unit;
			_unit action ["eject",vehicle _unit];
			_unit allowfleeing 0;
			[_unit] join (createGroup civilian);

			(group _unit) setBehaviour "CARELESS";
            (group _unit) setSpeedMode "FULL";

			for "_i" from (count waypoints (group _unit)) - 1 to 0 step -1 do {
				deleteWaypoint [group _unit, _i];
			};

			_pos = [position _unit, [70,100] call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
			_pos set [2, 0];

			unit_civ_runner = _unit;

			private _wp = (group _unit) addWaypoint [_pos, 0];  
			_wp setWaypointSpeed "FULL";  
			_wp setWaypointType "MOVE";
			_wp setWaypointCompletionRadius 10;
			_wp setWaypointStatements ["true", "[unit_civ_runner, 'Acts_CivilHiding_2'] remoteExec ['switchMove', 0]"];
		}];
	};
} forEach _civilian_house_units + _civilian_patrols_units;

waitUntil {sleep 1;!triggerActivated _trigger};

/////////////////////DELETE ALL\\\\\\\\\\\\\\\\\\\\\\\\

_global_vehicles = (_enemy_light_vehicles select 0) + (_civilian_light_vehicles select 0) + (_enemy_heavy_vehicles select 0) + (_enemy_statics select 0);

//delete vehicle crew
_global_vehicles_crew = (_enemy_light_vehicles select 1) + (_civilian_light_vehicles select 1) + (_enemy_heavy_vehicles select 1) + (_enemy_statics select 1);

{deleteVehicle _x} forEach _global_vehicles_crew;

//delete passengers
_global_vehicles_cargo = (_enemy_light_vehicles select 2) + (_civilian_light_vehicles select 2) + (_enemy_heavy_vehicles select 2);

{deleteVehicle _x} forEach _global_vehicles_cargo;

//delete vehicle without player
_vehicles_players = [];
{_vehicles_players pushBack (vehicle _x)} forEach allPlayers;

// systemChat format ["%1",_vehicles_players];
// systemChat format ["%1",count _global_vehicles];

_global_vehicles = _global_vehicles - _vehicles_players;

// systemChat format ["%1",count _global_vehicles];

//delete house and patrols groups
_units_deleted = _enemy_house_units + _civilian_house_units + _enemy_patrols_units + _civilian_patrols_units + _global_vehicles + _global_vehicles_cargo;

{deleteVehicle _x} forEach _enemy_house_units + _civilian_house_units + _enemy_patrols_units + _civilian_patrols_units + _global_vehicles;

if (uss_debug) then {
	[format ["%1 deactivated\n%2 entities deleted",_trigger,count _units_deleted]] remoteExec ["hint",0];
};