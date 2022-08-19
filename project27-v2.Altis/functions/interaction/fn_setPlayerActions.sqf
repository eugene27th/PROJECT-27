/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_setPlayerActions;
    
    Return:
		nothing
*/


// task actions
["taskManagement", "Task management", "", {true}, {true}] call P27_fnc_createSelfAction;

["cancelTask", "Cancel task", "", {[player call BIS_fnc_taskCurrent] remoteExecCall ["P27_fnc_cancelTask", 2]}, {true}, ["taskManagement"]] call P27_fnc_createSelfAction;
["requestTask", "Request task", "", {true}, {true}, ["taskManagement"]] call P27_fnc_createSelfAction;

{
    private _task = _x;
    ["ts_" + _task, localize ("STR_P27_TASK_TITLE_" + (toUpper _task)), "", {[_task] remoteExecCall ["P27_fnc_createTask", 2]}, {true}, ["taskManagement", "requestTask"]] call P27_fnc_createSelfAction;
} forEach configTasks;


// arsenal action
["openVirtualArsenal", "Arsenal", "", {[player, player, true] call ace_arsenal_fnc_openBox}, {(player distance respawn) < 100 && (vehicle player) == player}] call P27_fnc_createSelfAction;


// vehicle actions
["openVehicleSpawner", "Get vehicle", "", {[] call P27_fnc_showVehicleList}, {(player distance respawn) < 100 && (vehicle player) == player}] call P27_fnc_createSelfAction;
["openVehicleService", "Vehicle service", "", {[] call P27_fnc_showVehicleService}, {(player distance respawn) < 100 && (vehicle player) != player}] call P27_fnc_createSelfAction;


// treatment
["fullHealLocal", "Heal yourself", "", {[player] call ace_medical_treatment_fnc_fullHealLocal}, {(player distance respawn) < 100}] call P27_fnc_createSelfAction;


// teleport to mhq
["tpToMhq", "To MHQ", "", {[] call P27_fnc_teleportToMhq}, {!(isNil "mhqTerminal")}] call P27_fnc_createSelfAction;

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
["civilOrders", "Civil orders", "", {true}, {(vehicle player) == player}] call P27_fnc_createSelfAction;

["civilStop", "STOP", "", {["STOP"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetDown", "DOWN", "", {["DOWN"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGoAway", "GO AWAY", "", {["GOAWAY"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilHandsUp", "HANDS UP", "", {["HANDSUP"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetOut", "GET OUT", "", {["GETOUT"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;