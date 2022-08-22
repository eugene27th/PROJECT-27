/*
    Author: eugene27
    Date: 19.08.2022
    
    Example:
        [_count] call P27_fnc_updateItemsList
*/


private _ctrlListBox = (findDisplay 3001) displayCtrl 2002;
private _ctrlCombo = (findDisplay 3001) displayCtrl 2001;

private _comboIndex = lbCurSel _ctrlCombo;
private _itemsCategory = _ctrlCombo lbText _comboIndex;

lbClear _ctrlListBox;

private _itemsArray = (configLoadoutItems # _comboIndex) # 1;

{
	private _configPath = [_x] call P27_fnc_getConfigPathFromClass;

	_ctrlListBox lbAdd (getText(_configPath >> "displayName"));
	_ctrlListBox lbSetData [_forEachIndex, _x];
} forEach _itemsArray;