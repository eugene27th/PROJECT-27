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

			x = 0.173199 * safezoneW + safezoneX;
			y = 0.268 * safezoneH + safezoneY;
			w = 0.236247 * safezoneW;
			h = 0.475 * safezoneH;

			onLBSelChanged = "[] call P27_fnc_showVehiclePreview";
		};

		class preview: RscPicture {
			idc = 1001;
			
			x = 0.417053 * safezoneW + safezoneX;
			y = 0.268 * safezoneH + safezoneY;
			w = 0.402934 * safezoneW;
			h = 0.425546 * safezoneH;

			text = "";
		};

		class className: RscText {
			idc = 1005;

			x = 0.412066 * safezoneW + safezoneX;
			y = 0.705 * safezoneH + safezoneY;
			w = 0.413315 * safezoneW;
			h = 0.0335963 * safezoneH;

			font = "PuristaMedium";
			text = "";
		};

		class spawnButton: RscButton {
			idc = 1002;
			
			x = 0.173199 * safezoneW + safezoneX;
			y = 0.763166 * safezoneH + safezoneY;
			w = 0.091874 * safezoneW;
			h = 0.0279964 * safezoneH;

			font = "PuristaMedium";
			text = "SPAWN";

			action = "[] call P27_fnc_vehiclePlacement";
		};

		class typeList: RscCombo {
			idc = 1003;

			x = 0.271633 * safezoneW + safezoneX;
			y = 0.763166 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.0279964 * safezoneH;

			onLBSelChanged = "[] call P27_fnc_updateVehicleList";
		};

		class searchInput: RscEdit {
			idc = 1004;

			x = 0.174511 * safezoneW + safezoneX;
			y = 0.222837 * safezoneH + safezoneY;
			w = 0.23492 * safezoneW;
			h = 0.03 * safezoneH;

			maxChars = 64;

			font = "PuristaMedium";
			text = "";

			onKeyUp = "[] call P27_fnc_updateVehicleList";
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

			onLBSelChanged = "[] call P27_fnc_updateItemsList";
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
			y = 0.205198 * safezoneH + safezoneY;
			w = 0.419994 * safezoneW;
			h = 0.0277996 * safezoneH;

			colorBackground[] = {0, 0.7, 0, 0.7};
		};

		class headerText: RscText {
			idc = -1;
			
			x = 0.290002 * safezoneW + safezoneX;
			y = 0.208841 * safezoneH + safezoneY;
			w = 0.419994 * safezoneW;
			h = 0.0222004 * safezoneH;

			sizeEx = 0.025;
			text = "esc to back";
		};

		class mainBackground: RscText {
			idc = -1;

			x = 0.29079 * safezoneW + safezoneX;
			y = 0.233194 * safezoneH + safezoneY;
			w = 0.419994 * safezoneW;
			h = 0.531932 * safezoneH;

			colorBackground[] = {0, 0, 0, 0.7};
		};
	};

	class Controls {
		class aircraftPictureBackground: RscText {
			idc = -1;

			x = 0.303127 * safezoneW + safezoneX;
			y = 0.262026 * safezoneH + safezoneY;
			w = 0.393744 * safezoneW;
			h = 0.421523 * safezoneH;

			colorBackground[] = {0.5, 0.5, 0.5, 1};
		};
		
		class aircraftPicture: RscPicture {
			idc = 3000;

			x = 0.303127 * safezoneW + safezoneX;
			y = 0.262026 * safezoneH + safezoneY;
			w = 0.393744 * safezoneW;
			h = 0.421523 * safezoneH;

			style = 48 + 0x800;
		};

		class applyButton: RscButton {
			idc = 3001;
			
			x = 0.303127 * safezoneW + safezoneX;
			y = 0.709975 * safezoneH + safezoneY;
			w = 0.0656244 * safezoneW;
			h = 0.0307968 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "APPLY";

			action = "[] call P27_fnc_configurePylons";
		};

		class resetButton: RscButton {
			idc = 3002;
			
			x = 0.381878 * safezoneW + safezoneX;
			y = 0.709975 * safezoneH + safezoneY;
			w = 0.0656244 * safezoneW;
			h = 0.0307968 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "RESET";

			action = "[] call P27_fnc_resetPylons";
		};

		class cancelButton: RscButton {
			idc = 3003;
			
			x = 0.631204 * safezoneW + safezoneX;
			y = 0.709971 * safezoneH + safezoneY;
			w = 0.0656244 * safezoneW;
			h = 0.0307968 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "CANCEL";

			action = "closeDialog 1";
		};
	};
};

class dialogViewSettings {
	idd = 3003;

	class ControlsBackground {
		class headerBlock: RscText {
			idc = -1;

			x = 0.35563 * safezoneW + safezoneX;
			y = 0.399212 * safezoneH + safezoneY;
			w = 0.288565 * safezoneW;
			h = 0.025 * safezoneH;

			colorBackground[] = {0, 0.7, 0, 0.7};
		};

		class headerText: RscText {
			idc = -1;
			
			x = 0.357861 * safezoneW + safezoneX;
			y = 0.398373 * safezoneH + safezoneY;
			w = 0.284628 * safezoneW;
			h = 0.025 * safezoneH;

			sizeEx = 0.025;
			text = "esc to back";
		};

		class mainBackground: RscText {
			idc = -1;

			x = 0.35563 * safezoneW + safezoneX;
			y = 0.42441 * safezoneH + safezoneY;
			w = 0.288745 * safezoneW;
			h = 0.145581 * safezoneH;

			colorBackground[] = {0, 0, 0, 0.7};
		};


		class viewDistanceText: RscText {
			idc = -1;

			x = 0.36 * safezoneW + safezoneX;
			y = 0.438408 * safezoneH + safezoneY;
			w = 0.052 * safezoneW;
			h = 0.0280001 * safezoneH;

			text = "Distance:";
		};

		class objectsText: RscText {
			idc = -1;

			x = 0.36 * safezoneW + safezoneX;
			y = 0.477603 * safezoneH + safezoneY;
			w = 0.052 * safezoneW;
			h = 0.0280001 * safezoneH;

			text = "Objects:";
		};
		

		class terrainText: RscText {
			idc = -1;

			x = 0.36 * safezoneW + safezoneX;
			y = 0.527996 * safezoneH + safezoneY;
			w = 0.052 * safezoneW;
			h = 0.0280001 * safezoneH;

			text = "Terrain:";
		};
	};

	class Controls {
		class sliderViewDistance: RscXSliderH {
			idc = 4000;

			x = 0.421253 * safezoneW + safezoneX;
			y = 0.438408 * safezoneH + safezoneY;
			w = 0.164057 * safezoneW;
			h = 0.0280001 * safezoneH;

			sliderRange[] = {500, 12000};
			sliderStep = 100;
			sliderPosition = 1600;

			onSliderPosChanged = "params ['_control', '_newValue']; (findDisplay 3003) displayCtrl ((ctrlIDC _control) + 1) ctrlSetText (str _newValue); setViewDistance _newValue;"
		};

		class editViewDistance: RscEdit {
			idc = 4001;
			
			x = 0.591872 * safezoneW + safezoneX;
			y = 0.438408 * safezoneH + safezoneY;
			w = 0.0393736 * safezoneW;
			h = 0.0252005 * safezoneH;

			text = "1600";
			maxChars = 5;

			onKeyUp = "params ['_displayOrControl', '_key', '_shift', '_ctrl', '_alt']; private _newValue = (ctrlText _displayOrControl) call BIS_fnc_parseNumber; if (_newValue < 500) exitWith {}; (findDisplay 3003) displayCtrl ((ctrlIDC _displayOrControl) - 1) sliderSetPosition _newValue; setViewDistance _newValue;"
		};

		class sliderObjectsViewDistance: RscXSliderH {
			idc = 4002;

			x = 0.421253 * safezoneW + safezoneX;
			y = 0.477603 * safezoneH + safezoneY;
			w = 0.164057 * safezoneW;
			h = 0.0280001 * safezoneH;

			sliderRange[] = {500, 12000};
			sliderStep = 100;
			sliderPosition = 1600;

			onSliderPosChanged = "params ['_control', '_newValue']; (findDisplay 3003) displayCtrl ((ctrlIDC _control) + 1) ctrlSetText (str _newValue); setObjectViewDistance _newValue;"
		};

		class editObjectsViewDistance: RscEdit {
			idc = 4003;
			
			x = 0.591872 * safezoneW + safezoneX;
			y = 0.477603 * safezoneH + safezoneY;
			w = 0.0393736 * safezoneW;
			h = 0.0280001 * safezoneH;

			text = "1600";
			maxChars = 5;

			onKeyUp = "params ['_displayOrControl', '_key', '_shift', '_ctrl', '_alt']; private _newValue = (ctrlText _displayOrControl) call BIS_fnc_parseNumber; if (_newValue < 500) exitWith {}; (findDisplay 3003) displayCtrl ((ctrlIDC _displayOrControl) - 1) sliderSetPosition _newValue; setObjectViewDistance _newValue;"
		};


		class terrainNone: RscButton {
			idc = 4004;

			x = 0.421253 * safezoneW + safezoneX;
			y = 0.525197 * safezoneH + safezoneY;
			w = 0.0485608 * safezoneW;
			h = 0.0335957 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "None";

			action = "setTerrainGrid 50";
		};

		class terrainLow: RscButton {
			idc = 4005;
			
			x = 0.473751 * safezoneW + safezoneX;
			y = 0.525197 * safezoneH + safezoneY;
			w = 0.0498732 * safezoneW;
			h = 0.0335957 * safezoneH;
			
			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "Low";

			action = "setTerrainGrid 30";
		};

		class terrainNormal: RscButton {
			idc = 4006;
			
			x = 0.527562 * safezoneW + safezoneX;
			y = 0.525197 * safezoneH + safezoneY;
			w = 0.0498732 * safezoneW;
			h = 0.0335957 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "Normal";

			action = "setTerrainGrid 12.5";
		};

		class terrainHigh: RscButton {
			idc = 4007;
			
			x = 0.581372 * safezoneW + safezoneX;
			y = 0.525197 * safezoneH + safezoneY;
			w = 0.0498732 * safezoneW;
			h = 0.0335957 * safezoneH;

			font = "PuristaMedium";
			sizeEx = 0.035;
			text = "High";

			action = "setTerrainGrid 3.125";
		};
	};
};