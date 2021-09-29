/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _center_pos = [1,false] call prj_fnc_selectPosition;

private _plcount = count allPlayers;
private _radius = _plcount * 30;
if (_radius > 500) then {_radius = 500};
private _min_radius = _radius * 0.3;

private _pos = [_center_pos, _min_radius, _radius, 3, 0] call BIS_fnc_findSafePos;

private _tower_class = selectRandom towers;
private _tower = (_tower_class select 0) createVehicle _pos;
private _generator = (_tower_class select 1) createVehicle ((position _tower) findEmptyPosition [0,20,_tower_class select 1]);

_tower addEventHandler ["FiredNear", {
	params ["_unit"];
	_unit removeEventHandler ["FiredNear", _thisEventHandler];
	
	[position _unit] call prj_fnc_sentry_patrol;
}];

private _enemies = [];

_enemies = _enemies + ([_pos] call prj_fnc_enemy_crowd);
_enemies = _enemies + ([_pos,100,[1,2]] call prj_fnc_enemy_patrols);

private _picture = getText(configfile >> "CfgVehicles" >> _tower_class select 0 >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_DESTROY_TOWER_DESCRIPTION", _picture], "STR_SIDE_DESTROY_TOWER_TITLE", ""], _center_pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

[_taskID,_center_pos,"ColorOrange",0.7,[[_radius,_radius],"ELLIPSE"]] call prj_fnc_create_marker;

waitUntil {uiSleep 5; !alive _tower || !alive _generator || _taskID call BIS_fnc_taskCompleted};

if (!alive _tower || !alive _generator) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
	uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach [_tower,_generator];
deleteMarker _taskID;

[_enemies] spawn {
	params ["_enemies"];
	uiSleep 120;
	{deleteVehicle _x} forEach _enemies;
};