/*
    Author: eugene27
    Date: 13.09.2022
    
    Example:
        [] spawn P27_fnc_showTaskDisplay
*/


if !(missionNamespace getVariable ["taskIsAvailable", true]) exitWith {
	systemChat "1 minute between creating a task.";
};

private _taskList = [];
private _allSectorPositions = missionNamespace getVariable "sectorPositions";

if (isNil "_allSectorPositions") exitWith {
	systemChat "No tasks available.";
};

{
	_x params ["_taskName", ["_inNearestSectors", false], ["_inCapturedSectors", false]];
	
	private _availablePositions = _allSectorPositions # 1;

	if (_inCapturedSectors) then {
		_availablePositions = _allSectorPositions # 0;
	};

	if ((count _availablePositions) < 1) then {
		continue;
	};

	if (_inNearestSectors) then {
		_availablePositions = _availablePositions select [0,5];
	};

	private _taskPosition = selectRandom _availablePositions;

	if (debugMode) then {
		systemChat format ["%1 / %2 / %3 / %4", _taskName, _inNearestSectors, _inCapturedSectors, _taskPosition];
	};

	_taskList pushBack [
		_taskPosition,
		{
			if (debugMode) then {
				systemChat format ["start %1", _this # 9];
			};
			[(_this # 9) # 0, (_this # 9) # 1] remoteExecCall ["P27_fnc_createTask", 2];
		},
		localize (format ["STR_P27_TASK_TITLE_%1", toUpper _taskName]),
        localize (format ["STR_P27_TASK_DESCRIPTION_%1", toUpper _taskName]),
        "",
		"",
		1,
		[_taskName, _taskPosition]
	];

	{
		private _index = _x find _taskPosition;

		if (_index != -1) then {
			_x deleteAt _index;
		};
	} forEach _allSectorPositions;
	
} forEach configTasks;

if ((count _taskList) < 1) exitWith {
	systemChat "No tasks available.";
};

[findDisplay 46, position player, _taskList, [], ["respawn"], [], 0.1, false, 0, true] spawn BIS_fnc_strategicMapOpen;