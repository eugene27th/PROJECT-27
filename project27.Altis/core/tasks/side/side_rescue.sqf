/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _center_pos = [1] call prj_fnc_select_position;
private _pos = [_center_pos, 300, 900, 5, 0] call BIS_fnc_findSafePos;

private _heli = (selectRandom friendly_helicopters) createVehicle _pos;
_heli setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
_heli setDamage 1;

private _heli_smoke = createVehicle ["test_EmptyObjectForSmoke", position _heli, [], 0, "CAN_COLLIDE"];
_heli_smoke attachTo [_heli, [0, 0, 0]];

private _picture = getText(configfile >> "CfgVehicles" >> typeOf _heli >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_RESCUE_DESCRIPTION",_picture], "STR_SIDE_RESCUE_TITLE", ""], _center_pos, "CREATED", 0, true, "search"] call BIS_fnc_taskCreate;

sleep 3;

private _pilot = (createGroup civilian) createUnit [getText(configfile >> "CfgVehicles" >> typeOf _heli >> "crew"), position _heli findEmptyPosition [10,200,"B_Survivor_F"], [], 0, "NONE"];
_pilot setCaptive true;
removeAllWeapons _pilot;
_pilot setBehaviour "CARELESS";
_pilot setUnitPos "DOWN";

[_taskID + "_blue_base",position spawn_zone,"ColorWEST",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;
[_taskID + "_center",_center_pos,"ColorWEST",0.7,[[900,900],"ELLIPSE"]] call prj_fnc_create_marker;

private _trg = createTrigger ["EmptyDetector", position _pilot, true];
_trg setVariable ["unit", _pilot];
_trg setTriggerArea [5, 5, 0, false];
_trg setTriggerActivation ["WEST", "PRESENT", false];
_trg setTriggerStatements ["this", "_unit = thisTrigger getVariable 'unit'; [_unit] join (thisList select 0); _unit setUnitPos 'UP'; timeendmissionfailed=timeendmissionfailed+1200; independentwinrescuemis=false;", ""];
_trg attachTo [_pilot, [0, 0, 0]];

private _enemies = [];

for [{private _i = 0 }, { _i < [10,20] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
    private _grpname = createGroup independent;
    private _pos = [position _pilot, 50, 150, 1, 0] call BIS_fnc_findSafePos;
    private _unit = _grpname createUnit [selectRandom enemy_infantry, _pos, [], 0, "NONE"];
    _enemies pushBack _unit;
};

{_x lookAt _heli} forEach _enemies;

waitUntil {sleep 5; !alive _pilot || _pilot distance position spawn_zone < 50 || _taskID call BIS_fnc_taskCompleted};

if (!alive _pilot) then {
    [_taskID,"FAILED"] call BIS_fnc_taskSetState;
	sleep 2;
};

if (_pilot distance position spawn_zone < 50) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
	sleep 2;
};

[_pilot, false] call ACE_captives_fnc_setHandcuffed;
_pilot action ["GetOut",vehicle _pilot];
[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach [_pilot,_trg,_heli_smoke] + _enemies;
{deleteMarker _x} forEach [(_taskID + "_red_base"),(_taskID + "_blue_base"),(_taskID + "_center")];