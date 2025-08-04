#!/usr/bin/env python

import argparse
import multiprocessing
import re
from pathlib import Path

import pandas as pd  # pylint: disable=import-error
import google.auth  # pylint: disable=import-error
from google.cloud import bigquery  # pylint: disable=import-error
from googleapiclient.discovery import build  # pylint: disable=import-error

PROJECT_ID = "httparchive"

QUERY_PARAMETERS = [
    # The date of the crawl used for the analysis.
    bigquery.ScalarQueryParameter(
        "date",
        "DATE",
        "2025-07-01",
    ),
    # A set of dates for queries studying trends over time.
    bigquery.ArrayQueryParameter(
        "dates",
        "DATE",
        ["2022-07-01", "2023-07-01", "2024-07-01", "2025-07-01"],
    ),
    # The number of digits after the decimal point for formatting proportions.
    bigquery.ScalarQueryParameter(
        "precision",
        "INT64",
        4,
    ),
]

# The spreadsheet with results for the corresponding edition.
SPREADSHEET_ID = "1otdu4p_CCI70B4FVzw6k02frStsPMrQoFu7jUim_0Bg"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("path", nargs="*", default=["*/*.sql"])
    parser.add_argument("--no-dry-run", action="store_true")
    arguments = parser.parse_args()

    paths = list(path for path in arguments.path for path in Path(".").glob(path))
    width = max(len(str(path)) for path in paths) + 1

    tasks = [{"path": path, "dry_run": not arguments.no_dry_run} for path in paths]
    with multiprocessing.Pool(multiprocessing.cpu_count()) as pool:
        for result in pool.imap_unordered(_process, tasks):
            path = result["path"]
            if "error" in result:
                error = result["error"].splitlines()[0]
                error = ": ".join(error.split(": ")[1:])
                print(f"{str(path).ljust(width)}: {error}")
            elif "size" in result:
                size = result["size"] / 1024 / 1024 / 1024 / 1024
                print(f"{str(path).ljust(width)}: {size:6.2f} TB")


def _process(task: dict) -> dict:
    query = _read(task["path"])

    path = task["path"].with_suffix(".csv")
    if not path.exists():
        result = _extract(query["content"], task["dry_run"])
        if "data" not in result:
            return {**task, **result}
        result["data"].to_csv(path, index=False)

    result = _load(path, query["metadata"], task["dry_run"])
    return {**task, **result}


def _extract(query: str, dry_run: bool) -> dict:
    credentials, _ = google.auth.default()
    client = bigquery.Client(
        credentials=credentials,
        project=PROJECT_ID,
    )
    config = bigquery.QueryJobConfig(
        query_parameters=QUERY_PARAMETERS,
        use_query_cache=not dry_run,
        dry_run=dry_run,
    )
    try:
        job = client.query(query, job_config=config)
        if dry_run:
            return {"size": job.total_bytes_processed}
        return {"data": job.to_dataframe()}
    except Exception as error:
        return {"error": str(error)}


def _load(
    path: Path,
    metadata: dict,
    dry_run: bool,
    min_column_count: int = 10,
    min_row_count: int = 1000,
) -> dict:
    if dry_run:
        return {}

    data = pd.read_csv(path, dtype=str)

    credentials, _ = google.auth.default()
    service = build("sheets", "v4", credentials=credentials)
    spreadsheet = service.spreadsheets().get(spreadsheetId=SPREADSHEET_ID).execute()

    sheet_name = str(path.with_suffix(""))
    sheet_id = next(
        (
            sheet["properties"]["sheetId"]
            for sheet in spreadsheet["sheets"]
            if sheet["properties"]["title"] == sheet_name
        ),
        None,
    )
    if not sheet_id:
        request = {
            "addSheet": {
                "properties": {
                    "title": sheet_name,
                    "gridProperties": {
                        "columnCount": max(len(data.columns), min_column_count),
                        "rowCount": max(len(metadata) + 1 + len(data), min_row_count),
                    },
                }
            }
        }
        response = (
            service.spreadsheets()
            .batchUpdate(
                spreadsheetId=SPREADSHEET_ID,
                body={"requests": [request]},
            )
            .execute()
        )
        sheet_id = response["replies"][0]["addSheet"]["properties"]["sheetId"]

    return {}


def _read(path: Path) -> dict:
    lines = []
    metadata = {}
    for line in path.read_text().splitlines():
        match = re.search(r"^-- (.+): (.+)$", line)
        if match:
            name, value = match.groups()
            metadata[name] = value
        match = re.search(r"^-- INCLUDE .*/([^/]+)\.sql$", line)
        if match:
            (name,) = match.groups()
            lines.extend(Path(f"{name}.sql").read_text().splitlines())
        else:
            lines.append(line)
    return {
        "content": "\n".join(lines),
        "metadata": metadata,
    }


if __name__ == "__main__":
    main()
