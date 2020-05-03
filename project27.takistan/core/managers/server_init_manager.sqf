/*
	written by eugene27.
	only server
	1.3.0
*/

// Initializes the Dynamic Groups framework
["Initialize"] call BIS_fnc_dynamicGroups; 

// friendly units
// east setFriend [west, 1];
// west setFriend [east, 1];

// local fnc
pgn_fnc_create_markers = {
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

// execvm
execVM "core\unit_spawn_system\core\select_locations.sqf";
execVM "core\tasks\patrols.sqf";

// statistics manager
null = [] spawn {
	while {true} do {
		sleep 10;
		{
			if (isNil {_x getVariable "oldSide"} || {(_x getVariable "oldSide") != side _x}) then {
				_x setVariable ["oldSide",side _x,true]
			};
		} forEach allUnits;
	};
};

addMissionEventHandler  ["Entitykilled", {
	params [
		"_victim","_killer"
	];
	if (isPlayer _killer || _victim != _killer) then {
		if (side _killer == west) then {
			switch (_victim getVariable "oldSide") do {
				case west: {
					_killer setVariable ["money",(_killer getVariable "money") - 50,true];
					_killer setVariable ["friend_killings",(_killer getVariable "friend_killings") + 1,true];
				};
				case east: {
					_killer setVariable ["money",(_killer getVariable "money") - 50,true];
					_killer setVariable ["friend_killings",(_killer getVariable "friend_killings") + 1,true];
				};
				case civilian: {
					_killer setVariable ["money",(_killer getVariable "money") - 5,true];
					_killer setVariable ["civ_killings",(_killer getVariable "civ_killings") + 1,true];
				};
				case independent: {
					_killer setVariable ["money",(_killer getVariable "money") + 10,true];
					_killer setVariable ["enemy_killings",(_killer getVariable "enemy_killings") + 1,true];
					if (random 1 < 0.5) then {
						_victim addMagazine [selectRandom ["acex_intelitems_photo","acex_intelitems_document","acex_intelitems_notepad"], 1];
					};
					if (random 1 < 0.5) then {
						_victim addItemToUniform "ACE_Cellphone";
					};
				};
			};	
		};
	};
}];

// set variables
[
	[
		["missionNamespace",["intel_score",0,true]],
		["missionNamespace",["arsenal_level",0,true]],
		["missionNamespace",["g_garage_level",0,true]],
		["missionNamespace",["a_garage_level",0,true]]
	]
] call prj_fnc_set_variables;

// create markers
[
	[
		["hq_blue",position laptophq,"mil_dot","ColorWEST","command center"],

		["respawn_west",position Checkpoint2,"b_hq","ColorWEST","BLUE BASE"],
		["land_vehicle_b",position shed2,"mil_dot","ColorWEST","land vehicle"],
		["air_vehicle_b",position airdepotplace2,"mil_dot","ColorWEST","air vehicle"],
		["vehicle_service_b",position vehserviceb,"mil_dot","ColorWEST","vehicle service"],
		["airserviceb_tr",position airserviceb_tr,"mil_dot","ColorWEST","air service"],
		["treatment_b",position medbuildb,"mil_dot","ColorWEST","treatment"],
		["vehicle_tp_from_r",position tp_veh_blue,"mil_dot","ColorWEST","vehicle tp from redbase"],
		
		["red_base",position Checkpoint1,"o_hq","ColorEAST","RED BASE"],
		["land_vehicle_r",position shed1,"mil_dot","ColorEAST","land vehicle"],
		["air_vehicle_r",position airdepotplace1,"mil_dot","ColorEAST","air vehicle"],
		["vehicle_service_r",position vehserviceo,"mil_dot","ColorEAST","vehicle service"],
		["airserviceo_tr",position airserviceo_tr,"mil_dot","ColorEAST","air service"],
		["treatment_r",position medbuildo,"mil_dot","ColorEAST","treatment"],	
		["vehicle_tp_from_b",position tp_veh_red,"mil_dot","ColorEAST","vehicle tp from bluebase"]
	]
] call pgn_fnc_create_markers;

// create arsenal
{
	[_x, [[], 1]] call ace_arsenal_fnc_attributeInit;
} forEach [arsenalboxonbluebase,arsenalboxonredbase];

// time acceleration
[] spawn {
	while {true} do {
		if (daytime >= 21 || daytime < 4) then
		{setTimeMultiplier 14}
		else
		{setTimeMultiplier 5};
		uiSleep 30;
	};
};