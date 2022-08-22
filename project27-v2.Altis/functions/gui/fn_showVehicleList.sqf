/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_showVehicleList
*/


createDialog "dialogVehicleList";

private _ctrlCombo = (findDisplay 3000) displayCtrl 1003;

{
	_ctrlCombo lbAdd _x;
} forEach ["All", "Car", "Tank", "Helicopter", "Plane", "Ship", "StaticWeapon"];

_ctrlCombo lbSetCurSel 0;