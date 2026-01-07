#standardSQL
# The distribution of CDN adoption on websites by client.

SELECT
    client,
    total,
    IF(cdn = '', 'No CDN', cdn) AS cdn,
    COUNT(*) AS freq,
    ROUND(100 * COUNT(*) / total, 2) AS pct
FROM (
        SELECT
            client,
            COUNT(*) AS total,
            ARRAY_CONCAT_AGG(
                SPLIT(JSON_EXTRACT_SCALAR(summary, '$.cdn'), ', ')
            ) AS cdn_list
        FROM
            `httparchive.crawl.pages`
        WHERE
            date = '2025-06-01' AND
            is_root_page = TRUE
        GROUP BY
            client
),
UNNEST(cdn_list) AS cdn
GROUP BY
    client,
    cdn,
    total
ORDER BY
    pct DESC,
    client ASC,
    cdn ASC;
