/*
    Author: eugene27
    Date: 13.09.2022
    
    Example:
        [] call P27_fnc_allObjectsAreDead
*/


params ["_objects"];

private _allDead = true;

{
	if (alive _x) exitWith {
		_allDead = false;
	};
} forEach _objects;

_allDead