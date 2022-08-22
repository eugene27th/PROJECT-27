/*
    Author: eugene27
    Date: 13.08.2022
    
    Example:
        [] call P27_fnc_setPlayerEvents
*/


player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	hideBody player;

	private _quotations = ["A_hub_quotation","A_in_quotation","A_in2_quotation","A_m01_quotation","A_m02_quotation","A_m03_quotation","A_m04_quotation","A_m05_quotation","A_out_quotation","B_Hub01_quotation","B_in_quotation","B_m01_quotation","B_m02_1_quotation","B_m03_quotation","B_m05_quotation","B_m06_quotation","B_out2_quotation","C_EA_quotation","C_EB_quotation","C_in2_quotation","C_m01_quotation","C_m02_quotation","C_out1_quotation"];
	
	["A3\missions_f_epa\video\" + selectRandom _quotations + ".ogv"] spawn BIS_fnc_playVideo;
}];