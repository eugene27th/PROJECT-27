call compile preprocessFileLineNumbers "config.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;

[] spawn P27_fnc_unitSideUpdate;
[] spawn P27_fnc_setMissionEvents;
[] call P27_fnc_generateSectors;
[50] call P27_fnc_createIedOnRoads;
[50] call P27_fnc_generateCheckpoints;
//[] call P27_fnc_loadGameProgress;