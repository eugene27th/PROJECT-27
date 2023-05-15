/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [] call P27_fnc_generateCheckpoints
*/


params [["_count", 10]];

if (_count < 1) exitWith {};

private _roadPositions = [_count] call P27_fnc_getRandomRoadPositions;

private _allTriggers = [];

for [{private _i = 0 }, { _i < (count _roadPositions) }, { _i = _i + 1 }] do {
	private _roadPosition = (_roadPositions # _i) # 0;
	private _roadDirection = (_roadPositions # _i) # 1;

	private _trgRadius = (configSectors # 1) + 100;

	private _trg = createTrigger ["EmptyDetector", _roadPosition, false];
	_trg setTriggerArea [_trgRadius, _trgRadius, 0, false, 800];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerTimeout [10, 10, 10, true];
	_trg setDir _roadDirection;
	_trg setTriggerStatements [
		"{vehicle _x in thisList && (speed _x < 160)} count allPlayers > 0",
		"[thisTrigger] call P27_fnc_createCheckpoint",
		""
	];

	_trg setVariable ["isActive", false];

	_allTriggers pushBack _trg;

	if (debugMode) then {
		["checkpoint_" + (str _roadPosition), _roadPosition, "ELLIPSE", [50, 50], "COLOR:", "ColorBlack", "ALPHA:", 0.7, "PERSIST"] call CBA_fnc_createMarker;
	};
};

missionNamespace setVariable ["checkpointTriggers", _allTriggers];