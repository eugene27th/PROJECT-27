/*
    Author: eugene27
    Date: 14.08.2022
    
    Example:
        [] call P27_fnc_createTask
*/


params [["_taskName", "random"]];

if (_taskName == "random") then {
    _taskName = selectRandom configTasks;
};

private _taskPath = "tasks\ts_" + _taskName + ".sqf";

if !(fileExists _taskPath) exitWith {
    ["Task not found."] remoteExec ["systemChat"];
};

if !(missionNamespace getVariable ["taskIsAvailable", true]) exitWith {
	["1 minute between creating a task."] remoteExec ["systemChat"];
};

missionNamespace setVariable ["taskIsAvailable", false, true];

[] execVM _taskPath;

[] spawn {
	uiSleep 60;
	missionNamespace setVariable ["taskIsAvailable", true, true];
};