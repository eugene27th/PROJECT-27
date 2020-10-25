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

prj_fnc_select_position = {
	
	params ["_type_location",["_position_around", true],["_capture_check",false]];

	private "_selected_pos";

	private _types_location = switch (_type_location) do {
		case 1: {["NameCityCapital","NameCity","NameVillage"]};
		case 2: {["RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]};
		case 3: {["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"]};
		case 4: {["NameCityCapital","NameCity","NameVillage","NameLocal","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]};
	};

	private _locations = nearestLocations [[worldSize / 2, worldsize / 2, 0], _types_location, worldSize * 1.5] - (nearestLocations [position spawn_zone, ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"], 2000]);

	private _selecting = true;

	while {_selecting} do {
		switch (_position_around) do {
			case true: {
				_selected_pos = [locationPosition (selectRandom _locations), 0, 700, 5, 0] call BIS_fnc_findSafePos;
			};
			case false: {
				_selected_pos = locationPosition (selectRandom _locations);
			};
		};

		if ((_selected_pos distance (position spawn_zone)) >= 2000) then {
			if (_capture_check) then {
				private _trgs = _selected_pos nearObjects ["EmptyDetector", 50];
				if ((count _trgs) == 1) then {
					if !((_trgs # 0) getVariable "captured") then {_selecting = false}
				}
			}
			else
			{
				_selecting = false
			};
		};
	};

	_selected_pos set [2, 0];
	_selected_pos
};

prj_fnc_select_road_position = {

	params [["_typelocation",4],["_radius",3000]];

	private "_returndata";

	private _pos = [_typelocation] call prj_fnc_select_position;
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
	}
	else
	{
		private _pos = [_pos, round ((_radius / 100) * 10), _radius, 3, 0] call BIS_fnc_findSafePos;
		private _direction = round (random 360);
		_returndata = [_pos,_direction];
	};
	_returndata
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

	// hintC format ["%1 | %2 | %3 | %4",_vehicle,_units,_side,_passengers];

	//create crew
	private _vehicle_crew = [];

	private _vehicle_group = createGroup _side;

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
		
		private _empty_seats = round (random (_vehicle emptyPositions "cargo"));

		for "_i" from 1 to _empty_seats do {
			private _unit = _vehicle_group createUnit [selectRandom _units, position _vehicle, [], 0, "NONE"];
			_unit moveInCargo _vehicle;
			_vehicle_cargo pushBack _unit;
			uiSleep 0.3;
		};
	};

	_vehicle_crew + _vehicle_cargo
};

prj_fnc_capt_zone = {
	params ["_capt_trigger"];

	private _parent_trigger = _capt_trigger getVariable "parent_trigger";
	private _trigger_pos = position _capt_trigger;
	private _trigger_loc_name = _parent_trigger getVariable "loc_name";
	private _trigger_grid_pos = mapGridPosition _capt_trigger;
	private _trigger_radius = (triggerArea _capt_trigger) # 0;
	private _trigger_str_name = str _parent_trigger;

	_parent_trigger setVariable ["captured", true];

	[_trigger_str_name,_trigger_pos,"ColorWEST",0.3,[[_trigger_radius,_trigger_radius],"ELLIPSE"]] call prj_fnc_create_marker;

	[_parent_trigger,_trigger_grid_pos,_trigger_loc_name,_trigger_str_name] spawn {
		params ["_parent_trigger","_trigger_grid_pos","_trigger_loc_name","_trigger_str_name"];

		["sector_capture",[_trigger_grid_pos,_trigger_loc_name]] remoteExec ["BIS_fnc_showNotification"];

		private _time_remaining = 60 * ([60,120] call BIS_fnc_randomInt);
		private _reward = _parent_trigger getVariable "reward";

		while {_time_remaining > 0} do {
			["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
			// [format ["Игрокам выдано %1 очков за удержание сектора %2 (%3).",_reward,_trigger_grid_pos,_trigger_loc_name]] remoteExec ["systemChat",0];
			uiSleep 600;
			_time_remaining = _time_remaining - 600;
		};

		_parent_trigger setVariable ["captured", false];
		_trigger_str_name setMarkerColor "ColorOPFOR";
		_trigger_str_name setMarkerAlpha 0.8;
		[_trigger_str_name, 2, 10] spawn BIS_fnc_blinkMarker;

		["sector_lost",[_trigger_grid_pos,_trigger_loc_name]] remoteExec ["BIS_fnc_showNotification"];

		uiSleep 20;
		deleteMarker (_trigger_str_name);
	};
};

prj_fnc_civ = {
	private _civ = _this;

	_civ addEventHandler ["FiredNear", {
		params ["_unit"];

		if ((animationState _unit) == "amovpercmstpssurwnondnon") exitWith {};
		if ((random 1) > 0.3) exitWith {};

		_unit allowfleeing 0;
		[_unit] join (createGroup civilian);

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

	private _scan_end = false;
	while {alive _civ && !_scan_end} do {
		private _nearestunits = nearestObjects [getPos _civ,["Man"],30];
		{
			if (side _x == west) then {

				if ((random 1) > 0.5 || !alive _civ || !([_civ] call ace_common_fnc_isAwake)) exitWith {_scan_end = true;};

				[_civ] join (createGroup independent);

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
				}
				else 
				{			
					if (random 1 < 0.5) then {
						_civ addItemToUniform "ACE_Cellphone";
					};			
			
					while {alive _civ && [_civ] call ace_common_fnc_isAwake && (_civ distance _x) > 40} do {
						_civ doMove position _x;
						sleep 3;
					};

					if (alive _civ && [_civ] call ace_common_fnc_isAwake) then {
						_weaponchoice = selectRandom [
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