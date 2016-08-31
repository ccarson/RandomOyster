ALTER QUEUE BlockedProcessReportQueue
WITH ACTIVATION( 
		STATUS = ON
	  , PROCEDURE_NAME = dbo.ProcessBlockedProcessReports
	  , MAX_QUEUE_READERS = 1 
	  , EXECUTE AS OWNER ) ; 
GO
 