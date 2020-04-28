/*
	written by eugene27.
	1.3.0
*/

createDialog "dialogUpgradesMenu";

private ["_ctrl_arsenal","_text_arsenal","_ctrl_a_grg","_text_a_grg","_ctrl_g_grg","_text_g_grg","_next_arsenal_level","_next_a_garage_level","_next_g_garage_level","_ctrl_intel","_text_intel"];

private _arrayUIDs = ["76561198141746661","76561198138702011","76561198343937417","76561198061237087"];

ctrlEnable [1026, false];

if !((getPlayerUID player) in _arrayUIDs || player getVariable ["officer",false]) then {
	{ctrlEnable [_x, false]} forEach [1027,1028];
};

_ctrl_intel = (findDisplay 3006) displayCtrl 1025;
_text_intel = "INTEL SCORE: <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "intel_score") + "</t>";
_ctrl_intel ctrlSetStructuredText parseText _text_intel;

_ctrl_arsenal = (findDisplay 3006) displayCtrl 1022;
_text_arsenal = "ARSENAL: <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "arsenal_level") + " LVL</t>";
_ctrl_arsenal ctrlSetStructuredText parseText _text_arsenal;

_ctrl_a_grg = (findDisplay 3006) displayCtrl 1023;
_text_a_grg = "AIR GARAGE: <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "a_garage_level") + " LVL</t>";
_ctrl_a_grg ctrlSetStructuredText parseText _text_a_grg;

_ctrl_g_grg = (findDisplay 3006) displayCtrl 1024;
_text_g_grg = "LAND GARAGE: <t size='1.2' color='#25E03F'>" + str (missionNamespace getVariable "g_garage_level") + " LVL</t>";
_ctrl_g_grg ctrlSetStructuredText parseText _text_g_grg;