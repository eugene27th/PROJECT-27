/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [_count] call P27_fnc_getRandomRoadPositions;
    
    Return:
		nothing
*/


params [["_count", 1]];


private _returnArray = [];
private _allRoads = (_worldCenter nearRoads (_worldSize * 1.5)) - ((position respawn) nearRoads (configSectors # 0));

for [{private _i = 0 }, { _i < _count }, { _i = _i + 1 }] do {
	private _randomRoad = selectRandom _allRoads;

	private _roadPosition = getPos _randomRoad;
	private _roadDirection = _randomRoad getDir ((roadsConnectedTo _randomRoad) select 0);

	if (isNil "_direction") then {
		_roadDirection = 0;
	};

	_allRoads deleteAt (_allRoads find _randomRoad);
	_returnArray pushBack [_roadPosition, _roadDirection];
};

_returnArray