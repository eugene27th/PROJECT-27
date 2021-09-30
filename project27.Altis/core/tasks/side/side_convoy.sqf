/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _centerPos = [false,false,[],["NameCityCapital","NameCity","NameVillage"]] call prj_fnc_selectCaptPosition;

private _roadpos = [_centerPos,500] call prj_fnc_select_road_position;
private _startPos = _roadpos # 0;
private _direction = _roadpos # 1;
private _distance_route = round (worldSize / 4);

private _finishPos = [_startPos, (_distance_route - 1000), (_distance_route + 1000), 0, 0] call BIS_fnc_findSafePos;
_finishPos = getPos ([_finishPos, _distance_route] call BIS_fnc_nearestRoad);
_finishPos set [2, 0];

private _finishGridPos = mapGridPosition _finishPos;

[west, [_taskID], ["STR_SIDE_CONVOY_DESCRIPTION", "STR_SIDE_CONVOY_TITLE", ""], _centerPos, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;
[_taskID,_centerPos,"ColorOPFOR",0.4,[[500,500],"ELLIPSE"]] call prj_fnc_create_marker;

// uiSleep ([900,1100] call BIS_fnc_randomInt);

uiSleep ([15,25] call BIS_fnc_randomInt);

private _allVehicles = [];
private _allUnits = [];
private _distanceForOneVehicle = 8;

private _convoyConfig = [[enemy_vehiclesConvoyHeavy,1],[enemy_vehiclesConvoyLight,2]];

{
	for "_i" from 1 to (_x # 1) do {
		private _correctPos = true;
		private _vehicleClass = selectRandom (_x # 0);

		systemChat str (_startPos findEmptyPosition [0,0,_vehicleClass]);

		if ((count (_startPos findEmptyPosition [0,0,_vehicleClass])) < 1) then {
			_correctPos = false;
		};

		if (!_correctPos) then {
			_startPos = [_startPos, 0, 40, 4] call BIS_fnc_findSafePos;	
		};

		private _vehicle = _vehicleClass createVehicle _startPos;
		_vehicle setDir (_vehicle getDir _finishPos);

		if (_correctPos) then {
			_startPos = [_startPos, _distanceForOneVehicle, _direction + 180] call BIS_fnc_relPos;
		};

		private _units = [_vehicle,enemy_infantry,true] call prj_fnc_create_crew;

		_allUnits append _units;
		_allVehicles pushBack _vehicle;

		uiSleep 1;

		_vehicle addEventHandler ["GetIn", {
			params ["_vehicle", "_role", "_unit", "_turret"];

			if (isPlayer _unit) then {
				_vehicle removeEventHandler ["GetIn",_thisEventHandler];
				_vehicle setVariable ["cannotDeleted",true,true];
				systemChat "машина игрока";
			};
		}];
		
		if (_i == 1) then {
			_vehicle addEventHandler ["FiredNear", {
				params ["_unit"];
				_unit removeEventHandler ["FiredNear", _thisEventHandler];

				private _number = [2,3] call BIS_fnc_randomInt;
				private _vehicles = [position _unit,_number] call prj_fnc_reinforcement;

				systemChat "выстрелы у головной машины";
			}];
		};

		{
			_vehicle addMagazineCargoGlobal [_x, [5,15] call BIS_fnc_randomInt];
		} forEach ["acex_intelitems_photo","acex_intelitems_document","acex_intelitems_notepad"];

	};
} forEach _convoyConfig;

private _allGrpUnits = _allVehicles + _allUnits;

private _convoyGroup = createGroup independent;
_allGrpUnits joinSilent _convoyGroup;

private _wpConwoy = _convoyGroup addWaypoint [_finishPos, 0];
_wpConwoy setWaypointSpeed "LIMITED";
_wpConwoy setWaypointType "MOVE";
_wpConwoy setWaypointFormation "COLUMN";

[_allVehicles,_allUnits,_convoyGroup,_taskID] spawn {
	params ["_allVehicles","_allUnits","_convoyGroup","_taskID"];

	private _count = (count _allVehicles) - 1;
	private _notLeadUnits = [];

	for "_i" from 1 to _count do {
		if (alive (_allVehicles # _i)) then {
			_notLeadUnits append (crew (_allVehicles # _i));
		};
	};

	while {!(_taskID call BIS_fnc_taskCompleted)} do {
		for "_i" from 0 to _count do {
			private _firstVehicle = _allVehicles # _i;

			if (_i == _count || !alive _firstVehicle) exitWith {};
			
			private _secondVehicle = _allVehicles # (_i + 1);

			if ((_firstVehicle distance _secondVehicle) > 80) exitWith {
				_notLeadUnits doFollow (leader _convoyGroup);
				systemChat "пинок";
			};
		};
		uiSleep 10;
	};
};

waitUntil {sleep 5; {(_x distance _startPos) > 200} forEach _allVehicles;};

["side_convoy_start",[_finishGridPos]] remoteExec ["BIS_fnc_showNotification"];

private _gridMarkerData = _finishGridPos call BIS_fnc_gridToPos;
private _gridMarkerPos = [(_gridMarkerData # 0) # 0,(_gridMarkerData # 0) # 1,0];
private _gridMarkerSizes = _gridMarkerData # 1;

[_taskID + str "_finishGrid",_gridMarkerPos,"ColorOPFOR",0.7,[[_gridMarkerSizes # 0,_gridMarkerSizes # 1],"RECTANGLE"]] call prj_fnc_create_marker;
[_taskID + str "_finishGridTitle",_gridMarkerPos,"ColorBLACK",1,[],"mil_flag","destination sector"] call prj_fnc_create_marker;

[_allUnits,_taskID] spawn {
	params ["_allUnits","_taskID"];

	while {!(_taskID call BIS_fnc_taskCompleted)} do {
		private _aliveConvoyUnits = _allUnits select {alive _x};

		if ((count _aliveConvoyUnits) < 1) then {
			[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
			["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
		};

		systemChat str (count _aliveConvoyUnits);

		uiSleep 10;
	};
};

waitUntil {uiSleep 5; {(_x distance _finishPos) < 300} forEach _allVehicles || _taskID call BIS_fnc_taskCompleted};

if ((_x distance _finishPos) < 300} forEach _allVehicles) then {
	[_taskID,"FAILED"] call BIS_fnc_taskSetState;
};

{
	deleteMarker _x;
} forEach [_taskID,_taskID + str "_finishGrid",_taskID + str "_finishGridTitle"];

[_allVehicles,_allUnits,_taskID] spawn {
	params ["_allVehicles","_allUnits","_taskID"];

	systemChat "del";

	if ((_taskID call BIS_fnc_taskState) == "SUCCEEDED") then {
		uiSleep 240;
	};

	[_taskID] call BIS_fnc_deleteTask;

	{
		deleteVehicle _x;
	} forEach _allUnits;

	{
		if !(_x getVariable ["cannotDeleted",false]) then {
			deleteVehicle _x;
		};
	} forEach _allVehicles;
};