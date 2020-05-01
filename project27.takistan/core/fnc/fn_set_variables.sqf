/*
	written by eugene27.
	1.3.0
*/

params [
	"_data"
];

for [{private _i = 0 }, { _i < (count _data) }, { _i = _i + 1 }] do {
	(call (compile ((_data select _i) select 0))) setVariable ((_data select _i) select 1);
};