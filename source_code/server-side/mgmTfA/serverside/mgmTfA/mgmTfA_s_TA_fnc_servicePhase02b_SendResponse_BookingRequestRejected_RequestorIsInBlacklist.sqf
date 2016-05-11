//H
//H ~~
//H $FILE$		:	<mission>/custom/mgmTfA/mgmTfA_fnc_server_ClickNGoTaxi_ServicePhase02b_SendResponse_BookingRequestRejected_RequestorIsInBlacklist.sqf
//H $PURPOSE$	:	This function process rejected clickNGo taxi requests.
//H ~~
//H
//HH
//HH ~~
//HH	Example usage	:	_null	=	[_clickNGoRequestorClientIDNumber, _clickNGoRequestorPosition3DArray, _clickNGoRequestorPlayerUIDTextString, _clickNGoRequestorProfileNameTextString] spawn mgmTfA_fnc_server_ClickNGoTaxi_ServicePhase02b_SendResponse_BookingRequestRejected_RequestorIsInBlacklist;
//HH	Parameters	:	see the parameter parsing section below
//HH	NEED UPDATE			Return Value	:	none	[this function spawns the next function in "Fixed Destination Taxi - Service Request - Workflow"
//HH ~~
//HH	The server-side master configuration file read (and/or publicVariable publish) the following value(s) this function rely on:
//HH		mgmTfA_configgv_serverVerbosityLevel
//HH		
//HH
//HH	The client-side init file create the following value(s) this function rely on:
//HH		none documented yet
//HH
//HH	Note: we will send an initial "we are processing your request - please wait" message to the Requestor
//HH	Note: we will send the FINAL confirmation to the Requestor ONLY AFTER successfully creating the SU (vehicle+driver).
//HH
if (!isServer) exitWith {}; if (isNil("mgmTfA_Server_Init")) then {mgmTfA_Server_Init=0;}; waitUntil {mgmTfA_Server_Init==1}; private ["_thisFileVerbosityLevelNumber"]; _thisFileVerbosityLevelNumber = mgmTfA_configgv_serverVerbosityLevel;

private	[
		"_clickNGoRequestorClientIDNumber",
		"_clickNGoRequestorPosition3DArray",
		"_clickNGoRequestorPlayerUIDTextString",
		"_clickNGoRequestorProfileNameTextString"
		];

_clickNGoRequestorClientIDNumber = (_this select 0);
_clickNGoRequestorPosition3DArray = (_this select 1);
_clickNGoRequestorPlayerUIDTextString = (_this select 2);
_clickNGoRequestorProfileNameTextString = (_this select 3);
// this below is NOT a DEBUG msg!
if (_thisFileVerbosityLevelNumber>=5) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_server_ClickNGoTaxi_ServicePhase02b_SendResponse_BookingRequestRejected_RequestorIsInBlacklist.sqf]  [TV5] A REJECTED clickNGo taxi request was FORWARDED to me.			This is what I have received:		_clickNGoRequestorClientIDNumber: (%1).		_clickNGoRequestorPosition3DArray: (%2).		_clickNGoRequestorPlayerUIDTextString: (%3) / resolved to _clickNGoRequestorProfileNameTextString: (%4)", _clickNGoRequestorClientIDNumber, _clickNGoRequestorPosition3DArray, _clickNGoRequestorPlayerUIDTextString, _clickNGoRequestorProfileNameTextString];};

// Client Communications - Send the initial "we are processing your request - please wait" message to the Requestor
mgmTfA_gv_pvc_neg_yourclickNGoTaxiRequestHasBeenRejectedAsYouAreBlacklistedPacketSignalOnly = ".";
_clickNGoRequestorClientIDNumber publicVariableClient "mgmTfA_gv_pvc_neg_yourclickNGoTaxiRequestHasBeenRejectedAsYouAreBlacklistedPacketSignalOnly";

// Increment the global counter
mgmTfA_gvdb_PV_clickNGoTaxisTotalRequestsRejectedDueToBlacklistNumber = mgmTfA_gvdb_PV_clickNGoTaxisTotalRequestsRejectedDueToBlacklistNumber + 1;
// Broadcast the value to all computers
publicVariable "mgmTfA_gvdb_PV_clickNGoTaxisTotalRequestsRejectedDueToBlacklistNumber";
// this below is NOT a DEBUG msg!
if (mgmTfA_configgv_serverVerbosityLevel>=4) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_server_ClickNGoTaxi_ServicePhase02b_SendResponse_BookingRequestRejected_RequestorIsInBlacklist.sqf]  [TV4] Just incremented & pV broadcasted (mgmTfA_gvdb_PV_clickNGoTaxisTotalRequestsRejectedDueToBlacklistNumber). After the increment, now it is: (%1)", (str mgmTfA_gvdb_PV_clickNGoTaxisTotalRequestsRejectedDueToBlacklistNumber)];};

// this below is NOT a DEBUG msg!
// Let the log know
if (mgmTfA_configgv_serverVerbosityLevel>=3) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_server_ClickNGoTaxi_ServicePhase02b_SendResponse_BookingRequestRejected_RequestorIsInBlacklist.sqf]  [TV3] A Blacklisted Requestor has just been rejected!	(%1) (PUID: %2) requested a clickNGo Taxi but we've refused to serve him of course!", _clickNGoRequestorProfileNameTextString, _clickNGoRequestorPlayerUIDTextString];};
// EOF