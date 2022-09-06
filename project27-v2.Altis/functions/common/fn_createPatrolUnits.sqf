/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
		[] call P27_fnc_createPatrolUnits
*/


params ["_positionOrTrigger", ["_sectorRadius", 100], ["_spawnConfig", [1, 1]], ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0]];

if ((_spawnConfig # 0) == 0) exitWith {};


private ["_sectorTrigger"];

if (typeName _positionOrTrigger != "ARRAY") then {
	_sectorTrigger = _positionOrTrigger;
	_positionOrTrigger = position _sectorTrigger;
};


for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {
	private _spawnPosition = [_positionOrTrigger, 10, _sectorRadius, 1, 0] call BIS_fnc_findSafePos;
	private _grp = createGroup [_unitSide, true];
	
	if (isNil "_spawnPosition") then {
		continue;
	};

	for [{private _i = 0 }, { _i < [_spawnConfig # 1] call P27_fnc_getNumberOfUnits }, { _i = _i + 1 }] do {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];

		if (!isNil "_sectorTrigger") then {
			_unit setVariable ["spawnTrigger", _sectorTrigger];
		};
		
		uiSleep 0.5;
	};

	_grp setBehaviour "SAFE";
	_grp setSpeedMode "LIMITED";
	_grp setCombatMode "YELLOW";
	_grp setFormation "STAG COLUMN";

	[_grp, _positionOrTrigger, _sectorRadius] call BIS_fnc_taskPatrol;
};