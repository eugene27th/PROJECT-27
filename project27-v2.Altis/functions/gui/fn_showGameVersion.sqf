/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_showGameVersion
*/


disableSerialization;

waitUntil{!isNull (findDisplay 46)};

private _ctrlText = (findDisplay 46) ctrlCreate ["RscStructuredText", -1];

private _playerUID = getPlayerUID player;
private _firstSymbolsUID = [_playerUID, 0, 4] call CBA_fnc_substr;
private _lastSymbolsUID = [_playerUID, (([_playerUID] call CBA_fnc_strLen) - 4)] call CBA_fnc_substr;

private _systemTime = systemTimeUTC apply { if (_x < 10) then { "0" + str _x } else { str _x } };

private _ctrlX = (safezoneW - 22 * (((safezoneW / safezoneH) min 1.2) / 40)) + (safeZoneX);
private _ctrlY = (safezoneH - 2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + (safeZoneY);
private _ctrlW = 20 * (((safezoneW / safezoneH) min 1.2) / 40);
private _ctrlH = 5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);

_ctrlText ctrlSetStructuredText (parseText (format ["<t font='PuristaMedium' align='right' size='0.75' shadow='0'>%1 | %2%3%4%5%6", version, _firstSymbolsUID, _lastSymbolsUID, _systemTime # 0, _systemTime # 1, _systemTime # 2]));
_ctrlText ctrlSetPosition [_ctrlX, _ctrlY, _ctrlW, _ctrlH];
_ctrlText ctrlSetFade 0.2;
_ctrlText ctrlCommit 0;