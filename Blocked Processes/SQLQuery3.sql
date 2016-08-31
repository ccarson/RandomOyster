USE AdventureWorks2014
GO

CREATE CERTIFICATE DatabaseMailCertificate
ENCRYPTION BY PASSWORD = 'P@SSw0rd'
WITH SUBJECT = 'Database Mail Certificate' ;
GO

BACKUP CERTIFICATE DatabaseMailCertificate
TO FILE = 'F:\MSSQL\SQL2014\Backup\DatabaseMailCertificate.CER' ; 
GO

USE master
GO

CREATE CERTIFICATE DatabaseMailCertificate
FROM FILE = 'F:\MSSQL\SQL2014\Backup\DatabaseMailCertificate.CER' ; 
GO

CREATE LOGIN DatabaseMailLogin
FROM CERTIFICATE DatabaseMailCertificate ;
GO

GRANT AUTHENTICATE SERVER TO DatabaseMailLogin
GO

USE msdb
GO

CREATE USER DatabaseMailLogin FROM LOGIN DatabaseMailLogin
GO

EXECUTE
	sp_addrolemember
		@rolename = 'DatabaseMailUserRole', @membername = 'DatabaseMailLogin' ; 
GO