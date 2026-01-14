import re
import os
from googleapiclient.discovery import build
import google.auth

# Configuration
SPREADSHEET_ID = '1Svyw40Th7VbigX6lpR1lb1WXwTUVKZWrK7O2YELrml4'
PUBCHART_ID = '2PACX-1vRC5wrzy5NEsWNHn9w38RLsMURRScnP4jgjO1mDiVhsfFCY55tujlTUZhUaEWzmPtJza0QA7w8S4uK5'
SQL_DIR = '../2025/privacy'  # Relative to this script's location

SCOPES = ['https://www.googleapis.com/auth/spreadsheets']


def get_sql_to_sheet_map(sql_dir):
    mapping = {}
    if not os.path.exists(sql_dir):
        print(f"Directory not found: {sql_dir}")
        return mapping
    for filename in os.listdir(sql_dir):
        if filename.endswith(".sql"):
            # Generate sheet name from filename using the regex:
            # re.sub(r'(\.sql|[^a-zA-Z0-9]+)', ' ', filename).strip().title()
            sheet_name = re.sub(r'(\.sql|[^a-zA-Z0-9]+)', ' ', filename).strip().title()
            mapping[sheet_name] = filename
    return mapping


def generate_figure_markup(spreadsheet_id, sql_dir):
    try:
        credentials, project = google.auth.default(scopes=SCOPES)
        sheets_service = build('sheets', 'v4', cache_discovery=False, credentials=credentials)
    except Exception as e:
        print(f"Authentication failed: {e}")
        print("Please ensure you have application default credentials set up.")
        return

    sql_map = get_sql_to_sheet_map(sql_dir)
    response = sheets_service.spreadsheets().get(spreadsheetId=spreadsheet_id, includeGridData=False).execute()
    sheets = response.get('sheets', [])

    for sheet in sheets:
        sheet_name = sheet['properties']['title']
        sheet_id = sheet['properties']['sheetId']
        charts = sheet.get('charts', [])
       
        sql_file = sql_map.get(sheet_name)
        if not sql_file:
            # Try to match case-insensitively or show warning
            sql_file = "TODO.sql"

        for chart in charts:
            title = chart['spec'].get('title', 'Untitled Chart')
            chart_id = chart['chartId']

            # Slugify for image name
            image_name = re.sub(r'[^a-z0-9]+', '-', title.lower()).strip('-') + ".png"

            # Construct markup
            markup = f"""{{{{ figure_markup(
  image="{image_name}",
  caption="{title}",
  description="",
  chart_url="https://docs.google.com/spreadsheets/d/e/{PUBCHART_ID}/pubchart?oid={chart_id}&format=interactive",
  sheets_gid="{sheet_id}",
  sql_file="{sql_file}"
  )
}}}}"""
            print(markup)
            print()


if __name__ == "__main__":
    # Resolve relative SQL_DIR based on script location
    script_dir = os.path.dirname(os.path.abspath(__file__))
    absolute_sql_dir = os.path.normpath(os.path.join(script_dir, SQL_DIR))

    print(f"Processing Spreadsheet: {SPREADSHEET_ID}")
    print(f"SQL Directory: {absolute_sql_dir}\n")

    generate_figure_markup(SPREADSHEET_ID, absolute_sql_dir)
