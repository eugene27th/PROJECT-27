/*
	written by eugene27.
	global functions
*/

// vehicle shop ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_vehicle_shop_window = {
	params [
		"_vehiclearray","_spawnobject"
	];

	private _land_vehicles = [
		["Land_CanisterFuel_F",0,0],
		["ACE_Wheel",0,0],
		["ACE_Track",0,0],
		["B_supplyCrate_F",0,0],
		["rhsusf_mrzr4_d",0,0],
		["C_Quadbike_01_F",0,0],
		["C_Hatchback_01_F",0,0],
		["C_Hatchback_01_sport_F",0,0],
		["C_Offroad_01_covered_F",0,0],
		["C_Offroad_01_F",0,0],
		["C_Offroad_02_unarmed_F",0,0],
		["C_SUV_01_F",0,0],
		["C_Van_01_transport_F",0,0],
		["rhs_uaz_vdv",0,0],
		["rhs_uaz_open_vdv",0,0],
		["C_Van_01_box_F",0,0],
		["C_Van_02_transport_F",0,0],
		["C_Van_02_vehicle_F",0,0],
		["C_Truck_02_transport_F",60,0],
		["RHS_Ural_Open_Civ_01",60,0],
		["RHS_Ural_Civ_01",60,0],
		["B_LSV_01_unarmed_F",70,0],
		["O_LSV_02_unarmed_F",70,0],
		["rhsusf_m998_d_2dr",100,0],
		["rhsusf_m998_w_2dr",100,0],
		["rhsusf_m998_d_2dr_halftop",100,0],
		["rhsusf_m998_w_2dr_halftop",100,0],
		["rhsusf_m998_d_2dr_fulltop",100,0],
		["rhsusf_m998_w_2dr_fulltop",100,0],
		["rhsusf_m998_d_4dr",100,0],
		["rhsusf_m998_w_4dr",100,0],
		["rhsusf_m998_d_4dr_halftop",100,0],
		["rhsusf_m998_w_4dr_halftop",100,0],
		["rhsusf_m998_d_4dr_fulltop",100,0],
		["rhsusf_m998_w_4dr_fulltop",100,0],
		["RHS_Ural_VDV_01",100,0],
		["RHS_Ural_Flat_VDV_01",120,0],
		["RHS_Ural_Open_VDV_01",120,0],
		["RHS_Ural_Open_Flat_VDV_01",120,0],
		["RHS_Ural_Fuel_VDV_01",120,0],
		["rhs_gaz66_vdv",120,0],
		["rhs_gaz66_flat_vdv",120,0],
		["rhs_gaz66o_vdv",120,0],
		["rhs_gaz66o_flat_vdv",120,0],
		["rhs_gaz66_r142_vdv",120,0],
		["rhs_gaz66_repair_vdv",120,0],
		["rhs_gaz66_ap2_vdv",120,0],
		["rhs_gaz66_ammo_vdv",120,0],
		["rhs_kamaz5350_vdv",120,0],
		["rhs_kamaz5350_flatbed_cover_vdv",120,0],
		["rhs_kamaz5350_open_vdv",120,0],
		["rhs_kamaz5350_flatbed_vdv",120,0],
		["rhs_zil131_vdv",120,0],
		["rhs_zil131_open_vdv",120,0],
		["rhs_zil131_flatbed_vdv",120,0],
		["rhsusf_M1084A1R_SOV_M2_d_fmtv_socom",120,0],
		["rhsusf_M1078A1R_SOV_M2_d_fmtv_socom",120,0],
		["rhsusf_M1078A1P2_WD_fmtv_usarmy",120,0],
		["rhsusf_M1078A1P2_WD_flatbed_fmtv_usarmy",120,0],
		["rhsusf_M1083A1P2_WD_fmtv_usarmy",120,0],
		["rhsusf_M1083A1P2_WD_flatbed_fmtv_usarmy",120,0],
		["rhsusf_M1084A1P2_WD_fmtv_usarmy",120,0],
		["rhsusf_M977A4_usarmy_wd",120,0],
		["rhsusf_M977A4_AMMO_usarmy_wd",120,0],
		["rhsusf_M977A4_REPAIR_usarmy_wd",120,0],
		["rhsusf_M978A4_usarmy_wd",120,0],
		["rhs_pts_vmf",200,0],
		["rhsusf_m1025_d",120,1],
		["rhsusf_m1025_w",120,1],
		["rhsusf_m1025_d_m2",250,1],
		["rhsusf_m1025_w_m2",250,1],
		["rhsusf_m1025_d_Mk19",250,1],
		["rhsusf_m1025_w_Mk19",250,1],
		["rhsusf_M1078A1P2_B_WD_fmtv_usarmy",280,1],
		["rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy",280,1],
		["rhsusf_M1078A1P2_B_M2_WD_flatbed_fmtv_usarmy",280,1],
		["rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy",280,1],
		["rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy",280,1],
		["rhsusf_M1083A1P2_B_WD_fmtv_usarmy",280,1],
		["rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy",280,1],
		["rhsusf_M1083A1P2_B_WD_flatbed_fmtv_usarmy",280,1],
		["rhsusf_M1083A1P2_B_M2_WD_flatbed_fmtv_usarmy",280,1],
		["rhsusf_M1084A1P2_B_WD_fmtv_usarmy",280,1],
		["rhsusf_M1084A1P2_B_M2_WD_fmtv_usarmy",280,1],
		["rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy",280,1],
		["rhsusf_M977A4_BKIT_usarmy_wd",280,1],
		["rhsusf_M977A4_REPAIR_BKIT_usarmy_wd",280,1],
		["rhsusf_M978A4_BKIT_usarmy_wd",280,1],
		["rhsusf_M977A4_AMMO_BKIT_usarmy_wd",280,1],
		["rhsusf_m1043_d",300,1],
		["rhsusf_m1043_w",300,1],
		["rhs_tigr_vdv",300,1],
		["rhs_tigr_3camo_vdv",300,1],
		["rhs_typhoon_vdv",300,1],
		["rhs_tigr_m_vdv",320,1],
		["rhs_tigr_m_3camo_vdv",320,1],
		["rhsusf_CGRCAT1A2_usmc_wd",400,1],
		["rhsusf_M1238A1_socom_d",400,1],
		["rhsusf_M1239_socom_d",400,1],
		["rhsusf_M1239_M2_deploy_socom_d",400,1],
		["rhsusf_M1220_usarmy_d",400,1],
		["rhsusf_M1220_usarmy_wd",400,1],
		["rhsusf_M1220_MK19_usarmy_d",400,1],
		["rhsusf_M1220_MK19_usarmy_wd",400,1],
		["rhsusf_M1230a1_usarmy_d",400,1],
		["rhsusf_M1230a1_usarmy_wd",400,1],
		["rhsusf_M1232_usarmy_d",400,1],
		["rhsusf_M1232_usarmy_wd",400,1],
		["rhsusf_m1240a1_usarmy_d",400,1],
		["rhsusf_m1043_d_m2",500,1],
		["rhsusf_m1043_w_m2",500,1],
		["rhsusf_m1043_d_mk19",500,1],
		["rhsusf_m1043_w_mk19",500,1],
		["rhs_tigr_sts_vdv",500,1],
		["rhs_tigr_sts_3camo_vdv",500,1],
		["rhsusf_M977A4_BKIT_M2_usarmy_wd",500,1],
		["rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd",500,1],
		["rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd",500,1],
		["rhsusf_m113_usarmy_unarmed",550,1],
		["rhsusf_m113d_usarmy_unarmed",550,1],
		["rhsusf_CGRCAT1A2_M2_usmc_wd",580,1],
		["rhsusf_CGRCAT1A2_Mk19_usmc_wd",580,1],
		["rhsusf_M1238A1_M2_socom_d",600,1],
		["rhsusf_M1238A1_Mk19_socom_d",600,1],
		["rhsusf_M1239_M2_socom_d",600,1],
		["rhsusf_M1239_MK19_socom_d",600,1],
		["rhsusf_M1220_M153_M2_usarmy_d",600,1],
		["rhsusf_M1220_M153_M2_usarmy_wd",600,1],
		["rhsusf_M1220_M2_usarmy_d",600,1],
		["rhsusf_M1220_M2_usarmy_wd",600,1],
		["rhsusf_M1220_M153_MK19_usarmy_d",600,1],
		["rhsusf_M1220_M153_MK19_usarmy_wd",600,1],
		["rhsusf_M1239_MK19_deploy_socom_d",650,1],
		["rhsusf_M1230_M2_usarmy_d",650,1],
		["rhsusf_M1230_M2_usarmy_wd",650,1],
		["rhsusf_M1230_MK19_usarmy_d",650,1],
		["rhsusf_M1230_MK19_usarmy_wd",650,1],
		["rhsusf_M1232_M2_usarmy_d",650,1],
		["rhsusf_M1232_M2_usarmy_wd",650,1],
		["rhsusf_M1232_MK19_usarmy_d",650,1],
		["rhsusf_M1232_MK19_usarmy_wd",650,1],
		["rhsusf_M1237_M2_usarmy_d",650,1],
		["rhsusf_M1237_M2_usarmy_wd",650,1],
		["rhsusf_M1237_MK19_usarmy_d",650,1],
		["rhsusf_M1237_MK19_usarmy_wd",650,1],
		["rhsusf_m113_usarmy_supply",700,1],
		["rhsusf_m113d_usarmy_supply",700,1],
		["rhsusf_m1240a1_m2_usarmy_d",750,1],
		["rhsusf_m1240a1_m2_usarmy_wd",750,1],
		["rhsusf_m1240a1_m240_usarmy_d",750,1],
		["rhsusf_m1240a1_m240_usarmy_wd",750,1],
		["rhsusf_m1240a1_mk19_usarmy_d",750,1],
		["rhsusf_m1240a1_mk19_usarmy_wd",750,1],
		["rhsusf_m113_usarmy_M240",750,2],
		["rhsusf_m113_usarmy_MK19",750,2],
		["rhsusf_m113d_usarmy_M240",750,2],
		["rhsusf_m113d_usarmy_MK19",750,2],
		["rhsusf_M1117_d",750,2],
		["rhsusf_M1117_O",750,2],
		["rhsusf_M1117_W",750,2],
		["rhsusf_m1240a1_m2crows_usarmy_d",750,2],
		["rhsusf_m1240a1_m2crows_usarmy_wd",750,2],
		["rhsusf_m1240a1_mk19crows_usarmy_d",750,2],
		["rhsusf_m1240a1_mk19crows_usarmy_wd",750,2],
		["rhsusf_m113_usarmy",760,2],
		["rhsusf_m113d_usarmy",760,2],
		["rhsgref_BRDM2_vdv",770,2],
		["rhs_btr60_vdv",770,2],
		["rhs_btr70_vdv",780,2],
		["rhsusf_m966_w",800,2],
		["rhsusf_m1245_m2crows_socom_deploy",800,2],
		["rhsusf_m1245_mk19crows_socom_deploy",800,2],
		["rhsgref_BRDM2_ATGM_vdv",800,2],
		["rhs_btr80_vdv",800,2],
		["rhsusf_stryker_m1126_m2_d",800,3],
		["rhsusf_stryker_m1126_m2_wd",800,3],
		["rhs_prp3_tv",800,3],
		["rhs_brm1k_tv",810,3],
		["rhs_bmp1_tv",830,3],
		["rhs_bmp1k_tv",830,3],
		["rhs_btr80a_vdv",850,3],
		["rhsusf_m1045_w",870,3],
		["rhs_bmp1d_tv",880,3],
		["rhs_bmp1p_tv",900,3],
		["rhs_zsu234_aa",900,3],
		["rhs_bmp2e_tv",1000,4],
		["rhs_bmp2_tv",1000,4],
		["rhs_bmp2k_tv",1000,4],
		["rhs_bmp2d_tv",1150,4],
		["rhs_bmd4_vdv",1200,4],
		["rhs_bmd4m_vdv",1200,4],
		["rhs_bmd4ma_vdv",1280,4],
		["RHS_M2A2_wd",1350,5],
		["RHS_M2A2",1350,5],
		["RHS_M2A3_wd",1350,5],
		["RHS_M2A3",1350,5],
		["RHS_M6_wd",1350,5],
		["RHS_M6",1350,5],
		["rhs_sprut_vdv",1012,5],
		["rhs_t72ba_tv",1650,6],
		["rhs_t80",1650,6],
		["rhs_t72bb_tv",1690,6],
		["rhs_t72bc_tv",1750,6],
		["rhs_t90_tv",1750,6],
		["RHS_M2A2_BUSKI_WD",1750,6],
		["RHS_M2A2_BUSKI",1750,6],
		["RHS_M2A3_BUSKI_wd",1750,6],
		["RHS_M2A3_BUSKI",1750,6],
		["rhs_t80b",1750,6],
		["rhs_t80bk",1750,6],
		["RHS_M2A3_BUSKIII_wd",1800,6],
		["RHS_M2A3_BUSKIII",1800,6],
		["rhs_t80a",1800,6],
		["rhs_t80bv",1800,6],
		["rhs_t80bvk",1800,6],	
		["rhs_t80u",1850,6],
		["rhs_t80u45m",1850,6],
		// появилась агава
		["rhs_t80um",2000,7],
		["rhs_t80uk",2000,7],
		//
		["rhs_t80ue1",2100,7],
		["rhs_t90a_tv",2100,7],
		["rhsusf_m1a1hc_wd",2100,7],
		["rhs_t72bd_tv",2200,7],
		["rhsusf_m1a1fep_wd",2200,7],
		["rhsusf_m1a1fep_od",2200,7],
		["rhs_t72be_tv",2300,8],
		["rhsusf_m1a1aimwd_usarmy",2300,8],
		["rhsusf_m1a1aimd_usarmy",2300,8],
		["rhs_t90saa_tv",2400,8],
		["rhsusf_m1a2sep1d_usarmy",2400,8],
		["rhsusf_m1a2sep1wd_usarmy",2400,8],
		["rhs_t90sab_tv",2500,9],
		["rhsusf_m1a1aim_tuski_d",2500,9],
		["rhsusf_m1a1aim_tuski_wd",2500,9],
		["rhs_t90am_tv",2600,9],
		["rhsusf_m1a2sep1tuskid_usarmy",2600,10],
		["rhsusf_m1a2sep1tuskiwd_usarmy",2600,10],
		["rhs_t90sm_tv",2650,10],
		["rhsusf_m1a2sep1tuskiiwd_usarmy",2700,10],
		["rhsusf_m1a2sep1tuskiid_usarmy",2700,10],
		["rhs_t14_tv",2800,10]
	];
	private _air_vehicles = [
		["C_Plane_Civil_01_F",100,1],
		["C_Heli_Light_01_civil_F",200,1],
		["rhs_uh1h_hidf_unarmed",250,1],
		["RHS_Mi8t_civilian",270,1],
		["RHS_Mi8amt_civilian",270,1],
		["RHS_MELB_MH6M",300,1],
		["RHS_MELB_H6M",300,1],
		["RHS_Mi8mt_vvs",350,2],
		["RHS_Mi8mt_vvsc",350,2],
		["RHS_Mi8mt_Cargo_vvs",380,2],
		["RHS_Mi8mt_Cargo_vvsc",380,2],
		["RHS_Mi8AMT_vvs",400,2],
		["RHS_Mi8AMT_vvsc",400,2],
		["RHS_CH_47F_10",500,3],
		["RHS_CH_47F_light",500,3],
		["rhsusf_CH53E_USMC_d",500,3],
		["RHS_UH1Y_UNARMED_d",550,3],
		["RHS_UH60M2",580,4],
		["RHS_UH60M_MEV2",580,4],
		["RHS_C130J",600,4],
		["RHS_UH60M",630,4],
		["RHS_UH60M_ESSS2",650,4],
		["RHS_UH60M_ESSS",650,4],
		["rhs_ka60_grey",650,4],
		["rhs_ka60_c",650,4],
		["RHS_MELB_AH6M",650,4],
		["RHS_Mi8MTV3_vvs",680,5],
		["RHS_Mi8MTV3_vvsc",680,5],
		["RHS_UH1Y_FFAR_d",680,5],
		["RHS_UH1Y_d",700,5],
		["RHS_Mi8AMTSh_vvs",720,5],
		["RHS_Mi8AMTSh_vvsc",720,5],
		["RHS_Mi24P_vvs",800,6],
		["RHS_Mi24P_vvsc",800,6],
		["RHS_Mi24V_vvs",860,6],
		["RHS_Mi24V_vvsc",860,6],
		["rhs_mi28n_vvs",1400,7],
		["rhs_mi28n_vvsc",1400,7],
		["RHS_AH1Z",1012,7],
		["RHSGREF_A29B_HIDF",1012,7],
		["RHS_AH64D",1700,8],
		["RHS_AH64DGrey",1700,8],
		["RHS_Su25SM_vvs",1700,8],
		["RHS_Su25SM_vvsc",1700,8],
		["RHS_Ka52_vvsc",1800,9],
		["RHS_Ka52_vvs",1800,9],
		["RHS_A10",2000,9],
		["rhs_mig29s_vmf",2500,10],
		["rhs_mig29s_vvsc",2500,10],
		["rhs_mig29sm_vmf",2900,10],
		["rhs_mig29sm_vvsc",2900,10],
		["rhsusf_f22",3500,10],
		["RHS_T50_vvs_generic_ext",3500,10]
	];

	objectspawn = _spawnobject;

	createDialog "dialogVehicleShop";
	ctrlEnable [1008, false];

	private _money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	private _ctrl_money = (findDisplay 3002) displayCtrl 1011;
	private _text_money = "YOU HAVE: " + str _money;
	_ctrl_money ctrlSetText _text_money;
	_ctrl_money ctrlSetTextColor [0.2,0.7,0,1];

	private _ctrl_lb = (findDisplay 3002) displayCtrl 1012;

	lbAdd [1012, getText(configFile >> "CfgVehicles" >> "Land_dataTerminal_01_F" >> "displayName")];
	_ctrl_lb lbSetTextRight [0, "MHQ"];
	lbSetColorRight [1012, 0, [0.26, 0.44, 0.82, 1]];
	lbSetData [1012, 0, str (["Land_dataTerminal_01_F",0,0])];

	{
		if ((_x select 2) <= missionNamespace getVariable (if (_vehiclearray) then {"g_garage_level"} else {"a_garage_level"})) then {
			private _left_text = (getText(configFile >> "CfgVehicles" >> _x select 0 >> "displayName"));
			private _right_text = (if ((_x select 1) != 0) then {str (_x select 1)} else {"FREE"});
			lbAdd [1012, _left_text];
			_ctrl_lb lbSetTextRight [_forEachIndex + 1, _right_text];
			lbSetData [1012, _forEachIndex + 1, str _x];

			if ((_x select 1) != 0) then {
				if (_money < (_x select 1)) then {
					lbSetColorRight [1012, _forEachIndex + 1, [0.92, 0.13, 0.13, 1]];
				}
				else
				{
					lbSetColorRight [1012, _forEachIndex + 1, [0.04, 0.67, 0, 1]];
				};
			}
			else
			{
				lbSetColorRight [1012, _forEachIndex + 1, [0.82, 0.78, 0.04, 1]];
			};
		};
	} forEach (if (_vehiclearray) then {_land_vehicles} else {_air_vehicles});
};

prj_fnc_show_vehicle_picture = {
	private _ctrlprice = (findDisplay 3002) displayCtrl 1009;
	private _index = lbCurSel 1012;
	private _data = lbData [1012, _index];
	_data = call (compile _data);
	private _picture = getText(configfile >> "CfgVehicles" >> (_data select 0) >> "editorPreview");
	ctrlSetText [1013, _picture];
	ctrlSetText [1009, str (_data select 1)];

	ctrlSetText [1010, "LEVEL: " + str (_data select 2)];

	private _money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	if ((_data select 1) != 0) then {
		if (_money < (_data select 1)) then {
			ctrlSetText [1009, "LACKING AMOUNT: " + str ((_data select 1) - _money)];
			_ctrlprice ctrlSetTextColor [1, 0, 0, 1];
			ctrlEnable [1008, false];
			ctrlSetText [1008, "UNDERFUNDED"];
		}
		else
		{
			ctrlSetText [1009, "PRICE: " + str (_data select 1)];
			_ctrlprice ctrlSetTextColor [0, 1, 0, 1];
			ctrlEnable [1008, true];
			ctrlSetText [1008, "BUY"];
		};
	}
	else
	{
		ctrlSetText [1009, "FREE"];
		_ctrlprice ctrlSetTextColor [0, 1, 0, 1];
		ctrlEnable [1008, true];
		ctrlSetText [1008, "RECEIVE"];
	};
};

prj_fnc_spawn_vehicle = {
	closeDialog 2;

	private _index = lbCurSel 1012;
	private _data = lbData [1012, _index];
	_data = call (compile _data);

	private _checkplace = nearestObjects [position objectspawn,["landVehicle","Air","Ship"],12] select 0;
	if (!isNil "_checkplace") then {deleteVehicle _checkplace};

	private _vehicle = (_data select 0) createVehicle position objectspawn;
	_vehicle setDir (getDir objectspawn);

	if ((_data select 0) == "Land_DataTerminal_01_F") then {
		if (!isNil "mhqterminal") then {
			deleteVehicle mhqterminal
		};
		
		_vehicle setVehicleVarName "mhqterminal";
		missionNamespace setVariable ["mhqterminal", _vehicle, true];

		[_vehicle, 3] call ace_cargo_fnc_setSize; 
		[_vehicle, "blue", "orange", "green"] call BIS_fnc_DataTerminalColor;
		[_vehicle, true, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable;

		remoteExecCall ["prj_fnc_add_mhq_action"];
	};

	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;

	["missionNamespace", getPlayerUID player, "money", 0, -(_data select 1)] call prj_fnc_changePlayerVariable;
};

// hq menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_hq_menu = {
	private _dialog_hq = createDialog "dialogHQmenu";

	private _enemy = ((missionNamespace getVariable (getPlayerUID player)) select 1) select 1;
	private _friend = ((missionNamespace getVariable (getPlayerUID player)) select 2) select 1;
	private _civ = ((missionNamespace getVariable (getPlayerUID player)) select 3) select 1;

	private _stats_text = localize "STR_PRJ_STATISTICS_KILLED" + ":<br/>" + localize "STR_PRJ_STATISTICS_ENEMIES" + ": " + str _enemy + "<br/>" + localize "STR_PRJ_STATISTICS_FRIENDLY" + ": " + str _friend + "<br/>" + localize "STR_PRJ_STATISTICS_CIVILIANS" + ": " + str _civ + "<br/>";

	private _stat_p = (_enemy * 10) - (_friend * 50) - (_civ * 25);

	private _ctrl_name = (findDisplay 3000) displayCtrl 1001;

	private ["_picture"];

	switch (true) do {
		case (_stat_p >= 250) : {
			_picture = "img\icons\icon_smile_good_g.paa";
			_ctrl_name ctrlSetTextColor [0.18, 0.48, 0.08, 1];
		};
		case (_stat_p >= 50) : {
			_picture = "img\icons\icon_smile_good_y.paa";
			_ctrl_name ctrlSetTextColor [0.25, 0.82, 0.07, 1];
		};
		case (_stat_p <= -300) : {
			_picture = "img\icons\icon_smile_wtf.paa";
			_ctrl_name ctrlSetTextColor [0.37, 0.13, 0.13, 1];
			};
		case (_stat_p <= -150) : {
			_picture = "img\icons\icon_smile_bad_r.paa";
			_ctrl_name ctrlSetTextColor [0.61, 0.16, 0.16, 1];
		};
		case (_stat_p <= -20) : {
			_picture = "img\icons\icon_smile_bad_y.paa";
			_ctrl_name ctrlSetTextColor [0.82, 0.45, 0.07, 1];
		};
		case (_stat_p < 50) : {
			_picture = "img\icons\icon_smile_n.paa";
			_ctrl_name ctrlSetTextColor [0.82, 0.76, 0.07, 1];
		};
	};
	ctrlSetText [1029, _picture];

	private _ctrl = (findDisplay 3000) displayCtrl 1002;
	_ctrl ctrlSetStructuredText parseText _stats_text;
	_ctrl ctrlSetTextColor [0.8, 0.8, 0, 1];

	ctrlSetText [1001, toUpper (name player)];
};

prj_fnc_tpmhq = {
	if (isNil "mhqterminal") exitWith {hint "MHQ is not exist"};

	if ((mhqterminal animationPhase "lid_rot_1") != 0) then {
		player setposATL ((getpos mhqterminal) findEmptyPosition [ 0 , 15 , "B_soldier_F" ]);
		closeDialog 2;
	}
	else
	{
		hint "MHQ is not deployed";
	};
};

// bank menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_bank_menu = {
	private _dialog_bank = createDialog "dialogBankMenu";

	private _ctrl = (findDisplay 3001) displayCtrl 1007;

	private _money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	ctrlSetText [1007, str _money];

	if (_money >= 0) then {
		_ctrl ctrlSetTextColor [0.2, 0.7, 0.18, 1];
	}
	else
	{
		_ctrl ctrlSetTextColor [0.82, 0.17, 0.17, 1];
	};

	ctrlEnable [1005, false];

	{
		lbAdd [1003, name _x];
		lbSetData [1003, _forEachIndex, getPlayerUID _x];
	} forEach allPlayers - (entities "HeadlessClient_F");
};

prj_fnc_transfer_points = {
	params ["_player","_value"];

	if ((getPlayerUID player) in _player) then {
		["missionNamespace", getPlayerUID player, "money", 0, _value] call prj_fnc_changePlayerVariable;
		hint format [localize "STR_PRJ_GET_POINTS",_value];
	};
};

prj_fnc_btn_transfer_points = {
	private _index = lbCurSel 1003;
	private _player = lbData [1003, _index];
	_player = [_player];
	private _value = parseNumber (ctrlText 1004);
	private _money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	if (_value isEqualTo 0) exitWith {hint localize "STR_PRJ_NUMBER_OF_POINTS"};
	if (_value > _money) exitWith {hint localize "STR_PRJ_DONT_HAVE_POINTS"};
	if ((_value <= 0) || ((typeName _value) != "SCALAR" )) exitWith {hint localize "STR_PRJ_INVALID_VALUE"};

	_value = round _value;

	[_player,_value] remoteExec ["prj_fnc_transfer_points", 0];

	["missionNamespace", getPlayerUID player, "money", 0, -_value] call prj_fnc_changePlayerVariable;

	hint format [localize "STR_PRJ_SENT_POINTS",_value];

	_money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	private _ctrl = (findDisplay 3001) displayCtrl 1007;
	ctrlSetText [1007, str _money];

	if (_money >= 0) then {
		_ctrl ctrlSetTextColor [0.2, 0.7, 0.18, 1];
	}
	else
	{
		_ctrl ctrlSetTextColor [0.82, 0.17, 0.17, 1];
	};
};

prj_fnc_player_info = {
	ctrlEnable [1005, true];
};

// intel menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_intel_menu = {
	private _intel_objects = [
		["acex_intelitems_photo",5],
		["acex_intelitems_document",3],
		["ACE_Cellphone",2],
		["acex_intelitems_notepad",1]
	];

	createDialog "dialogIntelMenu";

	ctrlEnable [1019, false];

	private _office_table_items = [((getItemCargo office_table) select 0) + ((getMagazineCargo office_table) select 0),((getItemCargo office_table) select 1) + ((getMagazineCargo office_table) select 1)];

	private _intel_score = 0;
	private _lb_index = 0;

	for [{private _i = 0 }, { _i < (count _intel_objects) }, { _i = _i + 1 }] do {
		private _intel_index = (_office_table_items select 0) find ((_intel_objects select _i) select 0);
		if (_intel_index >= 0) then {
			private _intel_displayName = getText(configFile >> "CfgMagazines" >> (_office_table_items select 0) select _intel_index >> "displayName");
			if (_intel_displayName isEqualTo "") then {
				_intel_displayName = getText(configFile >> "CfgWeapons" >> (_office_table_items select 0) select _intel_index >> "displayName");
			};
			private _intel_number = (_office_table_items select 1) select _intel_index;
			_intel_score = _intel_score + (((_intel_objects select _i) select 1) * _intel_number * 10);
			_intel_text = "x" + str _intel_number + " " + _intel_displayName;
			lbAdd [1018, _intel_text];
			lbSetTooltip [1018, _lb_index, _intel_text];
			lbSetData [1018, _lb_index, str [(_office_table_items select 0) select _intel_index,_intel_number]];
			lbSetValue [1018, _lb_index, ((_intel_objects select _i) select 1)];
			_lb_index = _lb_index + 1;
		};
	};

	private _ctrl = (findDisplay 3004) displayCtrl 1020;
	private _text = "INTEL SCORE:<t size='1.2' color='#25E03F'> " + str (missionNamespace getVariable "intel_score") + "</t>";
	_ctrl ctrlSetStructuredText parseText _text;
};

prj_fnc_show_intel_trade = {
	ctrlEnable [1019, true];
	private _ctrlloadb = (findDisplay 3004) displayCtrl 1019;
	_ctrlloadb ctrlSetTextColor [0.8, 0.8, 0, 1];

	private _index = lbCurSel 1018;
	private _intels = lbData [1018, _index];
	private _intels = call (compile _intels);
	private _intel_score = lbValue [1018, _index];

	ctrlSetText [1019, "EXCHANGE / " + str ((_intel_score * (_intels select 1)) * 10)];
};

prj_fnc_intel_trade_btn = {
	ctrlEnable [1019, false];
	private _ctrlloadb = (findDisplay 3004) displayCtrl 1019;
	ctrlSetText [1019, "SELECT INTEL"];
	_ctrlloadb ctrlSetTextColor [0, 0, 0, 1];

	private _index = lbCurSel 1018;
	private _intels = lbData [1018, _index];
	private _intels = call (compile _intels);
	private _intel_score = lbValue [1018, _index];

	[missionNamespace,["intel_score",(missionNamespace getVariable "intel_score") + ((_intel_score * (_intels select 1)) * 10),true]] remoteExec ["setVariable",2];

	lbDelete [1018, _index];

	private _office_table_items = [((getItemCargo office_table) select 0) + ((getMagazineCargo office_table) select 0),((getItemCargo office_table) select 1) + ((getMagazineCargo office_table) select 1)];

	clearItemCargoGlobal office_table;
	clearMagazineCargoGlobal office_table;
	clearWeaponCargoGlobal office_table;
	clearBackpackCargoGlobal office_table;

	for [{private _i = 0 }, { _i < (count (_office_table_items select 0)) }, { _i = _i + 1 }] do {
		if !(((_office_table_items select 0) select _i) isEqualTo (_intels select 0)) then {
			office_table addItemCargoGlobal [((_office_table_items select 0) select _i), ((_office_table_items select 1) select _i)];
		};
	};

	private _ctrl_is = (findDisplay 3004) displayCtrl 1020;
	private _text_is = "INTEL SCORE:<t size='1.2' color='#25E03F'> " + str ((missionNamespace getVariable "intel_score") + ((_intel_score * (_intels select 1)) * 10)) + "</t>";
	_ctrl_is ctrlSetStructuredText parseText _text_is;
};

prj_fnc_upgrades_menu = {
	createDialog "dialogUpgradesMenu";

	ctrlEnable [1026, false];

	if !((getPlayerUID player) in hqUID || player getVariable ["officer",false]) then {
		{ctrlEnable [_x, false]} forEach [1027,1028];
	};

	private _ctrl_intel = (findDisplay 3006) displayCtrl 1025;
	private _text_intel = "INTEL SCORE: <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "intel_score") + "</t>";
	_ctrl_intel ctrlSetStructuredText parseText _text_intel;

	private _ctrl_arsenal = (findDisplay 3006) displayCtrl 1022;
	private _text_arsenal = "ARSENAL: <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "arsenal_level") + " LVL</t>";
	_ctrl_arsenal ctrlSetStructuredText parseText _text_arsenal;

	private _ctrl_a_grg = (findDisplay 3006) displayCtrl 1023;
	private _text_a_grg = "AIR GARAGE: <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "a_garage_level") + " LVL</t>";
	_ctrl_a_grg ctrlSetStructuredText parseText _text_a_grg;

	private _ctrl_g_grg = (findDisplay 3006) displayCtrl 1024;
	private _text_g_grg = "LAND GARAGE: <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "g_garage_level") + " LVL</t>";
	_ctrl_g_grg ctrlSetStructuredText parseText _text_g_grg;
};

prj_fnc_upgrade = {
	params [
		"_type"
	];

	private ["_variable","_upgrade_name","_next_level","_upgrade_name","_display_ctrl","_text"];

	switch (_type) do {
		case 1: {
			_variable = "arsenal_level";
			_next_level = (missionNamespace getVariable _variable) + 1;
			_upgrade_name = localize "STR_PRJ_ARSENAL";
			_display_ctrl = 1022;
			_text = "ARSENAL: <t size='1.2' color='#25E03F'>" + str _next_level + " LVL</t>";		
		};
		case 2: {
			_variable = "a_garage_level";
			_next_level = (missionNamespace getVariable _variable) + 1;
			_upgrade_name = localize "STR_PRJ_A_GARAGE";
			_display_ctrl = 1023;
			_text = "AIR GARAGE: <t size='1.2' color='#25E03F'>" + str _next_level + " LVL</t>";
		};
		case 3: {
			_variable = "g_garage_level";
			_next_level = (missionNamespace getVariable _variable) + 1;
			_upgrade_name = localize "STR_PRJ_G_GARAGE";
			_display_ctrl = 1024;
			_text = "LAND GARAGE: <t size='1.2' color='#25E03F'>" + str _next_level + " LVL</t>";
		};
	};

	private _intel_score = missionNamespace getVariable "intel_score";

	if (_intel_score < (_next_level * 100)) then {
		hint localize "STR_PRJ_DONT_HAVE_IS"
	}
	else
	{
		[missionNamespace,["intel_score",(_intel_score - (_next_level * 100)),true]] remoteExec ["setVariable",2];
		[missionNamespace,[_variable,_next_level,true]] remoteExec ["setVariable",2];

		hint format [localize "STR_PRJ_UPGRADED" + " " + _upgrade_name + " " + localize "STR_PRJ_TO_LEVEL",_next_level];

		private _ctrl_intel = (findDisplay 3006) displayCtrl 1025;
		private _text_intel = "INTEL SCORE: <t size='1.2' color='#25E03F'>" + str (_intel_score - (_next_level * 100)) + "</t>";
		_ctrl_intel ctrlSetStructuredText parseText _text_intel;

		private _ctrl = (findDisplay 3006) displayCtrl _display_ctrl;
		_ctrl ctrlSetStructuredText parseText _text;
	};
};

// option menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_option_menu = {
	createDialog "dialogOptionMenu";

	if !((getPlayerUID player) in hqUID || player getVariable ["officer",false]) then {
		ctrlEnable [1021, false];
	};
};

// vehicle service menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_vehicle_menu_window = {
	createDialog "dialogVehicleService";
	ctrlEnable [1015, false];

	showitems = {
		params ["_items"];

		for [{private _i = 0 }, { _i < (count _items) }, { _i = _i + 1 }] do {
			private _displayname = (_items # _i) # 0;
			lbAdd [1014, _displayname];
			lbSetTooltip [1014, _i, _displayname];
			lbSetData [1014, _i, str (_items # _i)];
		};
	};

	[
		[
			[
				"Medicine",
				[
					"ACE_adenosine",
					"ACE_epinephrine",
					"ACE_personalAidKit",
					"ACE_tourniquet",
					"ACE_bloodIV",
					"ACE_bloodIV_250",
					"ACE_bloodIV_500",
					"ACE_bodyBag",
					"ACE_morphine",
					"ACE_quikclot",
					"ACE_plasmaIV",
					"ACE_plasmaIV_250",
					"ACE_plasmaIV_500",
					"ACE_elasticBandage",
					"ACE_fieldDressing",
					"ACE_packingBandage",
					"ACE_salineIV",
					"ACE_salineIV_250",
					"ACE_salineIV_500",
					"ACE_surgicalKit",
					"ACE_splint"
				]
			],
			[
				"Explosives",
				[
					"DemoCharge_Remote_Mag",
					"SatchelCharge_Remote_Mag",
					"ATMine_Range_Mag",
					"APERSBoundingMine_Range_Mag",
					"APERSMine_Range_Mag",
					"ClaymoreDirectionalMine_Remote_Mag",
					"APERSMineDispenser_Mag",
					"MineDetector",
					"ACE_DefusalKit",
					"ACE_M26_Clacker"
				]
			],
			[
				"Food",
				[
					"ACE_Can_Franta",
					"ACE_Can_Spirit",
					"ACE_Can_RedGull",
					"ACE_WaterBottle",
					"ACE_Humanitarian_Ration",
					"ACE_MRE_CreamChickenSoup",
					"ACE_MRE_ChickenTikkaMasala",
					"ACE_MRE_ChickenHerbDumplings",
					"ACE_MRE_MeatballsPasta",
					"ACE_MRE_SteakVegetables",
					"ACE_MRE_CreamTomatoSoup",
					"ACE_MRE_BeefStew",
					"ACE_MRE_LambCurry",
					"ACE_Canteen"
				]
			],
			[
				"Misc",
				[
					"ACE_UAVBattery",
					"ACE_EarPlugs",	
					"ACE_IR_Strobe_Item",
					"ACE_CableTie",
					"ACE_wirecutter",
					"ACE_Sandbag_empty",
					"ToolKit",
					"ACE_EntrenchingTool",
					"ACE_Flashlight_XL50",
					"ACE_Flashlight_MX991",
					"B_AssaultPack_cbr"
				]
			],
			[
				"Tubes",
				[
					"rhs_weap_M136_hp",
					"rhs_weap_M136_hedp",
					"rhs_weap_M136",
					"rhs_weap_m72a7",
					"rhs_weap_rpg75",
					"rhs_weap_rpg26",
					"rhs_weap_rshg2",
					"rhs_weap_m80"
				]
			],
			[
				"Ammo",
				[
					"rhs_30Rnd_545x39_7N10_AK",
					"rhs_30Rnd_545x39_7N22_AK",
					"rhs_30Rnd_762x39mm_polymer",
					"rhs_30Rnd_762x39mm_polymer_89",
					"rhs_mag_30Rnd_556x45_M855A1_PMAG",
					"rhs_mag_30Rnd_556x45_Mk262_PMAG_Tan",
					"rhs_mag_30Rnd_556x45_Mk318_PMAG",
					"rhs_20rnd_9x39mm_SP5",
					"rhs_20rnd_9x39mm_SP6",
					"rhs_10Rnd_762x54mmR_7N1",
					"rhs_10Rnd_762x54mmR_7N14",
					"rhsusf_mag_10Rnd_STD_50BMG_M33",
					"rhsusf_mag_10Rnd_STD_50BMG_mk211",
					"rhssaf_10Rnd_792x57_m76_tracer",
					"rhsgref_10Rnd_792x57_m76",
					"rhsusf_10Rnd_762x51_m118_special_Mag",
					"rhsusf_10Rnd_762x51_m62_Mag",
					"rhsusf_10Rnd_762x51_m993_Mag",
					"rhsusf_20Rnd_762x51_m118_special_Mag",
					"rhsusf_20Rnd_762x51_m62_Mag",
					"rhsusf_20Rnd_762x51_m80_Mag",
					"rhsusf_20Rnd_762x51_m993_Mag",
					"rhs_mag_20Rnd_762x51_m61_fnfal",
					"rhs_mag_20Rnd_762x51_m62_fnfal",
					"rhs_mag_20Rnd_762x51_m80_fnfal",
					"rhs_mag_20Rnd_762x51_m80a1_fnfal",
					"rhs_mag_20Rnd_SCAR_762x51_m118_special_bk",
					"rhs_mag_20Rnd_SCAR_762x51_m61_ap_bk",
					"rhs_mag_20Rnd_SCAR_762x51_m62_tracer_bk",
					"rhs_mag_20Rnd_SCAR_762x51_m80_ball_bk",
					"rhs_mag_20Rnd_SCAR_762x51_m80a1_epr_bk",
					"rhs_mag_20Rnd_SCAR_762x51_mk316_special_bk",
					"rhs_45Rnd_545X39_7N22_AK",
					"rhs_45Rnd_545X39_7N10_AK",
					"rhs_100Rnd_762x54mmR",
					"rhs_100Rnd_762x54mmR_7BZ3",
					"rhs_100Rnd_762x54mmR_7N13",
					"rhs_100Rnd_762x54mmR_7N26",
					"rhs_100Rnd_762x54mmR_green",
					"rhsusf_200rnd_556x45_M855_box",
					"rhsusf_200Rnd_556x45_box",
					"rhsusf_20Rnd_762x51_SR25_m118_special_Mag",
					"rhsusf_20Rnd_762x51_SR25_m62_Mag",
					"rhsusf_20Rnd_762x51_SR25_m993_Mag",
					"rhsusf_20Rnd_762x51_SR25_mk316_special_Mag",
					"rhs_mag_30Rnd_556x45_Mk318_SCAR",
					"rhsusf_5Rnd_762x51_AICS_m118_special_Mag",
					"rhsusf_5Rnd_762x51_AICS_m62_Mag",
					"rhsusf_5Rnd_762x51_AICS_m993_Mag",
					"rhs_VOG25",
					"rhs_VG40TB",
					"rhs_VG40SZ",
					"rhs_VG40OP_white",
					"rhs_VG40OP_green",
					"rhs_VG40OP_red",
					"rhs_VOG25P",
					"rhsusf_mag_6Rnd_M397_HET",
					"rhsusf_mag_6Rnd_M433_HEDP",
					"rhsusf_mag_6Rnd_M716_yellow",
					"rhsusf_mag_6Rnd_M715_green",
					"rhsusf_mag_6Rnd_M714_white",
					"rhsusf_mag_6Rnd_m662_red",
					"rhsusf_mag_6Rnd_M713_red",
					"rhsusf_mag_6Rnd_m661_green",
					"rhsusf_mag_6Rnd_M585_white",
					"rhsusf_mag_6Rnd_m4009",
					"rhsusf_mag_6Rnd_M576_Buckshot",
					"rhs_mag_M397_HET",
					"rhs_mag_M433_HEDP",
					"ACE_HuntIR_M203",
					"ACE_40mm_Flare_white",
					"rhs_mag_m576",
					"rhs_mag_M585_white",
					"ACE_40mm_Flare_green",
					"rhs_mag_m661_green",
					"ACE_40mm_Flare_red",
					"rhs_mag_m662_red",
					"rhs_mag_m713_Red",
					"rhs_mag_m714_White",
					"rhs_mag_m715_Green",
					"rhs_mag_m716_yellow",
					"ACE_40mm_Flare_ir"
				]
			]
		]
	] call showitems;
};

prj_fnc_btn_load_enable = {
	ctrlEnable [1015, true];
	private _ctrlloadb = (findDisplay 3003) displayCtrl 1015;
	_ctrlloadb ctrlSetTextColor [0.8, 0.8, 0, 1];
};

prj_fnc_show_load_items = {
	lbClear 1017;

	private _index = lbCurSel 1014;
	private _items = lbData [1014, _index];
	private _items = call (compile _items);

	private _ctrlitemstext = (findDisplay 3003) displayCtrl 1017;

	{
		private _itemclass = getText(configFile >> "CfgVehicles" >> _x >> "displayName");

		if (_itemclass isEqualTo "") then {
			_itemclass = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
		};
		
		if (_itemclass isEqualTo "") then {
			_itemclass = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
		};

		lbAdd [1017, _itemclass];
		lbSetData [1017, _forEachIndex, _x];
	} forEach (_items # 1);
};

prj_fnc_load_item_to_cargo = {
	private _index = lbCurSel 1017;
	private _item = lbData [1017, _index];
	private _car = vehicle player;
	private _typeofitem = _item call BIS_fnc_itemType;

	switch (_typeofitem # 0) do {
		case "Item": {
			_car addItemCargoGlobal [_item,1];
		};
		case "Weapon": {
			_car addWeaponCargoGlobal [_item,1];
		};
		case "Equipment": {
			if ((_typeofitem  # 1) == "Backpack") then {
				_car addBackpackCargoGlobal [_item,1];
			}
			else
			{
				_car addItemCargoGlobal [_item,1];
			}
		};
		case "Magazine": {
			_car addMagazinecargoGlobal [_item,1];
		};
		case "Mine": {
			_car addMagazinecargoGlobal [_item,1];
		};
	};
};

prj_fnc_vehicle_repair = {
	private _object = vehicle player;
	private _type = typeOf _object;
	if (_object isKindOf "Man") exitWith {};
	_object setFuel 0;
	_object setVehicleAmmo 1;

	_object vehicleChat format ["Servicing vehicle. Please stand by.", _type];

	if (_object getVariable ["isDMM", false]) then {
		clearMagazineCargoGlobal _object;
		_object setDamage 0;
		_object setFuel 1;
	} else {
		private _magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
		if (count _magazines > 0) then {
			_removed = [];
			{
				if (!(_x in _removed)) then {
					_object removeMagazines _x;
					_removed = _removed + [_x];
				};
			} forEach _magazines;
			{
				_object addMagazine _x;
			} forEach _magazines;
		};

		private _count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");
		
		if (_count > 0) then {
			for "_i" from 0 to (_count - 1) do {
				scopeName "xx_reload2_xx";
				_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
				_magazines = getArray(_config >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
						_object removeMagazines _x;
						_removed = _removed + [_x];
					};
				} forEach _magazines;
				{
					_object addMagazine _x;
					
				} forEach _magazines;
				_count_other = count (_config >> "Turrets");
				if (_count_other > 0) then {
					for "_i" from 0 to (_count_other - 1) do {
						_config2 = (_config >> "Turrets") select _i;
						_magazines = getArray(_config2 >> "magazines");
						_removed = [];
						{
							if (!(_x in _removed)) then {
								_object removeMagazines _x;
								_removed = _removed + [_x];
							};
						} forEach _magazines;
						{	
							_object addMagazine _x;
							
						} forEach _magazines;
					};
				};
			};
		};
		_object setVehicleAmmo 1;
			
		_object setDamage 0;	
			
		_object setFuel 1;	
	};
	_object vehicleChat format ["Vehicle is ready.", _type];
};