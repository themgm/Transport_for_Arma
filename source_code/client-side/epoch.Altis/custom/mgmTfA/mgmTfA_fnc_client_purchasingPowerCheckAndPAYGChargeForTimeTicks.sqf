//H
//H ~~
//H $FILE$		:	<mission>/custom/mgmTfA/mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf
//H $PURPOSE$	:	__________undocumented_________
//H ~~
//H
//HH
//HH ~~
//HH	Syntax		:	_null = [GUSUID] mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks
//HH	Parameters	:	see below
//HH	Return Value	:	undocumented
//HH ~~
//HH	The shared configuration file has the following values this function rely on: none
//HH	This function does not create/update any global variables.
//HH	This function does rely on publicVariables containing the information about the Service Unit.
//HH		mgmTfA_configgv_thresholdNumberOfFailedPAYGTransactionsToPermitBeforeInitiatingPAYGserviceAbruptTerminationNumber
//HH
if (isServer) exitWith {}; if (isNil("mgmTfA_Client_Init")) then {mgmTfA_Client_Init=0;}; waitUntil {mgmTfA_Client_Init==1}; private ["_thisFileVerbosityLevelNumber"]; _thisFileVerbosityLevelNumber = mgmTfA_configgv_clientVerbosityLevel;

// TODO:		PVEH:		[GUSUID] mgmTfA_gv_pvc_req_pleaseBeginPurchasingPowerCheckAndPAYGChargeForTimeTicksSignal
// when PVEH trigger, TfA client on the local computer will launch the function:	[GUSUID] mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks
// declare local variables
private		[
			"_myGUSUIDNumber",
			"_functionExecutionTimeInSecondsNumber",
			"_emergencyEscapeNeeded",
			"_tooManyFailedPAYGTransactionsObservedBool",
			"_myVehiclesCommandingCustomerPlayerUIDNumber",
			"_playerCashNumber",
			"_myPUID",
			"_playerMustPayBool",
			"_playerWentBankruptBool",
			"_checkedAndPlayerWasNotInAclickNGoVehicleCountNumber",
			"_player"
			];
_functionExecutionTimeInSecondsNumber= (time);
if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf]  [TV8] 		DEVDEBUG		I have been SPAWN'd		at: (%1).		This is what I have received:	(%2).", (str _functionExecutionTimeInSecondsNumber), (str _this)];};
//// FUNCTION INIT STAGE
// if another instance is running, terminate this to prevent multiple active threads
if (mgmTfA_PurchasingPowerCheckAndPAYGChargeForTimeTicksFunctionCurrentlyRunningBool) exitWith {if (mgmTfA_configgv_clientVerbosityLevel>=5) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV5]          I have been SPAWN'd however (mgmTfA_PurchasingPowerCheckAndPAYGChargeForTimeTicksFunctionCurrentlyRunningBool) is  already active. I will now terminate this function."];};};
// we are now active.		mark it to prevent multiple active threads by possible future SPAWNs & let the log now
scopeName "mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicksMainScope";
mgmTfA_PurchasingPowerCheckAndPAYGChargeForTimeTicksFunctionCurrentlyRunningBool = true;
_emergencyEscapeNeeded = false;
// during this run, so far, we have observed 0 failed checks
mgmTfA_configgv_numberOfFailedPAYGTransactionsObservedOnThisClientNumber = 0;
_tooManyFailedPAYGTransactionsObservedBool = false;
_myPUID = (getPlayerUID player);
_playerMustPayBool = false;
_playerWentBankruptBool = false;
_checkedAndPlayerWasNotInAclickNGoVehicleCountNumber = 0;
_player = player;
if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          Just set this to true => (mgmTfA_PurchasingPowerCheckAndPAYGChargeForTimeTicksFunctionCurrentlyRunningBool).		Current time is: (%1).", (str (time))];};

//// now that we are 'running', let's do any other necessary initial variable assignments
// the variable below is used to determine how long has it been since the last check. only for the first run, it will be nil, thus we will set it to current time
if (isNil "mgmTfA_PurchasingPowerActiveCheckTimestampInSecondsNumber") then {
	mgmTfA_PurchasingPowerActiveCheckTimestampInSecondsNumber = (time);
	if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          (mgmTfA_PurchasingPowerActiveCheckTimestampInSecondsNumber) was nil.		Now, I set it to current time.	It now contains: (%1).", (str mgmTfA_PurchasingPowerActiveCheckTimestampInSecondsNumber)];};
} else {
	if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          (mgmTfA_PurchasingPowerActiveCheckTimestampInSecondsNumber) was not nil so I will not touch it!		It already contains the following value: (%1).", (str mgmTfA_PurchasingPowerActiveCheckTimestampInSecondsNumber)];};
};

// MAIN LOOP
while {true} do {
	uiSleep mgmTfA_configgv_monitoringAgentMissedPurchasingPowerCheckAndPAYGTickChargesAgentSleepTime;
	// debug log: 	client RPT log that main loop is executing now, at $time
	if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          Execution is at the top of main loop now. 		Current time is: (%1).", (str (time))];};

	if (_checkedAndPlayerWasNotInAclickNGoVehicleCountNumber == 15) then {
		if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          _checkedAndPlayerWasNotInAclickNGoVehicleCountNumber = 15!	Terminating now."];};
		breakTo "mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicksMainScope";
	};
	
	// CHECK: is the player in a mgmTfAisclickNGoTaxi at the moment?
	if (((vehicle player) getVariable ["mgmTfAisclickNGoTaxi", false])) then {
		// YES, the player is in a mgmTfAisclickNGoTaxi at the moment
	
		_checkedAndPlayerWasNotInAclickNGoVehicleCountNumber = 0;
		// player IS in a TfA clickNGo vehicle at the moment
		if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          I have determined player is currently in a clickNGoTaxi."];};
		// obtain vehicle's CommandingCustomer PUID -- do this only if player is in a clickNGoTaxi
		_myVehiclesCommandingCustomerPlayerUIDNumber								= (vehicle player) getVariable "commandingCustomerPlayerUIDNumber";
		if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          I have just obtained (_myVehiclesCommandingCustomerPlayerUIDNumber) as: (%1).		My PUID is: (%2).", (str _myVehiclesCommandingCustomerPlayerUIDNumber), (str _myPUID)];};

		// is the local player supposed to pay the next tick?	NOTE: currently, we are running this function for all players on board even if they are not the requestor. in the future, on-the-fly "payingCustomer" switching will be supported, meaning requestor running out of money, from inside the vehicle, one of the other players can take over "PAYG payment" duty. this below is the prep.
		if (_myPUID == _myVehiclesCommandingCustomerPlayerUIDNumber) then {
			// YES, player is the commandingCustomer and mustPay the nextTick
			if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          YES, player is the commandingCustomer and mustPay the nextTick.		_playerMustPayBool  is set to true."];};
			_playerMustPayBool = true;
		} else {
			if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          NO, player is NOT the commandingCustomer and will not pay the nextTick.		_playerMustPayBool  is set to false."];};
			_playerMustPayBool = false;
		};
		// if player mustPay, 	check: can the player afford the next PAYG tick?
		if (_playerMustPayBool) then {
			// YES, player mustPay the next PAYG tick cost

			_playerCashNumber = (EPOCH_playerCrypto);
			if (_playerCashNumber >=mgmTfA_configgv_clickNGoTaxisTickCostInCryptoNumber) then {
				// YES, player can afford the next PAYGtickCost	-- do nothing at this deep level, just proceed.
				if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          YES, player can afford the next PAYGtickCost	-- charging now"];};

				// charge the PAYG tickCost now -- SEND REQUEST to server so that server will charge customer's wallet
				_myGUSUIDNumber = ((vehicle player) getVariable ["GUSUIDNumber", -1]);
				if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA]  [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8] _myGUSUIDNumber has been obtained as: (%1)", (str _myGUSUIDNumber)];};
				myGUSUIDNumber = _myGUSUIDNumber;
				mgmTfA_gv_pvs_req_clickNGoTaxiChargeMePAYGTickCostPleaseConfirmPacket = [player, mgmTfA_gv_pvs_clickNGoRequestorPlayerUIDTextString, myGUSUIDNumber];
				publicVariableServer "mgmTfA_gv_pvs_req_clickNGoTaxiChargeMePAYGTickCostPleaseConfirmPacket";
				// report to log
				if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          CHARGED		the player TaxiAnywhere PAYG tick cost"];};

			} else {
				// NO, player cannot afford the next PAYGtickCost
				if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          NO, player cannot afford the next PAYGtickCost.	let him & the server now."];};
				// let the customer know via hint && systemChat
				private	[
						"_msg2HintTextString",
						"_messageTextOnlyFormat"
						];
				_msg2HintTextString = parsetext format ["<img size='6' image='custom\mgmTfA\img_comms\mgmTfA_img_client_taxiCannotAfford.jpg'/><br/><br/><t size='1.40' color='#00FF00'>%1<br/><br/>SORRY BUT YOU<br/>CANNOT AFFORD<br/>THIS SERVICE ANY MORE!<br/><br/>HAVE A NICE DAY!<br/>", (profileName)];
				_messageTextOnlyFormat = parsetext format ["%1 SORRY BUT YOU CANNOT AFFORD THIS SERVICE ANY MORE! HAVE A NICE DAY!", (profileName)];
				// Print the message
				hint _msg2HintTextString;
				systemChat (str _messageTextOnlyFormat);
				_playerWentBankruptBool = true;
				// signal the server via customerCannotAffordService=true
				(vehicle player) setVariable ["customerCannotAffordService", true, true];
				// break out of main loop
				breakTo "mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicksMainScope";
			};
		} else {
			// NO, player does not have to pay the next PAYG tick cost
			if (_thisFileVerbosityLevelNumber>=8) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV8]          NO, player does not have to pay the next PAYG tick cost"];};
		};
	} else {
		// NO, the player is NOT in a mgmTfAisclickNGoTaxi at the moment			// no reason to keep running a PAYG payment agent here. log the state && set global variable on clientPC pleaseDoPurchasingPowerCheckAndPAYGChargeForTimeTicksBool=false && shutdown the function
		_checkedAndPlayerWasNotInAclickNGoVehicleCountNumber = _checkedAndPlayerWasNotInAclickNGoVehicleCountNumber + 1;

		//	temp debug delete this line and the one under me ***	delete this line and the one under me ***delete this line and the one under me ***delete this line and the one under me ***delete this line and the one under me ***delete this line and the one under me ***delete this line and the one under me ***
		if (_thisFileVerbosityLevelNumber>=5) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV5]		DEVDEBUG		Just determined player currently IS NOT in a clickNGoTaxi!		The result of (str (((vehicle player) getVariable ['mgmTfAisclickNGoTaxi', false]))) is: (%1).", (str (((vehicle player) getVariable ["mgmTfAisclickNGoTaxi", false])))];};//dbg
		//	THIS HAS 		_checkVehicle		if (_thisFileVerbosityLevelNumber>=5) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_clickNGoTaxiDisplayInstructions.sqf] [TV3]		DEVDEBUG		Just determined player currently IS NOT in a clickNGoTaxi!		'mgmTfAisclickNGoTaxi' variable value is: (%1).		Terminating this function immediately.", (str _checkVehicle)];};//dbg
	};
};
if (_tooManyFailedPAYGTransactionsObservedBool) then {	if (mgmTfA_configgv_clientVerbosityLevel>=5) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV5]          This is the bottom of the function. I noticed (_tooManyFailedPAYGTransactionsObservedBool) is  true!	This is the last line."];};		};
if (_playerWentBankruptBool) then {	if (mgmTfA_configgv_clientVerbosityLevel>=5) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV5]          This is the bottom of the function. I noticed (_playerWentBankruptBool) is  true!	This is the last line."];};						};
if (_checkedAndPlayerWasNotInAclickNGoVehicleCountNumber == 15)	then {	if (mgmTfA_configgv_clientVerbosityLevel>=5) then {diag_log format ["[mgmTfA] [mgmTfA_fnc_client_purchasingPowerCheckAndPAYGChargeForTimeTicks.sqf] [TV5]          _checkedAndPlayerWasNotInAclickNGoVehicleCountNumber = 15!	Terminating now. This is the last line."];};					};
mgmTfA_PurchasingPowerCheckAndPAYGChargeForTimeTicksFunctionCurrentlyRunningBool = false;
// EOF