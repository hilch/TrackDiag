
TYPE
	TD_LoggerEntryType : 	STRUCT 
		RecordID : ArEventLogRecordIDType;
		OriginRecordID : ArEventLogRecordIDType;
		EventID : DINT;
		Severity : USINT;
		ObjectID : STRING[36];
		Description : STRING[80];
		TimeStamp : ArEventLogTimeStampType; (*Timestamp UTC + nanoseconds*)
		LocalTime : DATE_AND_TIME; (*local time*)
	END_STRUCT;
END_TYPE
