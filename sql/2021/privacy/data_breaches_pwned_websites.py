"""
Analyze data breaches reported by Pwned websites (https://haveibeenpwned.com/PwnedWebsites).
"""

from collections import defaultdict
import csv
import requests

# Retrieve breaches JSON from API
breaches_api_request = requests.get("https://haveibeenpwned.com/api/v2/breaches")
breaches_data = breaches_api_request.json()

total_number_of_affected_accounts_per_data_class_and_date = defaultdict(lambda: defaultdict(int))
total_number_of_affected_accounts_for_sensitive_breaches = defaultdict(int)

for breach in breaches_data:
    number_of_affected_accounts = breach["PwnCount"]

    breach_date = breach["BreachDate"]
    breach_data_classes = breach["DataClasses"]  # Type of data breached, e.g., email addresses
    for data_class in breach_data_classes:
        total_number_of_affected_accounts_per_data_class_and_date[data_class][breach_date] += number_of_affected_accounts

    # 'Sensitive' breaches, where the existence of an account is sensitive in and of itself.
    # https://haveibeenpwned.com/FAQs#SensitiveBreach
    is_breach_sensitive = breach["IsSensitive"]
    if is_breach_sensitive:
        total_number_of_affected_accounts_for_sensitive_breaches[breach_date] += number_of_affected_accounts

with open("data_breaches_pwned_websites_per_class_and_date.csv", "w") as of1:
    csvw_cd = csv.writer(of1)
    with open("data_breaches_pwned_websites_per_class.csv", "w") as of2:
        csvw_c = csv.writer(of2)

        for data_class in total_number_of_affected_accounts_per_data_class_and_date:
            for breach_date in total_number_of_affected_accounts_per_data_class_and_date[data_class]:
                csvw_cd.writerow([
                    data_class,
                    breach_date,
                    total_number_of_affected_accounts_per_data_class_and_date[data_class][breach_date]
                ])
            csvw_c.writerow([
                data_class,
                sum(total_number_of_affected_accounts_per_data_class_and_date[data_class].values())
            ])
with open("data_breaches_pwned_websites_sensitive_breaches_per_date.csv", "w") as of3:
    csvw_sbd = csv.writer(of3)
    with open("data_breaches_pwned_websites_sensitive_breaches.csv", "w") as of4:
        csvw_sb = csv.writer(of4)

        for breach_date in total_number_of_affected_accounts_for_sensitive_breaches:
            csvw_sbd.writerow([
                breach_date,
                total_number_of_affected_accounts_for_sensitive_breaches[breach_date]
            ])
        csvw_sb.writerow([
            sum(total_number_of_affected_accounts_for_sensitive_breaches.values())
        ])
