/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [_count] call P27_fnc_createIedOnRoads;
    
    Return:
		nothing
*/


params [["_count", 10]];

private _junkClasses = (configObjects # 0) # 1;
private _mineClasses = (configObjects # 0) # 0;

private _roadIedPositions = [_count] call P27_fnc_getRandomRoadPosition;

private _allRoadIed = [];

for [{private _i = 0 }, { _i < (count _roadIedPositions) }, { _i = _i + 1 }] do {
	private _roadPosition = (_roadIedPositions # _i) # 0;

	private _ied = createMine [selectRandom _mineClasses, _roadPosition, [], 3];

	if ((random 1) < 0.7) then {
		createVehicle [selectRandom _junkClasses, position _ied, [], 0, "CAN_COLLIDE"];
	};

	_allRoadIed pushBack _ied;
	
	if (debugMode) then {
		["ied_" + str _roadPosition, _roadPosition, "ELLIPSE", [3, 3], "COLOR:", "ColorRed", "ALPHA:", 1, "PERSIST"] call CBA_fnc_createMarker;
	};
};

private _roadJunkPositions = [_count] call P27_fnc_getRandomRoadPosition;

for [{private _i = 0 }, { _i < (count _roadJunkPositions) }, { _i = _i + 1 }] do {
	private _junk = createVehicle [selectRandom _junkClasses, (_roadJunkPositions # _i) # 0, [], 0, "CAN_COLLIDE"];
};

missionNamespace setVariable ["iedOnRoads", _allRoadIed, true];