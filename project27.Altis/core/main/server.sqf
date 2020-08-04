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
[
	[
		["missionNamespace",["intel_score",0,true],false],
		["missionNamespace",["arsenal_level",0,true],false],
		["missionNamespace",["g_garage_level",0,true],false],
		["missionNamespace",["a_garage_level",0,true],false],
		["missionNamespace",["total_kill_enemy",0,true],false],
		["missionNamespace",["total_kill_friend",0,true],false],
		["missionNamespace",["total_kill_civ",0,true],false]	
	]
] call prj_fnc_set_variables;

// create triggers
private _trg_g_garage = [position g_garage_depot_blue, [10, 10, 3], "ANYPLAYER", "PRESENT", true, "[thisTrigger,'g_garage'] execVM 'core\fnc\action_functions.sqf'", true] call prj_fnc_create_trg;
private _trg_a_garage = [position a_garage_depot_blue, [10, 10, 3], "ANYPLAYER", "PRESENT", true, "[thisTrigger,'a_garage'] execVM 'core\fnc\action_functions.sqf'", true] call prj_fnc_create_trg;

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

//create EHs and other system
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
					["missionNamespace", "total_kill_friend", 1] call prj_fnc_changeVariable;		
				};
				case civilian: {
					["missionNamespace", getPlayerUID _killer, "money", 0, -5] call prj_fnc_changePlayerVariable;
					["missionNamespace", getPlayerUID _killer, "civ_killings", 3, 1] call prj_fnc_changePlayerVariable;
					["missionNamespace", "total_kill_civ", 1] call prj_fnc_changeVariable;
				};
				case independent: {
					["missionNamespace", getPlayerUID _killer, "money", 0, 10] call prj_fnc_changePlayerVariable;
					["missionNamespace", getPlayerUID _killer, "enemy_killings", 1, 1] call prj_fnc_changePlayerVariable;
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

//transformation intels to inter score
office_table addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];
	
	private _intel_objects = [
		["acex_intelitems_photo",5],
		["acex_intelitems_document",3],
		["ACE_Cellphone",2],
		["acex_intelitems_notepad",1]
	];

	private _office_table_items = [((getItemCargo office_table) # 0) + ((getMagazineCargo office_table) # 0),((getItemCargo office_table) # 1) + ((getMagazineCargo office_table) # 1)];

	clearItemCargoGlobal office_table;
	clearMagazineCargoGlobal office_table;
	clearWeaponCargoGlobal office_table;
	clearBackpackCargoGlobal office_table;

	{	
		private _finded = false;
		for [{private _i = 0 }, { _i < (count _intel_objects) }, { _i = _i + 1 }] do {

			private _intel_object = ((_intel_objects # _i) # 0);
			private _intel_object_coast = ((_intel_objects # _i) # 1);
			
			if (_x isEqualTo _intel_object) then {
				private _intel_coast = ((_office_table_items # 1) # _forEachIndex) * _intel_object_coast;
				private _value = (missionNamespace getVariable "intel_score") + _intel_coast;
				missionNamespace setVariable ["intel_score",_value,true];
				if (prj_debug) then {
					systemChat format ["найдено совпадение %1 и %2. начислено %3 очков",_x,_intel_object,_intel_coast]
				};
				_finded = true;
			};
		};

		if (!_finded) then {
			office_table addItemCargoGlobal [_x, ((_office_table_items # 1) # _forEachIndex)];
			if (prj_debug) then {
				systemChat format ["для %1 не найдено совпадений. вернуто в кол-ве %3",_x,((_office_table_items # 1) # _forEachIndex)]
			};
		};

	} forEach (_office_table_items # 0);
}];

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