/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
    
    Return:
		nothing
*/


params ["_positionOrTrigger", ["_sectorRadius", 100], ["_vehClassNames", ((configUnits # 0) # 1) # 2], ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0], ["_spawnConfig", [1, 1]]];

if ((_spawnConfig # 0) == 0) exitWith {};


private ["_sectorTrigger", "_centerPosition"];

if (typeName _positionOrTrigger != "ARRAY") then {
	_sectorTrigger = _positionOrTrigger;
	_centerPosition = position _sectorTrigger;
};


private _vehicles = [];

private _roads = ((_centerPosition) nearRoads _sectorRadius) select {isOnRoad _x};

for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {

	if ((random 1) > _spawnConfig # 1) then {
		continue;
	};

	([1, _centerPosition, _sectorRadius] call P27_fnc_getRandomRoadPositions) params ["_roadPosition", "_roadDirection"];


	private _vehicle = (selectRandom _vehClassNames) createVehicle _roadPosition;
	_vehicle setVariable ["spawnTrigger", _sectorTrigger];
	_vehicle setDir _roadDirection;
	_vehicles pushBack _vehicle;

	uiSleep 0.5;


	private _grp = createGroup [_unitSide, true];

	if ((_vehicle emptyPositions "commander") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _roadPosition, [], 0, "NONE"];
		
		if (!isNil "_sectorTrigger") then {
			_unit setVariable ["spawnTrigger", _sectorTrigger];
		};

		_unit moveInCommander _vehicle;
	};

	if ((_vehicle emptyPositions "gunner") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _roadPosition, [], 0, "NONE"];
		
		if (!isNil "_sectorTrigger") then {
			_unit setVariable ["spawnTrigger", _sectorTrigger];
		};

		_unit moveInGunner _vehicle;
	};

	if ((_vehicle emptyPositions "driver") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _roadPosition, [], 0, "NONE"];
		
		if (!isNil "_sectorTrigger") then {
			_unit setVariable ["spawnTrigger", _sectorTrigger];
		};

		_unit moveInDriver _vehicle;
	};
	
	uiSleep 0.5;


	private _emptySeats = round (random (_vehicle emptyPositions "cargo"));

	for "_i" from 1 to _emptySeats do {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _roadPosition, [], 0, "NONE"];
		
		if (!isNil "_sectorTrigger") then {
			_unit setVariable ["spawnTrigger", _sectorTrigger];
		};

		_unit moveInCargo _vehicle;
		uiSleep 0.5;
	};

	_grp setBehaviour "SAFE";
	_grp setSpeedMode "LIMITED";
	_grp setCombatMode "YELLOW";


	for "_i" from 1 to 3 do {
		private "_wpPosition";

		if ((count _roads) > 5) then {
			private _road = selectRandom _roads;
			_wpPosition = getPos _road;
			_wpPosition set [2, 0];
		} else {
			_wpPosition = [_centerPosition, 0, _sectorRadius, 5, 0] call BIS_fnc_findSafePos;
		};

		private _wp = _grp addWaypoint [_wpPosition, 0];
		_wp setWaypointCompletionRadius 20;

		if (_i == 3) exitWith {
			_wp setWaypointType "CYCLE";
		};

		_wp setWaypointType "MOVE";
	};
};

if (!isNil "_sectorTrigger") then {
	[_vehicles] call P27_fnc_addSpawnTriggerEventToVehicles;
};
