/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [_order] call P27_fnc_giveOrderToCivilian;
    
    Return:
		nothing
*/


params ["_order"];

private _position = position player;
private _nearUnits = (_position nearEntities [["Man", "Car"], 60]) select {!(_x isEqualTo player) && ((side _x) isEqualTo civilian)};

player playActionNow "gestureFreeze";

if (isNil "_nearUnits" || _nearUnits isEqualTo []) exitWith {};

{
	if (_x isKindOf "Car") exitWith {
		private _driver = driver _x;
		private _crew = crew _x;

		switch (_order) do {
			case "GOAWAY": {
				systemChat "CAR: DOWN";
				[_driver] call ace_interaction_fnc_sendAway;
			};
			case "STOP": {
				systemChat "CAR: STOP";
				doStop _driver;
			};
			case "GETOUT": {
				systemChat "CAR: GETOUT";
				systemChat format ["%1 / %2", _x, vehicle _x];
				for [{private _i = 0 }, { _i < (count _crew) }, { _i = _i + 1 }] do {
					unassignVehicle (_crew # _i);
				};
				_crew allowGetIn false;
			};
		};
	};

	(group _x) setBehaviour "CARELESS";

	if (_order == "DOWN") then {
		systemChat "DOWN";
		_x setUnitPos "DOWN";
	} else {
		systemChat "UP";
		_x setUnitPos "UP";
	};

	if (_order == "HANDSUP") then {
		systemChat "HANDSUP";
		[_x, "AmovPercMstpSsurWnonDnon"] remoteExec ["playMove", 0];
	};

	if (_order == "GOAWAY") then {
		systemChat "GOAWAY";
		if ((animationState _x) == "amovpercmstpssurwnondnon") then {
			[_x, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
		};

		(group _x) setSpeedMode "FULL";
		[_x] call ace_interaction_fnc_sendAway;
	} else {
		systemChat "STOP";
		doStop _x;
	};
} forEach _nearUnits;