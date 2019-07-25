#standardSQL

# Linking - extract <a href> count per page (internal + external)


SELECT
    url,
    JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$.seo-anchor-elements.internal") as internal,
    JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$.seo-anchor-elements.external") as external,
    JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$.seo-anchor-elements.hash") as hash
FROM
    `httparchive.pages.2019_07_01_desktop`
/* group by for counting SUM */
LIMIT 10
