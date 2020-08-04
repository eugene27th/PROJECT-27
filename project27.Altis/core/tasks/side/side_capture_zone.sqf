/*
	written by eugene27.
	server only
*/


params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _pos = [1,false] call prj_fnc_select_position;

[_taskID,_pos,"ColorEAST",0.7,[[220,220],"ELLIPSE"]] call prj_fnc_create_marker;

[west, [_taskID], ["STR_SIDE_CAPTURE_ZONE_DESCRIPTION", "STR_SIDE_CAPTURE_ZONE_TITLE", ""], _pos, "CREATED", 0, true, "attack"] call BIS_fnc_taskCreate;

private _trg = createTrigger ["EmptyDetector", _pos, true];
_trg setTriggerArea [220, 220, 0, false, 20];
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
_trg setTriggerStatements ["this", "",""];

waitUntil {sleep 5;triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

if (triggerActivated _trg) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
    ["missionNamespace", getPlayerUID player, "money", 0, _reward] remoteExec ["prj_fnc_changePlayerVariable"];
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteVehicle _trg;
deleteMarker _taskID;