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
_heliWreckage lock true;

uiSleep 3;

private _heliPosition = position _heliWreckage;

private _heliSmoke = createVehicle ["test_EmptyObjectForSmoke", _heliPosition, [], 0, "CAN_COLLIDE"];
_heliSmoke attachTo [_heliWreckage, [0, 0, 0]];

private _heliPicture = getText(configfile >> "CfgVehicles" >> _heliClass >> "editorPreview");

[west, [_taskId], [format [localize "STR_P27_TASK_DESCRIPTION_CREWRESCUE_IMAGE", _heliPicture], "STR_P27_TASK_TITLE_CREWRESCUE", ""], _taskPosition, "CREATED", 0, true, "search"] call BIS_fnc_taskCreate;

private _crewUnitClass = getText(configFile >> "CfgVehicles" >> _heliClass >> "crew");
private _heliCrew = [_heliWreckage, [_crewUnitClass], civilian, 0] call P27_fnc_createCrew;

{ _x setCaptive true} forEach _heliCrew;

[_taskId, _taskPosition, "ELLIPSE", [900, 900], "COLOR:", "ColorWEST", "ALPHA:", 0.7, "PERSIST"] call CBA_fnc_createMarker;

private _triggerStateFnc = '
    private _heliCrew = thisTrigger getVariable "heliCrew";
    {
        [_x] join (thisList # 0);
        _x setCaptive false;
        _x action ["GetOut", vehicle _x];
    } forEach _heliCrew;
    [position thisTrigger] call P27_fnc_createReinforcements;
';

([_heliPosition, "AREA:", [10, 10, 0, false], "ACT:", ["ANYPLAYER", "PRESENT", true], "STATE:", ["this", _triggerStateFnc, ""]] call CBA_fnc_createTrigger) params ["_taskTrigger", "_triggerParams"];
_taskTrigger setVariable ["heliCrew", _heliCrew];


waitUntil {uiSleep 5; {!alive _x} forEach _heliCrew || {(_x distance (position respawn)) < 50} forEach _heliCrew || _taskId call BIS_fnc_taskCompleted};

private _aliveHeliCrewCount = _heliCrew select {alive _x};
systemChat str _aliveHeliCrewCount;

if ((count _aliveHeliCrewCount) < 1 || _taskId call BIS_fnc_taskCompleted) exitWith {
    if !(_taskId call BIS_fnc_taskCompleted) then {
        [_taskId, "FAILED"] call BIS_fnc_taskSetState;
    };
    [_taskId, [_taskTrigger, _heliSmoke] + _heliCrew, [_taskId]] spawn P27_fnc_clearTask;
};


[_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;

{
    [_x, false] call ACE_captives_fnc_setHandcuffed;
    _x action ["GetOut", vehicle _x];
} forEach _heliCrew;

[west, "HQ"] sideChat (localize (format ["STR_P27_TASK_HQ_NOTIFICATION_LESS_", count _aliveHeliCrewCount]));

[_taskId, [_taskTrigger, _heliSmoke] + _heliCrew, [_taskId]] spawn P27_fnc_clearTask;