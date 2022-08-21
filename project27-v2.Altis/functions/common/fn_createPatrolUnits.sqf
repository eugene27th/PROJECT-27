/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
    
    Return:
		nothing
*/


params ["_positionOrTrigger", ["_sectorRadius", 100], ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0], ["_spawnConfig", [1, 1]]];

if ((_spawnConfig # 0) == 0) exitWith {};


private ["_sectorTrigger", "_centerPosition"];

if (typeName _positionOrTrigger != "ARRAY") then {
	_sectorTrigger = _positionOrTrigger;
	_centerPosition = position _sectorTrigger;
};


for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {
	private _spawnPosition = [_centerPosition, 10, _sectorRadius, 1, 0] call BIS_fnc_findSafePos;
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

	for "_i" from 1 to 7 do {
		private _wpPosition = [_centerPosition, 10, _sectorRadius, 1, 0] call BIS_fnc_findSafePos;
		
		private _wp = _grp addWaypoint [_wpPosition, 0];
		_wp setWaypointCompletionRadius 10;

		if (_i == 7) exitWith {
			_wp setWaypointType "CYCLE";
		};

		_wp setWaypointType "MOVE";
	};
};