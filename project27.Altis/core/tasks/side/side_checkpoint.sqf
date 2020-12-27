/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _roadpos = [4] call prj_fnc_select_road_position;
private _pos = _roadpos select 0;
private _direction = _roadpos select 1;

[_taskID,_pos,"ColorEAST",0.7,[[30,30],"ELLIPSE"]] call prj_fnc_create_marker;

private _trg = createTrigger ["EmptyDetector", _pos, true];
_trg setTriggerArea [30, 30, 0, false, 20];
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
_trg setTriggerStatements ["this", "", ""];

private _vehicles = [];

private _vehicle = selectRandom (enemy_vehicles_light + enemy_vehicles_heavy) createVehicle _pos;
_vehicle setDir _direction + 90;
private _crew_units = [_vehicle,enemy_infantry] call prj_fnc_create_crew;
_vehicles pushBack _vehicle;

_vehicle addEventHandler ["FiredNear", {
	params ["_unit"];
	_unit removeEventHandler ["FiredNear", _thisEventHandler];

	private _number = [1,3] call BIS_fnc_randomInt;
	private _vehicles = [position _unit,[1500,2500],_number] call prj_fnc_reinforcement;

	[_vehicles,600,60] spawn prj_fnc_check_and_delete;
}];

for "_i" from 1 to 2 do {
	private _static = (selectRandom enemy_turrets) createVehicle (_pos findEmptyPosition [(10 * _i), 150, "B_HMG_01_high_F"]);
	_vehicles pushBack _static;
	private _crew = [_static,enemy_infantry] call prj_fnc_create_crew;
	_crew_units = _crew_units + _crew;
};

_composition = [
	["Land_BagFence_Long_F",[-0.0192871,-2.23193,-0.000999928],0,1,0,[],"","",true,false], 
	["Land_BagFence_Long_F",[0.106201,2.72778,-0.000999928],0,1,0,[],"","",true,false], 
	["Land_WoodenWindBreak_01_F",[0.0856934,-3.78625,-0.00102663],180,1,0,[],"","",true,false], 
	["Land_WoodenWindBreak_01_F",[0.0314941,4.18152,-0.00102663],0,1,0,[],"","",true,false]
];
[_pos, _direction, _composition, 0] call BIS_fnc_objectsMapper;

private _enemies = [];
for [{private _i = 0 }, { _i < [7,10] call BIS_fnc_randomInt}, { _i = _i + 1 }] do {
    private _grpname = createGroup independent;
    private _pos = [_pos, 10, 100, 1, 0] call BIS_fnc_findSafePos;
    private _unit = _grpname createUnit [selectRandom enemy_infantry, _pos, [], 0, "NONE"];
	_unit setDir (round (random 360));
    _enemies pushBack _unit;
};

[west, [_taskID], ["STR_SIDE_CHECKPOINT_DESCRIPTION", "STR_SIDE_CHECKPOINT_TITLE", ""], _pos, "CREATED", 0, true, "target"] call BIS_fnc_taskCreate;

waitUntil {uiSleep 5;triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

if (triggerActivated _trg) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
    ["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteMarker _taskID;

if !(triggerActivated _trg) then {
	uiSleep 120;
	{deleteVehicle _x} forEach _vehicles;
};

_enemies = _enemies + _crew_units;
[_enemies] spawn {
	params ["_enemies"];
	uiSleep 120;
	{deleteVehicle _x} forEach _enemies;
};