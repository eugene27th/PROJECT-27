/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
		[] call P27_fnc_createCrew
*/


params ["_vehicle", ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0], ["_minCargo", 6]];

private _spawnPosition = position _vehicle;
private _vehicleCrewIndexes = (typeof _vehicle) call BIS_fnc_vehicleCrewTurrets;

private _grp = createGroup [_unitSide, true];

_grp setBehaviour "SAFE";
_grp setSpeedMode "LIMITED";
_grp setCombatMode "YELLOW";

private _createUnit = {
	private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
	_crew pushBack _unit;
	_unit;
};

private _crew = [];

{(call _createUnit) moveInAny _vehicle} forEach _vehicleCrewIndexes;

private _emptyCargoSeats = 0;

if (_minCargo != 0) then {
	_emptyCargoSeats = _vehicle emptyPositions "cargo";

	if (_emptyCargoSeats > _minCargo && _minCargo != -1) then {
		_emptyCargoSeats = [_minCargo, _emptyCargoSeats] call BIS_fnc_randomInt;
	};
};

for "_i" from 1 to _emptyCargoSeats do {
	(call _createUnit) moveInCargo _vehicle;
};

_crew