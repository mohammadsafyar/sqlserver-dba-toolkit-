# SQL Server Trace

This directory contains scripts for creating, configuring, starting, verifying, and removing SQL Server Trace sessions.

## Scripts

The scripts should be executed in the following order:

```text
01 → 02 → 03
```

| File                                        | Description                                                                      |
| ------------------------------------------- | -------------------------------------------------------------------------------- |
| `01-create-trace-procedure.sql`             | Creates the `usp_StartAllTraces` stored procedure and configures the four traces |
| `02-configure-startup-and-start-traces.sql` | Configures the procedure as a Startup Procedure and starts all traces            |
| `03-verify-and-cleanup-traces.sql`          | Verifies trace status and provides commands to stop and remove traces            |

---

## Trace Configuration

The `usp_StartAllTraces` procedure creates four independent SQL Server traces.

| Trace              | Purpose                                  |    Threshold |
| ------------------ | ---------------------------------------- | -----------: |
| `CpuTime`          | Detect queries with high CPU consumption | `>= 5000 ms` |
| `HighLogicalRead`  | Detect queries with high logical reads   |  `>= 100000` |
| `LongRunningQuery` | Detect long-running queries              |    `>= 5000` |
| `RowCount`         | Detect queries with high row counts      |  `>= 100000` |

Each trace uses a maximum file size of **20 MB**.

### Trace File Locations

```text
C:\TraceFile\
├── CpuTime\
├── HighLogicalRead\
├── LongRuningQuery\
└── RowCount\
```

> The SQL Server service account must have write permissions on these directories.

---

# Installation

## Step 1 — Create the Trace Procedure

Run:

```text
01-create-trace-procedure.sql
```

This script creates the following stored procedure in the `master` database:

```sql
master.dbo.usp_StartAllTraces
```

The procedure contains the configuration for all four traces, including:

* Trace Events
* Trace Columns
* Trace Filters
* Trace File Paths
* Maximum File Size
* Trace Start

---

## Step 2 — Configure Startup and Start Traces

Run:

```text
02-configure-startup-and-start-traces.sql
```

This script performs the following actions:

1. Enables Advanced Options.
2. Enables `scan for startup procs`.
3. Registers `usp_StartAllTraces` as a Startup Procedure.
4. Executes `usp_StartAllTraces` to start the traces immediately.

The Startup Procedure configuration only needs to be performed once.

After a SQL Server service restart, SQL Server automatically executes:

```sql
master.dbo.usp_StartAllTraces
```

and the configured traces are recreated and started automatically.

---

## Step 3 — Verify Traces

Run:

```text
03-verify-and-cleanup-traces.sql
```

Use the verification section to check the Trace status:

```sql
SELECT
    id,
    status,
    path,
    max_size,
    start_time,
    last_event_time
FROM sys.traces
WHERE is_default = 0
ORDER BY id;
```

### Trace Status

| Status | Description |
| -----: | ----------- |
|    `0` | Stopped     |
|    `1` | Running     |

After successful installation, the configured traces should have:

```text
status = 1
```

---

# Trace Operations

## Start Traces

To manually start the configured traces:

```sql
EXEC master.dbo.usp_StartAllTraces;
```

> **Warning:** Every execution of `usp_StartAllTraces` creates new Trace instances. Do not execute the procedure repeatedly without checking the existing traces first.

---

## Stop a Trace

To stop a specific Trace:

```sql
EXEC sp_trace_setstatus
    @traceid = <TraceID>,
    @status = 0;
```

Replace `<TraceID>` with the Trace ID returned by `sys.traces`.

---

## Remove a Trace

To close and remove a specific Trace:

```sql
EXEC sp_trace_setstatus
    @traceid = <TraceID>,
    @status = 2;
```

The status values are:

```text
0 = Stop
2 = Close and Remove
```

---

# Cleanup

The cleanup section in:

```text
03-verify-and-cleanup-traces.sql
```

can be used to stop and remove the configured traces.

Before running the cleanup section in Production, verify the existing Trace sessions:

```sql
SELECT
    id,
    status,
    path
FROM sys.traces
WHERE is_default = 0
ORDER BY id;
```

> **Warning:** The current cleanup logic targets all non-default traces. Make sure there are no other non-default traces running on the server before executing it.

---

# Startup Procedure

The Startup Procedure configuration is:

```sql
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'scan for startup procs', 1;
RECONFIGURE;

EXEC sp_procoption
    @ProcName = 'usp_StartAllTraces',
    @OptionName = 'startup',
    @OptionValue = 'on';
```

This configuration is required only once.

Once enabled, SQL Server automatically executes `usp_StartAllTraces` when the SQL Server service starts.

---

# Trace Events

The traces capture events for:

```text
SQL:BatchCompleted
RPC:Completed
```

The configured columns provide information such as:

* SQL Text
* Database
* Login
* Host
* Application
* CPU
* Logical Reads
* Writes
* Duration
* Row Count
* Start Time
* End Time
* SPID

These values can be used to identify queries that exceed the configured resource thresholds.

---

# Troubleshooting

## No Trace Is Created

Check that the Trace directories exist:

```text
C:\TraceFile\CpuTime\
C:\TraceFile\HighLogicalRead\
C:\TraceFile\LongRuningQuery\
C:\TraceFile\RowCount\
```

Also verify that the SQL Server service account has write permission to these directories.

---

## Traces Are Not Running After Restart

Check the Startup Procedure configuration:

```sql
EXEC sp_configure 'scan for startup procs';
```

The expected value is:

```text
1
```

Also verify that the procedure exists in the `master` database:

```sql
SELECT
    OBJECT_ID('master.dbo.usp_StartAllTraces') AS ProcedureID;
```

---

## Multiple Trace Instances Exist

Check the current traces:

```sql
SELECT
    id,
    status,
    path,
    start_time
FROM sys.traces
WHERE is_default = 0
ORDER BY id;
```

If duplicate traces exist, identify the correct Trace IDs before performing cleanup.

---

# Production Considerations

SQL Trace is a legacy/deprecated SQL Server technology.

For new monitoring implementations, **Extended Events** is the recommended technology.

This implementation can still be useful for existing environments where SQL Trace is already required or where compatibility with an existing operational process is necessary.

The following items should be monitored:

* Trace file size
* Disk space
* Number of active traces
* Trace overhead
* Trace file retention
* SQL Server performance impact

---

# Quick Reference

| Task              | Script / Command                                |
| ----------------- | ----------------------------------------------- |
| Create Procedure  | `01-create-trace-procedure.sql`                 |
| Configure Startup | `02-configure-startup-and-start-traces.sql`     |
| Verify Traces     | `03-verify-and-cleanup-traces.sql`              |
| Manual Start      | `EXEC master.dbo.usp_StartAllTraces`            |
| Check Traces      | `SELECT * FROM sys.traces WHERE is_default = 0` |
| Stop Trace        | `sp_trace_setstatus @status = 0`                |
| Remove Trace      | `sp_trace_setstatus @status = 2`                |

## Execution Flow

```text
01-create-trace-procedure.sql
             │
             ▼
02-configure-startup-and-start-traces.sql
             │
             ▼
       Four Traces Running
             │
             ▼
03-verify-and-cleanup-traces.sql
             │
       ┌─────┴─────┐
       ▼           ▼
    Verify       Cleanup
```

