/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] spawn P27_fnc_unitSideUpdate
*/


private _enemySide = ((configUnits # 0) # 0);

while {true} do {
	{
		private _unitSide = _x getVariable "unitSide";

		if (isNil "unitSide") then {
			_x setVariable ["unitSide", side _x, true];
		} else {
			if (side _x != _unitSide && _unitSide != _enemySide) then {
				_x setVariable ["unitSide", side _x, true];
			};
		};
	} forEach allUnits;

	uiSleep 1;
};