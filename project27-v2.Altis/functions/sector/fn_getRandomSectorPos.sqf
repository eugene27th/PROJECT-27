/*
    Author: eugene27
    Date: 15.08.2022
    
    Example:
        [_includeCaptured = false, _nearest = false] call P27_fnc_getRandomSectorPos;
    
    Return:
		sector position
*/


params [["_includeCaptured", false], ["_nearest", false]];

private _sectorTriggers = missionNamespace getVariable "sectorTriggers";

if (isNil "_sectorTriggers") exitWith {};

if (!_includeCaptured) then {
    _sectorTriggers = _sectorTriggers select {!(_x getVariable "isCaptured")};
};

if (_nearest) then {
    [_sectorTriggers, [], {(position respawn) distance (position _x)}, "ASCEND"] call BIS_fnc_sortBy;
    _sectorTriggers resize 5;
};

private _returnPosition = position (selectRandom _sectorTriggers);

_returnPosition