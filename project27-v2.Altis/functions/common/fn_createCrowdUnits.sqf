/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [] call P27_fnc_createCrowdUnits
*/


params ["_positionOrTrigger", ["_sectorRadius", 100], ["_spawnConfig", [1, 1]], ["_unitClassNames", ((configUnits # 0) # 1) # 1], ["_unitSide", (configUnits # 0) # 0]];

if ((_spawnConfig # 0) == 0) exitWith {};


private ["_sectorTrigger"];

if (typeName _positionOrTrigger != "ARRAY") then {
	_sectorTrigger = _positionOrTrigger;
	_positionOrTrigger = position _sectorTrigger;
};


for [{private _i = 0 }, { _i < (_spawnConfig # 0) }, { _i = _i + 1 }] do {
    private _grp = createGroup [_unitSide, true];

    for [{private _i = 0 }, { _i < [_spawnConfig # 1] call P27_fnc_getNumberOfUnits }, { _i = _i + 1 }] do {
        private _spawnPosition = [_positionOrTrigger, 10, _sectorRadius, 1, 0] call BIS_fnc_findSafePos;
        
        private _unit = _grp createUnit [selectRandom _unitClassNames, [_spawnPosition, 10, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos, [], 0, "NONE"];
        [_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];
        _unit setDir ([0,359] call BIS_fnc_randomInt);
        doStop _unit;

        if (!isNil "_sectorTrigger") then {
            _unit setVariable ["spawnTrigger", _sectorTrigger];
        };
        
        uiSleep 0.5;
    };

    [_grp, _positionOrTrigger] call BIS_fnc_taskDefend;
};