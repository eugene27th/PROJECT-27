/*
	written by eugene27.
	global functions
*/

// vehicle shop ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_vehicle_shop_window = {
	params [
		"_vehiclearray","_spawnobject"
	];

	objectspawn = _spawnobject;

	createDialog "dialogVehicleShop";
	ctrlEnable [1008, false];

	private _money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	private _ctrl_money = (findDisplay 3002) displayCtrl 1011;
	private _text_money = "YOU HAVE: " + str _money;
	_ctrl_money ctrlSetText _text_money;
	_ctrl_money ctrlSetTextColor [0.2,0.7,0,1];

	private _checkplace = nearestObjects [position objectspawn,["landVehicle","Air","Ship"],12] # 0;
	if (!isNil "_checkplace") then {
		private _vehicle_name = getText(configFile >> "CfgVehicles" >> typeOf _checkplace >> "displayName");
		private _ctrl_alert = (findDisplay 3002) displayCtrl 1040;
		private _text_alert = str _vehicle_name + " " + localize "STR_PRJ_VEH_SHOP_MENU_ALERT";
		_ctrl_alert ctrlSetText _text_alert;
		private _ctrl_bg = (findDisplay 3002) displayCtrl 1041;
		_ctrl_bg ctrlSetBackgroundColor [0,0,0,0.7];
	};

	private _ctrl_lb = (findDisplay 3002) displayCtrl 1012;

	lbAdd [1012, getText(configFile >> "CfgVehicles" >> "Land_dataTerminal_01_F" >> "displayName")];
	_ctrl_lb lbSetTextRight [0, "MHQ"];
	lbSetColorRight [1012, 0, [0.26, 0.44, 0.82, 1]];
	lbSetData [1012, 0, str (["Land_dataTerminal_01_F",0,0])];

	{
		if ((_x select 2) <= missionNamespace getVariable (if (_vehiclearray) then {"g_garage_level"} else {"a_garage_level"})) then {
			private _left_text = (getText(configFile >> "CfgVehicles" >> _x select 0 >> "displayName"));
			switch (_x # 0) do {
				case "C_IDAP_supplyCrate_F": {_left_text = "Supply Box"};
			};
			private _right_text = (if ((_x select 1) != 0) then {str (_x select 1)} else {"FREE"});
			lbAdd [1012, _left_text];
			_ctrl_lb lbSetTextRight [_forEachIndex + 1, _right_text];
			lbSetData [1012, _forEachIndex + 1, str _x];

			if ((_x select 1) != 0) then {
				if (_money < (_x select 1)) then {
					lbSetColorRight [1012, _forEachIndex + 1, [0.92, 0.13, 0.13, 1]];
				} else {
					lbSetColorRight [1012, _forEachIndex + 1, [0.04, 0.67, 0, 1]];
				};
			} else {
				lbSetColorRight [1012, _forEachIndex + 1, [0.82, 0.78, 0.04, 1]];
			};
		};
	} forEach (if (_vehiclearray) then {shop_land_vehicles} else {shop_air_vehicles});
};

prj_fnc_show_vehicle_picture = {
	private _ctrlprice = (findDisplay 3002) displayCtrl 1009;
	private _index = lbCurSel 1012;
	private _data = lbData [1012, _index];
	_data = call (compile _data);
	private _picture = getText(configfile >> "CfgVehicles" >> (_data select 0) >> "editorPreview");
	ctrlSetText [1013, _picture];
	ctrlSetText [1009, str (_data select 1)];

	ctrlSetText [1010, "LEVEL: " + str (_data select 2)];

	private _money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	if ((_data select 1) != 0) then {
		if (_money < (_data select 1)) then {
			ctrlSetText [1009, "LACKING AMOUNT: " + str ((_data select 1) - _money)];
			_ctrlprice ctrlSetTextColor [1, 0, 0, 1];
			ctrlEnable [1008, false];
			ctrlSetText [1008, "UNDERFUNDED"];
		} else {
			ctrlSetText [1009, "PRICE: " + str (_data select 1)];
			_ctrlprice ctrlSetTextColor [0, 1, 0, 1];
			ctrlEnable [1008, true];
			ctrlSetText [1008, "BUY"];
		};
	} else {
		ctrlSetText [1009, "FREE"];
		_ctrlprice ctrlSetTextColor [0, 1, 0, 1];
		ctrlEnable [1008, true];
		ctrlSetText [1008, "RECEIVE"];
	};
};

prj_fnc_spawn_vehicle = {
	closeDialog 2;

	private _index = lbCurSel 1012;
	private _data = lbData [1012, _index];
	_data = call (compile _data);

	private _checkplace = nearestObjects [position objectspawn,["landVehicle","Air","Ship"],12] # 0;
	if (!isNil "_checkplace") then {deleteVehicle _checkplace};

	private _vehicle = (_data # 0) createVehicle position objectspawn;
	_vehicle setDir ((triggerArea objectspawn) # 2);

	if ((_data # 0) == "Land_DataTerminal_01_F") then {
		if (!isNil "mhqterminal") then {
			deleteVehicle mhqterminal;
			"Взят новый терминал MHQ" remoteExec ["systemChat",0];
		};
		
		[_vehicle, "mhqterminal"] remoteExec ["setVehicleVarName"];
		missionNamespace setVariable ["mhqterminal", _vehicle, true];

		[_vehicle, 3] call ace_cargo_fnc_setSize;
		[_vehicle, "blue", "orange", "green"] call BIS_fnc_DataTerminalColor;
		[_vehicle, true, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable;

		remoteExecCall ["prj_fnc_add_mhq_action",0,_vehicle];
	};

	if ((_data # 0) == "C_IDAP_supplyCrate_F") then {
		if (!isNil "supplybox") then {
			deleteVehicle supplybox;
			"Куплен новый Supply Box" remoteExec ["systemChat",0];
		};
		[_vehicle, "supplybox"] remoteExec ["setVehicleVarName"];
		missionNamespace setVariable ["supplybox", _vehicle, true];
	};

	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;

	if ((_data # 1) != 0) then {
		["missionNamespace", "money", 0, -(_data # 1)] call prj_fnc_changePlayerVariableLocal;
	};
};

// hq menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_hq_menu = {
	private _dialog_hq = createDialog "dialogHQmenu";

	private _enemy = ((missionNamespace getVariable (getPlayerUID player)) select 1) select 1;
	private _friend = ((missionNamespace getVariable (getPlayerUID player)) select 2) select 1;
	private _civ = ((missionNamespace getVariable (getPlayerUID player)) select 3) select 1;
	private _intel_score = missionNamespace getVariable "intel_score";

	private _stats_text = localize "STR_PRJ_STATISTICS_KILLED" + ":<br/>" + localize "STR_PRJ_STATISTICS_ENEMIES" + ": " + str _enemy + "<br/>" + localize "STR_PRJ_STATISTICS_FRIENDLY" + ": " + str _friend + "<br/>" + localize "STR_PRJ_STATISTICS_CIVILIANS" + ": " + str _civ + "<br/><br/>" + localize "STR_PRJ_STATISTICS_INTELSCORE" + ": " + str _intel_score + "<br/>";

	private _stat_p = (_enemy * 10) - (_friend * 50) - (_civ * 25);

	private _ctrl_name = (findDisplay 3000) displayCtrl 1001;

	private ["_picture"];

	switch (true) do {
		case (_stat_p >= 250) : {
			_picture = "img\icons\icon_smile_good_g.paa";
			_ctrl_name ctrlSetTextColor [0.18, 0.48, 0.08, 1];
		};
		case (_stat_p >= 50) : {
			_picture = "img\icons\icon_smile_good_y.paa";
			_ctrl_name ctrlSetTextColor [0.25, 0.82, 0.07, 1];
		};
		case (_stat_p <= -300) : {
			_picture = "img\icons\icon_smile_wtf.paa";
			_ctrl_name ctrlSetTextColor [0.37, 0.13, 0.13, 1];
			};
		case (_stat_p <= -150) : {
			_picture = "img\icons\icon_smile_bad_r.paa";
			_ctrl_name ctrlSetTextColor [0.61, 0.16, 0.16, 1];
		};
		case (_stat_p <= -20) : {
			_picture = "img\icons\icon_smile_bad_y.paa";
			_ctrl_name ctrlSetTextColor [0.82, 0.45, 0.07, 1];
		};
		case (_stat_p < 50) : {
			_picture = "img\icons\icon_smile_n.paa";
			_ctrl_name ctrlSetTextColor [0.82, 0.76, 0.07, 1];
		};
	};
	ctrlSetText [1029, _picture];

	private _ctrl = (findDisplay 3000) displayCtrl 1002;
	_ctrl ctrlSetStructuredText parseText _stats_text;
	_ctrl ctrlSetTextColor [0.8, 0.8, 0, 1];

	ctrlSetText [1001, toUpper (name player)];
};

prj_fnc_tpmhq = {
	if (isNil "mhqterminal") exitWith {
		hintC (localize "STR_PRJ_MHQ_IN_NOT_EXIST");
		hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
			0 = _this spawn {
				_this select 0 displayRemoveEventHandler ["unload", hintC_EH];
				hintSilent "";
			};
		}];
	};

	if ((mhqterminal animationPhase "lid_rot_1") != 0) then {
		player setposATL ((getpos mhqterminal) findEmptyPosition [ 0 , 15 , "B_soldier_F" ]);
		closeDialog 2;
	} else {
		hintC (localize "STR_PRJ_MHQ_IS_NOT_DEPLOYED");
		hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
			0 = _this spawn {
				_this select 0 displayRemoveEventHandler ["unload", hintC_EH];
				hintSilent "";
			};
		}];
	};
};

// bank menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_bank_menu = {
	private _dialog_bank = createDialog "dialogBankMenu";

	private _ctrl = (findDisplay 3001) displayCtrl 1007;

	private _money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	ctrlSetText [1007, str _money];

	if (_money >= 0) then {
		_ctrl ctrlSetTextColor [0.2, 0.7, 0.18, 1];
	} else {
		_ctrl ctrlSetTextColor [0.82, 0.17, 0.17, 1];
	};

	ctrlEnable [1005, false];

	{
		lbAdd [1003, name _x];
		lbSetData [1003, _forEachIndex, getPlayerUID _x];
	} forEach allPlayers - (entities "HeadlessClient_F");
};

prj_fnc_transfer_points = {
	params ["_player","_value"];

	if ((getPlayerUID player) in _player) then {
		["missionNamespace", "money", 0, _value] call prj_fnc_changePlayerVariableLocal;
		hint format [localize "STR_PRJ_GET_POINTS",_value];
	};
};

prj_fnc_btn_transfer_points = {
	private _index = lbCurSel 1003;
	private _player = lbData [1003, _index];
	_player = [_player];
	private _value = parseNumber (ctrlText 1004);
	private _money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	if (_value isEqualTo 0) exitWith {hint localize "STR_PRJ_NUMBER_OF_POINTS"};
	if (_value > _money) exitWith {hint localize "STR_PRJ_DONT_HAVE_POINTS"};
	if ((_value <= 0) || ((typeName _value) != "SCALAR" )) exitWith {hint localize "STR_PRJ_INVALID_VALUE"};

	_value = round _value;

	[_player,_value] remoteExec ["prj_fnc_transfer_points", 0];

	["missionNamespace", "money", 0, -_value] call prj_fnc_changePlayerVariableLocal;

	hint format [localize "STR_PRJ_SENT_POINTS",_value];

	_money = ((missionNamespace getVariable (getPlayerUID player)) select 0) select 1;

	private _ctrl = (findDisplay 3001) displayCtrl 1007;
	ctrlSetText [1007, str _money];

	if (_money >= 0) then {
		_ctrl ctrlSetTextColor [0.2, 0.7, 0.18, 1];
	} else {
		_ctrl ctrlSetTextColor [0.82, 0.17, 0.17, 1];
	};
};

prj_fnc_player_info = {
	ctrlEnable [1005, true];
};

// upgrades menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_upgrades_menu = {
	createDialog "dialogUpgradesMenu";

	ctrlEnable [1026, false];

	if !((getPlayerUID player) in hqUID || player getVariable ["officer",false]) then {
		{ctrlEnable [_x, false]} forEach [1027,1028];
	};

	ctrlSetText [1026,localize "STR_PRJ_STATISTICS_ARSENAL" + " (WIP)"];
	ctrlSetText [1027,localize "STR_PRJ_STATISTICS_AIRSHOP"];
	ctrlSetText [1028,localize "STR_PRJ_STATISTICS_GROUNDSHOP"];

	private _ctrl = (findDisplay 3006) displayCtrl 1025;
	private _text = localize "STR_PRJ_STATISTICS_INTELSCORE" + ": <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "intel_score") + "</t>";
	_ctrl ctrlSetStructuredText parseText _text;

	private _ctrl = (findDisplay 3006) displayCtrl 1022;
	private _text = localize "STR_PRJ_STATISTICS_ARSENAL" + ": <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "arsenal_level") + " " + localize "STR_PRJ_STATISTICS_LVL" +  "</t>";
	_ctrl ctrlSetStructuredText parseText _text;

	private _ctrl = (findDisplay 3006) displayCtrl 1023;
	private _text = localize "STR_PRJ_STATISTICS_AIRSHOP" + ": <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "a_garage_level") + " " + localize "STR_PRJ_STATISTICS_LVL" +  "</t>";
	_ctrl ctrlSetStructuredText parseText _text;

	private _ctrl = (findDisplay 3006) displayCtrl 1024;
	private _text = localize "STR_PRJ_STATISTICS_GROUNDSHOP" + ": <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "g_garage_level") + " " + localize "STR_PRJ_STATISTICS_LVL" +  "</t>";
	_ctrl ctrlSetStructuredText parseText _text;
};

prj_fnc_upgrade = {
	params [
		"_type"
	];

	private ["_variable","_upgrade_name","_display_ctrl","_text","_next_level"];

	switch (_type) do {
		case 1: {
			_variable = "arsenal_level";
			_upgrade_name = localize "STR_PRJ_ARSENAL";
			_display_ctrl = 1022;
			_next_level = (missionNamespace getVariable _variable) + 1;
			_text = localize "STR_PRJ_STATISTICS_ARSENAL" + ": <t size='1.2' color='#25E03F'>" + str _next_level + "</t> " + localize "STR_PRJ_STATISTICS_LVL";
		};
		case 2: {
			_variable = "a_garage_level";
			_upgrade_name = localize "STR_PRJ_A_GARAGE";
			_display_ctrl = 1023;
			_next_level = (missionNamespace getVariable _variable) + 1;
			_text = localize "STR_PRJ_STATISTICS_AIRSHOP" + ": <t size='1.2' color='#25E03F'>" + str _next_level + "</t> " + localize "STR_PRJ_STATISTICS_LVL";
		};
		case 3: {
			_variable = "g_garage_level";
			_upgrade_name = localize "STR_PRJ_G_GARAGE";
			_display_ctrl = 1024;
			_next_level = (missionNamespace getVariable _variable) + 1;
			_text = localize "STR_PRJ_STATISTICS_GROUNDSHOP" + ": <t size='1.2' color='#25E03F'>" + str _next_level + "</t> " + localize "STR_PRJ_STATISTICS_LVL";
		};
	};

	if ((missionNamespace getVariable _variable) >= 10) exitWith {hint (localize "STR_PRJ_UPGRADED" + " " + _upgrade_name + " " + localize "STR_PRJ_MAX_LEVEL")};

	private _intel_score = missionNamespace getVariable "intel_score";

	if (_intel_score < (_next_level * 200)) then {
		hint localize "STR_PRJ_DONT_HAVE_IS"
	} else {
		[missionNamespace,["intel_score",(_intel_score - (_next_level * 200)),true]] remoteExec ["setVariable",2];
		[missionNamespace,[_variable,_next_level,true]] remoteExec ["setVariable",2];

		hint format [localize "STR_PRJ_UPGRADED" + " " + _upgrade_name + " " + localize "STR_PRJ_TO_LEVEL",_next_level];

		private _ctrl_intel = (findDisplay 3006) displayCtrl 1025;
		private _text_intel = localize "STR_PRJ_STATISTICS_INTELSCORE" + ": <t size='1.2' color='#25E03F'>" + str (_intel_score - (_next_level * 200)) + "</t>";
		_ctrl_intel ctrlSetStructuredText parseText _text_intel;

		private _ctrl = (findDisplay 3006) displayCtrl _display_ctrl;
		_ctrl ctrlSetStructuredText parseText _text;
	};
};

// option menu ///////////////////////////////////////////////////////////////////////////////////////////
prj_fnc_option_menu = {
	createDialog "dialogOptionMenu";

	if !((getPlayerUID player) in hqUID || player getVariable ["officer",false]) then {
		{
			ctrlEnable [_x, false];
		} forEach [1021,1031];		
	};

	if !((getPlayerUID player) in hqUID) then {
		{
			ctrlEnable [_x, false];
		} forEach [1032,1033];
	};
};

// vehicle service menu ///////////////////////////////////////////////////////////////////////////////////
prj_fnc_price_calculate = {
	params ["_vehicle"];

	if !(typeOf _vehicle in (enemy_vehicles_light + enemy_vehicles_heavy + enemy_helicopters)) exitWith {};

	private _vehicle_armor = getNumber(configfile >> "CfgVehicles" >> typeOf _vehicle >> "armor");

	private _vehicle_price = _vehicle_armor;

	switch (true) do {
		case (_vehicle_armor < 60) : {_vehicle_price = 2 * _vehicle_armor};
		case (_vehicle_armor < 90) : {_vehicle_price = 3 * _vehicle_armor};
		case (_vehicle_armor <= 200) : {_vehicle_price = 4 * _vehicle_armor};
		case (_vehicle_armor > 200) : {_vehicle_price = 5 * _vehicle_armor};
		default {};
	};

	switch (true) do {
		case (typeOf _vehicle in enemy_vehicles_light): {_vehicle_price = _vehicle_price * 3};
		case (typeOf _vehicle in enemy_vehicles_heavy): {_vehicle_price = _vehicle_price * 4};
		default {};
	};

	// if ((damage _vehicle) < 0.2) then {
	// 	_vehicle_price = _vehicle_price + 200;
	// };

	_vehicle_price = _vehicle_price * 10;
	_vehicle_price
};

prj_fnc_vehicle_menu_window = {
	createDialog "dialogVehicleService";
	{ctrlEnable [_x, false]} forEach [1015,1045,1046,1047];

	private _vehicle = vehicle player;

	if (typeOf _vehicle in (enemy_vehicles_light + enemy_vehicles_heavy + enemy_helicopters)) then {
		private _vehicle_price = [_vehicle] call prj_fnc_price_calculate;
		private _ctrl = (findDisplay 3003) displayCtrl 1050;
		private _text = "sell a vehicle - " + str _vehicle_price + " points";
		_ctrl ctrlSetText _text;
		_ctrl ctrlSetTextColor [0.2,0.7,0,1];
	} else {
		ctrlEnable [1050, false];
		private _ctrl = (findDisplay 3003) displayCtrl 1050;
		private _text = "the vehicle is not for sale";
		_ctrl ctrlSetText _text;
	};

	for [{private _i = 0 }, { _i < (count vehicle_loadout_items) }, { _i = _i + 1 }] do {
		private _displayname = (vehicle_loadout_items # _i) # 0;
		lbAdd [1014, _displayname];
		lbSetTooltip [1014, _i, _displayname];
		lbSetData [1014, _i, str (vehicle_loadout_items # _i)];
	};
};

prj_fnc_sell_vehicle = {
	private _vehicle = vehicle player;
	private _vehicle_price = [_vehicle] call prj_fnc_price_calculate;
	["missionNamespace", "money", 0, _vehicle_price] call prj_fnc_changePlayerVariableLocal;
	player action ['GetOut',_vehicle];
	deleteVehicle (_vehicle);
	closeDialog 2;
};

prj_fnc_btn_load_enable = {
	{ctrlEnable [_x, true]} forEach [1015,1045,1046,1047];
	private _ctrlloadb = (findDisplay 3003) displayCtrl 1015;
	_ctrlloadb ctrlSetTextColor [0.8, 0.8, 0, 1];
};

prj_fnc_show_load_items = {
	lbClear 1017;

	private _index = lbCurSel 1014;
	private _items = lbData [1014, _index];
	private _items = call (compile _items);

	private _ctrlitemstext = (findDisplay 3003) displayCtrl 1017;

	{
		private _itemclass = getText(configFile >> "CfgVehicles" >> _x >> "displayName");

		if (_itemclass isEqualTo "") then {
			_itemclass = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
		};
		
		if (_itemclass isEqualTo "") then {
			_itemclass = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
		};

		lbAdd [1017, _itemclass];
		lbSetData [1017, _forEachIndex, _x];
	} forEach (_items # 1);
};

prj_fnc_load_item_to_cargo = {
	params [["_coef",1]];

	private _index = lbCurSel 1017;
	private _item = lbData [1017, _index];
	private _car = vehicle player;
	private _typeofitem = _item call BIS_fnc_itemType;

	switch (_typeofitem # 0) do {
		case "Item": {
			_car addItemCargoGlobal [_item,_coef];
		};
		case "Weapon": {
			_car addWeaponCargoGlobal [_item,_coef];
		};
		case "Equipment": {
			if ((_typeofitem  # 1) == "Backpack") then {
				_car addBackpackCargoGlobal [_item,_coef];
			} else {
				_car addItemCargoGlobal [_item,_coef];
			}
		};
		case "Magazine": {
			_car addMagazineCargoGlobal [_item,_coef];
		};
		case "Mine": {
			_car addMagazineCargoGlobal [_item,_coef];
		};
	};
};

prj_fnc_vehicle_repair = {
	private _object = vehicle player;
	private _type = typeOf _object;
	if (_object isKindOf "Man") exitWith {};
	_object setFuel 0;
	_object setVehicleAmmo 1;

	_object vehicleChat format ["Servicing vehicle. Please stand by.", _type];

	if (_object getVariable ["isDMM", false]) then {
		clearMagazineCargoGlobal _object;
		_object setDamage 0;
		_object setFuel 1;
	} else {
		private _magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
		if (count _magazines > 0) then {
			_removed = [];
			{
				if (!(_x in _removed)) then {
					_object removeMagazines _x;
					_removed = _removed + [_x];
				};
			} forEach _magazines;
			{
				_object addMagazine _x;
			} forEach _magazines;
		};

		private _count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");
		
		if (_count > 0) then {
			for "_i" from 0 to (_count - 1) do {
				_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
				_magazines = getArray(_config >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
						_object removeMagazines _x;
						_removed = _removed + [_x];
					};
				} forEach _magazines;
				{
					_object addMagazine _x;
					
				} forEach _magazines;
				_count_other = count (_config >> "Turrets");
				if (_count_other > 0) then {
					for "_i" from 0 to (_count_other - 1) do {
						_config2 = (_config >> "Turrets") select _i;
						_magazines = getArray(_config2 >> "magazines");
						_removed = [];
						{
							if (!(_x in _removed)) then {
								_object removeMagazines _x;
								_removed = _removed + [_x];
							};
						} forEach _magazines;
						{	
							_object addMagazine _x;
							
						} forEach _magazines;
					};
				};
			};
		};
		_object setVehicleAmmo 1;	
		_object setDamage 0;		
		_object setFuel 1;	
	};
	_object vehicleChat format ["Vehicle is ready.", _type];
};

prj_fnc_slideMonitorMenu = {
	
	private _monitorObject = missionNamespace getVariable ["slidesMonitor",nil];
	if (isNil "_monitorObject") exitWith {};

	private _dialog_monitor = createDialog "dialogSlideMonitorMenu";

	private _textures = _monitorObject getVariable "slidesArray";
	private _currentSlide = _monitorObject getVariable ["slideNumber",nil];

	private "_text";
	if (isNil "_currentSlide") then {
		_text = "титульный слайд"
	} else {
		_text = str (_textures # _currentSlide)
	};

	ctrlSetText [1055, "слайд:" + _text];
};

prj_fnc_arsenal_shop_window = {
	createDialog "dialogArsenalShop";
	{ctrlEnable [_x, false]} forEach [1082];

	for [{private _i = 0 }, { _i < (count arsenal_shop_items) }, { _i = _i + 1 }] do {
		private _displayname = (arsenal_shop_items # _i) # 0;
		lbAdd [1018, _displayname];
		lbSetTooltip [1018, _i, _displayname];
		lbSetData [1018, _i, str (arsenal_shop_items # _i)];
	};
};

prj_fnc_show_arsenal_items = {
	lbClear 1019;

	private _index = lbCurSel 1018;
	private _items = lbData [1018, _index];
	private _items = call (compile _items);

	private _ctrl_lb = (findDisplay 3007) displayCtrl 1019;

	private _money = ((missionNamespace getVariable (getPlayerUID player)) # 0) # 1;

	{
		private _item = (_x # 0);
		private _price = (_x # 1);

		private "_configPath";
		private _configs = ["CfgVehicles","CfgWeapons","CfgMagazines","CfgGlasses"];

		for "_i" from 0 to ((count _configs) - 1) do {
			if (isClass (configfile >> (_configs # _i) >> _item)) then {
				_configPath = configfile >> (_configs # _i) >> _item;
			};
		};

		private _left_text = getText(_configPath >> "displayName");

		lbAdd [1019, _left_text];
		lbSetData [1019, _forEachIndex, str _x];

		_ctrl_lb lbSetTextRight [_forEachIndex, str _price];

		if (_price != 0) then {
			if (_money < _price) then {
				lbSetColorRight [1019, _forEachIndex, [0.92, 0.13, 0.13, 1]];
			} else {
				lbSetColorRight [1019, _forEachIndex, [0.04, 0.67, 0, 1]];
			};
		} else {
			lbSetColorRight [1019, _forEachIndex, [0.82, 0.78, 0.04, 1]];
		};

 	} forEach (_items # 1);
};

prj_fnc_show_arsenal_item_info = {

	{ctrlSetText [_x, ""]} forEach [1082,1081,1080];

	private _index = lbCurSel 1019;
	private _data = lbData [1019, _index];
	_data = call (compile _data);

	private _item = _data # 0;
	private _price = _data # 1;

	// item config

	private ["_configPath","_configName"];

	{
		if (isClass (configfile >> _x >> _item)) then {
			_configPath = configfile >> _x >> _item;
			_configName = _x;
		};
	} forEach ["CfgVehicles","CfgWeapons","CfgMagazines","CfgGlasses"];

	// item picture

	private _picture = getText(_configPath >> "picture");
	if !(_picture isEqualTo "") then {ctrlSetText [1081, _picture]} else {ctrlSetText [1083, "no image"]};
		
	// item description

	private _desc = getText(_configPath >> "descriptionShort");
	if (_desc isEqualTo "") then {_desc = "They did not come up with a description"};

	// item mass

	private _mass = getNumber(_configPath >> "mass");

	if (_mass isEqualTo 0 && {isClass (_configPath >> "itemInfo")}) then {
		_mass = getNumber(_configPath >> "itemInfo" >> "mass");
	};

	if (_mass isEqualTo 0 && {isClass (_configPath >> "WeaponSlotsInfo")}) then {
		_mass = getNumber(_configPath >> "WeaponSlotsInfo" >> "mass");
	};

	_mass = format ["%1kg (%2lb)",((_mass * 0.1 * (1/2.2046) * 100) / 100) ToFixed 2, ((_mass * 0.1 * 100) / 100) ToFixed 2];

	// item set final text

	private _itemInfo = "The information ran away somewhere";

	switch (_configName) do {
		case "CfgVehicles": {
			_itemInfo = _desc + "<br/><br/>" +
						"Weight: <t color='#ffffff'>" + _mass + "</t><br/>";
		};

		case "CfgWeapons": {
			_itemInfo = _desc + "<br/><br/>" +
						"Weight: <t color='#ffffff'>" + _mass + "</t><br/>";

			// weapon info
			if (_item isKindOf ["Rifle", configFile >> "CfgWeapons"] || _item isKindOf ["Pistol", configFile >> "CfgWeapons"]) then {
				// rate of fire
				private _fireModes = getArray (_configPath >> "modes");
				private _rateOfFire = [];

				{_rateOfFire pushBackUnique (getNumber (_configPath >> _x >> "reloadTime"))} foreach _fireModes;

				_rateOfFire sort true;
				_rateOfFire = _rateOfFire param [0, 0];

				_rateOfFire = format ["%1 rpm", round (60 / _rateOfFire)];
				if (_rateOfFire isEqualTo 0) then {_rateOfFire = "PEW PEW PEW"};

				// accuracy
				private _dispersion = [];

				{
					if (getNumber (_configPath >> _x >> "showToPlayer") != 0) then {
						_dispersion pushBackUnique (getNumber (_configPath >> _x >> "dispersion"));
					};
				} foreach _fireModes;

				_dispersion sort true;
				_dispersion = _dispersion param [0, 0];

				private _accuracy = format ["%1 MIL (%2 MOA)", (_dispersion * 1000) toFixed 2, (_dispersion / pi * 10800) ToFixed 1];

				// barrel length
				private _barrelLength = str (getNumber(_configPath >> "ACE_barrelLength"));
				if (_barrelLength isEqualTo "") then {_barrelLength = ""};

				// barrel twist
				private _barrelTwist = str (getNumber(_configPath >> "ACE_barrelTwist"));
				if (_barrelTwist isEqualTo "") then {_barrelTwist = ""};

				// info text
				_itemInfo = _itemInfo + "<br/>" + 
							"Rate of fire: <t color='#ffffff'>" + _rateOfFire + "</t><br/>" + 
							"Accuracy: <t color='#ffffff'>" + _accuracy + "</t><br/>" +
							"Barrel length: <t color='#ffffff'>" + _barrelLength + " mm</t><br/>" +
							"Barrel twist: <t color='#ffffff'>" + _barrelTwist + " mm</t>";
			};
		};

		case "CfgMagazines": {
			_itemInfo = _desc + "<br/><br/>" +
						"Weight: <t color='#ffffff'>" + _mass + "</t><br/>";

			if ((getNumber(_configPath >> "type")) == 256) then {
				// ammo in magazines
				private _ammo = getText(_configPath >> "ammo");
				if (_ammo isEqualTo "") then {_ammo = ""};

				// initial velocity
				private _initialVelocity = str (getNumber(_configPath >> "initSpeed"));
				if (_initialVelocity isEqualTo "") then {_initialVelocity = ""};

				// bullet info
				private _bulletConfigPath = configfile >> "CfgAmmo" >> _ammo;

				// ballistic сoefficient			
				private _ballisticCoefficient = str ((getArray(_bulletConfigPath >> "ACE_ballisticCoefficients")) # 0);
				if (_ballisticCoefficient isEqualTo "") then {_ballisticCoefficient = ""};

				// bullet mass
				private _bulletMass = str (getNumber(_bulletConfigPath >> "ACE_bulletMass"));
				if (_bulletMass isEqualTo "") then {_bulletMass = ""};

				_itemInfo = _desc + "<br/><br/>" +
							"Weight: <t color='#ffffff'>" + _mass + "</t><br/><br/>" +
							"Ammunition: <t color='#ffffff'>" + _ammo + "</t><br/>" +
							"Initial velocity: <t color='#ffffff'>" + _initialVelocity + " m/s</t><br/>" +
							"Ballistic сoefficient: <t color='#ffffff'>" + _ballisticCoefficient + " G7 (ASM)</t><br/>" +
							"Bullet mass: <t color='#ffffff'>" + _bulletMass + " g</t><br/>";
			};
		};

		case "CfgGlasses": {
			_itemInfo = _desc + "<br/><br/>" +
						"Weight: <t color='#ffffff'>" + _mass + "</t><br/>";
		};

		default {
			_itemInfo = "lol. hello...<br/>It wasn't supposed to happen...";
		};
	};

	private _ctrlInfo = (findDisplay 3007) displayCtrl 1080;
	_ctrlInfo ctrlSetStructuredText parseText _itemInfo;
	_ctrlInfo ctrlSetTextColor [0.8, 0.8, 0, 1];

	// button

	private _money = ((missionNamespace getVariable (getPlayerUID player)) # 0) # 1;

	if (_price != 0) then {
		if (_money < _price) then {
			ctrlSetText [1082, "LACKING AMOUNT: " + str (_price - _money)];
			ctrlEnable [1082, false];
		} else {
			ctrlSetText [1082, "BUY"];
			ctrlEnable [1082, true];
		};
	} else {
		ctrlSetText [1082, "RECEIVE"];
		ctrlEnable [1082, true];
	};

};