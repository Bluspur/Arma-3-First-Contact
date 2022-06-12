/*
THINGS TO DO
	-Make it so the check for players close to the final objective checks that all living players are present and hint to the player that everyone needs to be present
	-Read up on whether the task creation should be ran from the init.sqf and whether it needs a isServer check
*/
[west, ["tskPatrol"], ["Finish your patrol of the Inner German Border and report in to HQ in Mariantal.", "Finish Patrol", "tskPtrlMkr1"], getMarkerPos "tskPtrlMkr1", "AUTOASSIGNED", 1, true, ""] call BIS_fnc_taskCreate;
waitUntil {"tskPatrol" call BIS_fnc_taskCompleted};
//creates the task to leave the RDZ
[west, ["tskRadio"], ["Leave the <marker name=""radioZoneMkr"">Radio Dead Zone</marker> and make radio contact with command at <marker name=""lclCommandMkr"">Mariental Horst</marker>.", "Contact Headquarters", "lclCommandMkr"], getMarkerPos "lclCommandMkr", "AUTOASSIGNED", 1, true, ""] call BIS_fnc_taskCreate;
//creates a local reference for the RDZ marker for use later
_mkr = "radioZoneMkr";
//pauses the script until number of players inside the RDZ is less than the total number of players
waitUntil {(count (allPlayers inAreaArray _mkr)) < (count allPlayers)};
//Sidechat message from player to HQ. Only sends from the Server, to avoid chat repitition
if isServer then {[player, "Mariental, this is border patrol Anton One, are you there? Over"] remoteExec ["sideChat"];};
sleep 4;
if isServer then {[[west, "Base"], "Anton One this is Mariental, we read you. Be patient, we're a little busy right now. Over."] remoteExec ["sideChat"];};
sleep 1;
//completes the task to exit the RDZ 
["tskRadio","SUCCEEDED"] call BIS_fnc_taskSetState;
sleep 3;
if isServer then {[player, "Mariental, what is happening? We saw Ossi forces cross the border fence and open fire on another patrol. Are we being attacked? Over."] remoteExec ["sideChat"];};
sleep 4;
if isServer then {[[west, "Base"], "Anton One, keep calm, we don't have every detail yet."] remoteExec ["sideChat"];};
sleep 2;
//Spawns a flyover of Mariental
hqDestroyed = false;
[] call TOB_bomberFlyover;
waitUntil {hqDestroyed};
if isServer then {[[west, "Base"], "Anton One, prepare to recieve new ord..."] remoteExec ["sideChat"];};
sleep 5;
if isServer then {[player, "Mariental, are you still there? We heard an explosion. Over."] remoteExec ["sideChat"];};
sleep 6;
if isServer then {[player, "Scheisse, they are not responding!"] remoteExec ["groupChat"];};
sleep 3;
if isServer then {[barmkeHQ, "Anton One, this is Berta One, my name is Captain Shwarz, commander of Berta Company at Barmke, do you read me? Over."] remoteExec ["sideChat"];};
sleep 4;
if isServer then {[player, "This is Anton One, we hear you loud and clear Captain. Over"] remoteExec ["sideChat"];};
sleep 4;
if isServer then {[barmkeHQ, "Anton One. We believe Mariental HQ has been hit."] remoteExec ["sideChat"];};
sleep 4;
if isServer then {[barmkeHQ, "We are regrouping at Barmke and gathering all forces to us there"] remoteExec ["sideChat"];};
sleep 3;
if isServer then {[barmkeHQ, "We can't offer you support in getting here, so you'll have to hoof it."] remoteExec ["sideChat"];};
sleep 3;
if isServer then {[barmkeHQ, "Once you're here, we'll get you restocked and rearmed and we'll think about our next move, how copy? Over."] remoteExec ["sideChat"];};
sleep 5;
if isServer then {[player, "Berta One, we confirm your last, we will regroup with you at Barmke. Over."] remoteExec ["sideChat"];};
sleep 6;
if isServer then {[barmkeHQ, "Good luck Anton One, we'll see you here soon. Good luck! Out."] remoteExec ["sideChat"];};
sleep 2;
//Creates the marker for the objective at a pre-determined position (Hidden and used for Task location)
_rvMkr = "|rendezvousMkr|[5623.4131,3478.3411,0.0002]|Empty|ICON|[1,1]|0|Solid|ColorBlue|1|" call BIS_fnc_stringToMarker;
//Creates the task to Rendezvous with friendly forces at Barmke
[west, ["tskRV"], ["Rendezvous with local Bundeswehr elements gathering at Barmke", "Rendezvous", "rendezvousMkr"], _rvMkr, "AUTOASSIGNED", 1, true, "meet"] call BIS_fnc_taskCreate;
//Checks that more than 0 members of the player group is within 400 meters of the destination marker and then checks if at least one of the group members is a player
waitUntil {({_x distance getMarkerPos "rendezvousMkr" < 400} count units TOL_grpMain > 0) && ({_x distance getMarkerPos "rendezvousMkr" < 80} count allPlayers > 0)};
//Debugs that players are close enough
//hint "Player in Mission completion Zone";
//Changes the task state to completed
["tskRV","SUCCEEDED"] call BIS_fnc_taskSetState;
//Forces a short break
sleep 5;
//Ends the mission as a success
["end1",true] remoteExecCall ['BIS_fnc_endMission',0];