/*
	written by eugene27.
	server only
    1.3.0
*/

params [
    "_taskID","_reward"
];

private ["_taskID","_roadpos","_pos","_direction","_trg","_vehicle","_composition","_crew_units","_crew_group","_vehicles"];

_taskID = "SIDE_" + str _taskID;

_roadpos = [4] call prj_fnc_select_road_position;
_pos = _roadpos select 0;
_direction = _roadpos select 1;

[_taskID,_pos,"ColorEAST",0.7,[[30,30],"ELLIPSE"]] call prj_fnc_create_marker;

_trg = createTrigger ["EmptyDetector", _pos, true];
_trg setTriggerArea [30, 30, 0, false, 20];
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
_trg setTriggerStatements ["this", "", ""];

_vehicles = [];

_vehicle = selectRandom (enemy_cars_array + enemy_heavy_armed_vehicle_array) createVehicle _pos;
_vehicle setDir _direction + 90;
_vehicle lock true;
_crew_units = [_vehicle,enemy_units_array] call prj_fnc_create_crew;
_vehicles pushBack _vehicle;

for "_i" from 1 to 2 do {
	private _static = (selectRandom enemy_static_array) createVehicle (_pos findEmptyPosition [(10 * _i), 150, "B_HMG_01_high_F"]);
	_static lock true;
	_vehicles pushBack _static;
	private _crew = [_static,enemy_units_array] call prj_fnc_create_crew;
	_crew_units = _crew_units + _crew;
};

_composition = [
	["Land_BagFence_Long_F",[-0.0192871,-2.23193,-0.000999928],0,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[0.106201,2.72778,-0.000999928],0,1,0,[],"","",true,false], 
	["Land_WoodenWindBreak_01_F",[0.0856934,-3.78625,-0.00102663],180,1,0,[],"","",true,false], 
	["Land_WoodenWindBreak_01_F",[0.0314941,4.18152,-0.00102663],0,1,0,[],"","",true,false]
];
[_pos, _direction, _composition, 0] call BIS_fnc_objectsMapper;

[west, [_taskID], ["STR_SIDE_CHECKPOINT_DESCRIPTION", "STR_SIDE_CHECKPOINT_TITLE", ""], _pos, "CREATED", 0, true, "target"] call BIS_fnc_taskCreate;

waitUntil {sleep 5;triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

if (triggerActivated _trg) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
    [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteMarker _taskID;

uiSleep 30;

{deleteVehicle _x} forEach _vehicles + _crew_units;