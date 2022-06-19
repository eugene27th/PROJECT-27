/*
	written by eugene27.
	server only
*/

private _distance = 800; // 600-1000
private _safeZone = 1000; // 1500-2000

private _all_locations = ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"];

private _types_locations = [
	// [location type,radius,array of units,reward],
	["NameCityCapital",320,[cities_enemy,cities_civilian],3500],
	["NameCity",300,[cities_enemy,cities_civilian],2500],
	["NameVillage",240,[villages_enemy,villages_civilian],2000],
	["NameLocal",230,[local_enemy,local_civilian],1500],
	["Hill",50,[hills_enemy,local_civilian],1000],
	// ["VegetationBroadleaf",175,[vegetation_enemy],500],
	// ["VegetationFir",175,[vegetation_enemy],500],
	// ["VegetationPalm",175,[vegetation_enemy],500],
	// ["VegetationVineyard",175,[vegetation_enemy],500],
	["ViewPoint",150,[other_enemy,local_civilian],1000]
	// ["BorderCrossing",100,[other_enemy,local_civilian],500]
];

private _worldSize = worldSize;
private _worldCenter = [_worldSize / 2, _worldSize / 2, 0];
private _g_delete_locations = nearestLocations [position spawn_zone, _all_locations, _safeZone];

private _a_delete_locations = [];
{_a_delete_locations = _a_delete_locations + nearestLocations [_x, _all_locations, 100]} forEach delete_locations;
_g_delete_locations = _g_delete_locations + _a_delete_locations;

private _house_ieds = "ied_in_houses" call BIS_fnc_getParamValue;
private _house_ieds_percentage = ("percentage_of_ied_in_houses" call BIS_fnc_getParamValue) * 0.1;

private _triggersArray = [];

for [{private _i = 0 }, { _i < (count _types_locations) }, { _i = _i + 1 }] do {

	private _locations = (nearestLocations [_worldCenter, [(_types_locations # _i) # 0], _worldSize * 1.5]) - _g_delete_locations;

	private _spawn_area = (_types_locations # _i) # 1;

	{
		private _pos = locationPosition _x;
		private _trigger = createTrigger ["EmptyDetector",_pos,false];
		_trigger setTriggerArea [(_distance + _spawn_area),(_distance + _spawn_area),0,false,800]; 
		_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
		_trigger setTriggerTimeout [3, 3, 3, true];
		_trigger setTriggerStatements ["{vehicle _x in thisList && isplayer _x && (speed _x < 160)} count playableunits > 0", "[thisTrigger] execVM 'core\unit_spawn_system\core\spawn_core.sqf'", ""];
		_trigger setVariable ["location",(_types_locations # _i) # 0];
		_trigger setVariable ["config",(_types_locations # _i) # 2];
		_trigger setVariable ["reward",(_types_locations # _i) # 3];
		_trigger setVariable ["captured",false];
		_trigger setVariable ["active",false];
		_triggersArray pushBack _trigger;

		if (_house_ieds == 1) then {
			private _buildings = nearestObjects [_pos, ["Building"], _spawn_area];
			
			if (!(_buildings isEqualTo [])) then {
				private _useful = _buildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};

				if ((count _useful) > 5) then {
					for "_i" from 1 to (round ((count _useful) * _house_ieds_percentage)) do {
						private _allpositions = (selectRandom _useful) buildingPos -1;
						private _house_ied = createMine [selectRandom houseIed, selectRandom _allpositions,[],1];
						if (prj_debug) then {
							["house_ied_" + str (position _house_ied),position _house_ied,"ColorWEST",1,[],"mil_dot"] call prj_fnc_createMarker;
						};
					};
				};

				if (prj_debug) then {
					systemChat format ["loc: %1 - build: %2 - rew: %3", text _x, count _useful,(_types_locations # _i) # 3];
				};
			};
		};

		if (prj_debug) then {
			["_area_marker_" + str _pos,_pos,"ColorOPFOR",0.7,[[_spawn_area,_spawn_area],"ELLIPSE"]] call prj_fnc_createMarker;
			["_area_trigger_marker_" + str _pos,_pos,"ColorBLUFOR",0.3,[[(_distance + _spawn_area),(_distance + _spawn_area)],"ELLIPSE"]] call prj_fnc_createMarker;
		};
	} forEach _locations;
};

missionNamespace setVariable ["location_triggers",_triggersArray];

//create camps
private _number_of_camps = round (round (_worldSize / 2000));
private _camps_coords = [];
private _camps_ammo_boxes = [];

if (prj_debug) then {
	systemChat format ["CAMPS: %1",_number_of_camps];
	["marker_center_world",_worldCenter,"ColorBlack",1,[],"mil_objective","CENTER"] call prj_fnc_createMarker;
};

private _min_distance = 0;
private _max_distance = (_worldSize / ((_number_of_camps * 2) + 1));
private _intel_objects = ["acex_intelitems_photo","acex_intelitems_document"];

for [{private _i = 1 }, { _i < (_number_of_camps + 1) }, { _i = _i + 1 }] do {

	private _position = [_worldCenter, _min_distance, _max_distance, 5, 0, 0.5, 0] call BIS_fnc_findSafePos;

	if (!isNil "_position") then {
		if (((position spawn_zone) distance _position) < _safeZone) then {
			private _try = 10;
			while {((position spawn_zone) distance _position) < _safeZone && _try > 0} do {
				_position = [_worldCenter, _min_distance, _max_distance, 5, 0, 0.5, 0] call BIS_fnc_findSafePos;
				_try = _try - 1;
			};
			if (((position spawn_zone) distance _position) < _safeZone) then {
				_position = nil;
			};
		};
	};

	if (!isNil "_position") then {
		_camps_coords pushBack _position;
		_compositions = [
			[
				["CamoNet_BLUFOR_open_F",[0.0136719,-0.600098,0],0,1,0,[0,0],"","",true,false], 
				["Land_CampingTable_F",[-1.18555,0.266602,-0.00259161],287.54,1,0,[7.8272e-006,5.46476e-007],"","",true,false], 
				["Land_Ammobox_rounds_F",[1.2666,-0.227539,-0.00016737],34.7668,1,0,[-0.00150395,-0.0597566],"","",true,false], 
				["Land_CampingTable_small_white_F",[-0.186523,-1.48389,0.00260162],359.998,1,0,[-0.000210848,-0.000412427],"","",true,false], 
				["Land_WoodenTable_large_F",[1.80371,-0.350586,0],90.6436,1,0,[-1.26188e-005,0.000162853],"","",true,false], 
				["Land_CampingChair_V2_F",[1.73828,0.691895,-1.90735e-006],46.1794,1,0,[0.000835097,-0.00109385],"","",true,false], 
				["Land_ChairPlastic_F",[-1.56396,-1.53076,9.53674e-007],0.488673,1,0,[-0.00141326,-0.000163208],"","",true,false], 
				["Land_CampingChair_V1_F",[-1.19922,1.85693,0.00308895],82.4506,1,0,[-0.000696618,0.00084023],"","",true,false], 
				["Land_ExtensionCord_F",[-0.234863,-2.48438,0],71.138,1,0,[-1.90827e-007,-6.98804e-007],"","",true,false], 
				["Box_IED_Exp_F",[2.49365,-0.322266,-9.53674e-007],91.3712,1,0,[0.000158571,2.86565e-005],"","",true,false], 
				["Land_PaperBox_open_empty_F",[1.64844,-2.1377,0],0,1,0,[0,0],"","",true,false], 
				["Land_Campfire_F",[-2.63184,1.25488,0.0299988],0,1,0,[0,0],"","",true,false], 
				["SatelliteAntenna_01_Small_Olive_F",[-0.995117,-2.77002,-0.00139332],209.403,1,0,[0.0157905,0.00572149],"","",true,false], 
				["Land_TentA_F",[2.25,2.20703,0],95.1529,1,0,[0,-0],"","",true,false], 
				["Land_WoodPile_F",[-1.84863,2.8623,0],96.5487,1,0,[0,-0],"","",true,false],  
				["Land_ChairPlastic_F",[-3.47754,2.80371,9.53674e-007],61.4002,1,0,[-0.00132119,-0.000102619],"","",true,false]
			],
			[
				["Land_Sack_F",[-0.385742,-0.783691,0],0,1,0,[0,0],"","",true,false], 
				["Land_ShootingPos_Roof_01_F",[-1.41846,0.163574,0],0,1,0,[0,0],"","",true,false], 
				["Land_CampingChair_V2_F",[-0.740234,0.728027,8.58307e-006],61.1208,1,0,[-0.00200058,-0.000681143],"","",true,false], 
				["Land_PaperBox_01_open_boxes_F",[0.992676,0.0078125,0.000930309],177.664,1,0,[-4.3497e-006,-6.01599e-006],"","",true,false], 
				["Land_Ammobox_rounds_F",[-1.229,-0.594727,-0.00016737],90.1042,1,0,[-0.00149947,-0.0597138],"","",true,false], 
				["Land_WoodenTable_small_F",[-1.39844,-0.566895,-9.53674e-007],5.63117,1,0,[3.55844e-005,0.000296774],"","",true,false], 
				["Land_Sleeping_bag_folded_F",[-1.64453,-0.583496,0],360,1,0,[1.50194e-006,-4.20235e-006],"","",true,false], 
				["Land_ExtensionCord_F",[0.0981445,1.82031,0],6.03769e-005,1,0,[7.2595e-006,-3.19181e-005],"","",true,false], 
				["Land_WoodPile_F",[-0.245117,-2.23975,0],95.2161,1,0,[0,-0],"","",true,false], 
				["Land_WoodenBox_02_F",[-2.64502,-0.560059,0],0,1,0,[0,0],"","",true,false], 
				["SatelliteAntenna_01_Small_Olive_F",[0.125,2.74316,-0.0013938],348.46,1,0,[0.0155925,0.00598564],"","",true,false], 
				["Land_PaperBox_open_empty_F",[2.8291,0.0170898,0],0,1,0,[0,0],"","",true,false], 
				["Land_ChairPlastic_F",[-2.80078,0.680664,4.76837e-007],306.975,1,0,[-0.00135966,-0.000169935],"","",true,false], 
				["Land_TentDome_F",[1.98975,2.44775,0],88.8467,1,0,[0,0],"","",true,false], 
				["Land_TentA_F",[2.00342,-3.0332,0],38.403,1,0,[0,0],"","",true,false], 
				["Land_CratesPlastic_F",[-3.66309,-0.550293,0],270.431,1,0,[0,0],"","",true,false], 
				["Land_Basket_F",[-3.87891,0.447754,4.76837e-007],0.000929876,1,0,[5.85499e-005,-0.000514625],"","",true,false], 
				["Land_FirePlace_F",[-0.155273,3.9375,-9.53674e-007],0,1,0,[0,0],"","",true,false], 
				["Land_TentA_F",[-2.44336,-3.08008,0],317.633,1,0,[0,0],"","",true,false], 
				["Land_Campfire_F",[-0.210449,-4.09131,0.0299988],0,1,0,[0,0],"","",true,false]
			]
		];
		[_position, 0, selectRandom _compositions, 0] call BIS_fnc_objectsMapper;

		private _ammo_box = "Box_FIA_Ammo_F" createVehicle ([_position, 5, 25, 1, 0, 0.5, 0] call BIS_fnc_findSafePos);
		_camps_ammo_boxes pushBack _ammo_box;

		clearWeaponCargoGlobal _ammo_box;
		clearMagazineCargoGlobal _ammo_box;
		clearItemCargoGlobal _ammo_box;
		clearBackpackCargoGlobal _ammo_box;

		for "_i" from 0 to ((count _intel_objects) - 1) do {
			_ammo_box addMagazineCargoGlobal [(_intel_objects # _i), [10,15] call BIS_fnc_randomInt];
		};

		private _trigger = createTrigger ["EmptyDetector",_position,false];
		_trigger setTriggerArea [800,800,0,false,800];
		_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
		_trigger setTriggerTimeout [3, 3, 3, true];
		_trigger setTriggerStatements ["{vehicle _x in thisList && isplayer _x && (speed _x < 150)} count playableunits > 0", "[thisTrigger] execVM 'core\unit_spawn_system\core\spawn_core.sqf'", ""];
		_trigger setVariable ["special","camp"];
		_trigger setVariable ["captured",false];
		_trigger setVariable ["active",false];

		if (prj_debug) then {
			["camp_" + str _position,_position,"ColorYellow",1,[],"mil_objective",str _i] call prj_fnc_createMarker;
		};
	};

	_min_distance = (_worldSize / ((_number_of_camps * 2) + 1)) * _i;
	_max_distance = _min_distance + (_worldSize / ((_number_of_camps * 2) + 1));

	if (prj_debug) then {
		private _ellipse_radius = _min_distance;
		["marker_min_" + str _i,_worldCenter,"ColorBlack",1,[[_ellipse_radius,_ellipse_radius],"ELLIPSE"]] call prj_fnc_createMarker;
		("marker_min_" + str _i) setMarkerBrush "Border";
	};
};

missionNamespace setVariable ["camps_coords",_camps_coords,true];

private _roadsSafeRadius = "roads_safe_radius" call BIS_fnc_getParamValue;
private _allRoads = (_worldCenter nearRoads (_worldSize * 1.5)) - (position spawn_zone nearRoads _roadsSafeRadius);

// create checkpoints
private _checkpointParam = "checkpoints_on_roads" call BIS_fnc_getParamValue;

if (_checkpointParam != 0) then {
	private _checkpointsArray = [];

	for "_i" from 1 to _checkpointParam do {
		private _randomRoad = selectRandom _allRoads;
		_allRoads deleteAt (_allRoads find _randomRoad);

		private _roadConnectedTo = roadsConnectedTo _randomRoad;
		private _connectedRoad = _roadConnectedTo select 0;
		private _direction = _randomRoad getDir _connectedRoad;

		if (isNil "_direction") then {
			_direction = 0;
		};

		private _pos = position _randomRoad;

		private _trigger = createTrigger ["EmptyDetector",_pos,false];
		_trigger setTriggerArea [900,900,0,false,800];
		_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
		_trigger setTriggerTimeout [3, 3, 3, true];
		_trigger setTriggerStatements ["{vehicle _x in thisList && isplayer _x && (speed _x < 150)} count playableunits > 0", "[thisTrigger] execVM 'core\unit_spawn_system\core\spawn_core.sqf'", ""];
		_trigger setVariable ["special","checkpoint"];
		_trigger setVariable ["cp_direction",_direction];
		_trigger setVariable ["captured",false];
		_trigger setVariable ["active",false];

		_checkpointsArray pushBack _pos;

		if (prj_debug) then {
			["checkpoint_" + str _pos,_pos,"ColorBlack",1,[],"mil_dot"] call prj_fnc_createMarker;
		};
	};
};

//create ied on the roads
private _iedsParam = "ied_on_roads" call BIS_fnc_getParamValue;

if (_iedsParam != 0) then {
	private _junk_class = ["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];

	private _iedArray = [];
	private _iedPosArray = [];

	for "_i" from 1 to _iedsParam do {

		private _randomRoad = selectRandom _allRoads;
		_allRoads deleteAt (_allRoads find _randomRoad);

		private _pos = position _randomRoad;
		private _ied = createMine [selectRandom roadIed, _pos,[],3];

		if ((random 1) < 0.7) then {
			_junk = selectRandom _junk_class createVehicle position _ied;
			_junk enableSimulationGlobal false;
		};

		_iedArray pushBack _ied;
		_iedPosArray pushBack _pos;
		
		private _junk = selectRandom _junk_class createVehicle (position (selectRandom _allRoads));
		_junk enableSimulationGlobal false;

		if (prj_debug) then {
			["junk_" + str (position _junk),position _junk,"ColorWEST",1,[],"mil_dot"] call prj_fnc_createMarker;
			["ied_" + str (position _ied),position _ied,"ColorOPFOR",1,[],"mil_dot"] call prj_fnc_createMarker;
		};
	};

	missionNamespace setVariable ["iedArray",_iedArray,true];
	missionNamespace setVariable ["iedPosArray",_iedPosArray,true];
};