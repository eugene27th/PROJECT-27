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
			text = "esc to back"
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
			y = 0.318 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.039375 * safezoneH;

			size = 0.03;
		};


		class HQ_Statistic_Pct: prjRscPicture
		{
			idc = 1029;
			text = "";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class HQ_Statistic_Text: prjRscStructuredText
		{
			idc = 1002;
			text = "";
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.376 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.091875 * safezoneH;

			size = 0.026;
		};


		class HQ_To_MHQ_Back: prjRscText
		{
			colorBackground[] = { 0, 0, 0, 0.3 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.46 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_To_MHQ_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_to_mhq.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.46 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_To_MHQ_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "TO MHQ";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.46 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "call prj_fnc_tpmhq";
		};

		class HQ_Bank_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.3 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.504 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_Bank_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_bank.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.504 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;

			sizeEx = 0.05;
		};
		class HQ_Bank_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "BANK";
			x = 0.444 * safezoneW + safezoneX;
			y = 0.504 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "call prj_fnc_bank_menu";
		};

		class HQ_Intels_Back: prjRscText {
			colorBackground[] = { 0, 0, 0, 0.3 };
			idc = -1;
			x = 0.415 * safezoneW + safezoneX;
			y = 0.548 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_Intels_Pct: prjRscPicture
		{
			idc = -1;
			text = "img\icons\icon_intels.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.548 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.039375 * safezoneH;
		};
		class HQ_Intels_Btn: prjRscButtonHQ
		{
			idc = -1;
			text = "INTELS"; //--- ToDo: Localize;
			x = 0.444 * safezoneW + safezoneX;
			y = 0.548 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			action = "call prj_fnc_intel_menu";
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
			text = "esc to back"
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
			text = "esc to back"
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

		class Intel_LB: prjRscListbox
		{
			idc = 1018;
			
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.381875 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.23625 * safezoneH;

			onLBSelChanged = call prj_fnc_show_intel_trade;
		};
		class Intel_Btn: prjRscButton
		{
			idc = 1019;

			x = 0.4125 * safezoneW + safezoneX;
			y = 0.63125 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.039375 * safezoneH;

			text = "SELECT INTEL"
			action = "call prj_fnc_intel_trade_btn";
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
			text = "esc to back"
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

			action = "[0,0] remoteExec ['setRain'];[0,0] remoteExec ['setOvercast']";
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

			action = "[0,0] remoteExec ['setFog']";
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
			text = "esc to back"
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
			size = 0.028;
		};
		class Upgrades_Arsenal: prjRscStructuredText
		{
			idc = 1022;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.385 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.02625 * safezoneH;
			font = "EtelkaMonospacePro";
			size = 0.028;
		};
		class Upgrades_GarageA: prjRscStructuredText
		{
			idc = 1023;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.415 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.02625 * safezoneH;
			font = "EtelkaMonospacePro";
			size = 0.028;
		};
		class Upgrades_GarageL: prjRscStructuredText
		{
			idc = 1024;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.02625 * safezoneH;
			font = "EtelkaMonospacePro";
			size = 0.028;
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
			text = "ARSENAL (WIP)"; //--- ToDo: Localize;
			x = 0.444 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			sizeEx = 0.032;

			onMouseEnter = "params ['_control'];_next = ((missionNamespace getVariable 'arsenal_level') + 1);_control ctrlSetText str _next + ' LVL / ' + str (_next * 100) + ' IS';";
			onMouseExit = "params ['_control'];_control ctrlSetText 'ARSENAL'";

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
			text = "AIR GARAGE"; //--- ToDo: Localize;
			x = 0.444 * safezoneW + safezoneX;
			y = 0.5525 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			sizeEx = 0.032;

			onMouseEnter = "params ['_control'];_next = ((missionNamespace getVariable 'a_garage_level') + 1);_control ctrlSetText str _next + ' LVL / ' + str (_next * 100) + ' IS';";
			onMouseExit = "params ['_control'];_control ctrlSetText 'AIR GARAGE'";

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
			text = "GROUND GARAGE"; //--- ToDo: Localize;
			x = 0.444 * safezoneW + safezoneX;
			y = 0.605 * safezoneH + safezoneY;
			w = 0.142 * safezoneW;
			h = 0.039375 * safezoneH;

			sizeEx = 0.032;

			onMouseEnter = "params ['_control'];_next = ((missionNamespace getVariable 'g_garage_level') + 1);_control ctrlSetText str _next + ' LVL / ' + str (_next * 100) + ' IS';";
			onMouseExit = "params ['_control'];_control ctrlSetText 'GROUND GARAGE'";

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
			text = "esc to back"
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
			text = "esc to back"
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
			y = 0.618125 * safezoneH + safezoneY;
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
			y = 0.618125 * safezoneH + safezoneY;
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
			text = "load";
			x = 0.5175 * safezoneW + safezoneX;
			y = 0.565625 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.039375 * safezoneH;

			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			action = "call prj_fnc_load_item_to_cargo";
		};
		class RscButton_1609: prjRscButton
		{
			idc = -1;
			text = "clear cargo";
			x = 0.605 * safezoneW + safezoneX;
			y = 0.565625 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.039375 * safezoneH;

			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			colorText[] = {0.3, 0.3, 0.7, 1};

			action = "_car = (vehicle player);clearItemCargoGlobal _car;clearMagazineCargoGlobal _car;clearWeaponCargoGlobal _car;clearBackpackCargoGlobal _car;";
		};
		class RscButton_1610: prjRscButton
		{
			idc = 1016;
			text = "";
			x = 0.3075 * safezoneW + safezoneX;
			y = 0.618125 * safezoneH + safezoneY;
			w = 0.20125 * safezoneW;
			h = 0.039375 * safezoneH;

			font = "PuristaMedium";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class RscStructuredText_1100: prjRscStructuredText
		{
			idc = 1017;
			text = "";
			x = 0.3075 * safezoneW + safezoneX;
			y = 0.329375 * safezoneH + safezoneY;
			w = 0.20125 * safezoneW;
			h = 0.3 * safezoneH;

			font = "RobotoCondensed";
			size = 0.023;
		};
	};
};