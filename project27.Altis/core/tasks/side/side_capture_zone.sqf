/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _pos = [false,false,[0,20]] call prj_fnc_selectCaptPosition;

[_taskID,_pos,"ColorEAST",0.7,[[250,250],"ELLIPSE"]] call prj_fnc_createMarker;

[west, [_taskID], ["STR_SIDE_CAPTURE_ZONE_DESCRIPTION", "STR_SIDE_CAPTURE_ZONE_TITLE", ""], _pos, "CREATED", 0, true, "attack"] call BIS_fnc_taskCreate;

private _trgC = [_pos, [250, 250, 20], "WEST SEIZED", "PRESENT", true, "", false] call prj_fnc_createTrigger;

waitUntil {uiSleep 5;triggerActivated _trgC || _taskID call BIS_fnc_taskCompleted};

if (triggerActivated _trgC) then {
    [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
    ["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteVehicle _trgC;
deleteMarker _taskID;