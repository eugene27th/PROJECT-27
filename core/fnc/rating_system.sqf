/*
	written by eugene27.
	server onlyf
	1.3.0
*/

{
	[_x, [[], 1]] call ace_arsenal_fnc_attributeInit;
} forEach [arsenalboxonbluebase,arsenalboxonredbase];

null = [] spawn {
	while {true} do {
		sleep 10;
		{
			if (isNil {_x getVariable "oldSide"} || {(_x getVariable "oldSide") != side _x}) then {
				_x setVariable ["oldSide",side _x,true]
			};
		} forEach allUnits;
	};
};

addMissionEventHandler  ["Entitykilled", {
	params [
		"_victim","_killer"
	];
	if (isPlayer _killer || _victim != _killer) then {
		if (side _killer == west) then {
			switch (_victim getVariable "oldSide") do {
				case west: {
					_killer setVariable ["money",(_killer getVariable "money") - 50,true];
					_killer setVariable ["friend_killings",(_killer getVariable "friend_killings") + 1,true];
				};
				case east: {
					_killer setVariable ["money",(_killer getVariable "money") - 50,true];
					_killer setVariable ["friend_killings",(_killer getVariable "friend_killings") + 1,true];
				};
				case civilian: {
					_killer setVariable ["money",(_killer getVariable "money") - 5,true];
					_killer setVariable ["civ_killings",(_killer getVariable "civ_killings") + 1,true];
				};
				case independent: {
					_killer setVariable ["money",(_killer getVariable "money") + 10,true];
					_killer setVariable ["enemy_killings",(_killer getVariable "enemy_killings") + 1,true];
					if (random 1 < 0.5) then {
						_victim addMagazine [selectRandom ["acex_intelitems_photo","acex_intelitems_document","acex_intelitems_notepad"], 1];
					};
					if (random 1 < 0.5) then {
						_victim addItemToUniform "ACE_Cellphone";
					};
				};
			};	
		};
	};
}];