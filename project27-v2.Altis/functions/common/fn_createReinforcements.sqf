/*
    Author: eugene27
    Date: 24.08.2022
    
    Example:
        [] call P27_fnc_createReinforcements
*/


params ["_sadPosition", ["_spawnConfig", [1,1]]];

_spawnConfig params ["_maxCountSectors", "_maxCountVehicles"];

if (_maxCountSectors < 1 || _maxCountVehicles < 1) exitWith {};


private _allSectorTriggers = (missionNamespace getVariable "sectorTriggers") select {!(_x getVariable "isCaptured") && !(_x getVariable "isActive")}; //todo BIS_fnc_sortBy

if ((count _allSectorTriggers) < 1) exitWith {};


if (_maxCountSectors > (count _allSectorTriggers)) then {
	_maxCountSectors = (count _allSectorTriggers);
};


private _allVehicles = [];
private _reinforcementsId = "reinforcements" + (str serverTime);

for [{private _i = 0 }, { _i < ([1, _maxCountSectors] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
	private _roadPositions = [[1, _maxCountVehicles] call BIS_fnc_randomInt, position (_allSectorTriggers # _i), 300] call P27_fnc_getRandomRoadPositions;

	{
		private _vehicle = (selectRandom (((configUnits # 0) # 1) # 2)) createVehicle (_x # 0);
		_vehicle setVariable ["spawnTrigger", _reinforcementsId];
		_vehicle setDir (_x # 1);

		_allVehicles pushBack _vehicle;

		private _crew = [_vehicle] call P27_fnc_createCrew;
		{_x setVariable ["spawnTrigger", _reinforcementsId]} forEach _crew;

		private _grp = group (_crew # 0);
		_grp setCombatMode "RED";

		private _wp = _grp addWaypoint [_sadPosition, 0];
		_wp setWaypointSpeed "FULL";
		_wp setWaypointType "SAD";
	} forEach _roadPositions;
};

[_allVehicles] call P27_fnc_addSpawnTriggerEventToVehicles;
[_reinforcementsId] spawn P27_fnc_removeReinforcements;