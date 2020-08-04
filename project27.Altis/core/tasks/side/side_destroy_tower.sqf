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

private _picture = getText(configfile >> "CfgVehicles" >> _tower_class select 0 >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_DESTROY_TOWER_DESCRIPTION", _picture], "STR_SIDE_DESTROY_TOWER_TITLE", ""], _center_pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

[_taskID,_center_pos,"ColorOrange",0.7,[[500,500],"ELLIPSE"]] call prj_fnc_create_marker;

waitUntil {sleep 5; !alive _tower || !alive _generator || _taskID call BIS_fnc_taskCompleted};

if (!alive _tower || !alive _generator) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	["missionNamespace", getPlayerUID player, "money", 0, _reward] remoteExec ["prj_fnc_changePlayerVariable"];
	sleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach [_tower,_generator];
deleteMarker _taskID;