/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [] call P27_fnc_generateSectors
*/

private _allLocations = [
	"NameCityCapital",
	"NameCity",
	"NameVillage",
	"NameLocal",
	"Hill",
	"RockArea",
	"VegetationBroadleaf",
	"VegetationFir",
	"VegetationPalm",
	"VegetationVineyard",
	"ViewPoint",
	"BorderCrossing"
];

private _safeDistance = configSectors # 0;
private _sectorDistance = configSectors # 1;
private _spawnLocations = configSectors # 2;

private _worldSize = worldSize;
private _worldCenter = [_worldSize / 2, _worldSize / 2, 0];

private _locationsInSafeZone = nearestLocations [position respawn, _allLocations, _safeDistance];

private _allTriggers = [];

for [{private _a = 0 }, { _a < (count _spawnLocations) }, { _a = _a + 1 }] do {
	private _locations = (nearestLocations [_worldCenter, [(_spawnLocations # _a) # 0], _worldSize * 1.5]) - _locationsInSafeZone;
	private _sectorRadius = (_spawnLocations # _a) # 1;

	for [{private _i = 0 }, { _i < (count _locations) }, { _i = _i + 1 }] do {
		private _location = _locations # _i;
		private _locationPos = locationPosition _location;
		private _trgRadius = _sectorDistance + _sectorRadius;

		private _nearLocations = _locations select {(_x distance _location) < _trgRadius};

		if ((count _nearLocations) > 1) then {
			_locations set [(_locations find _location), [0, 0, 0]];
			continue;
		};

		private _trg = createTrigger ["EmptyDetector", _locationPos, false];
		_trg setTriggerArea [_trgRadius, _trgRadius, 0, false, 800];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerTimeout [10, 10, 10, true];
		_trg setTriggerStatements [
			"{vehicle _x in thisList && (speed _x < 160)} count allPlayers > 0",
			"[thisTrigger] call P27_fnc_createSector",
			""
		];

		_trg setVariable ["isActive", false];
		_trg setVariable ["isCaptured", false];
		_trg setVariable ["spawnConfig", (_spawnLocations # _a) # 2];

		_allTriggers pushBack _trg;

		if (debugMode) then {
			["sector_" + str _locationPos, _locationPos, "ELLIPSE", [_trgRadius, _trgRadius], "COLOR:", "ColorBLUFOR", "ALPHA:", 0.1, "PERSIST"] call CBA_fnc_createMarker;
			["sectorTrigger_" + str _locationPos, _locationPos, "ELLIPSE", [_sectorRadius, _sectorRadius], "COLOR:", "ColorOPFOR", "ALPHA:", 0.2, "PERSIST"] call CBA_fnc_createMarker;
		};
	};
};

if (debugMode) then {
	["_safeDistance", position respawn, "ELLIPSE", [_safeDistance, _safeDistance], "COLOR:", "ColorOrange", "ALPHA:", 0.05, "PERSIST"] call CBA_fnc_createMarker;
};

missionNamespace setVariable ["sectorTriggers", _allTriggers];