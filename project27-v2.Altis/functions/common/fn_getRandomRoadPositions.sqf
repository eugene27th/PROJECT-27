/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [] call P27_fnc_getRandomRoadPositions
*/


params [["_count", 1], "_centerPosition", "_radius"];


private _returnArray = [];

if (isNil "_centerPosition") then {
	private _worldSize = worldSize;
	_centerPosition = [_worldSize / 2, _worldSize / 2, 0];
	_radius = _worldSize * 1.5;
};

private _allRoads = (_centerPosition nearRoads _radius) - ((position respawn) nearRoads (configSectors # 0));

if ((count _allRoads) < _count) exitWith {
	[_centerPosition, 0, _radius, 5, 0] call BIS_fnc_findSafePos;
};

for [{private _i = 0 }, { _i < _count }, { _i = _i + 1 }] do {
	private _randomRoad = selectRandom _allRoads;

	private _roadPosition = getPos _randomRoad;
	private _roadDirection = _randomRoad getDir ((roadsConnectedTo _randomRoad) select 0);

	if (isNil "_roadDirection") then {
		_roadDirection = 0;
	};

	_allRoads deleteAt (_allRoads find _randomRoad);
	_returnArray pushBack [_roadPosition, _roadDirection];
};

_returnArray