/*
    Author: eugene27
    Date: 20.09.2022
    
    Example:
        [] call P27_fnc_showAircraftLoadout
*/


params ["_vehicle"];

createDialog "dialogConfigurePylons";

private _display = findDisplay 3002;
private _ctrlUiPicture = _display displayCtrl 3000;

private _pylonComponent = (configOf _vehicle) >> "Components" >> "TransportPylonsComponent";

_ctrlUiPicture ctrlSetText (getText (_pylonComponent >> "uiPicture"));

{
	private _ctrlPylon = _display ctrlCreate ["RscCombo", -1];

    private _uiPicturePos = ctrlPosition _ctrlUiPicture;
    private _uiPos = getArray (_x >> "UIposition");

    _ctrlPylon ctrlSetPosition [(_uiPicturePos select 0) + (_uiPos select 0), (_uiPicturePos select 1) + (_uiPos select 1), 0.1 * safezoneW, 0.028 * safezoneH];
    _ctrlPylon ctrlCommit 0;

    _ctrlPylon lbAdd "empty";
	_ctrlPylon lbSetCurSel 0;

    private _currentMag = (getPylonMagazines _vehicle) select _forEachIndex;
    private _compatibleMags = _vehicle getCompatiblePylonMagazines (_forEachIndex + 1);

    private _index = 0;

    {
		_ctrlPylon lbAdd getText (configFile >> "CfgMagazines" >> _x >> "displayName");

        if (_x == _currentMag) then {
            _index = _forEachIndex + 1;
        };
    } forEach _compatibleMags;
} forEach ("true" configClasses (_pylonComponent >> "Pylons"));