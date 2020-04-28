/*
	written by eugene27.
	1.3.0
*/

private ["_index","_items","_car","_selectitem","_typeofitem"];

_index = lbCurSel 1014;
_items = lbData [1014, _index];
_items = call (compile _items);

_car = (vehicle player);

for [{private _i = 0 }, { _i < (count _items) }, { _i = _i + 1 }] do {
	_selectitem = _items select _i;
	_typeofitem = (_selectitem select 0) call BIS_fnc_itemType;
	switch (_typeofitem select 0) do {
		case "Item": {
			_car addItemCargoGlobal _selectitem;
		};
		case "Weapon": {
			_car addWeaponCargoGlobal _selectitem;
		};
		case "Equipment": {
			if ((_typeofitem  select 1) == "Backpack") then {
				_car addBackpackCargoGlobal _selectitem;
			}
			else
			{
				_car addItemCargoGlobal _selectitem;
			}
		};
		case "Magazine": {
			_car addMagazinecargoGlobal _selectitem;
		};
		case "Mine": {
			_car addMagazinecargoGlobal _selectitem;
		};
	};
};
