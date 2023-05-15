/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [] call P27_fnc_generateSectors
*/


private _createSectorTrigger = {
	params ["_pos", "_radius", "_config"];

	private _trg = createTrigger ["EmptyDetector", _pos, false];
	_trg setTriggerArea [_radius, _radius, 0, false, 800];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerTimeout [3, 3, 3, true];
	_trg setTriggerStatements [
		"{vehicle _x in thisList && (speed _x < 160)} count allPlayers > 0",
		"[thisTrigger] call P27_fnc_createSector",
		""
	];

	// "(({vehicle _x in thisList && (speed _x < 160)} count allPlayers > 0) || ('Land_DataTerminal_01_F' in (((position thisTrigger) nearObjects ((triggerArea thisTrigger) # 0)) apply { typeOf _x })))",

	_trg setVariable ["isActive", false];
	_trg setVariable ["isCaptured", false];
	_trg setVariable ["spawnConfig", _config];

	sectorTriggers pushBack _trg;
};


private _allLocationsTypes = [
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

private _worldSize = worldSize;
private _worldCenter = [_worldSize / 2, _worldSize / 2, 0];


private _allLocations = (nearestLocations [_worldCenter, _allLocationsTypes, _worldSize * 1.5]) - (nearestLocations [position respawn, _allLocationsTypes, _safeDistance]);

if ((count (customSectors # 2)) > 0) then {
	{
		_allLocations = _allLocations - (nearestLocations [_x # 0, _allLocationsTypes, _x # 1]);

		if (debugMode) then {
			["customSectorDeleteZone#" + str (_x # 0), _x # 0, "ELLIPSE", [_x # 1, _x # 1], "COLOR:", "ColorYellow", "PERSIST"] call CBA_fnc_createMarker;
		};
	} forEach (customSectors # 2);
};


if (debugMode) then {
	["_safeDistance", position respawn, "ELLIPSE", [_safeDistance, _safeDistance], "COLOR:", "ColorOrange", "PERSIST"] call CBA_fnc_createMarker;
};


sectorTriggers = [];

if ((count (customSectors # 0)) > 0) then {
	{
		private _position = _x # 0;
		private _sectorRadius = _x # 1;
		private _triggerRadius = _sectorDistance + _sectorRadius;

		[_position, _triggerRadius, _x # 2] call _createSectorTrigger;

		if (debugMode) then {
			["customSector#" + str _position, _position, "ELLIPSE", [_sectorRadius, _sectorRadius], "COLOR:", "ColorWhite", "PERSIST"] call CBA_fnc_createMarker;
			["customSectorTrigger#" + str _position, _position, "ELLIPSE", [_triggerRadius, _triggerRadius], "COLOR:", "ColorBLUFOR", "PERSIST"] call CBA_fnc_createMarker;
		};
	} forEach (customSectors # 0);
};

if ((count (customSectors # 1)) > 0) then {
	private _allMapMarkers = allMapMarkers;

	{
		private _tag = _x # 0;
		
		private _markers = _allMapMarkers select {(_x find _tag) > -1};

		if ((count _markers) < 1) then {
			continue;
		};

		for [{private _i = 0 }, { _i < (count _markers) }, { _i = _i + 1 }] do {
			private _marker = _markers # _i;

			private _position = getMarkerPos _marker;
			private _sectorRadius = (getMarkerSize _marker) # 0;
			private _triggerRadius = _sectorDistance + _sectorRadius;

			[_position, _triggerRadius, _x # 1] call _createSectorTrigger;

			deleteMarker _marker;

			if (debugMode) then {
				["customSector#" + str _position, _position, "ELLIPSE", [_sectorRadius, _sectorRadius], "COLOR:", "ColorWhite", "PERSIST"] call CBA_fnc_createMarker;
				["customSectorTrigger#" + str _position, _position, "ELLIPSE", [_triggerRadius, _triggerRadius], "COLOR:", "ColorBLUFOR", "PERSIST"] call CBA_fnc_createMarker;
			};
		};
	} forEach (customSectors # 1);
};

if ((count (configSectors # 2)) > 0) then {
	for [{private _a = 0 }, { _a < (count _allLocations) }, { _a = _a + 1 }] do {
		private _location = _allLocations # _a;
		private _locationType = type _location;

		private "_locationConfig";

		{
			if ((_x # 0) == _locationType) then {
				_locationConfig = _x;
			};
		} forEach (configSectors # 2);

		if (isNil "_locationConfig") then {
			if (debugMode) then {
				diag_log (format ["[PROJECT 27] WARNING: Config not found for: %1.", _locationType]);
				systemChat format ["Config not found for: %1", _locationType];
			};

			continue;
		};

		private _locationPos = locationPosition _location;

		private _sectorRadius = _locationConfig # 1;
		private _trgRadius = _sectorDistance + _sectorRadius;

		private _nearLocations = _allLocations select {((_x distance _location) < (_trgRadius + 150)) && !(_x isEqualTo _location)};

		if ((count _nearLocations) > 0) then {
			private _spawnAllowed = true;

			{
				private _locationTypeIndex = _allLocationsTypes find _locationType;
				private _nearLocationTypeIndex = _allLocationsTypes find (type _x);

				if (_locationTypeIndex >= _nearLocationTypeIndex) exitWith {
					_allLocations set [(_allLocations find _location), [0, 0, 0]];
					_spawnAllowed = false;
				};
			} forEach _nearLocations;

			if (!_spawnAllowed) then {
				if (debugMode) then {
					["sectorBlack#" + str _locationPos, _locationPos, "ELLIPSE", [_sectorRadius, _sectorRadius], "COLOR:", "ColorRED", "PERSIST"] call CBA_fnc_createMarker;
				};

				continue;
			};
		};

		[_locationPos, _trgRadius, _locationConfig # 2] call _createSectorTrigger;

		if (debugMode) then {
			["sector#" + str _locationPos, _locationPos, "ELLIPSE", [_sectorRadius, _sectorRadius], "COLOR:", "ColorWhite", "PERSIST"] call CBA_fnc_createMarker;
			["sectorTrigger#" + str _locationPos, _locationPos, "ELLIPSE", [_trgRadius, _trgRadius], "COLOR:", "ColorBLUFOR", "PERSIST"] call CBA_fnc_createMarker;
		};	
	};
};


missionNamespace setVariable ["sectorTriggers", sectorTriggers];
[] call P27_fnc_updateSectorPositions;

if ((count sectorTriggers) < 1 && debugMode) then {
	diag_log "[PROJECT 27] WARNING: No sectors have been created.";
	systemChat "WARNING: No sectors have been created."
};