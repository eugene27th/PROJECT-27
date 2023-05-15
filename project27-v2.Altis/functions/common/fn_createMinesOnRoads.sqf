/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [] call P27_fnc_createMinesOnRoads
*/


params [["_count", 10]];

private _junkClasses = (configObjects # 0) # 1;
private _mineClasses = (configObjects # 0) # 0;

if ((count _mineClasses) < 1 || _count < 1) exitWith {};

private _roadPositions = [_count] call P27_fnc_getRandomRoadPositions;

for [{private _i = 0 }, { _i < (count _roadPositions) }, { _i = _i + 1 }] do {
	private _roadPosition = (_roadPositions # _i) # 0;

	private _mine = createMine [selectRandom _mineClasses, _roadPosition, [], 5];

	if (junkOnMines && ((count _junkClasses) > 0) && ((random 1) < 0.6)) then {
		createVehicle [selectRandom _junkClasses, position _mine, [], 0, "CAN_COLLIDE"];
	};

	((configUnits # 0) # 0) revealMine _mine;
	
	if (debugMode) then {
		["ied_" + (str _roadPosition), _roadPosition, "ELLIPSE", [20, 20], "COLOR:", "ColorBlue", "ALPHA:", 1, "PERSIST"] call CBA_fnc_createMarker;
	};
};


private _roadJunkPositions = [_count] call P27_fnc_getRandomRoadPositions;

for [{private _i = 0 }, { _i < (count _roadJunkPositions) }, { _i = _i + 1 }] do {
	private _junk = createVehicle [selectRandom _junkClasses, (_roadJunkPositions # _i) # 0, [], 0, "CAN_COLLIDE"];
};