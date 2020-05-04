/* 
	written by eugene27.  
*/

params [
	"_order","_position"
];

_list = _position nearEntities [["Man"], 60];
_units = _list select {!(_x isEqualTo player) && ((side _x) isEqualTo civilian)};

if (_units isEqualTo []) exitWith {true};
{
	for "_i" from (count waypoints (group _x)) - 1 to 0 step -1 do {
		deleteWaypoint [group _x, _i];
	};
	(group _x) setBehaviour "CARELESS";
    switch (_order) do {
		case 1 : {
			doStop _x;
		};
		case 2 : {
			if ((animationState _x) == "amovpercmstpssurwnondnon") then {
				[_x, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
			};
			doStop _x;
			_x setUnitPos "DOWN";
		};
		case 3 : {
			if ((animationState _x) == "amovpercmstpssurwnondnon") then {
				[_x, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
			};
			_x setUnitPos "UP";
			(group _x) setSpeedMode "FULL";
			[_x] call ace_interaction_fnc_sendAway;
		};
		case 4 : {
			_x setUnitPos "UP";
			doStop _x;
			[_x, "AmovPercMstpSsurWnonDnon"] remoteExec ["playMove", 0];
		};
	};
} forEach _units;