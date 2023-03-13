/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_updateVehicleList
*/


private _updateVehicleClasses = {
	vehicleListClassNames = [_vehicleType, [_vehicleType] call P27_fnc_getVehicleClassNames];	

	if (!isNil "additionalClassesToVehicleSpawnList") then {
		vehicleListClassNames = [_vehicleType, additionalClassesToVehicleSpawnList + (vehicleListClassNames # 1)];
	};

	if (debugMode) then {
		systemChat format ["%1 - %2", vehicleListClassNames # 0, count (vehicleListClassNames # 1)];
	};
};


private _ctrlListBox = (findDisplay 3000) displayCtrl 1000;
private _ctrlCombo = (findDisplay 3000) displayCtrl 1003;

private _comboIndex = lbCurSel _ctrlCombo;
private _vehicleType = _ctrlCombo lbText _comboIndex;

lbClear _ctrlListBox;

if (isNil "vehicleListClassNames") then {
	[] call _updateVehicleClasses;
};

if (_vehicleType != (vehicleListClassNames # 0)) then {
	[] call _updateVehicleClasses;
};

private _ctrlSearchInput = (findDisplay 3000) displayCtrl 1004;
private _searchText = toLower (ctrlText _ctrlSearchInput);

private _lbDataIndex = 0;

{
	private _displayName = (getText(configFile >> "CfgVehicles" >> _x >> "displayName"));

	if (isNil "_displayName") then {
		continue;
	};

	if ((count _searchText) > 0 && ((toLower _displayName) find _searchText) < 0) then {
		continue;
	};

	_ctrlListBox lbAdd _displayName;
	_ctrlListBox lbSetData [_lbDataIndex, _x];

	_lbDataIndex = _lbDataIndex + 1;
} forEach (vehicleListClassNames # 1);

_ctrlListBox lbSetCurSel 0;