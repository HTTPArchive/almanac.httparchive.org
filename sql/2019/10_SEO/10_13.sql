#standardSQL

# custom mobile site (e.g. is mobile diffent response compared to desktop?)
#

#standardSQL

SELECT
    COUNT(`httparchive.pages.2019_07_01_desktop`.url) AS `total`,
    COUNT(DISTINCT `httparchive.pages.2019_07_01_desktop`.url) AS `distinct_total`
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
