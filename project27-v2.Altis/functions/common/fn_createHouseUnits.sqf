/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
		[] call P27_fnc_createHouseUnits
*/


params ["_positionOrTrigger", ["_sectorRadius", 100], ["_spawnConfig", [1, 1]], ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0]];

if ((_spawnConfig # 0) == 0) exitWith {};


private ["_sectorTrigger"];

if (typeName _positionOrTrigger != "ARRAY") then {
	_sectorTrigger = _positionOrTrigger;
	_positionOrTrigger = position _sectorTrigger;
};


private _allBuildings = nearestObjects [_positionOrTrigger, ["Building"], _sectorRadius];
private _usefulBuildings = _allBuildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};

private _freeBuildingPositions = [];

{
	private _buildingPositions = [_x] call CBA_fnc_buildingPositions;
	_freeBuildingPositions append _buildingPositions;
} forEach _usefulBuildings;

for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {
	if (count _freeBuildingPositions < 1) exitWith {};

	private _grp = createGroup [_unitSide, true];

	for [{private _i = 0 }, { _i < [_spawnConfig # 1] call P27_fnc_getNumberOfUnits }, { _i = _i + 1 }] do {
		if (count _freeBuildingPositions < 1) exitWith {};

		private _spawnPosition = selectRandom _freeBuildingPositions;
		
		private _unit = _grp createUnit [selectRandom _unitClassNames, _spawnPosition, [], 0, "NONE"];
		[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];
		
		if (!isNil "_sectorTrigger") then {
			_unit setVariable ["spawnTrigger", _sectorTrigger];
		};

		doStop _unit;

		_freeBuildingPositions deleteAt (_freeBuildingPositions find _spawnPosition);
		
		uiSleep 0.5;
	};
};