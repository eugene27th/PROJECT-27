/* 
	written by eugene27.
	only server functions
*/

if (("patrols" call BIS_fnc_getParamValue) != 1) exitWith {};

private _index = 0;
private _waitingTime = "patrolTime" call BIS_fnc_getParamValue;
if (isNil "_waitingTime") then {_waitingTime = 600};

while {true} do {

	uiSleep 15;

	if ((count allPlayers) > 0) then {
		private _index = _index + 1;
		private _taskID = "PATROL_" + str _index;

		private _pos = [false,false,[0,15],["NameCityCapital","NameCity","NameVillage"]] call prj_fnc_selectCaptPosition;

		[_taskID,_pos,"ColorEAST",0.7,[[150,150],"ELLIPSE"]] call prj_fnc_create_marker;

		private _task = [west, [_taskID], [format [localize "STR_PATROL_DESCRIPTION",(_waitingTime/60)], "STR_PATROL_TITLE", ""], _pos, "CREATED", 0, false, "walk"] call BIS_fnc_taskCreate;

		private _trg = createTrigger ["EmptyDetector", _pos, true];
		_trg setTriggerArea [150, 150, 0, false, 20];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerStatements ["this", "",""];

		waitUntil {uiSleep 10; _taskID call BIS_fnc_taskCompleted || triggerActivated _trg};

		while {!(_taskID call BIS_fnc_taskCompleted)} do {

			if (triggerActivated _trg) then {

				for [{private _i = _waitingTime }, { _i > -1  }, { _i = _i - 60 }] do {

					if (!triggerActivated _trg) exitWith {
						["", "Patrol stopped!"] remoteExec ["BIS_fnc_showSubtitle",0];
					};

					if (_i > 0) then {
						["", str (_i/60) + " minutes left."] remoteExec ["BIS_fnc_showSubtitle",0];
					};

					switch (_i) do {
						case _waitingTime: {
							["", "Patrol started. Time: " + str (_waitingTime/60) + " minutes."] remoteExec ["BIS_fnc_showSubtitle",0];
						};

						case (_waitingTime - 60): {
							systemChat "wtf";
							if (round (random 1) > 0.35) then {
								private _number = [2,3] call BIS_fnc_randomInt;
								private _vehicles = [_pos,_number] call prj_fnc_reinforcement;
							} else {
								[_pos] call prj_fnc_sentry_patrol;
							};
						};

						case 0: {
							["", "Patrol completed successfully. Waiting for next zone..."] remoteExec ["BIS_fnc_showSubtitle",0];
							[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
							["missionNamespace", "money", 0, 2000] call prj_fnc_changePlayerVariableGlobal;
							uiSleep 2;
						};
					};

					uiSleep 60;
				};
			};

			uiSleep 5;
		};

		deleteVehicle _trg;
		deleteMarker _taskID;
		[_taskID] call BIS_fnc_deleteTask;
	};
};