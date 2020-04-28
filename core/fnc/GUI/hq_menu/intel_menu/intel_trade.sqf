/*
	written by eugene27.
	1.3.0
*/

ctrlEnable [1019, true];
_ctrlloadb = (findDisplay 3004) displayCtrl 1019;
_ctrlloadb ctrlSetTextColor [0.8, 0.8, 0, 1];

_index = lbCurSel 1018;
_intels = lbData [1018, _index];
_intels = call (compile _intels);
_intel_score = lbValue [1018, _index];

ctrlSetText [1019, "EXCHANGE / " + str ((_intel_score * (_intels select 1)) * 10)];