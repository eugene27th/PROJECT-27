/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [[_unitClassNames], [_spawnConfig], _sectorTrigger, _sectorRadius, _enemySide = independent, _voice = false] spawn P27_fnc_createPatrolGroups;
    
    Return:
		nothing
*/

params ["_unitClassNames", "_spawnConfig", "_sectorTrigger", "_sectorRadius", ["_enemySide", independent], ["_voice", false]];


if ((_spawnConfig # 0) == 0) exitWith {};


private _triggerPosition = position _sectorTrigger;

for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {
	private _spawnPosition = [_triggerPosition, 10, _sectorRadius, 1, 0] call BIS_fnc_findSafePos;
	private _grp = createGroup [_enemySide, true];
	
	if (isNil "_spawnPosition") then {
		continue;
	};

	for [{private _i = 0 }, { _i < [_spawnConfig # 1] call P27_fnc_getNumberOfUnits }, { _i = _i + 1 }] do {
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		_unit setVariable ["sectorTrigger", _sectorTrigger];

		if (!_voice) then {
			[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];
		};

		uiSleep 0.5;
	};

	_grp setBehaviour "SAFE";
	_grp setSpeedMode "LIMITED";
	_grp setCombatMode "YELLOW";
	_grp setFormation "STAG COLUMN";

	for "_i" from 1 to 7 do {
		private _wpPosition = [_triggerPosition, 10, _sectorRadius, 1, 0] call BIS_fnc_findSafePos;
		
		private _wp = _grp addWaypoint [_wpPosition, 0];
		_wp setWaypointCompletionRadius 10;

		if (_i == 7) exitWith {
			_wp setWaypointType "CYCLE";
		};

		_wp setWaypointType "MOVE";
	};
};