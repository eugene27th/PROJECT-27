class dialogVehicleList {
	idd = 3000;
	movingEnable = true;

	class ControlsBackground {
		class headerBlock: RscText {
			idc = -1;

			x = 0.1675 * safezoneW + safezoneX;
			y = 0.18 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.025 * safezoneH;

			colorBackground[] = { 0, 0.7, 0, 0.7 };
		};

		class mainBackground: RscText {
			idc = -1;

			x = 0.1675 * safezoneW + safezoneX;
			y = 0.205 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.6 * safezoneH;

			colorBackground[] = { 0, 0, 0, 0.7 };
		};
	};
	
	class Controls {
		class headerText: RscText {
			idc = -1;
			
			x = 0.1675 * safezoneW + safezoneX;
			y = 0.18 * safezoneH + safezoneY;
			w = 0.66 * safezoneW;
			h = 0.025 * safezoneH;

			sizeEx = 0.025;
			text = "esc to back";
		};

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

			action = "call P27_fnc_vehicleSpawnPlace";
		};

		class typeChange: RscCombo {
			idc = 1003;

			x = 0.271628 * safezoneW + safezoneX;
			y = 0.763166 * safezoneH + safezoneY;
			w = 0.137811 * safezoneW;
			h = 0.0279964 * safezoneH;

			onLBSelChanged = "call P27_fnc_updateVehicleList";
		};
	};
};