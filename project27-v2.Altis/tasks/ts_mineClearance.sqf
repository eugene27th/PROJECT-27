/*
    Author: eugene27
    Date: 17.01.2023
    
    Task

    WIP
*/


params ["_sectorPosition"];

private _taskId = "ts#mineClearance#" + str serverTime;
private _taskRadius = 300;

private _roadPositions = [3, _sectorPosition, _taskRadius] call P27_fnc_getRandomRoadPositions;


private _mines = [];

{
	for [{ private _i = 0 }, { _i < [4,6] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
		_mines pushBack (createMine [selectRandom ((configObjects # 0) # 0), _x # 0, [], 15]);
	};

	if ((random 1) < 0.7) then {
		createVehicle [selectRandom ((configObjects # 0) # 1), _x # 0, [], 0, "NONE"];
	};
	
	[format ["%1#%2", _taskId, _forEachIndex], _x # 0, "ELLIPSE", [50, 50], "COLOR:", "ColorEAST", "ALPHA:", 0.5, "PERSIST"] call CBA_fnc_createMarker;
} forEach _roadPositions;


private _reinforcementMines = _mines select [(floor ((count _mines) / 2)) - 1, [1,3] call BIS_fnc_randomInt];
	
{
	_x addEventHandler ["Deleted", {
		params ["_entity"];
		[position _entity, [1, 1]] spawn P27_fnc_createReinforcements;
	}];

	_x setVariable ["spawnTrigger", _taskId];
} forEach _reinforcementMines;


[west, [_taskId], ["STR_P27_TASK_DESCRIPTION_MINECLEARANCE", "STR_P27_TASK_TITLE_MINECLEARANCE", ""], _sectorPosition, "CREATED", 0, true, "mine"] call BIS_fnc_taskCreate;


waitUntil {uiSleep 5; [_mines] call P27_fnc_allMinesNotActive || _taskId call BIS_fnc_taskCompleted};

if ([_mines] call P27_fnc_allMinesNotActive) then {
    [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
    uiSleep 2;
};

[_taskId, true, true, 3] spawn P27_fnc_clearTask;