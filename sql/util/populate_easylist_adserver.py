import requests
import pandas as pd
from google.cloud import bigquery
import os

def extract_domains_from_file(file_path):
    domains = []
    try:
        with open(file_path, 'r') as file:
            for line in file:
                # Remove the '||' prefix and '^' suffix
                domain = line.strip().lstrip('||').rstrip('^')
                if domain:  # Ensure the line is not empty
                    domains.append(domain)
    except FileNotFoundError:
        print(f"Error: The file {file_path} does not exist.")
    except Exception as e:
        print(f"An error occurred: {e}")
    return domains

def save_domains_to_csv(domains, csv_file_path):
    try:
        # Create a DataFrame from the list of domains
        df = pd.DataFrame(domains, columns=['Domain'])
        # Save the DataFrame to a CSV file
        df.to_csv(csv_file_path, index=False)
    except Exception as e:
        print(f"An error occurred while writing to CSV: {e}")

def upload_csv_to_bigquery(csv_file_path):
    # this needs the GOOGLE_APPLICATION_CREDENTIALS env variable to be set
    client = bigquery.Client()

    # Configure the job
    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        skip_leading_rows=1,  # Adjust if your CSV doesn't have a header row
        autodetect=True,  # Automatically infer schema
    )

    # Load data from the CSV file
    with open(csv_file_path, "rb") as source_file:
        load_job = client.load_table_from_file(source_file, "httparchive.almanac.easylist_adservers", job_config=job_config)

    # Wait for the job to complete
    load_job.result()

# URL to the text file containing the regex patterns
url = 'https://raw.githubusercontent.com/easylist/easylist/master/easylist/easylist_adservers.txt'
file_path = 'easylist_adservers.txt'
# Path to the output CSV file
csv_file_path = 'easylist_adservers.csv'

# Download the file and save it locally
response = requests.get(url)
with open(file_path, 'wb') as file:
    file.write(response.content)

# Extract domains
domains = extract_domains_from_file(file_path)

# Save domains to CSV
save_domains_to_csv(domains, csv_file_path)

# upload domains to BQ
upload_csv_to_bigquery(csv_file_path)

print(f"Domains have been saved to {csv_file_path}")
