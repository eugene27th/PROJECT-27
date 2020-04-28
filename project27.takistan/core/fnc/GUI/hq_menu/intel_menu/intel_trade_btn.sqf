/*
	written by eugene27.
	1.3.0
*/

private ["_ctrlloadb","_index","_intels","_intel_score","_office_table_items","_ctrl_is","_text_is"];

ctrlEnable [1019, false];
_ctrlloadb = (findDisplay 3004) displayCtrl 1019;
ctrlSetText [1019, "SELECT INTEL"];
_ctrlloadb ctrlSetTextColor [0, 0, 0, 1];

_index = lbCurSel 1018;
_intels = lbData [1018, _index];
_intels = call (compile _intels);
_intel_score = lbValue [1018, _index];

[missionNamespace,["intel_score",(missionNamespace getVariable "intel_score") + ((_intel_score * (_intels select 1)) * 10),true]] remoteExec ["setVariable",2];

lbDelete [1018, _index];

_office_table_items = [((getItemCargo office_table) select 0) + ((getMagazineCargo office_table) select 0),((getItemCargo office_table) select 1) + ((getMagazineCargo office_table) select 1)];

clearItemCargoGlobal office_table;
clearMagazineCargoGlobal office_table;
clearWeaponCargoGlobal office_table;
clearBackpackCargoGlobal office_table;

for [{private _i = 0 }, { _i < (count (_office_table_items select 0)) }, { _i = _i + 1 }] do {
	if !(((_office_table_items select 0) select _i) isEqualTo (_intels select 0)) then {
		office_table addItemCargoGlobal [((_office_table_items select 0) select _i), ((_office_table_items select 1) select _i)];
	};
};

_ctrl_is = (findDisplay 3004) displayCtrl 1020;
_text_is = "INTEL SCORE:<t size='1.2' color='#25E03F'> " + str ((missionNamespace getVariable "intel_score") + ((_intel_score * (_intels select 1)) * 10)) + "</t>";
_ctrl_is ctrlSetStructuredText parseText _text_is;