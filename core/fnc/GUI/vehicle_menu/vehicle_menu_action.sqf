/*
	written by eugene27.
	1.3.0
*/

private ["_action"];

ismainbase = _this select 2;
landvehicle = _this select 3;

if ((vehicle player) isKindOf "Man") exitWith {};

_action = player addAction ["<t color='#FFB900'>Vehicle operations</t>", {[ismainbase,landvehicle] call prj_fnc_vehicle_menu_window}];
waitUntil {(player distance (getPos (_this select 1))) > 15};
player removeaction _action;