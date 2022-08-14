call compile preprocessFileLineNumbers "config.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;

[] spawn P27_fnc_unitSideUpdate;
[] spawn P27_fnc_setMissionEvents;
[] call P27_fnc_generateSectors;
//[] call P27_fnc_loadGameProgress;