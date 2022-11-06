/*
    Author: eugene27
    Date: 27.08.2022
    
    Example:
        [] spawn P27_fnc_generateAmbientTraffic
*/


while {true} do {
    private _allSectorTriggers = (missionNamespace getVariable ["sectorTriggers", []]) select {!(_x getVariable "isCaptured") && !(_x getVariable "isActive")};
    private _allPlayers = allPlayers select {(_x distance respawn) > (configSectors # 0)};

    if ((count _allSectorTriggers) < 1 || (count _allPlayers) < 1) exitWith {};

    private _randomPlayer = selectRandom _allPlayers;
    private _nearestSectors = _allSectorTriggers select {(_x distance _randomPlayer) < 3000 && (_x distance _randomPlayer) > 1500};

    if ((count _nearestSectors) < 1) exitWith {};

    private _startSector = selectRandom _nearestSectors;

    private _dirFromStartToFinishPos = _startSector getRelPos [(_startSector distance _randomPlayer) + 4000, _startSector getDir _randomPlayer];
    private _nearestSectorsAroundFinishPos = _allSectorTriggers select {(_x distance _dirFromStartToFinishPos) < 2000};
    
    if ((count _nearestSectorsAroundFinishPos) < 1) exitWith {};

    private _startSectorPos = position _startSector;
    private _finishSectorPos = position (selectRandom _nearestSectorsAroundFinishPos);


    private _roadPositions = [1, _startSectorPos, 500] call P27_fnc_getRandomRoadPositions;

    private _vehicle = (selectRandom (((configUnits # 0) # 1) # 3)) createVehicle ((_roadPositions # 0) # 0);
	_vehicle setVariable ["spawnTrigger", "trafficVehicle"];
	_vehicle setDir (_startSectorPos getDir _finishSectorPos);

    [[_vehicle]] call P27_fnc_addSpawnTriggerEventToVehicles;


    private _vehicleCrew = [_vehicle, ((configUnits # 0) # 1) # 1, (configUnits # 0) # 0] call P27_fnc_createCrew;
    {_x setVariable ["spawnTrigger", "trafficVehicle"]} forEach _vehicleCrew;

    private _grp = group (_vehicleCrew # 0);
	private _wpPosition = [1, _finishSectorPos, 500] call P27_fnc_getRandomRoadPositions;
	
    private _wp = _grp addWaypoint [(_wpPosition # 0) # 0, 0];
    _wp setWaypointCompletionRadius 20;
    _wp setWaypointType "MOVE";

    ["trafficVehicle", _finishSectorPos, 500, 1500, 600, 30] spawn P27_fnc_removeFollowingVehicles;

    uiSleep 900;
};