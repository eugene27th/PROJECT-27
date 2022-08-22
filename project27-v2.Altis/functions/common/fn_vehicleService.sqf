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


private _vehicleClass = typeOf _vehicle;

_vehicle setFuel 1;
_vehicle setDamage 0;
_vehicle setVehicleAmmo 1;


private _magazines = getArray(configFile >> "CfgVehicles" >> _vehicleClass >> "magazines");

if (count _magazines > 0) then {
    private _removed = [];

    {
        if (!(_x in _removed)) then {
            _vehicle removeMagazines _x;
            _removed append _x;
        };
    } forEach _magazines;

    {
        _vehicle addMagazine _x;
    } forEach _magazines;
};


private _turretsCount = count (configFile >> "CfgVehicles" >> _vehicleClass >> "Turrets");
    
if (_turretsCount > 0) then {
    for "_i" from 0 to (_turretsCount - 1) do {
        private _turretConfig = (configFile >> "CfgVehicles" >> _vehicleClass >> "Turrets") select _i;
        private _turretMagazines = getArray(_turretConfig >> "magazines");

        private _removed = [];

        {
            if (!(_x in _removed)) then {
                _vehicle removeMagazines _x;
                _removed append _x;
            };
        } forEach _turretMagazines;

        {
            _vehicle addMagazine _x;
            
        } forEach _turretMagazines;

        private _otherTurretsCount = count (_turretConfig >> "Turrets");

        if (_otherTurretsCount > 0) then {
            for "_i" from 0 to (_otherTurretsCount - 1) do {
                private _otherTurretConfig = (_turretConfig >> "Turrets") select _i;
                private _otherTurretMagazines = getArray(_otherTurretConfig >> "magazines");

                private _removed = [];

                {
                    if (!(_x in _removed)) then {
                        _vehicle removeMagazines _x;
                        _removed append _x;
                    };
                } forEach _otherTurretMagazines;

                {	
                    _vehicle addMagazine _x;
                } forEach _otherTurretMagazines;
            };
        };
    };
};