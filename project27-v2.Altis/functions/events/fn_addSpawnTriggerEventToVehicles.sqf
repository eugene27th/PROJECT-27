/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
		[] call P27_fnc_addSpawnTriggerEventToVehicles
*/


params ["_objects"];

{
	_x addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];

		if (isPlayer _unit) then {
			_vehicle removeEventHandler ["GetIn", _thisEventHandler];
			_vehicle setVariable ["spawnTrigger", nil, true];
		};
	}];
} forEach _objects;