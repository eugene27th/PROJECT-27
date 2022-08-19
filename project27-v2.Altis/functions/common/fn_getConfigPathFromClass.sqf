/*
    Author: eugene27
    Date: 19.08.2022
    
    Example:
        [_class] call P27_fnc_getConfigPathFromClass;
    
    Return:
		config path
*/


params ["_class"];

private _configs = ["CfgVehicles", "CfgWeapons", "CfgMagazines", "CfgGlasses"];

private "_configPath";
		
for "_i" from 0 to ((count _configs) - 1) do {
	private _configClass = configfile >> (_configs # _i) >> _class;

	if (isClass _configClass) then {
		_configPath = _configClass;
	};
};

_configPath