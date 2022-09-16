/*
    Author: eugene27
    Date: 13.09.2022
    
    Task

    WIP
*/


params ["_sectorPosition"];

private _taskId = "ts#" + str serverTime;

private _taskPosition = [_sectorPosition, 300, [0, 359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
private _heliSpawnPosition = [_taskPosition, 200, 1000, 10, 0] call BIS_fnc_findSafePos;

private _heliClasses = ("getNumber (_x >> 'scope') >= 2 && getNumber (_x >> 'side') == 1 && getText (_x >> 'vehicleClass') == 'Air' && configName _x isKindof 'Helicopter'" configClasses (configFile >> "CfgVehicles")) apply {configName _x};

private _heliClass = selectRandom _heliClasses;

private _heliWreckage = _heliClass createVehicle _heliSpawnPosition;
_heliWreckage allowDamage false;
_heliWreckage setDamage 0.7;
_heliWreckage setFuel 0;

uiSleep 3;

private _heliPosition = position _heliWreckage;

private _heliSmoke = createVehicle ["test_EmptyObjectForSmoke", _heliPosition, [], 0, "CAN_COLLIDE"];
_heliSmoke attachTo [_heliWreckage, [0, 0, 0]];
_heliWreckage allowDamage true;

private _heliPicture = getText(configfile >> "CfgVehicles" >> _heliClass >> "editorPreview");

[west, [_taskId], [format [localize "STR_P27_TASK_DESCRIPTION_CREWRESCUE_IMAGE", _heliPicture], "STR_P27_TASK_TITLE_CREWRESCUE", ""], _taskPosition, "CREATED", 0, true, "search"] call BIS_fnc_taskCreate;

private _crewUnitClass = getText(configFile >> "CfgVehicles" >> _heliClass >> "crew");
private _heliCrew = [_heliWreckage, [_crewUnitClass], west, 0] call P27_fnc_createCrew;

{
    _x setCaptive true;
    for "_i" from 0 to 3 do {
        [_x, random(0.3), selectRandom ["Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"]] call ace_medical_fnc_addDamageToUnit;
    };
} forEach _heliCrew;

[_taskId, _taskPosition, "ELLIPSE", [900, 900], "COLOR:", "ColorWEST", "ALPHA:", 0.7, "PERSIST"] call CBA_fnc_createMarker;

private _triggerStateFnc = '
    {[_x] join (thisList # 0); _x setCaptive false; _x action ["GetOut", vehicle _x]} forEach (thisTrigger getVariable "heliCrew");
    [position thisTrigger] spawn P27_fnc_createReinforcements;
';

([_heliPosition, "AREA:", [20, 20, 10, false], "ACT:", ["ANYPLAYER", "PRESENT", false], "STATE:", ["this", _triggerStateFnc, ""]] call CBA_fnc_createTrigger) params ["_heliTrigger", "_triggerParams"];
_heliTrigger setVariable ["heliCrew", _heliCrew];

([_heliPosition, "AREA:", [500, 500, 200, false], "ACT:", ["ANYPLAYER", "PRESENT", false], "STATE:", ["this", "[position thisTrigger] spawn P27_fnc_createReinforcements;", ""]] call CBA_fnc_createTrigger) params ["_reinforcementTrigger", "_triggerParams"];


waitUntil {uiSleep 5; [_heliCrew] call P27_fnc_allObjectsAreDead || [_heliCrew select {alive _x}, position respawn] call P27_fnc_allObjectsInRadius || _taskId call BIS_fnc_taskCompleted};

private _deleteObjects = [_heliTrigger, _reinforcementTrigger, _heliSmoke] + _heliCrew;

private _aliveCount = count (_heliCrew select {alive _x});
private _allCrewCount = count _heliCrew;

if (_aliveCount < 1 || _taskId call BIS_fnc_taskCompleted) exitWith {
    if !(_taskId call BIS_fnc_taskCompleted) then {
        [_taskId, "FAILED"] call BIS_fnc_taskSetState;
    };
    [_taskId, _deleteObjects, [_taskId]] spawn P27_fnc_clearTask;
};


[_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;

{
    [_x, false] call ACE_captives_fnc_setHandcuffed;
    _x action ["GetOut", vehicle _x];
} forEach _heliCrew;


private _notificationResult = "FULL";

if (_aliveCount != _allCrewCount && _aliveCount > (_allCrewCount / 2)) then {
    _notificationResult = "MORE_THAN_FULL";
};

if (_aliveCount < (_allCrewCount / 2)) then {
    _notificationResult = "LESS_THAN_HALF";
};

[west, "Base"] sideChat (localize (format ["STR_P27_TASK_HQ_NOTIFICATION_%1", _notificationResult]));


[_taskId, _deleteObjects, [_taskId]] spawn P27_fnc_clearTask;