/*
    Author: eugene27
    Date: 14.08.2022
    
    Example:
        [] call P27_fnc_createTask
*/


params ["_taskName", "_sectorPosition"];

private _taskPath = "tasks\ts_" + _taskName + ".sqf";

if !(missionNamespace getVariable ["taskIsAvailable", true]) exitWith {
	["1 minute between creating a task."] remoteExec ["systemChat"];
};

if !(fileExists _taskPath) exitWith {
    ["Task not found."] remoteExec ["systemChat"];
};

missionNamespace setVariable ["taskIsAvailable", false, true];

[_sectorPosition] execVM _taskPath;

[] spawn {
	uiSleep 60;
	missionNamespace setVariable ["taskIsAvailable", true, true];
};