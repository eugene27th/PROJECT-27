/*
    Author: eugene27
    Date: 24.08.2022
    
    Example:
        [position, [1,1], "infantry"] spawn P27_fnc_createReinforcements
*/


params ["_sadPosition", ["_spawnConfig", [1,1]], ["_type", "random"]];

if ((_spawnConfig # 0) < 1 || (_spawnConfig # 1) < 1 || !(_type in ["ground", "air", "infantry", "random"])) exitWith {};


private _allSectorTriggers = (missionNamespace getVariable "sectorTriggers") select {!(_x getVariable "isCaptured") && !(_x getVariable "isActive") && ((_x distance _sadPosition) > 500)};

if ((count _allSectorTriggers) < 1) exitWith {};

_allSectorTriggers = [_allSectorTriggers, [], { _sadPosition distance _x }, "ASCEND"] call BIS_fnc_sortBy;


if (_type == "random") then {
	private _random = random 1;

	switch (true) do {
		case (_random > 0.5): { _type = "ground" };
		case (_random > 0.2): { _type = "infantry" };
		case (_random > 0): { _type = "air" };
	};
};


private _allVehicles = [];
private _reinforcementsId = "reinforcements#" + (str serverTime);


switch (_type) do {
	case "infantry": {
		private _spawnPosition = [position (_allSectorTriggers # 0), 0, 300, 3, 0] call BIS_fnc_findSafePos;

		if (isNil "_spawnPosition") exitWith {};

		private _grp = createGroup [(configUnits # 0) # 0, true];

		_grp setBehaviour "COMBAT";
		_grp setSpeedMode "FULL";
		_grp setCombatMode "RED";
		_grp setFormation "STAG COLUMN";

		for [{private _i = 0 }, { _i < ([_spawnConfig # 0, _spawnConfig # 1] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
			private _unit = _grp createUnit [selectRandom (((configUnits # 0) # 1) # 0), _spawnPosition, [], 0, "NONE"];
			[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];

			_unit setVariable ["spawnTrigger", _reinforcementsId];
			
			uiSleep 0.5;
		};
		
		(_grp addWaypoint [_sadPosition, 0]) setWaypointType "SAD";
	};

	case "ground": {
		private _vehicleClasses = ((((configUnits # 0) # 1) # 1) + (((configUnits # 0) # 1) # 2));

		if (isNil "_vehicleClasses" || _vehicleClasses isEqualTo []) exitWith {
			[_sadPosition, _spawnConfig, "infantry"] spawn P27_fnc_createReinforcements;
		};

		_spawnConfig params ["_maxCountSectors", "_maxCountVehicles"];

		if (_maxCountSectors > (count _allSectorTriggers)) then {
			_maxCountSectors = (count _allSectorTriggers);
		};
		
		for [{private _i = 0 }, { _i < ([1, _maxCountSectors] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
			private _roadPositions = [[1, _maxCountVehicles] call BIS_fnc_randomInt, position (_allSectorTriggers # _i), 300] call P27_fnc_getRandomRoadPositions;

			{
				private _vehicle = (selectRandom _vehicleClasses) createVehicle (_x # 0);
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

	case "air": {
		private _heliClasses = ((configUnits # 0) # 1) # 5;

		if (isNil "_heliClasses" || _heliClasses isEqualTo []) exitWith {
			[_sadPosition, _spawnConfig, "ground"] spawn P27_fnc_createReinforcements;
		};

		_spawnConfig params ["_maxCountSectors", "_maxCountVehicles"];

		if (_maxCountSectors > (count _allSectorTriggers)) then {
			_maxCountSectors = (count _allSectorTriggers);
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
};

[_allVehicles] call P27_fnc_addSpawnTriggerEventToVehicles;
[_reinforcementsId] spawn P27_fnc_removeReinforcements;