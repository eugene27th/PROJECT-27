/*
    Author: eugene27
    Date: 05.11.2022
    
    Example:
        [] call P27_fnc_resetPylons
*/


private _allControls = allControls findDisplay 3002;

{
	private _data = _x lbData (lbCurSel _x);
	
	if !(_data isEqualTo "") then {
		_x lbSetCurSel 0;
	};
} forEach _allControls;