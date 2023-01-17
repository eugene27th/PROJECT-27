debugMode = true;

numberOfIedOnRoads = 20;
numberOfCheckpoints = 10;
numberOfMaximumParkedVehiclesInSector = 4;

configSectors = [
	1500,
	600,
	[
		[
			"NameCityCapital",
			360,
			[
				[[7,2],[3,1],[1,1],[1,1],[1,1]], [[1,1],[3,0],[1,1]]
			]
		],
		[
			"NameCity",
			320,
			[
				[[7,2],[3,1],[1,1],[1,1],[1,1]], [[1,1],[3,0],[1,1]]
			]
		],
		[
			"NameVillage",
			250,
			[
				[[7,2],[3,1],[1,1],[1,1],[1,1]], [[1,1],[3,0],[1,1]]
			]
		],
		[
			"NameLocal",
			150,
			[
				[[7,2],[3,1],[1,1],[1,1],[1,1]], [[1,1],[3,0],[1,1]]
			]
		],
		[
			"Hill",
			50,
			[
				[[7,2],[3,1],[1,1],[1,1],[1,1]], [[1,1],[3,0],[1,1]]
			]
		]
	]
];

customSectors = [
	[
		[
			[0, 0, 0],
			360,
			[
				[[7,2],[3,1],[1,1],[1,1],[1,1]], [[1,1],[3,0],[1,1]]
			]
		],
		[
			[2000, 0, 0],
			200,
			[
				[[7,2],[3,1],[1,1],[1,1],[1,1]], [[1,1],[3,0],[1,1]]
			]
		]
	], 
	[
		[
			[4000, 0, 0],
			500
		]
	]
];

configUnits = [
	[
		independent,
		[
			["I_L_Looter_SMG_F","I_L_Looter_Rifle_F","I_L_Looter_SG_F","I_L_Looter_Pistol_F", "I_Soldier_AA_F", "I_Soldier_AT_F", "I_E_Soldier_AA_F", "I_E_Soldier_AT_F", "I_E_Soldier_LAT_F", "I_Soldier_LAT_F"], // infantry
			["I_G_Offroad_01_F", "I_C_Offroad_02_unarmed_F"], // light vehicles
			["I_G_Offroad_01_armed_F", "I_C_Offroad_02_LMG_F"], // armed vehicles
			["I_E_APC_tracked_03_cannon_F", "I_APC_Wheeled_03_cannon_F"], // heavy vehicles
			["I_C_HMG_02_high_F", "B_T_Static_AT_F"], // turrets
			["I_Heli_light_03_unarmed_F"] // transport helicopters
		]
	],
	[
		["C_Man_formal_4_F", "C_Man_casual_3_F", "C_Man_casual_8_F"], // units
		["C_SUV_01_F", "C_Hatchback_01_F"] // vehs
	]
];

configTasks = [
	["ammoCache"], // [task name (without "ts_" prefix), in nearest sectors, in captured sectors]
	["sectorCapture"],
	["hostageRescue"],
	["crewRescue"],
	["highValueTarget"],
	["mineClearance"]
];

configObjects = [
	[ // road ied
		["ACE_IEDUrbanBig_Range","ACE_IEDLandBig_Range","ACE_IEDUrbanSmall_Range","ACE_IEDLandSmall_Range","ACE_SLAMBottomMine","BombCluster_01_UXO1_F","BombCluster_03_UXO1_F"],
		["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"]
	]
];

additionalClassesToVehicleSpawnList = ["Land_dataTerminal_01_F", "Land_CanisterFuel_F", "ACE_Wheel", "ACE_Track", "Land_WoodenCrate_01_F"];

configLoadoutItems = [
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