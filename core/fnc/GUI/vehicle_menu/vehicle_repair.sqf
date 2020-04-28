/*
	written by eugene27.
	1.3.0
*/

_object = vehicle player;
_type = typeOf _object;
if (_object isKindOf "Man") exitWith {};
_object setFuel 0;
_object setVehicleAmmo 1;

_object vehicleChat format ["Servicing vehicle. Please stand by.", _type];

if (_object getVariable ["isDMM", false]) then {
	clearMagazineCargoGlobal _object;
	_object setDamage 0;
	_object setFuel 1;
} else {
	_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
	if (count _magazines > 0) then {
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_object removeMagazines _x;
				_removed = _removed + [_x];
			};
		} forEach _magazines;
		{
			_object addMagazine _x;
		} forEach _magazines;
	};

	_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");
	
	if (_count > 0) then {
		for "_i" from 0 to (_count - 1) do {
			scopeName "xx_reload2_xx";
			_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
			_magazines = getArray(_config >> "magazines");
			_removed = [];
			{
				if (!(_x in _removed)) then {
					_object removeMagazines _x;
					_removed = _removed + [_x];
				};
			} forEach _magazines;
			{
				_object addMagazine _x;
				
			} forEach _magazines;
			_count_other = count (_config >> "Turrets");
			if (_count_other > 0) then {
				for "_i" from 0 to (_count_other - 1) do {
					_config2 = (_config >> "Turrets") select _i;
					_magazines = getArray(_config2 >> "magazines");
					_removed = [];
					{
						if (!(_x in _removed)) then {
							_object removeMagazines _x;
							_removed = _removed + [_x];
						};
					} forEach _magazines;
					{	
						_object addMagazine _x;
						
					} forEach _magazines;
				};
			};
		};
	};
	_object setVehicleAmmo 1;
		
	_object setDamage 0;	
		
	_object setFuel 1;	
};
_object vehicleChat format ["Vehicle is ready.", _type];