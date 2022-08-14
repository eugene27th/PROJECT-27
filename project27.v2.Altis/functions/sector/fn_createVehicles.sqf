/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [[_vehClassNames], [_unitClassNames], [_spawnConfig], _sectorTrigger, _sectorRadius, _enemySide = independent, _behaviour = "SAFE"] spawn P27_fnc_createVehicles;
    
    Return:
		nothing
*/

params ["_vehClassNames", "_unitClassNames", "_spawnConfig", "_sectorTrigger", "_sectorRadius", ["_enemySide", independent], ["_behaviour", "SAFE"]];


if ((_spawnConfig # 0) == 0) exitWith {};


private _triggerPosition = position _sectorTrigger;
private _vehicles = [];

private _roads = ((_triggerPosition) nearRoads _sectorRadius) select {isOnRoad _x};

for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {

	if ((random 1) > _spawnConfig # 1) then {
		continue;
	};

	private "_spawnPosition";
	private _direction = 0;

	if ((count _roads) > 5) then {
		_road = selectRandom _roads;

		_spawnPosition = getPos _road;
		_spawnPosition set [2, 0];

		_direction = _road getDir ((roadsConnectedTo _road) # 0);
	} else {
		_spawnPosition = [_triggerPosition, 0, _sectorRadius, 5, 0] call BIS_fnc_findSafePos;
	};

	if (isNil "_spawnPosition") then {
		continue;
	};

	// create crew
	private _vehicle = (selectRandom _vehClassNames) createVehicle _spawnPosition;
	_vehicle setVariable ["sectorTrigger", _sectorTrigger];
	_vehicle setDir _direction;
	_vehicles pushBack _vehicle;

	uiSleep 0.5;

	private _grp = createGroup [_enemySide, true];

	if ((_vehicle emptyPositions "commander") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		_unit setVariable ["sectorTrigger", _sectorTrigger];
		_unit moveInCommander _vehicle;
	};

	if ((_vehicle emptyPositions "gunner") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		_unit setVariable ["sectorTrigger", _sectorTrigger];
		_unit moveInGunner _vehicle;
	};

	if ((_vehicle emptyPositions "driver") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		_unit setVariable ["sectorTrigger", _sectorTrigger];
		_unit moveInDriver _vehicle;
	};
	
	uiSleep 0.5;

	//create passengers
	private _emptySeats = round (random (_vehicle emptyPositions "cargo"));

	for "_i" from 1 to _emptySeats do {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		_unit setVariable ["sectorTrigger", _sectorTrigger];
		_unit moveInCargo _vehicle;
		uiSleep 0.5;
	};

	_grp setBehaviour _behaviour;
	_grp setSpeedMode "LIMITED";
	_grp setCombatMode "YELLOW";

	//create waypoints
	for "_i" from 1 to 3 do {
		private "_wpPosition";

		if ((count _roads) > 5) then {
			private _road = selectRandom _roads;
			_wpPosition = getPos _road;
			_wpPosition set [2, 0];
		} else {
			_wpPosition = [_triggerPosition, 0, _sectorRadius, 5, 0] call BIS_fnc_findSafePos;
		};

		private _wp = _grp addWaypoint [_wpPosition, 0];
		_wp setWaypointCompletionRadius 20;

		if (_i == 3) exitWith {
			_wp setWaypointType "CYCLE";
		};

		_wp setWaypointType "MOVE";
	};
};

{
	_x addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];

		if (isPlayer _unit) then {
			_vehicle removeEventHandler ["GetIn", _thisEventHandler];
			_vehicle setVariable ["sectorTrigger", nil, true];
		};
	}];
} forEach _vehicles;