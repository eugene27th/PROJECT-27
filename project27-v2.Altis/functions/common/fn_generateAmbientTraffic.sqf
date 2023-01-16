/*
    Author: eugene27
    Date: 27.08.2022
    
    Example:
        [] call P27_fnc_generateAmbientTraffic
*/


[] spawn {
    while {true} do {
        uiSleep 900; 

        private _allPlayers = allPlayers select {(_x distance respawn) > (configSectors # 0)};
        private _allSectorTriggers = (missionNamespace getVariable ["sectorTriggers", []]) select {!(_x getVariable "isCaptured") && !(_x getVariable "isActive")};

        if ((count _allSectorTriggers) < 1 || (count _allPlayers) < 1) then {
            continue;
        };

        private _randomPlayer = selectRandom _allPlayers;
        private _nearestSectors = _allSectorTriggers select {(_x distance _randomPlayer) < 3000 && (_x distance _randomPlayer) > 1500};

        if ((count _nearestSectors) < 1) then {
            continue;
        };

        private _startSector = selectRandom _nearestSectors;

        private _dirFromStartToFinishPos = _startSector getPos [(_startSector distance _randomPlayer) + 4000, _startSector getDir _randomPlayer];
        private _nearestSectorsAroundFinishPos = _allSectorTriggers select {(_x distance _dirFromStartToFinishPos) < 2000};
        
        if ((count _nearestSectorsAroundFinishPos) < 1) then {
            continue;
        };

        private _startSectorPos = position _startSector;
        private _finishSectorPos = position (selectRandom _nearestSectorsAroundFinishPos);


        private _roadPositions = [1, _startSectorPos, 500] call P27_fnc_getRandomRoadPositions;

        private _vehicle = (selectRandom (((configUnits # 0) # 1) # 2)) createVehicle ((_roadPositions # 0) # 0);
        _vehicle setVariable ["spawnTrigger", "trafficVehicle"];
        _vehicle setDir (_startSectorPos getDir _finishSectorPos);

        [[_vehicle]] call P27_fnc_addSpawnTriggerEventToVehicles;


        private _vehicleCrew = [_vehicle, ((configUnits # 0) # 1) # 0, (configUnits # 0) # 0] call P27_fnc_createCrew;
        {_x setVariable ["spawnTrigger", "trafficVehicle"]} forEach _vehicleCrew;

        private _grp = group (_vehicleCrew # 0);
        private _wpPosition = [1, _finishSectorPos, 500] call P27_fnc_getRandomRoadPositions;
        
        private _wp = _grp addWaypoint [(_wpPosition # 0) # 0, 0];
        _wp setWaypointCompletionRadius 20;
        _wp setWaypointType "MOVE";

        ["trafficVehicle", _finishSectorPos, 500, 1500, 600, 30] spawn P27_fnc_removeFollowingVehicles;
    };
};

[] spawn {
    private _aaUnits = ["AA"] call P27_fnc_getConfigUnitClassesByType;

    if ((count _aaUnits) > 0) then {
        while {true} do {
            uiSleep 600;

            private _allPlayers = allPlayers select {(_x distance respawn) > (configSectors # 0)};
            private _allSectorTriggers = (missionNamespace getVariable ["sectorTriggers", []]) select {!(_x getVariable "isCaptured") && !(_x getVariable "isActive")};

            if ((count _allSectorTriggers) < 1 || (count _allPlayers) < 1) then {
                continue;
            };

            private _allUnits = [];
            private _reinforcementsId = "reinforcements#" + (str serverTime);

            for [{private _i = 0 }, { _i < (count _allPlayers) }, { _i = _i + 1 }] do {
                private _vehiclePlayer = vehicle (_allPlayers # _i);
                private _vehicleType = (_vehiclePlayer call BIS_fnc_objectType) # 1;

                if (!(_vehicleType in ["Helicopter", "Plane"]) || (random 1) > 0.7) then {
                    continue;
                };

                private _distanceToSectors = switch (_vehicleType) do {
                    case "Helicopter": {
                        [1000, 3000]
                    };
                    case "Plane": {
                        [2000, 4000]
                    };
                };

                private _vehiclePlayer2D = [(position _vehiclePlayer) # 0, (position _vehiclePlayer) # 1];
                private _availableSectors = _allSectorTriggers select {(_x distance _vehiclePlayer2D) > (_distanceToSectors # 0) && (_x distance _vehiclePlayer2D) < (_distanceToSectors # 1)};
                private _sectorsCount = count _availableSectors;

                if (_sectorsCount < 1) then {
                    continue;
                };

                if (_sectorsCount > 2) then {
                    _sectorsCount = 2;
                };

                for [{private _s = 0 }, { _s < _sectorsCount }, { _s = _s + 1 }] do {
                    private _pos = [position (_availableSectors # _s), 100, 500] call BIS_fnc_findSafePos;

                    private _grp = createGroup [(configUnits # 0) # 0, true];
                    private _unit = _grp createUnit [selectRandom _aaUnits, _pos, [], 0, "NONE"];

                    _unit setDir (_unit getDir _vehiclePlayer);
                    _unit setVariable ["spawnTrigger", _reinforcementsId];

                    _allUnits pushBack _unit;
                };
            };

            if ((count _allUnits) > 0) then {
                [_reinforcementsId] spawn P27_fnc_removeReinforcements;

                if (debugMode) then {
                    systemChat format ["Air vehicle has been spotted. %1 AA units have spawned around.", count _allUnits];
                };
            };
        };
    };
};