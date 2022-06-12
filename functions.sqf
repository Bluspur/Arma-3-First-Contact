/*
	Spawns a small DDR squad that continuously hounds the player group
	4 men
*/

TOB_SpawnWeakHunter = {

 //Infantry Classes to be Spawned
_squadClasses = ["gm_gc_army_squadleader_mpiak74n_80_str","gm_gc_army_machinegunner_lmgrpk_80_str","gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk_80_str","gm_gc_army_rifleman_mpiak74n_80_str"];

//Array of markers, one is selected randomly from the array
_randomSelection = ["weakHunterSpawn_01","weakHunterSpawn_02","weakHunterSpawn_03","weakHunterSpawn_04"] call BIS_fnc_selectRandom;
_position = getMarkerPos _randomSelection;

//Creates Group, New Technique
_hunterGroup = [_position, east, _squadClasses] call BIS_fnc_spawnGroup;

//Marks group to be deleted when killed 
_hunterGroup deleteGroupWhenEmpty true;

//Runs the BIS function that makes the new group stalk the player group
_stalking = [_hunterGroup, group player, nil, 100,{false}, 1] spawn BIS_fnc_stalk;

//Returns the groupID
_hunterGroup
};

TOB_bomberFlyover = {

	//Aircraft to be spawned
	_plane = [getMarkerPos "helicopterSpawnE_2", 270, "len_mig29a_01_nva", EAST] call bis_fnc_spawnvehicle;
	_planeGroup = _plane select 2;
	//Gives Aircraft a waypoint over Mariental HQ
	_bmbWaypoint = _planeGroup addWaypoint [getMarkerPos "bmbMkr", 0];
	_bmbWaypoint setWaypointBehaviour "CARELESS";
	_bmbWaypoint setWaypointSpeed "NORMAL";
	_bmbWaypoint setWaypointtype "MOVE";
	_bmbWaypoint setWaypointTimeout [2, 2, 2];
	_bmbWaypoint setWaypointStatements ["true","_bmb = 'DemoCharge_Remote_Ammo_Scripted' createVehicle (getMarkerPos 'bmbMkr');_bmb setDamage 1; hqDestroyed = true"];
	_planeGroup setCombatMode "BLUE";
	_planeGroup allowFleeing 0;
	(driver (_plane select 0)) setskill ["courage",1];
	{
		_x disableAI "AUTOTARGET";
		_x disableAI "AUTOCOMBAT";
	} forEach units _planeGroup;
	//Gives Aircraft a waypoint to exit the map
	_exitWaypoint = _planeGroup addWaypoint [getMarkerPos "bmbExitMkr", 0];
	_exitWaypoint setWaypointBehaviour "CARELESS";
	_exitWaypoint setWaypointSpeed "NORMAL";
	_exitWaypoint setWaypointtype "MOVE";
};

TOB_patrolSouthEast = {
	//systemChat "South East Patrol Spawned";
	 //Infantry Classes to be Spawned
	_squadClasses = ["gm_gc_army_squadleader_mpiak74n_80_str","gm_gc_army_machinegunner_lmgrpk_80_str","gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_medic_mpiak74n_80_str","gm_gc_army_antitank_mpiak74n_rpg7_80_str","gm_gc_army_antitank_assistant_mpiak74n_rpg7_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_marksman_svd_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_engineer_mpiaks74n_80_str","gm_gc_army_rifleman_mpiak74n_80_str"];

	//Spawns Units at starting location
	_patrolGroup = [getMarkerPos "southEastPatrolWP0", east, _squadClasses] call BIS_fnc_spawnGroup;

	//Prepare the group for patrolling
	_patrolGroup setCombatMode "YELLOW";
	_patrolGroup allowFleeing 0.1;

	//1st Waypoint
	_patrolWaypoint1 = _patrolGroup addWaypoint [getMarkerPos "southEastPatrolWP1", 0]; 
	_patrolWaypoint1 setWaypointBehaviour "AWARE";
	_patrolWaypoint1 setWaypointtype "MOVE";
	_patrolWaypoint1 setWaypointFormation "STAG COLUMN";

	//2nd Waypoint
	_patrolWaypoint2 = _patrolGroup addWaypoint [getMarkerPos "southEastPatrolWP2", 0];
	_patrolWaypoint2 setWaypointBehaviour "AWARE";
	_patrolWaypoint2 setWaypointtype "MOVE";
	_patrolWaypoint2 setWaypointFormation "STAG COLUMN";

	//3rd Waypoint
	_patrolWaypoint3 = _patrolGroup addWaypoint [getMarkerPos "southEastPatrolWP3", 0];
	_patrolWaypoint3 setWaypointBehaviour "AWARE";
	_patrolWaypoint3 setWaypointtype "MOVE";
	_patrolWaypoint3 setWaypointFormation "STAG COLUMN";

	//3rd Waypoint
	_patrolWaypoint4 = _patrolGroup addWaypoint [getMarkerPos "southEastPatrolWP4", 0];
	_patrolWaypoint4 setWaypointBehaviour "AWARE";
	_patrolWaypoint4 setWaypointtype "MOVE";
	_patrolWaypoint4 setWaypointFormation "STAG COLUMN";

	//3rd Waypoint
	_patrolWaypoint5 = _patrolGroup addWaypoint [getMarkerPos "southEastPatrolWP5", 0];
	_patrolWaypoint5 setWaypointBehaviour "AWARE";
	_patrolWaypoint5 setWaypointtype "SAD";
	_patrolWaypoint5 setWaypointFormation "STAG COLUMN";

	//Marks group to be deleted when killed 
	_patrolGroup deleteGroupWhenEmpty true;
};

TOB_motorisedSouth = {
	//systemChat "South Motorised Group Spawned";
	
	//Infantry Classes to be Spawned
	_squadClasses = ["gm_gc_army_squadleader_mpiak74n_80_str","gm_gc_army_machinegunner_lmgrpk_80_str","gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_medic_mpiak74n_80_str","gm_gc_army_antitank_mpiak74n_rpg7_80_str","gm_gc_army_antitank_assistant_mpiak74n_rpg7_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_marksman_svd_80_str"];

	//Spawns and prepares the transport vehicle
	_transport = [(getMarkerPos "southMotorisedWP0"), 0, "gm_gc_army_btr60pb", EAST] call bis_fnc_spawnvehicle;
	//Sets maximum courage
	(driver (_transport select 0)) setskill ["courage",1];
	//XDisables AI's ability to change combat modesX
	//AI should probably be able to react to the player
	/*{
		_x disableAI "AUTOCOMBAT";
	} forEach units (_transport select 2);*/
	//Disables AI's ability to dismount when in combat
	(_transport select 0) setUnloadInCombat [true, true];

	//Spawns both Infantry squads
	_squadIDArray = [];
	for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do 
	{
		_squadID = [(getMarkerPos "southMotorisedWP0"), east, _squadClasses] call BIS_fnc_spawnGroup;
		_squadIDArray pushBack _squadID;
		{
			_x moveInCargo (_transport select 0);
		} forEach units _squadID;
		_squadID deleteGroupWhenEmpty true;
	};

	//Grabs the group IDs of both infantry squads
	_squadOne = (_squadIDArray select 0);
	_squadTwo = (_squadIDArray select 1);

	//Creates the route for the APC
	_transportWP0 = (_transport select 2) addWaypoint [getMarkerPos "southMotorisedWP1", 0];
	_transportWP0 setWaypointBehaviour "AWARE";
	_transportWP0 setWaypointSpeed "NORMAL";
	_transportWP0 setWaypointType "MOVE";
	(_transport select 2) setCombatMode "YELLOW";
	(_transport select 2) allowFleeing 0;
	_transportWP1 = (_transport select 2) addWaypoint [getMarkerPos "southMotorisedWP2", 0];
	_transportWP2 = (_transport select 2) addWaypoint [getMarkerPos "southMotorisedWP3", 0];
	_transportWP2 setWaypointType "TR UNLOAD";

	//WPs for the 2 Inf Patrols
	_squadOneWP0 = _squadOne addWaypoint [getMarkerPos "marientalCenter", 0];
	_squadOneWP0 setWaypointType  "SCRIPTED";
	_squadOneWP0 setWaypointCompletionRadius 200;
	_squadOneWP0 setWaypointScript "\z\lambs\addons\wp\scripts\fnc_wpPatrol.sqf";
	_squadOneWP0 setWaypointSpeed "FULL";
	_squadTwoWP0 = _squadTwo addWaypoint [getMarkerPos "marientalCenter", 0];
	_squadTwoWP0 setWaypointType  "SCRIPTED";
	_squadTwoWP0 setWaypointCompletionRadius 200;
	_squadTwoWP0 setWaypointScript "\z\lambs\addons\wp\scripts\fnc_wpGarrison.sqf";
};

TOB_HelicopterHunters = {
	params ["_landingMarker"];

	_squadClasses = ["gm_gc_army_squadleader_mpiak74n_80_str","gm_gc_army_machinegunner_lmgrpk_80_str","gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_medic_mpiak74n_80_str","gm_gc_army_antitank_mpiak74n_rpg7_80_str","gm_gc_army_antitank_assistant_mpiak74n_rpg7_80_str","gm_gc_army_rifleman_mpiak74n_80_str"];
	_transport = [getMarkerPos "helicopterSpawnE", 270, "len_mi8amt_nva", EAST] call bis_fnc_spawnvehicle;
	
	_squadGroup = createGroup [east,true];
	{
		private _unit = _squadGroup createUnit [_x, getMarkerPos "helicopterSpawnE", [], 0.5, "None"];
		_unit moveInCargo (_transport select 0);
	} forEach _squadClasses;

	_unloadWaypoint = (_transport select 2) addWaypoint [getMarkerPos _landingMarker, 0];
	_unloadWaypoint setWaypointSpeed "NORMAL";
	_unloadWaypoint setWaypointtype "TR UNLOAD";
	_unloadWaypoint setWaypointBehaviour "CARELESS";
	(_transport select 2) setCombatMode "BLUE";
	(_transport select 2) allowFleeing 0;
	(driver (_transport select 0)) setskill ["courage",1];
	{
		_x disableAI "AUTOTARGET";
		_x disableAI "AUTOCOMBAT";
	} forEach units (_transport select 2);

	//Creates an array of units in cargo and keeps counting them until all the units have dismounted
	_cargo = fullCrew [(_transport select 0), "cargo", false];
	_cargoTurret = fullCrew [(_transport select 0), "turret", false];
	_cargoCount = (count _cargo) + (count _cargoTurret) - 1;
	//hint format ["%1 in cargo",_cargoCount];
	while {_cargoCount > 0} do {
		_cargo = fullCrew [(_transport select 0), "cargo", false];
		_cargoTurret = fullCrew [(_transport select 0), "turret", false];
		_cargoCount = (count _cargo) + (count _cargoTurret) - 1;
		//hint format ["%1 in cargo",_cargoCount];
		sleep 1;
	};
	
	_squadWP = _squadGroup addWaypoint [_landingMarker, 0];
	_squadWP setWaypointType  "SCRIPTED";
	_squadWP setWaypointCompletionRadius 1000;
	_squadWP setWaypointScript "\z\lambs\addons\wp\scripts\fnc_wpHunt.sqf";

	_transportExfil = (_transport select 2) addWaypoint [getMarkerPos "helicopterSpawnE", 0];
	_transportExfil setWaypointtype "MOVE";
	_transportExfil setWaypointStatements ["true", "deleteVehicle (vehicle this);{deleteVehicle _x} forEach thislist; deleteGroup (group this);"]
}