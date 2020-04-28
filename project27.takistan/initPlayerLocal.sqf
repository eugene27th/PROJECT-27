["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; // Initializes the player/client side Dynamic Groups framework

[] spawn {
	disableSerialization;
	waitUntil{ !isNull (findDisplay 46) };
	private _ctrlText2 = (findDisplay 46) ctrlCreate ["RscStructuredText",-1];
	private _sitrep2 = format ["<t font='PuristaMedium' align='right' size='0.75' shadow='0'><br /><br /><br /><br />%1 | PROJECT 27</t>",pr27ver];
	_ctrlText2 ctrlSetStructuredText parseText _sitrep2;
	_ctrlText2 ctrlSetTextColor [1,1,1,0.7];
	_ctrlText2 ctrlSetBackgroundColor [0,0,0,0];
	_ctrlText2 ctrlSetPosition [
		(safezoneW - 22 * (((safezoneW / safezoneH) min 1.2) / 40)) + (safeZoneX)
		,(safezoneH - 5.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + (safeZoneY)
		,20 * (((safezoneW / safezoneH) min 1.2) / 40)
		,5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
	];
	_ctrlText2 ctrlSetFade 0.5;
	_ctrlText2 ctrlCommit 0;
	true;
};

if (!isNull player) then {

	private ["_start_screen","_quotations","_arrayUIDs","_action"];

	_start_screen = [
		position Checkpoint2, 
		"WELCOME TO PROJECT 27", 
		50, 
		80, 
		0, 
		0, 
		[
			["\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa",[0,0.35,1,1],treatment_tr_b,1,1,0,"heal"],
			["\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",[0,0.35,1,1],vehserviceb,1,1,0,"repair/rearm"],
			["\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",[0,0.35,1,1],airserviceb_tr,1,1,0,"repair/rearm"],
			["\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa",[0,0.35,1,1],arsenalboxonbluebase,1,1,0,"arsenal"],
			["\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa",[0,0.35,1,1],infteleportB,1,1,0,"teleport"],
			["\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa",[0,0.35,1,1],laptophq,1,1,0,"HQ"],
			["\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",[0,0.35,1,1],vgaragemonitor2,1,1,0,"vehicles"],
			["\A3\ui_f\data\igui\cfg\simpleTasks\types\heli_ca.paa",[0,0.35,1,1],vgaragemonitor2a,1,1,0,"air vehicles"]
		], 
		0, 
		true, 
		20
	] spawn BIS_fnc_establishingShot;
	
	waitUntil {scriptDone _start_screen};

	player addEventHandler ["Killed", {
		_quotations = [
			"A_hub_quotation",
			"A_in_quotation",
			"A_in2_quotation",
			"A_m01_quotation",
			"A_m02_quotation",
			"A_m03_quotation",
			"A_m04_quotation",
			"A_m05_quotation",
			"A_out_quotation",
			"B_Hub01_quotation",
			"B_in_quotation",
			"B_m01_quotation",
			"B_m02_1_quotation",
			"B_m03_quotation",
			"B_m05_quotation",
			"B_m06_quotation",
			"B_out2_quotation",
			"C_EA_quotation",
			"C_EB_quotation",
			"C_in2_quotation",
			"C_m01_quotation",
			"C_m02_quotation",
			"C_out1_quotation"
		];
		["A3\missions_f_epa\video\" + selectRandom _quotations + ".ogv"] spawn BIS_fnc_playVideo;
	}];

	player setPos getMarkerPos "respawn_west";

	player setVariable ["money",0,true];
	player setVariable ["enemy_killings",0,true];
	player setVariable ["friend_killings",0,true];
	player setVariable ["civ_killings",0,true];

	//////////////// ACTIONS \\\\\\\\\\\\\\\\\
	_arrayUIDs = ["76561198141746661","76561198138702011","76561198343937417","76561198061237087"];
	
	if (!isNil "mhqterminal") then {call prj_fnc_add_mhq_action};
	
	if ((getPlayerUID player) in _arrayUIDs || player getVariable ["officer",false]) then {
		_action = [
			"hq_menu",
			"HQ",
			"\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa",
			{},
			{}
		] call ace_interact_menu_fnc_createAction;

		[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = [
			"cancel_task",
			"Cancel task",
			"\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa",
			{[player call BIS_fnc_taskCurrent] remoteExecCall ["prj_fnc_cancel_task",2]},
			{true}
		] call ace_interact_menu_fnc_createAction;

		[player, 1, ["ACE_SelfActions", "hq_menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = [
			"task_request",
			"Task request",
			"\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa",
			{remoteExecCall ["prj_fnc_create_task",2]},
			{true}
		] call ace_interact_menu_fnc_createAction;

		[player, 1, ["ACE_SelfActions", "hq_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
	};

	_action = ["Civil_Orders", "Civil Orders", "\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["Civil_Stop", "STOP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk4_ca.paa", {
		player playActionNow "gestureFreeze";
		[1,position player] remoteExecCall ["prj_fnc_civ_orders", 2];
	}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["Civil_Get_down", "DOWN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk3_ca.paa", {
		player playActionNow "gestureCover";
		[2,position player] remoteExecCall ["prj_fnc_civ_orders", 2];
	}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["Civil_Go_away", "GO AWAY", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk2_ca.paa", {
		player playActionNow "gestureGo";
		[3,position player] remoteExecCall ["prj_fnc_civ_orders", 2];
	}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["Civil_Hands_Up", "HANDS UP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk1_ca.paa", {
		player playActionNow "gestureFreeze";
		[4,position player] remoteExecCall ["prj_fnc_civ_orders", 2];
	}, {vehicle player isEqualTo player}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

	{
		_action = ["Civil_Go_Away", "GO AWAY", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk4_ca.paa", 
		{
			player playActionNow "gestureGo";
			if ((animationState (_this select 0)) == "amovpercmstpssurwnondnon") then {
				[_this select 0, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
			};
			(_this select 0) setUnitPos "UP";
			(group (_this select 0)) setSpeedMode "FULL";
			[_this select 0] call ace_interaction_fnc_sendAway;
		}, 
		{
			alive (_this select 0) && {[(_this select 0)] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
		}] call ace_interact_menu_fnc_createAction;
		[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

		_action = ["Civil_Down", "DOWN", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk3_ca.paa", 
		{
			player playActionNow "gestureCover";
			if ((animationState (_this select 0)) == "amovpercmstpssurwnondnon") then {
				[_this select 0, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
			};
			doStop (_this select 0);
			(_this select 0) setUnitPos "DOWN";
		}, 
		{
			alive (_this select 0) && {[_this select 0] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
		}] call ace_interact_menu_fnc_createAction;
		[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

		_action = ["Civil_Hands_Up", "HANDS UP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk2_ca.paa", 
		{
			player playActionNow "gestureFreeze";
			(_this select 0) setUnitPos "UP";
			doStop (_this select 0);
			[_this select 0, "AmovPercMstpSsurWnonDnon"] remoteExec ["playMove", 0];
		}, 
		{
			alive (_this select 0) && {[_this select 0] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
		}] call ace_interact_menu_fnc_createAction;
		[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

		_action = ["Civil_Stop", "STOP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk1_ca.paa", 
		{
			player playActionNow "gestureFreeze";
			doStop (_this select 0);
		}, 
		{
			alive (_this select 0) && {[_this select 0] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
		}] call ace_interact_menu_fnc_createAction;
		[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

		_action = ["Ask_Info", "ASK INFO", "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", 
		{
			[position (_this select 0),_this select 0] call prj_fnc_civ_info;
		}, 
		{
			alive (_this select 0) && {[_this select 0] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}
		}] call ace_interact_menu_fnc_createAction;
		[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

		//remove ace3 "get down" order
		[_x, 0, ["ACE_MainActions", "ACE_GetDown"]] call ace_interact_menu_fnc_removeActionFromClass;
		//remove ace3 "go away" order
		[_x, 0, ["ACE_MainActions", "ACE_SendAway"]] call ace_interact_menu_fnc_removeActionFromClass;

	} forEach ["LOP_Tak_Civ_Man_06","LOP_Tak_Civ_Man_08","LOP_Tak_Civ_Man_07","LOP_Tak_Civ_Man_05","LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_10","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_09","LOP_Tak_Civ_Man_11","LOP_Tak_Civ_Man_12","LOP_Tak_Civ_Man_04","LOP_Tak_Civ_Man_14","LOP_Tak_Civ_Man_13","LOP_Tak_Civ_Man_16","LOP_Tak_Civ_Man_15","LOP_CHR_Civ_Citizen_03","LOP_CHR_Civ_Citizen_04","LOP_CHR_Civ_Citizen_01","LOP_CHR_Civ_Citizen_02","LOP_CHR_Civ_Profiteer_02","LOP_CHR_Civ_Profiteer_03","LOP_CHR_Civ_Profiteer_01","LOP_CHR_Civ_Profiteer_04","LOP_CHR_Civ_Villager_01","LOP_CHR_Civ_Villager_04","LOP_CHR_Civ_Villager_03","LOP_CHR_Civ_Villager_02","LOP_CHR_Civ_Woodlander_01","LOP_CHR_Civ_Woodlander_02","LOP_CHR_Civ_Woodlander_03","LOP_CHR_Civ_Woodlander_04","LOP_CHR_Civ_Worker_03","LOP_CHR_Civ_Worker_04","LOP_CHR_Civ_Worker_01","LOP_CHR_Civ_Worker_02","C_man_p_fugitive_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_p_beggar_F","C_Story_Mechanic_01_F","C_Nikos"];

	//////////////// ARSENAL \\\\\\\\\\\\\\\\\
	{
		[_x, [
			"launch_B_Titan_short_tna_F","launch_B_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_short_ghex_F","launch_O_Titan_short_F","launch_B_Titan_tna_F","launch_B_Titan_F","launch_B_Titan_olive_F","launch_O_Titan_F","launch_O_Titan_ghex_F","launch_I_Titan_eaf_F","launch_I_Titan_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","H_HelmetO_ViperSP_ghex_F","H_HelmetO_ViperSP_hex_F","Laserdesignator_02_ghex_F","Laserdesignator_02","optic_Nightstalker","FirstAidKit","optic_DMS","optic_DMS_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_LRPS","optic_LRPS_tna_F","optic_LRPS_ghex_F","optic_NVS","ACE_optic_Hamr_2D","ACE_optic_Hamr_PIP","optic_tws","optic_tws_mg","ace_csw_staticGMGCarry","ace_csw_staticHMGCarry","ace_csw_staticATCarry","ace_csw_staticAACarry","H_HelmetIA","H_HelmetLeaderO_ocamo","H_HelmetO_ocamo","H_HelmetSpecO_ocamo","H_HelmetLeaderO_oucamo","H_HelmetO_oucamo","H_HelmetSpecO_blk","H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F","H_HelmetSpecO_ghex_F","H_HelmetLeaderO_ghex_F","H_HelmetO_ghex_F","H_HelmetHBK_headset_F","H_HelmetHBK_chops_F","H_HelmetHBK_ear_F","H_HelmetHBK_F","H_HelmetB_TI_tna_F","H_HelmetAggressor_F","H_HelmetAggressor_cover_F","H_HelmetAggressor_cover_taiga_F","H_HelmetCrew_I","H_HelmetCrew_O","H_HelmetCrew_B","G_Goggles_VR","U_I_Protagonist_VR","U_O_Protagonist_VR","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F","Laserdesignator_02","U_C_Protagonist_VR","U_O_V_Soldier_Viper_F","U_B_T_Sniper_F","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_rgr","U_O_T_Sniper_F","U_B_Protagonist_VR","U_I_GhillieSuit","U_O_GhillieSuit","U_B_GhillieSuit","U_O_V_Soldier_Viper_hex_F","V_PlateCarrierSpec_wdl","O_NVGoggles_hex_F","O_NVGoggles_urb_F","O_NVGoggles_ghex_F","O_NVGoggles_grn_F"]
		] call ace_arsenal_fnc_removeVirtualItems;
	} forEach [arsenalboxonbluebase,arsenalboxonredbase];	

	uiSleep 10;

	[[player call BIS_fnc_locationDescription,2,2],[getText(configFile >> "CfgWorlds" >> worldName >> "description"),2,2],[[daytime, "HH:MM"] call BIS_fnc_timeToString,2,2,5]] spawn BIS_fnc_EXP_camp_SITREP;

	uiSleep 17;
	[parseText "<t font='PuristaBold' size='1.6'>PROJECT 27</t><br />by eugene27", true, nil, 10, 2, 0] spawn BIS_fnc_textTiles;
};