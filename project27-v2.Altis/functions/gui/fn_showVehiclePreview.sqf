/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_showVehiclePreview
*/


private _lisBoxIndex = lbCurSel 1000;
private _className = lbData [1000, _lisBoxIndex];

private _preview = getText(configfile >> "CfgVehicles" >> _className >> "editorPreview");
ctrlSetText [1001, _preview];