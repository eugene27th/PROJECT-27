class dialogVehicleList {
	idd = 3000;

	class ControlsBackground {
		class headerBlock: RscText {
			idc = -1;

			x = 0.1675 * safezoneW + safezoneX;
			y = 0.18 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.025 * safezoneH;

			colorBackground[] = {0, 0.7, 0, 0.7};
		};

		class headerText: RscText {
			idc = -1;
			
			x = 0.1675 * safezoneW + safezoneX;
			y = 0.18 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.025 * safezoneH;

			sizeEx = 0.025;
			text = "esc to back";
		};

		class mainBackground: RscText {
			idc = -1;

			x = 0.1675 * safezoneW + safezoneX;
			y = 0.205 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.6 * safezoneH;

			colorBackground[] = {0, 0, 0, 0.7};
		};
	};
	
	class Controls {
		class listBox: RscListbox {
			idc = 1000;

			x = 0.173191 * safezoneW + safezoneX;
			y = 0.220036 * safezoneH + safezoneY;
			w = 0.236247 * safezoneW;
			h = 0.531932 * safezoneH;

			onLBSelChanged = "call P27_fnc_showVehiclePreview";
		};

		class preview: RscPicture {
			idc = 1001;
			
			x = 0.417051 * safezoneW + safezoneX;
			y = 0.274069 * safezoneH + safezoneY;
			w = 0.402933 * safezoneW;
			h = 0.425546 * safezoneH;

			text = "";
		};

		class spawnButton: RscButton {
			idc = 1002;
			
			x = 0.173191 * safezoneW + safezoneX;
			y = 0.763166 * safezoneH + safezoneY;
			w = 0.0918739 * safezoneW;
			h = 0.0279964 * safezoneH;

			font = "PuristaMedium";
			text = "SPAWN";

			action = "call P27_fnc_vehiclePlacement";
		};

		class typeList: RscCombo {
			idc = 1003;

			x = 0.271628 * safezoneW + safezoneX;
			y = 0.763166 * safezoneH + safezoneY;
			w = 0.137811 * safezoneW;
			h = 0.0279964 * safezoneH;

			onLBSelChanged = "call P27_fnc_updateVehicleList";
		};
	};
};

class dialogVehicleService {
	idd = 3001;

	class ControlsBackground {
		class headerBlock: RscText {
			idc = -1;

			x = 0.377545 * safezoneW + safezoneX;
			y = 0.180001 * safezoneH + safezoneY;
			w = 0.246567 * safezoneW;
			h = 0.025 * safezoneH;

			colorBackground[] = {0, 0.7, 0, 0.7};
		};

		class headerText: RscText {
			idc = -1;
			
			x = 0.377545 * safezoneW + safezoneX;
			y = 0.180001 * safezoneH + safezoneY;
			w = 0.246567 * safezoneW;
			h = 0.025 * safezoneH;

			sizeEx = 0.025;
			text = "esc to back";
		};

		class mainBackground: RscText {
			idc = -1;

			x = 0.377418 * safezoneW + safezoneX;
			y = 0.202419 * safezoneH + safezoneY;
			w = 0.246746 * safezoneW;
			h = 0.618721 * safezoneH;

			colorBackground[] = {0, 0, 0, 0.7};
		};

		class loadBarBackground: IGUIBack {
			idc = -1;

			x = 0.5 * safezoneW + safezoneX;
			y = 0.73517 * safezoneH + safezoneY;
			w = 0.119436 * safezoneW;
			h = 0.0307961 * safezoneH;

			colorBackground[] = {-1, -1, -1, 1};
		};
	};

	class Controls {
		class categoryList: RscCombo {
			idc = 2001;

			x = 0.383189 * safezoneW + safezoneX;
			y = 0.216396 * safezoneH + safezoneY;
			w = 0.236254 * safezoneW;
			h = 0.0307961 * safezoneH;

			onLBSelChanged = "call P27_fnc_updateItemsList";
		};

		class itemsList: RscListbox {
			idc = 2002;

			x = 0.383189 * safezoneW + safezoneX;
			y = 0.253636 * safezoneH + safezoneY;
			w = 0.236247 * safezoneW;
			h = 0.470338 * safezoneH;

			onLBSelChanged = "";
		};

		class itemLoadx1: RscButton {
			idc = 2003;
			
			x = 0.383188 * safezoneW + safezoneX;
			y = 0.735171 * safezoneH + safezoneY;
			w = 0.0249364 * safezoneW;
			h = 0.030796 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "x1";

			action = "[vehicle player, 1] call P27_fnc_loadItemToCargo";
		};

		class itemLoadx2: RscButton {
			idc = 2004;

			x = 0.411878 * safezoneW + safezoneX;
			y = 0.735171 * safezoneH + safezoneY;
			w = 0.0249364 * safezoneW;
			h = 0.030796 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "x2";

			action = "[vehicle player, 2] call P27_fnc_loadItemToCargo";
		};

		class itemLoadx5: RscButton {
			idc = 2005;
			
			x = 0.439626 * safezoneW + safezoneX;
			y = 0.735171 * safezoneH + safezoneY;
			w = 0.0249364 * safezoneW;
			h = 0.030796 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "x5";

			action = "[vehicle player, 5] call P27_fnc_loadItemToCargo";
		};

		class itemLoadx10: RscButton {
			idc = 2006;
			
			x = 0.4685 * safezoneW + safezoneX;
			y = 0.735171 * safezoneH + safezoneY;
			w = 0.0249364 * safezoneW;
			h = 0.030796 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "x10";

			action = "[vehicle player, 10] call P27_fnc_loadItemToCargo";
		};

		class loadBar: IGUIBack {
			idc = 2007;

			x = 0.502153 * safezoneW + safezoneX;
			y = 0.739779 * safezoneH + safezoneY;
			w = 0;
			h = 0.0223972 * safezoneH;

			colorBackground[] = {1, 1, 1, 1};
		};

		class repairAndRearm: RscButton {
			idc = 2008;
			
			x = 0.383189 * safezoneW + safezoneX;
			y = 0.774366 * safezoneH + safezoneY;
			w = 0.0918739 * safezoneW;
			h = 0.0335956 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "REPAIR & REARM";

			action = "[vehicle player] call P27_fnc_vehicleService";
		};

		class clearInventory: RscButton {
			idc = 2009;
			
			x = 0.48031 * safezoneW + safezoneX;
			y = 0.774364 * safezoneH + safezoneY;
			w = 0.0748114 * safezoneW;
			h = 0.0335956 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "CLEAR INVENT";

			action = "[vehicle player, 'clear'] call P27_fnc_vehicleService";
		};

		class deleteVehicle: RscButton {
			idc = 2010;
			
			x = 0.560356 * safezoneW + safezoneX;
			y = 0.774366 * safezoneH + safezoneY;
			w = 0.0590614 * safezoneW;
			h = 0.0335956 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "DELETE";

			action = "[vehicle player, 'delete'] call P27_fnc_vehicleService";
		};
	};
};

class dialogConfigurePylons {
	idd = 3002;

	class ControlsBackground {
		class headerBlock: RscText {
			idc = -1;

			x = 0.29079 * safezoneW + safezoneX;
			y = 0.180001 * safezoneH + safezoneY;
			w = 0.419994 * safezoneW;
			h = 0.025 * safezoneH;

			colorBackground[] = {0, 0.7, 0, 0.7};
		};

		class headerText: RscText {
			idc = -1;
			
			x = 0.29079 * safezoneW + safezoneX;
			y = 0.180001 * safezoneH + safezoneY;
			w = 0.419994 * safezoneW;
			h = 0.025 * safezoneH;

			sizeEx = 0.025;
			text = "esc to back";
		};

		class mainBackground: RscText {
			idc = -1;

			x = 0.29079 * safezoneW + safezoneX;
			y = 0.202398 * safezoneH + safezoneY;
			w = 0.419994 * safezoneW;
			h = 0.621521 * safezoneH;

			colorBackground[] = {0, 0, 0, 0.7};
		};
	};

	class Controls {
		class aircraftPicture: RscPicture {
			idc = 3000;

			x = 0.29919 * safezoneW + safezoneX;
			y = 0.217236 * safezoneH + safezoneY;
			w = 0.402931 * safezoneW;
			h = 0.590727 * safezoneH;

			colorBackground[] = {1,1,1,0.1};
		};
	};
};