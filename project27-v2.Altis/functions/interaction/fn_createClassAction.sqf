/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [_name, _title, _img, _class, _statement, _condition, [_parents]] spawn/call P27_fnc_createClassAction;
    
    Return:
		nothing
*/


params ["_name", "_title", "_img", "_class", "_statement", "_condition", "_parents"];

private _action = [_name, _title, "\A3\ui_f\data\igui\cfg\simpleTasks\types\" + _img + ".paa", _statement, _condition] call ace_interact_menu_fnc_createAction;

private _actionPath = ["ACE_SelfActions"];

if (!isNil "_parents") then {
	_actionPath append _parents;
};

[_class, 0, _actionPath, _action] call ace_interact_menu_fnc_addActionToClass;