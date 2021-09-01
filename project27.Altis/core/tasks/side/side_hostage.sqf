/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _center_pos = [1,false] call prj_fnc_selectPosition;
private _pos = [_center_pos, 200] call prj_fnc_select_house_position;

private _hostage = (createGroup [civilian, true]) createUnit [selectRandom hostage_units, _pos, [], 0, "NONE"];
private _enemy = (createGroup [independent, true]) createUnit [selectRandom enemy_infantry, position _hostage, [], 0, "NONE"];
[_hostage, true] call ACE_captives_fnc_setHandcuffed;
_hostage setCaptive true;
{_x setBehaviour "CARELESS"} forEach [_hostage,_enemy];

_hostage addEventHandler ["FiredNear", {
	params ["_unit"];
	_unit removeEventHandler ["FiredNear", _thisEventHandler];

	private _number = [2,3] call BIS_fnc_randomInt;
	private _vehicles = [position _unit,_number] call prj_fnc_reinforcement;

	[_vehicles] spawn prj_fnc_check_and_delete;
}];

[_taskID + "_blue_base",position spawn_zone,"ColorWEST",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;
[_taskID + "_center",_center_pos,"ColorWEST",0.7,[[200,200],"ELLIPSE"]] call prj_fnc_create_marker;

private _picture = getText(configfile >> "CfgVehicles" >> typeOf _hostage >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_HOSTAGE_DESCRIPTION",_picture], "STR_SIDE_HOSTAGE_TITLE", ""], _center_pos, "CREATED", 0, true, "help"] call BIS_fnc_taskCreate;

uiSleep 1;

private _trg = createTrigger ["EmptyDetector", position _hostage, true];
_trg setVariable ["unit", _hostage];
_trg setTriggerArea [5, 5, 0, false];
_trg setTriggerActivation ["WEST", "PRESENT", false];
_trg setTriggerStatements ["this", "_unit = thisTrigger getVariable 'unit'; [_unit] join (thisList select 0); _unit setUnitPos 'UP'", ""];
_trg attachTo [_hostage, [0, 0, 0]];

waitUntil {uiSleep 5; !alive _hostage || _hostage distance position spawn_zone < 50 || _taskID call BIS_fnc_taskCompleted};

if (!alive _hostage) then {
    [_taskID,"FAILED"] call BIS_fnc_taskSetState;
	uiSleep 2;
};

if (_hostage distance position spawn_zone < 50) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
	uiSleep 2;
};

[_hostage, false] call ACE_captives_fnc_setHandcuffed;
_hostage action ["GetOut",vehicle _hostage];
[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach [_hostage,_enemy];
{deleteMarker _x} forEach [(_taskID + "_red_base"),(_taskID + "_blue_base"),(_taskID + "_center")];