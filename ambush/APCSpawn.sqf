/*
	Spawns APC near the IGB gate and sets them on their way to Mariental
*/

//Array of Units to be spawned in cargo - 12
_cargoUnitsClasses = ["gm_gc_army_squadleader_mpiak74n_80_str","gm_gc_army_machinegunner_lmgrpk_80_str","gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_medic_mpiak74n_80_str","gm_gc_army_antitank_mpiak74n_rpg7_80_str","gm_gc_army_antitank_assistant_mpiak74n_rpg7_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_marksman_svd_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_engineer_mpiaks74n_80_str","gm_gc_army_rifleman_mpiak74n_80_str"];
//Spawns Vehicle and Crew
_newAPC = [[10027,5485,0], 300, "gm_gc_army_btr60pb", EAST] call bis_fnc_spawnvehicle;
_newAPCGrp = _newAPC select 2;

//Makes the APC blind for its approach to the base 
(driver (_newAPC select 0)) setskill ["courage",1];
{
	_x disableAI "AUTOTARGET";
	_x disableAI "AUTOCOMBAT";
} forEach units _newAPCGrp;

//Disables Crew and Cargo from dismounting
(_newAPC select 0) setUnloadInCombat [false, false];

//Spawns Cargo Troops
_groundAssualtGroup = createGroup [east,true];
{
	private _unit = _groundAssualtGroup createUnit [_x, getMarkerPos "helicopterSpawnE", [], 0.5, "None"];
	_unit moveInCargo (_newAPC select 0);
} forEach _cargoUnitsClasses;

//Creates a waypoint near Mariental for the troops to be offloaded
_unloadWaypointAPC = _newAPCGrp addWaypoint [getMarkerPos "APCEDropPos", 0];
_unloadWaypointAPC setWaypointBehaviour "AWARE";
_unloadWaypointAPC setWaypointSpeed "NORMAL";
_unloadWaypointAPC setWaypointtype "TR UNLOAD";
_newAPCGrp setCombatMode "BLUE";
_newAPCGrp allowFleeing 0;

//creates an array from all the units in the APC's cargo
_cargo = fullCrew [(_newAPC select 0), "cargo", false];
_cargoTurret = fullCrew [(_newAPC select 0), "Turret", false];

//counts the array
_cargoCount = (count _cargo) + (count _cargoTurret);

//Repeatedly checks if all units have dismounted, then proceeds
while {_cargoCount > 0} do {
	_cargo = fullCrew [(_newAPC select 0), "cargo", false];
	_cargoTurret = fullCrew [(_newAPC select 0), "Turret", false];
	_cargoCount = (count _cargo) + (count _cargoTurret);
	sleep 1;
};
//Creates a waypoint for the GAG 
_assualtWaypointGAG_01 = _groundAssualtGroup addWaypoint [getMarkerPos "groundAssualtPoint", 0];
_assualtWaypointGAG_01 setWaypointBehaviour "AWARE";
_assualtWaypointGAG_01 setWaypointSpeed "NORMAL";
_assualtWaypointGAG_01 setWaypointType "SAD";
//_assualtWaypointGAG_01 setWaypointScript "\z\lambs\addons\wp\scripts\fnc_wpAssault.sqf";

//Activates the Base Assualt Forces
if (isServer) then
{
	execVM "ambush\baseAssualt.sqf";
};

//pauses script to avoid units getting run over
sleep 10;
APCReady = false;
_FBAPC = _newAPCGrp addWaypoint [getMarkerPos "APCEFB", 0];
_FBAPC setWaypointBehaviour "AWARE";
_FBAPC setWaypointSpeed "NORMAL";
_FBAPC setWaypointtype "MOVE";
_FBAPC setWaypointStatements ["true","APCReady = true"];

waitUntil {APCReady};
//Returns the ability to target to the APC while removing their ability to move
{
	_x enableAI "AUTOTARGET";
	_x enableAI "AUTOCOMBAT";
	_x disableAI "PATH";
} forEach units _newAPCGrp;
_newAPCGrp setCombatMode "RED";