//Gets the Trigger area for starting the approaching patrol
_patrolTrigger = patrolTrigger;
_ambushTrigger = ambushTrigger;
// Creates Patrol
_ptrlGrp = createGroup west;
_ptrlUnit01 = _ptrlGrp createUnit ["gm_ge_bgs_squadleader_g3a3_p2a1_80_smp", [9995,5457,0], [], 0, "CAN_COLLIDE"];
_ptrlUnit02 = _ptrlGrp createUnit ["gm_ge_bgs_rifleman_g3a3_80_smp", [9995,5457,0], [], 0, "CAN_COLLIDE"];
//Forces the Patrol to walk, act carelessly, be in formation
_ptrlGrp setFormation "STAG COLUMN";
{
	_x setBehaviour "Safe"; _x setSpeedMode "Limited"
} forEach [_ptrlGrp];
{
	_x setCaptive true
} forEach (units _ptrlGrp);
//Pauses the script until the player has moved far enough from their starting position
waitUntil {(count (allPlayers inAreaArray _patrolTrigger)) < (count allPlayers)};
//Creates waypoints for the patrol, passes through ambush zone
_wp01 = _ptrlGrp addWaypoint [getMarkerPos "ptrlMkr_01", 0];
_wp01 = _ptrlGrp addWaypoint [getMarkerPos "ptrlMkr_02", 0];
//Create the ambushing group
_ambsGrp = createGroup east;
_ambsGrp setFormDir 270;
_ambsUnit01 = _ambsGrp createUnit ["gm_gc_bgs_rifleman_mpikm72_80_str", [10017.7,5445.31,0], [], 0, "CAN_COLLIDE"];
_ambsUnit02 = _ambsGrp createUnit ["gm_gc_bgs_rifleman_mpikm72_80_str", [10026.1,5416.65,0], [], 0, "CAN_COLLIDE"];
_ambsUnit03 = _ambsGrp createUnit ["gm_gc_army_machinegunner_pk_80_str", [10024.4,5407.98,0], [], 0, "CAN_COLLIDE"];
_ambsUnit04 = _ambsGrp createUnit ["gm_gc_army_rifleman_mpiak74n_80_str", [10019.7,5399.34,0], [], 0, "CAN_COLLIDE"];
{
	_x setUnitPos "Down"; _x setCaptive true; _x setDir 270; _x disableAI "PATH"
} forEach (units _ambsGrp);
//Wait until both patrolling units are in the ambush trigger area 
waitUntil {({alive _x} count units _ptrlGrp) == ({_x inArea _ambushTrigger} count units _ptrlGrp)};
["tskPatrol","CANCELED"] call BIS_fnc_taskSetState;
//hint "Ambush";
//Removes the captive tag from the relevant groups and begins the ambush
{
	_x setCaptive false;
} forEach (units _ptrlGrp);
{
	_x setUnitPos "Middle";
} forEach (units _ambsGrp);
sleep 0.2;
{
	_x setCaptive false;
} forEach (units _ambsGrp);
_mine = createMine ["rhs_mine_a200_bz",[9989,5402,0], [], 0];
_mine setDamage 1;

//Activates the Assualting DDR Forces
if (isServer) then 
{
	execVM "ambush\aircraftSpawn.sqf";
	execVM "ambush\APCSpawn.sqf";
	execVM "ambush\patrolSpawn.sqf";
};

//Defines an array in which the group IDs of the hunter squads will be stored
_hunterSquadArray = [];
_hunterSquadCount = count _hunterSquadArray;

//Checks how many weak hunters are alive and spawns a replacement if needed
while {true} do 
{
	if (_hunterSquadCount < 2) then 
		{
			_hunterSquad = [] call TOB_SpawnWeakHunter;
			_hunterSquadArray pushBack _hunterSquad;
			//hint format ["Group Spawn Success, Active groups = %1",_hunterSquadCount + 1];
		}
	else 
		{
			//hint format ["Group Spawn Failure, Active groups = %1",_hunterSquadCount];
		};
	//hint format ["Hunter Groups = %1",_hunterSquadArray];
	_hunterSquadArray = _hunterSquadArray arrayIntersect _hunterSquadArray;
	_hunterSquadCount = count _hunterSquadArray;
	sleep 60;
};