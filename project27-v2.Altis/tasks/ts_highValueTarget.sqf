/*
    Author: eugene27
    Date: 16.01.2023
    
    Task

    WIP
*/


params ["_sectorPosition"];

private _taskId = "ts#highValueTarget#" + str serverTime;
private _taskRadius = 200;

private _buildingPositions = [_sectorPosition, _taskRadius] call P27_fnc_getBuildingPositions;
private _spawnPosition = selectRandom _buildingPositions;


private _hvtClass = selectRandom ["I_L_Looter_SMG_F"];
private _hvtPreview = getText(configfile >> "CfgVehicles" >> _hvtClass >> "editorPreview");

private _hvtUnit = (createGroup [((configUnits # 0) # 0), true]) createUnit [_hvtClass, _spawnPosition, [], 0, "NONE"];
private _secureUnit = (createGroup [((configUnits # 0) # 0), true]) createUnit [selectRandom (((configUnits # 0) # 1) # 0), _spawnPosition, [], 0, "NONE"];

{
    _x setVariable ["spawnTrigger", _taskId];
} forEach [_hvtUnit, _secureUnit];


[[_sectorPosition, _taskId], 100] spawn P27_fnc_createPatrolUnits;
[[_sectorPosition, _taskId], 100, [1,2]] spawn P27_fnc_createCrowdUnits;


[_taskId, _sectorPosition, "ELLIPSE", [_taskRadius, _taskRadius], "COLOR:", "ColorEAST", "ALPHA:", 0.5, "PERSIST"] call CBA_fnc_createMarker;
[west, [_taskId], [format [localize "STR_P27_TASK_DESCRIPTION_HIGHVALUETARGET_IMAGE", _hvtPreview], "STR_P27_TASK_TITLE_HIGHVALUETARGET", ""], _sectorPosition, "CREATED", 0, true, "kill"] call BIS_fnc_taskCreate;


([_spawnPosition, "AREA:", [100, 100, 10, false], "ACT:", ["ANYPLAYER", "PRESENT", false], "STATE:", ["this", "systemChat 'eblan'; [position thisTrigger, [2,1]] spawn P27_fnc_createReinforcements;", ""]] call CBA_fnc_createTrigger) params ["_taskTrigger", "_triggerParams"];

_taskTrigger setVariable ["spawnTrigger", _taskId];


waitUntil {uiSleep 5; !alive _hvtUnit || (_hvtUnit distance (position respawn)) < 50 || _taskId call BIS_fnc_taskCompleted};

if (!alive _hvtUnit || (_hvtUnit distance (position respawn)) < 50) then {
    [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
    uiSleep 2;
};

[_taskId] spawn P27_fnc_clearTask;