/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [[_turretClassNames], [_unitClassNames], [_spawnConfig], _sectorTrigger, _sectorRadius, _enemySide = independent] spawn P27_fnc_createTurrets;
    
    Return:
		nothing
*/

params ["_turretClassNames", "_unitClassNames", "_spawnConfig", "_sectorTrigger", "_sectorRadius", ["_enemySide", independent]];


if ((_spawnConfig # 0) == 0) exitWith {};


private _triggerPosition = position _sectorTrigger;
private _turrets = [];

for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {

	if ((random 1) > _spawnConfig # 1) then {
		continue;
	};

	private _spawnPosition = [_triggerPosition, 0, _sectorRadius, 5, 0] call BIS_fnc_findSafePos;

	if (isNil "_spawnPosition") then {
		continue;
	};

	private _turret = (selectRandom _turretClassNames) createVehicle _spawnPosition;
	_turret setVariable ["sectorTrigger", _sectorTrigger];
	_turret setDir ([0,359] call BIS_fnc_randomInt);
	_turrets pushBack _turret;

	private _grp = createGroup [_enemySide, true];

	if ((_turret emptyPositions "gunner") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		_unit setVariable ["sectorTrigger", _sectorTrigger];
		_unit moveInGunner _turret;
	};

	if ((_turret emptyPositions "commander") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		_unit setVariable ["sectorTrigger", _sectorTrigger];
		_unit moveInCommander _turret;
	};

	uiSleep 0.5;
};

{
	_x addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];

		if (isPlayer _unit) then {
			_vehicle removeEventHandler ["GetIn", _thisEventHandler];
			_vehicle setVariable ["sectorTrigger", nil, true];
		};
	}];
} forEach _turrets;