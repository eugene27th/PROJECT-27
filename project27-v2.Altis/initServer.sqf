call compile preprocessFileLineNumbers "config.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;

[] spawn P27_fnc_unitSideUpdate;
[] spawn P27_fnc_setMissionEvents;
[] call P27_fnc_generateSectors;
[50] call P27_fnc_createIedOnRoads;
[50] call P27_fnc_generateCheckpoints;
[] spawn P27_fnc_generateAmbientTraffic;

["respawn", position respawn, "ICON", [1,1], "COLOR:", "ColorBlufor", "PERSIST", "TEXT:", "HQ", "TYPE:", "b_hq"] call CBA_fnc_createMarker;