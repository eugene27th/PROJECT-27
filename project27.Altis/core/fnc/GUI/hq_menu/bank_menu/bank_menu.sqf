/*
	written by eugene27.
	1.3.0
*/

private _dialog_bank = createDialog "dialogBankMenu";

private ["_ctrl","_text","_color"];

_ctrl = (findDisplay 3001) displayCtrl 1007;
ctrlSetText [1007, str (player getVariable "money")];

if ((player getVariable "money") >= 0) then {
	_ctrl ctrlSetTextColor [0.2, 0.7, 0.18, 1];
}
else
{
	_ctrl ctrlSetTextColor [0.82, 0.17, 0.17, 1];
};

ctrlEnable [1005, false];

{
	lbAdd [1003, name _x];
	lbSetData [1003, _forEachIndex, getPlayerUID _x];
} forEach allPlayers - (entities "HeadlessClient_F");