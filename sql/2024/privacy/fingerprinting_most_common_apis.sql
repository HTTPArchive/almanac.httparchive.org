create temp function getFingerprintingTypes(input string)
returns array<string>
language js as """return Object.keys(JSON.parse(input).privacy?.fingerprinting?.counts || {})""";

with pages as (
  select client, page, fingerprinting_type from `httparchive.all.pages`, -- TABLESAMPLE SYSTEM (0.001 PERCENT)
   unnest(getFingerprintingTypes(custom_metrics)) as fingerprinting_type WHERE date = "2024-06-01"
)
select client, fingerprinting_type, count(distinct page) as page_count from pages group by client, fingerprinting_type order by page_count desc