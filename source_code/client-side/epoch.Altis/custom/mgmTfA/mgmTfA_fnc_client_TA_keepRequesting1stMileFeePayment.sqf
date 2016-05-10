//H
//H
//H ~~
//H $FILE$		:	<mission>/custom/mgmTfA/mgmTfA_fnc_client_TA_keepRequesting1stMileFeePayment.sqf
//H $PURPOSE$	:	This function will be spawn'd with one argument only SU ID (GUSUIDNumber) and it will keep asking for 1st Mile Fee payment every second via systemChat (until commandingCustomer pays this via GUI button or via ActionMenu or alternatively until the phase timeouts) 
//H ~~
//H
//HH
//H ~~
//HH	Syntax		:	_null = [SU_ID] mgmTfA_fnc_client_TA_keepRequesting1stMileFeePayment
//HH	Parameters	:	GUSUIDNumber Globally Unique Service Unit ID number		Number		Examples: 1, 2, 5, 384, 384728473
//HH	Return Value	:	Nothing	[outputs to client's local map]
//H ~~
//HH	The shared configuration file has the following values this function rely on:	mgmTfA_configgv_clickNGoTaxisAbsoluteMinimumJourneyFeeInCryptoNumber
//HH	This function does not create/update any global variables.
//HH	This function does rely on one publicVariable containing the information about the Service Unit:	mgmTfA_gv_PV_SU%1SUTA1stMileFeeNeedToBePaidBool
//HH		For example, for Service Unit 27, the publicVariables would be:
//HH		mgmTfA_gv_PV_SU27SUTA1stMileFeeNeedToBePaidBool
//HH
if (isServer) exitWith {}; if (isNil("mgmTfA_Client_Init")) then {mgmTfA_Client_Init=0;}; waitUntil {mgmTfA_Client_Init==1}; private ["_thisFileVerbosityLevelNumber"]; _thisFileVerbosityLevelNumber = mgmTfA_configgv_clientVerbosityLevel;
scopeName "mgmTfA_fnc_client_TA_keepRequesting1stMileFeePaymentMainScope";
if (!isServer) then { waitUntil {!isnull (finddisplay 46)}; };

// lame workaround to prevent the scenario where our SU's data has not been publicVariable broadcasted yet -- we will need a proper solution for this in a later version
uiSleep 5;

private	[
		"_continueRequesting1stMileFeePayment",
		"_myGUSUIDNumber",
		"_counter55",
		"_msg2SyschatTextString"
		];
// if we have been signalled by mgmTfA_scr_client_initRegisterClientEventHandlers, that means this is initially TRUE
_continueRequesting1stMileFeePayment = true;
// debug slow down counter
_counter55 = 0;
_myGUSUIDNumber = _this select 0;
// log it		-- do not move this line any higher!
if (_thisFileVerbosityLevelNumber>=5) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_TA_keepRequesting1stMileFeePayment.sqf]  [TV5]	BEGIN RUNNING FUNCTION		I will  keep requesting 1st Mile Fee Payment till it is paid or phase timeout, for SU: (%1).", (str _myGUSUIDNumber)];};

//// Begin looping the main loop -- we will keep looping as long as ""mgmTfA_gv_PV_SU%1SUTA1stMileFeeNeedToBePaidBool" is true		-- it can be false only if (a) paid, or (b) phase time out
while {_continueRequesting1stMileFeePayment} do
{
	// DEBUG SLOW DOWN
	_counter55 = _counter55 +1;
	if (_counter55 >= 10) then {
		if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_TA_keepRequesting1stMileFeePayment.sqf]  [TV8] Reached checkpoint: Running main loop. Now executing the very top, just above sleep."];};
		_counter55 = 0;
	};
	// sleep a sec
	uiSleep 1;
	// STEP1:	Obtain Latest Information and Update Local Variables Accordingly
	// inside loop evaluation -- Are we supposed to terminate now?
	_continueRequesting1stMileFeePayment = call compile format ["mgmTfA_gv_PV_SU%1SUTA1stMileFeeNeedToBePaidBool", _myGUSUIDNumber];
	// log the result
	if(_continueRequesting1stMileFeePayment) then {
		// YES continue requesting payment
		if (_thisFileVerbosityLevelNumber>=5) then {diag_log format ["[mgmTfA]  [mgmTfA_fnc_client_TA_keepRequesting1stMileFeePayment.sqf] [TV4] This is _myGUSUIDNumber: (%1)		INSIDE LOOP EVALUATION 		(_continueRequesting1stMileFeePayment) is: (%2)		I WILL CONTINUE LOOPING	", (str _myGUSUIDNumber), (str _continueRequesting1stMileFeePayment)];};
		// request payment
		_msg2SyschatTextString = parsetext format ["Greetings %1 PLEASE PAY THE 1ST MILE FEE: %2 CRYPTO. THANKS!", (profileName), (str mgmTfA_configgv_clickNGoTaxisAbsoluteMinimumJourneyFeeInCryptoNumber)];
		systemChat (str _msg2SyschatTextString);
	} else {
		// NO do not request payment any more - we are terminating!
		if (_thisFileVerbosityLevelNumber>=5) then {diag_log format ["[mgmTfA]  [mgmTfA_fnc_client_TA_keepRequesting1stMileFeePayment.sqf] [TV4] This is _myGUSUIDNumber: (%1)		INSIDE LOOP EVALUATION 		(_continueRequesting1stMileFeePayment) is: (%2)		I WILL TERMINATE NOW	", (str _myGUSUIDNumber), (str _continueRequesting1stMileFeePayment)];};
		// Exit the loops, go back to main, from where we will terminate AFTER writing to log.
		breakTo "mgmTfA_fnc_client_TA_keepRequesting1stMileFeePaymentMainScope";
	};
};
// EOF