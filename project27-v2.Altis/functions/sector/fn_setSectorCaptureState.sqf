/*
    Author: eugene27
    Date: 16.08.2022
    
    Example:
        [_captureTrigger] call P27_fnc_setSectorCaptureState;
    
    Return:
		nothing
*/


params ["_captureTrigger"];

private _sectorTrigger = _captureTrigger getVariable "sectorTrigger";

if (isNil "_sectorTrigger") exitWith {};

_sectorTrigger setVariable ["isCaptured", true];

private _sectorPosition = position _sectorTrigger;
private _sectorRadius = (triggerArea _captureTrigger) # 0;
private _sectorName = _sectorPosition call BIS_fnc_locationDescription;
private _sectorGrid = mapGridPosition _captureTrigger;

["CAPTURED_" + _sectorTrigger, _sectorPosition, "ELLIPSE", [_sectorRadius, _sectorRadius], "COLOR:", "ColorWEST", "ALPHA:", 0.3, "PERSIST"] call CBA_fnc_createMarker;
["sectorCaptured", [_sectorGrid, _sectorName]] remoteExec ["BIS_fnc_showNotification"];

deleteVehicle _captureTrigger;