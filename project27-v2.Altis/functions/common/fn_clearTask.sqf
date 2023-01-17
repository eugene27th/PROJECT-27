/*
    Author: eugene27
    Date: 27.08.2022
    
    Example:
		[] spawn P27_fnc_clearTask
*/


params ["_taskId", ["_deleteObjects", true], ["_deleteMarkers", true], ["_numOfMarkers", 0]];

if (isNil "_taskId") exitWith {};

uiSleep 1;

[_taskId] call BIS_fnc_deleteTask;

if (_deleteObjects) then {
	{deleteVehicle _x} forEach ((allUnits + vehicles + allMissionObjects "EmptyDetector") select {(_x getVariable ["spawnTrigger", ""]) isEqualTo _taskId});
};

if (_deleteMarkers) then {
	deleteMarker _taskId;

	if (_numOfMarkers > 0) then {
		for [{ private _i = 0 }, { _i < _numOfMarkers }, { _i = _i + 1 }] do {
			deleteMarker (format ["%1#%2", _taskId, _i]);
		};
	};
};