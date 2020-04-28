/*
	written by eugene27.
	1.3.0
*/

private ["_index","_player","_value","_ctrl"];

_index = lbCurSel 1003;
_player = lbData [1003, _index];
_player = [_player];
_value = parseNumber (ctrlText 1004);

if (_value isEqualTo 0) exitWith {hint "Укажите количество пойнтов."};
if (_value > (player getVariable "money")) exitWith {hint "У Вас не хватает пойнтов."};
if ((_value <= 0) || ((typeName _value) != "SCALAR" )) exitWith {hint "Некорректное значение."};

_value = round _value;

[_player,_value] remoteExec ["prj_fnc_transfer_points", 0];
player setVariable ["money",((player getVariable "money") - _value),true];
hint format ["Вы отправили %1 пойнтов.",_value];

_ctrl = (findDisplay 3001) displayCtrl 1007;
ctrlSetText [1007, str (player getVariable "money")];

if ((player getVariable "money") >= 0) then {
	_ctrl ctrlSetTextColor [0.2, 0.7, 0.18, 1];
}
else
{
	_ctrl ctrlSetTextColor [0.82, 0.17, 0.17, 1];
};