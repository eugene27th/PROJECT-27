/*
    Author: eugene27
    Date: 12.08.2022
    
    Example:
        [] spawn P27_fnc_clearSector
*/


params ["_sectorTrigger", ["_deleteDelay", 0]];

waitUntil {uiSleep 10; !triggerActivated _sectorTrigger};

private _captureTrigger = _sectorTrigger getVariable "captureTrigger";

if (!isNil "_captureTrigger") then {
    deleteVehicle _captureTrigger;
    _sectorTrigger setVariable ["captureTrigger", nil];
};

_sectorTrigger setVariable ["isActive", false];

uiSleep _deleteDelay;

{deleteVehicle _x} forEach ((allUnits + vehicles) select {(_x getVariable ["spawnTrigger", ""]) isEqualTo _sectorTrigger});