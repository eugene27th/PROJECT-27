/*
    Author: eugene27
    Date: 19.08.2022
    
    Example:
        [] call P27_fnc_teleportToMhq
*/


if (isNil "mhqTerminal") exitWith {
	systemChat "MHQ is not exist";
};

if ((mhqTerminal animationPhase "lid_rot_1") == 0) exitWith {
	systemChat "MHQ is not deployed";
};

player setPos ((position mhqTerminal) findEmptyPosition [0, 15, "B_soldier_F"]);