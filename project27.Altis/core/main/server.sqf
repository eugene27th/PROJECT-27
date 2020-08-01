/*
	written by eugene27.
	only server
*/

// Initializes the Dynamic Groups framework
["Initialize"] call BIS_fnc_dynamicGroups; 

// execvm
execVM "core\unit_spawn_system\core\select_locations.sqf";
execVM "core\tasks\patrols.sqf";

// statistics manager
null = [] spawn {
	while {true} do {
		uiSleep 10;
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
		if (side _killer == west && isPlayer _killer) then {
			switch (_victim getVariable "oldSide") do {
				case west: {
					["missionNamespace", getPlayerUID _killer, "money", 0, -50] call prj_fnc_changePlayerVariable;
					["missionNamespace", getPlayerUID _killer, "friend_killings", 2, 1] call prj_fnc_changePlayerVariable;
				};
				case civilian: {
					["missionNamespace", getPlayerUID _killer, "money", -5] call prj_fnc_changePlayerVariable;
					["missionNamespace", getPlayerUID _killer, "civ_killings", 3] call prj_fnc_changePlayerVariable;
				};
				case independent: {
					["missionNamespace", getPlayerUID _killer, "money", 10] call prj_fnc_changePlayerVariable;
					["missionNamespace", getPlayerUID _killer, "enemy_killings", 0, 1] call prj_fnc_changePlayerVariable;

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
		["missionNamespace",["intel_score",0,true],false],
		["missionNamespace",["arsenal_level",0,true],false],
		["missionNamespace",["g_garage_level",0,true],false],
		["missionNamespace",["a_garage_level",0,true],false]
	]
] call prj_fnc_set_variables;

// create triggers
private _trg_g_garage = [position g_garage_depot_blue, [10, 10, 3], "ANYPLAYER", "PRESENT", "[thisTrigger,'g_garage'] execVM 'core\fnc\action_functions.sqf'", true] call prj_fnc_create_trg;
private _trg_a_garage = [position a_garage_depot_blue, [10, 10, 3], "ANYPLAYER", "PRESENT","[thisTrigger,'a_garage'] execVM 'core\fnc\action_functions.sqf'", true] call prj_fnc_create_trg;

// create markers
[
	[
		["hq",position laptop_hq,"mil_dot","ColorWEST","command center"],
		["arsenal",position arsenal_blue,"mil_dot","ColorWEST","arsenal"],
		["respawn_west",position spawn_zone_blue,"b_hq","ColorWEST","main base"],
		["ground_vehicle_shop",position g_garage_depot_blue,"mil_dot","ColorWEST","land vehicle"],
		["air_vehicle_shop",position a_garage_depot_blue,"mil_dot","ColorWEST","air vehicle"],
		["ground_vehicle_service",position tr_g_service_blue,"mil_dot","ColorWEST","ground service"],
		["air_vehicle_service",position tr_a_service_blue,"mil_dot","ColorWEST","air service"],
		["treatment_building",position tr_treatment_blue,"mil_dot","ColorWEST","treatment"]
	]
] call prj_fnc_create_markers;

// create arsenal
[arsenal_blue, [[], 1]] call ace_arsenal_fnc_attributeInit;

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