# standardSQL
# usage of synchronous XMLHttpRequest using blink features from usage counters
SELECT
    client,
    pct_urls
FROM
    `httparchive.blink_features.usage` WHERE
    feature = 'XMLHttpRequestSynchronous' and yyyymmdd = '20210701'
GROUP BY
    pct_urls,
    client
ORDER BY
    pct_urls,
    client
