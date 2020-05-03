/*
	written by eugene27.
	server and client
	1.3.0
*/

//COMPILE SERVER ONLY
if (isServer) then {
	[] call compile preprocessFileLineNumbers "core\unit_spawn_system\configuration.sqf";
	// only server fnc
	[] call compile preprocessFileLineNumbers "core\fnc\fn_server.sqf";
	// tasks list
	[] call compile preprocessFileLineNumbers "core\tasks\tasks.sqf";
};

[] call compile preprocessFileLineNumbers "core\settings.sqf";

//COMPILE SERVER AND CLIENT

// set player and mission variables
prj_fnc_set_variables = compile preprocessFileLineNumbers "core\fnc\fn_set_variables.sqf";

// vehicle shop
prj_fnc_vehicle_shop_window = compile preprocessFileLineNumbers "core\fnc\GUI\vehicle_shop\vehicle_shop_window.sqf";
prj_fnc_show_vehicle_picture = compile preprocessFileLineNumbers "core\fnc\GUI\vehicle_shop\show_vehicle_picture.sqf";
prj_fnc_spawn_vehicle = compile preprocessFileLineNumbers "core\fnc\GUI\vehicle_shop\spawn_vehicle.sqf";

// hq menu
prj_fnc_hq_menu = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\hq_menu.sqf";
prj_fnc_tpmhq = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\to_mhq.sqf";

// bank menu
prj_fnc_bank_menu = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\bank_menu\bank_menu.sqf";
prj_fnc_transfer_points = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\bank_menu\transfer_points.sqf";
prj_fnc_btn_transfer_points = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\bank_menu\btn_transfer_points.sqf";
prj_fnc_player_info = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\bank_menu\player_info.sqf";

// intel menu
prj_fnc_intel_menu = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\intel_menu\intel_menu.sqf";
prj_fnc_show_intel_trade = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\intel_menu\intel_trade.sqf";
prj_fnc_intel_trade_btn = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\intel_menu\intel_trade_btn.sqf";

// upgrades menu
prj_fnc_upgrades_menu = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\upgrades_menu\upgrades_menu.sqf";
prj_fnc_upgrade = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\upgrades_menu\upgrade.sqf";

// option menu
prj_fnc_option_menu = compile preprocessFileLineNumbers "core\fnc\GUI\hq_menu\option_menu\option_menu.sqf";

// vehicle service menu
prj_fnc_vehicle_menu_window = compile preprocessFileLineNumbers "core\fnc\GUI\vehicle_menu\vehicle_menu_window.sqf";
prj_fnc_vehicle_repair = compile preprocessFileLineNumbers "core\fnc\GUI\vehicle_menu\vehicle_repair.sqf";
prj_fnc_show_load_items = compile preprocessFileLineNumbers "core\fnc\GUI\vehicle_menu\show_load_items.sqf";
prj_fnc_load_item_to_cargo = compile preprocessFileLineNumbers "core\fnc\GUI\vehicle_menu\load_item_to_cargo.sqf";

// civil interaction
prj_fnc_civ_orders = compile preprocessFileLineNumbers "core\fnc\civil_interaction\civil_orders.sqf";
prj_fnc_civ_info = compile preprocessFileLineNumbers "core\fnc\civil_interaction\civil_info.sqf";

// tasks fnc
prj_fnc_cancel_task = compile preprocessFileLineNumbers "core\tasks\fnc\cancel_task.sqf";
prj_fnc_create_task = compile preprocessFileLineNumbers "core\tasks\fnc\create_task.sqf";

// mhq
prj_fnc_add_mhq_action = compile preprocessFileLineNumbers "core\fnc\fn_add_mhq_actions.sqf";