/*
    Author: eugene27
    Date: 21.08.2022
    
    Example:
        [_checkpointTrigger] call P27_fnc_createCrowdUnits;
    
    Return:
		nothing
*/


params ["_pos",["_relPos",false],["_radius",[4,15]],["_number_of",[4,8]]];
  
    private _units = [];

	if (_relPos) then {
		_pos = [_pos, 80, 150, 3, 0] call BIS_fnc_findSafePos;
	};

	private _ground_enemies_grp = createGroup [enemySide, true];

    for [{private _i = 0 }, { _i < (_number_of call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
        private _position = [_pos, _radius call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
        private _unit = _ground_enemies_grp createUnit [selectRandom enemy_infantry, _position, [], 0, "NONE"];
        doStop _unit;
        _unit setDir (round (random 360));

        _units pushBack _unit;
    };

    _units