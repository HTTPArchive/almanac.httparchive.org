#standardSQL

# custom mobile site (e.g. is mobile diffent response compared to desktop?)
# check if we get a redirect, and if so to where

#standardSQL

SELECT
    COUNT(`httparchive.pages.2019_07_01_desktop`.url) AS `total`,
    COUNT(DISTINCT `httparchive.pages.2019_07_01_desktop`.url) AS `distinct_total`,
    SUM(IF(`httparchive.requests.2019_07_01_desktop`.url != `httparchive.requests.2019_07_01_mobile`.url, 1, 0)) AS `different`
FROM
    `httparchive.pages.2019_07_01_desktop`
LEFT JOIN
    `httparchive.requests.2019_07_01_desktop`
        ON `httparchive.pages.2019_07_01_desktop`.url = `httparchive.requests.2019_07_01_desktop`.url
LEFT JOIN
    `httparchive.requests.2019_07_01_mobile`
        ON `httparchive.pages.2019_07_01_desktop`.url = `httparchive.requests.2019_07_01_mobile`.url

GROUP BY
    `httparchive.requests.2019_07_01_desktop`.url
