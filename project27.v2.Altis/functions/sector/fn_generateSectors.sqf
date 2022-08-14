/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [] call P27_fnc_generateSectors;
    
    Return:
		nothing
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

for [{private _i = 0 }, { _i < (count _spawnLocations) }, { _i = _i + 1 }] do {

	private _locations = (nearestLocations [_worldCenter, [(_spawnLocations # _i) # 0], _worldSize * 1.5]) - _locationsInSafeZone;
	private _sectorRadius = (_spawnLocations # _i) # 1;

	{
		private _locationPos = locationPosition _x;
		private _trgRadius = _sectorDistance + _sectorRadius;

		private _trg = createTrigger ["EmptyDetector", _locationPos, false];
		_trg setTriggerArea [_trgRadius, _trgRadius, 0, false, 800];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerTimeout [10, 10, 10, true];
		// "({vehicle _x in thisList && isplayer _x && (speed _x < 160)} count playableUnits > 0) || ",
		_trg setTriggerStatements [
			"{vehicle _x in thisList && (speed _x < 160)} count allPlayers > 0",
			"[thisTrigger] call P27_fnc_createSector",
			""
		];

		_trg setVariable ["isActive", false];
		_trg setVariable ["isCaptured", false];
		_trg setVariable ["spawnConfig", (_spawnLocations # _i) # 2];

		_allTriggers pushBack _trg;

		if (debugMode) then {
			private _sectorMarker = "sectorMarker_" + str _locationPos;
			private _triggerMarker = "sectorTriggerMarker_" + str _locationPos;

			[_sectorMarker, _locationPos, "ELLIPSE", [_trgRadius, _trgRadius], "COLOR:", "ColorBLUFOR", "ALPHA:", 0.1, "PERSIST"] call CBA_fnc_createMarker;
			[_triggerMarker, _locationPos, "ELLIPSE", [_sectorRadius, _sectorRadius], "COLOR:", "ColorOPFOR", "ALPHA:", 0.2, "PERSIST"] call CBA_fnc_createMarker;
		};
	} forEach _locations;
};

if (debugMode) then {
	["_safeDistanceMarker", position respawn, "ELLIPSE", [_safeDistance, _safeDistance], "COLOR:", "ColorOrange", "ALPHA:", 0.05, "PERSIST"] call CBA_fnc_createMarker;
};

missionNamespace setVariable ["sectorTriggers", _allTriggers];