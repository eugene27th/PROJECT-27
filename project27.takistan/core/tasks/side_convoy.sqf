/*
	written by eugene27.
	server only
	1.3.0
*/

params [
    "_taskID","_reward"
];

private ["_taskID","_roadpos","_pos","_direction","_finish_pos","_vehicles","_crews"];

_taskID = "SIDE_" + str _taskID;

_roadpos = [1] call prj_fnc_select_road_position;
_pos = _roadpos select 0;
_direction = _roadpos select 1;

_finish_pos = [_pos, 5000, round (random 359)] call BIS_fnc_relPos;
_finish_pos = getPos ([_finish_pos, 5000] call BIS_fnc_nearestRoad); 
_finish_pos set [2, 0];

[west, [_taskID], ["STR_SIDE_CONVOY_DESCRIPTION", "STR_SIDE_CONVOY_TITLE", ""], objNull, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

_vehicles = [];
_crews = [];

for "_i" from 1 to 3 do {
	private _vehicle = selectRandom (enemy_heavy_armed_vehicle_array + enemy_cars_array) createVehicle _pos;
	_vehicle setDir _direction;
	_vehicle lock true;
	private _crew = [_vehicle,enemy_units_array,true] call prj_fnc_create_crew;
	_crews = _crews + _crew;
	crew _vehicle doMove _finish_pos;
	_vehicles pushBack _vehicle;
	[west, [(_taskID + "_" + str _i),_taskID], ["", "STR_SIDE_CONVOY_VEHICLE", ""], _vehicle, "CREATED", 0, false, "car"] call BIS_fnc_taskCreate;
};

waitUntil {sleep 5;{!alive _x} forEach _vehicles || {(_x distance _finish_pos) < 300} forEach _vehicles || _taskID call BIS_fnc_taskCompleted};

if ({!alive _x} forEach _vehicles) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
    [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
    uiSleep 2;
};

if ({(_x distance _finish_pos) < 300} forEach _vehicles) then {
    [_taskID,"FAILED"] call BIS_fnc_taskSetState;
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach _vehicles + _crews;
