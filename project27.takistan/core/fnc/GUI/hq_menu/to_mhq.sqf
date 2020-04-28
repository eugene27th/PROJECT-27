/*
	written by eugene27.
	1.3.0
*/

if (isNil "mhqterminal") exitWith {hint "MHQ is not exist"};

if ((mhqterminal animationPhase "lid_rot_1") != 0) then {
	player setposATL ((getpos mhqterminal) findEmptyPosition [ 0 , 15 , "B_soldier_F" ]);
	closeDialog 2;
}
else
{
	hint "MHQ is not deployed";
};