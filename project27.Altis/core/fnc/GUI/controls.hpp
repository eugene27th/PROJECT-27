class dialogHQmenu
{
	idd = 3000;
	
	class controls
	{
		class HQ_Header: prjRscText {
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
		};
		class HQ_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
			
			sizeEx = 0.025;
		};

		class HQ_MainBackground: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class HQ_HelloText: prjRscTextHQ
		{
			idc = 1001;
			text = ""; // hello
			x = 0.418 * safezoneW + safezoneX;
			y = 0.328 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.039375 * safezoneH;

			size = 0.03;
		};

		class HQ_Statistic_Pct: prjRscPicture
		{
			idc = 1029;
			text = "";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class HQ_Statistic_Text: prjRscStructuredText
		{
			idc = 1002;
			text = "";
			x = 0.412468 * safezoneW + safezoneX;
			y = 0.37934 * safezoneH + safezoneY;
			w = 0.150001 * safezoneW;
			h = 0.111198 * safezoneH;

			size = 0.026;
		};

		class HQ_To_MHQ_Back: prjRscText
		{
			colorBackground[] = { 0, 0, 0, 0.3 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.504 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_To_MHQ_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_to_mhq.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.504 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_To_MHQ_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "TO MHQ";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.504 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "call prj_fnc_tpmhq";
		};

		class HQ_Bank_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.3 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.548 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_Bank_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_bank.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.548 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;

			sizeEx = 0.05;
		};
		class HQ_Bank_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "BANK";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.548 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "call prj_fnc_bank_menu";
		};

		class HQ_Upgrades_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.3 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.592 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_Upgrades_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_upgrades.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.592 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_Upgrades_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "UPGRADES"; //--- ToDo: Localize;
			x = 0.444 * safezoneW + safezoneX;
			y = 0.592 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "call prj_fnc_upgrades_menu";
		};

		class HQ_Options_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.3 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.636 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_Options_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_options.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.636 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_Options_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "OPTIONS"; //--- ToDo: Localize;
			x = 0.444 * safezoneW + safezoneX;
			y = 0.636 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "call prj_fnc_option_menu";
		};
	};
};

class dialogBankMenu
{
	idd = 3001;
	
	class controls
	{
		class Bank_Header: prjRscText {
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
		};
		class Bank_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
			
			sizeEx = 0.025;
		};

		class Bank_MainBackground: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class Bank_Points_Text: prjRscText
		{
			idc = 1006;
			text = "YOUR POINTS";
			x = 0.43 * safezoneW + safezoneX;
			y = 0.31625 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.02625 * safezoneH;

			style = 2;
			font = "EtelkaMonospacePro";
		};
		class Bank_Points: prjRscText
		{
			idc = 1007;
			text = "";
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.345 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.0525 * safezoneH;

			sizeEx = 0.13;
			style = 2;
			font = "EtelkaMonospacePro";
		};
		class Bank_List_Box: prjRscListbox
		{
			idc = 1003;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.42125 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.196875 * safezoneH;

			onLBSelChanged = call prj_fnc_player_info;
		};
		class Bank_Edit_Window: prjRscEdit
		{
			idc = 1004;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.63 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		
		class Bank_Send_Btn: prjRscButtonHQ
		{
			idc = 1005;
			x = 0.56125 * safezoneW + safezoneX;
			y = 0.63 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
			action = "call prj_fnc_btn_transfer_points";
		};
		class Bank_Send_Pct: prjRscPicture
		{
			idc = -1;
			x = 0.56125 * safezoneW + safezoneX;
			y = 0.63 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
			text = "img\icons\icon_send.paa";
		};
		
	};
};

class dialogIntelMenu
{
	idd = 3004;
	
	class controls
	{
		class Intel_Header: prjRscText {
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
		};
		class Intel_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
			
			sizeEx = 0.025;
		};

		class Intel_MainBackground: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class Intel_Score: prjRscStructuredText
		{
			idc = 1020;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.329375 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.039375 * safezoneH;

			size = 0.03;
		};

	};
};

class dialogOptionMenu
{
	idd = 3005;
	
	class controls
	{
		class Options_Header: prjRscText {
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
		};
		class Options_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
			
			sizeEx = 0.025;
		};

		class Options_MainBackground: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.40 * safezoneH;
		};

		class Options_OffRain_Back: prjRscText
		{
			colorBackground[] = { 0, 0, 0, 0.5 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_OffRain_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_rain.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_OffRain_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "OFF RAIN";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "[0,0] remoteExec ['setRain'];[0,0] remoteExec ['setOvercast'];remoteExec ['forceWeatherChange']";
		};

		class Options_OffFog_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.5 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_OffFog_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_fog.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_OffFog_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "OFF FOG";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "[0,0] remoteExec ['setFog'];remoteExec ['forceWeatherChange']";
		};

		class Options_VehInfo_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.5 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.418 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_VehInfo_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_veh_info.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.418 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_VehInfo_Btn: prjRscButtonHQ
		{
			idc = 1021;
			text = "VEHICLE INFO";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.418 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "{if (((vehicle _x) isKindOf 'Car') || ((vehicle _x) isKindOf 'Tank') || ((vehicle _x) isKindOf 'Air')) then {systemChat format ['%1 - GPS:%2',(getText (configFile >> 'CfgVehicles' >> (typeOf _x) >> 'displayName')),(mapGridPosition _x)];};} forEach vehicles;";
		};

		class Options_TotalKillInfo_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.5 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.462 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_TotalKillInfo_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_total_kills.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.462 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_TotalKillInfo_Btn: prjRscButtonHQ
		{
			idc = 1030;
			text = "TOTAL KILLS";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.462 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "hint format ['ENEMY - %1\nCIVILIAN - %2\nFRIEND - %3',missionNamespace getVariable 'total_kill_enemy',missionNamespace getVariable 'total_kill_civ',missionNamespace getVariable 'total_kill_friend']";
		};

		class Options_SaveGame_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.5 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.506 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_SaveGame_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_save.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.506 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Options_SaveGame_Btn: prjRscButtonHQ
		{
			idc = 1031;
			text = "SAVE GAME";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.506 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "remoteExecCall ['prj_fnc_save_game',2]";
		};
	};
};

class dialogUpgradesMenu
{
	idd = 3006;
	
	class controls
	{
		class Upgrades_Header: prjRscText 
		{
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
		};
		class Upgrades_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
			
			sizeEx = 0.025;
		};

		class Upgrades_MainBack: prjRscText 
		{
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.40 * safezoneH;
		};		
		class Upgrades_InfoBack: prjRscText
		{
			colorBackground[] = { 0, 0, 0, 0.3 };
			idc = -1;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.34 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.14 * safezoneH;
		};

		class Upgrades_IntelScore: prjRscStructuredText
		{
			idc = 1025;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.355 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.02625 * safezoneH;
			font = "EtelkaMonospacePro";
			size = 0.024;
		};
		class Upgrades_Arsenal: prjRscStructuredText
		{
			idc = 1022;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.385 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.02625 * safezoneH;
			font = "EtelkaMonospacePro";
			size = 0.024;
		};
		class Upgrades_GarageA: prjRscStructuredText
		{
			idc = 1023;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.415 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.02625 * safezoneH;
			font = "EtelkaMonospacePro";
			size = 0.024;
		};
		class Upgrades_GarageL: prjRscStructuredText
		{
			idc = 1024;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.02625 * safezoneH;
			font = "EtelkaMonospacePro";
			size = 0.024;
		};

		class Upgrades_Arsenal_Btn_Back: prjRscText
		{
			idc = -1;

			x = 0.415 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class Upgrades_Arsenal_Btn_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_upgrade_arsenal.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Upgrades_Arsenal_Btn: prjRscButtonHQ
		{
			idc = 1026;
			text = "";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			sizeEx = 0.032;

			onMouseEnter = "params ['_control'];_next = ((missionNamespace getVariable 'arsenal_level') + 1);if (_next < 10) then {_control ctrlSetText str _next + ' / ' + str (_next * 200)} else {_control ctrlSetText 'MAX'}";
			onMouseExit = "params ['_control'];_control ctrlSetText localize 'STR_PRJ_STATISTICS_ARSENAL'";

			action = "[1] call prj_fnc_upgrade";
		};
		
		class Upgrades_GarageA_Btn_Back: RscText
		{
			idc = -1;

			x = 0.415 * safezoneW + safezoneX;
			y = 0.5525 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class Upgrades_GarageA_Btn_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_upgrade_a_garage.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.5525 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Upgrades_GarageA_Btn: prjRscButtonHQ
		{
			idc = 1027;
			text = "";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.5525 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			sizeEx = 0.032;

			onMouseEnter = "params ['_control'];_next = ((missionNamespace getVariable 'a_garage_level') + 1);if (_next <= 10) then {_control ctrlSetFont 'RobotoCondensedLight';_control ctrlSetText str _next + ' lvl > ' + str (_next * 200) + ' IntelScore';} else {_control ctrlSetText 'MAX'}";
			onMouseExit = "params ['_control'];_control ctrlSetFont 'EtelkaMonospacePro';_control ctrlSetText localize 'STR_PRJ_STATISTICS_AIRSHOP'";

			action = "[2] call prj_fnc_upgrade";
		};
		

		class Upgrades_GarageG_Btn_Back: RscText
		{
			idc = -1;

			x = 0.415 * safezoneW + safezoneX;
			y = 0.605 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class Upgrades_GarageG_Btn_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_upgrade_g_garage.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.605 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class Upgrades_GarageG_Btn: prjRscButtonHQ
		{
			idc = 1028;
			text = "";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.605 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			sizeEx = 0.032;

			onMouseEnter = "params ['_control'];_next = ((missionNamespace getVariable 'g_garage_level') + 1);if (_next <= 10) then {_control ctrlSetFont 'RobotoCondensedLight';_control ctrlSetText str _next + ' lvl > ' + str (_next * 200) + ' IntelScore';} else {_control ctrlSetText 'MAX'}";
			onMouseExit = "params ['_control'];_control ctrlSetFont 'EtelkaMonospacePro';_control ctrlSetText localize 'STR_PRJ_STATISTICS_GROUNDSHOP'";

			action = "[3] call prj_fnc_upgrade";
		};
	};
};

class dialogVehicleShop
{
	idd = 3002;
	
	class controls
	{
		class VehShop_Header: prjRscText 
		{
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.1675 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.018 * safezoneH;
		};
		class VehShop_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.1675 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.018 * safezoneH;

			sizeEx = 0.025;
		};

		class MainBackgroundVehShop : prjRscText {
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.1675 * safezoneW + safezoneX;
			y = 0.245 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.46 * safezoneH;
		};

		class RscButton_1600: prjRscButton
		{
			idc = 1008;
			text = "hello!";
			x = 0.17625 * safezoneW + safezoneX;
			y = 0.67 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.02625 * safezoneH;

			font = "PuristaMedium";

			action = "call prj_fnc_spawn_vehicle";
		};

		class RscText_1000: prjRscText
		{
			idc = 1009;
			text = "how are you?";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.669 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.02625 * safezoneH;
		};

		class RscText_1004: prjRscText
		{
			idc = 1010;
			text = "";
			x = 0.47 * safezoneW + safezoneX;
			y = 0.669 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.02625 * safezoneH;
		};

		class RscText_1002: prjRscText
		{
			idc = 1011;
			text = "";
			x = 0.6 * safezoneW + safezoneX;
			y = 0.669 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.02625 * safezoneH;
		};

		class RscListbox_1500: prjRscListbox
		{
			idc = 1012;
			x = 0.17625 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.24 * safezoneW;
			h = 0.4 * safezoneH;

			onLBSelChanged = call prj_fnc_show_vehicle_picture;
		};
		class RscPicture_1200: prjRscPicture
		{
			idc = 1013;
			text = "";
			x = 0.42 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.4000 * safezoneW;
			h = 0.4 * safezoneH;
		};

		class RscText_1041: RscText
		{
			idc = 1041;

			x = 0.1675 * safezoneW + safezoneX;
			y = 0.713125 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.0525 * safezoneH;
		};
		class RscText_1040: prjRscText
		{
			idc = 1040;
			text = "";
			x = 0.17625 * safezoneW + safezoneX;
			y = 0.72625 * safezoneH + safezoneY;
			w = 0.63875 * safezoneW;
			h = 0.02625 * safezoneH;
		};
	};
};

class dialogVehicleService
{
	idd = 3003;
	
	class controls
	{
		class VehService_Header: prjRscText 
		{
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.29875 * safezoneW + safezoneX;
			y = 0.29625 * safezoneH + safezoneY;
			w = 0.39375 * safezoneW;
			h = 0.018 * safezoneH;
		};
		class VehService_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.29875 * safezoneW + safezoneX;
			y = 0.29625 * safezoneH + safezoneY;
			w = 0.39375 * safezoneW;
			h = 0.018 * safezoneH;

			sizeEx = 0.025;
		};

		class MainBackgroundHQ : prjRscText {
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.29875 * safezoneW + safezoneX;
			y = 0.31625 * safezoneH + safezoneY;
			w = 0.39375 * safezoneW;
			h = 0.354375 * safezoneH;

			size = 0.02;
		};
		class RscListbox_1501: prjRscListbox
		{
			idc = 1014;
			x = 0.5175 * safezoneW + safezoneX;
			y = 0.329375 * safezoneH + safezoneY;
			w = 0.16625 * safezoneW;
			h = 0.223125 * safezoneH;

			onLBSelChanged = call prj_fnc_show_load_items;
		};
		class RscButton_1606: prjRscButton
		{
			idc = -1;
			text = "repair/rearm";
			x = 0.5175 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.039375 * safezoneH;

			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			colorText[] = {0.2, 0.5, 0.2, 1};

			action = "call prj_fnc_vehicle_repair";
		};
		class RscButton_1607: prjRscButton
		{
			idc = -1;
			text = "delete vehicle";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.039375 * safezoneH;

			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			colorText[] = {1, 0.2, 0.2, 1};

			action = "player action ['GetOut',vehicle player];deleteVehicle (vehicle player);closeDialog 2";
		};
		class RscButton_1608: prjRscButton
		{
			idc = 1015;
			text = "load (x1)";
			x = 0.5175 * safezoneW + safezoneX;
			y = 0.565625 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.02625 * safezoneH;

			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			action = "[1] call prj_fnc_load_item_to_cargo";
		};
		class RscButton_1609: prjRscButton
		{
			idc = -1;
			text = "clear cargo";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.565625 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.0525 * safezoneH;

			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			colorText[] = {0.3, 0.3, 0.7, 1};

			action = "_car = (vehicle player);clearItemCargoGlobal _car;clearMagazineCargoGlobal _car;clearWeaponCargoGlobal _car;clearBackpackCargoGlobal _car;";
		};
		class RscStructuredText_1100: prjRscListbox
		{
			idc = 1017;
			text = "";
			x = 0.3075 * safezoneW + safezoneX;
			y = 0.329375 * safezoneH + safezoneY;
			w = 0.20125 * safezoneW;
			h = 0.275625 * safezoneH;

			font = "RobotoCondensed";
			size = 0.023;

			onLBSelChanged = call prj_fnc_btn_load_enable;
		};
		class RscButton_1050: prjRscButton
		{
			font = "PuristaMedium";
			idc = 1050;
			text = "";
			x = 0.3075 * safezoneW + safezoneX;
			y = 0.618125 * safezoneH + safezoneY;
			w = 0.20125 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "call prj_fnc_sell_vehicle";
		};

		class RscButton_1610: prjRscButton
		{
			idc = 1045;
			font = "PuristaMedium";
			action = "[2] call prj_fnc_load_item_to_cargo";

			text = "x2";
			x = 0.5175 * safezoneW + safezoneX;
			y = 0.591875 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.02625 * safezoneH;

			colorBackground[] = { 100, 0, 0, 0.2 };
		};
		class RscButton_1611: prjRscButton
		{
			idc = 1046;
			font = "PuristaMedium";
			action = "[5] call prj_fnc_load_item_to_cargo";

			text = "x5";
			x = 0.54375 * safezoneW + safezoneX;
			y = 0.591875 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.02625 * safezoneH;

			colorBackground[] = { 200, 100, 0, 0.2 };
		};
		class RscButton_1612: prjRscButton
		{
			idc = 1047;
			font = "PuristaMedium";
			action = "[10] call prj_fnc_load_item_to_cargo";

			text = "x10";
			x = 0.57 * safezoneW + safezoneX;
			y = 0.591875 * safezoneH + safezoneY;
			w = 0.0255 * safezoneW;
			h = 0.02625 * safezoneH;

			colorBackground[] = { 0, 0, 100, 0.2 };
		};
	};
};

class dialogSlideMonitorMenu
{
	idd = 3020;
	
	class controls
	{
		class HQ_Header: prjRscText {
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
		};
		class HQ_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.018 * safezoneH;
			
			sizeEx = 0.025;
		};
		class HQ_MainBackground: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.40 * safezoneH;
		};

		class slideMonitorMenuSlideName: prjRscText 
		{
			text = "slide name";
			idc = 1055;
			x = 0.40375 * safezoneW + safezoneX;
			y = 0.31625 * safezoneH + safezoneY;
			w = 0.1925 * safezoneW;
			h = 0.0525 * safezoneH;
		};

		class slideMonitorMenuNext: prjRscButtonHQ
		{
			idc = -1;
			text = ">>";
			x = 0.50875 * safezoneW + safezoneX;
			y = 0.618125 * safezoneH + safezoneY;
			w = 0.0875 * safezoneW;
			h = 0.065625 * safezoneH;

			action = "['next'] remoteExecCall ['prj_fnc_monitorChangeSlide',2]";
		};

		class slideMonitorMenuPrevious: prjRscButtonHQ
		{
			idc = -1;
			text = "<<";
			x = 0.40375 * safezoneW + safezoneX;
			y = 0.618125 * safezoneH + safezoneY;
			w = 0.0875 * safezoneW;
			h = 0.065625 * safezoneH;

			action = "['previous'] remoteExecCall ['prj_fnc_monitorChangeSlide',2]";
		};
	};
};

class dialogArsenalShop
{
	idd = 3007;
	
	class controls
	{
		class Arsenal_Header: prjRscText 
		{
			colorBackground[] = { 0, 0.7, 0, 0.7 };
			idc = -1;
			x = 0.237534 * safezoneW + safezoneX;
			y = 0.150058 * safezoneH + safezoneY;
			w = 0.524932 * safezoneW;
			h = 0.0279953 * safezoneH;
		};
		class Arsenal_Header_Text: prjRscText 
		{
			text = "esc to back";
			idc = -1;
			x = 0.240159 * safezoneW + safezoneX;
			y = 0.155657 * safezoneH + safezoneY;
			w = 0.519682 * safezoneW;
			h = 0.0167972 * safezoneH;

			sizeEx = 0.025;
		};

		class Arsenal_Background : prjRscText {
			colorBackground[] = { 0, 0, 0, 0.7 };
			idc = -1;
			x = 0.237534 * safezoneW + safezoneX;
			y = 0.181972 * safezoneH + safezoneY;
			w = 0.524932 * safezoneW;
			h = 0.669087 * safezoneH;

			size = 0.02;
		};

		class Arsenal_LB_Header_Cat_Text: prjRscText 
		{
			text = "categories";
			idc = -1;
			x = 0.24672 * safezoneW + safezoneX;
			y = 0.192049 * safezoneH + safezoneY;
			w = 0.119416 * safezoneW;
			h = 0.0223961 * safezoneH;

			sizeEx = 0.035;
		};

		class Arsenal_LB_Header_Items_Text: prjRscText 
		{
			text = "items";
			idc = -1;
			x = 0.377948 * safezoneW + safezoneX;
			y = 0.192052 * safezoneH + safezoneY;
			w = 0.158776 * safezoneW;
			h = 0.0223961 * safezoneH;

			sizeEx = 0.035;
		};

		class Arsenal_LB_Cat: prjRscListbox
		{
			idc = 1018;
			x = 0.244096 * safezoneW + safezoneX;
			y = 0.22285 * safezoneH + safezoneY;
			w = 0.124671 * safezoneW;
			h = 0.613095 * safezoneH;

			onLBSelChanged = call prj_fnc_show_arsenal_items;
		};

		class Arsenal_LB_Items: prjRscListbox
		{
			idc = 1019;
			x = 0.375329 * safezoneW + safezoneX;
			y = 0.22285 * safezoneH + safezoneY;
			w = 0.164041 * safezoneW;
			h = 0.613095 * safezoneH;

			onLBSelChanged = call prj_fnc_show_arsenal_item_info;
		};

		class Arsenal_Item_Picture: prjRscPicture
		{
			idc = 1081;
			text = "";
			x = 0.545932 * safezoneW + safezoneX;
			y = 0.22285 * safezoneH + safezoneY;
			w = 0.209973 * safezoneW;
			h = 0.209964 * safezoneH;
		};

		class Arsenal_Item_Picture_Text: prjRscText 
		{
			idc = 1083;
			text = "";
			x = 0.552493 * safezoneW + safezoneX;
			y = 0.234045 * safezoneH + safezoneY;
			w = 0.0524932 * safezoneW;
			h = 0.0279953 * safezoneH;
		};

		class Arsenal_ST_Item_Info: prjRscStructuredText
		{
			idc = 1080;
			x = 0.545932 * safezoneW + safezoneX;
			y = 0.44681 * safezoneH + safezoneY;
			w = 0.209973 * safezoneW;
			h = 0.333173 * safezoneH;
			font = "EtelkaMonospacePro";
			size = 0.024;
		};

		class Arsenal_Btn_Buy: prjRscButton
		{
			idc = 1082;
			text = "buy";
			x = 0.54462 * safezoneW + safezoneX;
			y = 0.79395 * safezoneH + safezoneY;
			w = 0.211268 * safezoneW;
			h = 0.0419929 * safezoneH;

			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			colorText[] = {0.2, 0.5, 0.2, 1};

			action = "call prj_fnc_vehicle_repair";
		};
		
	};
};