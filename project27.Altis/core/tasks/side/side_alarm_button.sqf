/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _roadpos = [1] call prj_fnc_select_road_position;
private _pos = _roadpos select 0;
private _direction = _roadpos select 1;

private _unit_pos = [_pos, 5, 10, 1, 0] call BIS_fnc_findSafePos;

[west, [_taskID], ["STR_SIDE_ALARM_BUTTON_DESCRIPTION", "STR_SIDE_ALARM_BUTTON_TITLE", ""], _pos, "CREATED", 0, true, "unknown"] call BIS_fnc_taskCreate;

[_taskID,_pos,"ColorCIV",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;

private _idap_vehicle = selectRandom idap_vehicles createVehicle _pos;
_idap_vehicle setDir _direction;

private _enemy_vehicle_pos = [_pos, 10, 100, 5, 0] call BIS_fnc_findSafePos;
private _enemy_vehicle = selectRandom (enemy_vehicles_light + enemy_vehicles_heavy) createVehicle _enemy_vehicle_pos;
private _enemy_vehicle_crew = [_enemy_vehicle,enemy_infantry,true] call prj_fnc_create_crew;

private _idap_units = [];
private _enemies = [];

for "_i" from 1 to 2 do {
	private _unit = (createGroup civilian) createUnit [selectRandom idap_units, _unit_pos, [], 0, "NONE"];
    _unit setBehaviour "CARELESS";
    [_unit, "Acts_CivilHiding_2"] remoteExec ["switchMove", 0];
    _idap_units pushBack _unit;
};

for [{private _i = 0 }, { _i < ([10,15] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
	private _position = [_pos, [4,15] call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
	private _unit = (createGroup independent) createUnit [selectRandom enemy_infantry, _position, [], 0, "NONE"];
    _unit lookAt _idap_vehicle;
    _enemies pushBack _unit;
};

private _trg = createTrigger ["EmptyDetector", _pos, true];
_trg setTriggerArea [50, 50, 0, false, 20];
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
_trg setTriggerStatements ["this", "",""];

waitUntil {sleep 5;{!alive _x} forEach _idap_units || triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

if ({!alive _x} forEach _idap_units) then {
    [_taskID,"FAILED"] call BIS_fnc_taskSetState;
	sleep 2;
};

if (triggerActivated _trg) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
    {[_x, ""] remoteExec ["switchMove", 0]} forEach _idap_units;
    (_idap_units select 0) assignAsDriver _idap_vehicle; 
    [(_idap_units select 0)] orderGetIn true; 
    [(_idap_units select 0)] allowGetIn true;
	(_idap_units select 1) assignAsCargo _idap_vehicle;
	[(_idap_units select 1)] orderGetIn true; 
    [(_idap_units select 1)] allowGetIn true;
	sleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteMarker _taskID;

uiSleep 30;

{deleteVehicle _x} forEach [_idap_vehicle,_enemy_vehicle,_trg] + _enemy_vehicle_crew + _idap_units + _enemies;