//H
//H ~~
//H $FILE$		:	<mission>/custom/mgmTfA/mgmTfA_c_FD_scr_presentCATPActionMenu.sqf
//H $PURPOSE$	:	This client-side script presents the menu options.
//H ~~
//HH
//HH	The server-side master configuration file contain the following variables [which should be publicVariable published by server-side init]:
//HH		mgmTfA_configgv_CATPObject
//HH		mgmTfA_configgv_taxiFixedDestination01ActionMenuTextString
//HH		mgmTfA_configgv_taxiFixedDestination02ActionMenuTextString
//HH		mgmTfA_configgv_taxiFixedDestination03ActionMenuTextString
//HH		mgmTfA_configgv_CATPCheckFrequencySecondsNumber
//HH
//HH	The client-side init file create the following value(s) this function rely on:
//HH		mgmTfA_dgv_lastFixedDestinationTaxiBookingPlacedAtTimestampInSecondsNumber
//HH
//HH	This script will fill in the following global variables:
//HH		mgmTfA_gv_pvs_requestorPositionArray3D
//HH
if (isServer) exitWith {}; if (isNil("mgmTfA_Client_Init")) then {mgmTfA_Client_Init=0;}; waitUntil {mgmTfA_Client_Init==1}; private ["_thisFileVerbosityLevelNumber"]; _thisFileVerbosityLevelNumber = mgmTfA_configgv_clientVerbosityLevel;

//Initialize local variables
private	[
		"_lastKnownCATPObjectNeedCleanup",
		"_nearbyCATPCheckResult",
		"_CATPNearByObject",
		"_currentStatusOfThisObjectsAddActionMenu",
		"_thisFileVerbosityLevelNumber"
		];


uiSleep 3;

// when player get close to a CATP, an 'addAction' menu option will be added.
// when player leave CATP's close-proximity-range, addAction menu option will need to be cleaned up (addAction item should be removed). To do this we use this variable. A check, down the loop will look for this.
// this local variable will hold 'true' when clean up is needed. at the beginning of execution of this file, for the time being, no clean up is necessary.
_lastKnownCATPObjectNeedCleanup = false;
// starting value is false -- unless proven otherwise, we are NOT near a CATP
_nearbyCATPCheckResult = false;

while {true} do {
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// SYNOPSIS:	This main loop will perform the following tasks as long as player is alive:
	//
	//	STEP 1: perform the MAIN CHECK:	check for condition ("Are we near a CATP?) and proceed according to the result.
	//					-> POTENTIAL RESULT1: yes, we are near a CATP >>> ActionMenuOption should now be attached to the CATP-vehicle
	//								SUBCHECK:
	//									-> if it is ATTACHED  do nothing
	//									-> if it is NOT ATTACHED attach it now
	//					-> POTENTIAL RESULT2: no, we are not near a CATP  >> nothing to do then
	//	STEP 2: uiSleep 3 seconds
	//	STEP 3: return to top of the loop & start over
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	uiSleep mgmTfA_configgv_CATPCheckFrequencySecondsNumber;
	if (_thisFileVerbosityLevelNumber>=10) then {diag_log format ["[mgmTfA] [mgmTfA_c_FD_scr_presentCATPActionMenu.sqf] [TV10] BEGIN reading file. Before calling the function _nearbyCATPCheckResult is: %1 (should be 'false' now)", _nearbyCATPCheckResult];};//dbg

	// if we do not have the main display 46 let's wait for it to appear -- to eliminate unnecessary checks while player not in game (e.g.: while connecting)
	waitUntil {!isnull (finddisplay 46)};
	// There is no need to check for a CATP if we are already in a vehicle
	waitUntil {sleep 1; ((vehicle player) == player) };

	//Let's check if we have a CATP nearby
	_nearbyCATPCheckResult = call mgmTfA_c_FD_fnc_returnTrueIfThereIsACATPNearby;
	if (_nearbyCATPCheckResult) then {
		//
		// Yay! we have a CATP nearby!

		// Let's put it into a local variable as we will add/remove `addAction` to it.
		// BIS `nearestObject` function search range is 50m.
		_CATPNearByObject = nearestObject [player, mgmTfA_configgv_CATPObject];

		// Mark the nearByCATP state -- when we leave the close proximity range, we will need to do some clean up!
		_lastKnownCATPObjectNeedCleanup = true;

		// Check menuAttachedStatus of this CATP object
		if (isNil {_CATPNearByObject getVariable "menuAttachedStatus"}) then {
				// it was not defined (nil) which means object has no menu -- we will set it to "noObjectDoesNotHaveToggleMenu", then broadcast the result to all MP computers
				_CATPNearByObject setVariable["menuAttachedStatus", "noObjectDoesNotHaveToggleMenu", true];
				publicVariable "menuAttachedStatus";
		};
		// At this point, it's guaranteed that menuAttachedStatus of this object is defined
		_currentStatusOfThisObjectsAddActionMenu = (_CATPNearByObject getVariable "menuAttachedStatus");

		// AddAction if necessary
		if (_currentStatusOfThisObjectsAddActionMenu == "yesObjectDoesHaveToggleMenu") then {
				// Object already has a ToggleMenu - let's not add a second one	// Nothing to be done here
		} else {
				// Object does not have a ToggleMenu -- let's add it, update the status public variable and broadcast it to all MP computers
				//TODO: why do we have to broadcast this 'local business' again?
				// Perform addAction on CATP Object
				// TerminationCondition = when player no longer has a CATP nearby
				// BIKI: "If action is added to some object and not to player, condition will only get evaluated IF player is closer than 15m to the object AND is looking at the object."
				
				// Requestor's position -- so that we know where to request the taxi!
				// This must be a global var
				// Position is not precise/realtime -- fixed to the exact spot player was at, when he entered the 15 meter radius. shouldn't matter for our taxi booking purpose!
				mgmTfA_gv_pvs_requestorPositionArray3D = (getPos player);
				
				mgmTfA_gv_actionMenuItemTaxiFixedDestination01 = _CATPNearByObject addaction	[	mgmTfA_configgv_taxiFixedDestination01ActionMenuTextString,			"[mgmTfA_gv_pvs_requestorPositionArray3D, 1] call mgmTfA_c_FD_fnc_sendBookingRequestForFDTaxi",		"",							0,		false,		false,		"",		""];
				mgmTfA_gv_actionMenuItemTaxiFixedDestination02 = _CATPNearByObject addaction	[	mgmTfA_configgv_taxiFixedDestination02ActionMenuTextString,			"[mgmTfA_gv_pvs_requestorPositionArray3D, 2] call mgmTfA_c_FD_fnc_sendBookingRequestForFDTaxi",		"",							0,		false,		false,		"",		""];
				mgmTfA_gv_actionMenuItemTaxiFixedDestination03 = _CATPNearByObject addaction	[	mgmTfA_configgv_taxiFixedDestination03ActionMenuTextString,			"[mgmTfA_gv_pvs_requestorPositionArray3D, 3] call mgmTfA_c_FD_fnc_sendBookingRequestForFDTaxi",		"",							0,		false,		false,		"",		""];
				_CATPNearByObject setVariable ["menuAttachedStatus","yesObjectDoesHaveToggleMenu",true];
				publicVariable "menuAttachedStatus";

				//Show the "You have arrived a Call-a-Taxi-Point" message only if the player is on foot
				if (vehicle player == player) then {
					// player is on foot
					systemChat "[SYSTEM]  CALL-A-TAXI MENU OPTION HAS BEEN ADDED";
					hint parseText format["<img size='6' image='custom\mgmTfA\img\mgmTfA_c_FD_img_canCall.jpg'/><br/><br/><t size='1.40' color='#00FF00'>You have arrived at a Call-a-Taxi-Point.</t>", 5];
				} else {
					// Player in a vehicle at the moment
					// Do not display anything about CATP
				};
		};
	} else {
			// There are no CATPs nearby.
	
			// Do we need to clean up?
			if (_lastKnownCATPObjectNeedCleanup) then {
					//Yes clean up is needed. dam I hate cleaning!
					_CATPNearByObject removeAction mgmTfA_gv_actionMenuItemTaxiFixedDestination01;
					_CATPNearByObject removeAction mgmTfA_gv_actionMenuItemTaxiFixedDestination02;
					_CATPNearByObject removeAction mgmTfA_gv_actionMenuItemTaxiFixedDestination03;
					_CATPNearByObject setVariable["menuAttachedStatus", "noObjectDoesNotHaveToggleMenu", true];
					publicVariable "menuAttachedStatus";
					if (_thisFileVerbosityLevelNumber>=9) then {diag_log format ["[mgmTfA] [mgmTfA_c_FD_scr_presentCATPActionMenu.sqf] [TV9]      Removed actionMenu from the CATPobject.  mgmTfA_gv_pvs_requestorPositionArray3D is: (%1)", (str mgmTfA_gv_pvs_requestorPositionArray3D)];};// RELEASETODO	// debug

					//Show the "You have left a Call-A-Taxi-Point" message only if the player is on foot
					if (vehicle player == player) then {
						// player is on foot
						systemChat "[SYSTEM]  CALL-A-TAXI MENU OPTION HAS BEEN REMOVED";
						hint parseText format["<img size='6' image='custom\mgmTfA\img\mgmTfA_c_FD_img_cannotCall.jpg'/><br/><br/><t size='1.40' color='#FF2828'>You have left a Call-a-Taxi-Point.</t>", 5];
					} else {
						//I'm in a vehicle at the moment	//Do not display anything about CATP
					};
					_lastKnownCATPObjectNeedCleanup = false;
			};
	};
};
if (_thisFileVerbosityLevelNumber>=9) then {diag_log format ["[mgmTfA] [mgmTfA_c_FD_scr_presentCATPActionMenu.sqf] [TV9] END reading file. _nearbyCATPCheckResult is: %1 (should reflect real status now)", _nearbyCATPCheckResult];};//dbg
// EOF