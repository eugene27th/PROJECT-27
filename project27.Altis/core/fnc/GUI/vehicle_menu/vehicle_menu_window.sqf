/*
	written by eugene27.
	1.3.0
*/

params [
	"_base","_land"
];

private ["_ctrltp"];

createDialog "dialogVehicleService";
ctrlEnable [1015, false];

_ctrltp = (findDisplay 3003) displayCtrl 1016;

if (_land) then {
    if (_base) then {
        buttonSetAction [1016, 
            "(vehicle player) setposATL (position tp_veh_red findEmptyPosition [0,15,'B_Truck_01_Repair_F']);
            (vehicle player) setDir (getDir tp_veh_red);
            closeDialog 2"
        ];
        _ctrltp ctrlSetTextColor [0.6, 0.3, 0.3, 1];
        ctrlSetText [1016, "teleport to red base"];
    }
    else
    {
        buttonSetAction [1016, 
            "(vehicle player) setposATL (position tp_veh_blue findEmptyPosition [0,15,'B_Truck_01_Repair_F']);
            (vehicle player) setDir (getDir tp_veh_blue);
            closeDialog 2"
        ];
        _ctrltp ctrlSetTextColor [0.3, 0.3, 0.6, 1];
        ctrlSetText [1016, "teleport to blue base"];
    };
}
else
{
    ctrlEnable [1016, false];
};

showitems = {
    params [
        "_actionnamearray","_arrayitems"
    ];

    private ["_displayname"];

    for [{private _i = 0 }, { _i < (count _actionnamearray) }, { _i = _i + 1 }] do {
		_displayname = _actionnamearray select _i;
		lbAdd [1014, _displayname];
        lbSetTooltip [1014, _i, _displayname];
        lbSetData [1014, _i, str (_arrayitems select _i)];
	};
};

[
    [
        "Load medicine",
        "Load explosives",
        "Load food",
        "Load misc",
        "Load tubes (m136)",
        "30Rnd 762x39mm polymer 89",
        "30Rnd 545x39 7N10",
        "30Rnd 545x39 7N22",
        "30Rnd 556x45 M855A1 Stanag",
        "30Rnd 556x45 M855A1 PMAG"
    ],
    [
        [
            ["ACE_morphine",3],
            ["ACE_quikclot",5],
            ["ACE_elasticBandage",5],
            ["ACE_fieldDressing",5],
            ["ACE_packingBandage",5],
            ["ACE_EarPlugs",1],
            ["ACE_personalAidKit",3],
            ["ACE_bloodIV",3],
            ["ACE_splint",2]
        ],
        [
            ["DemoCharge_Remote_Mag",4],
            ["SatchelCharge_Remote_Mag",2],
            ["MineDetector",2],
            ["ACE_DefusalKit",2],
            ["ACE_M26_Clacker",2]
        ],
        [
            ["ACE_WaterBottle",2],
            ["ACE_Humanitarian_Ration",2]
        ],
        [
            ["ACE_CableTie",10],
            ["B_AssaultPack_cbr",1],
            ["ToolKit",1]
        ],
        [
            ["rhs_weap_M136_hp",2],
            ["rhs_weap_M136_hedp",2],
            ["rhs_weap_M136",2]
        ],
        [
            ["rhs_30Rnd_762x39mm_polymer_89",10]
        ],
        [
            ["rhs_30Rnd_545x39_7N10_AK",10]
        ],
        [
            ["rhs_30Rnd_545x39_7N22_AK",10]
        ],
        [
            ["rhs_mag_30Rnd_556x45_M855A1_Stanag",10]
        ],
        [
            ["rhs_mag_30Rnd_556x45_M855A1_PMAG",10]
        ]
    ]
] call showitems;