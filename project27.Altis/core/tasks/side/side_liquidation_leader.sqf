/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _center_pos = [1,false] call prj_fnc_select_position;

private _pos = [_center_pos, 200] call prj_fnc_select_house_position;

private _leader = (createGroup independent) createUnit [selectRandom enemy_leaders, _pos, [], 0, "NONE"];
private _enemy = (createGroup independent) createUnit [selectRandom enemy_infantry, position _leader, [], 0, "NONE"];
{_x setBehaviour "CARELESS"} forEach [_leader,_enemy];

[_taskID,_center_pos,"ColorEAST",0.7,[[200,200],"ELLIPSE"]] call prj_fnc_create_marker;

private _picture = getText(configfile >> "CfgVehicles" >> typeOf _leader >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_LIQUIDATION_LEADER_DESCRIPTION",_picture], "STR_SIDE_LIQUIDATION_LEADER_TITLE", ""], _center_pos, "CREATED", 0, true, "kill"] call BIS_fnc_taskCreate;

waitUntil {sleep 5; !alive _leader || _taskID call BIS_fnc_taskCompleted};

if (!alive _leader) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;
	sleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach [_leader,_enemy];
deleteMarker _taskID;