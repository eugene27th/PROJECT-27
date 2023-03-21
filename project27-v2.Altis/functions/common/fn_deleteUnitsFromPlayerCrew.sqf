/*
    Author: eugene27
    Date: 21.03.2022
    
    Example:
        [] call P27_fnc_deleteUnitsFromPlayerCrew
*/


params [["_player", player]];

{
    if !(isPlayer _x) then {
        deleteVehicle _x;
    };
} forEach (_player getVariable ["playerCrew", []]);