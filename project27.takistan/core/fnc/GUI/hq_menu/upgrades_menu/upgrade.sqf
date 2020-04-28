/* 
	written by eugene27.  
*/

params [
	"_type"
];

private ["_variable","_upgrade_name","_next_level","_upgrade_name","_display_ctrl","_text","_intel_score","_ctrl_intel","_text_intel","_ctrl","_text"];

switch (_type) do {
	case 1: {
		_variable = "arsenal_level";
		_next_level = (missionNamespace getVariable _variable) + 1;
		_upgrade_name = "арсенал";
		_display_ctrl = 1022;
		_text = "ARSENAL: <t size='1.2' color='#25E03F'>" + str _next_level + " LVL</t>";		
	};
	case 2: {
		_variable = "a_garage_level";
		_next_level = (missionNamespace getVariable _variable) + 1;
		_upgrade_name = "гараж воздушной техники";
		_display_ctrl = 1023;
		_text = "AIR GARAGE: <t size='1.2' color='#25E03F'>" + str _next_level + " LVL</t>";
	};
	case 3: {
		_variable = "g_garage_level";
		_next_level = (missionNamespace getVariable _variable) + 1;
		_upgrade_name = "гараж наземной техники";
		_display_ctrl = 1024;
		_text = "LAND GARAGE: <t size='1.2' color='#25E03F'>" + str _next_level + " LVL</t>";
	};
};

_intel_score = missionNamespace getVariable "intel_score";

if (_intel_score < (_next_level * 100)) then {
	hint "У Вашей команды не хватает Intel Score."
}
else
{
	[missionNamespace,["intel_score",(_intel_score - (_next_level * 100)),true]] remoteExec ["setVariable",2];
	[missionNamespace,[_variable,_next_level,true]] remoteExec ["setVariable",2];

	hint format ["Вы модернизировали " + _upgrade_name + " до %1 уровня.",_next_level];

	_ctrl_intel = (findDisplay 3006) displayCtrl 1025;
	_text_intel = "INTEL SCORE: <t size='1.2' color='#25E03F'>" + str (_intel_score - (_next_level * 100)) + "</t>";
	_ctrl_intel ctrlSetStructuredText parseText _text_intel;

	_ctrl = (findDisplay 3006) displayCtrl _display_ctrl;
	_ctrl ctrlSetStructuredText parseText _text;
};