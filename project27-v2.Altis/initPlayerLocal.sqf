call compile preprocessFileLineNumbers "config.sqf";

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

[] spawn P27_fnc_showGameVersion;
[] spawn P27_fnc_setPlayerEvents;
[] spawn P27_fnc_setPlayerActions;

[player, true] call ace_arsenal_fnc_initBox;

player setPos (position respawn);