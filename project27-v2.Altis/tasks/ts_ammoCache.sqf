/*
    Author: eugene27
    Date: 14.01.2023
    
    Task

    WIP
*/


params ["_sectorPosition"];

private _taskId = "ts#ammoCache#" + str serverTime;
private _taskRadius = (count allPlayers) * 50;

if (_taskRadius > 300) then {
    _taskRadius = 300;
};


private _ammoCachePos = [_sectorPosition, 20, _taskRadius, 2, 0] call BIS_fnc_findSafePos;

private _ammoCache = (selectRandom ["Box_FIA_Ammo_F", "Box_FIA_Support_F", "O_supplyCrate_F", "Box_FIA_Wps_F"]) createVehicle _ammoCachePos;
_ammoCache setVariable ["ace_cookoff_enable", false, true];
_ammoCache setVariable ["spawnTrigger", _taskId];

clearItemCargoGlobal _ammoCache;
clearMagazineCargoGlobal _ammoCache;
clearWeaponCargoGlobal _ammoCache;
clearBackpackCargoGlobal _ammoCache;


[[_sectorPosition, _taskId], 100] spawn P27_fnc_createPatrolUnits;
[[_sectorPosition, _taskId], 100, [1,2]] spawn P27_fnc_createCrowdUnits;


[_taskId, _sectorPosition, "ELLIPSE", [_taskRadius, _taskRadius], "COLOR:", "ColorEAST", "ALPHA:", 0.5, "PERSIST"] call CBA_fnc_createMarker;
[west, [_taskId], ["STR_P27_TASK_DESCRIPTION_AMMOCACHE", "STR_P27_TASK_TITLE_AMMOCACHE", ""], _sectorPosition, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;


waitUntil {uiSleep 5; !alive _ammoCache || _taskId call BIS_fnc_taskCompleted};

if (!alive _ammoCache) then {
    [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_sectorPosition, [1, 1]] spawn P27_fnc_createReinforcements;
    uiSleep 2;
};

[_taskId] spawn P27_fnc_clearTask;