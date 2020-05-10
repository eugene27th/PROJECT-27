/*
	written by eugene27.
	1.3.0
*/

closeDialog 2;

private ["_index","_data","_checkplace","_data","_vehicle"];

_index = lbCurSel 1012;
_data = lbData [1012, _index];
_data = call (compile _data);

_checkplace = nearestObjects [position objectspawn,["landVehicle","Air","Ship"],12] select 0;
if (!isNil "_checkplace") then {deleteVehicle _checkplace};

_vehicle = (_data select 0) createVehicle position objectspawn;
_vehicle setDir (getDir objectspawn);

if ((_data select 0) == "Land_DataTerminal_01_F") then {
	if (!isNil "mhqterminal") then {
		deleteVehicle mhqterminal
	};
	
	_vehicle setVehicleVarName "mhqterminal";
	missionNamespace setVariable ["mhqterminal", _vehicle, true];

	[_vehicle, 3] call ace_cargo_fnc_setSize; 
	[_vehicle, "blue", "orange", "green"] call BIS_fnc_DataTerminalColor;
	[_vehicle, true, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable;

	remoteExecCall ["prj_fnc_add_mhq_action"];
};

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

player setVariable ["money",(player getVariable "money") - (_data select 1),true];