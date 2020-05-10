/*
	written by eugene27.
	1.3.0
*/

private ["_ctrlloadb","_index","_items","_itemstext","_itemclass","_itemvalue","_ctrlitemstext"];

ctrlEnable [1015, true];
_ctrlloadb = (findDisplay 3003) displayCtrl 1015;
_ctrlloadb ctrlSetTextColor [0.8, 0.8, 0, 1];

_index = lbCurSel 1014;
_items = lbData [1014, _index];
_items = call (compile _items);

_itemstext = "";

{
	_itemclass = getText(configFile >> "CfgVehicles" >> _x select 0 >> "displayName");
	if (_itemclass isEqualTo "") then {
		_itemclass = getText(configFile >> "CfgWeapons" >> _x select 0 >> "displayName");
	};
	
	if (_itemclass isEqualTo "") then {
		_itemclass = getText(configFile >> "CfgMagazines" >> _x select 0 >> "displayName");
	};
	_itemvalue = _x select 1;
	_itemstext = _itemstext + str _itemvalue + " | " + _itemclass + "<br/>";
} forEach _items;

_ctrlitemstext = (findDisplay 3003) displayCtrl 1017;
_ctrlitemstext ctrlSetStructuredText parseText _itemstext;
_ctrlitemstext ctrlSetTextColor [0.8, 0.8, 0, 1];