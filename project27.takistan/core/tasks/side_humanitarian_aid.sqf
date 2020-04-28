/*
	written by eugene27.
	server only
    1.3.0
*/

params [
    "_taskID","_reward"
];

private ["_taskID","_pos","_pos_box","_boxes","_trg"];

_taskID = "SIDE_" + str _taskID;

_pos = [1] call prj_fnc_select_position;
_pos = [_pos, 100, 500, 5, 0] call BIS_fnc_findSafePos;

[_taskID,_pos,"ColorWEST",0.7,[[35,35],"ELLIPSE"]] call prj_fnc_create_marker;

[west, [_taskID], ["STR_SIDE_HUMANITARIAN_AID_DESCRIPTION", "STR_SIDE_HUMANITARIAN_AID_TITLE", ""], _pos, "CREATED", 0, true, "container"] call BIS_fnc_taskCreate;

_pos_box = position selectRandom [Checkpoint1,Checkpoint2];
_boxes = [];

for "_i" from 1 to (round ((count (allPlayers - (entities "HeadlessClient_F"))) / 2)) do {
	private _box = "C_IDAP_supplyCrate_F" createVehicle (_pos_box findEmptyPosition [0,50,"C_IDAP_supplyCrate_F"]);
	_box setVariable ["ace_cookoff_enable", false, true];
	[_box, true, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable;
	[west, [(_taskID + "_" + str _i),_taskID], ["", "STR_SIDE_HUMANITARIAN_AID_CARGO", ""], _box, "CREATED", 0, false, "box"] call BIS_fnc_taskCreate;
	_boxes pushBack _box;
};

_trg = createTrigger ["EmptyDetector", _pos, true];
_trg setVariable ["boxes", _boxes];
_trg setTriggerArea [35, 35, 0, false, 10];
_trg setTriggerActivation ["NONE", "PRESENT", false];
_trg setTriggerStatements ["{_x in thisList && ((getPosATL _x) select 2) < 0.2 && (speed _x == 0)} forEach (thisTrigger getVariable 'boxes')", "",""];

waitUntil {sleep 5; {!alive _x} forEach _boxes || triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

if ({!alive _x} forEach _boxes) then {
    [_taskID,"FAILED"] call BIS_fnc_taskSetState;
    uiSleep 2;
};

if (triggerActivated _trg) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
    [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteMarker _taskID;

uiSleep 30;

{deleteVehicle _x} forEach [_trg] + _boxes;