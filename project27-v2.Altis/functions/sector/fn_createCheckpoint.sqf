/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [] call P27_fnc_createCheckpoint
*/


params ["_sectorTrigger"];

private _triggerIsActive = _sectorTrigger getVariable ["isActive", false];

if (_triggerIsActive) exitWith {};


_sectorTrigger setVariable ["isActive", true];

if (debugMode) then {
	systemChat format["Sector (%1) is activated.", _sectorTrigger];
};

uiSleep 15;

if ((count (allPlayers inAreaArray _sectorTrigger)) < 1) exitWith {
	if (debugMode) then {
		systemChat format["Nobody in area. Sector (%1) is deactivated.", _sectorTrigger];
	};
	
	_sectorTrigger setVariable ["isActive", false];
};

if (debugMode) then {
	systemChat format["Starting spawn in sector (%1).", _sectorTrigger];
};


private _checkpointPosition = position _sectorTrigger;
private _checkpointDirection = getDir _sectorTrigger;
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

	{_x setVariable ["spawnTrigger", _sectorTrigger]} forEach ([_turret] call P27_fnc_createCrew);
};


[_sectorTrigger, 100] spawn P27_fnc_createPatrolUnits;
[_sectorTrigger, 20, [1,2]] spawn P27_fnc_createCrowdUnits;


{
	_x setVariable ["spawnTrigger", _sectorTrigger];
} forEach _spawnedVehicles;

[_spawnedVehicles] call P27_fnc_addSpawnTriggerEventToVehicles;


([
	_checkpointPosition,
	"AREA:", [50, 50, 0, false],
	"ACT:", ["WEST SEIZED", "PRESENT", false],
	"STATE:", ["this", "[thisTrigger] call P27_fnc_setCheckpointCaptureState", ""]
] call CBA_fnc_createTrigger) params ["_captureTrigger", "_captureTriggerOptions"];

_captureTrigger setVariable ["checkpointTrigger", _sectorTrigger];
_sectorTrigger setVariable ["captureTrigger", _captureTrigger];


[_sectorTrigger, 60] spawn P27_fnc_clearSector;