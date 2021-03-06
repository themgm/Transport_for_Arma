//H
//H ~~
//H $FILE$		:	<mission>/custom/mgmTfA/mgmTfA_s_CO_scr_initCreateMapMarkerCATP01.sqf
//H $PURPOSE$	:	This server-side script creates a particular Map Marker on server start.
//H ~~
//H
if (!isServer) exitWith {}; if (isNil("mgmTfA_Server_Init")) then {mgmTfA_Server_Init=0;}; waitUntil {mgmTfA_Server_Init==1}; private ["_thisFileVerbosityLevelNumber"]; _thisFileVerbosityLevelNumber = mgmTfA_configgv_serverVerbosityLevel;

// Create a Map Marker for CATP01, if requested in configuration file, as per details defined therein
if(mgmTfA_configgv_createCATP01LocationMapMarkerBool) then {
		markerCATP01String = createMarker["CATP01MapMarker", mgmTfA_configgv_CATP01LocationPositionArray];
		markerCATP01String setMarkerType mgmTfA_configgv_CATP01LocationMapMarkerTypeTextString;
		markerCATP01String setMarkerShape mgmTfA_configgv_CATP01LocationMapMarkerShapeTextString;
		markerCATP01String setMarkerColor mgmTfA_configgv_CATP01LocationMapMarkerColorTextString;
		markerCATP01String setMarkerText mgmTfA_configgv_CATP01LocationMapMarkerTextString;
};
//EOF