USE master;
GO

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'scan for startup procs', 1;
RECONFIGURE;

EXEC sp_procoption
    @ProcName = 'usp_StartAllTraces',
    @OptionName = 'startup',
    @OptionValue = 'on';
GO
