/*
    Author: eugene27
    Date: 21.03.2022
    
    Example:
        [] call P27_fnc_createUnitToPlayerCrew
*/


params [["_player", player], ["_className", "B_W_Crew_F"]];


if (leader (group _player) != leader _player) then {
    [_player] join (createGroup [west, true]);
};


private _unit = (group _player) createUnit [_className, position _player, [], 0, "NONE"];

if ((vehicle _player) != _player) then {
    _unit moveInAny (vehicle _player);
};


private _playerCrew = _player getVariable ["playerCrew", []];

_playerCrew pushBack _unit;

_player setVariable ["playerCrew", _playerCrew, true];