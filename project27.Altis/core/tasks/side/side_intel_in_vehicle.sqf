/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _roadpos = [4] call prj_fnc_select_road_position;
private _position = _roadpos # 0;
private _direction = _roadpos # 1;
private _distance_route = round ((worldSize / 5) * 3);

private _finish_pos = [_position, _distance_route, round (random 359)] call BIS_fnc_relPos;
_finish_pos = getPos ([_finish_pos, _distance_route] call BIS_fnc_nearestRoad); 
_finish_pos set [2, 0];

private _vehicle = (selectRandom enemy_vehicles_light) createVehicle _position;
_vehicle setDir _direction;

private _crew_units = [_vehicle,enemy_infantry,true] call prj_fnc_create_crew;

private _intel_objects = ["acex_intelitems_photo","acex_intelitems_document"];

for "_i" from 0 to ((count _intel_objects) - 1) do {
	_vehicle addMagazineCargoGlobal [(_intel_objects # _i), [10,30] call BIS_fnc_randomInt];
};

_vehicle setVariable ["taskData",[_intel_objects,_taskID]];

_vehicle addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];

	private _intel_objects = (_container getVariable "taskData") # 0;
	private _taskID = (_container getVariable "taskData") # 1;
	private _vehicle_items = ((getItemCargo _container) # 0) + ((getMagazineCargo _container) # 0);
	private _items = false;

	{
		if (_x in _intel_objects) then {
			_items = true;
		};
	} forEach _vehicle_items;

	if (!_items) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	};

	hint str _vehicle_items;
}];

(crew _vehicle) doMove _finish_pos;

[west, [_taskID], ["STR_SIDE_INTEL_VEHICLE_DESCRIPTION", "STR_SIDE_INTEL_VEHICLE_TITLE", ""], _position, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;

private _marker_name = "_vehicle_side_" + str _taskID;
[_marker_name,_position,"ColorOPFOR",1,[],"o_unknown","vehicle"] call prj_fnc_create_marker;

while {alive _vehicle && !(_taskID call BIS_fnc_taskCompleted)} do {
	_marker_name setMarkerPos (position _vehicle);
	uiSleep 5;
	if ((random 1) < 0.3) then {
		_marker_name setMarkerText "reconnecting...";
		uiSleep 10;
		_marker_name setMarkerText "vehicle";
	};
	if ((_vehicle distance _finish_pos) < 500) then {
		[_taskID,"FAILED"] call BIS_fnc_taskSetState;
	};
};

waitUntil {sleep 5; !alive _vehicle || _taskID call BIS_fnc_taskCompleted};

if (!alive _vehicle) then {
    [_taskID,"FAILED"] call BIS_fnc_taskSetState;
    uiSleep 2;
};

if ((_taskID call BIS_fnc_taskState) in ["CANCELED","FAILED"]) then {
	deleteVehicle _vehicle;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach _crew_units;
deleteMarker _marker_name;