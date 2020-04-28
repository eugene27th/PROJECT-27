//main
pr27ver = "1.3.0";

east setFriend [west, 1];
west setFriend [east, 1];

/////////////COMPILE\\\\\\\\\\\\\\

//COMPILE SERVER ONLY
if (isServer) then {
	[] call compile preprocessFileLineNumbers "core\settings.sqf";
	[] call compile preprocessFileLineNumbers "core\unit_spawn_system\configuration.sqf";
	// server fnc
	[] call compile preprocessFileLineNumbers "core\fnc\fnc_server.sqf";
};

//COMPILE SERVER AND CLIENT
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
prj_fnc_add_mhq_action = compile preprocessFileLineNumbers "core\fnc\add_mhq_actions.sqf";

if (isServer) then {
	["Initialize"] call BIS_fnc_dynamicGroups; // Initializes the Dynamic Groups framework

	//execvm
	execVM "core\unit_spawn_system\core\select_locations.sqf";
	execVM "core\tasks\patrols.sqf";
	execVM "core\fnc\rating_system.sqf";

	//variables
	missionNamespace setVariable ["intel_score",0,true];
	missionNamespace setVariable ["arsenal_level",0,true];
	missionNamespace setVariable ["g_garage_level",0,true];
	missionNamespace setVariable ["a_garage_level",0,true];

	//other fnc
	[] spawn {
		while {true} do {
			if (daytime >= 21 || daytime < 4) then
			{setTimeMultiplier 14}
			else
			{setTimeMultiplier 5};
			uiSleep 30;
		};
	};
};

//local fnc
pgn_fnc_set_textures = {
	params [
		"_textures_array"
	];
	for [{private _i = 0 }, { _i < (count _textures_array) }, { _i = _i + 1 }] do {
		{
			_x setObjectTexture [0, "img\" + ((_textures_array select _i) select 0)]
		} forEach ((_textures_array select _i) select 1);
	};
};

pgn_fnc_create_markers_on_start = {
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

//actions
vgaragemonitor1 addAction ["Land vehicle", { [true,shed1] call prj_fnc_vehicle_shop_window }];
vgaragemonitor2 addAction ["Land vehicle", { [true,shed2] call prj_fnc_vehicle_shop_window }];
vgaragemonitor1a addAction ["Air vehicle", { [false,airdepotplace1] call prj_fnc_vehicle_shop_window }];
vgaragemonitor2a addAction ["Air vehicle", { [false,airdepotplace2] call prj_fnc_vehicle_shop_window }];
laptophq addAction ["HQ menu", { call prj_fnc_hq_menu }];

//textures
[
	[
		["vservice.paa",[board_vehservice_b,board_vehservice_r]],
		["inftp.paa",[infteleportB,infteleportR]],
		["landv.paa",[vgaragemonitor1,vgaragemonitor2]],
		["airv.paa",[vgaragemonitor1a,vgaragemonitor2a]]
	]
] call pgn_fnc_set_textures;

//markers
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
] call pgn_fnc_create_markers_on_start;