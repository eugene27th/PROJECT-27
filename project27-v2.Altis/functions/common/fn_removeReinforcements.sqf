/*
    Author: eugene27
    Date: 24.08.2022
    
    Example:
        [] spawn P27_fnc_clearReinforcements
*/


params ["_reinforcementsId", ["_distanceFromPlayers", 1000], ["_sleepBeforeChecking", 60], ["_intervalSleep", 10]];

uiSleep _sleepBeforeChecking;

while {true} do {
	private _allObjects = (allUnits + vehicles) select {(_x getVariable ["spawnTrigger", ""]) isEqualTo _reinforcementsId};

	if ((count _allObjects) < 1) exitWith {};

	systemChat (str _allObjects);

	for [{private _i = 0 }, { _i < (count _allObjects) }, { _i = _i + 1 }] do {
		private _object = _allObjects # _i;

		{
			if ((_x distance _object) > _distanceFromPlayers) then {
				deleteVehicle _object;
			};
		} forEach allPlayers;
	};

	uiSleep _intervalSleep;
};