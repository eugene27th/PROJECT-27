/*
	written by eugene27.
	global
*/

// map preset / предустановка карты // presets: "middle_east", "european_aggressor"
private _map_preset = "middle_east";

// arsenal black list / чёрный лист арсенала. предметы, которых не будет в арсенале.
arsenal_black_list = ["launch_B_Titan_short_tna_F","launch_B_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_short_ghex_F","launch_O_Titan_short_F","launch_B_Titan_tna_F","launch_B_Titan_F","launch_B_Titan_olive_F","launch_O_Titan_F","launch_O_Titan_ghex_F","launch_I_Titan_eaf_F","launch_I_Titan_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","H_HelmetO_ViperSP_ghex_F","H_HelmetO_ViperSP_hex_F","Laserdesignator_02_ghex_F","Laserdesignator_02","optic_Nightstalker","FirstAidKit","optic_DMS","optic_DMS_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_LRPS","optic_LRPS_tna_F","optic_LRPS_ghex_F","optic_NVS","ACE_optic_Hamr_2D","ACE_optic_Hamr_PIP","optic_tws","optic_tws_mg","ace_csw_staticGMGCarry","ace_csw_staticHMGCarry","ace_csw_staticATCarry","ace_csw_staticAACarry","H_HelmetIA","H_HelmetLeaderO_ocamo","H_HelmetO_ocamo","H_HelmetSpecO_ocamo","H_HelmetLeaderO_oucamo","H_HelmetO_oucamo","H_HelmetSpecO_blk","H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F","H_HelmetSpecO_ghex_F","H_HelmetLeaderO_ghex_F","H_HelmetO_ghex_F","H_HelmetHBK_headset_F","H_HelmetHBK_chops_F","H_HelmetHBK_ear_F","H_HelmetHBK_F","H_HelmetB_TI_tna_F","H_HelmetAggressor_F","H_HelmetAggressor_cover_F","H_HelmetAggressor_cover_taiga_F","H_HelmetCrew_I","H_HelmetCrew_O","H_HelmetCrew_B","G_Goggles_VR","U_I_Protagonist_VR","U_O_Protagonist_VR","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F","Laserdesignator_02","U_C_Protagonist_VR","U_O_V_Soldier_Viper_F","U_B_T_Sniper_F","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_rgr","U_O_T_Sniper_F","U_B_Protagonist_VR","U_I_GhillieSuit","U_O_GhillieSuit","U_B_GhillieSuit","U_O_V_Soldier_Viper_hex_F","V_PlateCarrierSpec_wdl","O_NVGoggles_hex_F","O_NVGoggles_urb_F","O_NVGoggles_ghex_F","O_NVGoggles_grn_F"];

// hq uid / uid тех, кто будут иметь доступ к ключевым опциям миссии вне зависимости от роли
hqUID = ["76561198141746661","76561198138702011","76561198343937417","76561198061237087"];

// units configuration. don’t know? don’t change.
switch (_map_preset) do {
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

		enemy_vehicles_light = ["rhssaf_m1025_olive_m2","rhssaf_m1025_olive","rhssaf_m998_olive_2dr_fulltop","rhssaf_m998_olive_2dr_halftop","LOP_NAPA_Truck","LOP_NAPA_Landrover","LOP_NAPA_Landrover_M2","LOP_NAPA_Offroad","LOP_NAPA_Offroad_M2","rhsgref_nat_uaz","rhsgref_nat_uaz_open","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_dshkm","rhsgref_nat_uaz_spg9","rhsgref_nat_van","rhsgref_nat_van_fuel","rhsgref_nat_ural","rhsgref_nat_ural_Zu23","rhsgref_nat_ural_open","rhsgref_nat_ural_work","rhsgref_nat_ural_work_open"];
		enemy_vehicles_heavy = ["rhsgref_nat_btr70"];
		enemy_turrets = ["rhsgref_nat_DSHKM","rhsgref_nat_Igla_AA_pod","rhsgref_nat_SPG9","rhsgref_nat_AGS30_TriPod","rhsgref_nat_DSHKM_Mini_TriPod","rhsgref_nat_NSV_TriPod","rhsgref_nat_ZU23","LOP_NAPA_Kord","LOP_NAPA_Kord_High","LOP_NAPA_Igla_AA_pod","LOP_NAPA_AGS30_TriPod","LOP_NAPA_Static_M2","LOP_NAPA_Static_M2_MiniTripod","LOP_NAPA_Static_Mk19_TriPod","LOP_NAPA_NSV_TriPod"];
		enemy_helicopters = ["I_Heli_light_03_unarmed_F"];

		// mission objects
		box_ammo_cache = "Box_FIA_Ammo_F";

		towers = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];

		ied = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];
	};
	case "middle_east": {

		// units and vehicles
		friendly_helicopters = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];

		idap_units = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
		idap_vehicles = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
		
		civilian_units = ["LOP_Tak_Civ_Man_06","LOP_Tak_Civ_Man_08","LOP_Tak_Civ_Man_07","LOP_Tak_Civ_Man_05","LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_10","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_09","LOP_Tak_Civ_Man_11","LOP_Tak_Civ_Man_12","LOP_Tak_Civ_Man_04","LOP_Tak_Civ_Man_14","LOP_Tak_Civ_Man_13","LOP_Tak_Civ_Man_16","LOP_Tak_Civ_Man_15"];
		civilian_vehicles = ["LOP_TAK_Civ_Ural","LOP_TAK_Civ_Ural_open","LOP_TAK_Civ_UAZ","LOP_TAK_Civ_UAZ_Open","LOP_TAK_Civ_Hatchback","LOP_TAK_Civ_Landrover","LOP_TAK_Civ_Offroad"];
		hostage_units = idap_units + ["C_journalist_F","C_Journalist_01_War_F","C_Man_UtilityWorker_01_F","C_Story_EOD_01_F"];

		enemy_leaders = ["LOP_ISTS_Infantry_SL","LOP_AM_Infantry_SL","LOP_ISTS_Infantry_B_SL"];
		enemy_infantry = ["LOP_AM_Infantry_Engineer","LOP_AM_Infantry_Corpsman","LOP_AM_Infantry_GL","LOP_AM_Infantry_Rifleman_6","LOP_AM_Infantry_Rifleman","LOP_AM_Infantry_Rifleman_2","LOP_AM_Infantry_Rifleman_4","LOP_AM_Infantry_Rifleman_5","LOP_AM_Infantry_Rifleman_7","LOP_AM_Infantry_Rifleman_8","LOP_AM_Infantry_AT","LOP_AM_Infantry_Marksman","LOP_AM_Infantry_Rifleman_9","LOP_AM_Infantry_AR","LOP_AM_Infantry_AR_Asst","LOP_AM_Infantry_SL","LOP_ISTS_Infantry_Engineer","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_TL","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Rifleman_6","LOP_ISTS_Infantry_Rifleman","LOP_ISTS_Infantry_Rifleman_4","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Rifleman_7","LOP_ISTS_Infantry_AR_Asst_2","LOP_ISTS_Infantry_AR_2","LOP_ISTS_Infantry_AR_Asst","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Rifleman_9","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_Rifleman_8","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_B_Corpsman","LOP_ISTS_Infantry_B_GL","LOP_ISTS_Infantry_B_Rifleman","LOP_ISTS_Infantry_B_AT","LOP_ISTS_Infantry_B_Marksman","LOP_ISTS_Infantry_B_AR"];
		
		enemy_vehicles_light = ["LOP_AFR_Landrover","LOP_AFR_Landrover_M2","LOP_AFR_Landrover_SPG9","LOP_AM_Nissan_PKM","LOP_AM_UAZ","LOP_AM_UAZ_AGS","LOP_AM_UAZ_DshKM","LOP_AM_UAZ_Open","LOP_AM_UAZ_SPG","LOP_ISTS_Landrover","LOP_ISTS_Landrover_M2","LOP_ISTS_Landrover_SPG9","LOP_ISTS_M1025_W_M2","LOP_ISTS_M1025_W_Mk19","LOP_ISTS_M1025_D","LOP_ISTS_M998_D_4DR","LOP_ISTS_Offroad","LOP_ISTS_Offroad_M2","LOP_ISTS_Offroad_AT","LOP_ISTS_Truck"];
		enemy_vehicles_heavy = ["LOP_AM_BTR60","LOP_ISTS_BTR60","LOP_ISTS_M113_W","LOP_ISTS_BMP2","LOP_ISTS_BMP1","LOP_ISTS_ZSU234","LOP_ISTS_T55","LOP_ISTS_T72BA","LOP_IRAN_ZSU234"];
		enemy_turrets = ["LOP_AM_Static_DSHKM","LOP_AM_Kord","LOP_AM_Kord_High","LOP_AM_Igla_AA_pod","LOP_AM_Static_AT4","LOP_AM_Static_SPG9","LOP_AM_AGS30_TriPod","LOP_AM_Static_M2","LOP_AM_Static_M2_MiniTripod","LOP_AM_Static_Mk19_TriPod","LOP_AM_NSV_TriPod","LOP_AM_Static_ZU23"];
		enemy_helicopters = [];
		
		// mission objects
		box_ammo_cache = "Box_FIA_Ammo_F";
		
		towers = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
		
		ied = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];
	};
};

// debug mode
prj_debug = false;