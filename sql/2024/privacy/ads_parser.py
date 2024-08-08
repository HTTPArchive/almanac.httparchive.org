"""
Description: This script is used to parse the sellers.json file from a given URL
and extract the required information.
The extracted information is then written to a file named sellers.json in the current directory.
e.g. Google sellers.json url = https://storage.googleapis.com/adx-rtb-dictionaries/sellers.json
"""

import json
import requests  # pylint: disable=import-error

SELLER_TYPES = ["publisher", "intermediary", "both"]


def is_present(response, paths):
    """
    Check if any of the given paths are present in the response URL.

    Args:
        response (object): The response object.
        paths (list): A list of paths to check.

    Returns:
        bool: True if any of the paths are present in the response URL, False otherwise.
    """
    return any(path in response.url for path in paths)


def parse_sellers_json(
    url="https://storage.googleapis.com/adx-rtb-dictionaries/sellers.json",
):
    """
    Parse the sellers.json file from a given URL.

    Args:
        url (str): The URL of the sellers.json file.

    Returns:
        dict: A dictionary containing the parsed information.
    """
    result = {}

    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        content = response.json()
    except (requests.exceptions.RequestException, json.JSONDecodeError):
        content = None

    result = {
        "present": is_present(response, ["/sellers.json"]),
        "redirected": response.history != [],
        "status": response.status_code,
    }

    if result["present"] and content:
        result.update(
            {
                "seller_count": 0,
                "seller_types": {
                    "publisher": {
                        "domains": set(),
                        "seller_count": 0,
                    },
                    "intermediary": {
                        "domains": set(),
                        "seller_count": 0,
                    },
                    "both": {
                        "domains": set(),
                        "seller_count": 0,
                    },
                },
                "passthrough_count": 0,
                "confidential_count": 0,
            }
        )

        result["seller_count"] = len(content.get("sellers", []))

        for seller in content.get("sellers", []):
            stype = seller.get("seller_type", "").strip().lower()
            if stype not in SELLER_TYPES or not seller.get("seller_id"):
                continue

            if seller.get("is_passthrough"):
                result["passthrough_count"] += 1

            if seller.get("is_confidential"):
                result["confidential_count"] += 1

            if seller.get("domain"):
                domain = seller["domain"].strip().lower()
                result["seller_types"][stype]["domains"].add(domain)
                result["seller_types"][stype]["seller_count"] += 1

        for stype in result["seller_types"].values():
            stype["domain_count"] = len(stype["domains"])
            stype["domains"] = list(stype["domains"])

    return result


if __name__ == "__main__":
    url = input("Enter the sellers.json URL: ").strip()
    parsed_data = parse_sellers_json(url)

    with open("sellers.json", "w", encoding="utf-8") as f:
        f.write(json.dumps(parsed_data, indent=4))
