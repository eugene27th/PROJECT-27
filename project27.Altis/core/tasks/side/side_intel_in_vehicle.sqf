/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _roadpos = [4] call prj_fnc_select_road_position;
private _position = _roadpos select 0;
private _direction = _roadpos select 1;

private _finish_pos = [_position, 5000, round (random 359)] call BIS_fnc_relPos;
_finish_pos = getPos ([_finish_pos, 5000] call BIS_fnc_nearestRoad); 
_finish_pos set [2, 0];

private _vehicle = selectRandom (enemy_vehicles_light + enemy_vehicles_heavy) createVehicle _position;
_vehicle setDir _direction;

private _crew_units = [_vehicle,enemy_infantry,true] call prj_fnc_create_crew;

private _intel_objects = ["acex_intelitems_photo","acex_intelitems_document"];

for "_i" from 1 to (count _intel_objects) do {
	_vehicle addMagazineCargoGlobal [(_intel_objects # _i), [10,30] call BIS_fnc_randomInt];
};

(crew _vehicle) doMove _finish_pos;

[west, [_taskID], ["STR_SIDE_INTEL_VEHICLE_DESCRIPTION", "STR_SIDE_INTEL_VEHICLE_TITLE", ""], objNull, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;

private _marker_name = "_vehicle_side_" + str _taskID;
[_marker_name,_position,"ColorOPFOR",1,[],"o_unknown"] call prj_fnc_create_marker;

while {alive _vehicle || !(_taskID call BIS_fnc_taskCompleted)} do {
	_marker_name setMarkerPos (position _vehicle);
	uiSleep 5;
	if ((random 1) < 0.7) then {
		_marker_name setMarkerText "reconnecting...";
		uiSleep 10;
		_marker_name setMarkerText "";
	};
};

waitUntil {sleep 5; !alive _vehicle || _taskID call BIS_fnc_taskCompleted};

if (!alive _vehicle) then {
    [_taskID,"FAILED"] call BIS_fnc_taskSetState;
	deleteVehicle _vehicle;
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach _crew_units;
deleteMarker _marker_name;