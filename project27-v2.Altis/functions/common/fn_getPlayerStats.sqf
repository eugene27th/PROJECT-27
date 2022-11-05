/*
    Author: eugene27
    Date: 05.11.2022
    
    Example:
        [] call P27_fnc_getPlayerStats
*/


params [["_chatMessage", false]];

private _playerUID = getPlayerUID player;
private _playerData = (missionNamespace getVariable ["playerStats", []]) select {(_x # 0) == _playerUID};

if ((count _playerData) < 1) exitWith {
	if (_chatMessage) then {
		systemChat "There are no statistics for you. Kill someone :)";
	};
};

private _playerStats = (_playerData # 0) # 1;

if (_chatMessage) then {
	systemChat format ["Killed: enemy - %1 ; friendly - %2 ; civil - %3.", _playerStats # 0, _playerStats # 1, _playerStats # 2];
} else {
	_playerStats
};