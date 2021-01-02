/*
	written by eugene27.
	only server
*/

// Initializes the Dynamic Groups framework
["Initialize"] call BIS_fnc_dynamicGroups; 

// execvm
execVM "core\unit_spawn_system\core\select_locations.sqf";
execVM "core\tasks\patrols.sqf";

// set variables
private _air_level = "a_garage_level_on_start" call BIS_fnc_getParamValue;
private _ground_level = "g_garage_level_on_start" call BIS_fnc_getParamValue;
if (isNil "_air_level") then {_air_level = 0};
if (isNil "_ground_level") then {_ground_level = 0};

[
	[
		["missionNamespace",["intel_score",0,true],false],
		["missionNamespace",["arsenal_level",0,true],false],
		["missionNamespace",["g_garage_level",_ground_level,true],false],
		["missionNamespace",["a_garage_level",_air_level,true],false],
		["missionNamespace",["total_kill_enemy",0,true],false],
		["missionNamespace",["total_kill_friend",0,true],false],
		["missionNamespace",["total_kill_civ",0,true],false]
	]
] call prj_fnc_set_variables;

// create markers
[
	[
		["hq",position laptop_hq,"mil_dot","ColorWEST","command center"],
		["arsenal",position arsenal,"mil_dot","ColorWEST","arsenal"],
		["respawn_west",position spawn_zone,"b_hq","ColorWEST","main base"],
		["ground_vehicle_shop",position tr_g_shop,"mil_dot","ColorWEST","ground vehicles"],
		["air_vehicle_shop",position tr_a_shop,"mil_dot","ColorWEST","air vehicles"],
		["ground_vehicle_service",position tr_g_service,"mil_dot","ColorWEST","ground service"],
		["air_vehicle_service",position tr_a_service,"mil_dot","ColorWEST","air service"],
		["treatment_building",position tr_treatment,"mil_dot","ColorWEST","treatment"]
	]
] call prj_fnc_create_markers;

// create arsenal
[arsenal, [[], 1]] call ace_arsenal_fnc_attributeInit;

// create any objects
private _a_garage_depot = createVehicle ["VR_Area_01_circle_4_grey_F", position tr_a_shop, [], 0, "CAN_COLLIDE"];
private _g_garage_depot = createVehicle ["VR_Area_01_circle_4_yellow_F", position tr_g_shop, [], 0, "CAN_COLLIDE"];
{(_x # 0) setDir ((triggerArea (_x # 1)) # 2)} forEach [[_a_garage_depot,tr_a_shop],[_g_garage_depot,tr_g_shop]];

//create EHs and other system
// statistics manager
[] spawn {
	while {true} do {
		uiSleep 1;
		{
			private _oldSide = _x getVariable ["oldSide","empty"];
			if (_oldSide isEqualTo "empty") then {
				_x setVariable ["oldSide",side _x,true];
			}
			else
			{
				if (side group _x != _oldSide) then {
					_x setVariable ["oldSide",side _x,true];
				};
			};
		} forEach allUnits;
	};
};

addMissionEventHandler ["Entitykilled", {
	params [
		"_victim","_killer"
	];
	if (isPlayer _killer || _victim != _killer) then {
		if (side _killer == west && isPlayer _killer) then {
			switch (_victim getVariable "oldSide") do {
				case west: {
					["missionNamespace", "money", 0, -50, getPlayerUID _killer] call prj_fnc_changePlayerVariableLocal;
					["missionNamespace", "friend_killings", 2, 1, getPlayerUID _killer] call prj_fnc_changePlayerVariableLocal;
					["missionNamespace", "total_kill_friend", 1] call prj_fnc_changeVariable;	
				};
				case civilian: {
					["missionNamespace", "money", 0, -20, getPlayerUID _killer] call prj_fnc_changePlayerVariableLocal;
					["missionNamespace", "civ_killings", 3, 1, getPlayerUID _killer] call prj_fnc_changePlayerVariableLocal;
					["missionNamespace", "total_kill_civ", 1] call prj_fnc_changeVariable;
				};
				case independent: {
					["missionNamespace", "money", 0, 10, getPlayerUID _killer] call prj_fnc_changePlayerVariableLocal;
					["missionNamespace", "enemy_killings", 1, 1, getPlayerUID _killer] call prj_fnc_changePlayerVariableLocal;
					["missionNamespace", "total_kill_enemy", 1] call prj_fnc_changeVariable;

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

addMissionEventHandler ["PlayerConnected",
{
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	private _uids = missionNamespace getVariable ["prj27UIDs",[]];
	if ((_uids findIf {_x == _uid}) == -1) then {
		_uids pushBack _uid;
		missionNamespace setVariable ["prj27UIDs",_uids,true];

		private _player_points = "player_point_value_on_start" call BIS_fnc_getParamValue;
		if (isNil "_player_points") then {_player_points = 100};

		[
			[
				[
					"missionNamespace",
					[
						_uid,
						[
							["money",_player_points],
							["enemy_killings",0],
							["friend_killings",0],
							["civ_killings",0]
						],
						true
					],
					false
				]
			]
		] call prj_fnc_set_variables;
	};
}];

if (!isDedicated) then {

	private _uid = getPlayerUID player;
	private _uids = missionNamespace getVariable ["prj27UIDs",[]];
	
	if ((_uids findIf {_x == _uid}) == -1) then {_uids pushBack _uid};
	missionNamespace setVariable ["prj27UIDs",_uids,true];

	private _player_points = "player_point_value_on_start" call BIS_fnc_getParamValue;
	if (isNil "_player_points") then {_player_points = 100};

	[
		[
			[
				"missionNamespace",
				[
					_uid,
					[
						["money",_player_points],
						["enemy_killings",0],
						["friend_killings",0],
						["civ_killings",0]
					],
					true
				],
				false
			]
		]
	] call prj_fnc_set_variables;
};

// time acceleration
[] spawn {
	while {true} do {
		if (daytime >= 21 || daytime < 4) then
		{setTimeMultiplier 7}
		else
		{setTimeMultiplier 5};
		uiSleep 30;
	};
};

// auto load
private _autoLoad = "autoSaveLoad" call BIS_fnc_getParamValue;
if (_autoLoad == 1) then {call prj_fnc_load_game};

// winter ambience
private _winterAmb = "winterAmbience" call BIS_fnc_getParamValue;
if (_winterAmb == 1) then {call prj_fnc_winterAmbienceServer};