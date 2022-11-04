/*
    Author: eugene27
    Date: 19.08.2022
    
    Example:
        [] call P27_fnc_showVehicleService
*/


createDialog "dialogVehicleService";

private _ctrlCombo = (findDisplay 3001) displayCtrl 2001;

{
	_ctrlCombo lbAdd (_x # 0);
} forEach configLoadoutItems;

_ctrlCombo lbSetCurSel 0;

[] call P27_fnc_updateInvLoadBar;