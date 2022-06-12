//Delays the script
sleep 60;
//Units to be spawned into the _airAssualtGroup
_cargoUnitsClasses = ["gm_gc_army_squadleader_mpiak74n_80_str","gm_gc_army_machinegunner_lmgrpk_80_str","gm_gc_army_machinegunner_assistant_mpiak74n_lmgrpk_80_str","gm_gc_army_rifleman_mpiak74n_80_str","gm_gc_army_medic_mpiak74n_80_str","gm_gc_army_antitank_mpiak74n_rpg7_80_str","gm_gc_army_antitank_assistant_mpiak74n_rpg7_80_str","gm_gc_army_rifleman_mpiak74n_80_str"];
//Creates the aircraft at a fixed position and automatically creates a crew
_newAircraft = [getMarkerPos "helicopterSpawnE", 270, "len_mi24d_CAS_nva", EAST] call bis_fnc_spawnvehicle;
_newAircraftGrp = _newAircraft select 2;
//Creates the group that the transported squad will be placed into, will be automatically deleted when the squad is killed
_airAssualtGroup = createGroup [east,true];
//For each unit class in the airAssualtClasses array, creates said unit and moves them into the aircraft's cargo
{
	private _unit = _airAssualtGroup createUnit [_x, getMarkerPos "helicopterSpawnE", [], 0.5, "None"];
	_unit moveInCargo (_newAircraft select 0);
} forEach _cargoUnitsClasses;
//Creates a waypoint for the helicopter to drop off AI troops
_unloadWaypoint = _newAircraftGrp addWaypoint [getMarkerPos "helicopterEDropPos", 0];
_unloadWaypoint setWaypointBehaviour "CARELESS";
_unloadWaypoint setWaypointSpeed "NORMAL";
_unloadWaypoint setWaypointtype "TR UNLOAD";
_newAircraftGrp setCombatMode "BLUE";
_newAircraftGrp allowFleeing 0;
(driver (_newAircraft select 0)) setskill ["courage",1];
{
	_x disableAI "AUTOTARGET";
	_x disableAI "AUTOCOMBAT";
} forEach units _newAircraftGrp;

//creates an array from all the units in the Helicopter's cargo
_cargo = fullCrew [(_newAircraft select 0), "cargo", false];
_cargoTurret = fullCrew [(_newAircraft select 0), "Turret", false];

//counts the array
_cargoCount = (count _cargo) + (count _cargoTurret);
//hint format ["%1 in cargo",_cargoCount];
//Repeatedly checks if all units have dismounted, then proceeds
while {_cargoCount > 0} do {
	_cargo = fullCrew [(_newAircraft select 0), "cargo", false];
	_cargoTurret = fullCrew [(_newAircraft select 0), "Turret", false];
	_cargoCount = (count _cargo) + (count _cargoTurret);
	//hint format ["%1 in cargo",_cargoCount];
	sleep 1;
};

//Creates a waypoint for the GAG 
_assualtWaypoint_01 = _airAssualtGroup addWaypoint [getMarkerPos "airAssualtPoint", 0];
_assualtWaypoint_01 setWaypointBehaviour "AWARE";
_assualtWaypoint_01 setWaypointSpeed "NORMAL";
_assualtWaypoint_01 setWaypointType "SAD";

//Creates a loiter waypoint for the Helicopter 
_heliWaypoint_02 = _newAircraftGrp addWaypoint [getMarkerPos "heliLoiterPoint", 0];
_heliWaypoint_02 setWaypointBehaviour "AWARE";
_heliWaypoint_02 setWaypointSpeed "LIMITED";
_heliWaypoint_02 setWaypointType "LOITER";
_heliWaypoint_02 setWaypointLoiterRadius 300;
_newAircraftGrp setCombatMode "RED";
{
	_x enableAI "AUTOTARGET";
	_x enableAI "AUTOCOMBAT";
} forEach units _newAircraftGrp;
