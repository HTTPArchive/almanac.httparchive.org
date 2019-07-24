#standardSQL

SELECT
    COUNT(`httparchive.pages.2019_07_01_desktop`.url) AS `total`,
    COUNT(DISTINCT `httparchive.pages.2019_07_01_desktop`.url) AS `distinct_total`,
    CAST(JSON_EXTRACT(`httparchive.requests.2019_07_01_desktop`.payload, '$.response.status') as NUMERIC)
FROM
    `httparchive.pages.2019_07_01_desktop`
LEFT JOIN
    `httparchive.requests.2019_07_01_desktop`
    ON `httparchive.pages.2019_07_01_desktop`.url = `httparchive.requests.2019_07_01_desktop`.url
GROUP BY
    CAST(JSON_EXTRACT(`httparchive.requests.2019_07_01_desktop`.payload, '$.response.status') as NUMERIC)
