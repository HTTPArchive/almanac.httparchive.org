"""
Analyze data breaches reported by Pwned websites (https://haveibeenpwned.com/PwnedWebsites).
"""

from collections import defaultdict
import csv
import requests

# Retrieve breaches JSON from API
breaches_api_request = requests.get("https://haveibeenpwned.com/api/v2/breaches")
breaches_data = breaches_api_request.json()

total_number_of_affected_accounts_per_date = defaultdict(lambda: defaultdict(int))

for breach in breaches_data:

    for data_class in breach[
        "DataClasses"
    ]:  # Type of data breached, e.g., email addresses
        total_number_of_affected_accounts_per_date[breach["BreachDate"]][
            data_class
        ] += breach["PwnCount"]

    # 'Sensitive' breaches, where the existence of an account is sensitive in and of itself.
    # https://haveibeenpwned.com/FAQs#SensitiveBreach
    total_number_of_affected_accounts_per_date[breach["BreachDate"]][
        breach["IsSensitive"]
    ] += breach["PwnCount"]

# https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/edit#gid=1158689200
with open(
    "sql/2021/privacy/data_breaches_pwned_websites_per_date_and_class.tsv", "w"
) as of1:
    # https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/edit#gid=1435927653
    with open(
        "sql/2021/privacy/data_breaches_pwned_websites_per_date_and_breach_sensitivity.tsv",
        "w",
    ) as of2:

        csvw_dc = csv.writer(of1, delimiter="\t")
        csvw_dc.writerow(
            [
                "breach_date",
                "data_class",
                "total_number_of_affected_accounts",
            ]
        )

        csvw_ds = csv.writer(of2, delimiter="\t")
        csvw_ds.writerow(
            [
                "breach_date",
                "breach_is_sensitive",
                "total_number_of_affected_accounts",
            ]
        )

        for breach_date in total_number_of_affected_accounts_per_date:

            for item in total_number_of_affected_accounts_per_date[breach_date]:

                if item is True or item is False:
                    csvw_ds.writerow(
                        [
                            breach_date,
                            item,
                            total_number_of_affected_accounts_per_date[breach_date][
                                item
                            ],
                        ]
                    )
                else:
                    csvw_dc.writerow(
                        [
                            breach_date,
                            item,
                            total_number_of_affected_accounts_per_date[breach_date][
                                item
                            ],
                        ]
                    )
