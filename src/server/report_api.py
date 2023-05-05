# Because of the "true" value we can't use a Python object
# and have to use actual JSON
report_to = """
{
    "group": "default",
    "max_age": 31536000,
    "endpoints": [
        {
            "url": "https://httparchive.report-uri.com/a/d/g"
        }
    ],
    "include_subdomains": true
}
""".replace(
    "\n", ""
).replace(
    " ", ""
)
