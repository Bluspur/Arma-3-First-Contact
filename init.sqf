if (isServer) then 
{
	ambush = false;
	execVM "ambush\ambush.sqf";
	execVM "briefing.sqf";
	execVM "functions.sqf";
	centerObject setVariable ["objectArea",[3500,2000,0,false,0]];  
	[centerObject,[],true] call BIS_fnc_moduleCoverMap;
};