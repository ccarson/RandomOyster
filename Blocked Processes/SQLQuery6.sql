CREATE EVENT SESSION [BlockingTransactions] ON SERVER 
ADD EVENT sqlserver.lock_timeout_greater_than_0(SET collect_database_name=(1),collect_resource_description=(0)
    ACTION(package0.collect_system_time,sqlserver.database_name,sqlserver.nt_username,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text,sqlserver.tsql_stack)),
ADD EVENT sqlserver.locks_lock_waits(
    ACTION(sqlserver.sql_text,sqlserver.tsql_stack)) 
ADD TARGET package0.ring_buffer
WITH ( MAX_DISPATCH_LATENCY=30 SECONDS, STARTUP_STATE = ON )
GO

