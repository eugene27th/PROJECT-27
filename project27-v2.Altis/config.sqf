debugMode = true;

configSectors = [
	1500, // safe distance
	600, // distance
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
			230,
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

configUnits = [
	[
		independent,
		[
			["I_E_Officer_F"], // leaders
			["I_L_Looter_SMG_F","I_L_Looter_Rifle_F","I_L_Looter_SG_F","I_L_Looter_Pistol_F"], // infantry
			["I_G_Offroad_01_F", "I_C_Offroad_02_unarmed_F"], // light vehicles
			["I_G_Offroad_01_armed_F", "I_C_Offroad_02_LMG_F"], // armed vehicles
			["I_E_APC_tracked_03_cannon_F", "I_APC_Wheeled_03_cannon_F"], // heavy vehicles
			["I_C_HMG_02_high_F", "B_T_Static_AT_F"] // static
		]
	],
	[
		["C_Man_formal_4_F", "C_Man_casual_3_F", "C_Man_casual_8_F"], // units
		["C_SUV_01_F", "C_Hatchback_01_F"] // vehs
	]
];