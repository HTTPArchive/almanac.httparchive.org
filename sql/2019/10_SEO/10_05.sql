#standardSQL

#ld+json, microformatting, schema.org + what @type

SELECT
    url,
    flattened_105
FROM
    `httparchive.pages.2019_07_01_desktop`
CROSS JOIN
    UNNEST(CAST(JSON_EXTRACT_SCALAR(REPLACE(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '\\"','"'), "$['10.5']") as ARRAY)) as flattened_105
/* group by for counting SUM */
LIMIT 10
