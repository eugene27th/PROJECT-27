/* 
	written by eugene27.
	server only
    1.3.0
*/

params [
    "_task"
];

if (_task isEqualTo "") exitWith {hint "select task on map"};

private ["_task"];

private _subTasks = _task call BIS_fnc_taskChildren;
if (_subTasks isEqualTo []) then {
    private _taskParent = _task call BIS_fnc_taskParent;
    if !(_taskParent isEqualTo "") then {
        _task = _taskParent;
        _subTasks = _task call BIS_fnc_taskChildren;
    };
};

([_task] + _subTasks) apply {
    if !(_x call BIS_fnc_taskCompleted) then {
        [_x, "CANCELED"] call BIS_fnc_taskSetState
    } else {
        false
    };
};