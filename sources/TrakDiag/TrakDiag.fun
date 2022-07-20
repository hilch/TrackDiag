
FUNCTION_BLOCK TD_CrashReport (*read all data from a logger entry*)
	VAR_INPUT
		Execute : BOOL;
		pLoggerEntries : {REDUND_UNREPLICABLE} UDINT; (*pointer to TD_LoggerEntryType[]*)
		SizeLoggerEntries : UDINT; (*sizeof TD_LoggerEntryType[]*)
		thrSeverity : USINT; (*severity threshold [0-3]*)
		objectStartsWith1 : STRING[5]; (*filter objects whose names begin like this*)
		objectStartsWith2 : STRING[5]; (*filter objects whose names begin like this*)
		observationPeriod : {REDUND_UNREPLICABLE} TIME;
	END_VAR
	VAR_OUTPUT
		MaxEntries : UINT; (*max number of entries possible in TD_LoggerEntryType[]*)
		NbrOfEntries : UINT; (*no of entries in TD_LoggerEntryType[]*)
		Done : BOOL;
		Busy : BOOL;
		Error : BOOL;
		StatusID : DINT;
	END_VAR
	VAR
		step : UINT;
		index : UINT; (*current index in list*)
		fbGetIdent : ArEventLogGetIdent;
		fbGetPreviousRecordID : ArEventLogGetPreviousRecordID;
		fbGetLatestRecordID : ArEventLogGetLatestRecordID;
		fbDTGetTime : DTGetTime;
		fbReadEntry : TD_LoggerReadEntry;
		tonDelayRead : TON;
		eventTimeMinimum : DATE_AND_TIME; (*ignore entries before this time*)
		counterEntries : UDINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK TD_Logger (*read all data from a logger entry*)
	VAR_INPUT
		Enable : BOOL;
		pLoggerEntries : {REDUND_UNREPLICABLE} UDINT; (*pointer to TD_LoggerEntryType[]*)
		SizeLoggerEntries : UDINT; (*sizeof TD_LoggerEntryType[]*)
		thrSeverity : USINT; (*severity threshold [0-3]*)
		objectStartsWith1 : STRING[5]; (*filter objects whose names begin like this*)
		objectStartsWith2 : STRING[5]; (*filter objects whose names begin like this*)
		eventTimeMinimum : DATE_AND_TIME; (*ignore entries before this time*)
	END_VAR
	VAR_OUTPUT
		MaxEntries : UINT; (*max number of entries possible in TD_LoggerEntryType[]*)
		NbrOfEntries : UINT; (*no of entries in TD_LoggerEntryType[]*)
		LatestRecordID : ArEventLogRecordIDType;
		Valid : BOOL;
		Busy : BOOL;
		Error : BOOL;
		StatusID : DINT;
	END_VAR
	VAR
		step : UINT;
		index : UINT; (*current index in list*)
		msOld : TIME;
		fbGetIdent : ArEventLogGetIdent;
		fbGetPreviousRecordID : ArEventLogGetPreviousRecordID;
		fbGetLatestRecordID : ArEventLogGetLatestRecordID;
		fbReadEntry : TD_LoggerReadEntry;
		LatestRecordID_Old : ArEventLogRecordIDType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK TD_LoggerReadEntry (*read motion logger cyclically*)
	VAR_INPUT
		Execute : BOOL;
		Ident : ArEventLogIdentType;
		RecordID : ArEventLogRecordIDType;
	END_VAR
	VAR_OUTPUT
		Entry : TD_LoggerEntryType; (*TD_LoggerEntryType*)
		Done : BOOL;
		Error : BOOL;
		StatusID : DINT;
	END_VAR
	VAR
		fbRead : ArEventLogRead;
		fbReadDescription : ArEventLogReadDescription;
		fbReadObjectID : ArEventLogReadObjectID;
		fbUtcToLocalTime : UtcDT_TO_LocalDTStructure;
		UtcToLocalTime_Done : BOOL;
		LocalTimeDTStructure : DTStructure;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION TD_ascDT : BOOL (*returns ASCII timestring for ArEventLogTimeStampType*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		DT1 : DATE_AND_TIME;
		pString : UDINT; (*pointer to output string*)
		maxSize : USINT; (*max length of output string*)
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION TD_filenameDT : UINT (*returns a filename with DT included*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		prefix : UDINT; (*pointer to prefix string (input)*)
		pString : UDINT; (*pointer to output string*)
		maxSize : USINT; (*max length of output string*)
	END_VAR
END_FUNCTION

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK TD_LogWrite (*Write into Logger*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Execute : {REDUND_UNREPLICABLE} BOOL;
		Name : {REDUND_UNREPLICABLE} STRING[10];
		EventID : {REDUND_UNREPLICABLE} DINT;
		ObjectID : {REDUND_UNREPLICABLE} STRING[36];
		Ascii : {REDUND_UNREPLICABLE} STRING[80];
	END_VAR
	VAR_OUTPUT
		Done : {REDUND_UNREPLICABLE} BOOL;
		Busy : {REDUND_UNREPLICABLE} BOOL;
		Error : {REDUND_UNREPLICABLE} BOOL;
		StatusID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR
		fbLogCreate : {REDUND_UNREPLICABLE} ArEventLogCreate;
		fbLogGetIdent : {REDUND_UNREPLICABLE} ArEventLogGetIdent;
		fbLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite;
		step : {REDUND_UNREPLICABLE} UINT;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK TD_LogWatchBOOL (*Write status of BOOL variable into log*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		Signal : {REDUND_UNREPLICABLE} BOOL;
		LogName : {REDUND_UNREPLICABLE} STRING[10];
		SignalName : {REDUND_UNREPLICABLE} STRING[36];
		EventID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR_OUTPUT
		Valid : {REDUND_UNREPLICABLE} BOOL;
		Busy : {REDUND_UNREPLICABLE} BOOL;
		Error : {REDUND_UNREPLICABLE} BOOL;
		StatusID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR
		signalOld : {REDUND_UNREPLICABLE} BOOL;
		step : {REDUND_UNREPLICABLE} UINT;
		fbLogWrite : {REDUND_UNREPLICABLE} TD_LogWrite;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK TD_LogWatch8Flags (*Write status of 8 flags variable into log*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		Signal : {REDUND_UNREPLICABLE} USINT;
		LogName : {REDUND_UNREPLICABLE} STRING[10];
		SignalName : {REDUND_UNREPLICABLE} STRING[36];
		EventID : {REDUND_UNREPLICABLE} DINT;
		Flag : {REDUND_UNREPLICABLE} ARRAY[0..7] OF STRING[8];
	END_VAR
	VAR_OUTPUT
		Valid : {REDUND_UNREPLICABLE} BOOL;
		Busy : {REDUND_UNREPLICABLE} BOOL;
		Error : {REDUND_UNREPLICABLE} BOOL;
		StatusID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR
		signalOld : {REDUND_UNREPLICABLE} USINT;
		step : {REDUND_UNREPLICABLE} UINT;
		fbLogWrite : {REDUND_UNREPLICABLE} TD_LogWrite;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK TD_LogWatchDINT (*Write status of DINT variable into log*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		Signal : {REDUND_UNREPLICABLE} DINT;
		LogName : {REDUND_UNREPLICABLE} STRING[10];
		SignalName : {REDUND_UNREPLICABLE} STRING[36];
		EventID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR_OUTPUT
		Valid : {REDUND_UNREPLICABLE} BOOL;
		Busy : {REDUND_UNREPLICABLE} BOOL;
		Error : {REDUND_UNREPLICABLE} BOOL;
		StatusID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR
		signalOld : {REDUND_UNREPLICABLE} DINT;
		step : {REDUND_UNREPLICABLE} UINT;
		fbLogWrite : {REDUND_UNREPLICABLE} TD_LogWrite;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK TD_LogWatchSTRING (*Write contents of STRING variable into log*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		Signal : {REDUND_UNREPLICABLE} STRING[80];
		LogName : {REDUND_UNREPLICABLE} STRING[10];
		SignalName : {REDUND_UNREPLICABLE} STRING[36];
		EventID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR_OUTPUT
		Valid : {REDUND_UNREPLICABLE} BOOL;
		Busy : {REDUND_UNREPLICABLE} BOOL;
		Error : {REDUND_UNREPLICABLE} BOOL;
		StatusID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR
		signalOld : {REDUND_UNREPLICABLE} STRING[80];
		step : {REDUND_UNREPLICABLE} UINT;
		fbLogWrite : {REDUND_UNREPLICABLE} TD_LogWrite;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK TD_SegCommandError (*Simulate Segment Error*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Segment : REFERENCE TO McSegmentType;
		Execute : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		Done : {REDUND_UNREPLICABLE} BOOL;
		Busy : {REDUND_UNREPLICABLE} BOOL;
		Error : {REDUND_UNREPLICABLE} BOOL;
		StatusID : {REDUND_UNREPLICABLE} DINT;
	END_VAR
	VAR
		fbSegCommandError : MC_BR_SegCommandError_AcpTrak;
		fbSegPowerOn : MC_BR_SegPowerOn_AcpTrak;
		step : UINT;
	END_VAR
END_FUNCTION_BLOCK
