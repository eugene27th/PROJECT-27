/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [[_unitClassNames], [_spawnConfig], _sectorTrigger, _sectorRadius, _enemySide = independent, _voice = false] spawn P27_fnc_createHouseGroups;
    
    Return:
		nothing
*/

params ["_unitClassNames", "_spawnConfig", "_sectorTrigger", "_sectorRadius", ["_enemySide", independent], ["_voice", false]];


if ((_spawnConfig # 0) == 0) exitWith {};


private _freeBuildingPositions = [];

private _triggerPosition = position _sectorTrigger;

private _allBuildings = nearestObjects [_triggerPosition, ["Building"], _sectorRadius];
private _usefulBuildings = _allBuildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};

{
	private _buildingPositions = [_x] call CBA_fnc_buildingPositions;
	_freeBuildingPositions append _buildingPositions;
} forEach _usefulBuildings;

for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {
	if (count _freeBuildingPositions < 1) exitWith {};

	private _grp = createGroup [_enemySide, true];

	for [{private _i = 0 }, { _i < [_spawnConfig # 1] call P27_fnc_getNumberOfUnits }, { _i = _i + 1 }] do {
		if (count _freeBuildingPositions < 1) exitWith {};

		private _spawnPosition = selectRandom _freeBuildingPositions;
		
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		_unit setVariable ["sectorTrigger", _sectorTrigger];

		doStop _unit;

		if (!_voice) then {
			[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];
		};

		_freeBuildingPositions deleteAt (_freeBuildingPositions find _spawnPosition);
		
		uiSleep 0.5;
	};
};