/*
	Spawns 2 DDR Infantry sections to attack Mariental
	Spawns 1 Tank to attack Mariental
	Should be basic with an aim to creating noise more than anything

	Tank acts a bit weird while shooting, but it should be okay
*/

//Infantry Classes to be Spawned
_squadClasses = ["gm_gc_army_squadleader_mpiak74n_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_machinegunner_lmgrpk_80_str","gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk_80_str","gm_gc_army_antitank_mpiak74n_rpg7_80_str","gm_gc_army_antitank_assistant_mpiak74n_rpg7_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_rifleman_mpiak74n_80_str"];

//Group 1
_groupOne = createGroup [east,true];

//Spawns units
{
	private _unit = _groupOne createUnit [_x, getMarkerPos "groupOneSpawn", [], 5, "None"];
} forEach _squadClasses;

//Group 2
_groupTwo = createGroup [east,true];

//Spawns units
{
	private _unit = _groupTwo createUnit [_x, getMarkerPos "groupTwoSpawn", [], 5, "None"];
} forEach _squadClasses;

//Spawns Tank
_tank = [getMarkerPos "baseAssualtTankSpawn", 235, "gm_gc_army_t55a", EAST] call bis_fnc_spawnvehicle;
_groupTank = _tank select 2;

//Makes Tank Brave and Disables Independent Driving
(driver (_tank select 0)) setskill ["courage",1];
{
	_x disableAI "AUTOTARGET";
	_x disableAI "AUTOCOMBAT";
} forEach units _groupTank;

//Creates a waypoint for groupOne
_groupOneWaypoint = _groupOne addWaypoint [getMarkerPos "groundAssualtPoint", 0];
_groupOneWaypoint setWaypointBehaviour "AWARE";
_groupOneWaypoint setWaypointSpeed "NORMAL";
_groupOneWaypoint setWaypointType "SAD";

//Creates a waypoint for groupTwo 
_groupTwoWaypoint = _groupTwo addWaypoint [getMarkerPos "groundAssualtPoint", 0];
_groupTwoWaypoint setWaypointBehaviour "AWARE";
_groupTwoWaypoint setWaypointSpeed "NORMAL";
_groupTwoWaypoint setWaypointType "SAD";

//Creates a waypoint for tank
_tankWaypoint = _groupTank addWaypoint [getMarkerPos "baseAssualtTankPoint", 0];
_tankWaypoint setWaypointBehaviour "AWARE";
_tankWaypoint setWaypointSpeed "NORMAL";
_tankWaypoint setWaypointType "MOVE";
_tankWaypoint setWaypointCompletionRadius 3;
_groupTank setCombatMode "BLUE";
_tankWaypoint setWaypointStatements ["true","{_x enableAI 'AUTOTARGET';_x enableAI 'AUTOCOMBAT';_x disableAI 'PATH';} forEach units _groupTank; _groupTank setCombatMode 'RED'"];
_groupTank allowFleeing 0;
