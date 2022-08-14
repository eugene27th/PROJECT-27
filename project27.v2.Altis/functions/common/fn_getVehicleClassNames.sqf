/*
    Author: eugene27
    Date: 14.08.2022
    
    Example:
        [_type] call P27_fnc_getVehicleClassNames;
    
    Return:
		array of classNames
*/


params [["_type", "All"]];

private _classNames = [];

if ((typeName _type) == "STRING") then {
	if (_type == "All") then {
		{
			_classNames	append (("getNumber (_x >> 'scope') >= 2 && configName _x isKindof '" + _x + "'" configClasses (configFile >> "CfgVehicles")) apply {configName _x});
		} forEach ["Car", "Tank", "Helicopter", "Plane", "Ship", "StaticWeapon"];
	} else {
		_classNames = ("getNumber (_x >> 'scope') >= 2 && configName _x isKindof '" + _type + "'" configClasses (configFile >> "CfgVehicles")) apply {configName _x};
	};
};

if ((typeName _type) == "ARRAY") then {
	{
		_classNames	append (("getNumber (_x >> 'scope') >= 2 && configName _x isKindof '" + _x + "'" configClasses (configFile >> "CfgVehicles")) apply {configName _x});
	} forEach _type;
};

_classNames