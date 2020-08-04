/*
	written by eugene27.
	server only
*/

private _safe_radius = 2000;
private _distance = 600;

private _all_locations = ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"];

private _types_locations = [
	["NameCityCapital",350,[cities_enemy,cities_civilian]],
	["NameCity",300,[cities_enemy,cities_civilian]],
	["NameVillage",250,[villages_enemy,villages_civilian]],
	["NameLocal",150,[local_enemy,local_civilian]],
	["Hill",50,[hills_enemy,hills_civilian]],
	["RockArea",125,[rock_enemy,rock_civilian]],
	["VegetationBroadleaf",175,[vegetation_enemy,vegetation_civilian]],
	["VegetationFir",175,[vegetation_enemy,vegetation_civilian]],
	["VegetationPalm",175,[vegetation_enemy,vegetation_civilian]],
	["VegetationVineyard",175,[vegetation_enemy,vegetation_civilian]],
	["ViewPoint",150,[other_enemy,other_civilian]],
	["BorderCrossing",100,[other_enemy,other_civilian]]
];

private _delete_locations = nearestLocations [position spawn_zone_blue, _all_locations, _safe_radius];

private _house_ieds = "ied_in_houses" call BIS_fnc_getParamValue;
private _house_ieds_class = ["rhs_mine_a200_dz35","rhs_mine_stockmine43_2m","APERSTripMine","rhs_mine_mk2_pressure"];
private _house_ieds_percentage = ("percentage_of_ied_in_houses" call BIS_fnc_getParamValue) * 0.1;

for [{private _i = 0 }, { _i < (count _types_locations) }, { _i = _i + 1 }] do {

	private _locations = (nearestLocations [[worldSize / 2, worldsize / 2, 0], [(_types_locations # _i) # 0], worldSize * 1.5]) - _delete_locations;

	private _spawn_area = (_types_locations # _i) # 1;

	{
		private _pos = locationPosition _x;
		private _trigger = createTrigger ["EmptyDetector",_pos,false];
		_trigger setTriggerArea [(_distance + _spawn_area),(_distance + _spawn_area),0,false]; 
		_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
		_trigger setTriggerTimeout [3, 3, 3, true];
		_trigger setTriggerStatements ["{vehicle _x in thisList && isplayer _x && ((getPosATL _x) # 2) < 150 && (speed _x < 180)} count playableunits > 0", "[thisTrigger] execVM 'core\unit_spawn_system\core\spawn_core.sqf'", ""];
		_trigger setVariable ["config",(_types_locations # _i) # 2];
		_trigger setVariable ["captured",false];

		if (_house_ieds == 1) then {
			private _buildings = nearestObjects [_pos, ["Building"], _spawn_area];
			if (!(_buildings isEqualTo [])) then {
				private _useful = _buildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};

				if ((count _useful) > 5) then {
					for "_i" from 1 to (round ((count _useful) * _house_ieds_percentage)) do {
						private _allpositions = (selectRandom _useful) buildingPos -1;
						private _house_ied = createMine [selectRandom _house_ieds_class, selectRandom _allpositions,[],1];
						if (prj_debug) then {
							["house_ied_" + str (position _house_ied),position _house_ied,"ColorWEST",1,[],"mil_dot"] call prj_fnc_create_marker;
						};
					};
				};

				if (prj_debug) then {
					systemChat format ["%1 - %2 - %3", text _x, count _useful, round ((count _useful) * 0.2)];
				};
			};
		};

		if (prj_debug) then {
			["_area_marker_" + str _pos,_pos,"ColorOPFOR",0.7,[[_spawn_area,_spawn_area],"ELLIPSE"]] call prj_fnc_create_marker;
			["_area_trigger_marker_" + str _pos,_pos,"ColorBLUFOR",0.3,[[(_distance + _spawn_area),(_distance + _spawn_area)],"ELLIPSE"]] call prj_fnc_create_marker;
		};
	} forEach _locations;
};

//create ied on the roads
if (("ied_on_roads" call BIS_fnc_getParamValue) == 0) exitWith {};

private _junk_class = ["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];
private _number_of_ied = "number_of_ied" call BIS_fnc_getParamValue;
private _safe_radius = "ied_safe_radius" call BIS_fnc_getParamValue;

private _roads = ([worldSize / 2, worldsize / 2, 0] nearRoads (worldSize * 1.5)) - (position spawn_zone_blue nearRoads _safe_radius);

for "_i" from 1 to _number_of_ied do {
	private _ied = createMine [selectRandom ied, (position (selectRandom _roads)),[],3];
	if ((random 1) < 0.7) then {
		_junk = selectRandom _junk_class createVehicle position _ied;
		_junk enableSimulationGlobal false;
	};
	private _junk = selectRandom _junk_class createVehicle (position (selectRandom _roads));
	_junk enableSimulationGlobal false;

	if (prj_debug) then {
		["junk_" + str (position _junk),position _junk,"ColorWEST",1,[],"mil_dot"] call prj_fnc_create_marker;
		["ied_" + str (position _ied),position _ied,"ColorOPFOR",1,[],"mil_dot"] call prj_fnc_create_marker;
	};
};

{independent revealMine _x} forEach allMines;