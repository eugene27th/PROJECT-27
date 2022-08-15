/*
    Author: eugene27
    Date: 11.08.2022
    
    Example:
        [_sectorTrigger] spawn P27_fnc_createSector;
    
    Return:
		nothing
*/

params ["_sectorTrigger"];

private _triggerIsActive = _sectorTrigger getVariable ["isActive", false];
private _sectorIsCaptured = _sectorTrigger getVariable ["isCaptured", false];
private _spawnConfig = _sectorTrigger getVariable ["spawnConfig", []];


if (_triggerIsActive || _spawnConfig isEqualTo []) exitWith {};


private _triggerPosition = position _sectorTrigger;
private _triggerRadius = (triggerArea _sectorTrigger) # 0;
private _sectorRadius = _triggerRadius - (configSectors # 1);

private _spawnEnemyConfig = _spawnConfig # 0;
private _spawnCivConfig = _spawnConfig # 1;


_sectorTrigger setVariable ["isActive", true];


private _allSpawnedEntities = [[], []];

private _enemyConfig = configUnits # 0;

private _enemySide = _enemyConfig # 0;
private _enemyClasses = _enemyConfig # 1;
private _civClasses = configUnits # 1;

if (!_sectorIsCaptured) then {
	[_enemyClasses # 1, _spawnEnemyConfig # 0, _sectorTrigger, _sectorRadius, _enemySide] spawn P27_fnc_createHouseGroups;
	[_enemyClasses # 1, _spawnEnemyConfig # 1, _sectorTrigger, _sectorRadius, _enemySide] spawn P27_fnc_createPatrolGroups;
	[(_enemyClasses # 2) + (_enemyClasses # 3), _enemyClasses # 1, _spawnEnemyConfig # 2, _sectorTrigger, _sectorRadius, _enemySide] spawn P27_fnc_createVehicles;
	[_enemyClasses # 4, _enemyClasses # 1, _spawnEnemyConfig # 3, _sectorTrigger, _sectorRadius, _enemySide] spawn P27_fnc_createVehicles;
	[_enemyClasses # 5, _enemyClasses # 1, _spawnEnemyConfig # 4, _sectorTrigger, _sectorRadius, _enemySide] spawn P27_fnc_createTurrets;

	private _captureTrigger = [
		_triggerPosition,
		"AREA:", [_sectorRadius, _sectorRadius, 0, false],
		"ACT:", ["WEST SEIZED", "PRESENT", true],
		"STATE:", ["this", "[thisTrigger] call P27_fnc_setSectorState", ""]
	] call CBA_fnc_createTrigger;

	(_captureTrigger # 0) setVariable ["sectorTrigger", _sectorTrigger];
	_sectorTrigger setVariable ["captureTrigger", (_captureTrigger # 0)];
};

[_civClasses # 0, _spawnCivConfig # 0, _sectorTrigger, _sectorRadius, civilian] spawn P27_fnc_createHouseGroups;
[_civClasses # 0, _spawnCivConfig # 1, _sectorTrigger, _sectorRadius, civilian] spawn P27_fnc_createPatrolGroups;
[_civClasses # 1, _civClasses # 0, _spawnCivConfig # 2, _sectorTrigger, _sectorRadius, civilian] spawn P27_fnc_createVehicles;


[_sectorTrigger] spawn P27_fnc_clearSector;