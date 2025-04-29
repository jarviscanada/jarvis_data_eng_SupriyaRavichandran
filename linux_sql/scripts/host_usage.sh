#!/bin/bash

# Script usage: bash scripts/host_usage.sh psql_host psql_port db_name psql_user psql_password

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

# Check number of arguments
if [ "$#" -ne 5 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

# Retrieve system statistics
vmstat_mb=$(vmstat --unit M)
hostname=$(hostname -f)

# Parse stats from vmstat
memory_free=$(echo "$vmstat_mb" | awk '{print $4}' | tail -n1 | xargs)
cpu_idle=$(echo "$vmstat_mb" | awk '{print $15}' | tail -n1 | xargs)
cpu_kernel=$(echo "$vmstat_mb" | awk '{print $14}' | tail -n1 | xargs)
disk_io=$(vmstat -d | awk '{print $10}' | tail -n1 | xargs)

# Get current time
timestamp=$(date -u +"%Y-%m-%d %H:%M:%S")

# Subquery to find matching id in host_info table
host_id="(SELECT id FROM host_info WHERE hostname='$hostname')"

# Construct SQL query to insert usage data
insert_stmt="INSERT INTO host_usage (timestamp, memory_free, cpu_idle, cpu_kernel, disk_io, host_id)
VALUES ('$timestamp', '$memory_free', '$cpu_idle', '$cpu_kernel', '$disk_io', $host_id);"

# Insert data into PostgreSQL
export PGPASSWORD=$psql_password
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"

exit $?
