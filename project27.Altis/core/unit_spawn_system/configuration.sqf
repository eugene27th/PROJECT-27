/* 
	written by eugene27.
	server only

	size of groups:
	0 : 1 unit
	1 : 2-4 units
	2 : 4-8 units
	3 : 8-12 units

	probability:
	0 - 1;

	example:
	[0] - nobody
	[1,0.5] - 1 vehicle, 50/50 chance

	enemy:
		0 - [house groups, size of groups],
		1 - [patrol groups, size of groups],
		2 - [light vehicles, probability],
		3 - [heavy vehicles, probability],
		4 - [static vehicles, probability]
	ex: [[house grp, size of grp],[patrol grp, size of grp],[light veh, prob.],[heavy veh, prob.],[static veh, prob.]]

	civilian:
		0 - [house groups, size of groups],
		1 - [patrol groups, size of groups],
		2 - [vehicles, probability]
	ex: [[house grp, size of grp],[patrol grp, size of grp],[veh, prob.]]

	example adding your preset (takistan):
	switch (worldName) do {
		case "takistan": { // your preset on map "takistan". here is used worldname
			cities_enemy = [[3,1],[4,1],[2,0.5],[1,0.5],[1,1]];
			villages_enemy = [[3,1],[3,1],[2,0.5],[1,0.5],[1,1]];
			local_enemy = [[2,1],[2,1],[1,0.5],[1,0.5],[1,1]];
			rock_enemy = [[1,1],[2,1],[0],[1,0.2],[1,1]];
			hills_enemy = [[1,1],[2,1],[0],[1,0.2],[1,1]];
			vegetation_enemy = [[1,1],[2,1],[1,0.5],[1,0.5],[1,1]];
			other_enemy = [[2,1],[3,1],[1,0.5],[1,0.5],[1,1]];
			//civilian
			cities_civilian = [[3,1],[5,0],[2,0.5]];
			villages_civilian = [[2,1],[5,0],[2,0.4]];
			local_civilian = [[0],[2,0],[1,0.4]];
			rock_civilian = [[0],[0],[0]];
			hills_civilian = [[0],[0],[0]];
			vegetation_civilian = [[0],[0],[0]];
			other_civilian = [[0],[2,0],[1,0.2]];
		};
	};
*/

switch (worldName) do {
	default {
		//enemy
		cities_enemy = [[4,2],[4,2],[2,0.4],[1,0.5],[1,0.4]];
		villages_enemy = [[4,2],[3,2],[2,0.4],[1,0.4],[1,0.3]];
		local_enemy = [[0],[3,2],[1,0.6],[1,0.4],[1,0.4]];
		rock_enemy = [[0],[1,1],[0],[0],[0]];
		hills_enemy = [[0],[1,1],[0],[0],[1,1]];
		vegetation_enemy = [[0],[1,1],[0],[0],[0]];
		other_enemy = [[0],[1,1],[1,0.5],[1,0.2],[1,0.5]];
		//civilian
		cities_civilian = [[0],[3,0],[1,0.4]];
		villages_civilian = [[0],[3,0],[1,0.2]];
		local_civilian = [[0],[0],[0]];
		rock_civilian = [[0],[0],[0]];
		hills_civilian = [[0],[0],[0]];
		vegetation_civilian = [[0],[0],[0]];
		other_civilian = [[0],[0],[0]];
	};
};

private _enemy_coef = "enemycoef" call BIS_fnc_getParamValue;
if (_enemy_coef == 1) exitWith {};

private _variableNumbers = [0,1];

{
	for [{private _i = 0 }, { _i < (count _x) }, { _i = _i + 1 }] do {
		if (_i in _variableNumbers) then {
			private _subArray = (_x # _i);
			if ((count _subArray) > 1) then {
				private _number = ((_subArray # 0) * _enemy_coef);
				_subArray set [0,_number];
				_x set [_i,_subArray];
			};
		};
	};
} forEach [cities_enemy,villages_enemy,local_enemy,rock_enemy,hills_enemy,vegetation_enemy,other_enemy];