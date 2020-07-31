/*
	written by eugene27.
	server only
*/


params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _pos = ([3] call prj_fnc_select_road_position) select 0;

private _mines = [];

for [{private _i = 0 }, { _i < ([5,15] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
    private _roads = _pos nearRoads 250;
    private _roads = _roads select {isOnRoad _x};
    private _road = selectRandom _roads;
    _pos = getPos _road;

    private _mine = createMine [selectRandom ied, _pos, [], 0];
    _mines pushBack _mine;

    if (prj_debug) then {
        private _marker = createMarker [("minemarker" + str _i + str (position _mine)), position _mine];
        _marker setMarkerType "mil_dot";
        _marker setMarkerColor "ColorBLACK";
    };
};

{independent revealMine _x} forEach _mines;

[west, [_taskID], ["STR_SIDE_MINES_DESCRIPTION", "STR_SIDE_MINES_TITLE", ""], _pos, "CREATED", 0, true, "mine"] call BIS_fnc_taskCreate;

[_taskID,_pos,"ColorOrange",0.7,[[750,750],"ELLIPSE"]] call prj_fnc_create_marker;

uiSleep 1;

waitUntil {sleep 5;{!mineActive _x} forEach _mines || _taskID call BIS_fnc_taskCompleted};

if ({!mineActive _x} forEach _mines) then {
    [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
    [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
deleteMarker _taskID;