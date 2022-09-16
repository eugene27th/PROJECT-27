/*
    Author: eugene27
    Date: 16.09.2022
    
    Example:
        [] call P27_fnc_changeEnvironment
*/


params [["_weather", "current"], ["_time", "current"]];


private _weatherConfig = [
	["clean", [0, 0, 0, [3,2]]],
	["cloudy", [0, 0.6, 0, [8,10]]],
	["rain", [0.3, 0.8, 0.1, [14,12]]],
	["rainstorm", [1, 1, 0.4, [20,20]]]
];

if (_weather != "current") then {
	{
		if (_weather != (_x # 0)) then {
			continue;
		};

		private _weatherSettins = _x # 1;

		0 setRain (_weatherSettins # 0);
		0 setOvercast (_weatherSettins # 1);
		0 setFog (_weatherSettins # 2);
		setWind (_weatherSettins # 3);
		forceWeatherChange;
	} forEach _weatherConfig;	
};

if !(_time isEqualTo "current") then {
	skipTime _time;
};