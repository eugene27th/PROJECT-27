/*
    Author: eugene27
    Date: 15.08.2022
    
    Example:
        [] call P27_fnc_getRandomSectorPos
*/


params [["_includeCaptured", false], ["_nearest", false], ["_returnArray", false], ["_returnOriginal", false]];

private _sectorTriggers = missionNamespace getVariable "sectorTriggers";

if (isNil "_sectorTriggers") exitWith {};

if (!_includeCaptured) then {
    _sectorTriggers = _sectorTriggers select {!(_x getVariable "isCaptured")};
};

if (_nearest) then {
    _sectorTriggers = [_sectorTriggers, [], {(position respawn) distance (position _x)}, "ASCEND"] call BIS_fnc_sortBy;

    if (!_returnArray) then {
        _sectorTriggers resize 5;
    };
};

private "_result";

if (!_returnArray) then {
    private _randomSector = selectRandom _sectorTriggers;
    
    if (_returnOriginal) then {
        _result = _randomSector;
    } else {
        _result = position _randomSector;
    };
} else {
    if (_returnOriginal) then {
        _result = _sectorTriggers;
    } else {
        _result = _sectorTriggers apply {position _x};
    };
};

_result