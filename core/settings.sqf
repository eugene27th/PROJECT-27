/*
	written by eugene27.
	1.3.0
	___________________
	russian (original):

	____________
	> параметры:

	• предустановка карты:
		"european_aggressor" - рекомендуется для таких карт как: rosche, chernarus, livonia и т.д. (европейские карты)
		"middle_east" - рекомендуется для таких карт как: takistan, fallujah, lithium и т.д. (средне-восточные карты)

	*о редактировании конфигурации спавна юнитов можно узнать в файле "core\unit_spawn_system\configuration.sqf"

	_______________________________________________
	> переход на карту, которая есть в папке "mission_sqm":

	• переименуйте нужный вам файл из папки "missions_sqm" в "mission.sqm" и замените им оригинальный
	• измените "расширение" папки (директории) миссии в зависимости от выбранной карты
	• расширения карт, которые есть в "missions_sqm":
		- takistan - .takistan
		- fallujah - .fallujah
		- lithium - .Lythium
		- rosche - .WL_Rosche
		- chernarus - .chernarus
		- chernarus summer - .chernarus_summer
		- chernarus winter - .Chernarus_Winter
	• (по усмотрению) измените предустановку карты (_map_preset), в зависимости от выбранной карты
	• (не обязательно. если знаете как.) можете изменить (или добавить свой) пресет конфигурации спавна юнитов в файле "core\unit_spawn_system\configuration.sqf"
	• играть :)

	______________________________________________________________
	> портирование на другие карты, которых нет в папке "mission_sqm":

	• в редакторе расставьте объекты на базах
	• (по усмотрению) измените предустановку карты (_map_preset), в зависимости от выбранной карты
	• (не обязательно. если знаете как.) можете изменить (или добавить свой) пресет конфигурации спавна юнитов в файле "core\unit_spawn_system\configuration.sqf"
	• играть
	• сообщать о багах, если они появятся
*/

if (isServer) then {

	//////// map preset / предустановка карты \\\\\\\\
	_map_preset = "middle_east";

	////// preset configuration. don’t know? don’t change. \\\\\\
	switch (_map_preset) do {
		case "european_aggressor": {
			box_ammo_cache = "Box_FIA_Ammo_F";
			idap_vehicles_array = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
			idap_units_array = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
			civilian_units_array = ["LOP_CHR_Civ_Citizen_03","LOP_CHR_Civ_Citizen_04","LOP_CHR_Civ_Citizen_01","LOP_CHR_Civ_Citizen_02","LOP_CHR_Civ_Profiteer_02","LOP_CHR_Civ_Profiteer_03","LOP_CHR_Civ_Profiteer_01","LOP_CHR_Civ_Profiteer_04","LOP_CHR_Civ_Villager_01","LOP_CHR_Civ_Villager_04","LOP_CHR_Civ_Villager_03","LOP_CHR_Civ_Villager_02","LOP_CHR_Civ_Woodlander_01","LOP_CHR_Civ_Woodlander_02","LOP_CHR_Civ_Woodlander_03","LOP_CHR_Civ_Woodlander_04","LOP_CHR_Civ_Worker_03","LOP_CHR_Civ_Worker_04","LOP_CHR_Civ_Worker_01","LOP_CHR_Civ_Worker_02","C_man_p_fugitive_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_p_beggar_F","C_Story_Mechanic_01_F","C_Nikos"];
			civilian_cars_array = ["C_Offroad_01_F","C_Van_01_transport_F","C_Tractor_01_F","C_Van_02_transport_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Offroad_02_unarmed_F","LOP_CHR_Civ_Landrover","LOP_CHR_Civ_UAZ","LOP_CHR_Civ_UAZ_Open","LOP_CHR_Civ_Hatchback","LOP_CHR_Civ_Offroad"];
			enemy_units_array = ["rhsgref_nat_pmil_grenadier_rpg","rhsgref_nat_pmil_saboteur","rhsgref_nat_pmil_hunter","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_scout","rhsgref_nat_pmil_medic","rhsgref_nat_pmil_grenadier","rhsgref_nat_pmil_specialist_aa","rhsgref_nat_pmil_rifleman_akm","rhsgref_nat_pmil_rifleman_aksu","rhsgref_nat_pmil_rifleman","rhsgref_nat_grenadier_rpg","rhsgref_nat_saboteur","rhsgref_nat_medic","rhsgref_nat_militiaman_kar98k","rhsgref_nat_militiaman_kar98k","rhsgref_nat_hunter","rhsgref_nat_machinegunner","rhsgref_nat_machinegunner_mg42","rhsgref_nat_scout","rhsgref_nat_grenadier","rhsgref_nat_specialist_aa","rhsgref_nat_rifleman_akms","rhsgref_nat_rifleman_aks74","rhsgref_nat_rifleman_mp44","rhsgref_nat_rifleman","rhsgref_nat_rifleman_vz58","LOP_NAPA_Infantry_Engineer","LOP_NAPA_Infantry_GL_2","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_Rifleman_3","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman_2","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_MG_Asst","LOP_NAPA_Infantry_Corpsman","rhsgref_nat_pmil_hunter"];
			enemy_leaders_array = ["LOP_NAPA_Infantry_Prizrak","LOP_NAPA_Infantry_SL","rhsgref_nat_commander","rhsgref_nat_pmil_commander"];
			enemy_cars_array = ["rhssaf_m1025_olive_m2","rhssaf_m1025_olive","rhssaf_m998_olive_2dr_fulltop","rhssaf_m998_olive_2dr_halftop","LOP_NAPA_Truck","LOP_NAPA_Landrover","LOP_NAPA_Landrover_M2","LOP_NAPA_Offroad","LOP_NAPA_Offroad_M2","rhsgref_nat_uaz","rhsgref_nat_uaz_open","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_dshkm","rhsgref_nat_uaz_spg9","rhsgref_nat_van","rhsgref_nat_van_fuel","rhsgref_nat_ural","rhsgref_nat_ural_Zu23","rhsgref_nat_ural_open","rhsgref_nat_ural_work","rhsgref_nat_ural_work_open"];
			enemy_heli_array = ["I_Heli_light_03_unarmed_F"];
			enemy_static_array = ["rhsgref_nat_DSHKM","rhsgref_nat_Igla_AA_pod","rhsgref_nat_SPG9","rhsgref_nat_AGS30_TriPod","rhsgref_nat_DSHKM_Mini_TriPod","rhsgref_nat_NSV_TriPod","rhsgref_nat_ZU23","LOP_NAPA_Kord","LOP_NAPA_Kord_High","LOP_NAPA_Igla_AA_pod","LOP_NAPA_AGS30_TriPod","LOP_NAPA_Static_M2","LOP_NAPA_Static_M2_MiniTripod","LOP_NAPA_Static_Mk19_TriPod","LOP_NAPA_NSV_TriPod"];
			enemy_heavy_armed_vehicle_array = ["rhsgref_nat_btr70"];
			towers_array = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
			friendly_cars_array = ["rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19","rhsusf_m1025_w","rhsusf_m1043_w_m2","rhsusf_m1043_w_mk19","rhsusf_m1043_w","rhsusf_m1045_w","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr","rhsusf_m998_w_4dr_fulltop","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr","rhsusf_M1220_usarmy_wd","rhsusf_M1220_M153_M2_usarmy_wd","rhsusf_M1220_M2_usarmy_wd","rhsusf_M1220_M153_MK19_usarmy_wd","rhsusf_M1220_MK19_usarmy_wd","rhsusf_M1230_M2_usarmy_wd","rhsusf_M1230_MK19_usarmy_wd","rhsusf_M1230a1_usarmy_wd","rhsusf_M1232_usarmy_wd","rhsusf_M1232_M2_usarmy_wd","rhsusf_M1232_MK19_usarmy_wd","rhsusf_M1237_M2_usarmy_wd","rhsusf_M1237_MK19_usarmy_wd","rhsusf_m1240a1_usarmy_wd","rhsusf_m1240a1_m2crows_usarmy_wd","rhsusf_m1240a1_m2_usarmy_wd","rhsusf_m1240a1_m240_usarmy_wd","rhsusf_m1240a1_mk19crows_usarmy_wd","rhsusf_m1240a1_mk19_usarmy_wd","rhs_tigr_vdv","rhs_tigr_m_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv","rhs_tigr_sts_vdv","rhs_gaz66_vdv","rhs_gaz66_flat_vdv","rhs_gaz66_zu23_vdv","rhs_gaz66_r142_vdv","rhs_gaz66_ammo_vdv","rhs_gaz66o_vdv","rhs_gaz66_ap2_vdv","rhs_gaz66_repair_vdv","rhs_typhoon_vdv","RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","RHS_Ural_Repair_VDV_01","rhs_gaz66o_flat_vdv","rhs_kamaz5350_vdv","rhs_kamaz5350_flatbed_cover_vdv","rhs_kamaz5350_open_vdv","rhs_kamaz5350_flatbed_vdv","RHS_Ural_Flat_VDV_01","rhs_zil131_vdv","rhs_zil131_flatbed_cover_vdv","rhs_zil131_open_vdv","rhs_zil131_flatbed_vdv"];
			friendly_heli_array = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];
			friendly_blue_armored_car = "rhsusf_m1240a1_m2crows_usarmy_wd";
			friendly_red_armored_car = "rhs_tigr_sts_vdv";
			friendly_blue_units_array = ["rhsusf_usmc_marpat_wd_grenadier","rhsusf_usmc_marpat_wd_riflemanat","rhsusf_usmc_marpat_wd_grenadier_m32","rhsusf_usmc_marpat_wd_teamleader","rhsusf_usmc_marpat_wd_squadleader","rhsusf_usmc_marpat_wd_jfo","rhsusf_usmc_marpat_wd_javelin","rhsusf_usmc_marpat_wd_smaw","rhsusf_usmc_marpat_wd_machinegunner","rhsusf_usmc_marpat_wd_autorifleman_m249","rhsusf_usmc_marpat_wd_autorifleman","rhsusf_usmc_marpat_wd_sniper_m110","rhsusf_usmc_marpat_wd_sniper","rhsusf_usmc_marpat_wd_engineer","rhsusf_usmc_marpat_wd_marksman","rhsusf_usmc_marpat_wd_stinger","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman_m4"];
			friendly_red_units_array = ["rhs_vdv_grenadier_rpg","rhs_vdv_efreitor","rhs_vdv_engineer","rhs_vdv_junior_sergeant","rhs_vdv_machinegunner","rhs_vdv_arifleman","rhs_vdv_medic","rhs_vdv_sergeant","rhs_vdv_marksman","rhs_vdv_marksman_asval","rhs_vdv_aa","rhs_vdv_rifleman","rhs_vdv_grenadier","rhs_vdv_rifleman_asval","rhs_vdv_grenadier_alt","rhs_vdv_LAT","rhs_vdv_RShG2","rhs_vdv_rifleman_alt","rhs_vdv_at"];
			mines_array = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];
		};
		case "middle_east": {
			box_ammo_cache = "Box_FIA_Ammo_F";
			idap_vehicles_array = ["C_IDAP_Offroad_02_unarmed_F","C_IDAP_Offroad_01_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F"];
			idap_units_array = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_03_F"];
			civilian_units_array = ["LOP_Tak_Civ_Man_06","LOP_Tak_Civ_Man_08","LOP_Tak_Civ_Man_07","LOP_Tak_Civ_Man_05","LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_10","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_09","LOP_Tak_Civ_Man_11","LOP_Tak_Civ_Man_12","LOP_Tak_Civ_Man_04","LOP_Tak_Civ_Man_14","LOP_Tak_Civ_Man_13","LOP_Tak_Civ_Man_16","LOP_Tak_Civ_Man_15"];
			civilian_cars_array = ["LOP_TAK_Civ_Ural","LOP_TAK_Civ_Ural_open","LOP_TAK_Civ_UAZ","LOP_TAK_Civ_UAZ_Open","LOP_TAK_Civ_Hatchback","LOP_TAK_Civ_Landrover","LOP_TAK_Civ_Offroad"];
			enemy_units_array = ["LOP_AM_Infantry_Engineer","LOP_AM_Infantry_Corpsman","LOP_AM_Infantry_GL","LOP_AM_Infantry_Rifleman_6","LOP_AM_Infantry_Rifleman","LOP_AM_Infantry_Rifleman_2","LOP_AM_Infantry_Rifleman_4","LOP_AM_Infantry_Rifleman_5","LOP_AM_Infantry_Rifleman_7","LOP_AM_Infantry_Rifleman_8","LOP_AM_Infantry_AT","LOP_AM_Infantry_Marksman","LOP_AM_Infantry_Rifleman_9","LOP_AM_Infantry_AR","LOP_AM_Infantry_AR_Asst","LOP_AM_Infantry_SL","LOP_ISTS_Infantry_Engineer","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_TL","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Rifleman_6","LOP_ISTS_Infantry_Rifleman","LOP_ISTS_Infantry_Rifleman_4","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Rifleman_7","LOP_ISTS_Infantry_AR_Asst_2","LOP_ISTS_Infantry_AR_2","LOP_ISTS_Infantry_AR_Asst","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Rifleman_9","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_Rifleman_8","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_B_Corpsman","LOP_ISTS_Infantry_B_GL","LOP_ISTS_Infantry_B_Rifleman","LOP_ISTS_Infantry_B_AT","LOP_ISTS_Infantry_B_Marksman","LOP_ISTS_Infantry_B_AR"];
			enemy_leaders_array = ["LOP_ISTS_Infantry_SL","LOP_AM_Infantry_SL","LOP_ISTS_Infantry_B_SL"];
			enemy_cars_array = ["LOP_AFR_Landrover","LOP_AFR_Landrover_M2","LOP_AFR_Landrover_SPG9","LOP_AM_Nissan_PKM","LOP_AM_UAZ","LOP_AM_UAZ_AGS","LOP_AM_UAZ_DshKM","LOP_AM_UAZ_Open","LOP_AM_UAZ_SPG","LOP_ISTS_Landrover","LOP_ISTS_Landrover_M2","LOP_ISTS_Landrover_SPG9","LOP_ISTS_M1025_W_M2","LOP_ISTS_M1025_W_Mk19","LOP_ISTS_M1025_D","LOP_ISTS_M998_D_4DR","LOP_ISTS_Offroad","LOP_ISTS_Offroad_M2","LOP_ISTS_Offroad_AT","LOP_ISTS_Truck"];
			enemy_heli_array = [];
			enemy_static_array = ["LOP_AM_Static_DSHKM","LOP_AM_Kord","LOP_AM_Kord_High","LOP_AM_Igla_AA_pod","LOP_AM_Static_AT4","LOP_AM_Static_SPG9","LOP_AM_AGS30_TriPod","LOP_AM_Static_M2","LOP_AM_Static_M2_MiniTripod","LOP_AM_Static_Mk19_TriPod","LOP_AM_NSV_TriPod","LOP_AM_Static_ZU23"];
			enemy_heavy_armed_vehicle_array = ["LOP_AM_BTR60","LOP_ISTS_BTR60","LOP_ISTS_M113_W","LOP_ISTS_BMP2","LOP_ISTS_BMP1","LOP_ISTS_ZSU234","LOP_ISTS_T55","LOP_ISTS_T72BA","LOP_IRAN_ZSU234"];
			towers_array = [["Land_TTowerSmall_1_F","Land_Portable_generator_F"],["Land_TTowerSmall_2_F","Land_PowerGenerator_F"]];
			friendly_cars_array = ["rhsusf_m1043_d","rhsusf_M1220_usarmy_d","rhsusf_M1232_usarmy_d","rhsusf_M1078A1P2_D_fmtv_usarmy","rhs_tigr_3camo_vdv","rhs_tigr_sts_3camo_vdv","rhs_tigr_m_3camo_vdv","rhs_gaz66_vdv","rhsusf_M1084A1P2_D_fmtv_usarmy","rhsusf_M977A4_usarmy_d","rhs_gaz66o_vdv","rhs_kamaz5350_open_vdv","rhs_zil131_vdv","RHS_Ural_VDV_01"];
			friendly_heli_array = ["rhs_uh1h_hidf","RHS_UH60M","RHS_CH_47F","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_Mi8mt_vvsc","RHS_Mi8AMT_vvsc","rhs_ka60_c","RHS_UH1Y_UNARMED_d"];
			friendly_blue_armored_car = "rhsusf_m1240a1_m2_usarmy_d";
			friendly_red_armored_car = "rhs_tigr_sts_3camo_vdv";
			friendly_blue_units_array = ["rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_javelin","rhsusf_army_ocp_maaws","rhsusf_army_ocp_autorifleman","rhsusf_army_ocp_medic","rhsusf_army_ocp_engineer","rhsusf_army_ocp_explosives","rhsusf_army_ocp_fso","rhsusf_army_ocp_grenadier","rhsusf_army_ocp_rifleman","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_sniper","rhsusf_army_ocp_teamleader"];
			friendly_red_units_array = ["rhs_vdv_des_aa","rhs_vdv_des_at","rhs_vdv_des_arifleman","rhs_vdv_des_efreitor","rhs_vdv_des_engineer","rhs_vdv_des_grenadier_rpg","rhs_vdv_des_junior_sergeant","rhs_vdv_des_machinegunner","rhs_vdv_des_marksman","rhs_vdv_des_medic","rhs_vdv_des_grenadier","rhs_vdv_des_LAT","rhs_vdv_des_RShG2"];
			mines_array = ["APERSBoundingMine","ATMine","APERSMine","ACE_IEDLandBig_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanSmall_Range"];
		};
	};

	////// DO NOT CHANGE \\\\\\
	friendly_UAV_array = "B_UAV_02_dynamicLoadout_F";
};