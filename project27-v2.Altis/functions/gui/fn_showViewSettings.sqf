/*
    Author: eugene27
    Date: 10.01.2023
    
    Example:
        [] call P27_fnc_showViewSettings
*/


createDialog "dialogViewSettings";

private _viewDistance = viewDistance;
private _objectViewDistance = getObjectViewDistance # 0;

((findDisplay 3003) displayCtrl 4000) sliderSetPosition _viewDistance;
((findDisplay 3003) displayCtrl 4002) sliderSetPosition _objectViewDistance;

((findDisplay 3003) displayCtrl 4001) ctrlSetText (str _viewDistance);
((findDisplay 3003) displayCtrl 4003) ctrlSetText (str _objectViewDistance);