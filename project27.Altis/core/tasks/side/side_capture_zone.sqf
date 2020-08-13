/*
	written by eugene27.
	server only
*/

params ["_taskID","_reward"];

private _taskID = "SIDE_" + str _taskID;

private _pos = [1,false,true] call prj_fnc_select_position;

[_taskID,_pos,"ColorEAST",0.7,[[250,250],"ELLIPSE"]] call prj_fnc_create_marker;

[west, [_taskID], ["STR_SIDE_CAPTURE_ZONE_DESCRIPTION", "STR_SIDE_CAPTURE_ZONE_TITLE", ""], _pos, "CREATED", 0, true, "attack"] call BIS_fnc_taskCreate;

_trgC = [_pos, [250, 250, 20], "WEST SEIZED", "PRESENT", true, "", false] call prj_fnc_create_trg;

waitUntil {sleep 5;triggerActivated _trgC || _taskID call BIS_fnc_taskCompleted};

if (triggerActivated _trgC) then {

    [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
    ["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;

    /*
    if ((random 1) > 0.5) then {
        [_trigger_str_name, 1, 180] spawn BIS_fnc_blinkMarker;

        _trgD = [_pos, [250, 250, 20], "ANYPLAYER", "NOT PRESENT", true, "", false] call prj_fnc_create_trg;

        [west, [_taskID + "_D",_taskID], ["STR_SIDE_DEFENCE_ZONE_DESCRIPTION", "STR_SIDE_DEFENCE_ZONE_TITLE", ""], _pos, "CREATED", 0, true, "defend"] call BIS_fnc_taskCreate;

        [_trgD] spawn {
            params ["_trgD"];

            uiSleep 180;

            private _defence = true;

            while {!(triggerActivated _trgD) && _defence} do {
                
            };
        };

        waitUntil {sleep 5;triggerActivated _trgD || _taskID call BIS_fnc_taskCompleted || (_taskID + "_D") call BIS_fnc_taskCompleted};

        if (triggerActivated _trgD) then {
            [_taskID + "_D","FAILED"] call BIS_fnc_taskSetState;
        };
    };
    */

    uiSleep 2;
};

[_taskID] call BIS_fnc_deleteTask;
//{deleteVehicle _x} forEach [_trgC,_trgD];
deleteVehicle _trgC;
deleteMarker _taskID;

/*
[_taskID + "_D","SUCCEEDED"] call BIS_fnc_taskSetState;
["missionNamespace", "money", 0, _reward] call prj_fnc_changePlayerVariableGlobal;