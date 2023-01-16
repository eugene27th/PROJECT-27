/*
	Author: eugene27
	Date: 16.01.2023

	Example:
	[] call P27_fnc_getBuildingPositions
*/


params ["_centerPosition", ["_radius", 200]];

private _allBuildings = nearestObjects [_centerPosition, ["Building"], _radius];
private _usefulBuildings = _allBuildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};

private _freeBuildingPositions = [];

{
	_freeBuildingPositions append ([_x] call CBA_fnc_buildingPositions);
} forEach _usefulBuildings;

if ((count _freeBuildingPositions) < 1) then {
	_freeBuildingPositions pushBack ([_centerPosition, 0, _radius, 2, 0] call BIS_fnc_findSafePos);
};

_freeBuildingPositions