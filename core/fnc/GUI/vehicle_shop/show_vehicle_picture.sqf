/*
	written by eugene27.
	1.3.0
*/

private ["_ctrlprice","_index","_data"];

_ctrlprice = (findDisplay 3002) displayCtrl 1009;
_index = lbCurSel 1012;
_data = lbData [1012, _index];
_data = call (compile _data);
_picture = getText(configfile >> "CfgVehicles" >> (_data select 0) >> "editorPreview");
ctrlSetText [1013, _picture];
ctrlSetText [1009, str (_data select 1)];

ctrlSetText [1010, "LEVEL: " + str (_data select 2)];

if ((_data select 1) != 0) then {
	if ((player getVariable "money") < (_data select 1)) then {
		ctrlSetText [1009, "LACKING AMOUNT: " + str ((_data select 1) - (player getVariable "money"))];
		_ctrlprice ctrlSetTextColor [1, 0, 0, 1];
		ctrlEnable [1008, false];
		ctrlSetText [1008, "UNDERFUNDED"];
	}
	else
	{
		ctrlSetText [1009, "PRICE: " + str (_data select 1)];
		_ctrlprice ctrlSetTextColor [0, 1, 0, 1];
		ctrlEnable [1008, true];
		ctrlSetText [1008, "BUY"];
	};
}
else
{
	ctrlSetText [1009, "FREE"];
	_ctrlprice ctrlSetTextColor [0, 1, 0, 1];
	ctrlEnable [1008, true];
	ctrlSetText [1008, "RECEIVE"];
};