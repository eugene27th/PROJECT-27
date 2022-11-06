/*
    Author: eugene27
    Date: 13.09.2022
    
    Example:
        [] call P27_fnc_allObjectsInRadius
*/


params ["_objects", "_center", ["_distance", 50]];

private _allInRadius = true;

{
    if ((_x distance _center) > _distance) exitWith {
        _allInRadius = false;
    };
} forEach _objects;

_allInRadius