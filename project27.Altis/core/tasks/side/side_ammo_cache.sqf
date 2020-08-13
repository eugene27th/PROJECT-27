/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _pos = [4] call prj_fnc_select_position;

[_taskID,_pos,"ColorOrange",0.7,[[300,300],"ELLIPSE"]] call prj_fnc_create_marker;

private _ammo_cache = box_ammo_cache createVehicle ([_pos, 150, 300, 3, 0] call BIS_fnc_findSafePos);
clearItemCargoGlobal _ammo_cache;
clearMagazineCargoGlobal _ammo_cache;
clearWeaponCargoGlobal _ammo_cache;
clearBackpackCargoGlobal _ammo_cache;
_ammo_cache setVariable ["ace_cookoff_enable", false, true];

private _marker = createMarker ["cache_" + _taskID, position _ammo_cache];
_marker setMarkerType "mil_dot";
_marker setMarkerAlpha 1;
_marker setMarkerColor "ColorBLACK";

[west, [_taskID], ["STR_SIDE_AMMO_CACHE_DESCRIPTION", "STR_SIDE_AMMO_CACHE_TITLE", ""], _pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

waitUntil {sleep 5;!alive _ammo_cache || _taskID call BIS_fnc_taskCompleted};

if (!alive _ammo_cache) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
	sleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteVehicle _ammo_cache;
deleteMarker _taskID;