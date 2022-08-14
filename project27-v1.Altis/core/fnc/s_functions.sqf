/*
	written by eugene27.
	only server functions
*/

prj_fnc_changeVariable = {
	params ["_space", "_name", "_value"];

	_oldValue = (call (compile _space)) getVariable _name;
	(call (compile _space)) setVariable [_name, _oldValue + _value, true];
};

prj_fnc_changePlayerVariableGlobal = {
	params ["_space","_name","_number", "_value"];

	{
		private _UID = getPlayerUID _x;
		private _variable = ((missionNamespace getVariable _UID) # _number) # 1;
		private _player_table = missionNamespace getVariable _UID;
		
		_player_table set [_number,[_name,_variable + _value]];
		(call (compile _space)) setVariable [_UID, _player_table, true];
	} forEach allPlayers;
};

prj_fnc_selectPosition = {
	params ["_type_location",["_position_around", true],["_nearest",[]]];

	private "_selected_pos";

	private _types_location = switch (_type_location) do {
		case 1: {["NameCityCapital","NameCity","NameVillage"]};
		case 2: {["RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]};
		case 3: {["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"]};
		case 4: {["NameCityCapital","NameCity","NameVillage","NameLocal","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]};
	};

	private _all_types = ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"];

	private _global_locations = nearestLocations [[worldSize / 2, worldsize / 2, 0], _types_location, worldSize * 1.5];
	private _safe_locations = nearestLocations [position spawn_zone, _all_types, 2000];
	private _locations = _global_locations - _safe_locations;

	if !(_nearest isEqualTo []) then {
		_filtered_locations = [_locations, [], { (position spawn_zone) distance (locationPosition _x) }, "ASCEND"] call BIS_fnc_sortBy;
		_selected_pos = locationPosition (_filtered_locations # (_nearest call BIS_fnc_randomInt));
	} else {
		_selected_pos = locationPosition (selectRandom _locations);
	};

	private _selected_pos = locationPosition (selectRandom _locations);

	if (_position_around) then {
		_selected_pos = [_selected_pos, 0, 700, 5, 0] call BIS_fnc_findSafePos;
	};

	_selected_pos set [2, 0];
	_selected_pos
};

prj_fnc_selectCaptPosition = {
	params [["_position_around",false],["_captured",false],["_nearest",[]],["_typeLocations",["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"]]];

	private _locations = missionNamespace getVariable "location_triggers";

	private _filtered_locations = switch (_captured) do {
		case true: {
			_locations select {(_x getVariable "captured") && (_x getVariable "location") in _typeLocations}
		};
		case false: {
			_locations select {!(_x getVariable "captured") && (_x getVariable "location") in _typeLocations}
		};
	};

	private "_selected_pos";

	if !(_nearest isEqualTo []) then {
		_filtered_locations = [_filtered_locations, [], { (position spawn_zone) distance (position _x) }, "ASCEND"] call BIS_fnc_sortBy;
		_selected_pos = position (_filtered_locations # (_nearest call BIS_fnc_randomInt));
	} else {
		_selected_pos = position (selectRandom _filtered_locations);
	};

	if (_position_around) then {
		_selected_pos = [_selected_pos, 0, 700, 5, 0] call BIS_fnc_findSafePos;
	};

	_selected_pos set [2, 0];
	_selected_pos
};

prj_fnc_selectRoadPosition = {
	params [["_pos",4],["_radius",3000]];

	private _returndata = [];

	if ((typeName _pos) != "ARRAY") then {
		_pos = [_pos] call prj_fnc_selectPosition;
	};

	private _roads = _pos nearRoads _radius;
	private _roads = _roads select {isOnRoad _x};

	if ((count _roads) >= 2) then {
		private _road = selectRandom _roads;
		private _pos = getPos _road;
		_pos set [2, 0];

		private _roadConnectedTo = roadsConnectedTo _road;
		private _connectedRoad = _roadConnectedTo select 0;
		private _direction = _road getDir _connectedRoad;

		_returndata = [_pos,_direction];
	} else {
		private _pos = [_pos, round ((_radius / 100) * 10), _radius, 3, 0] call BIS_fnc_findSafePos;
		private _direction = round (random 360);
		_returndata = [_pos,_direction];
	};
	
	_returndata
};

prj_fnc_selectRoadPositionAround = {
	params ["_pos",["_radius",[1000,3000]]];

	private "_returndata";

	private _all_roads = _pos nearRoads (_radius # 1);
	private _del_roads = _pos nearRoads (_radius # 0);

	private _roads = _all_roads - _del_roads;
	private _roads = _roads select {isOnRoad _x};

	if ((count _roads) >= 2) then {
		private _road = selectRandom _roads;
		private _pos = getPos _road;
		_pos set [2, 0];
		private _roadConnectedTo = roadsConnectedTo _road;
		private _connectedRoad = _roadConnectedTo select 0;
		private _direction = _road getDir _connectedRoad;
		_returndata = [_pos,_direction];
	} else {
		private _pos = [_pos, _radius # 0, _radius # 1, 3, 0] call BIS_fnc_findSafePos;
		private _direction = round (random 360);
		_returndata = [_pos,_direction];
	};
	_returndata
};

prj_fnc_createCrowd = {
    params ["_pos",["_relPos",false],["_radius",[4,15]],["_number_of",[4,8]]];
  
    private _units = [];

	if (_relPos) then {
		_pos = [_pos, 80, 150, 3, 0] call BIS_fnc_findSafePos;
	};

	private _ground_enemies_grp = createGroup [enemySide, true];

    for [{private _i = 0 }, { _i < (_number_of call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
        private _position = [_pos, _radius call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
        private _unit = _ground_enemies_grp createUnit [selectRandom enemy_infantry, _position, [], 0, "NONE"];
        doStop _unit;
        _unit setDir (round (random 360));

        _units pushBack _unit;
    };

    _units
};

prj_fnc_createPatrol = {
	params ["_cpos","_radius","_inf",["_voice",false]];

	prj_fnc_getNumberOfUnits = {
		params ["_number"];

		private _number_result = switch (_number) do {
			case 0: {1};
			case 1: {[2,4] call BIS_fnc_randomInt};
			case 2: {[4,8] call BIS_fnc_randomInt};
			case 3: {[8,12] call BIS_fnc_randomInt};
			default {1};
		};
		_number_result
	};

	private _units = [];

	if ((_inf # 0) != 0) then {
		for [{private _i = 0 }, { _i < (_inf # 0) }, { _i = _i + 1 }] do {
			private _group = createGroup [enemySide, true];
			private _pos = [_cpos, 10, _radius, 1, 0] call BIS_fnc_findSafePos;
			if (!isNil "_pos") then {
				for [{private _i = 0 }, { _i < [(_inf # 1)] call prj_fnc_getNumberOfUnits }, { _i = _i + 1 }] do {
					private _unit = _group createUnit [selectRandom enemy_infantry, _pos, [], 0, "NONE"];
					if (!_voice) then {
						[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];
					};
					_units pushBack _unit;
					if (prj_debug) then {"юнит патруля создан" remoteExec ["systemChat"]};
					uiSleep 0.5;
				};
				_group setBehaviour "SAFE";
				_group setSpeedMode "LIMITED";
				_group setCombatMode "YELLOW";
				_group setFormation (["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"] call BIS_fnc_selectRandom);

				//create waypoints
				for "_i" from 1 to 5 do {
					private _pos = [_cpos, 10, _radius, 1, 0] call BIS_fnc_findSafePos;
					private _wp = _group addWaypoint [_pos, 0];
					_wp setWaypointType "MOVE";
					_wp setWaypointCompletionRadius 50;
					_wp setWaypointTimeout [0,2,6];
					if (prj_debug) then {"WP для группы создан" remoteExec ["systemChat"]};
				};

				private _pos_wp = [_cpos, 10, _radius, 1, 0] call BIS_fnc_findSafePos;

				private _wp_cycle = _group addWaypoint [_pos_wp, 0];
				_wp_cycle setWaypointType "CYCLE";
				_wp_cycle setWaypointCompletionRadius 50;
			};
			uiSleep 0.5;
		};
	};
	
	_units
};

prj_fnc_createCheckpoint = {
	params ["_pos",["_direction",0],["_spawnComposition",false],["_radius",70]];

	private _vehicles = [];

	private _barricadingVehicle = (selectRandom enemy_vehicles_light) createVehicle _pos;
	_barricadingVehicle setDir _direction + 90;
	_vehicles pushBack _barricadingVehicle;
	
	private _crewUnits = [_barricadingVehicle,enemy_infantry] call prj_fnc_createCrew;
	
	_barricadingVehicle addEventHandler ["FiredNear", {
		params ["_unit"];
		_unit removeAllEventHandlers "FiredNear";
		
		[position _unit] call prj_fnc_createSentryPatrol;
	}];

	for "_i" from 0 to 1 do {
		private _static = (selectRandom enemy_turrets) createVehicle (_pos findEmptyPosition [(10 * _i), 150, "B_HMG_01_high_F"]);
		_static setDir _direction + (_i * 180);
		_vehicles pushBack _static;
		private _staticCrew = [_static,enemy_infantry] call prj_fnc_createCrew;
		_crewUnits = _crewUnits + _staticCrew;
	};

	if (_spawnComposition) then {
		_composition = [
			["Land_BagFence_Long_F",[-0.0192871,-2.23193,-0.000999928],0,1,0,[],"","",true,false], 
			["Land_BagFence_Long_F",[0.106201,2.72778,-0.000999928],0,1,0,[],"","",true,false], 
			["Land_WoodenWindBreak_01_F",[0.0856934,-3.78625,-0.00102663],180,1,0,[],"","",true,false], 
			["Land_WoodenWindBreak_01_F",[0.0314941,4.18152,-0.00102663],0,1,0,[],"","",true,false]
		];

		[_pos, _direction, _composition, 0] call BIS_fnc_objectsMapper;
	};

	private _enemyInf = [];

	_enemyInf = _enemyInf + ([_pos] call prj_fnc_createCrowd);
	_enemyInf = _enemyInf + ([_pos,_radius,[1,1]] call prj_fnc_createPatrol);

	{
		_x addEventHandler ["GetIn", {
			params ["_vehicle", "_role", "_unit", "_turret"];

			if (isPlayer _unit) then {
				_vehicle removeEventHandler ["GetIn",_thisEventHandler];
				_vehicle setVariable ["cannotDeleted",true,true];
			};
		}];
	} forEach _vehicles;

	[_vehicles,_crewUnits,_enemyInf]
};

prj_fnc_createSentryPatrol = {
	params ["_sentryPos",["_forced",false],["_radius",400],["_numPoints",8]];

	private _chance = ("airVehiclesUsageProbability" call BIS_fnc_getParamValue) / 10;

	if (enemy_heliSentry isEqualTo [] || (!_forced && round (random 1) < _chance)) exitWith {
		private _vehicles = [_sentryPos] call prj_fnc_createReinforcement;
	};
	
	private _spawnPos = [false,false,[]] call prj_fnc_selectCaptPosition;

	private _vehicle = createVehicle [(selectRandom enemy_heliSentry), _spawnPos, [], 0, "FLY"];
	
	private _vehUnits = [_vehicle,enemy_infantry,true] call prj_fnc_createCrew;
	private _vehGroup = group _vehicle;

	_vehicle flyInHeight 140;

	private _deg = 0;
	private _degDif = 360 / _numPoints;

	for "_i" from 1 to _numPoints do {
		private _wpPos = [_sentryPos, _radius, _deg] call BIS_fnc_relPos;

		private _wpCrew = _vehGroup addWaypoint [_wpPos, 0];
		_wpCrew setWaypointSpeed "NORMAL";
		_wpCrew setWaypointType "MOVE";

		_deg = _deg + _degDif;
	};

	[_vehicle,_vehUnits] spawn {
		params ["_vehicle","_vehUnits"];

		while {alive _vehicle} do {
			sleep 10;
			private _unit = _vehUnits # 0;
			private _nearEnemy = _unit findNearestEnemy (position _unit);

			if (!isNull _nearEnemy) exitWith {
				private _enemyData = _nearEnemy call BIS_fnc_objectType;

				private _enemyCategory = _enemyData # 0;
				private _enemyType = _enemyData # 1;

				switch (_enemyCategory) do {
					case "Soldier": {
						private _vehicles = [position _nearEnemy,2,"antiInf"] call prj_fnc_createReinforcement;
					};
					case "Vehicle": {
						if (_enemyType isEqualTo "Helicopter" || _enemyType isEqualTo "Plane") then {
							private _vehicles = [position _nearEnemy,2,"antiAir"] call prj_fnc_createReinforcement;
						} else {
							if (_enemyType isEqualTo "Car") then {
								private _vehicles = [position _nearEnemy,2,"antiInf"] call prj_fnc_createReinforcement;
							} else {
								private _vehicles = [position _nearEnemy,2,"antiTank"] call prj_fnc_createReinforcement;
							};
						};
					};
				};
			};
		};

		if (!alive _vehicle) then {
			private _heliCrashPos = position _vehicle;
			_heliCrashPos set [2,0];
			
			private _vehicles = [_heliCrashPos,2,"antiInf"] call prj_fnc_createReinforcement;
		};
	};

	private _wpCrew = _vehGroup addWaypoint [_spawnPos, 0];  
	_wpCrew setWaypointSpeed "FULL";
	_wpCrew setWaypointType "MOVE";

	//check and vehicle delete

	[_vehicle,_vehUnits,_spawnPos] spawn {
		sleep 300;

		params ["_vehicle","_crewUnits","_spawnPos"];

		waitUntil {sleep 10; !alive _vehicle || (_spawnPos distance _vehicle) < 700};

		if (!alive _vehicle) then {
			sleep 120;
		};

		_crewUnits pushBack _vehicle;
		
		{deleteVehicle _x} forEach _crewUnits;
	};
};

prj_fnc_createReinforcement = {
	params ["_pos",["_number",0],["_type","antiInf"],["_radius",[1500,4000]]];

	if (_number == 0) then {
		_number = [2,3] call BIS_fnc_randomInt;
	};

	private _airChance = ("airVehiclesUsageProbability" call BIS_fnc_getParamValue) / 10;

	_type = switch (_type) do {
		case "antiInf": {
			if ((random 1) < _airChance) then {"airToInf"} else {"groundToInf"};
		};
		case "antiAir": {
			if ((random 1) < _airChance) then {"airToAir"} else {"groundToAir"};
		};
		case "antiTank": {
			if ((random 1) < _airChance) then {"airToGround"} else {"groundToGround"};
		};
	};

	switch (_type) do {
		case "groundToInf": {
			private _position_data = [_pos,_radius] call prj_fnc_selectRoadPositionAround;

			private _vehicles = [];

			for "_i" from 1 to _number do {
				private _safePos = [(_position_data # 0), 0, 100] call BIS_fnc_findSafePos;

				private _vehicle = (selectRandom enemy_vehicles_light) createVehicle _safePos;
				_vehicle setDir (_position_data # 1);

				private _crew_units = [_vehicle,enemy_infantry,true] call prj_fnc_createCrew;

				private _vehicle_group = group _vehicle;
				_vehicle_group setCombatMode "RED";

				private _wp = _vehicle_group addWaypoint [_pos, 0];  
				_wp setWaypointSpeed "FULL";  
				_wp setWaypointType "SAD";
				_wp setWaypointTimeout [120, 160, 180];

				private _wp = _vehicle_group addWaypoint [_safePos, 0];  
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointType "MOVE";

				_vehicles pushBack [_vehicle, _crew_units];
			};

			[_vehicles] spawn prj_fnc_checkAndDelete;
			
			_vehicles
		};

		case "groundToAir": {
			if (enemy_vehicles_aa isEqualTo []) exitWith {
				private _vehicles = [_pos,2,"groundToInf"] call prj_fnc_createReinforcement;
			};

			private _position_data = [_pos,_radius] call prj_fnc_selectRoadPositionAround;

			private _vehicles = [];

			for "_i" from 1 to _number do {
				private _safePos = [(_position_data # 0), 0, 300] call BIS_fnc_findSafePos;

				private _vehicle = (selectRandom enemy_vehicles_aa) createVehicle _safePos;
				_vehicle setDir (_position_data # 1);

				private _crew_units = [_vehicle,enemy_infantry,false] call prj_fnc_createCrew;

				private _vehicle_group = group _vehicle;
				_vehicle_group setCombatMode "RED";

				private _wp = _vehicle_group addWaypoint [_pos, 0];  
				_wp setWaypointSpeed "FULL";  
				_wp setWaypointType "SAD";
				_wp setWaypointTimeout [60, 90, 120];

				private _wp = _vehicle_group addWaypoint [_safePos, 0];  
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointType "MOVE";

				_vehicles pushBack [_vehicle, _crew_units];
			};

			[_vehicles] spawn prj_fnc_checkAndDelete;
			
			_vehicles
		};

		case "groundToGround": {
			if (enemy_vehicles_at isEqualTo []) exitWith {
				private _vehicles = [_pos,2,"groundToInf"] call prj_fnc_createReinforcement;
			};

			private _position_data = [_pos,_radius] call prj_fnc_selectRoadPositionAround;

			private _vehicles = [];

			for "_i" from 1 to _number do {
				private _safePos = [(_position_data # 0), 0, 300] call BIS_fnc_findSafePos;

				private _vehicle = (selectRandom enemy_vehicles_at) createVehicle _safePos;
				_vehicle setDir (_position_data # 1);

				private _crew_units = [_vehicle,enemy_infantry,false] call prj_fnc_createCrew;

				private _vehicle_group = group _vehicle;
				_vehicle_group setCombatMode "RED";

				private _wp = _vehicle_group addWaypoint [_pos, 0];  
				_wp setWaypointSpeed "FULL";  
				_wp setWaypointType "SAD";
				_wp setWaypointTimeout [90, 100, 110];

				private _wp = _vehicle_group addWaypoint [_safePos, 0];  
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointType "MOVE";

				_vehicles pushBack [_vehicle, _crew_units];
			};

			[_vehicles] spawn prj_fnc_checkAndDelete;
			
			_vehicles
		};

		case "airToInf": {
			if (enemy_heliTransport isEqualTo []) exitWith {
				private _vehicles = [_pos,2,"groundToInf"] call prj_fnc_createReinforcement;
			};

			private _finishPos = [_pos, 600, 1800, 5, 0, 0.5, 0, []] call BIS_fnc_findSafePos;
			private _helipad = "Land_HelipadEmpty_F" createVehicle _finishPos;

			private _spawnPos = [false,false,[]] call prj_fnc_selectCaptPosition;

			private _vehicle = createVehicle [(selectRandom enemy_heliTransport), _spawnPos, [], 0, "FLY"];
			private _vehUnits = [_vehicle,enemy_infantry,true,false] call prj_fnc_createCrew;

			private _crewUnits = (_vehUnits # 0) # 0;
			private _cargoUnits = (_vehUnits # 1) # 0;

			private _crewGroup = (_vehUnits # 0) # 1;
			private _cargoGroup = (_vehUnits # 1) # 1;

			_cargoGroup setCombatMode "RED";

			private _wpCrew = _crewGroup addWaypoint [_finishPos, 0];  
			_wpCrew setWaypointSpeed "FULL";
			_wpCrew setWaypointType "TR UNLOAD";

			private _wpCargo = _cargoGroup addWaypoint [_finishPos, 0];  
			_wpCargo setWaypointSpeed "FULL";
			_wpCargo setWaypointType "GETOUT";

			_wpCrew synchronizeWaypoint [_wpCargo];

			private _wpCrew = _crewGroup addWaypoint [_spawnPos, 0];  
			_wpCrew setWaypointSpeed "FULL";
			_wpCrew setWaypointType "MOVE";

			private _wpCargo = _cargoGroup addWaypoint [_pos, 0];  
			_wpCargo setWaypointSpeed "FULL";
			_wpCargo setWaypointType "SAD";

			//check and vehicle delete

			[_vehicle,_crewUnits,_spawnPos,_helipad] spawn {
				sleep 120;

				params ["_vehicle","_crewUnits","_spawnPos","_helipad"];

				waitUntil {sleep 10; !alive _vehicle || (_spawnPos distance _vehicle) < 400};

				if (!alive _vehicle) then {
					sleep 120;
				};

				_crewUnits pushBack _vehicle;
				_crewUnits pushBack _helipad;
				
				{deleteVehicle _x} forEach _crewUnits;
			};

			//check and cargos delete

			[_cargoUnits] spawn {
				sleep 300;

				params ["_cargoUnits"];
				
				while {(count _cargoUnits) > 0} do {
					private _unitsCount = (count _cargoUnits) - 1;

					for "_i" from 0 to _unitsCount do {
						private _finded = false;
						
						{
							if ((_x distance (_cargoUnits # _i)) < 2000) exitWith {
								_finded = true;
							};
						} forEach allPlayers;

						if (!_finded) then {
							deleteVehicle (_cargoUnits # _i);
						};
					};

					sleep 60;
				};
			};
		};

		case "airToGround": {
			if (enemy_heliHeavy isEqualTo []) exitWith {
				private _vehicles = [_pos,3,"groundToGround"] call prj_fnc_createReinforcement;
			};

			private _spawnPos = [false,false,[]] call prj_fnc_selectCaptPosition;

			private _vehicle = createVehicle [(selectRandom enemy_heliHeavy), _spawnPos, [], 0, "FLY"]; 
			private _vehUnits = [_vehicle,enemy_infantry,false] call prj_fnc_createCrew; 

			private _vehGroup = group _vehicle;
			_vehGroup setCombatMode "RED";
			_vehicle flyInHeight 250;
			
			private _wpCrew = _vehGroup addWaypoint [_pos, 0];
			_wpCrew setWaypointSpeed "NORMAL";
			_wpCrew setWaypointType "SAD";
			_wpCrew setWaypointTimeout [20, 20, 20];

			private _wpCrew = _vehGroup addWaypoint [_spawnPos, 0];
			_wpCrew setWaypointSpeed "FULL";
			_wpCrew setWaypointType "MOVE";

			[_vehicle,_vehUnits,_spawnPos] spawn {
				sleep 300;

				params ["_vehicle","_crewUnits","_spawnPos"];

				waitUntil {sleep 10; !alive _vehicle || (_spawnPos distance _vehicle) < 400};

				if (!alive _vehicle) then {
					sleep 120;
				};

				_crewUnits pushBack _vehicle;
				
				{deleteVehicle _x} forEach _crewUnits;
			};
		};

		case "airToAir": {
			if (enemy_fighters isEqualTo []) exitWith {
				private _vehicles = [_pos,2,"groundToAir"] call prj_fnc_createReinforcement;
			};

			private _spawnPos = [_pos, 6000, ([0,360] call BIS_fnc_randomInt)] call BIS_fnc_relPos;

			private _vehicle = createVehicle [(selectRandom enemy_fighters), _spawnPos, [], 0, "FLY"]; 
			private _vehUnits = [_vehicle,enemy_infantry,false] call prj_fnc_createCrew; 

			private _vehGroup = group _vehicle;
			_vehGroup setCombatMode "RED";
			// _vehicle flyInHeight 250;
			
			private _wpCrew = _vehGroup addWaypoint [_pos, 0];
			_wpCrew setWaypointSpeed "NORMAL";
			_wpCrew setWaypointType "SAD";
			// _wpCrew setWaypointTimeout [60, 60, 60];

			private _wpCrew = _vehGroup addWaypoint [_spawnPos, 0];
			_wpCrew setWaypointSpeed "FULL";
			_wpCrew setWaypointType "MOVE";

			[_vehicle,_vehUnits,_spawnPos] spawn {
				sleep 300;

				params ["_vehicle","_crewUnits","_spawnPos"];

				waitUntil {sleep 10; !alive _vehicle || (_spawnPos distance _vehicle) < 1000};

				if (!alive _vehicle) then {
					sleep 120;
				};

				_crewUnits pushBack _vehicle;
				
				{deleteVehicle _x} forEach _crewUnits;
			};
		};
	};
};

prj_fnc_checkAndDelete = {
	params ["_vehicles",["_distance",1500],["_start_time",300],["_interval_time",60]];

	{
		(_x # 0) addEventHandler ["GetIn", {
			params ["_vehicle", "_role", "_unit", "_turret"];

			if (isPlayer _unit) then {
				_vehicle removeEventHandler ["GetIn",_thisEventHandler];
				_vehicle setVariable ["cannotDeleted",true,true];
			};
		}];
	} forEach _vehicles;

	uiSleep _start_time;

	while {(count _vehicles) > 0} do {
		private _deleteArr = [];

		for "_i" from 0 to ((count _vehicles) - 1) do {
			
			private _veh = (_vehicles # _i) # 0;
			private _crew = (_vehicles # _i) # 1;

			if (!alive _veh) exitWith {
				_deleteArr pushBack (_vehicles # _i);

				_crew pushBack _veh;

				[_crew] spawn {
					params ["_crew"];
					uiSleep 300;
					{deleteVehicle _x} forEach _crew;
				};
			};

			if (_veh getVariable ["cannotDeleted",false]) then {
				_deleteArr pushBack (_vehicles # _i);

				[_crew] spawn {
					params ["_crew"];
					uiSleep 300;
					{deleteVehicle _x} forEach _crew;
				};
			} else {
				private _playersNear = false;

				{
					if ((_x distance _veh) < _distance) exitWith {
						_playersNear = true
					}
				} forEach allPlayers;

				if (!_playersNear) then {
					_deleteArr pushBack (_vehicles # _i);

					_crew pushBack _veh;
					{deleteVehicle _x} forEach _crew;
				};

			};
		};

		{_vehicles deleteAt (_vehicles find _x)} forEach _deleteArr;

		uiSleep _interval_time;
	};
};

prj_fnc_selectHousePosition = {
	params [["_pos", [0,0,0]],["_radius", 200]];

	private _buildings = nearestObjects [_pos, ["Building"], _radius];
	private _useful = _buildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};

	if ((count _useful) > 5) then {
		private _allpositions = (selectRandom _useful) buildingPos -1;
		_pos = selectRandom _allpositions;
	};

	if (isNil "_pos") then {
		_pos = [_pos, (_radius / 100) * 10, _radius, 2, 0] call BIS_fnc_findSafePos;
	};

	_pos
};

prj_fnc_createTrigger = {
	params ["_position", "_area", "_by", "_type", ["_global",true], ["_activation",""], ["_repeating",false], ["_rectangle",false], ["_angle",0]];

	_area params ["_a", "_b", "_c"];

	private _trg = createTrigger ["EmptyDetector", _position, _global];
	_trg setTriggerArea [_a, _b, _angle, _rectangle, _c];
	_trg setTriggerActivation [_by, _type, _repeating];
	_trg setTriggerStatements ["this", _activation,""];

	_trg
};

prj_fnc_createMarker = {
	params ["_markername","_position","_color","_alpha",["_size_form",[]],["_type",""],["_text",""]];

	_marker = createMarker [_markername,_position];
	_marker setMarkerColor _color;
	_marker setMarkerAlpha _alpha;

	if (!isNil "_size_form" && count _size_form != 0) then {
		_size_form params ["_marker_size","_marker_shape",["_marker_dir",0]];
		_marker setMarkerSize _marker_size;
		_marker setMarkerShape _marker_shape;
		_marker setMarkerDir _marker_dir;
	};

	if (!isNil "_type") then {_marker setMarkerType _type};
	if (!isNil "_text") then {_marker setMarkerText _text};

	_marker
};

prj_fnc_createMarkers = {
	params ["_markers_array"];
	for [{private _i = 0 }, { _i < (count _markers_array) }, { _i = _i + 1 }] do {
		_marker = createMarker [((_markers_array select _i) select 0),((_markers_array select _i) select 1)];
		_marker setMarkerType ((_markers_array select _i) select 2);
		_marker setMarkerColor ((_markers_array select _i) select 3);
		_marker setMarkerText ((_markers_array select _i) select 4);
	};
};

prj_fnc_createCrew = {
	params ["_vehicle","_units",["_passengers",false],["_oneGroup",true],["_side",enemySide]];

	//create group
	private _vehCrewGroup = createGroup [_side, true];
	private "_vehCargoGroup";

	if (_oneGroup) then {
		_vehCargoGroup = _vehCrewGroup;
	} else {
		_vehCargoGroup = createGroup [_side, true];
	};

	//create crew
	private _vehicle_crew = [];

	{
		private _emptySeats = _vehicle emptyPositions _x;

		if (_emptySeats != 0) then {
			for "_i" from 1 to _emptySeats do {
				private _unit = _vehCrewGroup createUnit [selectRandom _units, position _vehicle, [], 0, "NONE"];
				_unit moveInAny _vehicle;
				_vehicle_crew pushBack _unit;
			};
		};
	} forEach ["driver","gunner","commander","turret"];

	//create passengers
	private _vehicle_cargo = [];

	if (_passengers) then {
		
		private _empty_seats = _vehicle emptyPositions "cargo";

		for "_i" from 1 to _empty_seats do {
			private _unit = _vehCargoGroup createUnit [selectRandom _units, position _vehicle, [], 0, "NONE"];
			_unit moveInCargo _vehicle;
			_vehicle_cargo pushBack _unit;
		};
	};

	//return
	if (_oneGroup) then {
		_vehicle_crew + _vehicle_cargo
	} else {
		[[_vehicle_crew,_vehCrewGroup],[_vehicle_cargo,_vehCargoGroup]]
	};
	
};

prj_fnc_zoneCapture = {
	params ["_capt_trigger"];

	private _parent_trigger = _capt_trigger getVariable "parent_trigger";
	private _trigger_pos = position _capt_trigger;
	private _trigger_loc_name = _trigger_pos call BIS_fnc_locationDescription;
	private _trigger_grid_pos = mapGridPosition _capt_trigger;
	private _trigger_radius = (triggerArea _capt_trigger) # 0;
	private _trigger_str_name = str _parent_trigger;
	private _markerName = _trigger_str_name + str serverTime;
	private _trigger_special = _parent_trigger getVariable ["special","none"];

	_parent_trigger setVariable ["captured", true];

	private _vehicles = [_trigger_pos] call prj_fnc_createReinforcement;

	[_trigger_pos] call prj_fnc_createSentryPatrol;

	if (_trigger_special != "none") exitWith {
		switch (_trigger_special) do {
			case "camp": {
				["missionNamespace", "money", 0, 5000] call prj_fnc_changePlayerVariableGlobal;
				["camp_capture",[_trigger_grid_pos,_trigger_loc_name]] remoteExec ["BIS_fnc_showNotification"];
			};
			case "checkpoint": {
				["missionNamespace", "money", 0, 3000] call prj_fnc_changePlayerVariableGlobal;
				["checkpoint_capture",[_trigger_grid_pos,_trigger_loc_name]] remoteExec ["BIS_fnc_showNotification"];
			};
		};

		{deleteVehicle _x} forEach [_capt_trigger,_parent_trigger];
	};

	[_markerName,_trigger_pos,"ColorWEST",0.3,[[_trigger_radius,_trigger_radius],"ELLIPSE"]] call prj_fnc_createMarker;

	[_parent_trigger,_trigger_grid_pos,_trigger_loc_name,_markerName] spawn {
		params ["_parent_trigger","_trigger_grid_pos","_trigger_loc_name","_markerName"];

		["sector_capture",[_trigger_grid_pos,_trigger_loc_name]] remoteExec ["BIS_fnc_showNotification"];

		private _captureMode = "sectorCaptureMode" call BIS_fnc_getParamValue;

		private _reward = _parent_trigger getVariable ["reward",100];
		["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;

		if (_captureMode == 0) then {
			private _time_remaining = 60 * ([240,360] call BIS_fnc_randomInt);

			uiSleep _time_remaining;

			_parent_trigger setVariable ["captured", false];
			_markerName setMarkerColor "ColorOPFOR";
			_markerName setMarkerAlpha 0.8;
			[_markerName, 2, 10] spawn BIS_fnc_blinkMarker;

			["sector_lost",[_trigger_grid_pos,_trigger_loc_name]] remoteExec ["BIS_fnc_showNotification"];

			uiSleep 20;
			deleteMarker _markerName;
		};
	};
};

prj_fnc_civBehaviour = {
	private _civ = _this;

	_civ addEventHandler ["FiredNear", {
		params ["_unit"];

		private _oldSide = _unit getVariable ["oldSide",civilian];

		if (_oldSide != civilian) exitWith {
			_unit removeEventHandler ["FiredNear",_thisEventHandler];
		};

		if ((animationState _unit) == "amovpercmstpssurwnondnon") exitWith {};
		if ((random 1) > 0.3) exitWith {};

		_unit allowfleeing 0;
		[_unit] join (createGroup [civilian, true]);

		(group _unit) setBehaviour "CARELESS";
		(group _unit) setSpeedMode "FULL";

		for "_i" from (count waypoints (group _unit)) - 1 to 0 step -1 do {
			deleteWaypoint [group _unit, _i];
		};

		_pos = [position _unit, [70,100] call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
		_pos set [2, 0];

		unit_civ_runner = _unit;

		private _wp = (group _unit) addWaypoint [_pos, 0];  
		_wp setWaypointSpeed "FULL";  
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 10;
		_wp setWaypointStatements ["true", "[unit_civ_runner, 'Acts_CivilHiding_2'] remoteExec ['switchMove', 0]"];
	}];

	private _chanceCivTransform = "chanceCivTransform" call BIS_fnc_getParamValue;
	if (isNil "_chanceCivTransform") then {_chanceCivTransform = 2};
	_chanceCivTransform = _chanceCivTransform * 0.1;

	private _scan_end = false;
	while {alive _civ && !_scan_end} do {
		private _nearestunits = nearestObjects [getPos _civ,["Man"],30];
		{
			if (side _x == west) then {

				if ((random 1) > _chanceCivTransform || !alive _civ || !([_civ] call ace_common_fnc_isAwake)) exitWith {_scan_end = true};

				[_civ] join (createGroup [enemySide, true]);

				uiSleep 3;

				_civ removeAllEventHandlers "FiredNear";
				if ((animationState _civ) == "amovpercmstpssurwnondnon") then {
					[_civ, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
				};

				if (random 1 < 0.5) then {
					_civ addMagazine [selectRandom ["acex_intelitems_photo","acex_intelitems_document","acex_intelitems_notepad"], 1];
				};

				_civ setUnitPos "UP";
				unAssignVehicle _civ;
				_civ action ["eject",vehicle _civ];
				_civ allowfleeing 0;
				_civ forceSpeed 15;				  
				(group _civ) setBehaviour "CARELESS";
				(group _civ) setSpeedMode "FULL";

				private _bombers = "suicide_bombers" call BIS_fnc_getParamValue;

				if ((random 1) < 0.5 && _bombers == 1) then {
					{_civ addItemToUniform _x} forEach ["ACE_DeadManSwitch","ACE_Cellphone"];       

					while {alive _civ && [_civ] call ace_common_fnc_isAwake && (_civ distance _x) > 10} do {
						_civ doMove position _x;
						uiSleep 3;
					};

					if (alive _civ && [_civ] call ace_common_fnc_isAwake) then {
						[_civ, [selectRandom screams,50,1]] remoteExec ["say3D"];
						uiSleep 3;
						if (alive _civ && [_civ] call ace_common_fnc_isAwake && !(_civ getVariable ["ace_captives_isHandcuffed", false])) then {
							private _blast = ["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
							createVehicle [selectRandom _blast,(getPosATL _civ),[],0,""];
							createVehicle ["Crater",(getPosATL _civ),[],0,""];
							deleteVehicle _civ;
						};
					};
				} else {		
					if (random 1 < 0.5) then {
						_civ addItemToUniform "ACE_Cellphone";
					};			
			
					while {alive _civ && [_civ] call ace_common_fnc_isAwake && (_civ distance _x) > 50} do {
						_civ doMove position _x;
						uiSleep 3;
					};

					if (alive _civ && [_civ] call ace_common_fnc_isAwake) then {
						if (random 1 < 0.5) then {
							private _weaponchoice = selectRandom [
								["rhsusf_weap_m9","rhsusf_mag_15Rnd_9x19_JHP"],
								["rhs_weap_tt33","rhs_mag_762x25_8"],
								["rhsusf_weap_m1911a1","rhsusf_mag_7x45acp_MHP"],
								["rhs_weap_makarov_pm","rhs_mag_9x18_8_57N181S"],
								["rhs_weap_makarov_pm","rhs_mag_9x18_8_57N181S"],
								["rhs_weap_savz61_folded","rhsgref_20rnd_765x17_vz61"],
								["rhs_weap_type94_new","rhs_mag_6x8mm_mhp"]
							];

							_civ addWeapon (_weaponchoice # 0);
							_civ addHandgunItem (_weaponchoice # 1);
							for "_i" from 1 to 3 do {_civ addMagazine (_weaponchoice # 1)};			
						} else {
							private _grenades = ["rhs_mag_rgd5","rhs_mag_f1"];
							private _grenade = selectRandom _grenades;
							for "_i" from 1 to 3 do {_civ addItemToUniform _grenade};
						};
						_civ dotarget _x;
						_civ dofire _x;
					};
				};
				_scan_end = true;
			};
		} forEach _nearestunits;
		uiSleep 15;
	};
};