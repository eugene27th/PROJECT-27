/*
	written by eugene27.
	1.3.0
*/

private _dialog_hq = createDialog "dialogHQmenu";

private _civ = player getVariable "civ_killings";
private _enemy = player getVariable "enemy_killings";
private _friend = player getVariable "friend_killings";

private _stats_text = localize "STR_PRJ_STATISTICS_KILLED" + ":<br/>" + localize "STR_PRJ_STATISTICS_ENEMIES" + ": " + str _enemy + "<br/>" + localize "STR_PRJ_STATISTICS_FRIENDLY" + ": " + str _friend + "<br/>" + localize "STR_PRJ_STATISTICS_CIVILIANS" + ": " + str _civ + "<br/>";

private _stat_p = (_enemy * 10) - (_friend * 50) - (_civ * 25);

private _ctrl_name = (findDisplay 3000) displayCtrl 1001;

private ["_picture"];

switch (true) do {
	case (_stat_p >= 250) : {
		_picture = "img\icons\icon_smile_good_g.paa";
		_ctrl_name ctrlSetTextColor [0.18, 0.48, 0.08, 1];
	};
	case (_stat_p >= 50) : {
		_picture = "img\icons\icon_smile_good_y.paa";
		_ctrl_name ctrlSetTextColor [0.25, 0.82, 0.07, 1];
	};
	case (_stat_p <= -300) : {
		_picture = "img\icons\icon_smile_wtf.paa";
		_ctrl_name ctrlSetTextColor [0.37, 0.13, 0.13, 1];
		};
	case (_stat_p <= -150) : {
		_picture = "img\icons\icon_smile_bad_r.paa";
		_ctrl_name ctrlSetTextColor [0.61, 0.16, 0.16, 1];
	};
	case (_stat_p <= -20) : {
		_picture = "img\icons\icon_smile_bad_y.paa";
		_ctrl_name ctrlSetTextColor [0.82, 0.45, 0.07, 1];
	};
	case (_stat_p < 50) : {
		_picture = "img\icons\icon_smile_n.paa";
		_ctrl_name ctrlSetTextColor [0.82, 0.76, 0.07, 1];
	};
};
ctrlSetText [1029, _picture];

private _ctrl = (findDisplay 3000) displayCtrl 1002;
_ctrl ctrlSetStructuredText parseText _stats_text;
_ctrl ctrlSetTextColor [0.8, 0.8, 0, 1];

ctrlSetText [1001, toUpper (name player)];