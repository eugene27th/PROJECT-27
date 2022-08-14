/*
    Author: eugene27
    Date: 14.08.2022
    
    Example:
        [_task] call P27_fnc_cancelTask;
    
    Return:
		nothing
*/


params ["_task"];

if (_task isEqualTo "") exitWith {
	hint "Select task on map.";
};

private _subTasks = _task call BIS_fnc_taskChildren;

if (_subTasks isEqualTo []) then {
	private _taskParent = _task call BIS_fnc_taskParent;
	
	if !(_taskParent isEqualTo "") then {
		_task = _taskParent;
		_subTasks = _task call BIS_fnc_taskChildren;
	};
};

{
	if !(_x call BIS_fnc_taskCompleted) then {
		[_x, "CANCELED"] call BIS_fnc_taskSetState;
	};
} forEach ([_task] + _subTasks);