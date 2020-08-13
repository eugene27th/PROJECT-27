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
		1 - [house groups, size of groups],
		2 - [patrol groups, size of groups],
		3 - [light vehicles, probability],
		4 - [heavy vehicles, probability],
		5 - [static vehicles, probability]
	ex: [[house grp, size of grp],[patrol grp, size of grp],[light veh, prob.],[heavy veh, prob.],[static veh, prob.]]

	civilian:
		1 - [house groups, size of groups],
		2 - [patrol groups, size of groups],
		3 - [vehicles, probability]
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
		cities_enemy = [[2,1],[2,2],[2,0.4],[1,0.4],[1,0.8]];
		villages_enemy = [[1,1],[2,1],[1,0.4],[1,0.3],[1,0.6]];
		local_enemy = [[1,1],[1,1],[0],[0],[1,0.6]];
		rock_enemy = [[0],[1,1],[0],[0],[0]];
		hills_enemy = [[0],[1,1],[0],[0],[1,1]];
		vegetation_enemy = [[0],[1,1],[0],[0],[1,0.5]];
		other_enemy = [[0],[1,1],[1,0.3],[1,0.3],[1,0.7]];
		//civilian
		cities_civilian = [[2,1],[5,0],[1,0.7]];
		villages_civilian = [[1,1],[5,0],[1,0.5]];
		local_civilian = [[0],[0],[0]];
		rock_civilian = [[0],[0],[0]];
		hills_civilian = [[0],[0],[0]];
		vegetation_civilian = [[0],[0],[0]];
		other_civilian = [[0],[0],[0]];
	};
};