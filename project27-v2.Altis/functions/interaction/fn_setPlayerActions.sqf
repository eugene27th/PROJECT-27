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
    ["ts_" + _task, localize ("STR_TASK_" + _task + "_TITLE"), "", {[_task] remoteExecCall ["P27_fnc_createTask", 2]}, {true}, ["taskManagement", "requestTask"]] call P27_fnc_createSelfAction;
} forEach configTasks;


// arsenal action
["openVirtualArsenal", "Arsenal", "", {[player, player, true] call ace_arsenal_fnc_openBox}, {(player distance respawn) < 100 && (vehicle player) == player}] call P27_fnc_createSelfAction;


// vehicle actions
["openVehicleSpawner", "Get vehicle", "", {[] call P27_fnc_showVehicleList}, {(player distance respawn) < 100 && (vehicle player) == player}] call P27_fnc_createSelfAction;
["openVehicleService", "Vehicle service", "", {[] call P27_fnc_showVehicleService}, {(player distance respawn) < 100 && (vehicle player) != player}] call P27_fnc_createSelfAction;


// treatment
["fullHealLocal", "Heal yourself", "", {[player] call ace_medical_treatment_fnc_fullHealLocal}, {(player distance respawn) < 100}] call P27_fnc_createSelfAction;


// civil orders (radius)
["civilOrders", "Civil orders", "", {true}, {(vehicle player) == player}] call P27_fnc_createSelfAction;

["civilStop", "STOP", "", {[player, "STOP"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetDown", "DOWN", "", {[player, "DOWN"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGoAway", "GO AWAY", "", {[player, "GOAWAY"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilHandsUp", "HANDS UP", "", {[player, "HANDSUP"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetOut", "GET OUT", "", {[player, "GETOUT"] call P27_fnc_giveOrderToCivilian}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;