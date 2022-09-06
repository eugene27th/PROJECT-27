/*
    Author: eugene27
    Date: 27.08.2022
    
    Example:
        [] spawn P27_fnc_generateAmbientTraffic

    WIP
*/


while {true} do {
    private _allSectorTriggers = (missionNamespace getVariable "sectorTriggers") select {!(_x getVariable "isCaptured") && !(_x getVariable "isActive")};

    if ((count _allSectorTriggers) < 1) exitWith {};

    // получить скопление игроков, получить ближайший сектор от 1-1.5км от них (старт), получить азимут от сектора до них, получить сектор "за ними" (финиш) через 3-4км без игроков вокруг

    uiSleep 600;
};