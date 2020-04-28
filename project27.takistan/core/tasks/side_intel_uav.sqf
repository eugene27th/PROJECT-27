/*
	written by eugene27.
	server only
	1.3.0
*/

params [
    "_taskID","_reward"
];

private ["_taskID","_center_pos","_pos","_trg","_enemy"];

_taskID = "SIDE_" + str _taskID;

_center_pos = [3] call prj_fnc_select_position;
_pos = [_center_pos, 200, 500, 5, 0] call BIS_fnc_findSafePos;

_uav = friendly_UAV_array createVehicle _pos;
_uav setDamage 0.8;
_uav allowDamage false;
_uav_pylons = "true" configClasses (configFile >> "CfgVehicles" >> friendly_UAV_array >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
{_uav setPylonLoadout [_x, ""]} forEach _uav_pylons;

_uav_smoke = createVehicle ["test_EmptyObjectForSmoke", position _uav, [], 0, "CAN_COLLIDE"];
_uav_smoke attachTo [_uav, [0, 0, 0]];

[west, [_taskID], ["STR_SIDE_INTEL_UAV_DESCRIPTION", "STR_SIDE_INTEL_UAV_TITLE", ""], _center_pos, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;

[_taskID,_center_pos,"ColorWEST",0.7,[[500,500],"ELLIPSE"]] call prj_fnc_create_marker;

_trg = createTrigger ["EmptyDetector", position _uav, true];
_trg setTriggerArea [10, 10, 0, false, 20];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements ["this", "",""];
_trg attachTo [_uav, [0, 0, 0]];

waitUntil {sleep 5; triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

if (triggerActivated _trg) then {
	_enemy = [];

	for [{private _i = 0 }, { _i < [10,20] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
		private _grpname = createGroup independent;
		private _position = [position _uav, [200,300] call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
		private _unit = _grpname createUnit [selectRandom enemy_units_array, _position, [], 0, "NONE"];
		_enemy pushBack _unit;
	};
};

{_x doMove position _uav} forEach _enemy;

while {!(_taskID call BIS_fnc_taskCompleted)} do {

	if (triggerActivated _trg) then {

		for [{private _i = 120 }, { _i > -1  }, { _i = _i - 10 }] do {

			if (!triggerActivated _trg) exitWith {
				["HQ", "Download stopped!"] remoteExec ["BIS_fnc_showSubtitle",0];
				["stopdnlddronedate"] remoteExec ["playSound", 0];
			};

			switch (_i) do {	
				case 120: {
					["HQ", "The signal is good. Start of download."] remoteExec ["BIS_fnc_showSubtitle",0];
					["startdnlddronedate"] remoteExec ["playSound", 0];
				};
				case 90: {
					["90dnlddronedate"] remoteExec ["playSound", 0];
				};
				case 60: {
					["60dnlddronedate"] remoteExec ["playSound", 0];
				};
				case 30: {
					["30dnlddronedate"] remoteExec ["playSound", 0];
				};
				case 0: {
					["HQ", "Data downloaded successfully."] remoteExec ["BIS_fnc_showSubtitle",0];
					["finishdnlddronedate"] remoteExec ["playSound", 0];
					[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
					[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
					uiSleep 2;
				};
			};

			if (_i > 0) then {
				["HQ", str _i + " seconds left."] remoteExec ["BIS_fnc_showSubtitle",0];
			};

			uiSleep 10;
		};
	};

	uiSleep 5;
};

waitUntil {sleep 5;_taskID call BIS_fnc_taskCompleted};

[_taskID] call BIS_fnc_deleteTask;
deleteMarker _taskID;

uiSleep 30;

{deleteVehicle _x} forEach [_trg,_uav,_uav_smoke] + (if (!isNil "_enemy") then {_enemy});