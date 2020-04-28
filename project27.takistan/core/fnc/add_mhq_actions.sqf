/*
	written by eugene27.
	1.3.0
*/

private _actiondeploy = [
	"a_hq_terminal_deploy",
	"Deploy MHQ",
	"\A3\Ui_f\data\Map\Markers\NATO\b_hq.paa",
	{
		([mhqterminal,3] call BIS_fnc_dataTerminalAnimate);
		([mhqterminal, -1] call ace_cargo_fnc_setSize);
		([mhqterminal, false, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable)
	},
	{true}
] call ace_interact_menu_fnc_createAction;

[mhqterminal, 0, ["ACE_MainActions"], _actiondeploy] call ace_interact_menu_fnc_addActionToObject;

private _actionundeploy = [
	"a_hq_terminal_undeploy",
	"Undeploy MHQ",
	"\A3\Ui_f\data\Map\Markers\NATO\b_hq.paa",
	{
		([mhqterminal,0] call BIS_fnc_dataTerminalAnimate);
		([mhqterminal, 3] call ace_cargo_fnc_setSize);
		([mhqterminal, true, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable)
	},
	{true}
] call ace_interact_menu_fnc_createAction;

[mhqterminal, 0, ["ACE_MainActions"], _actionundeploy] call ace_interact_menu_fnc_addActionToObject;