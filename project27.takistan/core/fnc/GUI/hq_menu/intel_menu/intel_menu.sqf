/*
	written by eugene27.
	1.3.0
*/

private ["_intel_objects","_office_table_items","_intel_score","_lb_index","_intel_index","_intel_displayName","_intel_number","_intel_text","_ctrl","_text"];

_intel_objects = [
	["acex_intelitems_photo",5],
	["acex_intelitems_document",3],
	["ACE_Cellphone",2],
	["acex_intelitems_notepad",1]
];

createDialog "dialogIntelMenu";

ctrlEnable [1019, false];

_office_table_items = [((getItemCargo office_table) select 0) + ((getMagazineCargo office_table) select 0),((getItemCargo office_table) select 1) + ((getMagazineCargo office_table) select 1)];

_intel_score = 0;
_lb_index = 0;

for [{private _i = 0 }, { _i < (count _intel_objects) }, { _i = _i + 1 }] do {
	_intel_index = (_office_table_items select 0) find ((_intel_objects select _i) select 0);
	if (_intel_index >= 0) then {
		_intel_displayName = getText(configFile >> "CfgMagazines" >> (_office_table_items select 0) select _intel_index >> "displayName");
		if (_intel_displayName isEqualTo "") then {
			_intel_displayName = getText(configFile >> "CfgWeapons" >> (_office_table_items select 0) select _intel_index >> "displayName");
		};
		_intel_number = (_office_table_items select 1) select _intel_index;
		_intel_score = _intel_score + (((_intel_objects select _i) select 1) * _intel_number * 10);
		_intel_text = "x" + str _intel_number + " " + _intel_displayName;
		lbAdd [1018, _intel_text];
		lbSetTooltip [1018, _lb_index, _intel_text];
		lbSetData [1018, _lb_index, str [(_office_table_items select 0) select _intel_index,_intel_number]];
		lbSetValue [1018, _lb_index, ((_intel_objects select _i) select 1)];
		_lb_index = _lb_index + 1;
	};
};

_ctrl = (findDisplay 3004) displayCtrl 1020;
_text = "INTEL SCORE:<t size='1.2' color='#25E03F'> " + str (missionNamespace getVariable "intel_score") + "</t>";
_ctrl ctrlSetStructuredText parseText _text;