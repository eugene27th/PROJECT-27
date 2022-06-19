if (!isServer) then {
	[] call compile preprocessFileLineNumbers "core\compile.sqf"; // complile (global)
};

if (!isNull player) then {
	execVM "core\main\client.sqf";
};