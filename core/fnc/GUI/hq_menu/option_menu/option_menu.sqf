/*
	written by eugene27.
	1.3.0
*/

createDialog "dialogOptionMenu";

private _arrayUIDs = ["76561198141746661","76561198138702011","76561198343937417","76561198061237087"];

if !((getPlayerUID player) in _arrayUIDs || player getVariable ["officer",false]) then {
	ctrlEnable [1021, false];
};