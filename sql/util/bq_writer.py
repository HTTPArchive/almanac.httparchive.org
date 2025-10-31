"""
This script writes a pandas DataFrame to BigQuery.
"""

from google.cloud import bigquery  # pylint: disable=import-error


def write_to_bq(df, table_id, schema, write_disposition="WRITE_APPEND"):
    """
    Writes a DataFrame to BigQuery.

    Args:
        df (pandas.DataFrame): The data to load into BigQuery.
        table_id (str): The destination table in BigQuery (e.g., 'project.dataset.table').
        schema (list): The schema for the BigQuery table.
        write_disposition (str): Write mode, default is WRITE_APPEND.
    """
    client = bigquery.Client()

    job_config = bigquery.LoadJobConfig(
        write_disposition=write_disposition,
        schema=schema,
    )

    # Load data into BigQuery
    job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
    job.result()  # Waits for the job to complete
