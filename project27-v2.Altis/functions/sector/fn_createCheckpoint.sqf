/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [_checkpointTrigger] call P27_fnc_createCheckpoint;
    
    Return:
		nothing
*/


params ["_checkpointTrigger"];

private _triggerIsActive = _checkpointTrigger getVariable ["isActive", false];

if (_triggerIsActive) exitWith {};

_checkpointTrigger setVariable ["isActive", true];

private _checkpointPosition = position _checkpointTrigger;
private _checkpointDirection = getDir _checkpointTrigger;

private _configEnemy = (configUnits # 0) # 1;

private _spawnedVehicles = [];
private _spawnedUnits = [];

private _checkPointVehicle = (selectRandom (_configEnemy # 2)) createVehicle _checkpointPosition;
_checkPointVehicle setDir (_checkpointDirection + 90);

_spawnedVehicles pushBack _checkPointVehicle;


for "_i" from 0 to 1 do {
	private _turret = (selectRandom (_configEnemy # 5)) createVehicle (_checkpointPosition findEmptyPosition [10, 50, "B_HMG_01_high_F"]);
	_turret setDir (_checkpointDirection + (_i * 180));
	_spawnedVehicles pushBack _turret;

	private _turretCrew = [_turret, (_configEnemy # 1)] call prj_fnc_createCrew;
	_spawnedUnits append _turretCrew;
};





{
	_x setVariable ["spawnTrigger", _checkpointTrigger];

	_x addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];

		if (isPlayer _unit) then {
			_vehicle removeEventHandler ["GetIn", _thisEventHandler];
			_vehicle setVariable ["spawnTrigger", nil, true];
		};
	}];
} forEach _spawnedVehicles;


([
	_checkpointPosition,
	"AREA:", [50, 50, 0, false],
	"ACT:", ["WEST SEIZED", "PRESENT", true],
	"STATE:", ["this", "[thisTrigger] call P27_fnc_setCheckpointCaptureState", ""]
] call CBA_fnc_createTrigger) params ["_captureTrigger", "_captureTriggerOptions"];

_captureTrigger setVariable ["checkpointTrigger", _checkpointTrigger];
_checkpointTrigger setVariable ["captureTrigger", _captureTrigger];


[_checkpointTrigger] spawn P27_fnc_clearSector;