/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
		[] call P27_fnc_createCrew
*/


params ["_vehicle", ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0]];

private _grp = createGroup [_unitSide, true];
private _spawnPosition = position _vehicle;
private _crew = [];

_grp setBehaviour "SAFE";
_grp setSpeedMode "LIMITED";
_grp setCombatMode "YELLOW";


if ((_vehicle emptyPositions "commander") != 0) then {
	private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
	_crew pushBack _unit;
	_unit moveInCommander _vehicle;
};

if ((_vehicle emptyPositions "gunner") != 0) then {
	private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];

	_crew pushBack _unit;
	_unit moveInGunner _vehicle;
};

if ((_vehicle emptyPositions "driver") != 0) then {
	private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
	_crew pushBack _unit;
	_unit moveInDriver _vehicle;
};


private _emptySeats = round (random (_vehicle emptyPositions "cargo"));

for "_i" from 1 to _emptySeats do {
	private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
	_crew pushBack _unit;
	_unit moveInCargo _vehicle;
};

_crew