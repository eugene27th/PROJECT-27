/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _startPos = [false,false,[],["NameCityCapital","NameCity","NameVillage"]] call prj_fnc_selectCaptPosition;

private _roadpos = [_startPos,500] call prj_fnc_select_road_position;
private _position = _roadpos # 0;
private _direction = _roadpos # 1;
private _distance_route = round (worldSize / 3);

// private _finish_pos = [_position, _distance_route, round (random 359)] call BIS_fnc_relPos;
private _finish_pos = [_position, (_distance_route - 1000), (_distance_route + 1000), 0, 0] call BIS_fnc_findSafePos;
_finish_pos = getPos ([_finish_pos, _distance_route] call BIS_fnc_nearestRoad);
_finish_pos set [2, 0];

private _finishGridPos = mapGridPosition _finish_pos;

[west, [_taskID], ["STR_SIDE_CONVOY_DESCRIPTION", "STR_SIDE_CONVOY_TITLE", ""], _startPos, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;
[_taskID,_startPos,"ColorOPFOR",0.4,[[500,500],"ELLIPSE"]] call prj_fnc_create_marker;

// uiSleep ([900,1100] call BIS_fnc_randomInt);

uiSleep ([15,25] call BIS_fnc_randomInt);

private _convoyUnitsArray = [_position,_direction,_finish_pos,[[enemy_vehiclesConvoyHeavy,1],[enemy_vehiclesConvoyLight,2]],_taskID] call prj_fnc_convoy_create;

uiSleep 20;

["side_convoy_start",[_finishGridPos]] remoteExec ["BIS_fnc_showNotification"];

private _gridMarkerData = _finishGridPos call BIS_fnc_gridToPos;
private _gridMarkerPos = [(_gridMarkerData # 0) # 0,(_gridMarkerData # 0) # 1,0];
private _gridMarkerSizes = _gridMarkerData # 1;

[_taskID + str "_finishGrid",_gridMarkerPos,"ColorOPFOR",0.7,[[_gridMarkerSizes # 0,_gridMarkerSizes # 1],"RECTANGLE"]] call prj_fnc_create_marker;
[_taskID + str "_finishGridTitle",_gridMarkerPos,"ColorBLACK",1,[],"mil_flag","destination sector"] call prj_fnc_create_marker;

[(_convoyUnitsArray # 1),_taskID] spawn {
	params ["_data","_taskID"];

	while {_taskID call BIS_fnc_taskCompleted} do {
		private _aliveConvoyUnits = _data select {alive _x};

		if ((count _aliveConvoyUnits) < 1) then {
			[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		};

		systemChat str (count _aliveConvoyUnits);
	};
};

waitUntil {uiSleep 5; _taskID call BIS_fnc_taskCompleted};

[_taskID] call BIS_fnc_deleteTask;

{
	deleteMarker _x;
} forEach [_taskID,_taskID + str "_finishGrid"];

[_convoyUnitsArray] spawn {
	params ["_data"];

	private _units = _data # 1;
	private _vehicles = _data # 0;

	// uiSleep 240;
	uiSleep 10;

	{
		deleteVehicle _x;
	} forEach _units;

	{
		if !(_x getVariable ["cannotDeleted",false]) then {
			deleteVehicle _x;
		};
	} forEach _vehicles;
};