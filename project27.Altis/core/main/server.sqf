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
private _a_garage_depot = "VR_Area_01_circle_4_grey_F" createVehicle position tr_a_shop;
private _g_garage_depot = "VR_Area_01_circle_4_yellow_F" createVehicle position tr_g_shop;
{(_x # 0) setDir ((triggerArea (_x # 1)) # 2)} forEach [[_a_garage_depot,tr_a_shop],[_g_garage_depot,tr_g_shop]];

//create EHs and other system
// statistics manager
null = [] spawn {
	while {true} do {
		uiSleep 5;
		{
			if (isNil {_x getVariable "oldSide"} || {(_x getVariable "oldSide") != side _x}) then {
				_x setVariable ["oldSide",side _x,true]
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
					["missionNamespace", "money", 0, -5, getPlayerUID _killer] call prj_fnc_changePlayerVariableLocal;
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

//transformation intels to inter score
office_table addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];
	
	private _intel_objects = [
		["acex_intelitems_photo",5],
		["acex_intelitems_document",5],
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