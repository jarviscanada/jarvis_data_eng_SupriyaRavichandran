#!/bin/bash

# Assign CLI arguments to variables
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

# Validate the number of arguments
if [ "$#" -ne 5 ]; then
  echo "Illegal number of parameters"
  echo "Usage: ./scripts/host_info.sh psql_host psql_port db_name psql_user psql_password"
  exit 1
fi
# Parse hardware specifications
cpu_info=$(lscpu)
cpu_model=$(echo "$cpu_info" | grep "Model name" | awk -F: '{print $2}' | xargs)
cpu_cores=$(echo "$cpu_info" | grep "^CPU(s):" | awk -F: '{print $2}' | xargs)

memory_info=$(free -m)
total_memory=$(echo "$memory_info" | grep Mem | awk '{print $2}')
free_memory=$(echo "$memory_info" | grep Mem | awk '{print $4}')

disk_info=$(df -BM /)
disk_total=$(echo "$disk_info" | awk 'NR==2 {print $2}' | sed 's/M//')
disk_free=$(echo "$disk_info" | awk 'NR==2 {print $4}' | sed 's/M//')

hostname=$(hostname -f)

# Construct SQL insert statement
insert_stmt="INSERT INTO host_info (hostname, cpu_model, cpu_cores, total_memory, free_memory, disk_total, disk_free) VALUES ('$hostname', '$cpu_model', '$cpu_cores', '$total_memory', '$free_memory', '$disk_total', '$disk_free');"

# Execute PSQL command to insert the data
export PGPASSWORD=$psql_password
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?