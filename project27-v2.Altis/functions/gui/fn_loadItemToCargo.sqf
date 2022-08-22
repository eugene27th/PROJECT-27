/*
    Author: eugene27
    Date: 19.08.2022
    
    Example:
        [] call P27_fnc_loadItemToCargo
*/


params ["_vehicle", ["_count", 1]];

private _ctrlListBox = (findDisplay 3001) displayCtrl 2002;

private _listBoxIndex = lbCurSel _ctrlListBox;
private _itemClass = _ctrlListBox lbData _listBoxIndex;
private _itemType = _itemClass call BIS_fnc_itemType;

if !(_vehicle canAdd [_itemClass, _count]) exitWith {
	_vehicle vehicleChat "Not enough space.";
};

switch (_itemType # 0) do {
	case "Item": {
		_vehicle addItemCargoGlobal [_itemClass, _count];
	};
	case "Weapon": {
		_vehicle addWeaponCargoGlobal [_itemClass, _count];
	};
	case "Equipment": {
		if ((_itemType  # 1) == "Backpack") then {
			_vehicle addBackpackCargoGlobal [_itemClass, _count];
		} else {
			_vehicle addItemCargoGlobal [_itemClass, _count];
		}
	};
	case "Magazine": {
		_vehicle addMagazineCargoGlobal [_itemClass, _count];
	};
	case "Mine": {
		_vehicle addMagazineCargoGlobal [_itemClass, _count];
	};
};

[] call P27_fnc_updateInvLoadBar;