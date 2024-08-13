import pandas as pd

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

# Path to the text file containing the regex patterns
# Download: https://github.com/easylist/easylist/blob/master/easylist/easylist_adservers.txt
file_path = 'easylist_adservers.txt'
# Path to the output CSV file
csv_file_path = 'easylist_adservers.csv'

# Extract domains
domains = extract_domains_from_file(file_path)

# Save domains to CSV
save_domains_to_csv(domains, csv_file_path)

print(f"Domains have been saved to {csv_file_path}")
