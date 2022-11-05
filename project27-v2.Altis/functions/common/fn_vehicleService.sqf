/*
    Author: eugene27
    Date: 19.08.2022
    
    Example:
        [] call P27_fnc_vehicleService
*/


params ["_vehicle", ["_type", "repair"]];

if (_vehicle isKindOf "Man") exitWith {};

if (_type == "delete") exitWith {
    {_x action ['GetOut', _vehicle]} forEach (crew _vehicle);
    deleteVehicle _vehicle;
    closeDialog 1;
};

if (_type == "clear") exitWith {
    clearItemCargoGlobal _vehicle;
    clearMagazineCargoGlobal _vehicle;
    clearWeaponCargoGlobal _vehicle;
    clearBackpackCargoGlobal _vehicle;
    
    [] call P27_fnc_updateInvLoadBar;
};

_vehicle setFuel 1;
_vehicle setDamage 0;
_vehicle setVehicleAmmo 1;