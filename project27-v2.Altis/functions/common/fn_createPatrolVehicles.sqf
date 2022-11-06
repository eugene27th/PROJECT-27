/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
		[] call P27_fnc_createPatrolVehicles
*/


params ["_positionOrTrigger", ["_sectorRadius", 100], ["_spawnConfig", [1, 1]], ["_vehClassNames", ((configUnits # 0) # 1) # 3], ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0]];

if ((_spawnConfig # 0) == 0) exitWith {};


private ["_sectorTrigger"];

if (typeName _positionOrTrigger != "ARRAY") then {
	_sectorTrigger = _positionOrTrigger;
	_positionOrTrigger = position _sectorTrigger;
};


private _vehicles = [];
private _roadPositions = [_spawnConfig # 0, _positionOrTrigger, _sectorRadius] call P27_fnc_getRandomRoadPositions;

for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {

	if ((random 1) > _spawnConfig # 1) then {
		continue;
	};

	private _spawnPosition = (_roadPositions # _i) # 0;
	private _spawnDirection = (_roadPositions # _i) # 1;

	private _vehicle = (selectRandom _vehClassNames) createVehicle _spawnPosition;
	_vehicle setVariable ["spawnTrigger", _sectorTrigger];
	_vehicle setDir _spawnDirection;
	_vehicles pushBack _vehicle;

	uiSleep 0.5;


	private _vehicleCrew = [_vehicle, _unitClassNames, _unitSide] call P27_fnc_createCrew;

	if (!isNil "_sectorTrigger") then {
		{_x setVariable ["spawnTrigger", _sectorTrigger]} forEach _vehicleCrew;
	};

	private _grp = group (_vehicleCrew # 0);
	private _wpPositions = [3, _positionOrTrigger, _sectorRadius] call P27_fnc_getRandomRoadPositions;
	
	for "_i" from 0 to 2 do {
		private _wp = _grp addWaypoint [(_wpPositions # _i) # 0, 0];
		_wp setWaypointCompletionRadius 20;

		if (_i == 2) exitWith {
			_wp setWaypointType "CYCLE";
		};

		_wp setWaypointType "MOVE";
	};
};

if (!isNil "_sectorTrigger") then {
	[_vehicles] call P27_fnc_addSpawnTriggerEventToVehicles;
};
