/*
	written by eugene27.
	1.3.0
*/

createDialog "dialogOptionMenu";

if !((getPlayerUID player) in hqUID || player getVariable ["officer",false]) then {
	ctrlEnable [1021, false];
};