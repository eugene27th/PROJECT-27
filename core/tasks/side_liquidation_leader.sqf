/*
	written by eugene27.
	server only
	1.3.0
*/

params [
    "_taskID","_reward"
];

private ["_taskID","_center_pos","_pos","_leader","_enemy","_picture"];

_taskID = "SIDE_" + str _taskID;

_center_pos = [1,false] call prj_fnc_select_position;

_pos = [_center_pos, 200] call prj_fnc_select_house_position;

_leader = (createGroup independent) createUnit [selectRandom enemy_leaders_array, _pos, [], 0, "NONE"];
_enemy = (createGroup independent) createUnit [selectRandom enemy_units_array, position _leader, [], 0, "NONE"];
{_x setBehaviour "CARELESS"} forEach [_leader,_enemy];

[_taskID,_center_pos,"ColorEAST",0.7,[[200,200],"ELLIPSE"]] call prj_fnc_create_marker;

_picture = getText(configfile >> "CfgVehicles" >> typeOf _leader >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_LIQUIDATION_LEADER_DESCRIPTION",_picture], "STR_SIDE_LIQUIDATION_LEADER_TITLE", ""], _center_pos, "CREATED", 0, true, "kill"] call BIS_fnc_taskCreate;

waitUntil {sleep 5; !alive _leader || _taskID call BIS_fnc_taskCompleted};

if (!alive _leader) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
	sleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach [_leader,_enemy];
deleteMarker _taskID;