
//Array of Marker to be assessed
_markerArray = ["southEastPatrolWP0","southEastPatrolWP1","southEastPatrolWP2","southEastPatrolWP3","southEastPatrolWP4","southEastPatrolWP5","southMotorisedWP0","southMotorisedWP1","southMotorisedWP2","southMotorisedWP3","helicopterEDropPos_2","helicopterEDropPos_3"];
_southEastPatrolRoute = ["southEastPatrolWP0","southEastPatrolWP1","southEastPatrolWP2","southEastPatrolWP3","southEastPatrolWP4","southEastPatrolWP5"];
_southMotorisedRoute = ["southMotorisedWP0","southMotorisedWP1","southMotorisedWP2","southMotorisedWP3"];

while {true} do {
	//systemChat format ["%1",_markerArray];
	sleep 10;
	{
		_playersInProximity = 0;
		_currentMarker = _x;
		_playerCount = {(_x distance (getMarkerPos _currentMarker))<900} count allPlayers;
		_playersInProximity = _playersInProximity + _playerCount;
		if (_playersInProximity > 0) then {
			switch (_currentMarker) do {
    			default {systemChat "something went wrong"};
				case "southEastPatrolWP0";
    			case "southEastPatrolWP1";
				case "southEastPatrolWP2";
				case "southEastPatrolWP3";
				case "southEastPatrolWP4";
				case "southEastPatrolWP5": {[] call TOB_patrolSouthEast;_markerArray = _markerArray - _southEastPatrolRoute;};
				case "southMotorisedWP0";
				case "southMotorisedWP1";
				case "southMotorisedWP2";
				case "southMotorisedWP3": {[] call TOB_motorisedSouth;_markerArray = _markerArray - _southMotorisedRoute;};
				case "helicopterEDropPos_2": {["helicopterEDropPos_2"] call TOB_HelicopterHunters;_markerArray = _markerArray - ["helicopterEDropPos_2"];};
				case "helicopterEDropPos_3": {["helicopterEDropPos_3"] call TOB_HelicopterHunters;_markerArray = _markerArray - ["helicopterEDropPos_3"];};
			};
			//hint format ["%1 players in proximity to markers",_playersInProximity];
		};
	} forEach _markerArray;


};
