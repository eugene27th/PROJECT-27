/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _roadpos = [4] call prj_fnc_select_road_position;
private _pos = _roadpos select 0;
private _direction = _roadpos select 1;

[_taskID,_pos,"ColorEAST",0.7,[[30,30],"ELLIPSE"]] call prj_fnc_create_marker;

private _trg = createTrigger ["EmptyDetector", _pos, true];
_trg setTriggerArea [30, 30, 0, false, 20];
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
_trg setTriggerStatements ["this", "", ""];

private _checkpointData = [_pos,_direction] call prj_fnc_create_checkpoint;
private _vehicles = _checkpointData # 0;
private _infantry = (_checkpointData # 1) + (_checkpointData # 2);

[west, [_taskID], ["STR_SIDE_CHECKPOINT_DESCRIPTION", "STR_SIDE_CHECKPOINT_TITLE", ""], _pos, "CREATED", 0, true, "target"] call BIS_fnc_taskCreate;

waitUntil {uiSleep 5;triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

if (triggerActivated _trg) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
    ["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteMarker _taskID;

[_vehicles,_infantry,_trg] spawn {
	params ["_vehicles","_infantry","_delTime"];

	if (triggerActivated _trg) then {
		uiSleep 300;
	};

	{
		if !(_x getVariable ["cannotDeleted",false]) then {
			deleteVehicle _x;
		}
	} forEach _vehicles;

	_infantry pushBack _trg;
	{deleteVehicle _x} forEach _infantry;
};