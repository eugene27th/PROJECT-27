/*
    Author: eugene27
    Date: 12.08.2022
    
    Example:
        [] call P27_fnc_clearSector
*/


params ["_sectorTrigger"];

waitUntil {uiSleep 30; !triggerActivated _sectorTrigger};

private _captureTrigger = _sectorTrigger getVariable "captureTrigger";

if (!isNil "_captureTrigger") then {
    deleteVehicle _captureTrigger;
    _sectorTrigger setVariable ["captureTrigger", nil];
};

{deleteVehicle _x} forEach ((allUnits + vehicles) select {(_x getVariable ["spawnTrigger", ""]) isEqualTo _sectorTrigger});

_sectorTrigger setVariable ["isActive", false];