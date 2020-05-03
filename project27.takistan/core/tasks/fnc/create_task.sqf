/* 
	written by eugene27.
	server only
    1.3.0
*/

private ["_taskID","_tasks","_selected_task"];

_taskID = missionNamespace getVariable ["taskID",0];

_tasks = [
	["prj_side_alarm_button",200],
	["prj_side_ammo_cache",200],
	["prj_side_capture_leader",200],
	["prj_side_capture_zone",200],
	["prj_side_checkpoint",200],
	["prj_side_convoy",200],
	["prj_side_destroy_tower",200],
	["prj_side_destruction_of_vehicles",200],
	["prj_side_hostage",200],
	["prj_side_humanitarian_aid",200],
	["prj_side_intel_uav",200],
	["prj_side_liquidation_leader",200],
	["prj_side_mines",200],
	["prj_side_rescue",200]
];

_selected_task = selectRandom _tasks;

[_taskID,(_selected_task select 1)] call (call compile (_selected_task select 0));

_taskID = missionNamespace setVariable ["taskID",_taskID + 1,true];

if (prj_debug) then {
	systemChat format ["id: %1 | task: %2 | reward: %3",_taskID, _selected_task select 0, str (_selected_task select 1)];
};