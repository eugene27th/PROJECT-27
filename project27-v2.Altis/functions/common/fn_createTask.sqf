/*
    Author: eugene27
    Date: 14.08.2022
    
    Example:
        [] call P27_fnc_createSideTask;
    
    Return:
		nothing
*/


if !(missionNamespace getVariable ["taskIsAvailable", true]) exitWith {
	["Task not available."] remoteExec ["systemChat"];
};

missionNamespace setVariable ["taskIsAvailable", false, true];

private _taskNames = ["kek", "pek"];
private _currentTaskName = missionNamespace getVariable ["currentTaskName", "null"];

private _newTaskName = selectRandom _taskNames;

while {_newTaskName == _currentTaskName} do {
    _newTaskName = selectRandom _taskNames;
};

[] execVM "tasks\ts_" + _newTaskName + ".sqf";

missionNamespace setVariable ["currentTaskName", _newTaskName, true];

[] spawn {
	uiSleep 60;
	missionNamespace setVariable ["taskIsAvailable",true,true];
};