#standardSQL
# how many lson-ld scripts on a page
# see raw_json_ld_scripts.txt for notes and test scripts
# not sure if this will be needed yet
# maybe do as percentiles instead?
SELECT 
ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, '(?i)<script[^>]*type=[\'"]?application\\/ld\\+json[\'"]?[^>]*>(.*?)<\\/script>')) AS jsonld_scripts_count,
COUNT(0) AS number_of_pages
FROM `httparchive.sample_data.response_bodies_desktop_10k` 
WHERE page = url
GROUP BY jsonld_scripts_count
ORDER BY jsonld_scripts_count DESC;
