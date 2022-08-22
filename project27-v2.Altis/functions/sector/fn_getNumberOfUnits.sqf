/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [] call P27_fnc_getNumberOfUnits
*/

params ["_number"];


private _return = switch (_number) do {
	case 0: {1};
	case 1: {[2,4] call BIS_fnc_randomInt};
	case 2: {[4,8] call BIS_fnc_randomInt};
	case 3: {[8,12] call BIS_fnc_randomInt};
	default {1};
};

_return