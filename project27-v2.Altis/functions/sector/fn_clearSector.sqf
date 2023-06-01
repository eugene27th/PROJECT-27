/*
    Author: eugene27
    Date: 12.08.2022
    
    Example:
        [] spawn P27_fnc_clearSector
*/


params ["_sectorTrigger", ["_delay", 0]];

uiSleep _delay;

waitUntil {uiSleep 10; !triggerActivated _sectorTrigger};

private _captureTrigger = _sectorTrigger getVariable "captureTrigger";

if (!isNil "_captureTrigger") then {
    deleteVehicle _captureTrigger;
    _sectorTrigger setVariable ["captureTrigger", nil];
};

{deleteVehicle _x} forEach ((allUnits + vehicles) select {(_x getVariable ["spawnTrigger", ""]) isEqualTo _sectorTrigger});

_sectorTrigger setVariable ["isActive", false];

if (debugMode) then {
	systemChat format["Sector (%1) is deactivated.", _sectorTrigger];
};