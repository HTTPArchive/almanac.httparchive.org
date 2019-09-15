#standardSQL

# linking - extract <a href> count per page (internal + external + hash)

SELECT
    APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-anchor-elements'].internal") AS INT64), 1000)[OFFSET(500)] AS median_internal_count,
    APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-anchor-elements'].external") AS INT64), 1000)[OFFSET(500)] AS median_external_count,
    APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-anchor-elements'].hash") AS INT64), 1000)[OFFSET(500)] AS median_hash_count,
    APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-anchor-elements'].external") AS INT64), 1000)[OFFSET(500)] / APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-anchor-elements'].internal") AS INT64), 1000)[OFFSET(500)] AS median_ratio_external_internal_count,
    ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-anchor-elements'].hash") AS INT64) > 0) * 100 / SUM(COUNT(0)) OVER (), 2)  AS hash_occurence_percentage
FROM
    `httparchive.pages.2019_07_01_*`
