/*
    Author: eugene27
    Date: 06.11.2022
    
    Example:
        [] spawn P27_fnc_removeFollowingVehicles
*/


params ["_spawnTriggerId", "_finishPos", ["_distanceAroundFinish", 500], ["_distanceToPlayers", 1500], ["_timeBeforeDelete", 600], ["_intervalSleep", 30]];


private _timePassed = 0;

while {true} do {
	uiSleep _intervalSleep;

	private _allObjects = (allUnits + vehicles) select {(_x getVariable ["spawnTrigger", ""]) isEqualTo _spawnTriggerId};

	if ([_allObjects, _finishPos, _distanceAroundFinish] call P27_fnc_allObjectsInRadius || [_allObjects] call P27_fnc_allObjectsAreDead) exitWith {
		{deleteVehicle _x} forEach _allObjects;

		if (debugMode) then {
			systemChat "All traffic in radius, no units or all units are dead.";
		};
	};
 
	if (_timePassed > _timeBeforeDelete) then {
		for [{private _i = 0 }, { _i < (count _allObjects) }, { _i = _i + 1 }] do {
			private _object = _allObjects # _i;
			private _nearPlayers = allPlayers select {(_x distance _object) < _distanceToPlayers};

			if ((count _nearPlayers) < 1) then {
				deleteVehicle _object;
			};
		};

		if (debugMode) then {
			systemChat "Forced deletion of traffic.";
		};
	} else {
		_timePassed = _timePassed + _intervalSleep;

		if (debugMode) then {
			systemChat format ["Time before traffic is forcibly removed: %1 / %2", _timePassed, _timeBeforeDelete];
		};
	};
};