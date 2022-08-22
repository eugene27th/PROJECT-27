/*
    Author: eugene27
    Date: 19.08.2022
    
    Example:
        [] call P27_fnc_updateInvLoadBar
*/


private _vehicle = vehicle player;
private _ctrlLoadBar = (findDisplay 3001) displayCtrl 2007;
private _fullWidth = 0.115493;

private _vehicleLoad = load _vehicle;

if (_vehicleLoad > 1) then {
	_vehicleLoad = 1;
};

private _loadBarW = _vehicleLoad * _fullWidth;
private _loadBarColor = [1, 1, 1, 1];

if (_vehicleLoad > 0.6) then {
	_loadBarColor = [1, 1, 0, 1];
};

if (_vehicleLoad > 0.8) then {
	_loadBarColor = [1, 0, 0, 1];
};

_ctrlLoadBar ctrlSetBackgroundColor _loadBarColor;
_ctrlLoadBar ctrlSetPositionW (_loadBarW * safezoneW);
_ctrlLoadBar ctrlCommit 0.5;