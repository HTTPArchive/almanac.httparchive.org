#!/usr/bin/env python

import argparse
import multiprocessing
import re
from pathlib import Path
from typing import Optional

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
            task = result["task"]
            path = task["path"]
            if result["errors"]:
                messages = result["errors"]
            elif result["successes"]:
                messages = result["successes"]
            else:
                messages = []
            if not messages:
                print(f"{str(path).ljust(width)}: skipped")
            elif len(messages) == 1:
                print(f"{str(path).ljust(width)}: {messages[0]}")
            else:
                print(f"{path}:")
                for message in messages:
                    print(f"  - {message}")


def _process(task: dict) -> dict:
    result = {"task": task, "errors": [], "successes": []}

    query = _query_read(task["path"])

    # If there is a CSV file, just use it without questions.
    path = task["path"].with_suffix(".csv")
    if not path.exists():
        try:
            if task["dry_run"]:
                size = _bigquery_estimate(query["content"])
                result["successes"].append(f"estimated {size:5.2f} TB")
                return result
            else:
                data = _bigquery_read(query["content"])
                data.to_csv(path, index=False)
                result["successes"].append(f"wrote {path}")
        except Exception as error:
            result["errors"].append(str(error))
            return result

    data = pd.read_csv(path, dtype=str)

    if task["dry_run"]:
        return result

    try:
        sheet = _sheets_prepare(query["metadata"])
        # If A1 is populated, skip writing.
        if not _sheets_exists(sheet):
            _sheets_write(data, query["metadata"], sheet)
            result["successes"].append(f"updated “{sheet}”")
    except Exception as error:
        result["errors"].append(str(error))
        return result

    return result


def _bigquery_estimate(query: str) -> float:
    credentials, _ = google.auth.default()
    client = bigquery.Client(credentials=credentials, project=PROJECT_ID)
    config = bigquery.QueryJobConfig(
        query_parameters=QUERY_PARAMETERS,
        use_query_cache=False,
        dry_run=True,
    )
    job = client.query(query, job_config=config)
    return job.total_bytes_processed / 1024 / 1024 / 1024 / 1024


def _bigquery_read(query: str) -> pd.DataFrame:
    credentials, _ = google.auth.default()
    client = bigquery.Client(
        credentials=credentials,
        project=PROJECT_ID,
    )
    config = bigquery.QueryJobConfig(
        query_parameters=QUERY_PARAMETERS,
        use_query_cache=True,
    )
    job = client.query(query, job_config=config)
    return job.to_dataframe()


def _sheets_exists(name: str) -> bool:
    credentials, _ = google.auth.default()
    service = build("sheets", "v4", credentials=credentials)
    result = (
        service.spreadsheets()
        .values()
        .get(spreadsheetId=SPREADSHEET_ID, range=f"'{name}'!A1")
        .execute()
    )
    return "values" in result and result["values"][0][0]


def _sheets_prepare(metadata: dict) -> str:
    credentials, _ = google.auth.default()
    service = build("sheets", "v4", credentials=credentials)
    name = metadata["Section"] + ": " + metadata["Question"]
    _ = _sheets_find(service, name) or _sheets_create(service, name)
    return name


def _sheets_write(data: pd.DataFrame, metadata: dict, name: str) -> dict:
    credentials, _ = google.auth.default()
    service = build("sheets", "v4", credentials=credentials)
    values = [
        ["Section", metadata["Section"]],
        ["Question", metadata["Question"]],
        ["Normalization", metadata["Normalization"]],
        [],
        data.columns.tolist(),
        *data.values.tolist(),
    ]
    service.spreadsheets().values().update(
        spreadsheetId=SPREADSHEET_ID,
        range=f"'{name}'!A1",
        valueInputOption="RAW",
        body={"values": values},
    ).execute()


def _sheets_create(
    service: "Service",
    name: str,
    column_count: int = 20,
    row_count: int = 1000,
) -> str:
    request = {
        "addSheet": {
            "properties": {
                "title": name,
                "gridProperties": {
                    "columnCount": column_count,
                    "rowCount": row_count,
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
    return response["replies"][0]["addSheet"]["properties"]["sheetId"]


def _sheets_find(service: "Service", name: str) -> Optional[str]:
    spreadsheet = service.spreadsheets().get(spreadsheetId=SPREADSHEET_ID).execute()
    return next(
        (
            sheet["properties"]["sheetId"]
            for sheet in spreadsheet["sheets"]
            if sheet["properties"]["title"] == name
        ),
        None,
    )


def _query_read(path: Path) -> dict:
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
