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
private _pylons = "true" configClasses (_pylonComponent >> "Pylons");

if ((count _pylons) < 1) exitWith {};

_ctrlUiPicture ctrlSetText (getText (_pylonComponent >> "uiPicture"));

{
	private _ctrlPylon = _display ctrlCreate ["RscCombo", -1, (findDisplay 3002) displayCtrl 3004];

    private _uiPicturePos = ctrlPosition _ctrlUiPicture;
    private _uiPos = getArray (_x >> "UIposition");

    _ctrlPylon ctrlSetPosition [0.079 + (_uiPos # 0), 0.167 + (_uiPos # 1), 0.1 * safezoneW, 0.028 * safezoneH];
    _ctrlPylon ctrlCommit 0;

    _ctrlPylon lbAdd "empty";
    _ctrlPylon lbSetData [0, "empty"];
    _ctrlPylon lbSetCurSel 0;
	
    private _currentMag = (getPylonMagazines _vehicle) # _forEachIndex;
    private _compatibleMags = _vehicle getCompatiblePylonMagazines (_forEachIndex + 1);

    {
        private _magDescription = getText (configFile >> "CfgMagazines" >> _x >> "descriptionShort");

		_ctrlPylon lbAdd getText (configFile >> "CfgMagazines" >> _x >> "displayName");
        _ctrlPylon lbSetData [_forEachIndex + 1, _x];
        _ctrlPylon lbSetTooltip [_forEachIndex + 1, _magDescription];

        if (_x == _currentMag) then {
            _ctrlPylon lbSetCurSel (_forEachIndex + 1);
        };
    } forEach _compatibleMags;
} forEach _pylons;