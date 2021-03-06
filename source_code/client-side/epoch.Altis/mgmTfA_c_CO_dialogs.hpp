// Transport for Arma Dialogs

class MGMTFA_DIALOG
{
	// we define an idd can reference the whole dialog any time we wish
	idd = 21310;
	// moving
	movingEnable = true;
	//what's this? =>	moving = 1;
	//code to run when it loads
	onLoad = "";
	//code to run when its closed
	onUnload = "";
    class Controls
    {
		// Background
		class MGMTFA_BACKGROUND: MGMTFA_BACKGROUNDOBJECTTEMPLATE
		{
			idc = -1;
			text = "";
			x = 0.206094 * safezoneW + safezoneX;
			y = 0.125939 * safezoneH + safezoneY;
			w = 0.572344 * safezoneW;
			h = 0.759125 * safezoneH;
			//// blue
			//colorBackground[] = { 0.0,0.5647,1.0,1.0 };
			/// really dark blue - almost black
			colorBackground[] = { 0.0000,0.0000,0.2314,1.0000 };
		};
		class MGMTFA_BACKGROUNDBOXTAXIANYWHERE: MGMTFA_BACKGROUNDOBJECTTEMPLATE
		{
			idc = 13010;
			x = 0.242187 * safezoneW + safezoneX;
			y = 0.323971 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.517085 * safezoneH;
			//[0.2667,0.0000,0.0118,1.0000]
			//colorBackground[] = {0.2784,0.0000,0.0980,1.0000};
			colorBackground[] = {0.2784,0.0000,0.0980,1.0000};
		};
		class MGMTFA_BACKGROUNDBOXPUBLICBUS: MGMTFA_BACKGROUNDOBJECTTEMPLATE
		{
			idc = 13020;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.323971 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.517085 * safezoneH;
			colorBackground[] = {0.2667,0.0000,0.0118,1.0000};
		};
		class MGMTFA_BACKGROUNDBOXFIXEDDESTINATIONTAXI: MGMTFA_BACKGROUNDOBJECTTEMPLATE
		{
			idc = 13030;
			x = 0.608281 * safezoneW + safezoneX;
			y = 0.323971 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.517085 * safezoneH;
			colorBackground[] = {0.2667,0.0000,0.0118,1.0000};
		};
		// Transport for Arma Logo
		class RscPicture_1200: RscPicture
		{
			idc = 13040;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guiLogoTfA.jpg";
			x = 0.221562 * safezoneW + safezoneX;
			y = 0.158944 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.12102 * safezoneH;
		};
		// Arma 3 Logo
		class RscPicture_1201: RscPicture
		{
			idc = 13050;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guiLogoArma.jpg";
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.158944 * safezoneH + safezoneY;
			w = 0.180469 * safezoneW;
			h = 0.132022 * safezoneH;
		};
		// Column Header: Taxi Anywhere Logo
		class RscPicture_1202: RscPicture
		{
			idc = 1202;

			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnHeaderTA.jpg";
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.345975 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.143023 * safezoneH;
		};
		// Column Header: Public Bus Logo
		class RscPicture_1203: RscPicture
		{
			idc = 13060;

			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnHeaderBU.jpg";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.345975 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.110018 * safezoneH;
		};
		// Column Header: Fixed Destination Taxis Logo
		class RscPicture_1204: RscPicture
		{
			idc = 13070;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnHeaderFD.jpg";
			x = 0.62375 * safezoneW + safezoneX;
			y = 0.345975 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.12102 * safezoneH;
		};
	
		////////////////////////////////////////////////////////
		// BEGIN: MGMTFA BUTTONS
		////////////////////////////////////////////////////////

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////
		// column: Taxi Anywhere	// button: Hey Taxi!
		class MGMTFA_BUTTONPICTAXIANYWHEREHEYTAXI: MGMTFA_TEMPLATEBUTTONPIC
		{
			idc = -1;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnHeyTaxi.jpg";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055009 * safezoneH;
		};
		class MGMTFA_BUTTONACTUALBUTTONTAXIANYWHEREHEYTAXI: MGMTFA_TEMPLATEACTUALBUTTON
		{
			idc = -1;
			tooltip = "CALL A TAXI";
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnHeyTaxi.jpg";
			action = "CloseDialog 0;_null=[]execVM ""custom\mgmTfA\mgmTfA_c_TA_scr_heyTaxi.sqf""";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055009 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// column: Taxi Anywhere	// button: 1st Mile Pay Now
		class MGMTFA_BUTTONPICTAXIANYWHERE1STMILEPAYNOW: MGMTFA_TEMPLATEBUTTONPIC
		{
			idc = -1;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnPay1stMile.jpg";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.577013 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055009 * safezoneH;
		};
		class MGMTFA_BUTTONACTUALBUTTONTAXIANYWHERE1STMILEPAYNOW: MGMTFA_TEMPLATEACTUALBUTTON
		{
			idc = -1;
			tooltip = "PAY 1ST MILE FEE";
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnPay1stMile.jpg";
			action = "CloseDialog 0;_null=[]execVM ""custom\mgmTfA\mgmTfA_c_TA_scr_chargeMe1stMileFee.sqf""";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.577013 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055009 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// column: Taxi Anywhere	// button: Set Destination
		class MGMTFA_BUTTONPICTAXIANYWHERESETDESTINATION: MGMTFA_TEMPLATEBUTTONPIC
		{
			idc = -1;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnSetDestination.jpg";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.665027 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055009 * safezoneH;
		};
		class MGMTFA_BUTTONACTUALBUTTONTAXIANYWHERESETDESTINATION: MGMTFA_TEMPLATEACTUALBUTTON
		{
			idc = -1;
			//tooltip = "SET DESTINATION";
			tooltip = "NOT IMPLEMENTED: SET DESTINATION";
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnSetDestination.jpg";
			action = "CloseDialog 0;_null=[]execVM ""custom\mgmTfA\mgmTfA_c_TA_scr_setDestination.sqf""";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.665027 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055009 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// column: Taxi Anywhere	// button: Exit Vehicle
		class MGMTFA_BUTTONPICTAXIANYWHEREEXITVEHICLE: MGMTFA_TEMPLATEBUTTONPIC
		{
			idc = -1;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnExit.jpg";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.786047 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0330054 * safezoneH;
		};
		class MGMTFA_BUTTONACTUALBUTTONTAXIANYWHEREEXITVEHICLE: MGMTFA_TEMPLATEACTUALBUTTON
		{
			idc = -1;
			tooltip = "EXIT VEHICLE";
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnExit.jpg";
			action = "CloseDialog 0;_null=[]execVM ""custom\mgmTfA\mgmTfA_c_TA_fnc_pleaseStopVehicle.sqf""";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.786047 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0330054 * safezoneH;
		};
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////
		// column: Public Bus		// button: Stop the Bus
		class MGMTFA_BUTTONPICPUBLICBUSSTOPTHEBUS: MGMTFA_TEMPLATEBUTTONPIC
		{
			idc = -1;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnStopBU.jpg";
			x = 0.45875 * safezoneW + safezoneX;
			y = 0.544007 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.132022 * safezoneH;
		};
		class MGMTFA_BUTTONACTUALBUTTONPUBLICBUSSTOPTHEBUS: MGMTFA_TEMPLATEACTUALBUTTON
		{
			idc = -1;
			tooltip = "NOT IMPLEMENTED: STOP THE BUS";
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnStopBU.jpg";
			action = "CloseDialog 0;_null=[]execVM ""custom\mgmTfA\mgmTfA_c_BU_scr_pleaseStopVehicle.sqf""";
			x = 0.45875 * safezoneW + safezoneX;
			y = 0.544007 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.132022 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// column: Public Bus		// button: Exit Vehicle
		class MGMTFA_BUTTONPICPUBLICBUSEXITVEHICLE: MGMTFA_TEMPLATEBUTTONPIC
		{
			idc = -1;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnExit.jpg";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.786047 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0330054 * safezoneH;
		};
		class MGMTFA_BUTTONACTUALBUTTONPUBLICBUSEXITVEHICLE: MGMTFA_TEMPLATEACTUALBUTTON
		{
			idc = -1;
			tooltip = "NOT IMPLEMENTED: BUS - EXIT VEHICLE";
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnExit.jpg";
			action = "CloseDialog 0;_null=[]execVM ""custom\mgmTfA\mgmTfA_c_BU_scr_exitVehicle.sqf""";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.786047 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0330054 * safezoneH;
		};
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////
		// column: Fixed Destination Taxi	// button: Pay Service Fee
		class MGMTFA_BUTTONPICFIXEDDESTINATIONTAXIPAYSERVICEFEE: MGMTFA_TEMPLATEBUTTONPIC
		{
			idc = -1;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnPayNow.jpg";
			x = 0.634062 * safezoneW + safezoneX;
			y = 0.555009 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.0770126 * safezoneH;
		};
		class MGMTFA_BUTTONACTUALBUTTONFIXEDDESTINATIONTAXIPAYSERVICEFEE: MGMTFA_TEMPLATEACTUALBUTTON
		{
			idc = -1;
			tooltip = "PAY NOW";
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnPayNow.jpg";
			action = "CloseDialog 0;_null=[]execVM ""custom\mgmTfA\mgmTfA_c_FD_scr_chargeMeServiceFee.sqf""";
			x = 0.634062 * safezoneW + safezoneX;
			y = 0.555009 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.0770126 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// column: Fixed Destination Taxi	// button: Exit Vehicle
		class MGMTFA_BUTTONPICFIXEDDESTINATIONTAXIEXITVEHICLE: MGMTFA_TEMPLATEBUTTONPIC
		{
			idc = -1;
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnExit.jpg";
			//x = 0.659844 * safezoneW + safezoneX;
			x = 0.646062 * safezoneW + safezoneX;
			//x = 0.634062 * safezoneW + safezoneX;
			y = 0.786047 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0330054 * safezoneH;
		};
		class MGMTFA_BUTTONACTUALBUTTONFIXEDDESTINATIONTAXIEXITVEHICLE: MGMTFA_TEMPLATEACTUALBUTTON
		{
			idc = -1;
			tooltip = "NOT IMPLEMENTED: FIXED DEST. TAXI - EXIT VEHICLE";
			text = "custom\mgmTfA\img\mgmTfA_c_CO_img_guibtnExit.jpg";
			action = "CloseDialog 0;_null=[]execVM ""custom\mgmTfA\mgmTfA_c_FD_scr_pleaseStopVehicle.sqf""";
			/*
			x = 0.646062 * safezoneW + safezoneX;
			y = 0.764043 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0330054 * safezoneH;
			*/
			x = 0.649531 * safezoneW + safezoneX;
			y = 0.786047 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0330054 * safezoneH;

		};
		////////////////////////////////////////////////////////
		// END: MGMTFA BUTTONS
		////////////////////////////////////////////////////////
		class MGMTFA_FOOTER: MGMTFA_FOOTEROBJECTTEMPLATE
		{
			idc = 13080;
			text = "TRANSPORT FOR ARMA by mgm";
			x = 0.206094 * safezoneW + safezoneX;
			y = 0.852058 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.0330054 * safezoneH;
		};
    };
};
// EOF