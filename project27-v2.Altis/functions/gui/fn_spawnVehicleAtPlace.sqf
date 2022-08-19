/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_spawnVehicleAtPlace;
    
    Return:
		nothing
*/


private _ctrlListBox = (findDisplay 3000) displayCtrl 1000;

private _listBoxIndex = lbCurSel _ctrlListBox;
private _vehicleClass = _ctrlListBox lbData _listBoxIndex;

closeDialog 1;

private _ctrlHelpText = (findDisplay 46) ctrlCreate ["RscStructuredText", -1];

_ctrlHelpText ctrlSetStructuredText (parseText ("<t font='PuristaMedium' align='center'>ESC: cancel | Space: spawn | Mouse wheel: rotate"));
_ctrlHelpText ctrlSetPosition [safezoneX, 0.807961 * safezoneH + safezoneY, safezoneW, 0.0279964 * safezoneH];
_ctrlHelpText ctrlCommit 0;

player setVariable ["ctrlHelpText", _ctrlHelpText];


private _localVehicle = _vehicleClass createVehicleLocal (position player);
_localVehicle attachTo [player, [0, 5, 2]];
_localVehicle setDir 90;

player setVariable ["localVehicle", _localVehicle];


private _scrollEventIndex = (findDisplay 46) displayAddEventHandler ["MouseZChanged", {
	params ["_displayOrControl", "_scroll"];

	private _localVehicle = player getVariable "localVehicle";
	_localVehicle setDir ((getDir _localVehicle) - (getDir player)) + (_scroll * 2);
}];

player setVariable ["scrollEventIndex", _scrollEventIndex];


private _keyDownEventIndex = (findDisplay 46) displayAddEventHandler ["keyDown", {
	params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];

	if (_key != 57 && _key != 1) exitWith {};

	private _localVehicle = player getVariable "localVehicle";

	if (_key == 57) then {
		private _className = typeOf _localVehicle;
		private _spawnPosition = (position player) getPos [5, getDir player];
		private _direction = getDir _localVehicle;

		[_className, _spawnPosition, _direction] spawn {
			params ["_className", "_spawnPosition", "_direction"];

			sleep 0.1;

			private _spawnedVehicle = createVehicle [_className, _spawnPosition, [], 0, "CAN_COLLIDE"];
			_spawnedVehicle setDir _direction;

			clearItemCargoGlobal _spawnedVehicle;
			clearMagazineCargoGlobal _spawnedVehicle;
			clearWeaponCargoGlobal _spawnedVehicle;
			clearBackpackCargoGlobal _spawnedVehicle;
		};
	};

	ctrlDelete (player getVariable "ctrlHelpText");
	deleteVehicle _localVehicle;

	(findDisplay 46) displayRemoveEventHandler ["MouseZChanged", player getVariable "scrollEventIndex"];
	(findDisplay 46) displayRemoveEventHandler ["keyDown", player getVariable "keyDownEventIndex"];

	{player setVariable [_x, nil]} forEach ["localVehicle", "scrollEventIndex", "keyDownEventIndex"];

	if (_key == 1) then {
		true;
	};
}];

player setVariable ["keyDownEventIndex", _keyDownEventIndex];