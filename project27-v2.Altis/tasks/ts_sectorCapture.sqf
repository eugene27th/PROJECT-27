/*
    Author: eugene27
    Date: 14.08.2022
    
    Task
*/


params ["_sectorPosition"];

private _taskId = "ts#sectorCapture#" + str serverTime;

[_taskId, _sectorPosition, "ELLIPSE", [250, 250], "COLOR:", "ColorEAST", "ALPHA:", 0.5, "PERSIST"] call CBA_fnc_createMarker;
[west, [_taskId], ["STR_P27_TASK_DESCRIPTION_SECTORCAPTURE", "STR_P27_TASK_TITLE_SECTORCAPTURE", ""], _sectorPosition, "CREATED", 0, true, "attack"] call BIS_fnc_taskCreate;

([_sectorPosition, "AREA:", [250, 250, 20, false], "ACT:", ["WEST SEIZED", "PRESENT", true], "STATE:", ["this", "", ""]] call CBA_fnc_createTrigger) params ["_taskTrigger", "_triggerParams"];
_taskTrigger setVariable ["spawnTrigger", _taskId];

waitUntil {uiSleep 5; triggerActivated _taskTrigger || _taskId call BIS_fnc_taskCompleted};

if (triggerActivated _taskTrigger) then {
    [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_sectorPosition, [2, 2]] spawn P27_fnc_createReinforcements;
    uiSleep 2;
};

[_taskId] spawn P27_fnc_clearTask;