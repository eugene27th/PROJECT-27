/*
    Author: eugene27
    Date: 17.01.2023
    
    Example:
        [] call P27_fnc_allMinesNotActive
*/


params ["_mines"];

private _notActive = true;

{
	if (mineActive  _x) exitWith {
		_notActive = false;
	};
} forEach _mines;

_notActive