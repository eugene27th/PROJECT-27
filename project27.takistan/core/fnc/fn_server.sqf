/*
	written by eugene27.
	server only
	1.3.0
*/

prj_fnc_select_position = {
	
	params [
		"_type_location",["_position_around", true]
	];

	private ["_selected_pos","_safe_radius","_type_locations","_locations"];

	_types_location = switch (_type_location) do {
		case 1: {["NameCityCapital","NameCity","NameVillage"]};
		case 2: {["RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]};
		case 3: {["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"]};
		case 4: {["NameCityCapital","NameCity","NameVillage","NameLocal","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]};
	};

	_safe_radius = "spawnunitsradiusaroundthebase" call BIS_fnc_getParamValue;

	_locations = nearestLocations [[worldSize / 2, worldsize / 2, 0], _types_location, worldSize * 1.5] - (nearestLocations [position Checkpoint1, ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"], _safe_radius] + nearestLocations [position Checkpoint2, ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","BorderCrossing"], _safe_radius]);

	switch (_position_around) do {
		case true: {
			_selected_pos = [locationPosition (selectRandom _locations), 100, 1000, 5, 0] call BIS_fnc_findSafePos;
		};
		case false: {
			_selected_pos = locationPosition (selectRandom _locations);
		};
	};
	_selected_pos set [2, 0];
	_selected_pos
};

prj_fnc_select_road_position = {

	params [
		["_typelocation",4],["_radius",3000]
	];

	private ["_returndata","_pos","_roadConnectedTo","_connectedRoad","_direction","_roads","_road"];

	_pos = [_typelocation] call prj_fnc_select_position;
	_roads = _pos nearRoads _radius;
	_roads = _roads select {isOnRoad _x};

	if ((count _roads) >= 2) then {
		_road = selectRandom _roads;
		_pos = getPos _road;
		_pos set [2, 0];
		_roadConnectedTo = roadsConnectedTo _road;
		_connectedRoad = _roadConnectedTo select 0;
		_direction = _road getDir _connectedRoad;
		_returndata = [_pos,_direction];
	}
	else
	{
		_pos = [_pos, round ((_radius / 100) * 10), _radius, 3, 0] call BIS_fnc_findSafePos;
		_direction = round (random 360);
		_returndata = [_pos,_direction];
	};
	_returndata
};

prj_fnc_select_house_position = {

	params [
		["_pos", [0,0,0]],
		["_radius", 200]
	];

	private ["_buildings","_useful","_allpositions","_pos"];

	_buildings = nearestObjects [_pos, ["Building"], _radius];
	_useful = _buildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};
	if ((count _useful) > 5) then {
		_allpositions = (selectRandom _useful) buildingPos -1;
		_pos = selectRandom _allpositions;
	};
	if (isNil "_pos") then {
		_pos = [_pos, (_radius / 100) * 10, _radius, 2, 0] call BIS_fnc_findSafePos;
	};
	_pos
};

prj_fnc_create_marker = {

	params [
		"_markername","_position","_color","_alpha",["_size_form",[]],["_type",""],["_text",""]
	];

	_marker = createMarker [_markername,_position];
	_marker setMarkerColor _color;
	_marker setMarkerAlpha _alpha;

	if (!isNil "_size_form" && count _size_form != 0) then {
		_marker setMarkerSize (_size_form select 0);
		_marker setMarkerShape (_size_form select 1);
	};

	if (!isNil "_type") then {_marker setMarkerType _type};
	if (!isNil "_text") then {_marker setMarkerText _text};
};

prj_fnc_create_crew = {

	params [
		"_vehicle","_units",["_passengers",false],["_side",independent]
	];

	// hintC format ["%1 | %2 | %3 | %4",_vehicle,_units,_side,_passengers];

	private ["_vehicle_crew","_vehicle_group","_vehicle_cargo","_empty_seats"];

	//create crew
	_vehicle_crew = [];

	_vehicle_group = createGroup _side;

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
	_vehicle_cargo = [];

	if (_passengers) then {
		
		_empty_seats = round (random (_vehicle emptyPositions "cargo"));

		for "_i" from 1 to _empty_seats do {
			private _unit = _vehicle_group createUnit [selectRandom _units, position _vehicle, [], 0, "NONE"];
			_unit moveInCargo _vehicle;
			_vehicle_cargo pushBack _unit;
		};
	};

	_vehicle_crew + _vehicle_cargo
};