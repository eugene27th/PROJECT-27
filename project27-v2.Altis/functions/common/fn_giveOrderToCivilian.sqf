/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_giveOrderToCivilian
*/


params ["_order"];

private _nearUnits = ((position player) nearEntities [["Man", "Car"], 60]) select {!(_x isEqualTo player) && ((side _x) isEqualTo civilian)};

player playActionNow "gestureFreeze";

if (isNil "_nearUnits" || _nearUnits isEqualTo []) exitWith {};

{
	if (_x isKindOf "Man") exitWith {
		switch (_order) do {
			case "DOWN": {
				if ((animationState _x) == "amovpercmstpssurwnondnon") then {
					[_x, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
				};
				_x setUnitPos "DOWN";
			};
			case "STOP": {
				doStop _x;
			};
			case "GOAWAY": {
				if ((animationState _x) == "amovpercmstpssurwnondnon") then {
					[_x, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
				};
				_x setUnitPos "UP";
				[_x] call ace_interaction_fnc_sendAway;
			};
			case "HANDSUP": {
				[_x, "AmovPercMstpSsurWnonDnon"] remoteExec ["playMove", 0];
			};
		};
	};

	private _crew = crew _x;

	if ((count _crew) < 1) exitWith {};

	switch (_order) do {
		case "GOAWAY": {
			[driver _x] call ace_interaction_fnc_sendAway;
		};
		case "STOP": {
			doStop (driver _x);
		};
		case "GETOUT": {
			for [{private _i = 0 }, { _i < (count _crew) }, { _i = _i + 1 }] do {
				(_crew # _i) leaveVehicle _x;
				unassignVehicle (_crew # _i);
			};
			_crew allowGetIn false;
		};
	};
} forEach _nearUnits;