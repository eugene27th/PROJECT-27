/*
	written by eugene27.
	1.3.0
*/

params [
	"_player","_value"
];

if ((getPlayerUID player) in _player) then {
	player setVariable ["money",((player getVariable "money") + _value),true];
	hint format [localize "STR_PRJ_GET_POINTS",_value];
};