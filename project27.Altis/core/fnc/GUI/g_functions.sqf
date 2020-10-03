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
		["C_Truck_02_transport_F",100,0],
		["RHS_Ural_Open_Civ_01",100,0],
		["RHS_Ural_Civ_01",100,0],
		["B_CTRG_LSV_01_light_F",100,0],
		["O_LSV_02_unarmed_F",100,0],
		["rhs_pts_vmf",150,0],
		["rhsusf_m998_d_2dr",200,0],
		["rhsusf_m998_w_2dr",200,0],
		["rhsusf_m998_d_2dr_halftop",200,0],
		["rhsusf_m998_w_2dr_halftop",200,0],
		["rhsusf_m998_d_2dr_fulltop",200,0],
		["rhsusf_m998_w_2dr_fulltop",200,0],
		["rhsusf_m998_d_4dr",200,0],
		["rhsusf_m998_w_4dr",200,0],
		["rhsusf_m998_d_4dr_halftop",200,0],
		["rhsusf_m998_w_4dr_halftop",200,0],
		["rhsusf_m998_d_4dr_fulltop",200,0],
		["rhsusf_m998_w_4dr_fulltop",200,0],
		["rhs_gaz66_vdv",200,0],
		["rhs_gaz66_flat_vdv",200,0],
		["rhs_gaz66o_vdv",200,0],
		["rhs_gaz66o_flat_vdv",200,0],
		["rhs_gaz66_r142_vdv",300,0],
		["rhs_gaz66_repair_vdv",300,0],
		["rhs_gaz66_ap2_vdv",300,0],
		["rhs_gaz66_ammo_vdv",300,0],
		["rhs_zil131_vdv",300,0],
		["rhs_zil131_open_vdv",300,0],
		["rhs_zil131_flatbed_vdv",300,0],
		["rhs_kamaz5350_vdv",400,0],
		["rhs_kamaz5350_flatbed_cover_vdv",400,0],
		["rhs_kamaz5350_open_vdv",400,0],
		["rhs_kamaz5350_flatbed_vdv",400,0],
		["RHS_Ural_VDV_01",400,0],
		["RHS_Ural_Flat_VDV_01",400,0],
		["RHS_Ural_Open_VDV_01",400,0],
		["RHS_Ural_Open_Flat_VDV_01",400,0],
		["RHS_Ural_Fuel_VDV_01",400,0],
		["rhsusf_M1084A1R_SOV_M2_d_fmtv_socom",400,0],
		["rhsusf_M1078A1R_SOV_M2_d_fmtv_socom",400,0],
		["rhsusf_M1078A1P2_WD_fmtv_usarmy",400,0],
		["rhsusf_M1078A1P2_WD_flatbed_fmtv_usarmy",400,0],
		["rhsusf_M1083A1P2_WD_fmtv_usarmy",400,0],
		["rhsusf_M1083A1P2_WD_flatbed_fmtv_usarmy",400,0],
		["rhsusf_M1084A1P2_WD_fmtv_usarmy",400,0],
		["rhsusf_M977A4_usarmy_wd",500,0],
		["rhsusf_M977A4_AMMO_usarmy_wd",500,0],
		["rhsusf_M977A4_REPAIR_usarmy_wd",500,0],
		["rhsusf_M978A4_usarmy_wd",500,0],
		["B_G_Offroad_01_repair_F",500,0],
		["B_G_Van_01_fuel_F",600,0],
		["rhsusf_m1025_d",600,1],
		["rhsusf_m1025_w",600,1],
		["rhsusf_m1025_d_m2",650,1],
		["rhsusf_m1025_w_m2",650,1],
		["rhsusf_m1025_d_Mk19",700,1],
		["rhsusf_m1025_w_Mk19",700,1],
		["O_T_Truck_02_fuel_F",800,1],
		["rhsusf_M1078A1P2_B_WD_fmtv_usarmy",900,1],
		["rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy",900,1],
		["rhsusf_M1078A1P2_B_M2_WD_flatbed_fmtv_usarmy",900,1],
		["rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy",900,1],
		["rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy",900,1],
		["rhsusf_M1083A1P2_B_WD_fmtv_usarmy",1000,1],
		["rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy",1000,1],
		["rhsusf_M1083A1P2_B_WD_flatbed_fmtv_usarmy",1000,1],
		["rhsusf_M1083A1P2_B_M2_WD_flatbed_fmtv_usarmy",1000,1],
		["rhsusf_M1084A1P2_B_WD_fmtv_usarmy",1000,1],
		["rhsusf_M1084A1P2_B_M2_WD_fmtv_usarmy",1000,1],
		["rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy",1000,1],
		["rhsusf_M977A4_BKIT_usarmy_wd",1300,1],
		["rhsusf_M977A4_REPAIR_BKIT_usarmy_wd",1300,1],
		["rhsusf_M978A4_BKIT_usarmy_wd",1300,1],
		["rhsusf_M977A4_AMMO_BKIT_usarmy_wd",1300,1],
		["rhsusf_m1043_d",1500,1],
		["rhsusf_m1043_w",1500,1],
		["rhs_tigr_vdv",1500,1],
		["rhs_tigr_3camo_vdv",1500,1],
		["rhs_typhoon_vdv",1500,1],
		["rhs_tigr_m_vdv",1500,1],
		["rhs_tigr_m_3camo_vdv",1500,1],
		["rhsusf_CGRCAT1A2_usmc_wd",1500,1],
		["rhsusf_M1238A1_socom_d",1500,1],
		["rhsusf_M1239_socom_d",1500,1],
		["rhsusf_M1239_M2_deploy_socom_d",1500,1],
		["rhsusf_M1220_usarmy_d",1500,1],
		["rhsusf_M1220_usarmy_wd",1500,1],
		["rhsusf_M1220_MK19_usarmy_d",1500,1],
		["rhsusf_M1220_MK19_usarmy_wd",1500,1],
		["rhsusf_M1230a1_usarmy_d",1500,1],
		["rhsusf_M1230a1_usarmy_wd",1500,1],
		["rhsusf_M1232_usarmy_d",1500,1],
		["rhsusf_M1232_usarmy_wd",1500,1],
		["rhsusf_m1240a1_usarmy_d",1500,1],
		["LOP_NK_T34",1500,1],
		["rhsusf_m1043_d_m2",1700,1],
		["rhsusf_m1043_w_m2",1700,1],
		["rhsusf_m1043_d_mk19",1700,1],
		["rhsusf_m1043_w_mk19",1700,1],
		["rhs_tigr_sts_vdv",1700,1],
		["rhs_tigr_sts_3camo_vdv",1700,1],	
		["rhsusf_M977A4_BKIT_M2_usarmy_wd",1800,1],
		["rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd",1800,1],
		["rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd",1800,1],
		["rhsusf_m113_usarmy_unarmed",2100,1],
		["rhsusf_m113d_usarmy_unarmed",2100,1],
		["rhsusf_CGRCAT1A2_M2_usmc_wd",2100,1],
		["rhsusf_CGRCAT1A2_Mk19_usmc_wd",2100,1],
		["rhsusf_M1238A1_M2_socom_d",2300,1],
		["rhsusf_M1238A1_Mk19_socom_d",2300,1],
		["rhsusf_M1239_M2_socom_d",2500,1],
		["rhsusf_M1239_MK19_socom_d",2500,1],
		["rhsusf_M1220_M153_M2_usarmy_d",2500,1],
		["rhsusf_M1220_M153_M2_usarmy_wd",2500,1],
		["rhsusf_M1220_M2_usarmy_d",2700,1],
		["rhsusf_M1220_M2_usarmy_wd",2700,1],
		["rhsusf_M1220_M153_MK19_usarmy_d",2700,1],
		["rhsusf_M1220_M153_MK19_usarmy_wd",2700,1],
		["rhsusf_M1239_MK19_deploy_socom_d",2700,1],
		["rhsusf_M1230_M2_usarmy_d",2900,1],
		["rhsusf_M1230_M2_usarmy_wd",2900,1],
		["rhsusf_M1230_MK19_usarmy_d",2900,1],
		["rhsusf_M1230_MK19_usarmy_wd",2900,1],
		["rhsusf_M1232_M2_usarmy_d",3000,1],
		["rhsusf_M1232_M2_usarmy_wd",3000,1],
		["rhsusf_M1232_MK19_usarmy_d",3000,1],
		["rhsusf_M1232_MK19_usarmy_wd",3000,1],
		["rhsusf_M1237_M2_usarmy_d",3200,1],
		["rhsusf_M1237_M2_usarmy_wd",3200,1],
		["rhsusf_M1237_MK19_usarmy_d",3200,1],
		["rhsusf_M1237_MK19_usarmy_wd",3200,1],
		["rhsusf_m113_usarmy_supply",3200,1],
		["rhsusf_m113d_usarmy_supply",3200,1],
		["rhsusf_m1240a1_m240_usarmy_d",3400,1],
		["rhsusf_m1240a1_m240_usarmy_wd",3400,1],
		["rhsusf_m1240a1_m2_usarmy_d",3500,1],
		["rhsusf_m1240a1_m2_usarmy_wd",3500,1],
		["rhsusf_m1240a1_mk19_usarmy_d",3600,1],
		["rhsusf_m1240a1_mk19_usarmy_wd",3600,1],
		["rhsusf_m113_usarmy_M240",3600,2],
		["rhsusf_m113_usarmy_MK19",3600,2],
		["rhsusf_m113d_usarmy_M240",3600,2],
		["rhsusf_m113d_usarmy_MK19",3600,2],
		["rhsusf_M1117_d",3700,2],
		["rhsusf_M1117_O",3700,2],
		["rhsusf_M1117_W",3700,2],
		["rhsusf_m1240a1_m2crows_usarmy_d",4000,2],
		["rhsusf_m1240a1_m2crows_usarmy_wd",4000,2],
		["rhsusf_m1240a1_mk19crows_usarmy_d",4000,2],
		["rhsusf_m1240a1_mk19crows_usarmy_wd",4000,2],
		["rhsusf_m113_usarmy",4000,2],
		["rhsusf_m113d_usarmy",4000,2],
		["rhsgref_BRDM2_vdv",4000,2],
		["rhs_btr60_vdv",4000,2],
		["rhs_btr70_vdv",4200,2],
		["rhsusf_m966_w",4300,2],
		["rhsusf_m1245_m2crows_socom_deploy",4500,2],
		["rhsusf_m1245_mk19crows_socom_deploy",4500,2],
		["rhs_btr80_vdv",5000,2],
		["rhsusf_stryker_m1126_m2_wd",5500,3],
		["rhsusf_stryker_m1127_m2_wd",5500,3],	
		["rhs_prp3_tv",5500,3],
		["rhs_brm1k_tv",5700,3],
		["rhs_bmp1_tv",5700,3],
		["rhs_bmp1k_tv",5700,3],
		["rhsgref_BRDM2_ATGM_vdv",5700,2],
		["rhsusf_stryker_m1126_mk19_wd",5700,3],
		["rhs_btr80a_vdv",5700,3],
		["rhsusf_m1045_w",5800,3],
		["rhs_bmp1d_tv",6000,3],
		["rhs_bmp1p_tv",6000,3],
		["rhsusf_stryker_m1132_m2_wd",6500,4],
		["rhsusf_stryker_m1134_wd",6500,4],
		["rhs_zsu234_aa",6500,3],
		["rhs_bmp2e_tv",7000,4],
		["rhs_bmp2_tv",7000,4],
		["rhs_bmp2k_tv",7000,4],
		["rhs_bmp2d_tv",7000,4],
		["LOP_NK_T55",7200,4],
		["rhs_bmd4_vdv",9000,4],
		["rhs_bmd4m_vdv",9000,4],
		["rhs_bmd4ma_vdv",9000,4],
		["RHS_M2A2_wd",9000,5],
		["RHS_M2A2",9000,5],
		["RHS_M2A3_wd",9000,5],
		["RHS_M2A3",9000,5],
		["RHS_M6_wd",9000,5],
		["RHS_M6",9000,5],
		["rhs_sprut_vdv",9000,5],
		["rhs_t72ba_tv",10000,6],
		["rhs_t80",10000,6],
		["rhs_t72bb_tv",10000,6],
		["rhs_t72bc_tv",10000,6],
		["rhs_t90_tv",10000,6],
		["RHS_M2A2_BUSKI_WD",10000,6],
		["RHS_M2A2_BUSKI",10000,6],
		["RHS_M2A3_BUSKI_wd",10000,6],
		["RHS_M2A3_BUSKI",10000,6],
		["rhs_t80b",12000,6],
		["rhs_t80bk",12000,6],
		["RHS_M2A3_BUSKIII_wd",12000,6],
		["RHS_M2A3_BUSKIII",12000,6],
		["rhs_t80a",12000,6],
		["rhs_t80bv",12400,6],
		["rhs_t80bvk",12700,6],	
		["rhs_t80u",13000,6],
		["rhs_t80u45m",13000,6],
		// появилась агава
		["rhs_t80um",14000,7],
		["rhs_t80uk",14000,7],
		//
		["rhs_t80ue1",14000,7],
		["rhs_t90a_tv",14000,7],
		["rhsusf_m1a1hc_wd",14000,7],
		["rhs_t72bd_tv",14500,7],
		["rhsusf_m1a1fep_wd",14500,7],
		["rhsusf_m1a1fep_od",14500,7],
		["rhs_t72be_tv",14800,8],
		["rhsusf_m1a1aimwd_usarmy",15000,8],
		["rhsusf_m1a1aimd_usarmy",15000,8],
		["rhs_t90saa_tv",15000,8],
		["rhsusf_m1a2sep1d_usarmy",15000,8],
		["rhsusf_m1a2sep1wd_usarmy",15000,8],
		["rhs_t90sab_tv",15500,9],
		["rhsusf_m1a1aim_tuski_d",15500,9],
		["rhsusf_m1a1aim_tuski_wd",15500,9],
		["rhs_t90am_tv",15500,9],
		["rhsusf_m1a2sep1tuskid_usarmy",15500,10],
		["rhsusf_m1a2sep1tuskiwd_usarmy",15500,10],
		["rhs_t90sm_tv",15500,10],
		["rhsusf_m1a2sep1tuskiiwd_usarmy",16000,10],
		["rhsusf_m1a2sep1tuskiid_usarmy",16000,10],
		["rhs_t14_tv",16000,10]
	];
	private _air_vehicles = [
		["C_Plane_Civil_01_F",1000,1],
		["C_Heli_Light_01_civil_F",2000,1],
		["rhs_uh1h_hidf_unarmed",2500,1],
		["RHS_Mi8t_civilian",2700,1],
		["RHS_Mi8amt_civilian",2700,1],
		["RHS_MELB_MH6M",3000,2],
		["RHS_MELB_H6M",3000,2],
		["RHS_Mi8mt_vvs",3500,2],
		["RHS_Mi8mt_vvsc",3500,2],
		["RHS_Mi8mt_Cargo_vvs",3800,2],
		["RHS_Mi8mt_Cargo_vvsc",3800,2],
		["RHS_Mi8AMT_vvs",4000,3],
		["RHS_Mi8AMT_vvsc",4000,3],
		["RHS_CH_47F_10",5000,4],
		["RHS_CH_47F_light",5000,4],
		["rhsusf_CH53E_USMC_d",5500,4],
		["RHS_UH1Y_UNARMED_d",5500,4],
		["RHS_C130J",6000,4],
		["RHS_C130J_Cargo",6500,4],
		["rhs_ka60_grey",6500,5],
		["rhs_ka60_c",6500,5],
		["RHS_UH60M2",7000,4],
		["RHS_UH60M_MEV2",7000,4],
		["RHS_UH60M",7000,4],
		["RHS_UH60M_ESSS2",7000,5],
		["RHS_UH60M_ESSS",7000,5],
		["RHS_MELB_AH6M",7000,5],
		["RHS_UH1Y_FFAR_d",8000,5],
		["RHS_UH1Y_d",8000,5],
		["RHS_Mi8MTV3_vvs",8500,6],
		["RHS_Mi8MTV3_vvsc",8500,6],
		["RHS_Mi8AMTSh_vvs",9500,6],
		["RHS_Mi8AMTSh_vvsc",9500,6],
		["RHS_Mi24P_vvs",10000,7],
		["RHS_Mi24P_vvsc",10000,7],
		["RHS_Mi24V_vvs",12000,7],
		["RHS_Mi24V_vvsc",12000,7],
		["RHSGREF_A29B_HIDF",14000,8],
		["RHS_Su25SM_vvs",16000,8],
		["RHS_Su25SM_vvsc",16000,8],
		["rhs_mi28n_vvs",16000,8],
		["rhs_mi28n_vvsc",16000,8],
		["RHS_AH1Z",17000,9],
		["RHS_Ka52_vvsc",18000,9],
		["RHS_Ka52_vvs",18000,9],
		["RHS_AH64D",19000,9],
		["RHS_AH64DGrey",19000,9],
		["RHS_A10",20000,9],
		["rhs_mig29s_vmf",21000,10],
		["rhs_mig29s_vvsc",21000,10],
		["rhs_mig29sm_vmf",26000,10],
		["rhs_mig29sm_vvsc",26000,10],
		["rhsusf_f22",32000,10],
		["RHS_T50_vvs_generic_ext",37000,10]
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

	private _checkplace = nearestObjects [position objectspawn,["landVehicle","Air","Ship"],12] # 0;
	if (!isNil "_checkplace") then {deleteVehicle _checkplace};

	private _vehicle = (_data # 0) createVehicle position objectspawn;
	//_vehicle setDir (getDir objectspawn);
	_vehicle setDir ((triggerArea objectspawn) # 2);

	if ((_data # 0) == "Land_DataTerminal_01_F") then {
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

	if ((_data # 1) != 0) then {
		["missionNamespace", "money", 0, -(_data # 1)] call prj_fnc_changePlayerVariableLocal;
	};
};

// hq menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_hq_menu = {
	private _dialog_hq = createDialog "dialogHQmenu";

	private _enemy = ((missionNamespace getVariable (getPlayerUID player)) select 1) select 1;
	private _friend = ((missionNamespace getVariable (getPlayerUID player)) select 2) select 1;
	private _civ = ((missionNamespace getVariable (getPlayerUID player)) select 3) select 1;
	private _intel_score = missionNamespace getVariable "intel_score";

	private _stats_text = localize "STR_PRJ_STATISTICS_KILLED" + ":<br/>" + localize "STR_PRJ_STATISTICS_ENEMIES" + ": " + str _enemy + "<br/>" + localize "STR_PRJ_STATISTICS_FRIENDLY" + ": " + str _friend + "<br/>" + localize "STR_PRJ_STATISTICS_CIVILIANS" + ": " + str _civ + "<br/><br/>" + localize "STR_PRJ_STATISTICS_INTELSCORE" + ": " + str _intel_score + "<br/>";

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
	if (isNil "mhqterminal") exitWith {
		hintC (localize "STR_PRJ_MHQ_IN_NOT_EXIST");
		hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
			0 = _this spawn {
				_this select 0 displayRemoveEventHandler ["unload", hintC_EH];
				hintSilent "";
			};
		}];
	};

	if ((mhqterminal animationPhase "lid_rot_1") != 0) then {
		player setposATL ((getpos mhqterminal) findEmptyPosition [ 0 , 15 , "B_soldier_F" ]);
		closeDialog 2;
	}
	else
	{
		hint localize "STR_PRJ_MHQ_IS_NOT_DEPLOYED";
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
		["missionNamespace", "money", 0, _value] call prj_fnc_changePlayerVariableLocal;
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

	["missionNamespace", "money", 0, -_value] call prj_fnc_changePlayerVariableLocal;

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

// upgrades menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_upgrades_menu = {
	createDialog "dialogUpgradesMenu";

	ctrlEnable [1026, false];

	if !((getPlayerUID player) in hqUID || player getVariable ["officer",false]) then {
		{ctrlEnable [_x, false]} forEach [1027,1028];
	};

	ctrlSetText [1026,localize "STR_PRJ_STATISTICS_ARSENAL" + " (WIP)"];
	ctrlSetText [1027,localize "STR_PRJ_STATISTICS_AIRSHOP"];
	ctrlSetText [1028,localize "STR_PRJ_STATISTICS_GROUNDSHOP"];

	private _ctrl = (findDisplay 3006) displayCtrl 1025;
	private _text = localize "STR_PRJ_STATISTICS_INTELSCORE" + ": <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "intel_score") + "</t>";
	_ctrl ctrlSetStructuredText parseText _text;

	private _ctrl = (findDisplay 3006) displayCtrl 1022;
	private _text = localize "STR_PRJ_STATISTICS_ARSENAL" + ": <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "arsenal_level") + " " + localize "STR_PRJ_STATISTICS_LVL" +  "</t>";
	_ctrl ctrlSetStructuredText parseText _text;

	private _ctrl = (findDisplay 3006) displayCtrl 1023;
	private _text = localize "STR_PRJ_STATISTICS_AIRSHOP" + ": <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "a_garage_level") + " " + localize "STR_PRJ_STATISTICS_LVL" +  "</t>";
	_ctrl ctrlSetStructuredText parseText _text;

	private _ctrl = (findDisplay 3006) displayCtrl 1024;
	private _text = localize "STR_PRJ_STATISTICS_GROUNDSHOP" + ": <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "g_garage_level") + " " + localize "STR_PRJ_STATISTICS_LVL" +  "</t>";
	_ctrl ctrlSetStructuredText parseText _text;
};

prj_fnc_upgrade = {
	params [
		"_type"
	];

	private ["_variable","_upgrade_name","_display_ctrl","_text","_next_level"];

	switch (_type) do {
		case 1: {
			_variable = "arsenal_level";
			_upgrade_name = localize "STR_PRJ_ARSENAL";
			_display_ctrl = 1022;
			_next_level = (missionNamespace getVariable _variable) + 1;
			_text = localize "STR_PRJ_STATISTICS_ARSENAL" + ": <t size='1.2' color='#25E03F'>" + str _next_level + "</t> " + localize "STR_PRJ_STATISTICS_LVL";
		};
		case 2: {
			_variable = "a_garage_level";
			_upgrade_name = localize "STR_PRJ_A_GARAGE";
			_display_ctrl = 1023;
			_next_level = (missionNamespace getVariable _variable) + 1;
			_text = localize "STR_PRJ_STATISTICS_AIRSHOP" + ": <t size='1.2' color='#25E03F'>" + str _next_level + "</t> " + localize "STR_PRJ_STATISTICS_LVL";
		};
		case 3: {
			_variable = "g_garage_level";
			_upgrade_name = localize "STR_PRJ_G_GARAGE";
			_display_ctrl = 1024;
			_next_level = (missionNamespace getVariable _variable) + 1;
			_text = localize "STR_PRJ_STATISTICS_GROUNDSHOP" + ": <t size='1.2' color='#25E03F'>" + str _next_level + "</t> " + localize "STR_PRJ_STATISTICS_LVL";
		};
	};

	if ((missionNamespace getVariable _variable) >= 10) exitWith {hint (localize "STR_PRJ_UPGRADED" + " " + _upgrade_name + " " + localize "STR_PRJ_MAX_LEVEL")};

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
		private _text_intel = localize "STR_PRJ_STATISTICS_INTELSCORE" + ": <t size='1.2' color='#25E03F'>" + str (_intel_score - (_next_level * 100)) + "</t>";
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
			_car addMagazineCargoGlobal [_item,1];
		};
		case "Mine": {
			_car addMagazineCargoGlobal [_item,1];
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