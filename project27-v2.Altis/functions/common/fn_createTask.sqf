/*
    Author: eugene27
    Date: 14.08.2022
    
    Example:
        [] call P27_fnc_createTask
*/


params ["_taskName", "_sectorPosition"];

private _taskPath = "tasks\ts_" + _taskName + ".sqf";

if !(fileExists _taskPath) exitWith {
    ["Task not found."] remoteExec ["systemChat"];
};

[_sectorPosition] execVM _taskPath;