/*
    Author: eugene27
    Date: 12.08.2022
    
    Example:
        [_sectorTrigger] spawn P27_fnc_clearSector;
    
    Return:
		nothing
*/

params ["_sectorTrigger"];

waitUntil {uiSleep 5; !triggerActivated _sectorTrigger};


private _captureTrigger = _sectorTrigger getVariable "captureTrigger";

if (!isNil "_captureTrigger") then {
    deleteVehicle _captureTrigger;
    _sectorTrigger setVariable ["captureTrigger", nil];
};


{
    private _unitSectorTrigger = _x getVariable "spawnTrigger";

    if (isNil "_unitSectorTrigger") then {
        continue;
    };

    if (_unitSectorTrigger == _sectorTrigger) then {
        deleteVehicle _x;
    };
} forEach (allUnits + vehicles);


_sectorTrigger setVariable ["isActive", false];