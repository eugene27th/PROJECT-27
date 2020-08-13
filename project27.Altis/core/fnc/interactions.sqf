/*
	written by eugene27.
	global functions
*/

params ["_trg","_type","_thisList"];

{
	if !(isPlayer _x) exitWith {};

	private "_action";

	switch (_type) do {
		case "a_garage": {
			if (!(vehicle _x isKindOf 'Man')) exitWith {};
			_action = [
				_x,
				"Air vehicles shop",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"true",
				"true",
				{},
				{},
				{[false,tr_a_shop] call prj_fnc_vehicle_shop_window},
				{},
				[],
				3,
				0,
				true,
				false
			] call BIS_fnc_holdActionAdd;
			waitUntil {uiSleep 1; (_x distance (getPos _trg)) > 10};
			[_x, _action] call BIS_fnc_holdActionRemove;
		};
		case "g_garage": {
			if (!(vehicle _x isKindOf 'Man')) exitWith {};
			_action = [
				_x,
				"Ground vehicles shop",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"true",
				"true",
				{},
				{},
				{[true,tr_g_shop] call prj_fnc_vehicle_shop_window},
				{},
				[],
				3,
				0,
				true,
				false
			] call BIS_fnc_holdActionAdd;
			waitUntil {uiSleep 1; (_x distance (getPos _trg)) > 10};
			[_x, _action] call BIS_fnc_holdActionRemove;
		};
		case "vehicle_service": {
			if (vehicle _x isKindOf 'Man') exitWith {};
			_action = [
				_x,
				"Vehicle operations",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"true",
				"true",
				{},
				{},
				{call prj_fnc_vehicle_menu_window},
				{},
				[],
				3,
				0,
				true,
				false
			] call BIS_fnc_holdActionAdd;
			waitUntil {uiSleep 1; (_x distance (getPos _trg)) > 10};
			[_x, _action] call BIS_fnc_holdActionRemove;
		};

		case "treatment": {
			if (!(vehicle _x isKindOf 'Man')) exitWith {};
			_action = [
				_x,
				"Treatment",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"true",
				"true",
				{},
				{},
				{[player] call ace_medical_treatment_fnc_fullHealLocal},
				{},
				[],
				2,
				0,
				true,
				true
			] call BIS_fnc_holdActionAdd;
			waitUntil {uiSleep 1; (_x distance (getPos _trg)) > 4};
			[_x, _action] call BIS_fnc_holdActionRemove;
		};
	};
} forEach _thisList;