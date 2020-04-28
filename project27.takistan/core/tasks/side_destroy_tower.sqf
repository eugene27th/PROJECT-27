/*
	written by eugene27.
	server only
	1.3.0
*/

params [
    "_taskID","_reward"
];

private ["_taskID","_center_pos","_pos","_tower_class","_tower","_generator","_picture"];

_taskID = "SIDE_" + str _taskID;

_center_pos = [1,false] call prj_fnc_select_position;
_pos = [_center_pos, 200, 500, 3, 0] call BIS_fnc_findSafePos;

_tower_class = selectRandom towers_array;
_tower = (_tower_class select 0) createVehicle _pos;
_generator = (_tower_class select 1) createVehicle ((position _tower) findEmptyPosition [0,20,_tower_class select 1]);

_picture = getText(configfile >> "CfgVehicles" >> _tower_class select 0 >> "editorPreview");

[west, [_taskID], [format [localize "STR_SIDE_DESTROY_TOWER_DESCRIPTION", _picture], "STR_SIDE_DESTROY_TOWER_TITLE", ""], _center_pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

[_taskID,_center_pos,"ColorOrange",0.7,[[500,500],"ELLIPSE"]] call prj_fnc_create_marker;

/*
изменить и добавить если будут рации
[] spawn { 
	{
		while {alive _tower || alive _generator} do {
			if (alive _tower || alive _generator && player distance _tower < 2000) then
			{
				//player setVariable ["tf_receivingDistanceMultiplicator", 0];
				player setVariable ["tf_sendingDistanceMultiplicator", 0.1];
			}
			else
			{
				//player setVariable ["tf_receivingDistanceMultiplicator", 1];
				player setVariable ["tf_sendingDistanceMultiplicator", 1];
			};
			uiSleep 10;
		};
	} remoteExec ["bis_fnc_call", 0];
};
*/

waitUntil {sleep 5; !alive _tower || !alive _generator || _taskID call BIS_fnc_taskCompleted};

if (!alive _tower || !alive _generator) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
	[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
	sleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
{deleteVehicle _x} forEach [_tower,_generator];
deleteMarker _taskID;