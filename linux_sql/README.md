# Linux Monitoring Agent

## Introduction

This project is a Linux Monitoring Agent designed to collect real-time hardware and system usage metrics from a Linux host and persist them into a PostgreSQL database. It enables centralized monitoring of server performance across multiple machines. The primary users are system administrators and DevOps teams who need to track CPU load, memory availability, disk space, and system activity.

The agent captures data every minute using a Bash script scheduled via `crontab`. It supports scalable deployment and provides a lightweight and efficient solution to gather server health data. Key technologies used include Bash for scripting, PostgreSQL for data storage, Git for version control, and crontab for automation.

## Quick Start

> All scripts assume you're in the `linux_sql/scripts` directory of your project.

### 1. Start the PostgreSQL Docker container

```bash
./psql_docker.sh create postgres rocky1234
./psql_docker.sh start
Create database and tables
psql -h localhost -U postgres -d host_agent -f ../sql/ddl.sql
 Insert host hardware specification
./host_info.sh localhost 5432 host_agent postgres rocky1234
Insert system usage
./host_usage.sh localhost 5432 host_agent postgres rocky1234
 Set up crontab to automate data collection every minute
crontab -e
# Add the following line (update path as needed)
* * * * * /home/rocky/dev/jarvis_data_eng_SupriyaRavichandran/linux_sql/scripts/host_usage.sh localhost 5432 host_agent postgres rocky1234 > /tmp/host_usage.log 2>&1
Implementation
Architecture
The architecture includes three Linux machines each running a monitoring agent that connects to a central PostgreSQL server. The agents run on their local crontabs and send data to the DB every minute.
See diagram: assets/linux_monitoring_architecture.png

Scripts
psql_docker.sh
Manages PostgreSQL via Docker
Usage:
./psql_docker.sh create postgres rocky1234
./psql_docker.sh start
host_info.sh
Gathers host-level static hardware details
Inserts data into host_info table
Usage:
./host_info.sh localhost 5432 host_agent postgres rocky1234
host_usage.sh
Collects dynamic metrics like memory, CPU, and disk I/O
Inserts data into host_usage table
Usage: ./host_usage.sh localhost 5432 host_agent postgres rocky1234
crontab
Automates host_usage.sh execution every minute
Ensures continuous data flow for monitoring
queries.sql
Database Modeling
host_info

| Column            | Type      | Description                     |
|-------------------|-----------|---------------------------------|
| id                | SERIAL    | Primary key                     |
| hostname          | TEXT      | Unique server hostname          |
| cpu_number        | INT       | Number of CPUs                  |
| cpu_architecture  | TEXT      | CPU architecture type           |
| cpu_model         | TEXT      | CPU model name                  |
| cpu_mhz           | FLOAT     | CPU speed in MHz                |
| l2_cache          | INT       | L2 cache size (KB)              |
| total_mem         | INT       | Total memory available (KB)     |
| timestamp         | TIMESTAMP | Time of data collection         |
host_usage
| Column         | Type      | Description                            |
|----------------|-----------|----------------------------------------|
| timestamp      | TIMESTAMP | Time when usage was recorded           |
| host_id        | INT       | Foreign key referencing `host_info.id` |
| memory_free    | INT       | Free memory in KB                      |
| cpu_idle       | FLOAT     | CPU idle percentage                    |
| cpu_kernel     | FLOAT     | CPU kernel mode usage percentage       |
| disk_io        | INT       | Disk I/O usage                         |
| disk_available | INT       | Available disk space in MB             |

Test
All scripts were manually tested using the following method:

Ran each script from terminal with correct arguments

Verified expected data was inserted into the database via SQL queries

Debugged cron job using output from /tmp/host_usage.log

Successful entries appeared in host_info and host_usage tables without error.

Deployment
This app was deployed and automated using:

Git (branch: feature/monitoring_agent)

crontab to automate metrics collection

PostgreSQL running inside a Docker container

Improvements
Add alerting mechanism when thresholds are breached (e.g., memory < 100MB)

Improve logging and error handling in shell scripts

Implement support for collecting network usage statistics
