USE master;
GO

CREATE OR ALTER PROCEDURE dbo.usp_StartAllTraces
AS
BEGIN
    DECLARE @rc int, @TraceID int, @maxfilesize bigint, @FileName nvarchar(500), 
            @DateTime datetime, @on bit, @bigintfilter bigint, @intfilter int
    SET @on = 1
    SET @DateTime = NULL
    SET @maxfilesize = 20

    -----------------------------------------------
    -- Trace شماره ۱: CpuTime (فیلتر CPU >= 5000 میلی‌ثانیه)
    -----------------------------------------------
    SET @FileName = N'C:\TraceFile\CpuTime\CpuTime_' + FORMAT(GETDATE(), 'yyyy-MM-dd-HH-mm-ss') + N'_log'
    EXEC @rc = sp_trace_create @TraceID output, 2, @FileName, @maxfilesize, @DateTime
    IF (@rc = 0)
    BEGIN
        EXEC sp_trace_setevent @TraceID, 10, 9, @on
        EXEC sp_trace_setevent @TraceID, 10, 1, @on
        EXEC sp_trace_setevent @TraceID, 10, 66, @on
        EXEC sp_trace_setevent @TraceID, 10, 2, @on
        EXEC sp_trace_setevent @TraceID, 10, 3, @on
        EXEC sp_trace_setevent @TraceID, 10, 4, @on
        EXEC sp_trace_setevent @TraceID, 10, 6, @on
        EXEC sp_trace_setevent @TraceID, 10, 7, @on
        EXEC sp_trace_setevent @TraceID, 10, 8, @on
        EXEC sp_trace_setevent @TraceID, 10, 10, @on
        EXEC sp_trace_setevent @TraceID, 10, 11, @on
        EXEC sp_trace_setevent @TraceID, 10, 12, @on
        EXEC sp_trace_setevent @TraceID, 10, 13, @on
        EXEC sp_trace_setevent @TraceID, 10, 14, @on
        EXEC sp_trace_setevent @TraceID, 10, 15, @on
        EXEC sp_trace_setevent @TraceID, 10, 16, @on
        EXEC sp_trace_setevent @TraceID, 10, 17, @on
        EXEC sp_trace_setevent @TraceID, 10, 18, @on
        EXEC sp_trace_setevent @TraceID, 10, 25, @on
        EXEC sp_trace_setevent @TraceID, 10, 26, @on
        EXEC sp_trace_setevent @TraceID, 10, 31, @on
        EXEC sp_trace_setevent @TraceID, 10, 34, @on
        EXEC sp_trace_setevent @TraceID, 10, 35, @on
        EXEC sp_trace_setevent @TraceID, 10, 41, @on
        EXEC sp_trace_setevent @TraceID, 10, 48, @on
        EXEC sp_trace_setevent @TraceID, 10, 49, @on
        EXEC sp_trace_setevent @TraceID, 10, 50, @on
        EXEC sp_trace_setevent @TraceID, 10, 51, @on
        EXEC sp_trace_setevent @TraceID, 10, 60, @on
        EXEC sp_trace_setevent @TraceID, 10, 64, @on
        EXEC sp_trace_setevent @TraceID, 12, 9, @on
        EXEC sp_trace_setevent @TraceID, 12, 1, @on
        EXEC sp_trace_setevent @TraceID, 12, 3, @on
        EXEC sp_trace_setevent @TraceID, 12, 4, @on
        EXEC sp_trace_setevent @TraceID, 12, 6, @on
        EXEC sp_trace_setevent @TraceID, 12, 7, @on
        EXEC sp_trace_setevent @TraceID, 12, 8, @on
        EXEC sp_trace_setevent @TraceID, 12, 10, @on
        EXEC sp_trace_setevent @TraceID, 12, 11, @on
        EXEC sp_trace_setevent @TraceID, 12, 12, @on
        EXEC sp_trace_setevent @TraceID, 12, 13, @on
        EXEC sp_trace_setevent @TraceID, 12, 14, @on
        EXEC sp_trace_setevent @TraceID, 12, 15, @on
        EXEC sp_trace_setevent @TraceID, 12, 16, @on
        EXEC sp_trace_setevent @TraceID, 12, 17, @on
        EXEC sp_trace_setevent @TraceID, 12, 18, @on
        EXEC sp_trace_setevent @TraceID, 12, 26, @on
        EXEC sp_trace_setevent @TraceID, 12, 31, @on
        EXEC sp_trace_setevent @TraceID, 12, 35, @on
        EXEC sp_trace_setevent @TraceID, 12, 41, @on
        EXEC sp_trace_setevent @TraceID, 12, 48, @on
        EXEC sp_trace_setevent @TraceID, 12, 49, @on
        EXEC sp_trace_setevent @TraceID, 12, 50, @on
        EXEC sp_trace_setevent @TraceID, 12, 51, @on
        EXEC sp_trace_setevent @TraceID, 12, 60, @on
        EXEC sp_trace_setevent @TraceID, 12, 64, @on
        EXEC sp_trace_setevent @TraceID, 12, 66, @on

        -- نکته مهم: CPU از نوع int هست، نه bigint
        SET @intfilter = 5000
        EXEC sp_trace_setfilter @TraceID, 18, 0, 4, @intfilter -- CPU >= 5000 ms
        EXEC sp_trace_setstatus @TraceID, 1
    END

    -----------------------------------------------
    -- Trace شماره ۲: HighLogicalRead (فیلتر Reads >= 100000)
    -----------------------------------------------
    SET @FileName = N'C:\TraceFile\HighLogicalRead\HighLogicalRead_' + FORMAT(GETDATE(), 'yyyy-MM-dd-HH-mm-ss') + N'_log'
    EXEC @rc = sp_trace_create @TraceID output, 2, @FileName, @maxfilesize, @DateTime
    IF (@rc = 0)
    BEGIN
        EXEC sp_trace_setevent @TraceID, 10, 9, @on
        EXEC sp_trace_setevent @TraceID, 10, 1, @on
        EXEC sp_trace_setevent @TraceID, 10, 66, @on
        EXEC sp_trace_setevent @TraceID, 10, 2, @on
        EXEC sp_trace_setevent @TraceID, 10, 3, @on
        EXEC sp_trace_setevent @TraceID, 10, 4, @on
        EXEC sp_trace_setevent @TraceID, 10, 6, @on
        EXEC sp_trace_setevent @TraceID, 10, 7, @on
        EXEC sp_trace_setevent @TraceID, 10, 8, @on
        EXEC sp_trace_setevent @TraceID, 10, 10, @on
        EXEC sp_trace_setevent @TraceID, 10, 11, @on
        EXEC sp_trace_setevent @TraceID, 10, 12, @on
        EXEC sp_trace_setevent @TraceID, 10, 13, @on
        EXEC sp_trace_setevent @TraceID, 10, 14, @on
        EXEC sp_trace_setevent @TraceID, 10, 15, @on
        EXEC sp_trace_setevent @TraceID, 10, 16, @on
        EXEC sp_trace_setevent @TraceID, 10, 17, @on
        EXEC sp_trace_setevent @TraceID, 10, 18, @on
        EXEC sp_trace_setevent @TraceID, 10, 25, @on
        EXEC sp_trace_setevent @TraceID, 10, 26, @on
        EXEC sp_trace_setevent @TraceID, 10, 31, @on
        EXEC sp_trace_setevent @TraceID, 10, 34, @on
        EXEC sp_trace_setevent @TraceID, 10, 35, @on
        EXEC sp_trace_setevent @TraceID, 10, 41, @on
        EXEC sp_trace_setevent @TraceID, 10, 48, @on
        EXEC sp_trace_setevent @TraceID, 10, 49, @on
        EXEC sp_trace_setevent @TraceID, 10, 50, @on
        EXEC sp_trace_setevent @TraceID, 10, 51, @on
        EXEC sp_trace_setevent @TraceID, 10, 60, @on
        EXEC sp_trace_setevent @TraceID, 10, 64, @on
        EXEC sp_trace_setevent @TraceID, 12, 9, @on
        EXEC sp_trace_setevent @TraceID, 12, 1, @on
        EXEC sp_trace_setevent @TraceID, 12, 3, @on
        EXEC sp_trace_setevent @TraceID, 12, 4, @on
        EXEC sp_trace_setevent @TraceID, 12, 6, @on
        EXEC sp_trace_setevent @TraceID, 12, 7, @on
        EXEC sp_trace_setevent @TraceID, 12, 8, @on
        EXEC sp_trace_setevent @TraceID, 12, 10, @on
        EXEC sp_trace_setevent @TraceID, 12, 11, @on
        EXEC sp_trace_setevent @TraceID, 12, 12, @on
        EXEC sp_trace_setevent @TraceID, 12, 13, @on
        EXEC sp_trace_setevent @TraceID, 12, 14, @on
        EXEC sp_trace_setevent @TraceID, 12, 15, @on
        EXEC sp_trace_setevent @TraceID, 12, 16, @on
        EXEC sp_trace_setevent @TraceID, 12, 17, @on
        EXEC sp_trace_setevent @TraceID, 12, 18, @on
        EXEC sp_trace_setevent @TraceID, 12, 26, @on
        EXEC sp_trace_setevent @TraceID, 12, 31, @on
        EXEC sp_trace_setevent @TraceID, 12, 35, @on
        EXEC sp_trace_setevent @TraceID, 12, 41, @on
        EXEC sp_trace_setevent @TraceID, 12, 48, @on
        EXEC sp_trace_setevent @TraceID, 12, 49, @on
        EXEC sp_trace_setevent @TraceID, 12, 50, @on
        EXEC sp_trace_setevent @TraceID, 12, 51, @on
        EXEC sp_trace_setevent @TraceID, 12, 60, @on
        EXEC sp_trace_setevent @TraceID, 12, 64, @on
        EXEC sp_trace_setevent @TraceID, 12, 66, @on

        SET @bigintfilter = 100000
        EXEC sp_trace_setfilter @TraceID, 16, 0, 4, @bigintfilter -- Reads >= 100000
        EXEC sp_trace_setstatus @TraceID, 1
    END

    -----------------------------------------------
    -- Trace شماره ۳: LongRuningQuery (فیلتر Duration >= 5000)
    -----------------------------------------------
    SET @FileName = N'C:\TraceFile\LongRuningQuery\LongRuningQuery_' + FORMAT(GETDATE(), 'yyyy-MM-dd-HH-mm-ss') + N'_log'
    EXEC @rc = sp_trace_create @TraceID output, 2, @FileName, @maxfilesize, @DateTime
    IF (@rc = 0)
    BEGIN
        EXEC sp_trace_setevent @TraceID, 10, 9, @on
        EXEC sp_trace_setevent @TraceID, 10, 1, @on
        EXEC sp_trace_setevent @TraceID, 10, 66, @on
        EXEC sp_trace_setevent @TraceID, 10, 2, @on
        EXEC sp_trace_setevent @TraceID, 10, 3, @on
        EXEC sp_trace_setevent @TraceID, 10, 4, @on
        EXEC sp_trace_setevent @TraceID, 10, 6, @on
        EXEC sp_trace_setevent @TraceID, 10, 7, @on
        EXEC sp_trace_setevent @TraceID, 10, 8, @on
        EXEC sp_trace_setevent @TraceID, 10, 10, @on
        EXEC sp_trace_setevent @TraceID, 10, 11, @on
        EXEC sp_trace_setevent @TraceID, 10, 12, @on
        EXEC sp_trace_setevent @TraceID, 10, 13, @on
        EXEC sp_trace_setevent @TraceID, 10, 14, @on
        EXEC sp_trace_setevent @TraceID, 10, 15, @on
        EXEC sp_trace_setevent @TraceID, 10, 16, @on
        EXEC sp_trace_setevent @TraceID, 10, 17, @on
        EXEC sp_trace_setevent @TraceID, 10, 18, @on
        EXEC sp_trace_setevent @TraceID, 10, 25, @on
        EXEC sp_trace_setevent @TraceID, 10, 26, @on
        EXEC sp_trace_setevent @TraceID, 10, 31, @on
        EXEC sp_trace_setevent @TraceID, 10, 34, @on
        EXEC sp_trace_setevent @TraceID, 10, 35, @on
        EXEC sp_trace_setevent @TraceID, 10, 41, @on
        EXEC sp_trace_setevent @TraceID, 10, 48, @on
        EXEC sp_trace_setevent @TraceID, 10, 49, @on
        EXEC sp_trace_setevent @TraceID, 10, 50, @on
        EXEC sp_trace_setevent @TraceID, 10, 51, @on
        EXEC sp_trace_setevent @TraceID, 10, 60, @on
        EXEC sp_trace_setevent @TraceID, 10, 64, @on
        EXEC sp_trace_setevent @TraceID, 12, 9, @on
        EXEC sp_trace_setevent @TraceID, 12, 1, @on
        EXEC sp_trace_setevent @TraceID, 12, 3, @on
        EXEC sp_trace_setevent @TraceID, 12, 4, @on
        EXEC sp_trace_setevent @TraceID, 12, 6, @on
        EXEC sp_trace_setevent @TraceID, 12, 7, @on
        EXEC sp_trace_setevent @TraceID, 12, 8, @on
        EXEC sp_trace_setevent @TraceID, 12, 10, @on
        EXEC sp_trace_setevent @TraceID, 12, 11, @on
        EXEC sp_trace_setevent @TraceID, 12, 12, @on
        EXEC sp_trace_setevent @TraceID, 12, 13, @on
        EXEC sp_trace_setevent @TraceID, 12, 14, @on
        EXEC sp_trace_setevent @TraceID, 12, 15, @on
        EXEC sp_trace_setevent @TraceID, 12, 16, @on
        EXEC sp_trace_setevent @TraceID, 12, 17, @on
        EXEC sp_trace_setevent @TraceID, 12, 18, @on
        EXEC sp_trace_setevent @TraceID, 12, 26, @on
        EXEC sp_trace_setevent @TraceID, 12, 31, @on
        EXEC sp_trace_setevent @TraceID, 12, 35, @on
        EXEC sp_trace_setevent @TraceID, 12, 41, @on
        EXEC sp_trace_setevent @TraceID, 12, 48, @on
        EXEC sp_trace_setevent @TraceID, 12, 49, @on
        EXEC sp_trace_setevent @TraceID, 12, 50, @on
        EXEC sp_trace_setevent @TraceID, 12, 51, @on
        EXEC sp_trace_setevent @TraceID, 12, 60, @on
        EXEC sp_trace_setevent @TraceID, 12, 64, @on
        EXEC sp_trace_setevent @TraceID, 12, 66, @on

        SET @bigintfilter = 5000
        EXEC sp_trace_setfilter @TraceID, 13, 0, 4, @bigintfilter -- Duration >= 5000
        EXEC sp_trace_setstatus @TraceID, 1
    END

    -----------------------------------------------
    -- Trace شماره ۴: RowCount (فیلتر RowCounts >= 100000)
    -----------------------------------------------
    SET @FileName = N'C:\TraceFile\RowCount\RowCount_' + FORMAT(GETDATE(), 'yyyy-MM-dd-HH-mm-ss') + N'_log'
    EXEC @rc = sp_trace_create @TraceID output, 2, @FileName, @maxfilesize, @DateTime
    IF (@rc = 0)
    BEGIN
        EXEC sp_trace_setevent @TraceID, 10, 9, @on
        EXEC sp_trace_setevent @TraceID, 10, 1, @on
        EXEC sp_trace_setevent @TraceID, 10, 66, @on
        EXEC sp_trace_setevent @TraceID, 10, 2, @on
        EXEC sp_trace_setevent @TraceID, 10, 3, @on
        EXEC sp_trace_setevent @TraceID, 10, 4, @on
        EXEC sp_trace_setevent @TraceID, 10, 6, @on
        EXEC sp_trace_setevent @TraceID, 10, 7, @on
        EXEC sp_trace_setevent @TraceID, 10, 8, @on
        EXEC sp_trace_setevent @TraceID, 10, 10, @on
        EXEC sp_trace_setevent @TraceID, 10, 11, @on
        EXEC sp_trace_setevent @TraceID, 10, 12, @on
        EXEC sp_trace_setevent @TraceID, 10, 13, @on
        EXEC sp_trace_setevent @TraceID, 10, 14, @on
        EXEC sp_trace_setevent @TraceID, 10, 15, @on
        EXEC sp_trace_setevent @TraceID, 10, 16, @on
        EXEC sp_trace_setevent @TraceID, 10, 17, @on
        EXEC sp_trace_setevent @TraceID, 10, 18, @on
        EXEC sp_trace_setevent @TraceID, 10, 25, @on
        EXEC sp_trace_setevent @TraceID, 10, 26, @on
        EXEC sp_trace_setevent @TraceID, 10, 31, @on
        EXEC sp_trace_setevent @TraceID, 10, 34, @on
        EXEC sp_trace_setevent @TraceID, 10, 35, @on
        EXEC sp_trace_setevent @TraceID, 10, 41, @on
        EXEC sp_trace_setevent @TraceID, 10, 48, @on
        EXEC sp_trace_setevent @TraceID, 10, 49, @on
        EXEC sp_trace_setevent @TraceID, 10, 50, @on
        EXEC sp_trace_setevent @TraceID, 10, 51, @on
        EXEC sp_trace_setevent @TraceID, 10, 60, @on
        EXEC sp_trace_setevent @TraceID, 10, 64, @on
        EXEC sp_trace_setevent @TraceID, 12, 9, @on
        EXEC sp_trace_setevent @TraceID, 12, 1, @on
        EXEC sp_trace_setevent @TraceID, 12, 3, @on
        EXEC sp_trace_setevent @TraceID, 12, 4, @on
        EXEC sp_trace_setevent @TraceID, 12, 6, @on
        EXEC sp_trace_setevent @TraceID, 12, 7, @on
        EXEC sp_trace_setevent @TraceID, 12, 8, @on
        EXEC sp_trace_setevent @TraceID, 12, 10, @on
        EXEC sp_trace_setevent @TraceID, 12, 11, @on
        EXEC sp_trace_setevent @TraceID, 12, 12, @on
        EXEC sp_trace_setevent @TraceID, 12, 13, @on
        EXEC sp_trace_setevent @TraceID, 12, 14, @on
        EXEC sp_trace_setevent @TraceID, 12, 15, @on
        EXEC sp_trace_setevent @TraceID, 12, 16, @on
        EXEC sp_trace_setevent @TraceID, 12, 17, @on
        EXEC sp_trace_setevent @TraceID, 12, 18, @on
        EXEC sp_trace_setevent @TraceID, 12, 26, @on
        EXEC sp_trace_setevent @TraceID, 12, 31, @on
        EXEC sp_trace_setevent @TraceID, 12, 35, @on
        EXEC sp_trace_setevent @TraceID, 12, 41, @on
        EXEC sp_trace_setevent @TraceID, 12, 48, @on
        EXEC sp_trace_setevent @TraceID, 12, 49, @on
        EXEC sp_trace_setevent @TraceID, 12, 50, @on
        EXEC sp_trace_setevent @TraceID, 12, 51, @on
        EXEC sp_trace_setevent @TraceID, 12, 60, @on
        EXEC sp_trace_setevent @TraceID, 12, 64, @on
        EXEC sp_trace_setevent @TraceID, 12, 66, @on

        SET @bigintfilter = 100000
        EXEC sp_trace_setfilter @TraceID, 48, 0, 4, @bigintfilter -- RowCounts >= 100000
        EXEC sp_trace_setstatus @TraceID, 1
    END
END
GO
