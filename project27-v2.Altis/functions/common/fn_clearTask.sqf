/*
    Author: eugene27
    Date: 27.08.2022
    
    Example:
		[] spawn P27_fnc_clearTask
*/


params ["_taskId", ["_deleteObjects", true], ["_deleteMarkers", true]];

if (isNil "_taskId") exitWith {};

uiSleep 1;

[_taskId] call BIS_fnc_deleteTask;

if (_deleteObjects) then {
	{deleteVehicle _x} forEach ((allUnits + vehicles + allMissionObjects "EmptyDetector") select {(_x getVariable ["spawnTrigger", ""]) isEqualTo _taskId});
};

if (_deleteMarkers) then {
	deleteMarker _taskId;
};