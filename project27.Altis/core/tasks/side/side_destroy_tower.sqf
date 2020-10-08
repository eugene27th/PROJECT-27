/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _center_pos = [1,false] call prj_fnc_select_position;
private _pos = [_center_pos, 200, 500, 3, 0] call BIS_fnc_findSafePos;

private _tower_class = selectRandom towers;
private _tower = (_tower_class select 0) createVehicle _pos;
private _generator = (_tower_class select 1) createVehicle ((position _tower) findEmptyPosition [0,20,_tower_class select 1]);

private _enemies = [];
for [{private _i = 0 }, { _i < [10,20] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
    private _grpname = createGroup independent;
    private _pos = [_pos, 10, 170, 1, 0] call BIS_fnc_findSafePos;
    private _unit = _grpname createUnit [selectRandom enemy_infantry, _pos, [], 0, "NONE"];
	_unit setDir (round (random 360));
    _enemies pushBack _unit;
};

private _picture = getText(configfile >> "CfgVehicles" >> _tower_class select 0 >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_DESTROY_TOWER_DESCRIPTION", _picture], "STR_SIDE_DESTROY_TOWER_TITLE", ""], _center_pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

[_taskID,_center_pos,"ColorOrange",0.7,[[500,500],"ELLIPSE"]] call prj_fnc_create_marker;

waitUntil {sleep 5; !alive _tower || !alive _generator || _taskID call BIS_fnc_taskCompleted};

if (!alive _tower || !alive _generator) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
	sleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach [_tower,_generator];
deleteMarker _taskID;

[_enemies] spawn {
	params ["_enemies"];
	uiSleep 120;
	{deleteVehicle _x} forEach _enemies;
};