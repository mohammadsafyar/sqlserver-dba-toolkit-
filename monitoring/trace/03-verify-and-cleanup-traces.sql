-- Start all configured traces
EXEC master.dbo.usp_StartAllTraces;


-- Verify that the traces are running
SELECT *
FROM sys.traces
WHERE is_default = 0;


-- Stop and remove all non-default traces
DECLARE @TraceID INT;

DECLARE trace_cursor CURSOR FOR
SELECT id
FROM sys.traces
WHERE is_default = 0;

OPEN trace_cursor;

FETCH NEXT FROM trace_cursor INTO @TraceID;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Stop the trace
    EXEC sp_trace_setstatus @TraceID, 0;

    -- Close and remove the trace
    EXEC sp_trace_setstatus @TraceID, 2;

    PRINT 'Trace '
        + CAST(@TraceID AS VARCHAR(10))
        + ' stopped and removed';

    FETCH NEXT FROM trace_cursor INTO @TraceID;
END;

CLOSE trace_cursor;
DEALLOCATE trace_cursor;
