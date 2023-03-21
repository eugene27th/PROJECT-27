/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_setPlayerActions
*/


// task actions
["cancelTask", "Cancel task", "", {[player call BIS_fnc_taskCurrent] remoteExecCall ["P27_fnc_cancelTask", 2]}, {visibleMap}] call P27_fnc_createSelfAction;
["createTask", "Request task", "", {[] spawn P27_fnc_showTaskDisplay}, {true}] call P27_fnc_createSelfAction;


// arsenal action
["openVirtualArsenal", "Arsenal", "", {[player, player, true] call ace_arsenal_fnc_openBox}, {!visibleMap && (player distance respawn) < 100 && (vehicle player) == player}] call P27_fnc_createSelfAction;


// vehicle actions
["openVehicleSpawner", "Get vehicle", "", {[] call P27_fnc_showVehicleList}, {!visibleMap && (player distance respawn) < 700 && (vehicle player) == player}] call P27_fnc_createSelfAction;
["openVehicleService", "Vehicle service", "", {[] call P27_fnc_showVehicleService}, {!visibleMap && (player distance respawn) < 700 && (vehicle player) != player}] call P27_fnc_createSelfAction;
["openConfigurePylons", "Configure pylons", "", {[vehicle player] call P27_fnc_showAircraftLoadout}, {!visibleMap && (player distance respawn) < 700 && (vehicle player) != player && (((vehicle player) call BIS_fnc_objectType) # 1) in ["Helicopter", "Plane"]}] call P27_fnc_createSelfAction;


// treatment
["fullHealLocal", "Heal yourself", "", {[player] call ace_medical_treatment_fnc_fullHealLocal}, {!visibleMap && (player distance respawn) < 100}] call P27_fnc_createSelfAction;


// teleport to mhq
["tpToMhq", "To MHQ", "", {[] call P27_fnc_teleportToMhq}, {!visibleMap && !(isNil "mhqTerminal") && (player distance respawn) < 100}] call P27_fnc_createSelfAction;

// mhq actions
["mhqDeploy", "Deploy MHQ", "", "Land_DataTerminal_01_F", {
    params ["_target"];

    [_target, 3] call BIS_fnc_dataTerminalAnimate;
    [_target, -1] call ace_cargo_fnc_setSize;
    [_target, false, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable;
}, {true}] call P27_fnc_createClassAction;

["mhqUndeploy", "Undeploy MHQ", "", "Land_DataTerminal_01_F", {
    params ["_target"];

    [_target, 0] call BIS_fnc_dataTerminalAnimate;
    [_target, 3] call ace_cargo_fnc_setSize;
    [_target, true, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable;
}, {true}] call P27_fnc_createClassAction;


// civil orders (radius)
["civilOrders", "Civil orders", "", {true}, {!visibleMap && (vehicle player) == player}] call P27_fnc_createSelfAction;

["civilStop", "STOP", "", {["STOP"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetDown", "DOWN", "", {["DOWN"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGoAway", "GO AWAY", "", {["GOAWAY"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilHandsUp", "HANDS UP", "", {["HANDSUP"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetOut", "GET OUT", "", {["GETOUT"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;


// environment
["environmentSettings", "Environment", "", {true}, {(player distance respawn) < 100}] call P27_fnc_createSelfAction;

// set time
["skipTime", "Skip time", "", {true}, {true}, ["environmentSettings"]] call P27_fnc_createSelfAction;

["skipTime1", "1h", "", {["current", 1] remoteExecCall ["P27_fnc_changeEnvironment", 2]}, {true}, ["environmentSettings", "skipTime"]] call P27_fnc_createSelfAction;
["skipTime2", "2h", "", {["current", 2] remoteExecCall ["P27_fnc_changeEnvironment", 2]}, {true}, ["environmentSettings", "skipTime"]] call P27_fnc_createSelfAction;
["skipTime4", "4h", "", {["current", 4] remoteExecCall ["P27_fnc_changeEnvironment", 2]}, {true}, ["environmentSettings", "skipTime"]] call P27_fnc_createSelfAction;
["skipTime6", "6h", "", {["current", 6] remoteExecCall ["P27_fnc_changeEnvironment", 2]}, {true}, ["environmentSettings", "skipTime"]] call P27_fnc_createSelfAction;

// set weather
["setWeather", "Set weather", "", {true}, {true}, ["environmentSettings"]] call P27_fnc_createSelfAction;

["setWeatherClean", "Clean", "", {["clean"] remoteExecCall ["P27_fnc_changeEnvironment", 2]}, {true}, ["environmentSettings", "setWeather"]] call P27_fnc_createSelfAction;
["setWeatherCloudy", "Cloudy", "", {["cloudy"] remoteExecCall ["P27_fnc_changeEnvironment", 2]}, {true}, ["environmentSettings", "setWeather"]] call P27_fnc_createSelfAction;
["setWeatherRain", "Rain", "", {["rain"] remoteExecCall ["P27_fnc_changeEnvironment", 2]}, {true}, ["environmentSettings", "setWeather"]] call P27_fnc_createSelfAction;
["setWeatherRainstorm", "Rainstorm", "", {["rainstorm"] remoteExecCall ["P27_fnc_changeEnvironment", 2]}, {true}, ["environmentSettings", "setWeather"]] call P27_fnc_createSelfAction;


// player stats
["playerStats", "My statistics", "", {true}, {true}] call P27_fnc_createSelfAction;

["getPlayerStats", "Get my stats", "", {[true] call P27_fnc_getPlayerStats}, {true}, ["playerStats"]] call P27_fnc_createSelfAction;
["toggleKillMessage", "Switch kill reports", "", {
    private _state = !(player getVariable ["killReports", false]);

    player setVariable ["killReports", _state, true];
    systemChat format ["Show kill reports: %1.", _state];
}, {true}, ["playerStats"]] call P27_fnc_createSelfAction;


// other
["changeViewSettings", "View settings", "", {[] call P27_fnc_showViewSettings}, {true}] call P27_fnc_createSelfAction;