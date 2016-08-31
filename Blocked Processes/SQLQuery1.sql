USE AdventureWorks2014
GO

CREATE QUEUE	BlockedProcessReportQueue ; 
GO

CREATE SERVICE	BlockedProcessReportService
ON QUEUE		BlockedProcessReportQueue( [http://schemas.microsoft.com/SQL/Notifications/PostEventNotification] ) ; 
GO

CREATE ROUTE	BlockedProcessReportRoute
WITH SERVICE_NAME = 'BlockedProcessReportService', ADDRESS = 'LOCAL' ; 
GO

CREATE EVENT NOTIFICATION BlockedProcessReport 
ON SERVER WITH FAN_IN
FOR BLOCKED_PROCESS_REPORT
TO SERVICE 'BlockedProcessReportService', 'current database' ;