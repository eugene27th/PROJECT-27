/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] spawn/call P27_fnc_setPlayerActions;
    
    Return:
		nothing
*/


// task actions
["taskManagement", "Task management", "simpleTasks\types\whiteboard_ca", {true}, {true}] call P27_fnc_createSelfAction;
["cancelTask", "Cancel task", "simpleTasks\types\getout_ca", {true}, {true}, ["taskManagement"]] call P27_fnc_createSelfAction;
["requestTask", "Request task", "simpleTasks\types\documents_ca", {true}, {true}, ["taskManagement"]] call P27_fnc_createSelfAction;


// arsenal action
["openVirtualArsenal", "Arsenal", "Actions\gear_ca", {[player, player, true] call ace_arsenal_fnc_openBox}, {(player distance respawn) < 100}] call P27_fnc_createSelfAction;


// vehicle actions
["openVehicleSpawner", "Get vehicle", "simpleTasks\types\car_ca", {[] call P27_fnc_showVehicleList}, {(player distance respawn) < 100}] call P27_fnc_createSelfAction;
["openVehicleService", "Vehicle service", "simpleTasks\types\car_ca", {true}, {(player distance respawn) < 100 && (vehicle player) != player}] call P27_fnc_createSelfAction;


// civil orders (radius)
["civilOrders", "Civil orders", "simpleTasks\types\talk_ca", {true}, {true}] call P27_fnc_createSelfAction;
["civilStop", "STOP", "simpleTasks\types\talk1_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetDown", "DOWN", "simpleTasks\types\talk2_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGoAway", "GO AWAY", "simpleTasks\types\talk3_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilHandsUp", "HANDS UP", "simpleTasks\types\talk4_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;
["civilGetOut", "GET OUT", "simpleTasks\types\talk5_ca", {true}, {true}, ["civilOrders"]] call P27_fnc_createSelfAction;