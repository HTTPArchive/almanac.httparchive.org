#!/usr/bin/env python

import argparse
import multiprocessing
import re
from pathlib import Path

import google.auth  # pylint: disable=import-error
from google.cloud import bigquery  # pylint: disable=import-error

PROJECT = "httparchive"
PARAMETERS = [
    bigquery.ScalarQueryParameter(
        "date",
        "DATE",
        "2025-07-01",
    ),
    bigquery.ArrayQueryParameter(
        "dates",
        "DATE",
        ["2022-07-01", "2023-07-01", "2024-07-01", "2025-07-01"],
    ),
    bigquery.ScalarQueryParameter(
        "precision",
        "INT64",
        4,
    ),
]


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

    result = _load(path)
    return {**task, **result}


def _extract(query: str, dry_run: bool) -> dict:
    credentials, _ = google.auth.default(
        scopes=["https://www.googleapis.com/auth/cloud-platform"],
    )
    client = bigquery.Client(
        credentials=credentials,
        project=PROJECT,
    )
    config = bigquery.QueryJobConfig(
        query_parameters=PARAMETERS,
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


def _load(path: Path) -> dict:
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
