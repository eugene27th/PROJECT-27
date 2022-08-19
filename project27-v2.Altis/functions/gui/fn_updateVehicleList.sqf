/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_updateVehicleList;
    
    Return:
		nothing
*/


private _ctrlListBox = (findDisplay 3000) displayCtrl 1000;
private _ctrlCombo = (findDisplay 3000) displayCtrl 1003;

private _comboIndex = lbCurSel _ctrlCombo;
private _vehicleType = _ctrlCombo lbText _comboIndex;

lbClear _ctrlListBox;

private _classNames = [_vehicleType] call P27_fnc_getVehicleClassNames;

if (!isNil "additionalClassesToVehicleSpawnList") then {
	_classNames = additionalClassesToVehicleSpawnList + _classNames;
};

{
	private _displayName = (getText(configFile >> "CfgVehicles" >> _x >> "displayName"));

	if (isNil "_displayName") then {
		continue;
	};

	_ctrlListBox lbAdd _displayName;
	_ctrlListBox lbSetData [_forEachIndex, _x];
} forEach _classNames;

_ctrlListBox lbSetCurSel 0;
