#standardSQL

# Linking - fragment URLs (together with SPAs to navigate content)

SELECT
    url,
    JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$.seo-anchor-elements.navigateHash") as navigateHash

FROM
    `httparchive.pages.2019_07_01_desktop`
/* group by for counting SUM */
LIMIT 10
