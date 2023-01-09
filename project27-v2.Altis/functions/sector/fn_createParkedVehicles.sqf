/*
    Author: eugene27
    Date: 03.11.2022
    
    Example:
        [] call P27_fnc_createParkedVehicles
*/


params ["_sectorTrigger", ["_sectorRadius", 100]];

private _roadPositions = [[1, numberOfMaximumParkedVehiclesInSector] call BIS_fnc_randomInt, position _sectorTrigger, _sectorRadius] call P27_fnc_getRandomRoadPositions;

if ((count _roadPositions) < 2 && (random 1) < 0.4) exitWith {};


private _availableVehicles = (configUnits # 1) # 1;

if (!(_sectorTrigger getVariable ["isCaptured", false])) then {
	_availableVehicles = _availableVehicles + ((configUnits # 0) # 1) # 2;
};


private _vehicles = [];

{
	private _spawnDirection = _x # 1;
	private _spawnPosition = (_x # 0) getPos [3, _spawnDirection + 90];

	private _vehicle = createVehicle [selectRandom _availableVehicles, _spawnPosition, [], 0, "CAN_COLLIDE"];
	_vehicle setVariable ["spawnTrigger", _sectorTrigger];
	_vehicle setDir _spawnDirection;

	_vehicles pushBack _vehicle;
} forEach _roadPositions;


[_vehicles] call P27_fnc_addSpawnTriggerEventToVehicles;