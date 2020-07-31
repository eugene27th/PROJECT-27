/*
	written by eugene27.
	compile server and client functions
*/

//COMPILE SERVER ONLY
if (isServer) then {
	call compile preprocessFileLineNumbers "core\unit_spawn_system\configuration.sqf";
	// only server fnc
	call compile preprocessFileLineNumbers "core\fnc\s_functions.sqf";
};

//COMPILE SERVER AND CLIENT
call compile preprocessFileLineNumbers "core\settings.sqf";
call compile preprocessFileLineNumbers "core\fnc\g_functions.sqf";
call compile preprocessFileLineNumbers "core\fnc\GUI\g_functions.sqf";