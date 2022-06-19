/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _center_pos = [3] call prj_fnc_selectPosition;
private _pos = [_center_pos, 200, 500, 5, 0] call BIS_fnc_findSafePos;

private _uav = "B_UAV_02_dynamicLoadout_F" createVehicle _pos;
_uav setDamage 0.8;
_uav allowDamage false;
_uav_pylons = "true" configClasses (configFile >> "CfgVehicles" >> "B_UAV_02_dynamicLoadout_F" >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
{_uav setPylonLoadout [_x, ""]} forEach _uav_pylons;

private _uav_smoke = createVehicle ["test_EmptyObjectForSmoke", position _uav, [], 0, "CAN_COLLIDE"];
_uav_smoke attachTo [_uav, [0, 0, 0]];

[west, [_taskID], ["STR_SIDE_INTEL_UAV_DESCRIPTION", "STR_SIDE_INTEL_UAV_TITLE", ""], _center_pos, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;

[_taskID,_center_pos,"ColorWEST",0.7,[[500,500],"ELLIPSE"]] call prj_fnc_createMarker;

private _trg = createTrigger ["EmptyDetector", position _uav, true];
_trg setTriggerArea [10, 10, 0, false, 20];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements ["this", "",""];
_trg attachTo [_uav, [0, 0, 0]];

waitUntil {uiSleep 5; triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

private "_enemy";

if (triggerActivated _trg) then {
	_enemy = [];

	private _grp = createGroup [enemySide, true];
	private _position = [position _uav, [400,600] call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;

	for [{private _i = 0 }, { _i < [15,20] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
		private _unit = _grp createUnit [selectRandom enemy_infantry, _position, [], 0, "NONE"];

		if (dayTime >= 19 || dayTime < 5) then {
			[_unit, 3] call WBK_LoadAIThroughEden;
		};
		
		_enemy pushBack _unit;
	};

	private _wp = _grp addWaypoint [_playerPos, 0];
	_wp setWaypointSpeed "FULL";  
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointType "SAD";
	_wp setWaypointFormation "DIAMOND";

	if (dayTime > 5 && dayTime < 19) then {
		[_pos] call prj_fnc_createReinforcement;
	};
};

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
					["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
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

waitUntil {uiSleep 5;_taskID call BIS_fnc_taskCompleted};

[_taskID] call BIS_fnc_deleteTask;
deleteMarker _taskID;

uiSleep 30;

{deleteVehicle _x} forEach [_trg,_uav,_uav_smoke];

if (!isNil "_enemy") then {
	[_enemy] spawn {
		params ["_enemy"];
		uiSleep 300;
		{deleteVehicle _x} forEach _enemy;
	};
};