/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_setMissionEvents
*/


addMissionEventHandler ["Entitykilled", {
	params ["_victim", "_killer"];

	if (!isPlayer _killer || _victim == _killer) exitWith {};

	private _victimSide = _victim getVariable "unitSide";
	private _enemySide = ((configUnits # 0) # 0);

	if (isNil "_victimSide") exitWith {};

	private _playerUID = getPlayerUID _killer;
	private _playerStats = missionNamespace getVariable ["playerStats", []];
	private _playerIndex = _playerStats findIf {(_x # 0) == _playerUID};

	private "_playerStat";

	if (_playerIndex == -1) then {
		_playerStat = [0, 0, 0];
	} else {
		_playerStat = (_playerStats # _playerIndex) # 1;
	};

	switch (_victimSide) do {
		case (_enemySide): {
			_playerStat set [0, (_playerStat # 0) + 1];
		};
		case (side _killer): {
			_playerStat set [1, (_playerStat # 1) + 1];
		};
		case civilian: {
			_playerStat set [2, (_playerStat # 2) + 1];
		};
	};

	if (_playerIndex == -1) then {
		_playerStats pushBack [_playerUID, _playerStat];
	} else {
		_playerStats set [_playerIndex, [_playerUID, _playerStat]];
	};
	
	missionNamespace setVariable ["playerStats", _playerStats, true];
}];