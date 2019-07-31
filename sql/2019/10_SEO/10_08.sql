#standardSQL

# dataset: `httparchive.requests.2019_07_01_desktop`
# sample: `httparchive.almanac.requests_desktop_1k`

SELECT
    COUNT(`httparchive.pages.2019_07_01_desktop`.url) AS `total`,
    COUNT(DISTINCT `httparchive.pages.2019_07_01_desktop`.url) AS `distinct_total`,
    SAFE_CAST(JSON_EXTRACT(`httparchive.requests.2019_07_01_desktop`.payload, '$.response.status') as NUMERIC) as `status`
FROM
    `httparchive.pages.2019_07_01_desktop`
LEFT JOIN
    `httparchive.requests.2019_07_01_desktop`
    ON `httparchive.pages.2019_07_01_desktop`.url = `httparchive.requests.2019_07_01_desktop`.url
GROUP BY
    SAFE_CAST(JSON_EXTRACT(`httparchive.requests.2019_07_01_desktop`.payload, '$.response.status') as NUMERIC)

# sample:
SELECT
    COUNT(`httparchive.almanac.pages_desktop_1k`.url) AS `total`,
    COUNT(DISTINCT `httparchive.almanac.pages_desktop_1k`.url) AS `distinct_total`,
    CAST(JSON_EXTRACT(`httparchive.almanac.requests_desktop_1k`.payload, '$.response.status') as NUMERIC)
FROM
    `httparchive.almanac.pages_desktop_1k`
LEFT JOIN
    `httparchive.almanac.requests_desktop_1k`
    ON `httparchive.almanac.pages_desktop_1k`.url = `httparchive.almanac.requests_desktop_1k`.url
GROUP BY
    CAST(JSON_EXTRACT(`httparchive.almanac.requests_desktop_1k`.payload, '$.response.status') as NUMERIC)
