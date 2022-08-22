/*
    Author: eugene27
    Date: 16.08.2022
    
    Example:
        [] call P27_fnc_setCheckpointCaptureState
*/


params ["_captureTrigger"];

private _checkpointTrigger = _captureTrigger getVariable "checkpointTrigger";

if (isNil "_checkpointTrigger") exitWith {};

private _sectorName = (position _checkpointTrigger) call BIS_fnc_locationDescription;
private _sectorGrid = mapGridPosition _checkpointTrigger;

["checkpointCaptured", [_sectorGrid, _sectorName]] remoteExec ["BIS_fnc_showNotification"];

{deleteVehicle _x} forEach [_checkpointTrigger, _captureTrigger];