/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _pos = [4] call prj_fnc_selectPosition;

private _plcount = count allPlayers;
private _radius = _plcount * 30;
if (_radius > 500) then {_radius = 500};
private _min_radius = _radius * 0.3;

[_taskID,_pos,"ColorOrange",0.7,[[_radius,_radius],"ELLIPSE"]] call prj_fnc_create_marker;

private _ammo_cache_class = selectRandom box_ammo_cache;
private _ammo_cache_pos = [_pos, _min_radius, _radius, 3, 0] call BIS_fnc_findSafePos;
private _ammo_cache = _ammo_cache_class createVehicle _ammo_cache_pos;
_ammo_cache setVariable ["ace_cookoff_enable", false, true];

clearItemCargoGlobal _ammo_cache;
clearMagazineCargoGlobal _ammo_cache;
clearWeaponCargoGlobal _ammo_cache;
clearBackpackCargoGlobal _ammo_cache;

if (prj_debug) then {
	["side_cache_" + _taskID,_ammo_cache_pos,"ColorBLACK",1,[],"mil_dot","cache"] call prj_fnc_create_marker;
};

private _enemies = [];

_enemies = _enemies + ([_pos] call prj_fnc_enemy_crowd);
_enemies = _enemies + ([_pos,100,[1,2]] call prj_fnc_enemy_patrols);

private _picture = getText(configfile >> "CfgVehicles" >> _ammo_cache_class >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_AMMO_CACHE_DESCRIPTION", _picture], "STR_SIDE_AMMO_CACHE_TITLE", ""], _pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

waitUntil {uiSleep 5;!alive _ammo_cache || _taskID call BIS_fnc_taskCompleted};

if (!alive _ammo_cache) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
	uiSleep 2;
};

[_enemies] spawn {
	params ["_enemies"];
	uiSleep 120;
	{deleteVehicle _x} forEach _enemies;
};

[_taskID] call BIS_fnc_deleteTask;
deleteVehicle _ammo_cache;
deleteMarker _taskID;