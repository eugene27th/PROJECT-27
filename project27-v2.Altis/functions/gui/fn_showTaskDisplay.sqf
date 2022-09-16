/*
    Author: eugene27
    Date: 13.09.2022
    
    Example:
        [] call P27_fnc_showTaskDisplay
*/


if !(missionNamespace getVariable ["taskIsAvailable", true]) exitWith {
	["1 minute between creating a task."] remoteExec ["systemChat"];
};

private _taskList = [];
private _allSectors = [true, true, true, true] call P27_fnc_getRandomSectorPos;

{
	_x params ["_taskName", ["_inNearestSectors", false], ["_inCapturedSectors", false]];
	
	private _availableSectors = _allSectors;

	if (_inCapturedSectors) then {
		_availableSectors = _availableSectors select {_x getVariable "isCaptured"};
	};

	if ((count _availableSectors) < 1) then {
		continue;
	};

	if (_inNearestSectors) then {
		_availableSectors = _availableSectors select [0,5];
	};

	private _selectedSector = selectRandom _availableSectors;
	private _sectorPosition = position _selectedSector;

	if (debugMode) then {
		systemChat format ["%1 / %2 / %3 / %4", _taskName, _inNearestSectors, _inCapturedSectors, _sectorPosition];
	};

	_taskList pushBack [
		_sectorPosition,
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
		[_taskName, _sectorPosition]
	];

	_allSectors deleteAt (_allSectors find _selectedSector);
} forEach configTasks;

[findDisplay 46, position player, _taskList, [], ["respawn"], [], 0.1, false, 0, true] spawn BIS_fnc_strategicMapOpen;