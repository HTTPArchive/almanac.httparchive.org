#standardSQL

# Percentage of websites using HTTP/2+ vs HTTP/1.1; this is based on the home
# page.

SELECT
    client,
    protocol,
    CASE
        WHEN
            LOWER(protocol) LIKE 'h3%' OR LOWER(protocol) = 'quic' THEN 'HTTP/3'
        WHEN protocol IS NULL THEN 'Unknown'
        ELSE UPPER(protocol)
    END AS http_version,
    COUNT(*) AS num_reqs,
    SUM(COUNT(*)) OVER (PARTITION BY client) AS total_reqs,
    COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY client) AS pct_reqs,
    COUNTIF(firsthtml) AS num_pages,
    SUM(COUNTIF(firsthtml)) OVER (PARTITION BY client) AS total_pages,
    COUNTIF(
        firsthtml
    ) / SUM(COUNTIF(firsthtml)) OVER (PARTITION BY client) AS pct_pages
FROM
    `httparchive.almanac.requests` TABLESAMPLE SYSTEM (0.001 PERCENT)
WHERE
    date = '2022-06-01'
GROUP BY
    client,
    protocol
ORDER BY
    client ASC,
    num_reqs DESC
