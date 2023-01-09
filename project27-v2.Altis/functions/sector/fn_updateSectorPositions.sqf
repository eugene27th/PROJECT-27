/*
    Author: eugene27
    Date: 08.01.2023
    
    Example:
        [] call P27_fnc_updateSectorPositions
*/


private _sectorTriggers = missionNamespace getVariable "sectorTriggers";

if (debugMode) then {
    diag_log "[PROJECT 27] INFO: Updating sector positions.";
};

if (isNil "_sectorTriggers") exitWith {
    diag_log "[PROJECT 27] WARNING: No sector triggers in update sector positions.";
};

_sectorTriggers = [_sectorTriggers, [], {(position respawn) distance (position _x)}, "ASCEND"] call BIS_fnc_sortBy;

private _capturedSectors = _sectorTriggers select {(_x getVariable "isCaptured")};
private _otherSectors = _sectorTriggers select {!(_x getVariable "isCaptured")};

private _capturedSectorPositions = _capturedSectors apply {position _x};
private _otherSectorsPositions = _otherSectors apply {position _x};

missionNamespace setVariable ["sectorPositions", [_capturedSectorPositions, _otherSectorsPositions], true];