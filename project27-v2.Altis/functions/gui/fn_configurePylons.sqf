/*
    Author: eugene27
    Date: 05.11.2022
    
    Example:
        [] call P27_fnc_configurePylons
*/


private _allControls = allControls findDisplay 3002;

private _vehicle = vehicle player;
private _currentPylonMagazines = getPylonMagazines _vehicle;

private _pylonsConfig = [];

{
	private _data = _x lbData (lbCurSel _x);
	
	if !(_data isEqualTo "") then {
		_pylonsConfig pushBack _data;
	};
} forEach _allControls;

{
	private _magazineName = _x;

	if (debugMode) then {
		systemChat format ["%1 - %2", _forEachIndex + 1, _magazineName];
	};

	if (_magazineName == "empty") then {
		_magazineName = "";
	};
	
	_vehicle removeWeapon (getText (configFile >> "CfgMagazines" >> (_currentPylonMagazines # _forEachIndex) >> "pylonWeapon"));
	_vehicle setPylonLoadout [_forEachIndex + 1, _magazineName, true];
} forEach _pylonsConfig;