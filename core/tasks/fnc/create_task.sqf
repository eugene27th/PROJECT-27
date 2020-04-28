/* 
	written by eugene27.
	server only
    1.3.0
*/

private ["_taskID","_tasks","_selected_task"];

_taskID = missionNamespace getVariable ["taskID",0];

// systemChat format ["%1",_taskID];

_tasks = [
	["side_alarm_button.sqf",200],
	["side_ammo_cache.sqf",200],
	["side_capture_leader.sqf",200],
	["side_capture_zone.sqf",200],
	["side_checkpoint.sqf",200],
	["side_convoy.sqf",200],
	["side_destroy_tower.sqf",200],
	["side_destruction_of_vehicles.sqf",200],
	["side_hostage.sqf",200],
	["side_humanitarian_aid.sqf",200],
	["side_intel_uav.sqf",200],
	["side_liquidation_leader.sqf",200],
	["side_mines.sqf",200],
	["side_rescue.sqf",200]
];

_selected_task = selectRandom _tasks;

[_taskID,(_selected_task select 1)] execVM "core\tasks\" + (_selected_task select 0);

_taskID = missionNamespace setVariable ["taskID",_taskID + 1,true];