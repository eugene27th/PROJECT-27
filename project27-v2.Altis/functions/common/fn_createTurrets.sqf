/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
		[] call P27_fnc_createTurrets
*/


params ["_positionOrTrigger", ["_sectorRadius", 100], ["_spawnConfig", [1, 1]], ["_turretClassNames", ((configUnits # 0) # 1) # 5], ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0]];

if ((_spawnConfig # 0) == 0) exitWith {};


private ["_sectorTrigger"];

if (typeName _positionOrTrigger != "ARRAY") then {
	_sectorTrigger = _positionOrTrigger;
	_positionOrTrigger = position _sectorTrigger;
};


private _turrets = [];

for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {

	if ((random 1) > _spawnConfig # 1) then {
		continue;
	};

	private _spawnPosition = [_positionOrTrigger, 0, _sectorRadius, 5, 0] call BIS_fnc_findSafePos;

	if (isNil "_spawnPosition") then {
		continue;
	};


	private _turret = (selectRandom _turretClassNames) createVehicle _spawnPosition;
	_turret setVariable ["spawnTrigger", _sectorTrigger];
	_turret setDir ([0,359] call BIS_fnc_randomInt);
	_turrets pushBack _turret;


	private _grp = createGroup [_unitSide, true];

	if ((_turret emptyPositions "gunner") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		
		if (!isNil "_sectorTrigger") then {
			_unit setVariable ["spawnTrigger", _sectorTrigger];
		};

		_unit moveInGunner _turret;
	};

	if ((_turret emptyPositions "commander") != 0) then {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		
		if (!isNil "_sectorTrigger") then {
			_unit setVariable ["spawnTrigger", _sectorTrigger];
		};

		_unit moveInCommander _turret;
	};

	uiSleep 0.5;
};

if (!isNil "_sectorTrigger") then {
	[_turrets] call P27_fnc_addSpawnTriggerEventToVehicles;
};
