/* 
	written by eugene27.
	only server functions
*/

if (("patrols" call BIS_fnc_getParamValue) != 1) exitWith {};

private _index = 0;

while {true} do {

	uiSleep 30;

	if ((count allPlayers) > 0) then {
		private _index = _index + 1;
		private _taskID = "PATROL_" + str _index;

		private _pos = [false,false,[0,15]] call prj_fnc_selectCaptPosition;

		[_taskID,_pos,"ColorEAST",0.7,[[150,150],"ELLIPSE"]] call prj_fnc_create_marker;

		private _task = [west, [_taskID], [localize "STR_PATROL_DESCRIPTION", "STR_PATROL_TITLE", ""], _pos, "CREATED", 0, false, "walk"] call BIS_fnc_taskCreate;

		private _trg = createTrigger ["EmptyDetector", _pos, true];
		_trg setTriggerArea [150, 150, 0, false, 20];
		_trg setTriggerActivation ["WEST", "PRESENT", false];
		_trg setTriggerStatements ["this", "",""];
		_trg setTriggerTimeout [600, 600, 600, true];

		waitUntil {sleep 10; _taskID call BIS_fnc_taskCompleted || triggerActivated _trg};

		if (triggerActivated _trg) then {
			[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
			["missionNamespace", "money", 0, 200] call prj_fnc_changePlayerVariableGlobal;
			uiSleep 2;
		};

		[_taskID] call BIS_fnc_deleteTask;
		deleteVehicle _trg;
		deleteMarker _taskID;
	};
};