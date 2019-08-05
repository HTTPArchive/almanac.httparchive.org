#standardSQL

# links or buttons only containing an icon

SELECT
    COUNT(url) AS total,
    ROUND(COUNTIF(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['12.11']") = '1') * 100 / COUNT(0), 2) AS pct_module
FROM
    `httparchive.pages.2019_07_01_mobile`
