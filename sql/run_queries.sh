#!/bin/bash
#
# Converts BigQuery SQL to JSON.
#
# Usage: `sql/run_queries.sh <sql-directory>`
#
# For example:
#
#     sql/run_queries.sh sql/2019
#
# This will run all 2019 queries.
# You could provide the path to a specific sql file to run only that query.

set -o pipefail

DIRECTORY=$1
BQ_CMD="bq --format prettyjson --project_id httparchive query --max_rows 1000000"

for sql in $(find "$DIRECTORY" | grep \.sql); do
  echo "Querying $sql"
  metric=$(echo "$sql" | cut -d"." -f1)
  $BQ_CMD < "$sql" | sed '/^$/d' > "$metric".json
  result=$?
  # Make sure the query succeeded.
  if [ $result -ne 0 ]; then
    echo "Error querying $sql"
    exit 1
  fi
done

echo "Done!"