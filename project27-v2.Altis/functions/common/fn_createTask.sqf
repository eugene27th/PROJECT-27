/*
    Author: eugene27
    Date: 14.08.2022
    
    Example:
        [] call P27_fnc_createTask
*/


params [["_taskName", "random"]];

if !(missionNamespace getVariable ["taskIsAvailable", true]) exitWith {
	["1 minute between creating a task."] remoteExec ["systemChat"];
};

missionNamespace setVariable ["taskIsAvailable", false, true];

if (_taskName == "random") then {
    _taskName = selectRandom configTasks;
};

[] execVM "tasks\ts_" + _taskName + ".sqf";

[] spawn {
	uiSleep 60;
	missionNamespace setVariable ["taskIsAvailable", true, true];
};