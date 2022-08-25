/*
    Author: eugene27
    Date: 14.08.2022
    
    Task
*/


private _taskName = "ts_" + str serverTime;
private _sectorPosition = [false, true] call P27_fnc_getRandomSectorPos;

[_taskName, _sectorPosition, "ELLIPSE", [250, 250], "COLOR:", "ColorEAST", "ALPHA:", 0.5, "PERSIST"] call CBA_fnc_createMarker;
[west, [_taskName], ["STR_P27_TASK_DESCRIPTION_CAPTUREZONE", "STR_P27_TASK_TITLE_CAPTUREZONE", ""], _sectorPosition, "CREATED", 0, true, "attack"] call BIS_fnc_taskCreate;
([_sectorPosition, "AREA:", [250, 250, 20, false], "ACT:", ["WEST SEIZED", "PRESENT", true], "STATE:", ["this", "", ""]] call CBA_fnc_createTrigger) params ["_taskTrigger", "_triggerParams"];

waitUntil {uiSleep 5; triggerActivated _taskTrigger || _taskName call BIS_fnc_taskCompleted};

if (triggerActivated _taskTrigger) then {
    [_taskName, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_sectorPosition, [2, 2]] spawn P27_fnc_createReinforcements;
    uiSleep 2;
};

[_taskName] call BIS_fnc_deleteTask;
deleteVehicle _taskTrigger;
deleteMarker _taskName;