/*
    Author: eugene27
    Date: 24.08.2022
    
    Example:
        [] spawn P27_fnc_createReinforcements
*/


params ["_sadPosition", ["_spawnConfig", [1,1]], ["_type", "ground"]];

_spawnConfig params ["_maxCountSectors", "_maxCountVehicles"];

if (_maxCountSectors < 1 || _maxCountVehicles < 1 || !(_type in ["ground", "air", "random"])) exitWith {};


private _allSectorTriggers = (missionNamespace getVariable "sectorTriggers") select {!(_x getVariable "isCaptured") && !(_x getVariable "isActive") && ((_x distance _sadPosition) > 500)};

if ((count _allSectorTriggers) < 1) exitWith {};

if (_maxCountSectors > (count _allSectorTriggers)) then {
	_maxCountSectors = (count _allSectorTriggers);
};


private _allVehicles = [];
private _reinforcementsId = "reinforcements#" + (str serverTime);

_allSectorTriggers = [_allSectorTriggers, [], {_sadPosition distance _x}, "ASCEND"] call BIS_fnc_sortBy;


if (_type == "random") then {
	_type = selectRandom ["ground", "air"];
};

if (_type == "ground") then {
	for [{private _i = 0 }, { _i < ([1, _maxCountSectors] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
		private _roadPositions = [[1, _maxCountVehicles] call BIS_fnc_randomInt, position (_allSectorTriggers # _i), 300] call P27_fnc_getRandomRoadPositions;

		{
			private _vehicle = (selectRandom ((((configUnits # 0) # 1) # 1) + (((configUnits # 0) # 1) # 2))) createVehicle (_x # 0);
			_vehicle setVariable ["spawnTrigger", _reinforcementsId];
			_vehicle setDir (_x # 1);

			_allVehicles pushBack _vehicle;

			private _crew = [_vehicle] call P27_fnc_createCrew;
			{_x setVariable ["spawnTrigger", _reinforcementsId]} forEach _crew;

			private _grp = group (_crew # 0);
			_grp setCombatMode "RED";

			private _wp = _grp addWaypoint [_sadPosition, 0];
			_wp setWaypointSpeed "FULL";
			_wp setWaypointType "SAD";

			uiSleep 1;
		} forEach _roadPositions;
	};
};

if (_type == "air") then {
	private _heliClasses = ((configUnits # 0) # 1) # 5;

	if (isNil "_heliClasses" || _heliClasses isEqualTo []) exitWith {
		[_sadPosition, _spawnConfig, "ground"] spawn P27_fnc_createReinforcements;
	};


	private _availableSectorTriggers = [];

	for [{private _i = 0 }, { _i < (count _allSectorTriggers) }, { _i = _i + 1 }] do {
		private _sectorTrigger = _allSectorTriggers # _i;

		if ((_sectorTrigger distance _sadPosition) < 3000) then {
			continue;
		};

		private _nearPlayers = allPlayers select {(_x distance _sectorTrigger) < 1500};

		if ((count _nearPlayers) < 1) then {
			_availableSectorTriggers pushBack _sectorTrigger;
		};
	};


	for [{private _i = 0 }, { _i < ([1, _maxCountSectors] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
		private _sectorPosition = position (_availableSectorTriggers # _i);

		for [{private _i = 0 }, { _i < ([1, _maxCountVehicles] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
			private _spawnPosition = [_sectorPosition, 300, [0, 359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
			private _landingPosition = [_sadPosition, 700, 1000, 5, 0, 0.5, 0, []] call BIS_fnc_findSafePos;

			if (isNil "_spawnPosition" || isNil "_landingPosition") then {
				continue;
			};

			private _helipad = createVehicle ["Land_HelipadEmpty_F", _landingPosition];

			if (isNil "_helipad") then {
				continue;
			};

			private _vehicle = createVehicle [(selectRandom _heliClasses), _spawnPosition, [], 0, "FLY"];
			_vehicle setVariable ["spawnTrigger", _reinforcementsId];

			_allVehicles pushBack _vehicle;
			

			private _crew = [_vehicle] call P27_fnc_createCrew;
			{_x setVariable ["spawnTrigger", _reinforcementsId]} forEach _crew;

			private _crewGrp = group (_crew # 0);
			_crewGrp setCombatMode "RED";

			private _cargoGrp = createGroup ((configUnits # 0) # 0);
			_cargoGrp setCombatMode "RED";

			private _cargoUnits = assignedCargo _vehicle;
			_cargoUnits join _cargoGrp;


			private _wpCrew = _crewGrp addWaypoint [_landingPosition, 0];  
			_wpCrew setWaypointSpeed "FULL";
			_wpCrew setWaypointType "TR UNLOAD";

			private _wpCargo = _cargoGrp addWaypoint [_landingPosition, 0];  
			_wpCargo setWaypointSpeed "FULL";
			_wpCargo setWaypointType "GETOUT";

			_wpCrew synchronizeWaypoint [_wpCargo];

			private _wpCrew = _crewGrp addWaypoint [[0, 0, 0], 0];  
			_wpCrew setWaypointSpeed "FULL";
			_wpCrew setWaypointType "MOVE";

			private _wpCargo = _cargoGrp addWaypoint [_sadPosition, 0];  
			_wpCargo setWaypointSpeed "FULL";
			_wpCargo setWaypointType "SAD";

			uiSleep 1;
		};
	};
};

[_allVehicles] call P27_fnc_addSpawnTriggerEventToVehicles;
[_reinforcementsId] spawn P27_fnc_removeReinforcements;