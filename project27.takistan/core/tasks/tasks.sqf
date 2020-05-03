/* 
	written by eugene27.
	server only
    1.3.0.1
*/

prj_side_alarm_button = {
	params [
        "_taskID","_reward"
    ];

    private ["_taskID","_roadpos","_pos","_direction","_unit_pos","_idap_vehicle","_enemy_vehicle_pos","_enemy_vehicle","_enemy_vehicle_crew","_idap_units","_enemies","_trg"];

    _taskID = "SIDE_" + str _taskID;

    _roadpos = [1] call prj_fnc_select_road_position;
    _pos = _roadpos select 0;
    _direction = _roadpos select 1;

    _unit_pos = [_pos, 5, 10, 1, 0] call BIS_fnc_findSafePos;

    [west, [_taskID], ["STR_SIDE_ALARM_BUTTON_DESCRIPTION", "STR_SIDE_ALARM_BUTTON_TITLE", ""], _pos, "CREATED", 0, true, "unknown"] call BIS_fnc_taskCreate;

    [_taskID,_pos,"ColorCIV",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;

    _idap_vehicle = selectRandom idap_vehicles createVehicle _pos;
    _idap_vehicle setDir _direction;

    _enemy_vehicle_pos = [_pos, 10, 100, 5, 0] call BIS_fnc_findSafePos;
    _enemy_vehicle = selectRandom (enemy_vehicles_light + enemy_vehicles_heavy) createVehicle _enemy_vehicle_pos;
    _enemy_vehicle_crew = [_enemy_vehicle,enemy_infantry,true] call prj_fnc_create_crew;

    _idap_units = [];
    _enemies = [];

    for "_i" from 1 to 2 do {
        private _unit = (createGroup civilian) createUnit [selectRandom idap_units, _unit_pos, [], 0, "NONE"];
        _unit setBehaviour "CARELESS";
        [_unit, "Acts_CivilHiding_2"] remoteExec ["switchMove", 0];
        _idap_units pushBack _unit;
    };

    for [{private _i = 0 }, { _i < ([10,15] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
        private _position = [_pos, [4,15] call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
        private _unit = (createGroup independent) createUnit [selectRandom enemy_infantry, _position, [], 0, "NONE"];
        _unit lookAt _idap_vehicle;
        _enemies pushBack _unit;
    };

    _trg = createTrigger ["EmptyDetector", _pos, true];
    _trg setTriggerArea [50, 50, 0, false, 20];
    _trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
    _trg setTriggerStatements ["this", "",""];

    waitUntil {sleep 5;{!alive _x} forEach _idap_units || triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

    if ({!alive _x} forEach _idap_units) then {
        [_taskID,"FAILED"] call BIS_fnc_taskSetState;
        sleep 2;
    };

    if (triggerActivated _trg) then {
        [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
        [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
        {[_x, ""] remoteExec ["switchMove", 0]} forEach _idap_units;
        (_idap_units select 0) assignAsDriver _idap_vehicle; 
        [(_idap_units select 0)] orderGetIn true; 
        [(_idap_units select 0)] allowGetIn true;
        (_idap_units select 1) assignAsCargo _idap_vehicle;
        [(_idap_units select 1)] orderGetIn true; 
        [(_idap_units select 1)] allowGetIn true;
        sleep 2;
    };

    [_taskID] call BIS_fnc_deleteTask;
    deleteMarker _taskID;

    uiSleep 30;

    {deleteVehicle _x} forEach [_idap_vehicle,_enemy_vehicle,_trg] + _enemy_vehicle_crew + _idap_units + _enemies;
};

prj_side_ammo_cache = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_pos","_ammo_cache","_marker"];

	_taskID = "SIDE_" + str _taskID;

	_pos = [4] call prj_fnc_select_position;

	[_taskID,_pos,"ColorOrange",0.7,[[300,300],"ELLIPSE"]] call prj_fnc_create_marker;

	_ammo_cache = box_ammo_cache createVehicle ([_pos, 150, 300, 3, 0] call BIS_fnc_findSafePos);
	clearItemCargoGlobal _ammo_cache;
	clearMagazineCargoGlobal _ammo_cache;
	clearWeaponCargoGlobal _ammo_cache;
	clearBackpackCargoGlobal _ammo_cache;
	_ammo_cache setVariable ["ace_cookoff_enable", false, true];

	if (prj_debug) then {
		_marker = createMarker ["cache_" + _taskID, position _ammo_cache];
		_marker setMarkerType "mil_dot";
		_marker setMarkerAlpha 1;
		_marker setMarkerColor "ColorBLACK";
	};

	[west, [_taskID], ["STR_SIDE_AMMO_CACHE_DESCRIPTION", "STR_SIDE_AMMO_CACHE_TITLE", ""], _pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

	waitUntil {sleep 5;!alive _ammo_cache || _taskID call BIS_fnc_taskCompleted};

	if (!alive _ammo_cache) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
		sleep 2;
	};

	[_taskID] call BIS_fnc_deleteTask;
	deleteVehicle _ammo_cache;
	deleteMarker _taskID;
};

prj_side_capture_leader = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_center_pos","_pos","_leader","_enemy","_picture"];

	_taskID = "SIDE_" + str _taskID;

	_center_pos = [1,false] call prj_fnc_select_position;

	_pos = [_center_pos, 200] call prj_fnc_select_house_position;

	_leader = (createGroup independent) createUnit [selectRandom enemy_leaders, _pos, [], 0, "NONE"];
	_enemy = (createGroup independent) createUnit [selectRandom enemy_infantry, position _leader, [], 0, "NONE"];
	{_x setBehaviour "CARELESS"} forEach [_leader,_enemy];

	[_taskID + "_red_base",position Checkpoint1,"ColorWEST",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;
	[_taskID + "_blue_base",position Checkpoint2,"ColorWEST",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;
	[_taskID + "_center",_center_pos,"ColorEAST",0.7,[[200,200],"ELLIPSE"]] call prj_fnc_create_marker;

	_picture = getText(configfile >> "CfgVehicles" >> typeOf _leader >> "editorPreview");

	[west, [_taskID], [format [localize "STR_SIDE_CAPTURE_LEADER_DESCRIPTION",_picture], "STR_SIDE_CAPTURE_LEADER_TITLE", ""], _center_pos, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;

	waitUntil {sleep 5; !alive _leader || _leader distance position Checkpoint1 < 50 || _leader distance position Checkpoint2 < 50 || _taskID call BIS_fnc_taskCompleted};

	if (!alive _leader) then {
		[_taskID,"FAILED"] call BIS_fnc_taskSetState;
		sleep 2;
	};

	if (_leader distance position Checkpoint1 < 50 || _leader distance position Checkpoint2 < 50) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
		sleep 2;
	};

	[_leader, false] call ACE_captives_fnc_setHandcuffed;
	_leader action ["GetOut",vehicle _leader];
	[_taskID] call BIS_fnc_deleteTask;
	{deleteVehicle _x} forEach [_leader,_enemy];
	{deleteMarker _x} forEach [(_taskID + "_red_base"),(_taskID + "_blue_base"),(_taskID + "_center")];
};

prj_side_capture_zone = {
    params [
        "_taskID","_reward"
    ];

    private ["_taskID","_pos","_trg"];

    _taskID = "SIDE_" + str _taskID;

    _pos = [1,false] call prj_fnc_select_position;

    [_taskID,_pos,"ColorEAST",0.7,[[220,220],"ELLIPSE"]] call prj_fnc_create_marker;

    [west, [_taskID], ["STR_SIDE_CAPTURE_ZONE_DESCRIPTION", "STR_SIDE_CAPTURE_ZONE_TITLE", ""], _pos, "CREATED", 0, true, "attack"] call BIS_fnc_taskCreate;

    _trg = createTrigger ["EmptyDetector", _pos, true];
    _trg setTriggerArea [220, 220, 0, false, 20];
    _trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
    _trg setTriggerStatements ["this", "",""];

    waitUntil {sleep 5;triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

    if (triggerActivated _trg) then {
        [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
        [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
        uiSleep 2;
    };

    [_taskID] call BIS_fnc_deleteTask;
    deleteVehicle _trg;
    deleteMarker _taskID;
};

prj_side_checkpoint = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_roadpos","_pos","_direction","_trg","_vehicle","_composition","_crew_units","_crew_group","_vehicles"];

	_taskID = "SIDE_" + str _taskID;

	_roadpos = [4] call prj_fnc_select_road_position;
	_pos = _roadpos select 0;
	_direction = _roadpos select 1;

	[_taskID,_pos,"ColorEAST",0.7,[[30,30],"ELLIPSE"]] call prj_fnc_create_marker;

	_trg = createTrigger ["EmptyDetector", _pos, true];
	_trg setTriggerArea [30, 30, 0, false, 20];
	_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
	_trg setTriggerStatements ["this", "", ""];

	_vehicles = [];

	_vehicle = selectRandom (enemy_vehicles_light + enemy_vehicles_heavy) createVehicle _pos;
	_vehicle setDir _direction + 90;
	_vehicle lock true;
	_crew_units = [_vehicle,enemy_infantry] call prj_fnc_create_crew;
	_vehicles pushBack _vehicle;

	for "_i" from 1 to 2 do {
		private _static = (selectRandom enemy_turrets) createVehicle (_pos findEmptyPosition [(10 * _i), 150, "B_HMG_01_high_F"]);
		_static lock true;
		_vehicles pushBack _static;
		private _crew = [_static,enemy_infantry] call prj_fnc_create_crew;
		_crew_units = _crew_units + _crew;
	};

	_composition = [
		["Land_BagFence_Long_F",[-0.0192871,-2.23193,-0.000999928],0,1,0,[],"","",true,false], 
		["Land_BagFence_Long_F",[0.106201,2.72778,-0.000999928],0,1,0,[],"","",true,false], 
		["Land_WoodenWindBreak_01_F",[0.0856934,-3.78625,-0.00102663],180,1,0,[],"","",true,false], 
		["Land_WoodenWindBreak_01_F",[0.0314941,4.18152,-0.00102663],0,1,0,[],"","",true,false]
	];
	[_pos, _direction, _composition, 0] call BIS_fnc_objectsMapper;

	[west, [_taskID], ["STR_SIDE_CHECKPOINT_DESCRIPTION", "STR_SIDE_CHECKPOINT_TITLE", ""], _pos, "CREATED", 0, true, "target"] call BIS_fnc_taskCreate;

	waitUntil {sleep 5;triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

	if (triggerActivated _trg) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
		uiSleep 2;
	};

	[_taskID] call BIS_fnc_deleteTask;
	deleteMarker _taskID;

	uiSleep 30;

	{deleteVehicle _x} forEach _vehicles + _crew_units;
};

prj_side_convoy = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_roadpos","_pos","_direction","_finish_pos","_vehicles","_crews"];

	_taskID = "SIDE_" + str _taskID;

	_roadpos = [1] call prj_fnc_select_road_position;
	_pos = _roadpos select 0;
	_direction = _roadpos select 1;

	_finish_pos = [_pos, 5000, round (random 359)] call BIS_fnc_relPos;
	_finish_pos = getPos ([_finish_pos, 5000] call BIS_fnc_nearestRoad); 
	_finish_pos set [2, 0];

	[west, [_taskID], ["STR_SIDE_CONVOY_DESCRIPTION", "STR_SIDE_CONVOY_TITLE", ""], objNull, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

	_vehicles = [];
	_crews = [];

	for "_i" from 1 to 3 do {
		private _vehicle = selectRandom (enemy_vehicles_heavy + enemy_vehicles_light) createVehicle _pos;
		_vehicle setDir _direction;
		_vehicle lock true;
		private _crew = [_vehicle,enemy_infantry,true] call prj_fnc_create_crew;
		_crews = _crews + _crew;
		crew _vehicle doMove _finish_pos;
		_vehicles pushBack _vehicle;
		[west, [(_taskID + "_" + str _i),_taskID], ["", "STR_SIDE_CONVOY_VEHICLE", ""], _vehicle, "CREATED", 0, false, "car"] call BIS_fnc_taskCreate;
	};

	waitUntil {sleep 5;{!alive _x} forEach _vehicles || {(_x distance _finish_pos) < 300} forEach _vehicles || _taskID call BIS_fnc_taskCompleted};

	if ({!alive _x} forEach _vehicles) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
		uiSleep 2;
	};

	if ({(_x distance _finish_pos) < 300} forEach _vehicles) then {
		[_taskID,"FAILED"] call BIS_fnc_taskSetState;
		uiSleep 2;
	};

	[_taskID] call BIS_fnc_deleteTask;
	{deleteVehicle _x} forEach _vehicles + _crews;

};

prj_side_destroy_tower = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_center_pos","_pos","_tower_class","_tower","_generator","_picture"];

	_taskID = "SIDE_" + str _taskID;

	_center_pos = [1,false] call prj_fnc_select_position;
	_pos = [_center_pos, 200, 500, 3, 0] call BIS_fnc_findSafePos;

	_tower_class = selectRandom towers;
	_tower = (_tower_class select 0) createVehicle _pos;
	_generator = (_tower_class select 1) createVehicle ((position _tower) findEmptyPosition [0,20,_tower_class select 1]);

	_picture = getText(configfile >> "CfgVehicles" >> _tower_class select 0 >> "editorPreview");

	[west, [_taskID], [format [localize "STR_SIDE_DESTROY_TOWER_DESCRIPTION", _picture], "STR_SIDE_DESTROY_TOWER_TITLE", ""], _center_pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

	[_taskID,_center_pos,"ColorOrange",0.7,[[500,500],"ELLIPSE"]] call prj_fnc_create_marker;

	waitUntil {sleep 5; !alive _tower || !alive _generator || _taskID call BIS_fnc_taskCompleted};

	if (!alive _tower || !alive _generator) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
		sleep 2;
	};

	[_taskID] call BIS_fnc_deleteTask;
	{deleteVehicle _x} forEach [_tower,_generator];
	deleteMarker _taskID;
};

prj_side_destruction_of_vehicles = {
    params [
        "_taskID","_reward"
    ];

    private ["_taskID","_center_pos","_pos"];

    _taskID = "SIDE_" + str _taskID;

    _center_pos = [1] call prj_fnc_select_position;

    _enemies = [];
    _vehicles = [];
    _pos = [_center_pos, 200, 550, 5, 0] call BIS_fnc_findSafePos;

    _enemy_grp = createGroup independent;

    for [{private _i = 0 }, { _i < [5,10] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
        _vehicle = (selectRandom enemy_vehicles_light) createVehicle _pos;
        _vehicle setDir (round (random 359));
        _vehicle lock true;
        _vehicles pushBack _vehicle;
        uisleep 0.2;
        _unit = _enemy_grp createUnit [selectRandom enemy_infantry, (position _vehicle) findEmptyPosition [0,30,"C_IDAP_Man_AidWorker_01_F"], [], 0, "NONE"];
        _enemies pushBack _unit;
    };

    [west, [_taskID], ["STR_SIDE_DESTRUCTION_OF_VEHICLES_DESCRIPTION", "STR_SIDE_DESTRUCTION_OF_VEHICLES_TITLE", ""], _center_pos, "CREATED", 0, true, "destroy"] call BIS_fnc_taskCreate;

    [_taskID,_center_pos,"ColorOrange",0.7,[[600,600],"ELLIPSE"]] call prj_fnc_create_marker;

    waitUntil {sleep 5;{!alive _x} forEach _vehicles || _taskID call BIS_fnc_taskCompleted};

    if ({!alive _x} forEach _vehicles) then {
        [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
        [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
        uiSleep 2;
    };

    [_taskID] call BIS_fnc_deleteTask;
    {deleteVehicle _x} forEach _vehicles + _enemies;
    deleteMarker _taskID;
};

prj_side_hostage = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_center_pos","_pos","_hostage","_enemy","_picture","_trg"];

	_taskID = "SIDE_" + str _taskID;

	_center_pos = [1,false] call prj_fnc_select_position;
	_pos = [_center_pos, 200] call prj_fnc_select_house_position;

	_hostage = (createGroup civilian) createUnit [selectRandom civilian_units, _pos, [], 0, "NONE"];
	_enemy = (createGroup independent) createUnit [selectRandom enemy_infantry, position _hostage, [], 0, "NONE"];
	[_hostage, true] call ACE_captives_fnc_setHandcuffed;
	_hostage setCaptive true;
	{_x setBehaviour "CARELESS"} forEach [_hostage,_enemy];

	[_taskID + "_red_base",position Checkpoint1,"ColorWEST",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;
	[_taskID + "_blue_base",position Checkpoint2,"ColorWEST",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;
	[_taskID + "_center",_center_pos,"ColorWEST",0.7,[[200,200],"ELLIPSE"]] call prj_fnc_create_marker;

	_picture = getText(configfile >> "CfgVehicles" >> typeOf _hostage >> "editorPreview");

	[west, [_taskID], [format [localize "STR_SIDE_HOSTAGE_DESCRIPTION",_picture], "STR_SIDE_HOSTAGE_TITLE", ""], _center_pos, "CREATED", 0, true, "help"] call BIS_fnc_taskCreate;

	uiSleep 1;

	_trg = createTrigger ["EmptyDetector", position _hostage, true];
	_trg setVariable ["unit", _hostage];
	_trg setTriggerArea [5, 5, 0, false];
	_trg setTriggerActivation ["WEST", "PRESENT", false];
	_trg setTriggerStatements ["this", "_unit = thisTrigger getVariable 'unit'; [_unit] join (thisList select 0); _unit setUnitPos 'UP'", ""];
	_trg attachTo [_hostage, [0, 0, 0]];

	waitUntil {sleep 5; !alive _hostage || _hostage distance position Checkpoint1 < 50 || _hostage distance position Checkpoint2 < 50 || _taskID call BIS_fnc_taskCompleted};

	if (!alive _hostage) then {
		[_taskID,"FAILED"] call BIS_fnc_taskSetState;
		sleep 2;
	};

	if (_hostage distance position Checkpoint1 < 50 || _hostage distance position Checkpoint2 < 50) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
		sleep 2;
	};

	[_hostage, false] call ACE_captives_fnc_setHandcuffed;
	_hostage action ["GetOut",vehicle _hostage];
	[_taskID] call BIS_fnc_deleteTask;
	{deleteVehicle _x} forEach [_hostage,_enemy];
	{deleteMarker _x} forEach [(_taskID + "_red_base"),(_taskID + "_blue_base"),(_taskID + "_center")];
};

prj_side_humanitarian_aid = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_pos","_pos_box","_boxes","_trg"];

	_taskID = "SIDE_" + str _taskID;

	_pos = [1] call prj_fnc_select_position;
	_pos = [_pos, 100, 500, 5, 0] call BIS_fnc_findSafePos;

	[_taskID,_pos,"ColorWEST",0.7,[[35,35],"ELLIPSE"]] call prj_fnc_create_marker;

	[west, [_taskID], ["STR_SIDE_HUMANITARIAN_AID_DESCRIPTION", "STR_SIDE_HUMANITARIAN_AID_TITLE", ""], _pos, "CREATED", 0, true, "container"] call BIS_fnc_taskCreate;

	_pos_box = position selectRandom [Checkpoint1,Checkpoint2];
	_boxes = [];

	for "_i" from 1 to (round ((count (allPlayers - (entities "HeadlessClient_F"))) / 2)) do {
		private _box = "C_IDAP_supplyCrate_F" createVehicle (_pos_box findEmptyPosition [0,50,"C_IDAP_supplyCrate_F"]);
		_box setVariable ["ace_cookoff_enable", false, true];
		[_box, true, [0, 1.4, 0], 90] call ace_dragging_fnc_setDraggable;
		[west, [(_taskID + "_" + str _i),_taskID], ["", "STR_SIDE_HUMANITARIAN_AID_CARGO", ""], _box, "CREATED", 0, false, "box"] call BIS_fnc_taskCreate;
		_boxes pushBack _box;
	};

	_trg = createTrigger ["EmptyDetector", _pos, true];
	_trg setVariable ["boxes", _boxes];
	_trg setTriggerArea [35, 35, 0, false, 10];
	_trg setTriggerActivation ["NONE", "PRESENT", false];
	_trg setTriggerStatements ["{_x in thisList && ((getPosATL _x) select 2) < 0.2 && (speed _x == 0)} forEach (thisTrigger getVariable 'boxes')", "",""];

	waitUntil {sleep 5; {!alive _x} forEach _boxes || triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

	if ({!alive _x} forEach _boxes) then {
		[_taskID,"FAILED"] call BIS_fnc_taskSetState;
		uiSleep 2;
	};

	if (triggerActivated _trg) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
		uiSleep 2;
	};

	[_taskID] call BIS_fnc_deleteTask;
	deleteMarker _taskID;

	uiSleep 30;

	{deleteVehicle _x} forEach [_trg] + _boxes;
};

prj_side_intel_uav = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_center_pos","_pos","_trg","_enemy"];

	_taskID = "SIDE_" + str _taskID;

	_center_pos = [3] call prj_fnc_select_position;
	_pos = [_center_pos, 200, 500, 5, 0] call BIS_fnc_findSafePos;

	_uav = friendly_UAV_array createVehicle _pos;
	_uav setDamage 0.8;
	_uav allowDamage false;
	_uav_pylons = "true" configClasses (configFile >> "CfgVehicles" >> friendly_UAV_array >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
	{_uav setPylonLoadout [_x, ""]} forEach _uav_pylons;

	_uav_smoke = createVehicle ["test_EmptyObjectForSmoke", position _uav, [], 0, "CAN_COLLIDE"];
	_uav_smoke attachTo [_uav, [0, 0, 0]];

	[west, [_taskID], ["STR_SIDE_INTEL_UAV_DESCRIPTION", "STR_SIDE_INTEL_UAV_TITLE", ""], _center_pos, "CREATED", 0, true, "intel"] call BIS_fnc_taskCreate;

	[_taskID,_center_pos,"ColorWEST",0.7,[[500,500],"ELLIPSE"]] call prj_fnc_create_marker;

	_trg = createTrigger ["EmptyDetector", position _uav, true];
	_trg setTriggerArea [10, 10, 0, false, 20];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements ["this", "",""];
	_trg attachTo [_uav, [0, 0, 0]];

	waitUntil {sleep 5; triggerActivated _trg || _taskID call BIS_fnc_taskCompleted};

	if (triggerActivated _trg) then {
		_enemy = [];

		for [{private _i = 0 }, { _i < [10,20] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
			private _grpname = createGroup independent;
			private _position = [position _uav, [200,300] call BIS_fnc_randomInt, [0,359] call BIS_fnc_randomInt] call BIS_fnc_relPos;
			private _unit = _grpname createUnit [selectRandom enemy_infantry, _position, [], 0, "NONE"];
			_enemy pushBack _unit;
		};
	};

	{_x doMove position _uav} forEach _enemy;

	while {!(_taskID call BIS_fnc_taskCompleted)} do {

		if (triggerActivated _trg) then {

			for [{private _i = 120 }, { _i > -1  }, { _i = _i - 10 }] do {

				if (!triggerActivated _trg) exitWith {
					["HQ", "Download stopped!"] remoteExec ["BIS_fnc_showSubtitle",0];
					["stopdnlddronedate"] remoteExec ["playSound", 0];
				};

				switch (_i) do {	
					case 120: {
						["HQ", "The signal is good. Start of download."] remoteExec ["BIS_fnc_showSubtitle",0];
						["startdnlddronedate"] remoteExec ["playSound", 0];
					};
					case 90: {
						["90dnlddronedate"] remoteExec ["playSound", 0];
					};
					case 60: {
						["60dnlddronedate"] remoteExec ["playSound", 0];
					};
					case 30: {
						["30dnlddronedate"] remoteExec ["playSound", 0];
					};
					case 0: {
						["HQ", "Data downloaded successfully."] remoteExec ["BIS_fnc_showSubtitle",0];
						["finishdnlddronedate"] remoteExec ["playSound", 0];
						[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
						[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
						uiSleep 2;
					};
				};

				if (_i > 0) then {
					["HQ", str _i + " seconds left."] remoteExec ["BIS_fnc_showSubtitle",0];
				};

				uiSleep 10;
			};
		};

		uiSleep 5;
	};

	waitUntil {sleep 5;_taskID call BIS_fnc_taskCompleted};

	[_taskID] call BIS_fnc_deleteTask;
	deleteMarker _taskID;

	uiSleep 30;

	{deleteVehicle _x} forEach [_trg,_uav,_uav_smoke] + (if (!isNil "_enemy") then {_enemy});
};

prj_side_liquidation_leader = {
	params [
		"_taskID","_reward"
	];

	private ["_taskID","_center_pos","_pos","_leader","_enemy","_picture"];

	_taskID = "SIDE_" + str _taskID;

	_center_pos = [1,false] call prj_fnc_select_position;

	_pos = [_center_pos, 200] call prj_fnc_select_house_position;

	_leader = (createGroup independent) createUnit [selectRandom enemy_leaders, _pos, [], 0, "NONE"];
	_enemy = (createGroup independent) createUnit [selectRandom enemy_infantry, position _leader, [], 0, "NONE"];
	{_x setBehaviour "CARELESS"} forEach [_leader,_enemy];

	[_taskID,_center_pos,"ColorEAST",0.7,[[200,200],"ELLIPSE"]] call prj_fnc_create_marker;

	_picture = getText(configfile >> "CfgVehicles" >> typeOf _leader >> "editorPreview");

	[west, [_taskID], [format [localize "STR_SIDE_LIQUIDATION_LEADER_DESCRIPTION",_picture], "STR_SIDE_LIQUIDATION_LEADER_TITLE", ""], _center_pos, "CREATED", 0, true, "kill"] call BIS_fnc_taskCreate;

	waitUntil {sleep 5; !alive _leader || _taskID call BIS_fnc_taskCompleted};

	if (!alive _leader) then {
		[_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
		[player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
		sleep 2;
	};

	[_taskID] call BIS_fnc_deleteTask;
	{deleteVehicle _x} forEach [_leader,_enemy];
	deleteMarker _taskID;
};

prj_side_mines = {
    params [
        "_taskID","_reward"
    ];

    private ["_taskID","_pos","_mine","_mines"];

    _taskID = "SIDE_" + str _taskID;

    _pos = ([3] call prj_fnc_select_road_position) select 0;

    _mines = [];

    for [{private _i = 0 }, { _i < ([5,15] call BIS_fnc_randomInt) }, { _i = _i + 1 }] do {
        private _roads = _pos nearRoads 250;
        private _roads = _roads select {isOnRoad _x};
        private _road = selectRandom _roads;
        _pos = getPos _road;

        _mine = createMine [selectRandom ied, _pos, [], 0];
        _mines pushBack _mine;

        if (prj_debug) then {
            private _marker = createMarker [("minemarker" + str _i + str (position _mine)), position _mine];
            _marker setMarkerType "mil_dot";
            _marker setMarkerColor "ColorBLACK";
        };
    };

    {independent revealMine _x} forEach _mines;

    [west, [_taskID], ["STR_SIDE_MINES_DESCRIPTION", "STR_SIDE_MINES_TITLE", ""], _pos, "CREATED", 0, true, "mine"] call BIS_fnc_taskCreate;

    [_taskID,_pos,"ColorOrange",0.7,[[750,750],"ELLIPSE"]] call prj_fnc_create_marker;

    uiSleep 1;

    waitUntil {sleep 5;{!mineActive _x} forEach _mines || _taskID call BIS_fnc_taskCompleted};

    if ({!mineActive _x} forEach _mines) then {
        [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
        [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
        uiSleep 2;
    };

    [_taskID] call BIS_fnc_deleteTask;
    deleteMarker _taskID;
};

prj_side_rescue = {
    params [
        "_taskID","_reward"
    ];

    private ["_taskID","_center_pos","_pos","_heli","_heli_smoke","_picture","_pilot","_trg","_enemies"];

    _taskID = "SIDE_" + str _taskID;

    _center_pos = [1] call prj_fnc_select_position;
    _pos = [_center_pos, 300, 900, 5, 0] call BIS_fnc_findSafePos;

    _heli = (selectRandom friendly_helicopters) createVehicle _pos;
    _heli setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
    _heli setDamage 1;

    _heli_smoke = createVehicle ["test_EmptyObjectForSmoke", position _heli, [], 0, "CAN_COLLIDE"];
    _heli_smoke attachTo [_heli, [0, 0, 0]];

    _picture = getText(configfile >> "CfgVehicles" >> typeOf _heli >> "editorPreview");

    [west, [_taskID], [format [localize "STR_SIDE_RESCUE_DESCRIPTION",_picture], "STR_SIDE_RESCUE_TITLE", ""], _center_pos, "CREATED", 0, true, "search"] call BIS_fnc_taskCreate;

    sleep 3;

    _pilot = (createGroup civilian) createUnit [getText(configfile >> "CfgVehicles" >> typeOf _heli >> "crew"), position _heli findEmptyPosition [10,200,"B_Survivor_F"], [], 0, "NONE"];
    _pilot setCaptive true;
    removeAllWeapons _pilotheli;
    _pilot setBehaviour "CARELESS";
    _pilot setUnitPos "DOWN";

    [_taskID + "_red_base",position Checkpoint1,"ColorWEST",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;
    [_taskID + "_blue_base",position Checkpoint2,"ColorWEST",0.7,[[50,50],"ELLIPSE"]] call prj_fnc_create_marker;
    [_taskID + "_center",_center_pos,"ColorWEST",0.7,[[900,900],"ELLIPSE"]] call prj_fnc_create_marker;

    _trg = createTrigger ["EmptyDetector", position _pilot, true];
    _trg setVariable ["unit", _pilot];
    _trg setTriggerArea [5, 5, 0, false];
    _trg setTriggerActivation ["WEST", "PRESENT", false];
    _trg setTriggerStatements ["this", "_unit = thisTrigger getVariable 'unit'; [_unit] join (thisList select 0); _unit setUnitPos 'UP'; timeendmissionfailed=timeendmissionfailed+1200; independentwinrescuemis=false;", ""];
    _trg attachTo [_pilot, [0, 0, 0]];

    _enemies = [];

    for [{private _i = 0 }, { _i < [10,20] call BIS_fnc_randomInt }, { _i = _i + 1 }] do {
        private _grpname = createGroup independent;
        private _pos = [position _pilot, 50, 150, 1, 0] call BIS_fnc_findSafePos;
        private _unit = _grpname createUnit [selectRandom enemy_infantry, _pos, [], 0, "NONE"];
        _enemies pushBack _unit;
    };

    {_x lookAt _heli} forEach _enemies;

    waitUntil {sleep 5; !alive _pilot || _pilot distance position Checkpoint1 < 50 || _pilot distance position Checkpoint2 < 50 || _taskID call BIS_fnc_taskCompleted};

    if (!alive _pilot) then {
        [_taskID,"FAILED"] call BIS_fnc_taskSetState;
        sleep 2;
    };

    if (_pilot distance position Checkpoint1 < 50 || _pilot distance position Checkpoint2 < 50) then {
        [_taskID,"SUCCEEDED"] call BIS_fnc_taskSetState;
        [player,["money",(player getVariable "money") + _reward]] remoteExec ["setVariable",0];
        sleep 2;
    };

    [_pilot, false] call ACE_captives_fnc_setHandcuffed;
    _pilot action ["GetOut",vehicle _pilot];
    [_taskID] call BIS_fnc_deleteTask;
    {deleteVehicle _x} forEach [_pilot,_trg,_heli_smoke] + _enemies;
    {deleteMarker _x} forEach [(_taskID + "_red_base"),(_taskID + "_blue_base"),(_taskID + "_center")];
};