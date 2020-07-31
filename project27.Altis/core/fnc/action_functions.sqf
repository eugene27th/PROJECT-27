/*
	written by eugene27.
	global functions
*/

params ["_trg","_type"];

private "_action";

switch (_type) do {
	case "a_garage": {
		if (!(vehicle player isKindOf 'Man')) exitWith {};
		_action = [
			player,
			"Open garage",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
			"_this distance _target < 3",
			"_caller distance _target < 3",
			{},
			{},
			{[false,a_garage_depot_blue] call prj_fnc_vehicle_shop_window},
			{},
			[],
			3,
			0,
			true,
			false
		] call BIS_fnc_holdActionAdd;
		waitUntil {uiSleep 1; (player distance (getPos _trg)) > 10};
		[player, _action] call BIS_fnc_holdActionRemove;
	};
	case "g_garage": {
		if (!(vehicle player isKindOf 'Man')) exitWith {};
		_action = [
			player,
			"Open garage",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
			"_this distance _target < 3",
			"_caller distance _target < 3",
			{},
			{},
			{[true,g_garage_depot_blue] call prj_fnc_vehicle_shop_window},
			{},
			[],
			3,
			0,
			true,
			false
		] call BIS_fnc_holdActionAdd;
		waitUntil {uiSleep 1; (player distance (getPos _trg)) > 10};
		[player, _action] call BIS_fnc_holdActionRemove;
	};
	case "vehicle_service": {
		if (vehicle player isKindOf 'Man') exitWith {};
		_action = [
			player,
			"Vehicle operations",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
			"_this distance _target < 3",
			"_caller distance _target < 3",
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
		waitUntil {uiSleep 1; (player distance (getPos _trg)) > 10};
		[player, _action] call BIS_fnc_holdActionRemove;
	};
};