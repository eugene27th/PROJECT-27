/*
    Author: eugene27
    Date: 07.11.2022
    
    Example:
        [] call P27_fnc_getConfigUnitClassesByType
*/


params ["_unitType"];


private _unitClasses = missionNamespace getVariable ("specUnitClasses#" + _unitType);

if (!isNil "_unitClasses") exitWith {
    _unitClasses
};

private _typeWeapons = switch (_unitType) do {
    case "AA": {
        ["launch_B_Titan_F","launch_I_Titan_F","launch_O_Titan_F","launch_Titan_F","launch_B_Titan_tna_F","launch_B_Titan_short_tna_F","launch_O_Titan_ghex_F","launch_I_Titan_eaf_F","launch_B_Titan_olive_F","rhs_weap_igla","rhs_weap_fim92","CUP_launch_FIM92Stinger_Loaded","CUP_launch_FIM92Stinger","CUP_launch_9K32Strela_Loaded","CUP_launch_9K32Strela","CUP_launch_Igla_Loaded","CUP_launch_Igla","uns_sa7","uns_sa7b"]
    };
    case "AT": {
        ["launch_B_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_short_ghex_F","launch_Vorona_base_F","launch_O_Vorona_brown_F","launch_O_Vorona_green_F","launch_O_Titan_short_F","launch_Titan_short_F","rhs_weap_fgm148","CUP_launch_Javelin","CUP_launch_NLAW_Loaded","CUP_BAF_NLAW_Launcher","CUP_launch_NLAW","launch_NLAW_F","launch_RPG32_F","launch_RPG32_ghex_F","launch_RPG7_F","launch_MRAWS_olive_F","launch_MRAWS_olive_rail_F","launch_MRAWS_green_F","launch_MRAWS_green_rail_F","launch_MRAWS_sand_F","launch_MRAWS_sand_rail_F","launch_RPG32_green_F","launch_RPG32_camo_F","rhs_weap_rpg26","rhs_weap_rpg18","rhs_weap_rshg2","rhs_weap_rpg7","rhs_weap_rpg7_pgo","rhs_weap_rpg7_1pn93","rhs_weap_smaw","rhs_weap_smaw_green","rhs_weap_maaws","rhs_weap_M136","rhs_weap_M136_hedp","rhs_weap_M136_hp","rhs_weap_m72a7","CUP_launch_M136_Loaded","CUP_launch_M136","rhs_weap_smaw_optic","rhs_weap_smaw_gr_optic","rhs_weap_maaws_optic","ACE_launch_NLAW_ready_F","rhs_weap_rpg75","rhs_weap_panzerfaust60","rhs_weap_m80","CUP_launch_MAAWS","CUP_launch_M47","CUP_M47Launcher_EP1","ace_dragon_super","CUP_launch_MAAWS_Scope","CUP_launch_M72A6_Loaded","CUP_launch_M72A6_Special_Loaded","CUP_launch_M72A6","CUP_launch_M72A6_Special","CUP_launch_Metis","CUP_launch_PzF3_Loaded","CUP_launch_PzF3","CUP_launch_BF3_Loaded","CUP_launch_BF3","CUP_launch_HCPF3_Loaded","CUP_launch_HCPF3","CUP_launch_RPG18_Loaded","CUP_launch_RPG18","CUP_launch_RPG26_Loaded","CUP_launch_RPG26","CUP_launch_RShG2_Loaded","CUP_launch_RShG2","CUP_launch_RPG7V","CUP_launch_RPG7V_PGO7V","CUP_launch_RPG7V_PGO7V2","CUP_launch_RPG7V_PGO7V3","CUP_launch_RPG7V_NSPU","CUP_launch_Mk153Mod0","CUP_launch_Mk153Mod0_blk","CUP_launch_Mk153Mod0_SMAWOptics","CUP_launch_Mk153Mod0_blk_SMAWOptics","CUP_RPG7V","CUP_RPG18","uns_rpg2","uns_rpg7","uns_B40"]
    };
};

private _unitClasses = [];

if (isNil "_typeWeapons") exitWith {
    _unitClasses
};

{
    private _unitWeapons = getArray (configfile >> "CfgVehicles" >> _x >> "weapons");

    for [{private _i = 0 }, { _i < (count _unitWeapons) }, { _i = _i + 1 }] do {
        if ((_unitWeapons # _i) in _typeWeapons) exitWith {
            _unitClasses pushBack _x;
        };
    };
} forEach ((configUnits # 0) # 1) # 0;

missionNamespace setVariable ["specUnitClasses#" + _unitType, _unitClasses];

_unitClasses