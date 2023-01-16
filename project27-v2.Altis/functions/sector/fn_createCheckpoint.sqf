/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [] call P27_fnc_createCheckpoint
*/


params ["_checkpointTrigger"];

private _triggerIsActive = _checkpointTrigger getVariable ["isActive", false];

if (_triggerIsActive) exitWith {};

_checkpointTrigger setVariable ["isActive", true];

private _checkpointPosition = position _checkpointTrigger;
private _checkpointDirection = getDir _checkpointTrigger;
private _configEnemy = (configUnits # 0) # 1;


private _spawnedVehicles = [];

private _checkPointVehicle = (selectRandom (_configEnemy # 1)) createVehicle _checkpointPosition;
_checkPointVehicle setDir (_checkpointDirection + 90);

_spawnedVehicles pushBack _checkPointVehicle;


for "_i" from 0 to 1 do {
	private _turretPosition = _checkpointPosition getPos [10, _checkpointDirection + (_i * 180)];

	private _turret = createVehicle [selectRandom (_configEnemy # 4), _turretPosition, [], 0, "CAN_COLLIDE"];
	_turret setDir (_checkpointDirection + (_i * 180));

	_spawnedVehicles pushBack _turret;

	private _vehicleCrew = [_turret] call P27_fnc_createCrew;
	{_x setVariable ["spawnTrigger", _checkpointTrigger]} forEach _vehicleCrew;
};


[_checkpointTrigger, 100] spawn P27_fnc_createPatrolUnits;
[_checkpointTrigger, 20, [1,2]] spawn P27_fnc_createCrowdUnits;


{
	_x setVariable ["spawnTrigger", _checkpointTrigger];
} forEach _spawnedVehicles;

[_spawnedVehicles] call P27_fnc_addSpawnTriggerEventToVehicles;


([
	_checkpointPosition,
	"AREA:", [50, 50, 0, false],
	"ACT:", ["WEST SEIZED", "PRESENT", false],
	"STATE:", ["this", "[thisTrigger] call P27_fnc_setCheckpointCaptureState", ""]
] call CBA_fnc_createTrigger) params ["_captureTrigger", "_captureTriggerOptions"];

_captureTrigger setVariable ["checkpointTrigger", _checkpointTrigger];
_checkpointTrigger setVariable ["captureTrigger", _captureTrigger];


[_checkpointTrigger, 120] spawn P27_fnc_clearSector;