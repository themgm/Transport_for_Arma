//H
//H ~~
//H $FILE$		:	<mission>/custom/mgmTfA/mgmTfA_s_CO_fnc_returnARandomFirstnameTextString.sqf
//H $PURPOSE$	:	This function will randomly pick and return a FirstnameTextString from a flat file database
//H ~~
//H
//HH
//HH ~~
//HH	Syntax		:	_newRandomFirstNameTextString = mgmTfA_s_CO_fnc_returnARandomFirstnameTextString;
//HH	Parameters	:	none
//HH	Return Value	:	TextString
//HH ~~
//HH
//HH
//HH ~~
//HH	This function is dependant on the following files			:	//if any, dependant files should be listed below
//HH	Flat-text database file for male firstnames				:	mgmTfA_dat_server_MaleFirstnamesTextStringArrayDB.hpp
//HH
//HH	This function is dependant on the following global variables	:	//if any, dependant global variables should be listed below
//HH ~~
//HH
if (!isServer) exitWith {}; if (isNil("mgmTfA_Server_Init")) then {mgmTfA_Server_Init=0;}; waitUntil {mgmTfA_Server_Init==1}; private ["_thisFileVerbosityLevelNumber"]; _thisFileVerbosityLevelNumber = mgmTfA_configgv_serverVerbosityLevel;
#include "mgmTfA_s_CO_dat_maleFirstnamesTextStringArray.hpp"

//Initialize local variables
private	[
		"_mgmTfA_s_CO_fnc_returnARandomFirstnameTextStringNameToReturn"
		];
//Undefine return container
_mgmTfA_s_CO_fnc_returnARandomFirstnameTextStringNameToReturn = objNull;
//Pick a random Firstname from requested gender array
_mgmTfA_s_CO_fnc_returnARandomFirstnameTextStringNameToReturn = mgmTfA_sgv_firstnamesMaleTextStringArray select (floor (random (count mgmTfA_sgv_firstnamesMaleTextStringArray)));
	if (_thisFileVerbosityLevelNumber>=5) then {diag_log format ["[mgmTfA] [mgmTfA_s_CO_fnc_returnARandomFirstnameTextString.sqf]  [TV5]   Reached checkpoint: Bottom of function. The next line will exit the function & return the value. _mgmTfA_s_CO_fnc_returnARandomFirstnameTextStringNameToReturn is set to: (%1).", _mgmTfA_s_CO_fnc_returnARandomFirstnameTextStringNameToReturn];};
//Return the randomly chosen name
_mgmTfA_s_CO_fnc_returnARandomFirstnameTextStringNameToReturn;
// EOF