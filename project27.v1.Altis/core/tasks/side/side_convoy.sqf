/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _centerPos = [false,false,[],["NameCityCapital","NameCity","NameVillage"]] call prj_fnc_selectCaptPosition;

private _roadpos = [_centerPos,1000] call prj_fnc_selectRoadPosition;
private _startPos = _roadpos # 0;
private _direction = _roadpos # 1;
private _distance_route = round (worldSize / 4);

private _finishPos = [_startPos, (_distance_route - 500), (_distance_route + 500), 0, 0] call BIS_fnc_findSafePos;
_finishPos = getPos ([_finishPos, _distance_route] call BIS_fnc_nearestRoad);
_finishPos set [2, 0];

private _finishGridPos = mapGridPosition _finishPos;

[west, [_taskID], ["STR_SIDE_CONVOY_DESCRIPTION", "STR_SIDE_CONVOY_TITLE", ""], _centerPos, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;
[_taskID,_centerPos,"ColorOPFOR",0.4,[[500,500],"ELLIPSE"]] call prj_fnc_createMarker;

[_taskID + "_finishPos",_finishPos,"ColorOPFOR",0.7,[[100,100],"RECTANGLE"]] call prj_fnc_createMarker;
[_taskID + "_finishPosTitle",_finishPos,"ColorBLACK",1,[],"mil_dot","destination sector"] call prj_fnc_createMarker;

uiSleep 1800;

private _allVehicles = [];
private _allUnits = [];
private _distanceForOneVehicle = 8;

private _convoyConfig = [[enemy_vehiclesConvoyHeavy,2],[enemy_vehiclesConvoyLight,1]];

{
	for "_i" from 1 to (_x # 1) do {
		private _correctPos = true;
		private _vehicleClass = selectRandom (_x # 0);

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

		private _units = [_vehicle,enemy_infantry,true] call prj_fnc_createCrew;

		_allUnits append _units;
		_allVehicles pushBack _vehicle;

		uiSleep 1;

		_vehicle addEventHandler ["GetIn", {
			params ["_vehicle", "_role", "_unit", "_turret"];

			if (isPlayer _unit) then {
				_vehicle removeEventHandler ["GetIn",_thisEventHandler];
				_vehicle setVariable ["cannotDeleted",true,true];
				_vehicle removeAllEventHandlers "FiredNear";
			};
		}];
		
		if (_i == 1) then {
			_vehicle addEventHandler ["FiredNear", {
				params ["_unit"];
				_unit removeAllEventHandlers "FiredNear";

				private _vehicles = [position _unit] call prj_fnc_createReinforcement;
			}];
		};

		{
			_vehicle addMagazineCargoGlobal [_x, [5,15] call BIS_fnc_randomInt];
		} forEach ["acex_intelitems_photo","acex_intelitems_document","acex_intelitems_notepad"];

		[_vehicle,_units,_taskID] spawn {
			params ["_vehicle","_units","_taskID"];

			waitUntil {sleep 10; !alive _vehicle || !canMove _vehicle || _taskID call BIS_fnc_taskCompleted};

			if (!alive _vehicle || !canMove _vehicle) then {
				private _playersNear = false;

				{
					if ((_x distance _vehicle) < 2000) exitWith {
						_playersNear = true;
					}
				} forEach allPlayers;

				if (!_playersNear) then {
					{deleteVehicle _x} forEach _units;
				};

				[_vehicle] spawn {
					params ["_vehicle"];

					uiSleep 300;

					if !(_vehicle getVariable ["cannotDeleted",false]) then {
						deleteVehicle _vehicle;
					};
				};
			};
		};

	};
} forEach _convoyConfig;

private _allGrpUnits = _allVehicles + _allUnits;

private _convoyGroup = createGroup [enemySide, true];
_allGrpUnits joinSilent _convoyGroup;

private _wpConwoy = _convoyGroup addWaypoint [_finishPos, 0];
_wpConwoy setWaypointSpeed "LIMITED";
_wpConwoy setWaypointType "MOVE";
_wpConwoy setWaypointFormation "COLUMN";

private _iedArray = missionNamespace getVariable ["iedArray",[]];
{enemySide revealMine _x} forEach _iedArray;

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
			};
		};
		uiSleep 10;
	};
};

waitUntil {sleep 5; {(_x distance _startPos) > 200} forEach _allVehicles || _taskID call BIS_fnc_taskCompleted};

if ({(_x distance _startPos) > 200} forEach _allVehicles) then {
	["side_convoy_start",[_finishGridPos]] remoteExec ["BIS_fnc_showNotification"];

	[_allUnits,_taskID,_reward] spawn {
		params ["_allUnits","_taskID","_reward"];

		while {!(_taskID call BIS_fnc_taskCompleted)} do {
			uiSleep 10;

			private _aliveConvoyUnits = _allUnits select {alive _x};

			if ((count _aliveConvoyUnits) < 1 && !(_taskID call BIS_fnc_taskCompleted)) then {
				[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
				["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
			};
		};
	};
};

waitUntil {uiSleep 5; {(_x distance _finishPos) < 300} forEach _allVehicles || _taskID call BIS_fnc_taskCompleted};

if ({(_x distance _finishPos) < 300} forEach _allVehicles) then {
	[_taskID,"FAILED"] call BIS_fnc_taskSetState;
	uiSleep 2;
};

{
	deleteMarker _x;
} forEach [_taskID,_taskID + str "_finishPos",_taskID + str "_finishPosTitle"];

[_allVehicles,_allUnits,_taskID] spawn {
	params ["_allVehicles","_allUnits","_taskID"];

	if ((_taskID call BIS_fnc_taskState) == "SUCCEEDED") then {
		uiSleep 300;
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