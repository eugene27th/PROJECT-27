/*
    Author: eugene27
    Date: 24.08.2022
    
    Example:
        [] spawn P27_fnc_removeReinforcements
*/


params ["_reinforcementsId", ["_distanceToPlayers", 1500], ["_sleepBeforeChecking", 300], ["_intervalSleep", 30]];

uiSleep _sleepBeforeChecking;

while {true} do {
	private _allObjects = (allUnits + vehicles) select {(_x getVariable ["spawnTrigger", ""]) isEqualTo _reinforcementsId};

	if ((count _allObjects) < 1) exitWith {};

	for [{private _i = 0 }, { _i < (count _allObjects) }, { _i = _i + 1 }] do {
		private _object = _allObjects # _i;
		private _nearPlayers = allPlayers select {(_x distance _object) < _distanceToPlayers};

		if ((count _nearPlayers) < 1) then {
			deleteVehicle _object;
		};
	};

	uiSleep _intervalSleep;
};