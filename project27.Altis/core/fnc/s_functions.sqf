/*
	written by eugene27.
	only server functions
*/

prj_fnc_changeVariable = {
	params ["_space", "_name", "_value"];

	_oldValue = (call (compile _space)) getVariable _name;
	(call (compile _space)) setVariable [_name, _oldValue + _value, true];

	if (prj_debug) then {
		[format ["%1 изменена на: %2",_name,_oldValue + _value]] remoteExec ["hint"]
	};
};

prj_fnc_changePlayerVariableGlobal = {
	params ["_space","_name","_number", "_value"];

	{
		private _UID = getPlayerUID _x;
		private _variable = ((missionNamespace getVariable _UID) # _number) # 1;
		private _player_table = missionNamespace getVariable _UID;
		_player_table set [_number,[_name,_variable + _value]];
		(call (compile _space)) setVariable [_UID, _player_table, true];
		if (prj_debug) then {[format ["%1 changed to: %2",_UID,_player_table]] remoteExec ["systemChat"]};
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

	params [["_position_around",false],["_captured",false],["_nearest",[]]];

	private _locations = missionNamespace getVariable "location_triggers";

	private _filtered_locations = switch (_captured) do {
		case true: {
			_locations select {(_x getVariable "captured")}
		};
		case false: {
			_locations select {!(_x getVariable "captured")}
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

prj_fnc_select_road_position = {

	params [["_typelocation",4],["_radius",3000]];

	private "_returndata";

	private _pos = [_typelocation] call prj_fnc_selectPosition;
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

prj_fnc_select_road_position_around = {

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

prj_fnc_enemy_crowd = {
    params ["_pos",["_radius",[4,15]],["_number_of",[10,15]]];
  
    private _units = [];

	private _ground_enemies_grp = createGroup [independent, true];

    for [{private _i = 0 }, { _i < (_number_of call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
        private _position = [_pos, _radius call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
        private _unit = _ground_enemies_grp createUnit [selectRandom enemy_infantry, _position, [], 0, "NONE"];
        doStop _unit;
        _unit setDir (round (random 360));

        _units pushBack _unit;
    };

    _units
};

prj_fnc_enemy_patrols = {
	params ["_cpos","_radius","_inf",["_voice",false]];

	prj_fnc_number_of_units = {
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
			private _group = createGroup [independent, true];
			private _pos = [_cpos, 10, _radius, 1, 0] call BIS_fnc_findSafePos;
			if (!isNil "_pos") then {
				for [{private _i = 0 }, { _i < [(_inf # 1)] call prj_fnc_number_of_units }, { _i = _i + 1 }] do {
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

prj_fnc_reinforcement = {
	params ["_pos",["_radius",[1000,4000]],["_number",2]];

	private _position_data = [_pos,_radius] call prj_fnc_select_road_position_around;
	private _position = _position_data # 0;
	private _direction = _position_data # 1;
	private _vehicles = [];

	for "_i" from 1 to _number do {
		private _vehClass = selectRandom enemy_vehicles_light;
		private _safePos = [_position, 0, 300] call BIS_fnc_findSafePos;
		private _vehicle = _vehClass createVehicle _safePos;
		_vehicle setDir _direction;
		private _crew_units = [_vehicle,enemy_infantry,true] call prj_fnc_create_crew;

		private _vehicle_group = group _vehicle;

		private _wp = _vehicle_group addWaypoint [_pos, 0];  
		_wp setWaypointSpeed "FULL";  
		_wp setWaypointType "SAD";

		_vehicle_group setCombatMode "RED";

		_vehicles pushBack [_vehicle, _crew_units];
	};

	_vehicles
};

prj_fnc_check_and_delete = {
	params ["_vehicles","_start_time","_interval_time",["_distance",2000]];
	uiSleep _start_time;
	private _vehsArray = _vehicles;
	while {(count _vehsArray) > 0} do {
		private _count_vehicles = count _vehsArray;
		for [{private _i = 0 }, { _i < _count_vehicles }, { _i = _i + 1 }] do {
			private _vehicle = (_vehsArray # _i) # 0;
			private _crew = (_vehsArray # _i) # 1;

			if (!alive _vehicle) then {
				_crew pushBack _vehicle;
				[_crew] spawn {
					params ["_crew"];
					uiSleep 300;
					{deleteVehicle _x} forEach _crew;
				};	
				_vehsArray deleteAt _i;
			} else {
				private _playerInVeh = false;
				{
					if (_vehicle == vehicle _x) exitWith {_playerInVeh = true}
				} forEach allPlayers;

				if (_playerInVeh) then {
					{deleteVehicle _x} forEach _crew;
					_vehsArray deleteAt _i;
					systemChat "в машине подкрепления есть человек, она не пропадёт";
				} else {
					private _finded = false;
					private _nearestunits = nearestObjects [position _vehicle,["Man"],2000];
					{if (side _x == west) exitWith {_finded = true}} forEach _nearestunits;
					if (!_finded) then {
						_crew pushBack _vehicle;
						{deleteVehicle _x} forEach _crew;
						_vehsArray deleteAt _i;
					};
				};
			};
			
		};
		uiSleep _interval_time;
	};
};

prj_fnc_select_house_position = {

	params [["_pos", [0,0,0]],["_radius", 200]];

	private "_pos";

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

prj_fnc_create_trg = {
	params [
		"_position", "_area", "_by", "_type", ["_global",true], ["_activation",""], ["_repeating",false], ["_rectangle",false], ["_angle",0]
	];

	_area params ["_a", "_b", "_c"];

	private _trg = createTrigger ["EmptyDetector", _position, _global];
	_trg setTriggerArea [_a, _b, _angle, _rectangle, _c];
	_trg setTriggerActivation [_by, _type, _repeating];
	_trg setTriggerStatements ["this", _activation,""];

	_trg
};

prj_fnc_create_marker = {
	params [
		"_markername","_position","_color","_alpha",["_size_form",[]],["_type",""],["_text",""]
	];

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

prj_fnc_create_markers = {
	params [
		"_markers_array"
	];
	for [{private _i = 0 }, { _i < (count _markers_array) }, { _i = _i + 1 }] do {
		_marker = createMarker [((_markers_array select _i) select 0),((_markers_array select _i) select 1)];
		_marker setMarkerType ((_markers_array select _i) select 2);
		_marker setMarkerColor ((_markers_array select _i) select 3);
		_marker setMarkerText ((_markers_array select _i) select 4);
	};
};

prj_fnc_create_crew = {

	params ["_vehicle","_units",["_passengers",false],["_side",independent]];

	//create crew
	private _vehicle_crew = [];

	private _vehicle_group = createGroup [_side, true];

	if ((_vehicle emptyPositions "commander") != 0) then {
		private _unit = _vehicle_group createUnit [selectRandom _units, position _vehicle, [], 0, "NONE"];
		_unit moveInCommander _vehicle;
		_vehicle_crew pushBack _unit;
	};

	if ((_vehicle emptyPositions "gunner") != 0) then {
		private _unit = _vehicle_group createUnit [selectRandom _units, position _vehicle, [], 0, "NONE"];
		_unit moveInGunner _vehicle;
		_vehicle_crew pushBack _unit;
	};

	if ((_vehicle emptyPositions "driver") != 0) then {
		private _unit = _vehicle_group createUnit [selectRandom _units, position _vehicle, [], 0, "NONE"];
		_unit moveInDriver _vehicle;
		_vehicle_crew pushBack _unit;
	};

	//create passengers
	private _vehicle_cargo = [];

	if (_passengers) then {
		
		private _empty_seats = _vehicle emptyPositions "cargo";

		for "_i" from 1 to _empty_seats do {
			private _unit = _vehicle_group createUnit [selectRandom _units, position _vehicle, [], 0, "NONE"];
			_unit moveInCargo _vehicle;
			_vehicle_cargo pushBack _unit;
		};
	};

	_vehicle_crew + _vehicle_cargo
};

prj_fnc_capt_zone = {
	params ["_capt_trigger"];

	private _parent_trigger = _capt_trigger getVariable "parent_trigger";
	private _trigger_pos = position _capt_trigger;
	private _trigger_loc_name = _trigger_pos call BIS_fnc_locationDescription;
	private _trigger_grid_pos = mapGridPosition _capt_trigger;
	private _trigger_radius = (triggerArea _capt_trigger) # 0;
	private _trigger_str_name = str _parent_trigger;
	private _markerName = _trigger_str_name + str serverTime;
	private _trigger_camp = _parent_trigger getVariable ["camp",false];

	_parent_trigger setVariable ["captured", true];

	private _number = [2,3] call BIS_fnc_randomInt;
	private _vehicles = [_trigger_pos,[1500,4000],_number] call prj_fnc_reinforcement;
	[_vehicles,600,60,2500] spawn prj_fnc_check_and_delete;

	if (_trigger_camp) exitWith {
		["missionNamespace", "money", 0, 500] call prj_fnc_changePlayerVariableGlobal;
		["camp_capture",[_trigger_grid_pos,_trigger_loc_name]] remoteExec ["BIS_fnc_showNotification"];
		deleteVehicle _capt_trigger;
		[_parent_trigger] spawn {params ["_parent_trigger"]; uiSleep 120; deleteVehicle _parent_trigger};
	};

	[_markerName,_trigger_pos,"ColorWEST",0.3,[[_trigger_radius,_trigger_radius],"ELLIPSE"]] call prj_fnc_create_marker;

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

prj_fnc_civ = {
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

				[_civ] join (createGroup [independent, true]);

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