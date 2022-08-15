/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] spawn/call P27_fnc_setPlayerActions;
    
    Return:
		nothing
*/


// task actions
["taskManagement", "Task management", "whiteboard_ca", {true}, {true}] call P27_fnc_createSelfAction;
["cancelTask", "Cancel task", "getout_ca", {[player call BIS_fnc_taskCurrent] remoteExecCall ["P27_fnc_cancelTask", 2]}, {true}, ["taskManagement"]] call P27_fnc_createSelfAction;

["requestTask", "Request task", "documents_ca", {true}, {true}, ["taskManagement"]] call P27_fnc_createSelfAction;
{
    private _taskName = _x;
    [_taskName, _taskName, "documents_ca", {[_taskName] remoteExecCall ["P27_fnc_createTask", 2]}, {true}, ["taskManagement", "requestTask"]] call P27_fnc_createSelfAction
} forEach configTasks;


// arsenal action
["openVirtualArsenal", "Arsenal", "documents_ca", {[player, player, true] call ace_arsenal_fnc_openBox}, {(player distance respawn) < 100}] call P27_fnc_createSelfAction;


// vehicle actions
["openVehicleSpawner", "Get vehicle", "car_ca", {[] call P27_fnc_showVehicleList}, {(player distance respawn) < 100}] call P27_fnc_createSelfAction;
["openVehicleService", "Vehicle service", "car_ca", {true}, {(player distance respawn) < 100 && (vehicle player) != player}] call P27_fnc_createSelfAction;


// civil orders (radius)
["civilOrders", "Civil orders", "talk_ca", {true}, {true}] call P27_fnc_createSelfAction;
["civilStop", "STOP", "talk1_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetDown", "DOWN", "talk2_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGoAway", "GO AWAY", "talk3_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilHandsUp", "HANDS UP", "talk4_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetOut", "GET OUT", "talk5_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;