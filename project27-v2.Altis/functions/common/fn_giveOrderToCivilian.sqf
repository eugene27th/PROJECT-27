/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [_player, _order] call P27_fnc_giveOrderToCivilian;
    
    Return:
		nothing
*/


params ["_player", "_order"];

private _position = position _player;
private _nearUnits = (_position nearEntities [["Man"], 60]) select {!(_x isEqualTo player) && ((side _x) isEqualTo civilian)};

player playActionNow "gestureFreeze";

if (isNil _nearUnits || _nearUnits isEqualTo []) exitWith {};

{
	(group _x) setBehaviour "CARELESS";

	if (_order == "DOWN") then {
		_x setUnitPos "DOWN";
	} else {
		_x setUnitPos "UP";
	};

	if (_order == "GOAWAY") then {
		(group _x) setSpeedMode "FULL";
		[_x] call ace_interaction_fnc_sendAway;
	} else {
		doStop _x;
	};

	if (_order == "HANDSUP") then {
		[_x, "AmovPercMstpSsurWnonDnon"] remoteExec ["playMove", 0];
	};

	if (_order == "GETOUT" && vehicle _x != _x) then {
		systemChat "GETOUT";
		doGetOut _x;
		unassignVehicle _x;
	};
} forEach _nearUnits;