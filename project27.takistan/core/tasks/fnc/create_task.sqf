/* 
	written by eugene27.
	server only
    1.3.0
*/

private ["_taskID","_tasks","_selected_task"];

_taskID = missionNamespace getVariable ["taskID",0];

_tasks = [
	["side_alarm_button",200],
	["side_ammo_cache",200],
	["side_capture_leader",200],
	["side_capture_zone",200],
	["side_checkpoint",200],
	["side_convoy",200],
	["side_destroy_tower",200],
	["side_destruction_of_vehicles",200],
	["side_hostage",200],
	["side_humanitarian_aid",200],
	["side_intel_uav",200],
	["side_liquidation_leader",200],
	["side_mines",200],
	["side_rescue",200]
];

_selected_task = selectRandom _tasks;

[_taskID,(_selected_task select 1)] execVM "core\tasks\side\" + (_selected_task select 0) + ".sqf";

_taskID = missionNamespace setVariable ["taskID",_taskID + 1,true];

if (prj_debug) then {
	systemChat format ["id: %1 | task: %2 | reward: %3",_taskID, _selected_task select 0, str (_selected_task select 1)];
};