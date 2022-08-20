/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [_checkpointTrigger] call P27_fnc_createCheckpoint;
    
    Return:
		nothing
*/


params ["_checkpointTrigger"];

private _checkpointPosition = position _checkpointTrigger;
private _checkpointDirection = getDir _checkpointTrigger;

private _configEnemy = (configUnits # 0) # 1;


private _checkPointVehicle = (selectRandom (_configEnemy # 2)) createVehicle _checkpointPosition;
_checkPointVehicle setDir (_checkpointDirection + 90);

_vehicles pushBack _checkPointVehicle;







for "_i" from 0 to 1 do {
	private _static = (selectRandom enemy_turrets) createVehicle (_pos findEmptyPosition [(10 * _i), 150, "B_HMG_01_high_F"]);
	_static setDir _direction + (_i * 180);
	_vehicles pushBack _static;
	private _staticCrew = [_static,enemy_infantry] call prj_fnc_createCrew;
	_crewUnits = _crewUnits + _staticCrew;
};



private _enemyInf = [];

_enemyInf = _enemyInf + ([_pos] call prj_fnc_createCrowd);
_enemyInf = _enemyInf + ([_pos,_radius,[1,1]] call prj_fnc_createPatrol);

{
	_x addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];

		if (isPlayer _unit) then {
			_vehicle removeEventHandler ["GetIn",_thisEventHandler];
			_vehicle setVariable ["cannotDeleted",true,true];
		};
	}];
} forEach _vehicles;





[[_checkPointVehicle], _crewUnits, _enemyInf]