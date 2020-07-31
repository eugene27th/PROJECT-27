/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _center_pos = [1] call prj_fnc_select_position;

private _enemies = [];
private _vehicles = [];
private _pos = [_center_pos, 200, 550, 5, 0] call BIS_fnc_findSafePos;

private _enemy_grp = createGroup independent;

for [{private _i = 0 }, { _i < [5,10] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
    private _vehicle = (selectRandom enemy_vehicles_light) createVehicle _pos;
    _vehicle setDir (round (random 359));
    _vehicle lock true;
    _vehicles pushBack _vehicle;
    uisleep 0.2;
    _unit = _enemy_grp createUnit [selectRandom enemy_infantry, (position _vehicle) findEmptyPosition [0,30,"C_IDAP_Man_AidWorker_01_F"], [], 0, "NONE"];
    _enemies pushBack _unit;
};

[west, [_taskID], ["STR_SIDE_DESTRUCTION_OF_VEHICLES_DESCRIPTION", "STR_SIDE_DESTRUCTION_OF_VEHICLES_TITLE", ""], _center_pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

[_taskID,_center_pos,"ColorOrange",0.7,[[600,600],"ELLIPSE"]] call prj_fnc_create_marker;

waitUntil {sleep 5;{!alive _x} forEach _vehicles || _taskID call BIS_fnc_taskCompleted};

if ({!alive _x} forEach _vehicles) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
    [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach _vehicles + _enemies;
deleteMarker _taskID;