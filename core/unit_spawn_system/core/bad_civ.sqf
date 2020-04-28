/*
	written by eugene27.
	1.3.0
*/

private ["_civ","_scan_end","_nearestunits"];

_civ = _this;
_scan_end = false;

while {alive _civ && !_scan_end} do {
    _nearestunits = nearestObjects [getPos _civ,["Man"],30];
    {
        if (side _x == west) then {
            if (((random 1) < 0.3) && alive _civ && [_civ] call ace_common_fnc_isAwake) then {
                [_civ] join (createGroup independent);
                _civ addItemToUniform "ACE_DeadManSwitch";
                _civ addItemToUniform "ACE_Cellphone";
                _civ addItemToUniform "DemoCharge_Remote_Mag";          
                if (random 1 < 0.5) then {
                    _civ addMagazine [selectRandom ["acex_intelitems_photo","acex_intelitems_document","acex_intelitems_notepad"], 1];
                };
                _civ removeAllEventHandlers "FiredNear";
                if ((animationState _civ) == "amovpercmstpssurwnondnon") then {
                    [_civ, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
                };
                _civ setUnitPos "UP";
                unAssignVehicle _civ;
                _civ action ["eject",vehicle _civ];
                _civ allowfleeing 0;
                _civ forceSpeed 15;				  
                (group _civ) setBehaviour "CARELESS";
                (group _civ) setSpeedMode "FULL";
                sleep 1;

                while {(_civ distance _x) > 10} do {
                    _civ domove position _x;
                    sleep 2;
                };

                if (alive _civ && [_civ] call ace_common_fnc_isAwake) then {
                    [_civ, ["allah",50,1]] remoteExec ["say3D"];
                    uiSleep 3;
                    if (alive _civ && [_civ] call ace_common_fnc_isAwake && !(_civ getVariable ["ace_captives_isHandcuffed", false])) then {
                        private _blast = ["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
                        createVehicle [selectRandom _blast,(getPosATL _civ),[],0,""];
                        createVehicle ["Crater",(getPosATL _civ),[],0,""];
                        _civ removeItem "DemoCharge_Remote_Mag";
                    };
                };
            }
            else
            {	
                if ((random 1) < 0.3 && alive _civ && [_civ] call ace_common_fnc_isAwake) then {
                    [_civ] join (createGroup independent);
                    if (random 1 < 0.5) then {
                        _civ addMagazine [selectRandom ["acex_intelitems_photo","acex_intelitems_document","acex_intelitems_notepad"], 1];
                    };
                    if (random 1 < 0.5) then {
                        _civ addItemToUniform "ACE_Cellphone";
                    };			
                    _civ removeAllEventHandlers "FiredNear";
                    if ((animationState _civ) == "amovpercmstpssurwnondnon") then {
                        [_civ, "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["switchMove", 0];
                    };
                    unAssignVehicle _civ;
                    _civ setUnitPos "UP";							
                    _civ action ["eject",vehicle _civ];
                    _civ allowfleeing 0;

                    while {(_civ distance _x) > 60} do {
                        _civ domove position _x;
                        sleep 5;
                    };

                    (group _civ) setBehaviour "CARELESS";
                    (group _civ) setSpeedMode "FULL";

                    _weaponchoice = selectRandom [
                        ["rhsusf_weap_m9","rhsusf_mag_15Rnd_9x19_JHP"],
                        ["rhs_weap_tt33","rhs_mag_762x25_8"],
                        ["rhsusf_weap_m1911a1","rhsusf_mag_7x45acp_MHP"],
                        ["rhs_weap_makarov_pm","rhs_mag_9x18_8_57N181S"],
                        ["rhs_weap_makarov_pm","rhs_mag_9x18_8_57N181S"],
                        ["rhs_weap_savz61_folded","rhsgref_20rnd_765x17_vz61"],
                        ["rhs_weap_type94_new","rhs_mag_6x8mm_mhp"]
                    ];

                    _civ addWeapon (_weaponchoice select 0);
                    _civ addHandgunItem (_weaponchoice select 1);
                    for "_i" from 1 to 4 do {_civ addMagazine (_weaponchoice select 1)};					
                    _civ dotarget _x;
                    _civ dofire _x;
                };
            };
            _scan_end = true;
        };
    } forEach _nearestunits;
    sleep 10;
};







