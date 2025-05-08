# Linux Monitoring Agent

## Introduction

This project is a Linux Monitoring Agent designed to collect real-time hardware and system usage metrics from a Linux host and persist them into a PostgreSQL database. It enables centralized monitoring of server performance across multiple machines, making it useful for system administrators and DevOps teams.

## Features

* Collects hardware specifications (static data) using `host_info.sh`.
* Gathers real-time usage metrics (dynamic data) using `host_usage.sh`.
* Data is persisted in a PostgreSQL database.
* Uses Docker to run PostgreSQL in a container.
* Automates data collection every minute using `crontab`.

## Architecture

The monitoring agent follows a client-server model:

* Multiple Linux servers run the monitoring agent scripts (`host_info.sh` and `host_usage.sh`).
* A central PostgreSQL database collects and stores the data.
* Data can be analyzed using SQL queries.

## Project Structure

```
linux_sql/
├── scripts/
│   ├── host_info.sh      # Collects hardware specs
│   ├── host_usage.sh     # Collects usage metrics
│   └── psql_docker.sh    # Manages PostgreSQL Docker container
├── sql/
│   └── ddl.sql           # PostgreSQL database schema
└── assets/
    └── linux_monitoring_architecture.png # Architecture diagram
```

## Prerequisites

* Docker installed on your Linux machine
* PostgreSQL client installed (psql)
* Bash shell environment

## Quick Start

1. **Start PostgreSQL using Docker**

```bash
./scripts/psql_docker.sh create postgres your_password
./scripts/psql_docker.sh start
```

2. **Initialize Database**

```bash
psql -h localhost -U postgres -d host_agent -f sql/ddl.sql
```

3. **Collect Hardware Info (One-time)**

```bash
./scripts/host_info.sh localhost 5432 host_agent postgres your_password
```

4. **Collect Usage Data (Every minute)**

* Manually: Run the script

```bash
./scripts/host_usage.sh localhost 5432 host_agent postgres your_password
```

* Automatically: Setup crontab

```bash
crontab -e
# Add the following line
* * * * * /path/to/your/project/linux_sql/scripts/host_usage.sh localhost 5432 host_agent postgres your_password > /tmp/host_usage.log 2>&1
```

## Database Schema

### Table: host\_info

| Column            | Type      | Description             |
| ----------------- | --------- | ----------------------- |
| id                | SERIAL    | Primary key             |
| hostname          | TEXT      | Unique server hostname  |
| cpu\_number       | INT       | Number of CPUs          |
| cpu\_architecture | TEXT      | CPU architecture type   |
| cpu\_model        | TEXT      | CPU model name          |
| l2\_cache         | INT       | L2 cache size (KB)      |
| total\_mem        | INT       | Total memory (KB)       |
| timestamp         | TIMESTAMP | Time of data collection |

### Table: host\_usage

| Column          | Type      | Description                            |
| --------------- | --------- | -------------------------------------- |
| timestamp       | TIMESTAMP | Time when usage was recorded           |
| host\_id        | INT       | Foreign key referencing `host_info.id` |
| memory\_free    | INT       | Free memory in KB                      |
| cpu\_idle       | FLOAT     | CPU idle percentage                    |
| cpu\_kernel     | FLOAT     | CPU kernel mode usage percentage       |
| disk\_io        | INT       | Disk I/O usage                         |
| disk\_available | INT       | Available disk space in MB             |

## Troubleshooting

* Check Docker container logs for PostgreSQL issues:

```bash
docker logs <your_postgres_container_id>
```

* Debug cron job by checking logs:

```bash
tail -f /tmp/host_usage.log
```

## Future Improvements

* Add network usage monitoring.
* Implement alerting for resource threshold breaches.
* Enhance error handling in shell scripts.
