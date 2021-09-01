/*
	written by eugene27.
	global
*/

private _preset_units_array = ["middle_east","european_aggressor","syndikat","middle_east_with_cup","european_aggressor_with_cup","regular_salyanka_with_cup"];
private _number = "preset_units" call BIS_fnc_getParamValue;
private _preset_units = _preset_units_array # _number;

// virtual arsenal black list / чёрный лист ВИРТУАЛЬНОГО арсенала. предметы, которых не будет в арсенале.
arsenal_black_list = ["launch_B_Titan_short_tna_F","launch_B_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_short_ghex_F","launch_O_Titan_short_F","launch_B_Titan_tna_F","launch_B_Titan_F","launch_B_Titan_olive_F","launch_O_Titan_F","launch_O_Titan_ghex_F","launch_I_Titan_eaf_F","launch_I_Titan_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","H_HelmetO_ViperSP_ghex_F","H_HelmetO_ViperSP_hex_F","Laserdesignator_02_ghex_F","Laserdesignator_02","optic_Nightstalker","FirstAidKit","optic_DMS","optic_DMS_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_LRPS","optic_LRPS_tna_F","optic_LRPS_ghex_F","optic_NVS","ACE_optic_Hamr_2D","ACE_optic_Hamr_PIP","optic_tws","optic_tws_mg","ace_csw_staticGMGCarry","ace_csw_staticHMGCarry","ace_csw_staticATCarry","ace_csw_staticAACarry","H_HelmetIA","H_HelmetLeaderO_ocamo","H_HelmetO_ocamo","H_HelmetSpecO_ocamo","H_HelmetLeaderO_oucamo","H_HelmetO_oucamo","H_HelmetSpecO_blk","H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F","H_HelmetSpecO_ghex_F","H_HelmetLeaderO_ghex_F","H_HelmetO_ghex_F","H_HelmetHBK_headset_F","H_HelmetHBK_chops_F","H_HelmetHBK_ear_F","H_HelmetHBK_F","H_HelmetB_TI_tna_F","H_HelmetAggressor_F","H_HelmetAggressor_cover_F","H_HelmetAggressor_cover_taiga_F","H_HelmetCrew_I","H_HelmetCrew_O","H_HelmetCrew_B","G_Goggles_VR","U_I_Protagonist_VR","U_O_Protagonist_VR","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F","Laserdesignator_02","U_C_Protagonist_VR","U_O_V_Soldier_Viper_F","U_B_T_Sniper_F","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_rgr","U_O_T_Sniper_F","U_B_Protagonist_VR","U_I_GhillieSuit","U_O_GhillieSuit","U_B_GhillieSuit","U_O_V_Soldier_Viper_hex_F","V_PlateCarrierSpec_wdl","O_NVGoggles_hex_F","O_NVGoggles_urb_F","O_NVGoggles_ghex_F","O_NVGoggles_grn_F","psq36_dovetail","psq36_dovetail_NB","psq36_tarsier_dovetail","psq36_tarsier_dovetail_NB","psq36_gsgm","psq36_gsgm_NB"];

// hq uid / uid тех, кто будут иметь доступ к ключевым опциям миссии вне зависимости от роли
hqUID = ["76561198141746661","76561198138702011","76561198060515006"];

// additional removal points (radius 100m)
delete_locations = [[21776.1,6017.31,0],[22706.9,6932.26,0],[3017.65,12574.2,0],[3042.24,13171.6,0],[2372.57,11510.7,0],[2666.38,11460.9,0],[2332.28,9287.31,0],[14503.2,5870.01,0],[14221.3,6242.22,0],[14292.3,13465.8,0],[6281.23,12168.8,0],[28010,23768,0],[4919.26,21952.2,0],[19564.4,15630.3,0],[7821.94,7636.43,0],[8313.78,25086.8,0],[4385.52,12594,0]];

// units configuration. don’t know? don’t change.
switch (_preset_units) do {
	case "european_aggressor": {

		// units and vehicles
		friendly_helicopters = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];

		idap_units = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
		idap_vehicles = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
		
		civilian_units = ["LOP_CHR_Civ_Citizen_03","LOP_CHR_Civ_Citizen_04","LOP_CHR_Civ_Citizen_01","LOP_CHR_Civ_Citizen_02","LOP_CHR_Civ_Profiteer_02","LOP_CHR_Civ_Profiteer_03","LOP_CHR_Civ_Profiteer_01","LOP_CHR_Civ_Profiteer_04","LOP_CHR_Civ_Villager_01","LOP_CHR_Civ_Villager_04","LOP_CHR_Civ_Villager_03","LOP_CHR_Civ_Villager_02","LOP_CHR_Civ_Woodlander_01","LOP_CHR_Civ_Woodlander_02","LOP_CHR_Civ_Woodlander_03","LOP_CHR_Civ_Woodlander_04","LOP_CHR_Civ_Worker_03","LOP_CHR_Civ_Worker_04","LOP_CHR_Civ_Worker_01","LOP_CHR_Civ_Worker_02","C_man_p_fugitive_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_p_beggar_F","C_Story_Mechanic_01_F","C_Nikos"];
		civilian_vehicles = ["C_Offroad_01_F","C_Van_01_transport_F","C_Tractor_01_F","C_Van_02_transport_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Offroad_02_unarmed_F","LOP_CHR_Civ_Landrover","LOP_CHR_Civ_UAZ","LOP_CHR_Civ_UAZ_Open","LOP_CHR_Civ_Hatchback","LOP_CHR_Civ_Offroad"];
		hostage_units = idap_units + ["C_journalist_F","C_Journalist_01_War_F","C_Man_UtilityWorker_01_F","C_Story_EOD_01_F"];

		enemy_leaders = ["LOP_NAPA_Infantry_Prizrak","LOP_NAPA_Infantry_SL","rhsgref_nat_commander","rhsgref_nat_pmil_commander"];
		enemy_infantry = ["rhsgref_nat_pmil_grenadier_rpg","rhsgref_nat_pmil_saboteur","rhsgref_nat_pmil_hunter","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_scout","rhsgref_nat_pmil_medic","rhsgref_nat_pmil_grenadier","rhsgref_nat_pmil_specialist_aa","rhsgref_nat_pmil_rifleman_akm","rhsgref_nat_pmil_rifleman_aksu","rhsgref_nat_pmil_rifleman","rhsgref_nat_grenadier_rpg","rhsgref_nat_saboteur","rhsgref_nat_medic","rhsgref_nat_militiaman_kar98k","rhsgref_nat_militiaman_kar98k","rhsgref_nat_hunter","rhsgref_nat_machinegunner","rhsgref_nat_machinegunner_mg42","rhsgref_nat_scout","rhsgref_nat_grenadier","rhsgref_nat_specialist_aa","rhsgref_nat_rifleman_akms","rhsgref_nat_rifleman_aks74","rhsgref_nat_rifleman_mp44","rhsgref_nat_rifleman","rhsgref_nat_rifleman_vz58","LOP_NAPA_Infantry_Engineer","LOP_NAPA_Infantry_GL_2","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_Rifleman_3","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman_2","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_MG_Asst","LOP_NAPA_Infantry_Corpsman","rhsgref_nat_pmil_hunter"];

		enemy_vehicles_light = ["rhssaf_m1025_olive_m2","rhssaf_m1025_olive","rhssaf_m998_olive_2dr_fulltop","rhssaf_m998_olive_2dr_halftop","LOP_NAPA_Truck","LOP_NAPA_Landrover","LOP_NAPA_Landrover_M2","LOP_NAPA_Offroad","LOP_NAPA_Offroad_M2","rhsgref_nat_uaz","rhsgref_nat_uaz_open","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_dshkm","rhsgref_nat_uaz_spg9","rhsgref_nat_van","rhsgref_nat_ural","rhsgref_nat_ural_open","rhsgref_cdf_gaz66","rhsgref_cdf_zil131"];
		enemy_vehicles_heavy = ["rhsgref_nat_btr70","rhsgref_cdf_bmd2k","rhsgref_cdf_bmp2k","rhsgref_cdf_t72ba_tv","rhsgref_cdf_t72bb_tv","rhsgref_cdf_t80b_tv","rhsgref_cdf_bmp1d","rhsgref_cdf_bmp1p","rhsgref_cdf_bmd1k","rhsgref_cdf_bmp1","rhsgref_cdf_bmp2","rhsgref_BRDM2","rhsgref_cdf_btr80","rhsgref_ins_g_bmp1","rhsgref_ins_g_bmp2e"];
		enemy_turrets = ["rhsgref_nat_DSHKM","rhsgref_nat_SPG9","rhsgref_nat_AGS30_TriPod","rhsgref_nat_DSHKM_Mini_TriPod","rhsgref_nat_NSV_TriPod","rhsgref_nat_ZU23","LOP_NAPA_Kord","LOP_NAPA_Kord_High","LOP_NAPA_AGS30_TriPod","LOP_NAPA_Static_M2","LOP_NAPA_Static_M2_MiniTripod","LOP_NAPA_Static_Mk19_TriPod","LOP_NAPA_NSV_TriPod"];

		enemy_heliSentry = ["LOP_RACS_MH9","LOP_PMC_MH9"];
		enemy_heliTransport = ["LOP_RACS_MH9","LOP_RACS_UH60M","LOP_UA_Mi8MT_Cargo"];
		enemy_heliHeavy = ["rhsgref_cdf_Mi24D","rhsgref_cdf_Mi35","LOP_RACS_MH9_armed"];

		// mission objects
		box_ammo_cache = ["Box_FIA_Ammo_F","Box_FIA_Support_F","O_supplyCrate_F","Box_FIA_Wps_F"];
		towers = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
		ied = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];

		// sounds
		screams = ["scream_1","scream_2","scream_3"];
	};
	case "middle_east": {

		// units and vehicles
		friendly_helicopters = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];

		idap_units = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
		idap_vehicles = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
		
		civilian_units = ["LOP_Tak_Civ_Man_06","LOP_Tak_Civ_Man_08","LOP_Tak_Civ_Man_07","LOP_Tak_Civ_Man_05","LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_10","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_09","LOP_Tak_Civ_Man_11","LOP_Tak_Civ_Man_12","LOP_Tak_Civ_Man_04","LOP_Tak_Civ_Man_14","LOP_Tak_Civ_Man_13","LOP_Tak_Civ_Man_16","LOP_Tak_Civ_Man_15"];
		civilian_vehicles = ["LOP_TAK_Civ_UAZ","LOP_TAK_Civ_UAZ_Open","LOP_TAK_Civ_Hatchback","LOP_TAK_Civ_Landrover","LOP_TAK_Civ_Offroad"];
		hostage_units = idap_units + ["C_journalist_F","C_Journalist_01_War_F","C_Man_UtilityWorker_01_F","C_Story_EOD_01_F"];

		enemy_leaders = ["LOP_ISTS_Infantry_SL","LOP_AM_Infantry_SL","LOP_ISTS_Infantry_B_SL"];
		enemy_infantry = ["LOP_AM_Infantry_Engineer","LOP_AM_Infantry_Corpsman","LOP_AM_Infantry_GL","LOP_AM_Infantry_Rifleman_6","LOP_AM_Infantry_Rifleman","LOP_AM_Infantry_Rifleman_2","LOP_AM_Infantry_Rifleman_4","LOP_AM_Infantry_Rifleman_5","LOP_AM_Infantry_Rifleman_7","LOP_AM_Infantry_Rifleman_8","LOP_AM_Infantry_AT","LOP_AM_Infantry_Marksman","LOP_AM_Infantry_Rifleman_9","LOP_AM_Infantry_AR","LOP_AM_Infantry_AR_Asst","LOP_AM_Infantry_SL"];
		
		enemy_vehicles_light = ["LOP_AFR_Landrover","LOP_AFR_Landrover_M2","LOP_AM_Nissan_PKM","LOP_AM_UAZ_SPG","LOP_ISTS_Landrover","LOP_ISTS_Landrover_M2","LOP_ISTS_Landrover_SPG9","LOP_ISTS_M1025_W_M2","LOP_ISTS_M1025_W_Mk19","LOP_ISTS_M1025_D"];
		enemy_vehicles_heavy = ["LOP_AM_BTR60","LOP_ISTS_BTR60","LOP_ISTS_BMP1","LOP_ISTS_T55"];
		enemy_turrets = ["LOP_AM_Static_DSHKM","LOP_AM_Kord_High","LOP_AM_Static_SPG9","LOP_AM_AGS30_TriPod","LOP_AM_Static_M2","LOP_AM_Static_M2_MiniTripod","LOP_AM_Static_Mk19_TriPod","LOP_AM_Static_ZU23"];
		
		enemy_heliSentry = ["LOP_RACS_MH9"];
		enemy_heliTransport = ["LOP_RACS_MH9","I_Heli_light_03_unarmed_F"];
		enemy_heliHeavy = ["rhsgref_cdf_Mi24D","rhsgref_cdf_Mi35","LOP_RACS_MH9_armed"];
		
		// mission objects
		box_ammo_cache = ["Box_FIA_Ammo_F","Box_FIA_Support_F","O_supplyCrate_F","Box_FIA_Wps_F"];
		towers = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
		ied = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];

		// sounds
		screams = ["scream_allah","scream_1"];
	};
	case "syndikat": {

		// units and vehicles
		friendly_helicopters = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];

		idap_units = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
		idap_vehicles = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
		
		civilian_units = ["C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_man_sport_1_F_tanoan","C_man_sport_2_F_tanoan","C_man_sport_3_F_tanoan","C_Man_casual_4_F_afro","C_Man_casual_5_F_afro","C_Man_casual_6_F_afro","C_Man_casual_1_F_afro","C_Man_casual_2_F_afro","C_Man_casual_3_F_afro","C_man_sport_1_F_afro","C_man_sport_2_F_afro","C_man_sport_3_F_afro","C_man_p_fugitive_F_afro","C_man_p_shorts_1_F_afro","C_man_polo_2_F_afro","C_man_polo_1_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro","C_man_shorts_1_F_afro","C_man_p_beggar_F_afro","C_man_shorts_2_F_afro"];
		civilian_vehicles = ["C_Offroad_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Quadbike_01_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_SUV_01_F"];
		hostage_units = idap_units + ["C_journalist_F","C_Journalist_01_War_F","C_Man_UtilityWorker_01_F","C_Story_EOD_01_F"];

		enemy_leaders = ["I_C_Soldier_base_unarmed_F","I_C_Soldier_Camo_F","I_G_officer_F"];
		enemy_infantry = ["I_G_Soldier_GL_F","I_G_engineer_F","I_G_Soldier_TL_F","I_G_Soldier_SL_F","I_G_medic_F","I_G_Sharpshooter_F","I_G_Soldier_A_F","I_G_Soldier_AR_F","I_G_Soldier_exp_F","I_G_Soldier_M_F","I_G_Soldier_F","I_G_Soldier_LAT_F","I_G_Soldier_LAT2_F","I_G_Soldier_lite_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Para_2_F","LOP_AFR_Infantry_IED","LOP_AFR_Infantry_Corpsman","LOP_AFR_Infantry_GL","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_3_F","LOP_AFR_Infantry_Rifleman_4","LOP_AFR_Infantry_Rifleman","LOP_AFR_Infantry_Rifleman_5","LOP_AFR_Infantry_Rifleman_2","LOP_AFR_Infantry_Rifleman_7","LOP_AFR_Infantry_AR_2","LOP_AFR_Infantry_Rifleman_8","LOP_AFR_Infantry_AR","LOP_AFR_Infantry_AT","LOP_AFR_Infantry_Marksman","LOP_AFR_Infantry_Rifleman_6","LOP_AFR_Infantry_AR_Asst_2","LOP_AFR_Infantry_AR_Asst","LOP_AFR_Driver","LOP_AFR_Infantry_SL","LOP_AFRCiv_Soldier_SL","I_C_Helipilot_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_4_F"];

		enemy_vehicles_light = ["I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F","I_C_Offroad_02_unarmed_F","I_C_Van_01_transport_F","I_C_Van_02_vehicle_F","I_C_Van_02_transport_F","I_G_Offroad_01_F","I_G_Offroad_01_AT_F","I_G_Offroad_01_repair_F","I_G_Offroad_01_armed_F","I_G_Van_01_transport_F","I_G_Van_01_fuel_F","I_G_Quadbike_01_F","I_G_Van_02_transport_F","I_G_Van_02_vehicle_F","LOP_PMC_Offroad_M2","rhsgref_tla_btr60"];
		enemy_vehicles_heavy = ["rhsgref_tla_btr60","LOP_AFR_Landrover_M2","LOP_AFR_T55","LOP_AFR_T34"];
		enemy_turrets = ["rhsgref_nat_DSHKM","rhsgref_nat_SPG9","rhsgref_nat_AGS30_TriPod","rhsgref_nat_DSHKM_Mini_TriPod","rhsgref_nat_NSV_TriPod","rhsgref_nat_ZU23","I_C_HMG_02_high_F"];
		
		enemy_heliSentry = ["LOP_RACS_MH9"];
		enemy_heliTransport = ["LOP_RACS_MH9","I_Heli_light_03_unarmed_F"];
		enemy_heliHeavy = ["rhsgref_cdf_Mi24D","rhsgref_cdf_Mi35","LOP_RACS_MH9_armed"];

		// mission objects
		box_ammo_cache = ["Box_FIA_Ammo_F","Box_FIA_Support_F","O_supplyCrate_F","Box_FIA_Wps_F"];
		towers = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
		ied = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];

		// sounds
		screams = ["scream_1","scream_2","scream_3"];
	};

	case "middle_east_with_cup": {

		// units and vehicles
		friendly_helicopters = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];

		idap_units = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
		idap_vehicles = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
		
		civilian_units = ["LOP_Tak_Civ_Man_06","LOP_Tak_Civ_Man_08","LOP_Tak_Civ_Man_07","LOP_Tak_Civ_Man_05","LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_10","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_09","LOP_Tak_Civ_Man_11","LOP_Tak_Civ_Man_12","LOP_Tak_Civ_Man_04","LOP_Tak_Civ_Man_14","LOP_Tak_Civ_Man_13","LOP_Tak_Civ_Man_16","LOP_Tak_Civ_Man_15","CUP_C_TK_Man_04","CUP_C_TK_Man_04_Jack","CUP_C_TK_Man_04_Waist","CUP_C_TK_Man_07","CUP_C_TK_Man_07_Coat","CUP_C_TK_Man_07_Waist","CUP_C_TK_Man_08","CUP_C_TK_Man_08_Jack","CUP_C_TK_Man_08_Waist","CUP_C_TK_Man_05_Coat","CUP_C_TK_Man_05_Jack","CUP_C_TK_Man_05_Waist","CUP_C_TK_Man_06_Coat","CUP_C_TK_Man_06_Jack","CUP_C_TK_Man_06_Waist","CUP_C_TK_Man_02","CUP_C_TK_Man_02_Jack","CUP_C_TK_Man_02_Waist","CUP_C_TK_Man_01_Coat","CUP_C_TK_Man_01_Waist","CUP_C_TK_Man_01_Jack","CUP_C_TK_Man_03_Coat","CUP_C_TK_Man_03_Jack","CUP_C_TK_Man_03_Waist"];
		civilian_vehicles = ["LOP_TAK_Civ_Landrover","CUP_C_S1203_CIV","CUP_C_Lada_TK_CIV","CUP_C_Lada_GreenTK_CIV","CUP_C_Lada_TK2_CIV","CUP_C_Volha_Gray_TKCIV","CUP_C_Volha_Blue_TKCIV","CUP_C_UAZ_Unarmed_TK_CIV","CUP_O_Hilux_unarmed_TK_CIV","CUP_O_Hilux_unarmed_TK_CIV_Red","CUP_O_Hilux_unarmed_TK_CIV_Tan","CUP_C_V3S_Open_TKC","CUP_C_TT650_TK_CIV","CUP_C_Skoda_CR_CIV","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_White_CIV","CUP_C_Lada_Red_CIV","CUP_O_Hilux_unarmed_CR_CIV_White"];
		hostage_units = idap_units + ["C_journalist_F","C_Journalist_01_War_F","C_Man_UtilityWorker_01_F","C_Story_EOD_01_F"];

		enemy_leaders = ["LOP_ISTS_Infantry_SL","LOP_AM_Infantry_SL","LOP_ISTS_Infantry_B_SL","CUP_I_TK_GUE_Commander"];
		enemy_infantry = ["LOP_AM_Infantry_Engineer","LOP_AM_Infantry_Corpsman","LOP_AM_Infantry_GL","LOP_AM_Infantry_Rifleman_6","LOP_AM_Infantry_Rifleman","LOP_AM_Infantry_Rifleman_2","LOP_AM_Infantry_Rifleman_4","LOP_AM_Infantry_Rifleman_5","LOP_AM_Infantry_Rifleman_7","LOP_AM_Infantry_Rifleman_8","LOP_AM_Infantry_AT","LOP_AM_Infantry_Marksman","LOP_AM_Infantry_Rifleman_9","LOP_AM_Infantry_AR","LOP_AM_Infantry_AR_Asst","LOP_AM_Infantry_SL","CUP_I_TK_GUE_Soldier_AA","CUP_I_TK_GUE_Soldier_AR","CUP_I_TK_GUE_Guerilla_Medic","CUP_I_TK_GUE_Demo","CUP_I_TK_GUE_Soldier","CUP_I_TK_GUE_Soldier_AK_47S","CUP_I_TK_GUE_Soldier_HAT","CUP_I_TK_GUE_Guerilla_Enfield","CUP_I_TK_GUE_Soldier_GL","CUP_I_TK_GUE_Soldier_M16A2","CUP_I_TK_GUE_Soldier_AAT","CUP_I_TK_GUE_Soldier_LAT","CUP_I_TK_GUE_Soldier_AT","CUP_I_TK_GUE_Sniper","CUP_I_TK_GUE_Mechanic","CUP_I_TK_GUE_Soldier_MG","CUP_I_TK_GUE_Soldier_TL"];
		
		enemy_vehicles_light = ["LOP_IA_M1025_D","LOP_IA_M1025_W_Mk19","LOP_IA_M1025_W_M2","LOP_IA_M998_D_4DR","LOP_AFR_Landrover","LOP_AFR_Landrover_M2","LOP_AM_Nissan_PKM","LOP_AM_UAZ_SPG","LOP_ISTS_Landrover","LOP_ISTS_Landrover_M2","LOP_ISTS_Landrover_SPG9","LOP_ISTS_M1025_W_M2","LOP_ISTS_M1025_W_Mk19","LOP_ISTS_M1025_D","CUP_I_Hilux_unarmed_TK","CUP_I_Datsun_4seat_TK","CUP_I_V3S_Open_TKG","CUP_I_V3S_Covered_TKG","CUP_I_Hilux_armored_unarmed_TK","CUP_I_Hilux_AGS30_TK","CUP_I_Hilux_DSHKM_TK","CUP_I_Hilux_podnos_TK","CUP_I_Hilux_zu23_TK","CUP_I_Hilux_UB32_TK","CUP_I_Hilux_btr60_TK","CUP_I_Hilux_BMP1_TK","CUP_I_MTLB_pk_SYNDIKAT"];
		enemy_vehicles_heavy = ["LOP_AM_BTR60","LOP_ISTS_BTR60","LOP_ISTS_BMP1","LOP_ISTS_T55","CUP_I_BRDM2_TK_Gue","CUP_I_BMP1_TK_GUE"];
		enemy_turrets = ["LOP_AM_Static_DSHKM","LOP_AM_Kord_High","LOP_AM_Static_SPG9","LOP_AM_AGS30_TriPod","LOP_AM_Static_M2","LOP_AM_Static_M2_MiniTripod","LOP_AM_Static_Mk19_TriPod","LOP_AM_Static_ZU23"];
		
		enemy_heliSentry = ["LOP_RACS_MH9"];
		enemy_heliTransport = ["LOP_RACS_MH9","I_Heli_light_03_unarmed_F"];
		enemy_heliHeavy = ["rhsgref_cdf_Mi24D","rhsgref_cdf_Mi35","LOP_RACS_MH9_armed"];
		
		// mission objects
		box_ammo_cache = ["Box_FIA_Ammo_F","Box_FIA_Support_F","O_supplyCrate_F","Box_FIA_Wps_F"];
		towers = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
		ied = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];

		// sounds
		screams = ["scream_allah","scream_1"];
	};

	case "european_aggressor_with_cup": {

		// units and vehicles
		friendly_helicopters = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];

		idap_units = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
		idap_vehicles = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
		
		civilian_units = ["LOP_CHR_Civ_Citizen_03","LOP_CHR_Civ_Citizen_04","LOP_CHR_Civ_Citizen_01","LOP_CHR_Civ_Citizen_02","LOP_CHR_Civ_Profiteer_02","LOP_CHR_Civ_Profiteer_03","LOP_CHR_Civ_Profiteer_01","LOP_CHR_Civ_Profiteer_04","LOP_CHR_Civ_Villager_01","LOP_CHR_Civ_Villager_04","LOP_CHR_Civ_Villager_03","LOP_CHR_Civ_Villager_02","LOP_CHR_Civ_Woodlander_01","LOP_CHR_Civ_Woodlander_02","LOP_CHR_Civ_Woodlander_03","LOP_CHR_Civ_Woodlander_04","LOP_CHR_Civ_Worker_03","LOP_CHR_Civ_Worker_04","LOP_CHR_Civ_Worker_01","LOP_CHR_Civ_Worker_02","C_man_p_fugitive_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_p_beggar_F","C_Story_Mechanic_01_F","C_Nikos"];
		civilian_vehicles = ["LOP_TAK_Civ_Landrover","CUP_C_S1203_CIV","CUP_C_Lada_TK_CIV","CUP_C_Lada_GreenTK_CIV","CUP_C_Lada_TK2_CIV","CUP_C_Volha_Gray_TKCIV","CUP_C_Volha_Blue_TKCIV","CUP_C_UAZ_Unarmed_TK_CIV","CUP_O_Hilux_unarmed_TK_CIV","CUP_O_Hilux_unarmed_TK_CIV_Red","CUP_O_Hilux_unarmed_TK_CIV_Tan","CUP_C_V3S_Open_TKC","CUP_C_TT650_TK_CIV","CUP_C_Skoda_CR_CIV","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_White_CIV","CUP_C_Lada_Red_CIV","CUP_O_Hilux_unarmed_CR_CIV_White"];
		hostage_units = idap_units + ["C_journalist_F","C_Journalist_01_War_F","C_Man_UtilityWorker_01_F","C_Story_EOD_01_F"];

		enemy_leaders = ["LOP_NAPA_Infantry_Prizrak","LOP_NAPA_Infantry_SL","rhsgref_nat_commander","rhsgref_nat_pmil_commander"];
		enemy_infantry = ["rhsgref_nat_pmil_grenadier_rpg","rhsgref_nat_pmil_saboteur","rhsgref_nat_pmil_hunter","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_scout","rhsgref_nat_pmil_medic","rhsgref_nat_pmil_grenadier","rhsgref_nat_pmil_specialist_aa","rhsgref_nat_pmil_rifleman_akm","rhsgref_nat_pmil_rifleman_aksu","rhsgref_nat_pmil_rifleman","rhsgref_nat_grenadier_rpg","rhsgref_nat_saboteur","rhsgref_nat_medic","rhsgref_nat_militiaman_kar98k","rhsgref_nat_militiaman_kar98k","rhsgref_nat_hunter","rhsgref_nat_machinegunner","rhsgref_nat_machinegunner_mg42","rhsgref_nat_scout","rhsgref_nat_grenadier","rhsgref_nat_specialist_aa","rhsgref_nat_rifleman_akms","rhsgref_nat_rifleman_aks74","rhsgref_nat_rifleman_mp44","rhsgref_nat_rifleman","rhsgref_nat_rifleman_vz58","LOP_NAPA_Infantry_Engineer","LOP_NAPA_Infantry_GL_2","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_Rifleman_3","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman_2","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_MG_Asst","LOP_NAPA_Infantry_Corpsman","rhsgref_nat_pmil_hunter"];

		enemy_vehicles_light = ["rhssaf_m1025_olive_m2","rhssaf_m1025_olive","rhssaf_m998_olive_2dr_fulltop","rhssaf_m998_olive_2dr_halftop","LOP_NAPA_Truck","LOP_NAPA_Landrover","LOP_NAPA_Landrover_M2","LOP_NAPA_Offroad","LOP_NAPA_Offroad_M2","rhsgref_nat_uaz","rhsgref_nat_uaz_open","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_dshkm","rhsgref_nat_uaz_spg9","rhsgref_nat_van","rhsgref_nat_ural","rhsgref_nat_ural_open","rhsgref_cdf_gaz66","rhsgref_cdf_zil131","CUP_I_Hilux_unarmed_TK","CUP_I_Datsun_4seat_TK","CUP_I_V3S_Open_TKG","CUP_I_V3S_Covered_TKG","CUP_I_Hilux_armored_unarmed_TK","CUP_I_Hilux_AGS30_TK","CUP_I_Hilux_DSHKM_TK","CUP_I_Hilux_podnos_TK"];
		enemy_vehicles_heavy = ["rhsgref_nat_btr70","rhsgref_cdf_bmd2k","rhsgref_cdf_bmp2k","rhsgref_cdf_t72ba_tv","rhsgref_cdf_t72bb_tv","rhsgref_cdf_t80b_tv","rhsgref_cdf_bmp1d","rhsgref_cdf_bmp1p","rhsgref_cdf_bmd1k","rhsgref_cdf_bmp1","rhsgref_cdf_bmp2","rhsgref_BRDM2","rhsgref_cdf_btr80","rhsgref_ins_g_bmp1","rhsgref_ins_g_bmp2e"];
		enemy_turrets = ["rhsgref_nat_DSHKM","rhsgref_nat_SPG9","rhsgref_nat_AGS30_TriPod","rhsgref_nat_DSHKM_Mini_TriPod","rhsgref_nat_NSV_TriPod","rhsgref_nat_ZU23","LOP_NAPA_Kord","LOP_NAPA_Kord_High","LOP_NAPA_AGS30_TriPod","LOP_NAPA_Static_M2","LOP_NAPA_Static_M2_MiniTripod","LOP_NAPA_Static_Mk19_TriPod","LOP_NAPA_NSV_TriPod"];
		
		enemy_heliSentry = ["LOP_RACS_MH9"];
		enemy_heliTransport = ["LOP_RACS_MH9","I_Heli_light_03_unarmed_F"];
		enemy_heliHeavy = ["rhsgref_cdf_Mi24D","rhsgref_cdf_Mi35","LOP_RACS_MH9_armed"];

		// mission objects
		box_ammo_cache = ["Box_FIA_Ammo_F","Box_FIA_Support_F","O_supplyCrate_F","Box_FIA_Wps_F"];
		towers = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
		ied = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];

		// sounds
		screams = ["scream_1","scream_2","scream_3"];
	};

	case "regular_salyanka_with_cup": {

		// units and vehicles
		friendly_helicopters = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];

		idap_units = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
		idap_vehicles = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
		
		civilian_units = ["LOP_CHR_Civ_Worker_02","LOP_CHR_Civ_Worker_04","LOP_CHR_Civ_Woodlander_04","LOP_CHR_Civ_Woodlander_03","LOP_CHR_Civ_Villager_03","LOP_CHR_Civ_Profiteer_02","LOP_CHR_Civ_Profiteer_03","LOP_CHR_Civ_Profiteer_01","LOP_CHR_Civ_Profiteer_04","LOP_CHR_Civ_Citizen_03","LOP_CHR_Civ_Citizen_01","LOP_CHR_Civ_Citizen_02","C_Man_casual_5_v2_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_Man_casual_4_v2_F","C_Man_casual_6_v2_F","C_Man_casual_7_F","C_Man_casual_8_F","C_Man_casual_9_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_p_beggar_F","C_Man_Messenger_01_F","C_Man_Fisherman_01_F"];
		civilian_vehicles = ["LOP_CHR_Civ_UAZ","LOP_CHR_Civ_UAZ_Open","LOP_CHR_Civ_Landrover","LOP_CHR_Civ_Offroad","C_Quadbike_01_F","C_Offroad_02_unarmed_F","CUP_C_Golf4_white_Civ","CUP_C_Octavia_CIV","CUP_C_Volha_Gray_TKCIV","CUP_C_Lada_GreenTK_CIV","CUP_C_Lada_TK2_CIV","CUP_C_TT650_CIV"];
		hostage_units = idap_units + ["C_journalist_F","C_Journalist_01_War_F","C_Man_UtilityWorker_01_F","C_Story_EOD_01_F"];

		enemy_leaders = ["LOP_RACS_Infantry_TL","LOP_TRK_Infantry_TL","LOP_ISTS_Infantry_SL","LOP_PESH_IND_Infantry_TL","LOP_UA_Infantry_TL"];
		enemy_infantry = ["LOP_RACS_Infantry_Corpsman","LOP_RACS_Infantry_Engineer","LOP_RACS_Infantry_GL","LOP_RACS_Infantry_AT","LOP_RACS_Infantry_AT_Asst","LOP_RACS_Infantry_MG","LOP_PESH_IND_Infantry_Corpsman","LOP_PESH_IND_Infantry_SL","LOP_PESH_IND_Infantry_Engineer","LOP_PESH_IND_Infantry_GL","LOP_PESH_IND_Infantry_AT","LOP_PESH_IND_Infantry_MG","LOP_PESH_IND_Infantry_Marksman","LOP_UA_Infantry_AT_Asst","LOP_UA_Infantry_Corpsman","LOP_RACS_Infantry_MG_Asst","LOP_RACS_Infantry_Marksman","LOP_RACS_Infantry_Rifleman","LOP_RACS_Infantry_Rifleman_2","LOP_RACS_Infantry_Rifleman_3","LOP_RACS_Infantry_SL","LOP_PESH_IND_Infantry_Rifleman_4","LOP_PESH_IND_Infantry_Rifleman","LOP_PESH_IND_Infantry_Rifleman_2","LOP_PESH_IND_Infantry_Rifleman_3","LOP_PESH_IND_Infantry_Sniper","LOP_UA_Infantry_Engineer","LOP_UA_Infantry_GL","LOP_UA_Infantry_AT","LOP_UA_Infantry_Rifleman_2","LOP_UA_Infantry_Rifleman","LOP_UA_Infantry_Rifleman_3","LOP_UA_Infantry_Marksman","LOP_UA_Infantry_MG","LOP_UA_Infantry_MG_Asst","LOP_UA_Officer","LOP_UA_Infantry_SL","LOP_TRK_Infantry_AT_Asst","LOP_TRK_Infantry_AT","LOP_TRK_Infantry_Corpsman","LOP_TRK_Infantry_Crewman","LOP_TRK_Infantry_Engineer","LOP_TRK_Infantry_MG","LOP_TRK_Infantry_MG_Asst","LOP_TRK_Infantry_Marksman","LOP_TRK_Infantry_Rifleman","LOP_TRK_Infantry_Rifleman_2","LOP_TRK_Infantry_SL","LOP_ISTS_Infantry_Engineer","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_TL","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Rifleman_6","LOP_ISTS_Infantry_Rifleman","LOP_ISTS_Infantry_Rifleman_4","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Rifleman_7","LOP_ISTS_Infantry_AR_Asst_2","LOP_ISTS_Infantry_AR_2","LOP_ISTS_Infantry_AR_Asst","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Rifleman_9","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_Rifleman_8","LOP_ISTS_Infantry_AT"];
		 
		enemy_vehicles_light = ["LOP_RACS_Landrover_M2","LOP_AFR_Landrover_M2","LOP_AFR_Offroad","LOP_AFR_Offroad_M2","LOP_AM_Landrover_M2","LOP_AFR_Landrover","CUP_I_LR_MG_RACS","CUP_I_LR_Transport_RACS","CUP_I_Hilux_unarmed_TK","CUP_I_Hilux_DSHKM_TK","CUP_I_Hilux_M2_TK","CUP_I_Hilux_metis_TK","CUP_I_Hilux_MLRS_TK","CUP_I_Datsun_AA_TK_Random","CUP_I_RG31_Mk19_W_ION","CUP_I_RG31E_M2_W_ION","CUP_I_RG31_M2_W_ION","CUP_I_RG31_M2_W_GC_ION","CUP_I_MTVR_RACS","LOP_IRAN_BMP1","LOP_IRAN_BTR70","LOP_IRAN_BTR80","LOP_IRAN_M113_C","LOP_ISTS_BMP1","CUP_I_M113_RACS","CUP_I_M113_RACS_URB","CUP_I_LAV25_HQ_RACS"];
		enemy_vehicles_heavy = ["LOP_RACS_T72BB","LOP_IRAN_BMP2","LOP_IRAN_T72BA","LOP_ISTS_BMP2","CUP_I_LAV25M240_RACS","CUP_I_LAV25_RACS","CUP_I_M60A3_TTS_RACS"];
		enemy_turrets = ["LOP_AM_Static_DSHKM","LOP_AM_Kord_High","LOP_AM_Static_SPG9","LOP_AM_AGS30_TriPod","LOP_AM_Static_M2","LOP_AM_Static_M2_MiniTripod","LOP_AM_Static_Mk19_TriPod","LOP_AM_Static_ZU23"];
		
		enemy_heliSentry = ["LOP_RACS_MH9","LOP_PMC_MH9"];
		enemy_heliTransport = ["LOP_RACS_MH9","LOP_RACS_UH60M","LOP_UA_Mi8MT_Cargo"];
		enemy_heliHeavy = ["rhsgref_cdf_Mi24D","rhsgref_cdf_Mi35","LOP_RACS_MH9_armed"];
		
		// mission objects
		box_ammo_cache = ["Box_FIA_Ammo_F","Box_FIA_Support_F","O_supplyCrate_F","Box_FIA_Wps_F"];
		towers = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
		ied = ["BombCluster_02_UXO2_F","BombCluster_02_UXO1_F","BombCluster_01_UXO1_F","BombCluster_03_UXO1_F","ACE_IEDLandBig_Range","ACE_IEDLandSmall_Range","rhs_uxo_ao1_1","rhs_uxo_ao1_3","rhs_uxo_ao1_2","rhs_uxo_ptab1m_1","rhs_uxo_ptab1m_3","rhs_uxo_ptab1m_2","rhs_uxo_ptab25ko_1","rhs_uxo_ptab25ko_3","rhs_uxo_ptab25ko_2","rhs_uxo_ptab25m_1","rhs_uxo_ptab25m_3","rhs_uxo_ptab25m_2","rhsusf_uxo_blu97","rhs_mine_ozm72_c","rhssaf_mine_pma3","rhs_mine_pmn2","ATMine","rhs_mine_tm62m","rhsusf_mine_M19","rhs_mine_TM43","rhssaf_mine_tma4","CUP_MineE"];
		supply_box = "C_IDAP_supplyCrate_F";

		// sounds
		screams = ["scream_allah","scream_1"];
	};
};

// arsenal shop items / [category,[[item class,price],[item class,price],[item class,price]...]]
arsenal_shop_items = [
	[
		"Primary weapons",
		[
			["rhs_weap_ak103",10000],
			["rhs_weap_ak104",1400],
			["rhs_weap_ak105",1700],
			["rhs_weap_ak74",900],
			["rhs_weap_ak74m",1000],
			["rhs_weap_ak74m_gp25",3000]
		]
	],
	[
		"Handguns",
		[
			["rhsusf_weap_glock17g4",600],
			["rhsusf_weap_m1911a1",400],
			["rhsusf_weap_m9",600],
			["rhs_weap_makarov_pm",200],
			["rhs_weap_pya",1000],
			["rhsusf_weap_MP7A2_folded",1800]
		]
	],
	[
		"Launchers",
		[
			["rhs_weap_rpg7",100],
			["rhs_weap_M136_hp",100],
			["rhs_weap_M136_hedp",100],
			["rhs_weap_M136",100],
			["rhs_weap_m72a7",100],
			["rhs_weap_rpg75",100],
			["rhs_weap_rpg26",100],
			["rhs_weap_rshg2",100],
			["rhs_weap_m80",100]
		]
	],
	[
		"Ammo",
		[
			["rhs_30Rnd_545x39_7N10_AK",100],
			["rhs_30Rnd_545x39_7N22_AK",100],
			["rhs_30Rnd_762x39mm_polymer",100],
			["rhs_30Rnd_762x39mm_polymer_89",100],
			["rhs_rpg7_PG7VL_mag",100]
		]
	],
	[
		"Sights",
		[
			["rhsusf_acc_ACOG2_USMC",1300],
			["rhsusf_acc_g33_xps3_tan",1150]
		]
	],
	[
		"Medicine",
		[
			["ACE_adenosine",100],
			["ACE_epinephrine",100],
			["ACE_personalAidKit",100],
			["ACE_tourniquet",100],
			["ACE_bloodIV",100],
			["ACE_bloodIV_250",100],
			["ACE_bloodIV_500",100],
			["ACE_bodyBag",100],
			["ACE_morphine",100],
			["ACE_quikclot",100],
			["ACE_plasmaIV",100],
			["ACE_plasmaIV_250",100],
			["ACE_plasmaIV_500",100],
			["ACE_elasticBandage",100],
			["ACE_fieldDressing",100],
			["ACE_packingBandage",100],
			["ACE_salineIV",100],
			["ACE_salineIV_250",100],
			["ACE_salineIV_500",100],
			["ACE_surgicalKit",100],
			["ACE_splint",100]
		]
	],
	[
		"Uniforms",
		[
			["rhs_uniform_acu_ocp",100],
			["rhs_uniform_gorka_r_g_gloves",150]
		]
	],
	[
		"Headgear",
		[
			["rhs_6b47_emr_1",100]
		]
	],
	[
		"Face protection",
		[
			["G_Bandanna_oli",100]
		]
	],
	[
		"Vests",
		[
			["rhs_6b23_digi_vydra_3m",100]
		]
	],
	[
		"Backpacks",
		[
			["B_FieldPack_oli",100],
			["B_AssaultPack_cbr",100]
		]
	],
	[
		"Binoculars",
		[
			["Binocular",100]
		]
	],
	[
		"NVG",
		[
			["O_NVGoggles_grn_F",100]
		]
	],
	[
		"Explosives",
		[
			["DemoCharge_Remote_Mag",100],
			["SatchelCharge_Remote_Mag",100],
			["ATMine_Range_Mag",100],
			["APERSBoundingMine_Range_Mag",100],
			["APERSMine_Range_Mag",100],
			["ClaymoreDirectionalMine_Remote_Mag",100],
			["APERSMineDispenser_Mag",100],
			["MineDetector",100],
			["ACE_DefusalKit",100],
			["ACE_M26_Clacker",100]
		]
	],
	[
		"Food",
		[
			["ACE_Can_Franta",100],
			["ACE_Can_Spirit",100],
			["ACE_Can_RedGull",100],
			["ACE_WaterBottle",100],
			["ACE_Humanitarian_Ration",100],
			["ACE_MRE_CreamChickenSoup",100],
			["ACE_MRE_ChickenTikkaMasala",100],
			["ACE_MRE_ChickenHerbDumplings",100],
			["ACE_MRE_MeatballsPasta",100],
			["ACE_MRE_SteakVegetables",100],
			["ACE_MRE_CreamTomatoSoup",100],
			["ACE_MRE_BeefStew",100],
			["ACE_MRE_LambCurry",100],
			["ACE_Canteen",100]
		]
	],
	[
		"Misc",
		[
			["ACE_UAVBattery",100],
			["ACE_EarPlugs",100],
			["ACE_IR_Strobe_Item",100],
			["ACE_CableTie",100],
			["ACE_wirecutter",100],
			["ACE_Sandbag_empty",100],
			["ToolKit",100],
			["ACE_EntrenchingTool",100],
			["ACE_Flashlight_XL50",100],
			["ACE_Flashlight_MX991",100]
		]
	]
];

// vehicle classes from the shop / [vehicle type, price, level] / LEVELS MUST TAKE PLACE IN THE ORDER OF (0 > 1 > 2 ... > 10)
shop_land_vehicles = [
	["Land_CanisterFuel_F",10,0],
	["ACE_Wheel",20,0],
	["ACE_Track",50,0],
	["Land_WoodenCrate_01_F",500,0],
	["B_supplyCrate_F",100,0],
	["C_IDAP_supplyCrate_F",300,0],
	["C_Quadbike_01_F",0,0],
	["C_Hatchback_01_F",1000,0],
	["I_C_Offroad_02_unarmed_F",2000,0],
	["C_SUV_01_F",2500,0],
	["C_Offroad_02_unarmed_F",3000,0],
	["rhs_uaz_vdv",700,0],
	["rhs_uaz_open_vdv",700,0],
	["rhsusf_mrzr4_d",2500,0],
	["C_Hatchback_01_sport_F",1200,0],
	["C_Offroad_01_covered_F",3500,0],
	["C_Offroad_01_F",3000,0],
	["C_Van_01_transport_F",4000,0],
	["C_Van_01_box_F",3500,0],
	["C_Van_02_transport_F",4000,0],
	["C_Van_02_vehicle_F",4000,0],
	["C_Truck_02_transport_F",3200,0],
	["RHS_Ural_Open_Civ_01",2900,0],
	["RHS_Ural_Civ_01",2900,0],
	["B_CTRG_LSV_01_light_F",5000,0],
	["O_LSV_02_unarmed_F",5000,0],
	["rhs_pts_vmf",15000,0],
	["rhsusf_m998_d_2dr",4300,0],
	["rhsusf_m998_w_2dr",4300,0],
	["rhsgref_hidf_M998_2dr",4300,0],
	["rhsusf_m998_d_2dr_halftop",4500,0],
	["rhsusf_m998_w_2dr_halftop",4500,0],
	["rhsgref_hidf_M998_2dr_halftop",4500,0],
	["rhssaf_army_o_m998_olive_2dr_halftop",4500,0],
	["rhsusf_m998_d_2dr_fulltop",4800,0],
	["rhsusf_m998_w_2dr_fulltop",4800,0],
	["rhsgref_hidf_M998_2dr_fulltop",4800,0],
	["rhssaf_army_o_m998_olive_2dr_fulltop",4800,0],
	["rhsusf_m998_d_4dr",4900,0],
	["rhsusf_m998_w_4dr",4900,0],
	["rhsgref_hidf_m998_4dr",4900,0],
	["rhsusf_m998_d_4dr_halftop",5000,0],
	["rhsusf_m998_w_4dr_halftop",5000,0],
	["rhsgref_hidf_M998_4dr_halftop",5000,0],
	["rhsusf_m998_d_4dr_fulltop",5200,0],
	["rhsusf_m998_w_4dr_fulltop",5200,0],
	["rhsgref_hidf_M998_4dr_fulltop",5200,0],
	["rhs_D30_at_msv",2000,0],
	["rhs_D30_msv",5500,0],
	["rhs_gaz66_vdv",2700,0],
	["rhs_gaz66_flat_vdv",1700,0],
	["rhs_gaz66o_vdv",2600,0],
	["rhs_gaz66o_flat_vdv",1600,0],
	["rhs_gaz66_r142_vdv",10000,0],
	["rhs_gaz66_repair_vdv",12000,0],
	["rhs_gaz66_ap2_vdv",14000,0],
	["rhs_gaz66_ammo_vdv",20000,0],
	["rhs_zil131_vdv",3100,0],
	["rhs_zil131_open_vdv",3000,0],
	["rhs_zil131_flatbed_vdv",2000,0],
	["rhs_kamaz5350_vdv",3400,0],
	["rhs_kamaz5350_flatbed_cover_vdv",2400,0],
	["rhs_kamaz5350_open_vdv",3200,0],
	["rhs_kamaz5350_flatbed_vdv",2400,0],
	["RHS_Ural_VDV_01",3400,0],
	["RHS_Ural_Flat_VDV_01",2400,0],
	["RHS_Ural_Open_VDV_01",3200,0],
	["RHS_Ural_Open_Flat_VDV_01",2200,0],
	["RHS_Ural_Fuel_VDV_01",24000,0],
	["rhs_kraz255b1_bmkt_vv",2400,0],
	["rhs_kraz255b1_flatbed_vv",3400,0],
	["rhs_kraz255b1_pmp_vv",2400,0],
	["rhsusf_M1084A1R_SOV_M2_d_fmtv_socom",6400,0],
	["rhsusf_M1078A1R_SOV_M2_d_fmtv_socom",6400,0],
	["rhsusf_M1078A1P2_WD_fmtv_usarmy",6800,0],
	["rhsusf_M1078A1P2_WD_flatbed_fmtv_usarmy",6800,0],
	["rhsusf_M1083A1P2_WD_fmtv_usarmy",5900,0],
	["rhsusf_M1083A1P2_WD_flatbed_fmtv_usarmy",4900,0],
	["rhsusf_M1084A1P2_WD_fmtv_usarmy",4400,0],
	["rhsusf_M977A4_usarmy_wd",6500,0],
	["rhsusf_M977A4_AMMO_usarmy_wd",26500,0],
	["rhsusf_M977A4_REPAIR_usarmy_wd",21000,0],
	["rhsusf_M978A4_usarmy_wd",27000,0],
	["B_G_Offroad_01_repair_F",15000,0],
	["B_G_Van_01_fuel_F",10000,0],	
	["I_C_Offroad_02_LMG_F",8200,1],
	["I_C_Offroad_02_AT_F",9500,1],
	["rhsusf_m1025_d",8200,1],
	["rhsusf_m1025_w",8200,1],
	["rhsgref_hidf_m1025",8200,1],
	["rhssaf_army_o_m1025_olive",8200,1],
	["rhsusf_m1025_d_m2",17500,1],
	["rhsusf_m1025_w_m2",17600,1],
	["rhsgref_hidf_m1025_m2",17600,1],
	["rhssaf_army_o_m1025_olive_m2",17600,1],
	["rhsusf_m1025_d_Mk19",23700,1],
	["rhsusf_m1025_w_Mk19",23700,1],
	["rhsgref_hidf_m1025_mk19",23700,1],
	["O_T_Truck_02_fuel_F",14800,1],
	["rhsusf_M1078A1P2_B_WD_fmtv_usarmy",5900,1],
	["rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy",12200,1],
	["rhsusf_M1078A1P2_B_M2_WD_flatbed_fmtv_usarmy",7400,1],
	["rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy",3000,1],
	["rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy",23900,1],
	["rhsusf_M1083A1P2_B_WD_fmtv_usarmy",5600,1],
	["rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy",16100,1],
	["rhsusf_M1083A1P2_B_WD_flatbed_fmtv_usarmy",4700,1],
	["rhsusf_M1083A1P2_B_M2_WD_flatbed_fmtv_usarmy",15000,1],
	["rhsusf_M1084A1P2_B_WD_fmtv_usarmy",4000,1],
	["rhsusf_M1084A1P2_B_M2_WD_fmtv_usarmy",12000,1],
	["rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy",21000,1],
	["rhsusf_M977A4_BKIT_usarmy_wd",3300,1],
	["rhsusf_M977A4_REPAIR_BKIT_usarmy_wd",21300,1],
	["rhsusf_M978A4_BKIT_usarmy_wd",25300,1],
	["rhsusf_M977A4_AMMO_BKIT_usarmy_wd",28100,1],
	["rhsusf_m1043_d",11400,1],
	["rhsusf_m1043_w",11400,1],
	["rhsusf_m1151_usarmy_wd",13800,1],
	["rhsusf_m1151_usarmy_d",13800,1],
	["rhssaf_army_o_m1151_olive",13800,1],
	["rhsusf_m1152_usarmy_wd",10500,1],
	["rhsusf_m1152_usarmy_d",10500,1],
	["rhssaf_army_o_m1152_olive",10500,1],
	["rhsusf_m1165_usarmy_wd",11500,1],
	["rhsusf_m1165_usarmy_d",11500,1],
	["rhsusf_m1152_rsv_usarmy_wd",14700,1],
	["rhsusf_m1152_rsv_usarmy_d",14700,1],
	["rhsusf_m1152_sicps_usarmy_wd",18300,1],
	["rhsusf_m1152_sicps_usarmy_d",18300,1],
	["rhs_tigr_vdv",9500,1],
	["rhs_tigr_3camo_vdv",10700,1],
	["O_MRAP_02_F",12500,1],
	["O_T_MRAP_02_ghex_F",12500,1],
	["rhs_typhoon_vdv",17200,1],
	["rhs_tigr_m_vdv",10700,1],
	["rhs_tigr_m_3camo_vdv",10900,1],
	["I_MRAP_03_F",12500,1],
	["rhsusf_CGRCAT1A2_usmc_wd",16400,1],
	["rhsusf_M1238A1_socom_d",18600,1],
	["rhsusf_M1239_socom_d",21000,1],
	["rhsusf_M1239_M2_deploy_socom_d",21000,1],
	["rhsusf_M1220_usarmy_d",26000,1],
	["rhsusf_M1220_usarmy_wd",26000,1],
	["rhsusf_M1220_MK19_usarmy_d",28300,1],
	["rhsusf_M1220_MK19_usarmy_wd",28300,1],
	["rhsusf_M1230a1_usarmy_d",32000,1],
	["rhsusf_M1230a1_usarmy_wd",32000,1],
	["rhsusf_M1232_usarmy_d",31000,1],
	["rhsusf_M1232_usarmy_wd",31000,1],
	["rhsusf_m1240a1_usarmy_d",26700,1],
	["LOP_NK_T34",82000,1],
	["rhsusf_m1043_d_m2",15900,1],
	["rhsusf_m1043_w_m2",15900,1],
	["rhsusf_m1043_d_mk19",21200,1],
	["rhsusf_m1043_w_mk19",21200,1],
	["rhssaf_army_o_m1151_olive_pkm",19500,1],
	["rhsusf_m1151_m240_v1_usarmy_wd",19500,1],
	["rhsusf_m1151_m240_v1_usarmy_d",19500,1],
	["rhsusf_m1151_m2_v1_usarmy_wd",20700,1],
	["rhsusf_m1151_m2_v1_usarmy_d",20700,1],
	["rhsusf_m1151_m2_lras3_v1_usarmy_wd",27800,1],
	["rhsusf_m1151_m2_lras3_v1_usarmy_d",27800,1],
	["rhsusf_m1151_mk19_v1_usarmy_wd",25200,1],
	["rhsusf_m1151_mk19_v1_usarmy_d",25200,1],
	["rhs_tigr_sts_vdv",30100,1],
	["rhs_tigr_sts_3camo_vdv",31400,1],	
	["rhsusf_M977A4_BKIT_M2_usarmy_wd",16800,1],
	["rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd",38000,1],
	["rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd",32000,1],
	["rhsusf_m1151_m240_v2_usarmy_wd",25100,1],
	["rhsusf_m1151_m240_v2_usarmy_d",25100,1],
	["rhsusf_m1165_asv_m240_usaf_d",26300,1],
	["rhsusf_m1151_m2_v2_usarmy_wd",28900,1],
	["rhsusf_m1151_m2_v2_usarmy_d",27900,1],
	["rhsusf_m1151_mk19_v2_usarmy_wd",31000,1],
	["rhsusf_m1151_mk19_v2_usarmy_d",31000,1],
	["rhsusf_m1165a1_gmv_m2_m240_socom_d",34000,1],
	["rhsusf_m1165a1_gmv_mk19_m240_socom_d",36000,1],
	["rhsusf_m113_usarmy_unarmed",43000,1],
	["rhsusf_m113d_usarmy_unarmed",43000,1],
	["rhsusf_m1151_m2crows_usarmy_wd",35000,1],
	["rhsusf_m1151_m2crows_usarmy_d",35000,1],
	["rhsusf_m1151_mk19crows_usarmy_wd",37100,1],
	["rhsusf_m1151_mk19crows_usarmy_d",37100,1],
	["rhsusf_m1165a1_gmv_m134d_m240_socom_d",40000,1],
	["rhsusf_CGRCAT1A2_M2_usmc_wd",21200,1],
	["rhsusf_CGRCAT1A2_Mk19_usmc_wd",25000,1],
	["rhsusf_M1238A1_M2_socom_d",26300,1],
	["rhsusf_M1238A1_Mk19_socom_d",29800,1],
	["rhsusf_M1239_M2_socom_d",25000,1],
	["rhsusf_M1239_MK19_socom_d",28000,1],
	["rhsusf_M1220_M153_M2_usarmy_d",36600,1],
	["rhsusf_M1220_M153_M2_usarmy_wd",36600,1],
	["rhsusf_M1220_M2_usarmy_d",31200,1],
	["rhsusf_M1220_M2_usarmy_wd",31200,1],
	["rhsusf_M1220_M153_MK19_usarmy_d",38900,1],
	["rhsusf_M1220_M153_MK19_usarmy_wd",38900,1],
	["rhsusf_M1239_MK19_deploy_socom_d",30100,1],
	["rhsusf_M1230_M2_usarmy_d",45000,1],
	["rhsusf_M1230_M2_usarmy_wd",40300,1],
	["rhsusf_M1230_MK19_usarmy_d",44500,1],
	["rhsusf_M1230_MK19_usarmy_wd",44800,1],
	["rhsusf_M1232_M2_usarmy_d",37800,1],
	["rhsusf_M1232_M2_usarmy_wd",37800,1],
	["rhsusf_M1232_MK19_usarmy_d",41300,1],
	["rhsusf_M1232_MK19_usarmy_wd",41300,1],
	["rhsusf_M1237_M2_usarmy_d",37200,1],
	["rhsusf_M1237_M2_usarmy_wd",37200,1],
	["rhsusf_M1237_MK19_usarmy_d",42500,1],
	["rhsusf_M1237_MK19_usarmy_wd",42500,1],
	["rhsusf_m113_usarmy_supply",58900,1],
	["rhsusf_m113d_usarmy_supply",58900,1],
	["rhsusf_m1240a1_m240_usarmy_d",31400,1],
	["rhsusf_m1240a1_m240_usarmy_wd",30800,1],
	["rhsusf_m1240a1_m2_usarmy_d",34500,1],
	["rhsusf_m1240a1_m2_usarmy_wd",34500,1],
	["rhsusf_m1240a1_mk19_usarmy_d",39600,1],
	["rhsusf_m1240a1_mk19_usarmy_wd",39600,1],
	["rhsusf_m113_usarmy_M240",45600,2],
	["rhsusf_m113_usarmy_MK19",49400,2],
	["rhsusf_m113d_usarmy_M240",45600,2],
	["rhsusf_m113d_usarmy_MK19",49400,2],
	["rhsusf_m1240a1_m240_uik_usarmy_wd",32200,2],
	["rhsusf_m1240a1_m240_uik_usarmy_d",33100,2],
	["rhsusf_m1240a1_m2_uik_usarmy_wd",36300,2],
	["rhsusf_m1240a1_m2_uik_usarmy_d",36300,2],
	["rhsusf_m1240a1_mk19_uik_usarmy_wd",39000,2],
	["rhsusf_m1240a1_mk19_uik_usarmy_d",39000,2],
	["rhsusf_M1117_d",56000,2],
	["rhsusf_M1117_O",56000,2],
	["rhsusf_M1117_W",56000,2],
	["rhsusf_m1240a1_m2crows_usarmy_d",38400,2],
	["rhsusf_m1240a1_m2crows_usarmy_wd",38400,2],
	["rhsusf_m1240a1_mk19crows_usarmy_d",43000,2],
	["rhsusf_m1240a1_mk19crows_usarmy_wd",43000,2],
	["rhsusf_m113_usarmy",52000,2],
	["rhsusf_m113d_usarmy",52000,2],
	["rhsgref_BRDM2_vdv",35000,2],
	["rhs_btr60_vdv",45000,2],
	["rhsusf_m1240a1_m2crows_usarmy_wd",39800,2],
	["rhsusf_m1240a1_m2crows_usarmy_d",39800,2],
	["rhsusf_m1240a1_mk19crows_usarmy_wd",41600,2],
	["rhsusf_m1240a1_mk19crows_usarmy_d",41600,2],
	["rhs_btr70_vdv",48200,2],
	["rhsusf_m966_w",45000,2],
	["rhsusf_m1245_m2crows_socom_deploy",44500,2],
	["rhsusf_m1245_mk19crows_socom_deploy",48500,2],
	["rhs_btr80_vdv",52000,2],
	["rhsgref_BRDM2_ATGM_vdv",40000,2],
	["rhsusf_m1045_w",49700,3],
	["rhsusf_stryker_m1126_m2_wd",60000,3],
	["rhsusf_stryker_m1127_m2_wd",63000,3],	
	["rhsusf_stryker_m1132_m2_wd",65000,3],
	["rhsusf_stryker_m1134_wd",65000,3],
	["I_LT_01_cannon_F",65000,3],
	["I_LT_01_AT_F",66000,3],
	["I_LT_01_AA_F",67000,3],
	["rhs_brm1k_tv",66100,3],
	["rhsusf_stryker_m1126_mk19_wd",67000,3],
	["rhs_bmp1_tv",65000,3],
	["rhs_bmp1k_tv",66000,3],
	["rhs_bmp1p_tv",67000,3],
	["rhs_bmp1d_tv",70000,3],
	["rhs_prp3_tv",71000,3],
	["rhs_btr80a_vdv",78000,3],
	["rhs_bmd1r",50000,4],
	["rhs_bmd1k",55500,4],
	["rhs_bmd1pk",57000,4],
	["rhs_bmd1",59000,4],
	["rhs_bmd1p",60000,4],
	["rhs_bmd2k",74000,4],
	["rhs_bmd2",74000,4],
	["rhs_bmd2m",77000,4],
	["rhs_zsu234_aa",60300,4],
	["rhs_bmd4_vdv",80000,4],
	["rhs_bmd4m_vdv",83000,4],
	["rhs_bmd4ma_vdv",85000,4],
	["rhs_bmp2e_tv",80000,4],
	["rhs_bmp2_tv",80400,4],
	["rhs_bmp2k_tv",81800,4],
	["rhs_bmp2d_tv",85000,4],
	["LOP_NK_T55",87700,4],
	["RHS_M2A2_wd",89000,5],
	["RHS_M2A2",89000,5],
	["RHS_M2A3_wd",91000,5],
	["RHS_M2A3",91000,5],
	["RHS_M6_wd",91000,5],
	["RHS_M6",91000,5],
	["rhs_sprut_vdv",96000,5],
	["B_APC_Wheeled_01_cannon_F",100000,5],
	["B_T_APC_Wheeled_01_cannon_F",100000,5],
	["RHS_BM21_MSV_01",100000,6],
	["RHS_M2A2_BUSKI_WD",105000,6],
	["RHS_M2A2_BUSKI",105000,6],
	["RHS_M2A3_BUSKI_wd",110000,6],
	["RHS_M2A3_BUSKI",110000,6],
	["RHS_M2A3_BUSKIII_wd",115000,6],
	["RHS_M2A3_BUSKIII",115000,6],
	["rhs_t72ba_tv",120000,6],
	["rhs_2s1_at_tv",100000,6],
	["rhs_2s1_tv",123000,6],
	["rhs_2s3_at_tv",100000,6],
	["rhs_2s3_tv",123000,6],
	["rhs_t80",127000,6],
	["rhs_t80b",130000,6],
	["rhs_t80bk",130000,6],
	["rhs_t80a",133000,6],
	["rhs_t80bv",134000,6],
	["rhs_t72bb_tv",134000,6],
	["rhs_t72bc_tv",134000,6],
	["rhs_t80bvk",136000,6],	
	["rhsusf_M142_usmc_WD",138000,6],
	["rhsusf_M142_usarmy_WD",138000,6],
	["rhsusf_M142_usarmy_D",138000,6],
	["rhsusf_m109_usarmy",145000,6],
	["rhsusf_m109d_usarmy",145000,6],
	["rhs_t80u",145000,6],
	["rhs_t80u45m",149000,6],
	["rhs_t90_tv",165000,6],
	// появилась агава
	["rhs_t80um",150000,7],
	["rhs_t80uk",150000,7],
	//
	["rhssaf_army_o_t72s",155000,7],
	["rhs_t80ue1",160000,7],
	["rhs_t72bd_tv",162000,7],
	["rhs_t72be_tv",170000,8],
	["rhs_t90a_tv",175000,8],
	["rhsusf_m1a1hc_wd",180000,8],
	["rhsusf_m1a1fep_wd",183000,8],
	["rhsusf_m1a1fep_od",183000,8],
	["rhs_t90saa_tv",180000,8],
	["rhs_t90sab_tv",182000,8],
	["rhsusf_m1a1aimwd_usarmy",185000,8],
	["rhsusf_m1a1aimd_usarmy",185000,8],
	["rhsusf_m1a2sep1d_usarmy",190000,8],
	["rhsusf_m1a2sep1wd_usarmy",190000,8],
	["rhsusf_m1a1aim_tuski_d",195500,9],
	["rhsusf_m1a1aim_tuski_wd",197500,9],
	["rhs_t90am_tv",197500,9],
	["rhs_t90sm_tv",198000,10],
	["rhs_t15_tv",115000,10],
	["rhsusf_m1a2sep1tuskid_usarmy",200000,10],
	["rhsusf_m1a2sep1tuskiwd_usarmy",200000,10],	
	["rhsusf_m1a2sep1tuskiiwd_usarmy",210000,10],
	["rhsusf_m1a2sep1tuskiid_usarmy",210000,10],
	["rhs_t14_tv",210000,10]
];

shop_air_vehicles = [
	["C_Quadbike_01_F",0,0],
	["RHS_AN2_B",18000,0],
	["C_Plane_Civil_01_F",14000,0],
	["C_Heli_Light_01_civil_F",17000,0],
	["rhs_uh1h_hidf_unarmed",22000,1],
	["RHS_Mi8t_civilian",31700,1],
	["RHS_Mi8amt_civilian",34200,1],		
	["RHS_Mi8mt_vvs",33000,2],
	["RHS_Mi8mt_vvsc",34000,2],	
	["I_Heli_light_03_unarmed_F",35000,2],
	["RHS_Mi8mt_Cargo_vvs",36000,2],
	["RHS_Mi8mt_Cargo_vvsc",37000,2],
	["O_Heli_Transport_04_bench_F",37000,2],
	["RHS_MELB_H6M",37000,2],
	["RHS_MELB_MH6M",40000,2],
	["O_Heli_Transport_04_medevac_F",36000,3],
	["RHS_Mi8AMT_vvs",37400,3],
	["RHS_Mi8AMT_vvsc",38100,3],
	["RHS_UH1Y_UNARMED_d",40500,4],
	["O_Heli_Transport_04_covered_F",41000,4],
	["RHS_CH_47F_10",45000,4],
	["RHS_CH_47F_light",45000,4],
	["rhsusf_CH53E_USMC_d",65500,4],
	["O_Heli_Transport_04_fuel_F",66000,4],
	["O_Heli_Transport_04_repair_F",68000,4],
	["O_Heli_Transport_04_ammo_F",70000,4],
	["RHS_C130J",96000,4],
	["RHS_C130J_Cargo",99000,4],
	["rhs_ka60_grey",30000,5],
	["rhs_ka60_c",30000,5],
	["I_Heli_Transport_02_F",32000,5],
	["RHS_UH60M2",35000,5],
	["RHS_UH60M_MEV2",37000,5],
	["RHS_UH60M",38000,5],
	["RHS_UH60M_ESSS2",42700,5],
	["RHS_UH60M_ESSS",45000,5],
	["RHS_MELB_AH6M",37900,5],
	["RHS_UH1Y_FFAR_d",52000,5],
	["RHS_UH1Y_d",55000,5],
	["RHS_Mi8MTV3_vvs",68500,6],
	["RHS_Mi8MTV3_vvsc",68500,6],
	["RHS_Mi8AMTSh_vvs",79500,6],
	["RHS_Mi8AMTSh_vvsc",79500,6],
	["RHS_Mi24P_vvs",110000,7],
	["RHS_Mi24P_vvsc",110000,7],
	["RHS_Mi24V_vvs",120000,7],
	["RHS_Mi24V_vvsc",122000,7],
	["RHSGREF_A29B_HIDF",80000,8],
	["RHS_Su25SM_vvs",160000,8],
	["RHS_Su25SM_vvsc",161000,8],
	["rhs_mi28n_vvs",184000,8],
	["rhs_mi28n_vvsc",185000,8],
	["rhs_l159_cdf_b_CDF",190000,8],
	["RHS_AH1Z",190000,9],
	["RHS_Ka52_vvsc",190000,9],
	["RHS_Ka52_vvs",190000,9],
	["RHS_AH64D",205000,9],
	["RHS_AH64DGrey",207000,9],
	["RHS_A10",220000,9],
	["rhs_mig29s_vmf",210000,10],
	["rhs_mig29s_vvsc",210000,10],
	["rhs_mig29sm_vmf",260000,10],
	["rhs_mig29sm_vvsc",260000,10],
	["rhsusf_f22",230000,10],
	["RHS_T50_vvs_generic_ext",227000,10]
];

// vehicle loadout items [category,[item,item...]]
vehicle_loadout_items = [
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
];

// tasks / [name,reward]
tasksConfig = [
	["side_alarm_button",3000],
	["side_ammo_cache",3000],
	["side_capture_leader",3500],
	["side_capture_zone",2800],
	["side_checkpoint",2000],
	["side_destroy_tower",3000],
	["side_destruction_of_vehicles",3000],
	["side_hostage",3500],
	["side_intel_uav",4000],
	["side_liquidation_leader",2000],
	["side_rescue",4000]
];

// debug mode
prj_debug = false;