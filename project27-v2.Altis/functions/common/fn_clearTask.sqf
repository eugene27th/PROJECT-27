/*
    Author: eugene27
    Date: 27.08.2022
    
    Example:
		[] call P27_fnc_clearTask
*/


params ["_task", ["_objects", []], ["_markers", []], ["_sleepObjects", []], ["_sleepMarkers", []]];

if (isNil "_task") exitWith {};


[_task] call BIS_fnc_deleteTask;

{deleteVehicle _x} forEach _objects;
{deleteMarker _x} forEach _markers;


if (_sleepObjects isEqualTo [] && _sleepMarkers isEqualTo []) exitWith {};

[_sleepObjects, _sleepMarkers] spawn {
	params ["_sleepObjects", "_sleepMarkers"];

	uiSleep 300;

	{deleteVehicle _x} forEach _sleepObjects;
	{deleteMarker _x} forEach _sleepMarkers;
};