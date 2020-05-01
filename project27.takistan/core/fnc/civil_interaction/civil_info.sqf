/* 
	written by eugene27.  
*/

params [
	"_position","_civilian"
];

if !(player getVariable ["interpreter",false]) exitWith {
	[localize "STR_PRJ_CIVIL", localize (selectRandom ["STR_PRJ_CIVIL_DOES_NOT_UNDERSTAND_1","STR_PRJ_CIVIL_DOES_NOT_UNDERSTAND_2","STR_PRJ_CIVIL_DOES_NOT_UNDERSTAND_3"])] spawn BIS_fnc_showSubtitle;
};

if (_civilian getVariable ["interviewed",false]) exitWith {
	[localize "STR_PRJ_CIVIL", localize (selectRandom ["STR_PRJ_CIVIL_INFO_INTERVIEWED_1","STR_PRJ_CIVIL_INFO_INTERVIEWED_2","STR_PRJ_CIVIL_INFO_INTERVIEWED_3"])] spawn BIS_fnc_showSubtitle;
};

_array = _position nearEntities [enemy_infantry, 1500];
if (!(_array isEqualTo []) && (random 1 < 0.5)) then {
	_man = _array select 0;
	_distance = (_position distance _man) + (round (random 150)) - (round (random 150));
	_dir = _position getDir _man;

	switch (true) do {
		case (_dir > 345 || _dir <= 15) : {card = localize "STR_PRJ_SIDE_WORLD_N"};
		case (_dir > 15 && _dir <= 75) : {card = localize "STR_PRJ_SIDE_WORLD_NE"};
		case (_dir > 75 && _dir <= 105) : {card = localize "STR_PRJ_SIDE_WORLD_E"};
		case (_dir > 105 && _dir <= 165) : {card = localize "STR_PRJ_SIDE_WORLD_SE"};
		case (_dir > 165 && _dir <= 195) : {card = localize "STR_PRJ_SIDE_WORLD_S"};
		case (_dir > 195 && _dir <= 255) : {card = localize "STR_PRJ_SIDE_WORLD_SW"};
		case (_dir > 255 && _dir <= 285) : {card = localize "STR_PRJ_SIDE_WORLD_W"};
		case (_dir > 285 && _dir <= 345) : {card = localize "STR_PRJ_SIDE_WORLD_NW"};
	};

	[localize "STR_PRJ_CIVIL", format [localize (selectRandom ["STR_PRJ_CIVIL_INFO_1_INF","STR_PRJ_CIVIL_INFO_2_INF","STR_PRJ_CIVIL_INFO_3_INF"]), card, round _distance]] spawn BIS_fnc_showSubtitle;
}
else
{
	[localize "STR_PRJ_CIVIL", localize (selectRandom ["STR_PRJ_CIVIL_INFO_NEGATIVE_1","STR_PRJ_CIVIL_INFO_NEGATIVE_2","STR_PRJ_CIVIL_INFO_NEGATIVE_3"])] spawn BIS_fnc_showSubtitle;
};

_civilian setVariable ["interviewed",true,true];