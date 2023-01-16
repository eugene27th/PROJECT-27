/*
    Author: eugene27
    Date: 16.01.2023
    
    Task

    WIP
*/


params ["_sectorPosition"];

private _taskId = "ts#hostageRescue#" + str serverTime;
private _taskRadius = 200;

private _buildingPositions = [_sectorPosition, _taskRadius] call P27_fnc_getBuildingPositions;
private _spawnPosition = selectRandom _buildingPositions;


private _hostageClass = selectRandom ["C_IDAP_Man_AidWorker_01_F", "C_IDAP_Man_AidWorker_07_F", "C_IDAP_Man_AidWorker_08_F", "C_IDAP_Man_AidWorker_09_F", "C_IDAP_Man_AidWorker_02_F", "C_IDAP_Man_AidWorker_05_F", "C_IDAP_Man_AidWorker_06_F", "C_IDAP_Man_AidWorker_04_F", "C_IDAP_Man_AidWorker_03_F", "C_journalist_F", "C_Journalist_01_War_F", "C_Man_UtilityWorker_01_F", "C_Story_EOD_01_F", "LOP_PMC_Infantry_VIP", "C_Man_Paramedic_01_F"];
private _hostagePreview = getText(configfile >> "CfgVehicles" >> _hostageClass >> "editorPreview");

private _hostageUnit = (createGroup [civilian, true]) createUnit [_hostageClass, _spawnPosition, [], 0, "NONE"];
private _secureUnit = (createGroup [((configUnits # 0) # 0), true]) createUnit [selectRandom (((configUnits # 0) # 1) # 0), _spawnPosition, [], 0, "NONE"];

[_hostageUnit, true] call ACE_captives_fnc_setHandcuffed;

{
    _x setVariable ["spawnTrigger", _taskId];
} forEach [_hostageUnit, _secureUnit];


[[_sectorPosition, _taskId], 100] spawn P27_fnc_createPatrolUnits;
[[_sectorPosition, _taskId], 100, [1,2]] spawn P27_fnc_createCrowdUnits;


[_taskId, _sectorPosition, "ELLIPSE", [_taskRadius, _taskRadius], "COLOR:", "ColorEAST", "ALPHA:", 0.5, "PERSIST"] call CBA_fnc_createMarker;
[west, [_taskId], [format [localize "STR_P27_TASK_DESCRIPTION_HOSTAGERESCUE_IMAGE", _hostagePreview], "STR_P27_TASK_TITLE_HOSTAGERESCUE", ""], _sectorPosition, "CREATED", 0, true, "help"] call BIS_fnc_taskCreate;


([_spawnPosition, "AREA:", [2, 2, 10, false], "ACT:", ["ANYPLAYER", "PRESENT", false], "STATE:", ["this", "private _hostageUnit = thisTrigger getVariable 'hostageUnit'; [_hostageUnit] join (thisList # 0); [position thisTrigger] spawn P27_fnc_createReinforcements;", ""]] call CBA_fnc_createTrigger) params ["_taskTrigger", "_triggerParams"];

_taskTrigger setVariable ["hostageUnit", _hostageUnit];
_taskTrigger setVariable ["spawnTrigger", _taskId];


waitUntil {uiSleep 5; !alive _hostageUnit || (_hostageUnit distance (position respawn)) < 50 || _taskId call BIS_fnc_taskCompleted};

if (!alive _hostageUnit) then {
    [_taskId, "FAILED"] call BIS_fnc_taskSetState;
    uiSleep 2;
};

if ((_hostageUnit distance (position respawn)) < 50) then {
    [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
	uiSleep 2;
};

[_taskId] spawn P27_fnc_clearTask;